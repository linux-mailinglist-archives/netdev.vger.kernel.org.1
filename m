Return-Path: <netdev+bounces-293618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KaZHS1JHWo2YgkAu9opvQ
	(envelope-from <netdev+bounces-293618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB361BE07
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1A343080BAE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA1368D59;
	Mon,  1 Jun 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/3ZTrOm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OascCDqA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE536728D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303771; cv=none; b=kTU19XPU05cJN25INYl+ly41OeNDKXyOIHUlEJOmr+yaT2mG+mj0RG6nWXJmTzWt1j+8fCaz5q6xM0kCKUY0bvnAz6+IMzYv3kS9ycYafq4S3W0AbraoxMxBXZn6IIIp9amu32gYynVq/64dLrDRPXO6i9p/mdS+99aeRwuNXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303771; c=relaxed/simple;
	bh=1RlI5AhCmHo7BEj9zECMfeUbl8CC+sqg162hxB0Z3+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+jhLYz3Jsz7/Y0LH0uAMeDKdLsxKbFgzCPlsM8UaRaF6XhDDyncOpoHN56dwBteapPTaOgk8/glugQvbt5cV56yggMKYh95ipTC6iG3gzjXrsVKr1a8WSGe8R81RnMIiG8dMgfRO7E6ZLRpfAnOLNXjHFjXUxonX6XIM9rUshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/3ZTrOm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OascCDqA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780303768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVP9ss4Lb/3al8YG7gU0T5fKPpgIsgOFPUND3RQKGAw=;
	b=S/3ZTrOm/KlaHZXiOR2kNbSfuJLkFhmIN/rFov5mVacFcioGNjkU8ud2YOj3xb+MAkUiCy
	iy5wGoepWhjJxkaF+QZc0Cgu+F1mROj7NB+EzPcPS3WsOX8oRYTI9e/pG3uwai96EaGYCM
	UBRvn13vUzNMTRAq9RXEUvtcrNmDZmQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-EKaWP6KgPo-TmJAOyw4NjQ-1; Mon, 01 Jun 2026 04:49:27 -0400
X-MC-Unique: EKaWP6KgPo-TmJAOyw4NjQ-1
X-Mimecast-MFC-AGG-ID: EKaWP6KgPo-TmJAOyw4NjQ_1780303767
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eec2ba533so2737985f8f.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780303766; x=1780908566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVP9ss4Lb/3al8YG7gU0T5fKPpgIsgOFPUND3RQKGAw=;
        b=OascCDqA7xTGCpEsFb38dqSol+0jAFN2aW1rCxLldEA8bOldlkDj3R0uPPNiIVqKHP
         0tE7Y8PuNwMtDSiw1zwhbVQUp7SQbkyChzT3jfHgy5+yRoGOjOSLD1Bpl+6CWYvL8dwt
         C4ghnOYuLG/C55v1QAoV63HxItsC2ylpf9pBNwW9Z5ePAMAjHaJPxBUhAgI63F/vPZCS
         NbwBmkai+iCmr8peUs/PFVRvhSrfTzE9MfICK3Qg8qdS3w93CLXoAY/Vo2jbDFcBHun6
         uWEn06bnTu8jZ17ZqkDL3ye8ixrddjJ4m8pXjDk0h8SWLI34d0fJ7VmOF3a6Az00KDUW
         bHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303766; x=1780908566;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVP9ss4Lb/3al8YG7gU0T5fKPpgIsgOFPUND3RQKGAw=;
        b=eyJeg3qC9PMMlTLQIs3n+nnVc/yso5pm2Yo/UrKjoucoTTTFTZdu/WwGzsBCEk1w1a
         W1Gx8KTvc6AjfgpdVk3qBPDEllNyDPYoq9zZV4hPKtnPcyKpSAU4S0eBWGmN1Gcru2RH
         I0WH9JP6NJWD0rxrw/HjPLSOSidSfVou4fCer+1zjde/dVw2LkKYxTNp/Uh/W5rdGbwY
         Kh03cb8kHuitSWF4M05aFuTPC7Oo9IQ2ggahwzyV80EzMFVq/iCSeX2gMD1Z7yKYAqe8
         HVHU8FVohrhh1dQJmdUGjmlxRbKICH6vGu+fQhkIB6t7hV61mIeUlIpgOXnZQTI55vgM
         09eA==
X-Forwarded-Encrypted: i=1; AFNElJ/oGP/Mzmx7P/XBdIQsMrnX3j1Pwp+EBhjal4SK/8FI8OmOnPJMtgyEUpvNmvtRrC2dO6slv8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyll7ib/jNqiI1jA28SVfsOfNQMwtyLTJSUtlocJ32WIWl3IC64
	iwEVvx8dlRereU35cWAM/338BF20H0yhQSdfcZOUzg5FD/fEPGfWNXBmuoqYUjdR/dJKy51v82J
	N4be1FXdLAbSIgurXvoG4/o+a1F+Npvf0ZCW/KrENQc8nPjjKzmU0fBCDag==
X-Gm-Gg: Acq92OEgb964yI9BQnIM9SAwYC61pTrVSHzopwNXR5vPHasKCDakhQuNLw0wChFYpl6
	fBKVdxUr41FDi6c+z89x2kqd/FyXGewjapy2tZV+OZ2RiPvxvJhTzRpqIakRXv41ippkAErFV3I
	IRjVRvtuzWxesmmRSMKqxYDwVcimM2Ea99hqBEn4Eg9vFzjGaQPI06liTeoI/IYpH58zErIh1GR
	LrYVRWt8p4e27jekLtBlhfyGUEF9g600HcUDKxIeQpL0BXxqIOQQoiip/s/0DCAblVHTSmFgqIt
	j5+d/JGDmy5XYseZndHkZga9D7mUBtxey6HnqIbxpIqqM2Jx/nPvh7I8m5B31/1VZ2JrvCivLT7
	whjDqh99I0QiZ9Qq28/f6DXjp0zNkTylY0Heyz8jD2y8fRnDuRhtFgxo9FXUlOfFu/Kl5
X-Received: by 2002:a05:6000:2892:b0:43d:69ff:6898 with SMTP id ffacd0b85a97d-45ef6b00c96mr19452455f8f.9.1780303766472;
        Mon, 01 Jun 2026 01:49:26 -0700 (PDT)
X-Received: by 2002:a05:6000:2892:b0:43d:69ff:6898 with SMTP id ffacd0b85a97d-45ef6b00c96mr19452387f8f.9.1780303765977;
        Mon, 01 Jun 2026 01:49:25 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm24482157f8f.5.2026.06.01.01.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:49:25 -0700 (PDT)
Message-ID: <27937ce7-ec1c-4aab-9061-cedcf4f89d12@redhat.com>
Date: Mon, 1 Jun 2026 10:49:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] net: dsa: microchip: remove
 setup_rgmii_delay() KSZ operation
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-4-5b63e732149a@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526-clean-ksz-3rd-v1-4-5b63e732149a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293618-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14CB361BE07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
> setup_rgmii_delay() operation is only used once during the common phylink
> MAC configuration. Only the lan937x switch implements this
> setup_rgmii_delay().
> 
> Remove the setup_rgmii_delay operation from ksz_dev_ops.
> Implement a lan937x-specific phylink MAC configuration that does this
> RGMII delay setup.
> Export ksz_set_xmii since it's needed by the lan937x implementation.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c   |  6 +-----
>  drivers/net/dsa/microchip/ksz_common.h   |  2 +-
>  drivers/net/dsa/microchip/lan937x_main.c | 29 +++++++++++++++++++++++++++--
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 5fb151fbf4f3..d6511fcebcf2 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3127,8 +3127,7 @@ int ksz_set_mac_eee(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> -static void ksz_set_xmii(struct ksz_device *dev, int port,
> -			 phy_interface_t interface)
> +void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface)
>  {
>  	const u8 *bitval = dev->info->xmii_ctrl1;
>  	struct ksz_port *p = &dev->ports[port];
> @@ -3233,9 +3232,6 @@ void ksz_phylink_mac_config(struct phylink_config *config,
>  	}
>  
>  	ksz_set_xmii(dev, port, state->interface);
> -
> -	if (dev->dev_ops->setup_rgmii_delay)
> -		dev->dev_ops->setup_rgmii_delay(dev, port);
>  }
>  
>  bool ksz_get_gbit(struct ksz_device *dev, int port)
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 804912fdd2db..ab08c98ed257 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -410,7 +410,6 @@ struct ksz_dev_ops {
>  			   u8 data);
>  	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
>  	void (*port_init_cnt)(struct ksz_device *dev, int port);
> -	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
>  	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
>  	int (*init)(struct ksz_device *dev);
>  };
> @@ -468,6 +467,7 @@ void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
>  void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config);
>  int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
>  				  u32 timer, bool tx_clock_stop);
> +void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface);
>  void ksz_phylink_mac_config(struct phylink_config *config,
>  			    unsigned int mode,
>  			    const struct phylink_link_state *state);
> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
> index 57e289637193..f8f220242f7a 100644
> --- a/drivers/net/dsa/microchip/lan937x_main.c
> +++ b/drivers/net/dsa/microchip/lan937x_main.c
> @@ -643,6 +643,32 @@ static void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
>  	}
>  }
>  
> +static void lan937x_phylink_mac_config(struct phylink_config *config,
> +				       unsigned int mode,
> +				       const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct ksz_device *dev = dp->ds->priv;
> +	int port = dp->index;
> +
> +	/* Internal PHYs */
> +	if (dev->info->internal_phy[port])
> +		return;
> +
> +	/* No need to configure XMII control register when using SGMII. */
> +	if (ksz_is_sgmii_port(dev, port))
> +		return;
> +
> +	if (phylink_autoneg_inband(mode)) {
> +		dev_err(dev->dev, "In-band AN not supported!\n");
> +		return;
> +	}
> +
> +	ksz_set_xmii(dev, port, state->interface);
> +
> +	lan937x_setup_rgmii_delay(dev, port);

I think you can avoid some code duplication with something alike the
following:

- factor out of ksz_phylink_mac_config() a  __ksz_phylink_mac_config(),
helper, with the latter doing all the work and returning true when
actually calling ksz_set_xmii()

- implement lan937x_phylink_mac_config() on top of
__ksz_phylink_mac_config():

	if (__ksz_phylink_mac_config())
		lan937x_setup_rgmii_delay(dev, port);

/P


