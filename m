Return-Path: <netdev+bounces-240255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7610C71EAE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B6495241CA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCD2F745D;
	Thu, 20 Nov 2025 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOMt3TVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86A27C866;
	Thu, 20 Nov 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763607815; cv=none; b=WcPdLJ72VR0V5uuHkR7HZQHDpuYLxImg836KDcrbN92YHiIeeqkVcD4PVls/HA6F0F02QIDOOcxpzGyUN3KmeN1X9qcoqBU0YkPirccjzV2BDBbS593DQiLCCk5lYsX4Tefa7982PF/uzKXZMTyihjw9LX/SsthajvMWoYhsC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763607815; c=relaxed/simple;
	bh=145kPQNmVRQJEt/03YmgJ8Q632Dr5R0rB+j9qDUHOw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCh2/ZPUMEMToMSOY6bZQM66gIQNGft4GYfJA+wgGGL8LGVQI0P0U1JLNVhEUyxvBqL+TgTdjeSpEmEdVgCME92BFVZgtigkMXLEZWDIKkfwa0/P0o291+xeR7n83TPy49d+EXzzDJas5JPPmbDc1ApOFhPdtPcTrfgz2uzfZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOMt3TVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA7DC4CEF5;
	Thu, 20 Nov 2025 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763607814;
	bh=145kPQNmVRQJEt/03YmgJ8Q632Dr5R0rB+j9qDUHOw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOMt3TVgQUFxBd2+XsB9LYZQoCAd4Pwt8Cu2rv4zg7g9sojWR+ke0OKjMuB4NChMu
	 JiDTP25JvdxFKyvLHZXnHwn8yQj/Eyn4CWFPpJLBgEuG649ad8Hhuetg46IQ4PC6uV
	 uQBXcbz0rhkgTyboBktyg/nee9nH7/j+MGyOSjGfiZCFImk2UT1fsct8dzIQ6twyCD
	 YYaLuv/+0IfHJ8Jkh3UxB8hWm2LW/u/TU5PHUeaGXSfcsPPWDSX2bZrQwctsvG4YM0
	 c2bXgyAVJNgTRtU1/kjHSaarbI29zX+LlVfJPdwP4g7A2lagDXKJbGWZzKntOYRz2F
	 oPX3s6gSQ/BzA==
Date: Wed, 19 Nov 2025 19:03:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiefeng <jiefeng.z.zhang@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org,
 irusskikh@marvell.com
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX
 path
Message-ID: <20251119190333.398954bf@kernel.org>
In-Reply-To: <CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
	<20251118122430.65cc5738@kernel.org>
	<CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 16:38:13 +0800 Jiefeng wrote:
> And I have encountered this crash in production with an
> Aquantia(AQtion AQC113) 10G NIC[Antigua 10G]:

Ah you're actually seeing a crash! Thanks a lot for the additional info,
I thought this is something you found with static code analysis!
Please include the stack trace and more info in the commit message,
makes it easier for others encountering the crash to compare.
(Drop the timestamps from the crash lines, tho, it's not important)

> The atlantic hardware supports multi-descriptor packet reception
> (RSC). When a large packet arrives, the hardware splits it across
> multiple descriptors, where each descriptor can hold up to 2048 bytes
> (AQ_CFG_RX_FRAME_MAX).
> 
> There is a logic bug in the code. The code already counts fragments in
> the multi-descriptor loop
> (frag_cnt at aq_ring.c:559), but the check at aq_ring.c:568 only considers
> frag_cnt, not the additional fragment from the first buffer
> (if buff->len > hdr_len). The actual fragment addition happens later
> (aq_ring.c:634-667):
> - One fragment from the first buffer (if hdr_len < buff->len)
> - Plus frag_cnt fragments from subsequent descriptors
> 
> This can exceed MAX_SKB_FRAGS (17) in edge cases:
> - If frag_cnt = 17 (the check passes)
> - And the first buffer has a fragment (buff->len > hdr_len)
> - Then total = 1 + 17 = 18 > MAX_SKB_FRAGS

Got it, would it make more sense to fix the existing check?
(assume there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE)

Or fix adding the zeroth frag? (if frag_cnt == max do not extract the
zeroth frag). Extracting the zeroth frag is just to make SW GRO/skb
freeing slightly faster, it's not necessary for correctness.

> While the hardware MTU limit is 16334 bytes (B0/ATL2), which should
> only need ~8 fragments, there are edge cases like LRO aggregation
> or hardware anomalies that could produce more descriptors.
> 
> The panic occurred because skb_add_rx_frag() was called with an index
> >= MAX_SKB_FRAGS, causing an out-of-bounds write. The fix ensures  
> we check the total fragment count (first buffer fragment + frag_cnt)
> before calling skb_add_rx_frag().

