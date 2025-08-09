Return-Path: <netdev+bounces-212332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61BB1F50A
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD167AA19A
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC527FD7D;
	Sat,  9 Aug 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hhAy01ws"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCA190692;
	Sat,  9 Aug 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754751648; cv=none; b=rQ4/ZhIhwe+1b3woL/3wqrWgGQJBjAsVGJaC+AC11z2qh5RuoW3mtwcHqPq1vpwjIStYURC0/RwXTabJs9YrP6nIhLc/s1aZqsQqExUsl+qUkBoZXXw4X2t+y45CbfB/+VYJISuxzUtLzoV2FiYFlT6lI5RUN/tD910AlaSnd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754751648; c=relaxed/simple;
	bh=Dz2PkMibCWtk3xZiunjGwlziFF5FYxDuqokFTdbnGVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z5AiVgE5vptlZ6C1cgEYu4SUauJ+6TxRlhrAmbimIG4mUUfCuNNkvUFvUPbeZsMrLicCtpn3oqXqrmNcWngSq6gK4ViKLOkMMNZ1iRLBO6lEhlp8pHzx7PbWg8zTTBNjgd6/BoKkQKglCEMnWOjGJzSf6GGYwQbLZorISUWVCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hhAy01ws; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Dz2PkMibCWtk3xZiunjGwlziFF5FYxDuqokFTdbnGVo=;
	b=hhAy01wsq1KQYASxxPofg3wExsK/ho+NbCLry9ILB6CJxRbpyIb0MWkU9eq3Eu
	yZ1t+gyqwynFJmrp1DXR/ENUKP3FXA96JGqUKD1Qz3T2WX4Vp6QnnWRu6tUUy3Lf
	Ywu85AGHKAv0VDFGPnZ40qGJaj+ujUdVd++vnCha0/zgQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAHyIbPXpdoGuRVAQ--.42733S2;
	Sat, 09 Aug 2025 22:44:31 +0800 (CST)
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
Date: Sat,  9 Aug 2025 22:44:31 +0800
Message-Id: <20250809144431.1784097-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHyIbPXpdoGuRVAQ--.42733S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW8AF1fKF1xAw17Xry7Jrb_yoWfCwcEkr
	4j9FykA3yxZFyqka18Kr47JFy7CrWjk3W5CFWkXF9xX34xXrnxuF9Ygry7Z3WfGayS9Fy5
	CFs0q3sxG3W29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyEEUUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwqkCmiXWhlEMwAAso

On Sat, 2025-08-09 at 21:45 +0800, Willem wrote:

> This is a resubmit of the patch you yesterday [1]? While the
> discussion on the original patch was ongoing too.

> Net-next is also closed. See also see also
> Documentation/process/maintainer-netdev.rst for the process.

> I'll take a closer look later. Agreed in principle that it's
> preferable to replace timer with hrtimer than to add a CONFIG to
> select between them.

> [1] https://lore.kernel.org/netdev/20250808032623.11485-1-jackzxcui1989@163.com/


Dear Willem，

Yes, you're right. I noticed that the title of the patch I submitted yesterday was
incorrect; it should be "use" instead of "user." Additionally, the title was a bit
too long, so I resubmitted it.
As you mentioned, I took Eric's advice and removed the new config, directly
modifying the code instead. Since the title has changed, I didn't use the "PATCH v1"
format.


Thanks
Xin Zhao


