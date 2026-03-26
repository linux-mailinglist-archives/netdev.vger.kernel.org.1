Return-Path: <netdev+bounces-271961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GxVIzkGxWnZ5gQAu9opvQ
	(envelope-from <netdev+bounces-271961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:11:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28D333082
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED5BB319ACEB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E63C7E0E;
	Thu, 26 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzVKWeSV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsuhscY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E33C7E15
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519107; cv=none; b=Ugwjy7cwSvXJdzEpsNhGEt15ydRDePPNtrBntWy1PN1J2wcxzCcqjJPjHMiz/FN11d2B0BAb2umj7HXfuq/bvTEBxKGtq4fE6YKoXSazYUz/28WrLwNxkTErU76Ct01+Jv4Sim2jgVP4jkJLZ3Yf1e8K6CblVvch/OB0EHJ7S2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519107; c=relaxed/simple;
	bh=Kd9nV26ZL3EfcjAmrbwca/U9g3js3Zp8Qfl8G8M/fpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+rxtJOvgZU3oV3qIV1LSqfrygVvckJOPbAW10sh0WYzGVMR7DDEIwg+2xpJtu/psOIWmjrnmcZgDaLrhhENPT4v7N90bCilyJCc2QDs4vqBwK8GNuBHDxKE3jb2YUie+EeJ2saq+DfOEyQiay3MS8mtlUYX3i7jn/ixAuQwLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzVKWeSV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsuhscY0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774519099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfSsmA6/5blQF6q3DGd5Zw/eyjxARekst8GL7QZ0MtI=;
	b=PzVKWeSV0Wnd+D5SJMaV6IrSSVvSoosBMUxeswoS4LkPlsWd0Fj/JoCiKXxDVKzGa8FLIx
	bKo9FT+v2lOYvc62GfD/+4rt8mGYL11nAOLUo+IQtDqZWyaqGqaOfqrpscaW9xbfcUS1zD
	iYvy8SfkpgbRtQ+W2NXEZREFvs05s9c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-j8GGMPrmNq-Fz7OahEpYpA-1; Thu, 26 Mar 2026 05:58:18 -0400
X-MC-Unique: j8GGMPrmNq-Fz7OahEpYpA-1
X-Mimecast-MFC-AGG-ID: j8GGMPrmNq-Fz7OahEpYpA_1774519097
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso15953835e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774519097; x=1775123897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfSsmA6/5blQF6q3DGd5Zw/eyjxARekst8GL7QZ0MtI=;
        b=PsuhscY0ojlP3Yr7iT0qvnZxX9OnGMtZwnAaUI3Tw9fKyEw+VCfR2v3s0m3keGIc+J
         lxzcU//M/rkF+NS0Ah7mNkX+HVW0xow7+/WUw+WQUyKxfJ+CSJF6zimE0I4UWcad94Au
         K+XgK/aguXPCEEA2HL/DqtYG8KAxLU+Tn+zu5dhekBY1cu+nxanPOE35Wyz9SHqJz7Bc
         VROUNOsUC/w3XK39YgRbvnqOd6iRFneZyJ2/KM9QcvWUo1z5XZy+b/TKAoX0juclH2a/
         AuBNTI6zWOtAdU/UhGL3ny9iPCOFxfATS3J/64nKZHkzPbh8wbH6i8yfpgqjdx/+MV38
         a/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519097; x=1775123897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfSsmA6/5blQF6q3DGd5Zw/eyjxARekst8GL7QZ0MtI=;
        b=hTElDA2hlslZdvkANoxGkN8VNtiF3j6gra/58TubQIEuBU/bCwkVXVZ/GiOztDwjko
         T/Do4VLZ8e7KYE6+WrR5+KVfNygzQTTA4LGzmsHM+w0MuCp25aXqhqvLGKLBJFZqid28
         tlfZmfuL5rMcaCiqQe23bSxDzr6RSbGJgcAXUE43n+EziNs1pTzA8+MqfFMHWhcl0ykn
         ExQn76DJBE3GAw2E1V5oXrZHPSxmJrtO5xtTlDmaFqZf8PSZD09tpIrjrKif+PVrvjHS
         o68ewDrQ49eqq/eJcg81ZCUbUMiXjtLVe++eFheIGJ0M4TJ2nqowNMW1pW5Ims397Zki
         Fa7A==
X-Gm-Message-State: AOJu0YwBKOTSu21z688HS7fXGInbAg18+URX7vk405zahOToelaU0GYx
	MKw1VkjPwIUUttJMjkxyZ6oP2m6isgNfA62zxXBRSI1fJbLVYYMz3e9aM433b0IxMLCGALn0TyN
	IhNc70Inmbah9malImgsrSiBKxiK8MiFloifoWixn9OYDEg6uL++YLqDnIw==
X-Gm-Gg: ATEYQzyB7qzeQh6dGvIhku8yrdzP1yoC8P+etZXsxGG/ygtTdLL0Ocubqj6o3Z2CvkB
	PP6eJyqHnny44IIeU5WMzQz/EC/iCkqdYhSkXyQ4eh/2ftx9vu0W/VMRqpHbSE8L0DcKuSdaOih
	3DjrYPIErfzWVj+KoxOjs3HHxMIkRdgBKEjs82QWmTec81gj2ccc9dJOElYO89C3HQdS8za9FLA
	hJE3c1SPD5ZDUleJI+mTTizDgVCuNp++kkQkL0q2QsCjCZn82NlC3Dj+L+a0ipqiY2h2q/PX5kO
	E/GWz48tB/ALLFbidy20wJzG88RGujpkXUmKnr3OwNTdvuQNdjPCcP/D2lsEjpXUfqjzkk3UF2+
	UhTPQ3SAChbWTv0YCB2kQ3ebZ7BO0KMsXTg0neTLOMQl1GryaRbc7RTVp
X-Received: by 2002:a05:600c:4447:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-48715fd50c2mr99407375e9.9.1774519096805;
        Thu, 26 Mar 2026 02:58:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4447:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-48715fd50c2mr99406985e9.9.1774519096349;
        Thu, 26 Mar 2026 02:58:16 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm26666255e9.0.2026.03.26.02.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:58:15 -0700 (PDT)
Message-ID: <834f1d4f-b749-41bb-8ae1-04d19e70ba92@redhat.com>
Date: Thu, 26 Mar 2026 10:58:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: realtek: support MDI swapping for
 RTL8226-CG
To: Jan Hoffmann <jan@3e8.eu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Markus Stockhausen <markus.stockhausen@gmx.de>,
 Damien Dejean <dam.dejean@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260322193235.990881-1-jan@3e8.eu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260322193235.990881-1-jan@3e8.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271961-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[3e8.eu,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,makrotopia.org,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,3e8.eu:email]
X-Rspamd-Queue-Id: 0F28D333082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 8:31 PM, Jan Hoffmann wrote:
> Add support for configuring swapping of MDI pairs (ABCD->DCBA) when the
> property "enet-phy-pair-order" is specified.
> 
> Unfortunately, no documentation about this feature is available, so the
> configuration involves magic values. As it is unknown whether the
> patching step can be safely reversed, only enabling MDI swapping is
> supported.

Still using human readable macros would improve readability, reduce the
change of c&p mistakes. I suggest you use chose some more explanatory
names at least for the more used values.

> Some other Realtek PHYs also support similar mechanisms:
> 
> - RTL8221B-VB-CG allows to configure MDI swapping via the same register,
>   but does not need the additional patching step. However, it is unclear
>   whether a driver implementation for that PHY is necessary, as it is
>   known to support configuration via strapping pins (which is working
>   fine at least in Zyxel XGS1210-12 rev B1).
> 
> - The patching step seems to match the one for the integrated PHYs of
>   some Realtek PCIe/USB NICs (see for example the r8152 driver).
> 
> For now, only implement this for the RTL8226-CG PHY, where it is needed
> for the switches Zyxel XGS1010-12 rev A1 and XGS1210-12 rev A1.
> 
> Signed-off-by: Jan Hoffmann <jan@3e8.eu>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 142 ++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 023e47ad605b..2472f54502bd 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1447,6 +1447,146 @@ static unsigned int rtl822x_inband_caps(struct phy_device *phydev,
>  	}
>  }
>  
> +static int rtl8226_set_mdi_swap(struct phy_device *phydev, bool swap_enable)
> +{
> +	u16 val = swap_enable ? BIT(5) : 0;
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, 0x6a21, BIT(5), val);
> +}
> +
> +static int rtl8226_patch_mdi_swap(struct phy_device *phydev)
> +{
> +	u16 values[4];
> +	int ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xd068);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(ret & BIT(1))) {
> +		/* already swapped */
> +		return 0;
> +	}
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x7, 0x1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* swap adccal_offset */
> +
> +	for (int i = 0; i < 4; i++) {
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x3 << 3, i << 3);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xd06a);
> +		if (ret < 0)
> +			return ret;
> +
> +		values[i] = ret;
> +	}
> +
> +	for (int i = 0; i < 4; i++) {
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x3 << 3, i << 3);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, 0xd06a, values[3 - i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* swap rg_lpf_cap_xg */
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xbd5a);
> +	if (ret < 0)
> +		return ret;
> +
> +	values[0] = ret & 0x1f;
> +	values[1] = (ret >> 8) & 0x1f;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xbd5c);
> +	if (ret < 0)
> +		return ret;
> +
> +	values[2] = ret & 0x1f;
> +	values[3] = (ret >> 8) & 0x1f;
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xbd5a, 0x1f1f,
> +			     values[3] | (values[2] << 8));

It looks like there are a few FIELD_GET/FIELD_PREP use cases above
(which will work better together with define for relevant values).

/P


