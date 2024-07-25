Return-Path: <netdev+bounces-112895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479FC93BAC0
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 04:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF38C1F22DB1
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFCA63C7;
	Thu, 25 Jul 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYnaT24d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C479CD
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874148; cv=none; b=X0y0zFXj9x6xzt/14zzzY9pHlwrPPKzCz7Z/HR1eUDHk6j63QyvcussPys3DULv6zAEYg8ddenMF3PTuXdL+AIN0sC4kVCmHdvauQ6NQsIdor796fgL2TJYpFGN4474r4ymDvWNJ66vX/OQoKGZmwUnH2maCW13h3DiWzKrYUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874148; c=relaxed/simple;
	bh=+MDDO5uES2QZNBYARbv0BJZlSSXziqFQDsrqrRNISpY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mtKg7qrtbUOWdmTJcaCeIFBlEudg7nn/5BKm6D/TVEy6PHh8oRlSo+ppF7VpYZkn5nqfx3A1KD1upCALbt3Et6HrkF09d8AANUg7OwmXA5NoeLQlVcK3lZtzwl+5QS7upZdhOjfXhLQkwZsCNewKUJPaqlSSGbyQwO/xcrapBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYnaT24d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721874145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNGM3lA0lOrAeTXmmJtr9qZWns5lRzfinKRsjPGxJf0=;
	b=eYnaT24dAA/r2FiU91ZS0mfo1E+7zACLz9s7S4xT2blpZhrb09JCf9GKmtGOcWm8YpwndJ
	AeXGzC2XISJSv8Xh4TqNbXlRzRjre3ieJ9vCWSvQdogZ03T3N5/J7xcRDRg8YxiSpnUH49
	k6nYyGNnLvydinBgZPy/AxNDSyQituM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-022nGwauPZOJXUWxgqwT2Q-1; Wed, 24 Jul 2024 22:22:23 -0400
X-MC-Unique: 022nGwauPZOJXUWxgqwT2Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb4c2276b9so538479a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 19:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721874143; x=1722478943;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oNGM3lA0lOrAeTXmmJtr9qZWns5lRzfinKRsjPGxJf0=;
        b=ApNbkEJqHydtX1A5nLEqSmogzY1EZXlqtV8W4y2kt6aNEsRmQo7lbJhmb6MPEy3DGI
         4Y6tDbwDgJqLAwDrRkIZjhAdxVMZhlbCVUjurIxsoJSpoSFTjZcsPj+Gj46vbJfbBcmL
         2TmT2+/UgfhTgN5mEuGHUnj76nounyaEhCixs8VBc0rG7d2xGpzAt0g9aM5Tf2z5X5wP
         b2mcdOcv/GfKmZrK9gH25v6x9X4y3vwWRI9I4VdLWEBPSplFvyCq7iZ6Aeq2e/2Kphan
         O5AmIyCHN69pv/Z/u1YGo7f4PQyNdeBgt+pLUj7ZNzI/p3wR7hh60c5gcYB+tHNQ0Rex
         jxnQ==
X-Gm-Message-State: AOJu0YyT4I549l0dl7t0bx3STlj7SmLebqssmR6v6K7ETObV74h/ED15
	w7b27YNTfhcymml3URiUtkG0Xa7RpVHTqxIZoL87bIPjegUkjvqQ85Ed5n7osB4bkcMrsT6ZeAk
	0A/nwqSI5cWBtb3jmon3D4bP7E0BRUNul6uSozlo99dEXPX99vJSgeg==
X-Received: by 2002:a17:90b:4b09:b0:2c4:ee14:94a2 with SMTP id 98e67ed59e1d1-2cf238ccadamr1769627a91.27.1721874142824;
        Wed, 24 Jul 2024 19:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU3inEA58dMWZvp16vrFg6KsKyTCzUVY/BbC397dqXMKNKyo3Sp/h85bina8DwsWLcGEL5qw==
X-Received: by 2002:a17:90b:4b09:b0:2c4:ee14:94a2 with SMTP id 98e67ed59e1d1-2cf238ccadamr1769620a91.27.1721874142482;
        Wed, 24 Jul 2024 19:22:22 -0700 (PDT)
Received: from localhost ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8bdb4sm2688555ad.21.2024.07.24.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:22:22 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:22:17 +0900 (JST)
Message-Id: <20240725.112217.1430301118501739414.syoshida@redhat.com>
To: jamie.bainbridge@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, johannes.berg@intel.com,
 jiri@resnulli.us, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] net-sysfs: check device is present when
 showing carrier
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
	<066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Jamie,

On Wed, 24 Jul 2024 11:46:50 +1000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal.
> 
> This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
> check for netdevice being present to speed_show") so add the same check
> to carrier_show.
> 
> Fixes: facd15dfd691 ("net: core: synchronize link-watch when carrier is queried")
> 
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

nit: When resubmitting your fix, there is no need for a blank line
     between the Fixes and SOB tags.

Thanks,
Shigeru

> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e2084ce7b7572bff458ed7e02358d9258c74628..7fabe5afa3012ecad6551e12f478b755952933b8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -206,7 +206,7 @@ static ssize_t carrier_show(struct device *dev,
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	if (netif_running(netdev)) {
> +	if (netif_running(netdev) && netif_device_present(netdev)) {
>  		/* Synchronize carrier state with link watch,
>  		 * see also rtnl_getlink().
>  		 */
> -- 
> 2.39.2
> 
> 


