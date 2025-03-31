Return-Path: <netdev+bounces-178418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848BA76F7B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2F1653A5
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F90214227;
	Mon, 31 Mar 2025 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIzEEaBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9F2165F3
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453603; cv=none; b=BXPvRRQn1fQYc/p41YxANtD9WBYOS1T1XcgjChjb98FZicZJBGm1NMu7bCfDGU7yCwQgI7iLa5BpK9TPXU6BUV7yxoAZa9eWYHfaZYsjVM0Dxntl1Ib5TFk8nGcOmf5i3DEh8swJ17FxOyeIr1e4zM8UwbMVhs66JK3CCX56PBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453603; c=relaxed/simple;
	bh=9U8EMd7xZoKhVVRPSmY2fsZQE6jJJEdRf01xM01tFUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hax3IgBi8QV/F4EM0WYWzSTF2sL6vvEC99am1z8aaMuphd1bAeMd1x+DUwDjvt30Fyb1d2LrY6SG1HFcfui+dBx/bu3ZKYRLVPh3IXGdtTYOdQUefX2QE/WeF1DGUgY99edQh5koW6tU1C3QJIHVIDLOjmRaH0rgHphLMYawLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIzEEaBL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264aefc45dso121989375ad.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743453601; x=1744058401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcPJdMmlpQJUXOo0T3hk32D5b3JMmm3nbyteU0s6J0I=;
        b=kIzEEaBLcf2ynaJXY0JUW3cdRA4Nkr5/iZB4+AFltc5axXG3czgA1V6nYL1MqoVuCu
         GlKA9zWTGr4UXmAQj6GsoLyuaCsnu/TtCXJVT/e8lQANxFf0nZJ0fZeNDctctxnEM3Zb
         3NfEaL6MM8pWzG+yCmRf1ETy+PiSNnQrHYFdriUv2rWdWr5z0aWHZeEkacqZPN05EfuY
         YfIIVFeVO2IBYrhlaLEy3FcsLwwMbp7T2KzXhQNtVkgLDbXYJ1L2YpkKQugogF4sMxlf
         4UCWXG0iwGFjbEV5XLfUI1BHfTHlU34vhYoLou9PanuJY6n4UTFJu6VlUFABI0BgjK17
         Pf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453601; x=1744058401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcPJdMmlpQJUXOo0T3hk32D5b3JMmm3nbyteU0s6J0I=;
        b=iC9viQaO6akeoGh8YeLpTrTk+Q9wnAC/CRkXojg/E308PtCULvOavjo+ysmrlqz8dw
         hrHGbeVfXVGEMPxu+pItGR+qdxpP3O5V7gD4ANIWuseyfPNtZVYVx2Z+bWeiB0edAuIi
         Cn57gbu/wUuJQXKHTqbvYVlAjUu6iSqtU3oJC9raCtUH8tBaPmTnkGqdQ48yIw++LDpq
         ks9treqNr0/5LfdCE1vioyYJXr5G8fNErDOcD1iXF3L7DUwtExf4Lve4lPjHG92OaMGV
         njBKZGk2xvQP82daVACFZvDqi91yzeImE0znFItcHZqZj8pu1S9XsrQbETNY91upyLoM
         e6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVQNjQ5tWoZatK/y/ItIMpz2DgW3kdySZkYl9E2+yZJwTZwW9w4A84whewzl5LCTeQCOM43u4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/vnwALLu2geQIY780tF80cmmRGtA0eZkCb4qxYj89JjOdQAJ
	doLpU0n+JBxlDN1ezU5EdUlv7q2H0SzWPxRMZQVOHs3Gaet5Lwg=
X-Gm-Gg: ASbGncvYtOVwaGG1TlKhDudkKUGlj6/05/P1O84wef4fSTv4c5Snn2d/d0oNqThHupi
	whVxiVMWhPNy0vcEO+6PzCikTzPLQFBDgSCSEAlUe7wOmUf1kWyTiJ//BBJu/H6LO8iRlIWkGzT
	nTBvJo9dQQJUF3HEK76Fyc5OcHK+IBQ2xIxHG69PUeb1YY7kRpYHibvX5LXZ3NfTDEHqdFzKmaG
	Beb+mWaxfWKazYVBMKqj8gbl9HEyfZzf6OxjMIiuOh+is+NNh9cxFZCsoceyTOUTtaGvPb3W/Cu
	Au6o2PU7edqy4L227kzpPNbxmgaKcMHE+7D/xVLEoO+ckeP3oyTO6Fg=
X-Google-Smtp-Source: AGHT+IGv1jUP3g+no97XkCw2C6lbSM8B7lYIG/GEDABimw/ZNJb3zuTrAmVrBU3Uj6yeq2bze8TGOw==
X-Received: by 2002:a17:902:f705:b0:224:194c:6942 with SMTP id d9443c01a7336-2292f9e8455mr188278695ad.34.1743453601238;
        Mon, 31 Mar 2025 13:40:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1df40dsm73813585ad.208.2025.03.31.13.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:40:00 -0700 (PDT)
Date: Mon, 31 Mar 2025 13:39:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ap420073@gmail.com, asml.silence@gmail.com, almasrymina@google.com,
	dw@davidwei.uk, sdf@fomichev.me
Subject: Re: [PATCH net 1/2] net: move mp dev config validation to
 __net_mp_open_rxq()
Message-ID: <Z-r9nxBna_WrOckQ@mini-arch>
References: <20250331194201.2026422-1-kuba@kernel.org>
 <20250331194303.2026903-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331194303.2026903-1-kuba@kernel.org>

On 03/31, Jakub Kicinski wrote:
> devmem code performs a number of safety checks to avoid having
> to reimplement all of them in the drivers. Move those to
> __net_mp_open_rxq() and reuse that function for binding to make
> sure that io_uring ZC also benefits from them.
> 
> While at it rename the queue ID variable to rxq_idx in
> __net_mp_open_rxq(), we touch most of the relevant lines.
> 
> Fixes: 6e18ed929d3b ("net: add helpers for setting a memory provider on an rx queue")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ap420073@gmail.com
> CC: almasrymina@google.com
> CC: asml.silence@gmail.com
> CC: dw@davidwei.uk
> CC: sdf@fomichev.me
> ---
>  include/net/page_pool/memory_provider.h |  6 +++
>  net/core/devmem.c                       | 52 ++++++-------------------
>  net/core/netdev-genl.c                  |  6 ---
>  net/core/netdev_rx_queue.c              | 49 +++++++++++++++++------
>  4 files changed, 55 insertions(+), 58 deletions(-)
> 
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
> index b3e665897767..3724ac3c9fb2 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -6,6 +6,7 @@
>  #include <net/page_pool/types.h>
>  
>  struct netdev_rx_queue;
> +struct netlink_ext_ack;
>  struct sk_buff;
>  
>  struct memory_provider_ops {
> @@ -24,8 +25,13 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov);
>  
>  int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
>  		    struct pp_memory_provider_params *p);
> +int __net_mp_open_rxq(struct net_device *dev, unsigned int ifq_idx,
> +		      const struct pp_memory_provider_params *p,
> +		      struct netlink_ext_ack *extack);

Nit: you keep using ifq_idx here, but in the .c file you rename it to
rxq_idx. Not worth the respin..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

