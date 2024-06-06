Return-Path: <netdev+bounces-101329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535878FE25D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEFF1C20E91
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490015FA77;
	Thu,  6 Jun 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwRof7wL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A915E5DE
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665295; cv=none; b=bHLyo7DwS/PXNgz+0Xj0RNH/qXlcloC1ld53qhsnUE20W0APW0TwKykO5cC8tIYismYsuCyTepIrecz+60qQ/fTrGguBqYWPFahXFATNUIPmk0QJbux6wyYDEX4n+HZYoKHLKIRLGKi/lZ0BR3He9ttst1T9YUuI/Z63djHJtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665295; c=relaxed/simple;
	bh=uHwI8RjIUSzq/5Y1r3oM5+yIohYnXgOarzdl1SHRFQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/NdXVEYrPSaKWnkEYz6stO8vFIA8fUjsScn3RzeLVRZErX3XFe0Zd8gSH62h7vzekhzdpUBUu2meqWC52y79RuQ2uwyBTsTVKVBD11vMhzzEPPAevHCI569Onq4Nh0611IGsRTeTcBPdg4t+J44xMolpmcgvUQ8LJQwsZGx9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwRof7wL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717665292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TyzarcjBrMym8T5g/oNt6NbYvJXKvgmRE0aRSsJwYIE=;
	b=hwRof7wLFzv6fUatrKqvphe/Bc9wzsmSaCd05FZh4xTTiPwQNReH5+FmJgWI3dfxG+8Auq
	O7y19j38QeyYacxj3s/4DnXqcNFX5Sp73YtklkCY40k8tDBTzmicgqPLXT2BS1xs0SBvlb
	j+LvYXJw92IELLexyd30i1Lj9CF2LAQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-usnmEp15PTS_uXviE7t8hA-1; Thu, 06 Jun 2024 05:14:51 -0400
X-MC-Unique: usnmEp15PTS_uXviE7t8hA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dc02bfc28so114019f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 02:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665290; x=1718270090;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyzarcjBrMym8T5g/oNt6NbYvJXKvgmRE0aRSsJwYIE=;
        b=vXolWto97/pMuMbi0Lg3TTQwhEan/EV80aj7MEJDS01zsCGO3hKP7sLO/AC2xgGeix
         ghavu1CtdAnifMR2T5vv4ZT/0OHNJbAQgHJbOAAxAIdtqqKT7JMjk9U2MsmEu9GuD8Mj
         jZjPT+/SnvY0dLhcDx20rAlkJWSM642ImZKv3d1qejzBl/eaOmbhB1hNwpSQ9ghmU0el
         z1A93tQhwC0OVUqnRypRtiaz4X2nwqEMh/4MD2SRUSNLr0gSjpPJyngtDlDnb789muKt
         2aVJe+rsT5XaKuMZ5rO16sIISawqmq0OLDE/4QYsHR2Jv07yHPgdHSq1NWF7L2eVaV/a
         FxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ4E0okgNiMu6SB1byQLzTguGwcQ/jtB67P9+l0RJAyDPkuRBCJUI6510brSOxUa/kch4CeVeOdiA4e96OGo88jnzhgp7
X-Gm-Message-State: AOJu0YxlOb+855mSW9Dj2dw+ZG+8DuQFwRz6SIZXyQWKRizDOaE46xP9
	MU7KSPaFmulPMFqCxBpABiO01Fz2f1ZGdRvI0Da7R03MukF37oHtzztmZtGcqMzsW+iQnX/BBQ6
	joWMg9pKVU4ProYx24pR96otaio21qV+7l0u+YCNNy+oN09QOY/ZpPg==
X-Received: by 2002:a05:600c:510d:b0:421:2918:3d9a with SMTP id 5b1f17b1804b1-42156256c0amr37534285e9.0.1717665289890;
        Thu, 06 Jun 2024 02:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELALRqXA1KnT0Cx8Ui3MGNZcOF6JzRYyDJxYryd79btPU47iE9AH9YALYa4dTMczErzqzv5A==
X-Received: by 2002:a05:600c:510d:b0:421:2918:3d9a with SMTP id 5b1f17b1804b1-42156256c0amr37534075e9.0.1717665289504;
        Thu, 06 Jun 2024 02:14:49 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f6c0sm48320855e9.46.2024.06.06.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:14:49 -0700 (PDT)
Message-ID: <8b5e1ffe0bc5a9e03c622166f4d5d26c5c6ce9b5.camel@redhat.com>
Subject: Re: [PATCH net-next v14 07/14] net: Add struct
 kernel_ethtool_ts_info
From: Paolo Abeni <pabeni@redhat.com>
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,  Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
  Alexandra Winter <wintera@linux.ibm.com>
Date: Thu, 06 Jun 2024 11:14:47 +0200
In-Reply-To: <20240604-feature_ptp_netnext-v14-7-77b6f6efea40@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
	 <20240604-feature_ptp_netnext-v14-7-77b6f6efea40@bootlin.com>
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

On Tue, 2024-06-04 at 12:39 +0200, Kory Maincent wrote:
> @@ -2443,13 +2444,20 @@ static int ethtool_get_dump_data(struct net_devic=
e *dev,
> =20
>  static int ethtool_get_ts_info(struct net_device *dev, void __user *user=
addr)
>  {
> +	struct kernel_ethtool_ts_info kernel_info;
>  	struct ethtool_ts_info info;
>  	int err;
> =20
> -	err =3D __ethtool_get_ts_info(dev, &info);
> +	err =3D __ethtool_get_ts_info(dev, &kernel_info);
>  	if (err)
>  		return err;
> =20
> +	info.cmd =3D kernel_info.cmd;
> +	info.so_timestamping =3D kernel_info.so_timestamping;
> +	info.phc_index =3D kernel_info.phc_index;
> +	info.tx_types =3D kernel_info.tx_types;
> +	info.rx_filters =3D kernel_info.rx_filters;

It looks like 'info' is not zeroed anymore...

> +
>  	if (copy_to_user(useraddr, &info, sizeof(info)))
>  		return -EFAULT;

... so this risk exposing to user-space unintialized kernel memory

Cheers,

Paolo


