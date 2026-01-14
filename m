Return-Path: <netdev+bounces-249680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD6FD1C22D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C2B73016CC4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE42FFFA5;
	Wed, 14 Jan 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8B5661k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D082FFF89
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357810; cv=none; b=cSlP5ruuLcJvwsyPUJUuYeS6J9iC99260fC+voS+kPwcXbMiJniUNMzyjrVclsErey88iNAq+HDlxiQgwoVaCyH2roxgxFcbYnhcS5FIQN/xsv2GLePLh5ljCbITogeEHBQiBpjgeHAa8BAdYAYwWfCS/YmOsbWxDrCoBamYUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357810; c=relaxed/simple;
	bh=rB/Pc+MocA2Hrim5hkGRBvmByotgqJEjphJuv83p7GU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0Iz39ywDYB42f+FF+FlXwzBgw+WDSKgW8Ht7iBbIxwBdwznn8i5P8rTLP7mi4U4kqB6lmhbpPYp9eZww8M4Qg37MO485UVXVr2gcXTS/YFYTM3OiJFB73kk9M1oq10wQzW0SsMgcPerUnKzMn4Ww3z7rbJXO3yoxUsxcyvBQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8B5661k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237AFC116C6;
	Wed, 14 Jan 2026 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768357809;
	bh=rB/Pc+MocA2Hrim5hkGRBvmByotgqJEjphJuv83p7GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8B5661k8znJFACcufjqnHa2ZHBM8hAzYBcDVB/ERqQiTMpAv0mRegL5U1ZiH3s5Z
	 0WnTRxt9H1x/o7eB04sHWTW5Aa+WOW/20PW7ZCCXi5Af7WLHugww32EPm/UkjgLa8Y
	 5Y/+QiJ3X7Mm1RLjbhpdVgXfBq+UOE0m7S4hA1XcwMtp8hNv6ZV2Fg155ORYxv7P0K
	 NodBXJxt2N5FtuT/aaFShj3AV+yGx44tpa3OFbiBJk0i36IN7g6bMKJnOSevWDMp+A
	 Rol/BehrbsvLyjZck9Bf2UC+JkBxDD8x3HQPCeCsOSKUrfeS+71Ru1X2c+/9mKIVyL
	 nI39q9o80kzEw==
Date: Tue, 13 Jan 2026 18:30:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: minor __alloc_skb() optimization
Message-ID: <20260113183008.15175891@kernel.org>
In-Reply-To: <CANn89iKDrx0DP56AynzMuKv4so7DFEFpFE2yHg6gCGugzd4ivQ@mail.gmail.com>
References: <20260113131017.2310584-1-edumazet@google.com>
	<20260113174417.32b13cc1@kernel.org>
	<CANn89iKDrx0DP56AynzMuKv4so7DFEFpFE2yHg6gCGugzd4ivQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 02:54:10 +0100 Eric Dumazet wrote:
> We could keep it for a while, WDYT of
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 77508cf7c41e829a11a988d8de3d2673ff1ff121..ccd287ff46e91c2548483c51fa32fc6167867940
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -458,7 +458,8 @@ static void __build_skb_around(struct sk_buff
> *skb, void *data,
>         /* frag_size == 0 is considered deprecated now. Callers
>          * using slab buffer should use slab_build_skb() instead.
>          */
> -       if (WARN_ONCE(size == 0, "Use slab_build_skb() instead"))
> +       if (IS_ENABLED(CONFIG_DEBUG_NET) &&
> +           WARN_ONCE(size == 0, "Use slab_build_skb() instead"))
>                 data = __slab_build_skb(data, &size);

Probably not worth it. People who use relevant HW + 3 year old kernels
(I just checked, we added the warning in Dec 2022) likely don't set
DEBUG_NET either. That said looks like the warning landed in 6.2,
narrowly missing the v6.1 LTS. I suppose v6.1 may still be used by some
"enterprise-ish" distroes. I guess we should wait another year :(
Sorry for the noise :(

