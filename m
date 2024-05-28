Return-Path: <netdev+bounces-98580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034C8D1D32
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2B7284097
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761816C68B;
	Tue, 28 May 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xwm/dPkF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3A131E3C
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903396; cv=none; b=qYgtf4PPwEG6BPHjEcOjRxv5Sf+bLMdT09GEEgO1L0TxjIXnSm/QagiC7cd9zgmDR6k4WRXv7sgG+Yapacb2KK2EGM5XCxng8ZFirTEvrfarHmiPlzsHuf+kBL8YYKF/piUFcSz7RWNRH67TYw/gixxDSlqZsCG1n/o7NPiF2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903396; c=relaxed/simple;
	bh=yWo20dzYvDi7ZiIY1e+59W1PhblN0WsdSBxs0aYAtmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kDrE/mVYJOa7uYd6rm+/q3OYX5GDF+SbZPoJLJI/Ilt7Ol128ZsDSYgOLlPeaSeV5coh6aglqkL6CErKY6KaYqPI0yInWMXLM50HnHDfYmrml2a3zqsipuX6tPpwbGj0ZHF4RayiCJ0WMtwzsZ1KZ/QGnHy3+HJ8zVuqn7MQWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xwm/dPkF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716903394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uP6toEwxY3sPx/XTsu40NEy3MSjBWj1SPFZTpLoAKBc=;
	b=Xwm/dPkFwKckb7kI51dmk5N0opCsf8HQa2YAFg6gxF5ymEFc9Otjb/cbpGKEJPRibA0+fl
	U+y2o6SEMDvY51wGRO5ONUb4EhJ74dIJ7498Nn6i1+HlWQQ3k0MqC2n1Yj7f+AJZ0bLuNa
	CGMlDCTwUhCOa8h8v2eaqM5aLSryDdo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-izXswwvNOjmde_SWxf1iwQ-1; Tue, 28 May 2024 09:36:32 -0400
X-MC-Unique: izXswwvNOjmde_SWxf1iwQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-529a07da6c9so123238e87.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903391; x=1717508191;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP6toEwxY3sPx/XTsu40NEy3MSjBWj1SPFZTpLoAKBc=;
        b=dTiqBVpKxTze4PYLzhee42o0NBxL9r77/I2eRVgQxtrLN0klK/3DOFiUlFQFT/7TGh
         QsyshQIJLXLmHoYGguLSNrfG+M+ReFXc3lL1Mm5uVilfvw9pncWeGQu/n4HDPsAQourI
         vOhQN7UOUkP/msejydat+0OwGaDDn9ij6XJ96J0hHnzdNCLY363QV6eSsp7CyJr85WhU
         22txA8o+vNVoB5Z7GA1Fd1/1af5e9mFfZhytVKiT9s4mQmO3sLhD626SsdZnMiI2R08e
         DoWdnPVZs58Khh/2FG8TwTiC1+4VIcb/g3cQ/aEVCANTh7egtWFefotmV7i2xuugs4oI
         IMEw==
X-Forwarded-Encrypted: i=1; AJvYcCV1co8yxoraftrIxOrW9uF+9vhkvG8PDeLR3YkJTh8qpO2bANPnZ25YxjovaJk1QwRR6I7EScf5m0eEhJ4i2saZwUiwaVZ7
X-Gm-Message-State: AOJu0Yw7V1zh0QqXxCZKUSVxeA3+TygBh1XbmSEVMDvHCDNbG794Y8cI
	NfJmnEA0+LHCb+pNMD/YWS3X3WM0DuXIU2XKuqf6CZtJkAEiHDqVermtweDDgfFr9R09F700fwW
	al8Tq6Ev4Co2KggOqsY4CzfTsrbN2MQGcvcVWqwLPQpd/B4GRpPZAPw==
X-Received: by 2002:a2e:874b:0:b0:2e9:8197:eca1 with SMTP id 38308e7fff4ca-2e98197ede1mr30600151fa.5.1716903391188;
        Tue, 28 May 2024 06:36:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnJeorTaJbN57wTNY5Jb8i3ycecq6eU1vWkaDHMPSgYis8QLaJYXZQ28DT0NxuvhWSYiBmg==
X-Received: by 2002:a2e:874b:0:b0:2e9:8197:eca1 with SMTP id 38308e7fff4ca-2e98197ede1mr30599871fa.5.1716903390623;
        Tue, 28 May 2024 06:36:30 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fb8f4asm175075685e9.41.2024.05.28.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:36:30 -0700 (PDT)
Message-ID: <6f596a8bf3f0ff2c498e7b6cf922fa28bd0dbef4.camel@redhat.com>
Subject: Re: [PATCH net] net: smc91x: Remove commented out code
From: Paolo Abeni <pabeni@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, Nicolas Pitre
 <nico@fluxnic.net>,  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 28 May 2024 15:36:28 +0200
In-Reply-To: <20240527105557.266833-2-thorsten.blum@toblux.com>
References: <20240527105557.266833-2-thorsten.blum@toblux.com>
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

Hi,

On Mon, 2024-05-27 at 12:55 +0200, Thorsten Blum wrote:
> Remove commented out code
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  drivers/net/ethernet/smsc/smc91x.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/sm=
sc/smc91x.c
> index 78ff3af7911a..907498848028 100644
> --- a/drivers/net/ethernet/smsc/smc91x.c
> +++ b/drivers/net/ethernet/smsc/smc91x.c
> @@ -1574,12 +1574,8 @@ smc_ethtool_set_link_ksettings(struct net_device *=
dev,
>  		    (cmd->base.port !=3D PORT_TP && cmd->base.port !=3D PORT_AUI))
>  			return -EINVAL;
> =20
> -//		lp->port =3D cmd->base.port;
>  		lp->ctl_rfduplx =3D cmd->base.duplex =3D=3D DUPLEX_FULL;
> =20
> -//		if (netif_running(dev))
> -//			smc_set_port(dev);
> -
>  		ret =3D 0;
>  	}
> =20
This is net-next material, please re-submit targeting the correct tree
in the subj prefix.

Thanks

Paolo


