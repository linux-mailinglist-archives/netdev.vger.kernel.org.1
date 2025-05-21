Return-Path: <netdev+bounces-192486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A847AC0075
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23664E62D4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FDB23BCEF;
	Wed, 21 May 2025 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="R1GMoUFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9523AE9A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869080; cv=none; b=pO66G0nMxi9xW86mjWmgOZjHa+EykQSb9IJWRl1HXuvl1TKBsimD3OD9LIAE3ztOe3SYiMm+bk3qScSrKFXoOuEGmRSpcdjQHxxeP0wAxxUT98MQE3xup1ElLujpx/pH/qtmvV1eoIrpr4/MBJQPNYyef0xz/mWl+TSbeETE1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869080; c=relaxed/simple;
	bh=UdWC9sqECTgaarvEiqSkXmOxN5DQvg45QnGDt7V+EQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiYaT8Nme97UUrPmDtOBL3U8tXihckumwq5m6fRE6JQ2PrGiTyKolBmpDZ8xWGlEQigBlj8sz4FErJ610sP+oe5fr2DymqU43u2mDpvgm1sB4KHRbGMpQHZoAeB86QY/NxSAQfGyzvYicLAhwKlOApYIfuGus8CBMq8blQDqNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=R1GMoUFE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30e7d9e9a47so952889a91.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747869078; x=1748473878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdZyuVQRffc/qTOwDv32OiSbo0Uwd9rdVUrfHuZzreA=;
        b=R1GMoUFEvRikYVjIfea6QXuZw0i1aNNJeekEl8RP0/cECGxZTEhTauqJsRhKR8nuoq
         XhYyemxe6IIOaFd4KaiNF1jsTS7Qr73rKDNSCOmqd7bFhhG4hwRMr78ouw5tPL5W+Cnd
         xJpgKKz8/OURZGpV8DWL4VJ9yo5byTTS50UPCUj/8/1vPcuYT2eU1QOy8VRw63pXCbT6
         8FuUZ+cHiAMjGlFeUTSpFdQGhAwGD4yXJhFjXxPoz+0hDVPMwEG0PAuExDErL3UVK+0D
         v2r9zHbnj0AfD28223dku9dNz8m3XaMJCUVLQtSPO8C28BrafCHWkmMLHzDZaD8KnOF0
         Aw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747869078; x=1748473878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdZyuVQRffc/qTOwDv32OiSbo0Uwd9rdVUrfHuZzreA=;
        b=KDGv/LprrMl9sLYTbuv5GNOIjYW1yTXMlbHmHe8k50Ad8iVByfWZjils3LhRX/H/cR
         8EI4HFt2HzZw2KtXrnOZAV8FwghgZCqYF/VhjQH+WIN8ssUu39M7ZR6e7IFyxQQ8AlL/
         EVnxZPE0VsrIMMuLtSOwKM6ffJfy98lV+7/nQ0RRUSg5SLicFJzKZaP2oNe0nuQttgD9
         s2gjstxur9SkjBKNrMyuhc/b9C3BEwwyzwXcilpGDrQC34NF+u8Cgluuam1ksRsGA2iX
         cutq4eFaW2kbu2JGapK1sNFA3zO+nMABQ2vcU3zAFuKRlPUDA3OikwmqW8vEp1OpCh9u
         Ihsw==
X-Forwarded-Encrypted: i=1; AJvYcCXgsOzTn7/Y2cGdBf502Nfer8BdQ8Tv3Vaksof1c0ke9W95dNdCXE+GO+rku3eBEJUHmNcegGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIXfHSJbAHLIWqmyEH9rtEqxP0EM7fc7NQv9Ve7uSPekNMuMQ
	9KCXo6hq5Yo7LgCV0bxpC5ecas/9XXGD3JVBreJ43pL11q83mzxFvhV+C57TsjYdc4o=
X-Gm-Gg: ASbGnctk86Zxj7EubvuSBYJYpO+i9x6oJi5hFZv3b+Mlix7qpwpLZk/iHfCSwbmu7V9
	OYDIu1N/4fwEra5tddxB4d1Moy5NihaMf6ovE5hitwvp5TmFTGU/rHw+dbHMGbFA725m+YcmFAr
	TtAhOb9+F6hW/EFQobk5KYenyCTJYcYikYweQ+7wiWgWDAJl5Xbe7hNdM3GreFj+BuhW2s3zpwK
	8xSuENfzyK1Hi05K7Ley/fjwA4nLHuVumqpDBE8afvHgxiuLHf52FF6vXhGxb7aKOgsV8xWnTj1
	V9o5CkTWc9Heh2pBHxg65gMVUxHfutILKrdEiQ==
