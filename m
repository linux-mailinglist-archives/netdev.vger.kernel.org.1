Return-Path: <netdev+bounces-239574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2805CC69CEF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA826341838
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D60354AC0;
	Tue, 18 Nov 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNB8ApJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFB316914
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474675; cv=none; b=eTa+liEDthwSoSxnlzmRAtiTzINZw2q3DuTfdlKKGH2dFqxREYeNa67pRwt0wBopIQe+b5nkvntQykDoeaZpQU+IH0bP88tE3jYpm65LrOGNg2H4hDZJO861/Xg03+rqONouzYzodqiwgRLrbh89GtcAwuCRC6ACDDRglD0rFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474675; c=relaxed/simple;
	bh=mh0XPOKxa9clfpl/Tgbk5Sd8lWYVaC2FPIHl08pEbaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ju4hE6OgJqFTDu0ErhLMdtCtkqA/v83KElpAcQUxgffWxm5yeIK4xBqafpUm1WXj3pwbBi0OFsBcLIriQQDeYLcQURtw9GiTQtqXEigcb7LwAMxF0trXoiqEX3wUk79fYSbcGZKPOydsHlbruAIzg3HQV7DZJVF+zXFF735XGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNB8ApJL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed67a143c5so314741cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763474672; x=1764079472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtFKq6NA6WikUzTSMAPyERROIvaWVzJ2GmLlcS5OXlM=;
        b=TNB8ApJLaaXIe6JIzH6jLh51KgTLlWBqUku3I/56OZVLRtkItO5jN+c5GAdTfGKbch
         YIWYVPZpgt2EqHsjDNIE82pSWpu8dTrp7zJrg2vs1t5pzFhTdtA5TQRy6HY+TtZIyUVH
         9B8NMJRO1SwtPBwMYghcUhc8Vxon9XrTYi+m5Sp5hzfVM8cNhYN8+M+3HwPgMZvlpvgr
         nk/+g02v2wKJ7c0MT+C1aitrPCQtgEMclyoSl5b1kl71Ms1djTqrfgjZBvnIWvcgnv9q
         9nNFkqKL4S9fueyh13cE9GLUksVygVmxSmbIpekidn4ulT0zNP/QS7QL2nyh1t/21XxQ
         UGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474672; x=1764079472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtFKq6NA6WikUzTSMAPyERROIvaWVzJ2GmLlcS5OXlM=;
        b=uxUPPUhNHVkH5gV/NYccGLT1NZHPZ7cvC9v6hJXzcg6KZua3ukoujxWZfj6NkEAwE6
         i4OqvjsvDkvMJk+MA9B2apUuwVreTmF/HPBF9d+ozGoq/iPwAcalj3+cL9SZykzbUorx
         36l8bUiydVXskJ+PiOEdiBmjHdszQLeil8lkibIdO3pNSqxY4HzAHoLz6vqnlS/W6CGY
         cF0XqXVJzBStwyF+aFEYf3UQr7Q3u4X7KBr42QdMZhpG2QXWZfXsmhkFhdo6wDp9psSM
         3OUYcC/Jp8/EG8E5gb9oehqTuajTxvqbBetuocbwtM0JvLp8LcGCmEsdh5CMJPV8i+6K
         a35g==
X-Forwarded-Encrypted: i=1; AJvYcCVdijC7CdLQvgFXTQuyJuErM3lq8wi/rp3xXOBDeN8Nqu5+EM1XnJfxsNHYJUW3b9cnTQywjx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9N/jFHRTtlOoCbWpdT+cG0djOnPECerouN+y9ifE9qKV5BEhU
	ueq80Cfb31Liloz/+liaAogkxuR6TmUEEWtJi0aOLnAgW3pzERALMfWzYEPe/oW64TZ3z0clbss
	VdXxHim5Lhr1WAdHi0UUlK/BYLeqOM9N7O+kyOFcI
