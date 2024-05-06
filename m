Return-Path: <netdev+bounces-93811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C048BD429
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F8C1F22A24
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA4158201;
	Mon,  6 May 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe/6e71R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1644157499;
	Mon,  6 May 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017976; cv=none; b=BsGSkT/onWYsXhkN5HypAfyTn6301G5zBwdJW1uGxQNJ9WNgLUgbxHxbW5GnRhwNpAQN3Ln4kx8LkCgu3E0L+9oH5+8PsQ5IRdYuBjvMsARsbJarb0/n25IVQnUfxpFsl9+LLHbS8ABrB/W10aA4Yzjbjx+xiJNYbhzqbuRawd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017976; c=relaxed/simple;
	bh=0uZVNC+RmIL4x6SFOxW8zvCs0BWjvkpsDEfsy39/wIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgYHXd7jISKFWGkyUAvg3Dv+BhimeFP2iZrB+QJ3gO4Gqb2LhUJsoxFkWHYqlc7y+/mUEG8sNtvIWMYhSdcGdF31oIXynrYw0oH1TgAZIjxXzFPkkUshM1wxsNaWqs6xKHefZ1b3S3qkmcKq4KRkX3YNNzvRzlvacAMwemfCf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe/6e71R; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed012c1afbso16809965ad.1;
        Mon, 06 May 2024 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715017974; x=1715622774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zL9KgfnMQMEXWqVrWGtFIyG/759bVBd2pXzbcD1wqpE=;
        b=Qe/6e71RU9U4t5Yk4z45zkLRNWukf7bAcUs8hXLihljUuWb+OtsVC4hpI7IJz/pGuU
         D4Sx6V7yOXCl1OjmCjtf9o+4cZ+jE+MF291kzdz/5plGy/0Am3S+NkuQNSqzwA77lTsi
         Zs3S0A99kADjoHr12YMHurEaCDjAspjRHHAWHKk0SqFnf+SRRWWAvbzEaakILiwoE8hQ
         6RJXOaFsjDQ/MwgOppsjedBw0fXaYLgUYaCJJ3mRyMzZQFHmBa0nFXd8DOtkrv5V+kPb
         +lwXO+fr/4IQSjMcXnucy1An3wrmZOvcJB0z28ouKSmW9HMpxrv0SpdsZe3D5N/Ct2IQ
         SzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017974; x=1715622774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL9KgfnMQMEXWqVrWGtFIyG/759bVBd2pXzbcD1wqpE=;
        b=i56tVB897G5SavIoOvknjHz0eenSg+ywMcPG4yivGrysn1WM9aDvy8tmMV+90Qjm6/
         rXu4d0CNhOt1eBuzTng8sX40HJUouhBAWI5/EF1uPBL7/N3/4ouIHtEtp1P+qPqcHptU
         0K8vzLA2HyNGzfkFA3LBIGHGjxcRsHn37J13CzWSlE5Z8w32EUXpKkwdwwhX7gqp5cts
         FiT5dx8lDfmo37PeChx/fVGb5VpWMjzBuxifQBE9O5KkXWv1NFWnYIV47JpX7E8JxRKv
         maMywUdXnyQQdcND0Qq7RLzjzd9bL+RshRPk4hL6344IXVDEex48Up5M2QSYKl5j2wPR
         /c4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6IlOoq6CHFlIfYnsdFcs0e5zctMLqdiAuhX+v9Vd+8Zx5SnoHcz2Vdnc2bcrvnzb65pzCjN5f0fkpxvIJpRUWOD6XuxKoHacu3fnN+fWwANgpvyICW//kV+IqRDvpYYdpo56Z
X-Gm-Message-State: AOJu0YyLigQdfdoUaByxD+IzsqujJEdPNUjrJPUuxM/ffIPM2zm2ewP3
	D78FmZ5BmhbGpAEoUO0YQ7fcAYUI7YTPfGBFfc+Egdhh2DYOCkGLIqH2wNGQ/Wg=
X-Google-Smtp-Source: AGHT+IHRaMz8qRHdb53omaqhencIxqzAi2Qon38K7m+KWqB2FVQ4w0tYKa/mFMQuw0yRiuiRsuHOUA==
X-Received: by 2002:a17:902:ce8b:b0:1e2:a5db:30d1 with SMTP id f11-20020a170902ce8b00b001e2a5db30d1mr474256plg.13.1715017973839;
        Mon, 06 May 2024 10:52:53 -0700 (PDT)
Received: from frhdebian ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001ea9580e6a0sm8525696plh.20.2024.05.06.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:52:53 -0700 (PDT)
Date: Mon, 6 May 2024 14:52:49 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hiago De Franco <hiago.franco@toradex.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-nuss: create platform
 device for port nodes
Message-ID: <e3g5bdpcejebhg3mokoaknxmzvr3wjxv5fvhbogyl5sz6cpt4n@wtgu6rba2w2g>
References: <20240503200038.573669-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503200038.573669-1-hiagofranco@gmail.com>

Dear Maintainers,

On Fri, May 03, 2024 at 05:00:38PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> After this change, an 'of_node' link from '/sys/devices/platform' to
> '/sys/firmware/devicetree' will be created. The 'ethernet-ports' device
> allows multiple netdevs to have the exact same parent device, e.g. port@x
> netdevs are child nodes of ethernet-ports.
> 
> When ethernet aliases are used (e.g. 'ethernet0 = &cpsw_port1' and
> 'ethernet1 = &cpsw_port2') in the device tree, without an of_node
> device exposed to the userspace, it is not possible to determine where
> exactly the alias is pointing to.
> 
> As an example, this is essential for applications like systemd, which rely
> on the of_node information to identify and manage Ethernet devices
> using device tree aliases introduced in the v251 naming scheme.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 1d00e21808c1..f74915f56fa2 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2091,6 +2091,13 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>  		if (strcmp(port_np->name, "port"))
>  			continue;
>  
> +		if (!of_platform_device_create(port_np, NULL, NULL)) {
> +			dev_err(dev, "%pOF error creating port platform device\n",
> +				port_np);
> +			ret = -ENODEV;
> +			goto of_node_put;
> +		}
> +
>  		ret = of_property_read_u32(port_np, "reg", &port_id);
>  		if (ret < 0) {
>  			dev_err(dev, "%pOF error reading port_id %d\n",
> -- 
> 2.43.0
> 

Apologies, I believe this patch is not 100% complete, there might be
something missing. Please keep this on hold, there is something not
working as expected that I am currently investigating.

My goal was to create an of_node device for the switch ports, which did
create under the /sys/devices/platform:

ls /sys/devices/platform/8000000.ethernet:ethernet-ports:port@1/
driver_override               power                         uevent
modalias                      subsystem                     waiting_for_supplier
of_node                       supplier:platform:104044.phy

However it is still missing under

find /sys/devices/platform/bus@f0000/8000000.ethernet/net/eth0/ -name *of_node*

I will figure out how to do that and propose a new version.

Regards,

Hiago.

