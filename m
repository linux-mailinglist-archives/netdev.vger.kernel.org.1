Return-Path: <netdev+bounces-188529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF7AAD334
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488071C03597
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1411684B0;
	Wed,  7 May 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGGuX6mc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E413B590
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584431; cv=none; b=reV7YxepgY2bIEnqlz4ErHLf6Zd1T5FAodAqdOV6K7agQABeBhHhHxam3h0T2zLhIjt9J5IoPJ3kxUjlIuckk6TWUMj3Gz9XQELDU6YvYEd36INu6A7kk6Xv9fXe6L1tpGBe/7fTren/LdZl2r2i6FHoXj5OLE8NTWlbNgtEzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584431; c=relaxed/simple;
	bh=+Bmy4xPQTVQQc662B36NyMPj1uJaevTBki/zHPMbAK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsEhHcQgNI3Ciu2QG34PSpbb/A5MFnpvVH9L/bMZge+O4+v8i/Et+9UjIKz6eApodR/FDCKmYlFHWYuSobCs3Ou0TwFOktoqDSPr3VHKHenyPVc7O3m4faWKuJWKyrtHO2Z5DZDmNRtdTYLwZys7888qtixvisSMLaiZtRNob6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGGuX6mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA58C4CEE4;
	Wed,  7 May 2025 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746584431;
	bh=+Bmy4xPQTVQQc662B36NyMPj1uJaevTBki/zHPMbAK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aGGuX6mcrwc8b0/XhxnckZrIY2kQen6CwfBGivOiryFWtL6fZZwpVfLCH1Vlu5SOL
	 VP3iyjPhvaux50XB9wf+cyrgvFB7O796FPgJpAnzt8i8cS7QRS9mGZ9W0QeZox4cnz
	 vy39W0CRSYOIxIA20Iv9lE3GqDt3A5/l18C58YEUYI+XN8nGiLNUM8Z/rXBG1GOq5G
	 1j0xR+EaHIZMbTIIwFj8/V8ivbvneZco+k1pu0BrVibwxzknykrNFGXSqT/+0GCLsL
	 zkM88RLJhHmA1EAuUmSS2yV6I1UC09t9H370Hjqc9/rrF98aAYvQIuJKR9liMrn2ek
	 f2crw8jz0ykeA==
Date: Tue, 6 May 2025 19:20:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
Message-ID: <20250506192030.7228fcc9@kernel.org>
In-Reply-To: <0decca5d2af88ccbe51b7e9c88a258bd8cc6c6e8.camel@codeconstruct.com.au>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
	<20250506180630.148c6ada@kernel.org>
	<84b6bdceff61d495661dcf3500fd4bf19cf4e7be.camel@codeconstruct.com.au>
	<20250506184124.57700932@kernel.org>
	<0decca5d2af88ccbe51b7e9c88a258bd8cc6c6e8.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 May 2025 10:13:19 +0800 Matt Johnston wrote:
> > I see your point. And existing user space may expect filtering
> > even if !cb->strict_check but family is set to AF_MCTP?  
> 
> Yes, given mctp_dump_addrinfo() has always applied a filter, mctp-specific
> programs likely expect that behaviour.

Okay, so would this make all known user space happy?

	if (!msg short) {
		ifindex = ifm->ifa_index
	} else {
		if (cb->strict_check)
			return error
	}

I suspect busybox doesn't set strict check, otherwise it'd trip up in IP