X-Google-Smtp-Source: AGHT+IGwjSUbiRwMD8QV6uWmDfMxXDebDsmtwEZ8vFNFrWh6oU27yigQeTPsiHaCNfm11lMgVo+uvw==
X-Received: by 2002:a05:6a20:d523:b0:215:db66:2a2f with SMTP id adf61e73a8af0-216216573a0mr12815396637.0.1747869078421;
        Wed, 21 May 2025 16:11:18 -0700 (PDT)
Received: from t14 ([2607:fb91:1be5:f4d8:99e5:a661:f426:884c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96defc3sm10143644b3a.21.2025.05.21.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 16:11:18 -0700 (PDT)
Date: Wed, 21 May 2025 16:11:14 -0700
From: Jordan Rife <jordan@jrife.io>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <a7h5ug23xvcayh66nm2373nxotd73xbr36kabpjky273wudb7i@mmduvu4bqzqa>
References: <20250517192955.594735-1-jordan@jrife.io>
 <20250517192955.594735-2-jordan@jrife.io>
 <aCz4jK9i-N6e5xk-@zx2c4.com>
 <aCz7YEp5-Viktx7W@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCz7YEp5-Viktx7W@zx2c4.com>

On Wed, May 21, 2025 at 12:00:00AM +0200, Jason A. Donenfeld wrote:
> On Tue, May 20, 2025 at 11:47:56PM +0200, Jason A. Donenfeld wrote:
> > Hi Jakub, Jordan,
> > 
> > On Sat, May 17, 2025 at 12:29:52PM -0700, Jordan Rife wrote:
> > > * Use NLA_POLICY_MASK for WGALLOWEDIP_A_FLAGS validation (Jakub).
> > [...]
> > > +	[WGALLOWEDIP_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGALLOWEDIP_F_ALL),
> > 
> > I wonder... Can we update, in a separate patch, these to also use
> > NLA_POLICY_MASK?
> > 
> >    ...
> >         [WGDEVICE_A_FLAGS]              = { .type = NLA_U32 },
> >    ...
> >         [WGPEER_A_FLAGS]                = { .type = NLA_U32 },
> >    ...
> > 
> > Some consistency would be nice.
> 
> Perhaps I'll commit something like this?
> 
> From 22b6d15ad2a2e38bc80ebf65694106ff554b572f Mon Sep 17 00:00:00 2001
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Date: Tue, 20 May 2025 23:56:18 +0200
> Subject: [PATCH] wireguard: netlink: use NLA_POLICY_MASK where possible
> 
> Rather than manually validating flags against the various __ALL_*
> constants, put this in the netlink policy description and have the upper
> layer machinery check it for us.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/net/wireguard/netlink.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
> index f7055180ba4a..b82266da949a 100644
> --- a/drivers/net/wireguard/netlink.c
> +++ b/drivers/net/wireguard/netlink.c
> @@ -24,7 +24,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
>  	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
>  	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
>  	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
> -	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
> +	[WGDEVICE_A_FLAGS]		= { .type = NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL) },
>  	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
>  	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
>  	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
> @@ -33,7 +33,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
>  static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
>  	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
>  	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
> -	[WGPEER_A_FLAGS]				= { .type = NLA_U32 },
> +	[WGPEER_A_FLAGS]				= { .type = NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL) },
>  	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
>  	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
>  	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
> @@ -373,9 +373,6 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)
> 
>  	if (attrs[WGPEER_A_FLAGS])
>  		flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
> -	ret = -EOPNOTSUPP;
> -	if (flags & ~__WGPEER_F_ALL)
> -		goto out;
> 
>  	ret = -EPFNOSUPPORT;
>  	if (attrs[WGPEER_A_PROTOCOL_VERSION]) {
> @@ -506,9 +503,6 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
> 
>  	if (info->attrs[WGDEVICE_A_FLAGS])
>  		flags = nla_get_u32(info->attrs[WGDEVICE_A_FLAGS]);
> -	ret = -EOPNOTSUPP;
> -	if (flags & ~__WGDEVICE_F_ALL)
> -		goto out;
> 
>  	if (info->attrs[WGDEVICE_A_LISTEN_PORT] || info->attrs[WGDEVICE_A_FWMARK]) {
>  		struct net *net;
> --
> 2.48.1

This changes the error code returned in userspace in these cases from
EOPNOTSUPP to EINVAL I think, but if there's nothing relying on that
behavior then it seems like a nice cleanup to me.

Jordan

