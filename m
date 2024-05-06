Return-Path: <netdev+bounces-93668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99A8BCAE4
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A2B280E19
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9289142E7C;
	Mon,  6 May 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOfIOj5H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DA142E63
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988316; cv=none; b=G5rwvHUmWdQLYdZoPZejqCcUmlvWUdkmrSTqoWxex3LrjtCLqib6IlPYPrkWHrRaqJbuuFPvaIHtUd/Jpj3lBGNvyoeOC9/Y1rl4BNaPNRYrg2PD0WGCrkn0Pt2VxCtcsPdj7vXVr1XfQvPLHiyFjHUSwi45S8d/UENDHSs/uOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988316; c=relaxed/simple;
	bh=nYUm9kcI88bCIJdm7i+MvfIjZW0f5pcjacyJHddWxvA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plWgSsrPSFX+8YJky13glkoKhXwxkpkYnkM9Z++P3Uy8m0R2aJV0JL3pECsCAEo5m4Bv1WdqnlvTfgK5iWbzfHdx3FTs8uPbaBEmu7tUUqJeVnpRzCusvLPNYH3BRQosfhjCNhIOnBZUaVZGnKJRyyGVV/nuafr/M3/SPUPNmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOfIOj5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714988314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ofi+IdOsdBBIT7hV591VSzQDADHpiRaZqxTdbVc2Izo=;
	b=OOfIOj5Hi3M9Mx3dR3r5Gx6y6M9yyh4iYFr6XSV2MCYg2citgLBADrRbOWa4iad/4JK5K5
	AfBJ5StjxEA4dvjNGLPbuGYPMOX9eX1hapAlASBN93XPgDZZmPTjFeaGI8IIpIMrmgovXA
	gQ7b0eLaU6IIP61ckVZ/aAYomndi3sA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-SlrjQaDxPaObnFunbwyeLA-1; Mon, 06 May 2024 05:38:33 -0400
X-MC-Unique: SlrjQaDxPaObnFunbwyeLA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34e40a604b5so209609f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 02:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988311; x=1715593111;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofi+IdOsdBBIT7hV591VSzQDADHpiRaZqxTdbVc2Izo=;
        b=jSxK/WthJqBEpP1Wyp4Sr3k04gxdSeXoECNbJD5NmPVmTHRZGXrz02+VRcDgF7iVHb
         nH0GyxiLXGaJvpAZa5gaSds/adZJ2uSUIfqjTwO68bhGIhHk/0hw3c2T70HQMoC5V+2l
         ToCPQ4wLjwTcpnEUyqk8EQPcoZDqZTDodCJ5kv+gp4AwkftWAo8MLS20iwxV85G75cWh
         SnUP6UJVTy6w3QldRI3M7PYXb4LlvmQ/0L381820f7XhmI22AEnZtRSLF08VwasDVw6y
         5aHYMv4mFBiPvv1/SHh09aQ33xRNkiqvTu2fmoZQzNFQlrlWndlEj7SgP164NT5fFzyd
         KWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3EEts1vFKYk3u4V0pE0nIW6uL7b2sFiLPcD+knc6eaCDA/xaHQKCOoW7ARn34gjRxHjvOVw/hgpn0zbmeIlmqR+JQZi2n
X-Gm-Message-State: AOJu0YylAAIro6p8JaybLJI85r3bsVrGIyx/d+7BcrvxjpAInzNNFlkd
	6olomVlMTbYj0kFmAhKqYoCCtcJS3Cq/WVE8g2KQx0YRIXyowgnw677Q0OiZvBauLVxrvPwQhlS
	T+BNp+qthVLEoHNMhXI427k0PG0YakNdP7K+B2FQQp8M6CfOmYMxwTk5xBjzevA==
X-Received: by 2002:a5d:590b:0:b0:34c:f9c9:f51c with SMTP id v11-20020a5d590b000000b0034cf9c9f51cmr7294509wrd.4.1714988311594;
        Mon, 06 May 2024 02:38:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpssS49YGsO2P6VsuovgOlShplA4Wj82H/KCeJWZDajXrjEGx+TY+Fjrv1xhuuoU6+kgEgaQ==
X-Received: by 2002:a5d:590b:0:b0:34c:f9c9:f51c with SMTP id v11-20020a5d590b000000b0034cf9c9f51cmr7294490wrd.4.1714988311150;
        Mon, 06 May 2024 02:38:31 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810:c326:df35:5f81:3c32])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d5284000000b0034b1a91be72sm10242715wrv.14.2024.05.06.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:38:30 -0700 (PDT)
Message-ID: <1706dd2a3d24462780599f57e379fa2a1e8e15ac.camel@redhat.com>
Subject: Re: [PATCH net v1] lan78xx: Fix crash with multiple device attach
From: Paolo Abeni <pabeni@redhat.com>
To: Rengarajan S <rengarajan.s@microchip.com>, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 11:38:29 +0200
In-Reply-To: <20240502045748.37627-1-rengarajan.s@microchip.com>
References: <20240502045748.37627-1-rengarajan.s@microchip.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 10:27 +0530, Rengarajan S wrote:
> After the first device(MAC + PHY) is attached, the corresponding
> fixup gets registered and before it is unregistered next device
> is attached causing the dev pointer of second device to be NULL.
> Fixed the issue with multiple PHY attach by unregistering PHY
> at the end of probe. Removed the unregistration during phy_init
> since the handling has been taken care in probe.

The above description is unclear to me. Could you please list the exact
sequence of events/calls that lead to the problem?

> Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---
>=20
>  drivers/net/usb/lan78xx.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5add4145d..3ec79620f 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2383,14 +2383,8 @@ static int lan78xx_phy_init(struct lan78xx_net *de=
v)
>  		netdev_err(dev->net, "can't attach PHY to %s\n",
>  			   dev->mdiobus->id);
>  		if (dev->chipid =3D=3D ID_REV_CHIP_ID_7801_) {
> -			if (phy_is_pseudo_fixed_link(phydev)) {
> +			if (phy_is_pseudo_fixed_link(phydev))
>  				fixed_phy_unregister(phydev);
> -			} else {
> -				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
> -							     0xfffffff0);
> -				phy_unregister_fixup_for_uid(PHY_LAN8835,
> -							     0xfffffff0);
> -			}
>  		}
>  		return -EIO;
>  	}
> @@ -4458,6 +4452,14 @@ static int lan78xx_probe(struct usb_interface *int=
f,
>  	pm_runtime_set_autosuspend_delay(&udev->dev,
>  					 DEFAULT_AUTOSUSPEND_DELAY);
> =20
> +	/* Unregistering Fixup to avoid crash with multiple device
> +	 * attach.
> +	 */
> +	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
> +				     0xfffffff0);
> +	phy_unregister_fixup_for_uid(PHY_LAN8835,
> +				     0xfffffff0);
> +

Minor nit: the above 2 statments can now fit a single line each.

Thanks,

Paolo