X-Gm-Gg: ASbGncvo3AE2flOIjb1GisUsDdu6iTZjCoQ7n+Y4GdVoDWMdm/fo2vazOTWe58OajI3
	6LQNgC3kQaDvxV0lwYYqVZ/OadmRflTyqD1yX50R/Ij9HfHIlCb4bHdZ+tM2CIMSwUnMInJ/eHK
	n7lbTtIs41XEeLr4FdP0FKPXaH1/tAgDjQXxGeCEIkoKfFGwUeeNEH8J1L4AxXgxf+hJCVOZD4m
	toM0obklpVCHcLQ37/qH1zPWcZcosdJXuYNTTJcznkcSg2FJDmagD3qIU8FMMhmxRXs4BZRsam4
	HG1mKxQHc9EKUR7aHvfLPZJ7yqJiyqEddssQJJFrqTvb36LqNKQC3Ii7pSwsFp6uJ1oYzjs=
X-Google-Smtp-Source: AGHT+IE3a+WRbi38k/wtkxWeKtC76OvOMSlsTRZdvHw/5mbsU9o4MZznsgbN6mjLgqzbD5X/VPEOJ3d63gH9pW3vux0=
X-Received: by 2002:ac8:7d46:0:b0:4e8:85ac:f7a7 with SMTP id
 d75a77b69052e-4ee373cfbd8mr2531221cf.9.1763474671824; Tue, 18 Nov 2025
 06:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-3-edumazet@google.com>
In-Reply-To: <20251117132802.2083206-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 18 Nov 2025 09:04:14 -0500
X-Gm-Features: AWmQ_bn2wfPOrMm2i_fmu7XzYHL5bxBHMImiYKP9iMLxloCmzFN8eDNQBPUvsag
Message-ID: <CADVnQyk4=w-Qbw24na3_09SRfbP3w+W9trzhd2vOLfeVui8-BA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This is a follow up of commit aa251c84636c ("tcp: fix too slow
> tcp_rcvbuf_grow() action") which brought again the issue that I tried
> to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
>
> We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
> ("tcp: increase tcp_rmem[2] to 32 MB")
>
> Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> force NIC driver to not recycle pages from the page pool, and also
> can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> are usually slower than senders.
>
> Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1 ms)
> If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshold
> ratio to control sk_rcvbuf inflation.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst         | 10 ++++++++++
>  .../net_cachelines/netns_ipv4_sysctl.rst       |  1 +
>  include/net/netns/ipv4.h                       |  1 +
>  net/core/net_namespace.c                       |  2 ++
>  net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
>  net/ipv4/tcp_input.c                           | 18 ++++++++++++++----
>  net/ipv4/tcp_ipv4.c                            |  1 +
>  7 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 2bae61be18593a8111a83d9f034517e4646eb653..ce2a223e17a61b40fc35b2528=
c8ee4cf8f750993 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -673,6 +673,16 @@ tcp_moderate_rcvbuf - BOOLEAN
>
>         Default: 1 (enabled)
>
> +tcp_rtt_threshold - INTEGER
> +       rcvbuf autotuning can over estimate final socket rcvbuf, which
> +       can lead to cache trashing for high throughput flows.
> +
> +       For small RTT flows (below tcp_rtt_threshold usecs), we can relax
> +       rcvbuf growth: Few additional ms to reach the final (and smaller)
> +       rcvbuf is a good tradeoff.
> +
> +       Default : 1000 (1 ms)

Thanks, Eric! The logic of this code looks good to me.

For the name of the sysctl, perhaps we can pick something more
specific than "tcp_rtt_threshold", to clarify to the reader what the
RTT threshold is used for?

And if the name is more specific about what the threshold is for, then
in the future if we want RTT thresholds for other behavior (e.g.,
tuning the tcp_tso_rtt_log code or other future RTT-based
mechanisms?), then it will be easier to add those future RTT
thresholds without the names seeming confusing and error-prone?

With the existing "tcp_moderate_rcvbuf" sysctl in mind, how about a
name like "tcp_rcvbuf_low_rtt"?

Then the description in ip-sysctl.rst could read as something like:
"We can relax rcvbuf growth for low RTT flows (with RTT below
tcp_rcvbuf_low_rtt usecs):".

WDYT?
neal

