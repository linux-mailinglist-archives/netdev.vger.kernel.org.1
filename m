Return-Path: <netdev+bounces-205547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236BAFF2D6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6CB3A62DF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCB238173;
	Wed,  9 Jul 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thB86Zck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74741FF5F9
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092362; cv=none; b=UuzNeOSUvlD5KnhWyfy9FOWkWMga11Efyn37Py9bSR2r5hPq7XMtAArZcnPxvwpEhkxo3bnucxDMwwe261jNtOackttaSS/XTH5pXKUgQbl++FY5bF3hX35uzkAg55e55wfOQ2KVSm20UKITM+oIVHvNEJVDox49dt07rHXKsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092362; c=relaxed/simple;
	bh=to8lwENjrk9Vo8aiV82QISxzcUgPD4RE1UdK590RVOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMW7CIA6o2RdcXJGTRruGjZpxeckE/cLv4ispuuLii2kNv8oaDa4Tyi57vr4GnGc3I220wa+XGyy5XM4Umb8inME0BxYH2ZnDmyyLz8dh0SGbv/DUc3sNvgpS2fhj/NkiKu7ebJFS3m99lRWuDWsx7ZHMf8w4qjRHLi7GI3Ot0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thB86Zck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A03C4CEEF;
	Wed,  9 Jul 2025 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092362;
	bh=to8lwENjrk9Vo8aiV82QISxzcUgPD4RE1UdK590RVOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thB86ZckyzpAUmwe9ePdA4/Vj8+1hUaWAVMm/h4yxvRg3GXDzD0VvSodxbss+TivF
	 P1gpOQmfZuE1BBh9FE3p6hrOlE99NuZjQUxlDKfyUO3acJP4Y/RBQs3lol6OPQjUSB
	 HdXWHKi1jDctK9rta+T7cE2yPuPduWfqzEyycxcsKo1X11ahUTnwppdRgQ7p9tubzV
	 mfrRQS5HQtkeuKSukOjMFWIlVg/79A1Wk/Owr7+ec6IUWcJ3rglw/D/K1xwQBUwZJd
	 cYDKNplzvt5NOIDIvGTnJvxrjWdW/pmHeUrzwq3WKHfsnQg42wcl0EvcEtpruqccS8
	 amO8xsVObn4Rw==
Date: Wed, 9 Jul 2025 13:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <20250709131920.7ce33c83@kernel.org>
In-Reply-To: <20250709180622.757423-1-xmei5@asu.edu>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
	<20250709180622.757423-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 11:06:22 -0700 Xiang Mei wrote:
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reported-by is for cases where the bug is reported by someone else than
the author. And please do *not* send the patches as a reply in a thread.
I already asked you not to do it once.
-- 
pw-bot: cr

