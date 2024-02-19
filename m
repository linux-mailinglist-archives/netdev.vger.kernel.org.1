Return-Path: <netdev+bounces-72922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E1885A24C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6B5B24926
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16B62C6B4;
	Mon, 19 Feb 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGFV80bP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD32C19C
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343110; cv=none; b=RUy6Cg1oX13zn0MmOAoGUHT6vM72L4zpfPJ4JGK5YB8QthgfrNmCwCxwCtLUP7lM2mh966Fk9xX0u3zEx6vSFHMcKO3JEikem/QdekaEDpi5wBQF6fogWpnDtiSWBS3h8xqBxdCjgY8g8WBfphHxyb9KcaO/VvSsw7HR+TS05TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343110; c=relaxed/simple;
	bh=D9hRGYviTBgrT9JL4bYsDb4sJ3nlGtiMKNkQ8M8d4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDWZOvGTCUc8luCEklLp5jWIXwuRZKrxoNiGn7BPNhP9uEhzmuWIr2doLtedqpG0M04hqHPS+8Rja7tUjIc16eyfn8TKg89x6MxLKCIeqOnTEiLDEyojblQ1DCl/ZLP8zD4jAU7UXvA7wHmcNCOmACBdYJfCdX1mc8KO/4xx9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGFV80bP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9hRGYviTBgrT9JL4bYsDb4sJ3nlGtiMKNkQ8M8d4Mo=;
	b=HGFV80bPvVJG4I/dcerxA0Dr+3iOxokAd4tFk8FjBMtH3oxSpau0bPrrbIOR0lRgcgLqjD
	CMx8DpvbF/j23/gb8RU3qCq1ATjGaFayzlVBEyogwz27Y6d5/fp3VWWST2aV0T8z9GE8Xi
	iWlApAjsncZ34DkA91dPYmAoUCzd2c0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-XMlh2GWpMUOLtxF1LwV_ZQ-1; Mon, 19 Feb 2024 06:45:06 -0500
X-MC-Unique: XMlh2GWpMUOLtxF1LwV_ZQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e43bd130b9so1885398a34.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343106; x=1708947906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9hRGYviTBgrT9JL4bYsDb4sJ3nlGtiMKNkQ8M8d4Mo=;
        b=dj450sCw41Bz3TFEMxzwr9F8hg6cjbBg1hVJFyW13CSrv4/0Izo1FWK8o2Xn6X3jys
         KlB1FicjJPmR5hKi1lVt0SzwxTS5tFPutWan9xPEwCYdBWQQZSSxaFGQwPb5HZDK2Sos
         F0LKshvbDPnk9N2Ge3e2qw+YCLf0WNVpNxBvG173qKxDCfPjqyK4JFSfj/osm6yrTE0H
         /XzEJ2OwKVKKSiTlYujuzJKn2yAu5XPueJezbY96ID2kbqnqb4Rt8HY66Ms7dsaAHjnU
         IDd9I6OYN2UVBnZXKFiay8qKCFsyiEv409DrSnIDdO4fxWC383yGvuaVqB639yHZHRZ2
         7cVw==
X-Forwarded-Encrypted: i=1; AJvYcCVb0wZScqscXXXTOCW3Gj3hqnLYKQ27NTDQ4GFwTzx3gn0AkvIWx3mA68r2S8XGaNVJi7JClf6YxS6y+HNBeXxedPO11A4+
X-Gm-Message-State: AOJu0YxzX1PUdMVnTNvpNR9yXY/I4lwtKf9sANYWu110hqGITKtYsezv
	FrZ5Ve+8E09IMj9C+R0NLlfQDCiLULSGWbo7XeUvGxpnZDlHnFVIsXe1VHfU/gBJh1pmzh4RagZ
	jhNNoIqm4FqmExVIr+n2TVWrt7fFbYSQGMrmj8r01USP8is5Bi19WKg==
X-Received: by 2002:a9d:784d:0:b0:6e2:b28f:6179 with SMTP id c13-20020a9d784d000000b006e2b28f6179mr10941366otm.1.1708343105920;
        Mon, 19 Feb 2024 03:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsN2n5yYaiYxn4J72WsxzOtRLf/NgiPHoctu4Eq36TIpHVzuwMVBn8xyf/HnupptrjA+lZvA==
X-Received: by 2002:a9d:784d:0:b0:6e2:b28f:6179 with SMTP id c13-20020a9d784d000000b006e2b28f6179mr10941343otm.1.1708343105678;
        Mon, 19 Feb 2024 03:45:05 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b0042c6ae89193sm2447426qtx.93.2024.02.19.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:45:05 -0800 (PST)
Date: Mon, 19 Feb 2024 12:45:00 +0100
From: Guillaume Nault <gnault@redhat.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/12] net: geneve: constify the struct device_type usage
Message-ID: <ZdM/PD+asF91uwTZ@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-6-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-6-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:28PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the geneve_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


