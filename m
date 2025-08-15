Return-Path: <netdev+bounces-213937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F8B27666
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF760568391
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FE292B58;
	Fri, 15 Aug 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LvoijHPZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604B27AC32;
	Fri, 15 Aug 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755226508; cv=none; b=PJZeV4NJ1L89TkE0ebauzkajjdFmHbsU7Kzg93igc/IiVWPeoEfz8TRoXqsGO/8U2+hoHieOsxfCvAtsI2bLAuPCVR0sVXpjGLQ+6kjMbgv+pf4toGPXysQu/UGCo1WYSgonVTT9o45w9UfYsgG57MveknQpxXcSYUMFuQh+KvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755226508; c=relaxed/simple;
	bh=KeJFi1pVXNK4Tlmsq/GV1v1fG/zwnxtUHIBtXHNy1QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=srdtQs4QkDbOi1SWqu9X75YffGp9Zhy4xQAIQg+79bbZF2cTE4uUDPj87M9kUmtOL/B5ZHTowbGncsqH8YyU4iNcTdBUKrJ0boPBIUNhHwhR1GhFDQdtgSkXwHh2v/p/dRmWOsO5nWzuGRPdRhlDJJ/K1lIFLevPtoF7aX5U/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LvoijHPZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=e/
	j1B9z3bQhmtlG6OiGtt3zOIKdDdDP0HF/AC2CMs64=; b=LvoijHPZzzbTl/MnnZ
	N7uMXprKdHStlcncaEbsggBe6PYRdmlcdKGiRbNWyf/Jf7zBa9oLMOYqO6NERDi4
	dfo1OVOBal8ESZr3ZjPChmfLT/enmqkbkV/fQ6EmCdxVHF9Od71jvsiR9hnvXqGq
	Re9mWwFBhsD4+3Z+7bFTnx/7I=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHffVtoZ5ovy88Bg--.29439S2;
	Fri, 15 Aug 2025 10:54:38 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: af_packet: Use hrtimer to do the retire operation
Date: Fri, 15 Aug 2025 10:54:37 +0800
Message-Id: <20250815025437.1053773-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHffVtoZ5ovy88Bg--.29439S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW8Ww1fJF15Xr17uF48WFg_yoW3GrgE9r
	yqvF48Ka1rJr4rWa17Kr43Jr9Y9w48Ga4UGa9Yy3sIvr1YgryjkFnxur15uF4DCwnrC3sx
	Cr4Ut34xtw1DWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb73vUUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiMBmqCmienv4+bgAAsP

On Fri, 2025-08-15 at 1:29 +0800, Willem wrote:

> > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > +	p1->tov_in_msecs = p1->retire_blk_tov;
> 
> Can probably drop this field as it's the same as retire_blk_tov.
> 
> Or convert to ktime_t next_timer, to be able to replace ktime_get()
> with ktime_add_ms when rearming when calling hrtimer_set_expires.

Dear Willem,

Thank you for your suggestion.
I will drop the tov_in_msecs field in PATCH v2.
Additionally, I think we cannot avoid using ktime_get, as the retire
timeout for each block is not fixed. When there are a lot of network packets,
a block can retire quickly, and if we do not re-fetch the time, the timeout
duration may be set incorrectly.

Thanks
Xin Zhao


