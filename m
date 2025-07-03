Return-Path: <netdev+bounces-203728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A010EAF6E47
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF883B6C69
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF32D5400;
	Thu,  3 Jul 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJW2Pkmq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7322D4B5B
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534039; cv=none; b=e1HYVVyJvNUYI7S58zD8Klz6uD3tFuqN6ia7nu9VlioGkxHCBEZJrgKnUQsQbOe1gW9OW7ozcG5kH11f6FJiQKambdKgVj4KyoSAB02FZYP1pGt2bY51HOP4jYSo9tkWmEYHwKWh2sHQMMyOkl7fvSONlZtHQXlyap3a3PFh/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534039; c=relaxed/simple;
	bh=2FJhwqOSUxIoDeCZEeXY6Q3vz2o4+XeHIQYBwmnKTZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q7isqInFXLw8RxDgnC72byEHii6w8vBfwWYhNkvH4OR3wJ2csS4Bvqov6G+UDk8VUtu0YIYwFgo0uxjrd2YD68oSURVV64hLzJR4bSGvHC5aRyTa9wReFizjeTiLlKp/bEjbKPeiiU2JRJzBkP/8bDgv6U3tg8xrE1VBPGThc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJW2Pkmq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OX+ytT49dmTr2vEb7Cm18JPywxCOwr2HkRwXRlWUGbI=;
	b=QJW2PkmqaP84UPLzaA3QUS26StljkWlITdbxiIzx/bhRwAoDLToJ8J/U0JfJnoRIsJ2TGw
	lKBkc8h1VvE/EReDIKvCH/GtB9XugFMKwhOls0X0CoqnTEKtwKTDuo3+cMU6sKzUlYqJsf
	nSmFZO9g0uM3fVT5lTOvgYmoVdjFszQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-JB7CbwQ-MimANipbNrRqkw-1; Thu, 03 Jul 2025 05:13:54 -0400
X-MC-Unique: JB7CbwQ-MimANipbNrRqkw-1
X-Mimecast-MFC-AGG-ID: JB7CbwQ-MimANipbNrRqkw_1751534033
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so3850334f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 02:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534033; x=1752138833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OX+ytT49dmTr2vEb7Cm18JPywxCOwr2HkRwXRlWUGbI=;
        b=CswN7Ic2ND/7Kn4xJph/F99DPdLx7PjtjfiIlbn0xflqNljCD4G/lLLLNQdX0kLsvJ
         Y7fNhwcHy0XtbR4cyA2B9XAOOLW5b1espmPW+ihSyMwDIBjCV4CKZpOIQOOtrkxlXnbC
         rx2gPHUWLV+5iV08LevFBfTz0enlvxmIe0twx5zUr8ViHY8kbEH0b2FM1ENOJexQCML4
         QsgJgXvh6VXR+2v9w0YYvvnCTP2b9IaZIBzinbriJmlu7uAFj0nPY45SBfIQeatZqcaD
         bQqUgxYqMmxOAtuwfJUKMNc5RSs6YNZrIPf1KAIr7O/15LNpsc/WnXEy/V4tc/AZ7mrl
         9h9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMdD6iAEbdQa9/4tNVy2OOIxLbblFngNNcX62THe44IIw7LwcxzVQsYEA7QOdq8GtBwEWB57U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKV1CRBzB0gvDMhGI4uU639wXU032JXOTBUdiSMWHJuKKj5p1
	KJHbyNppZpj/8aaEFEVFXzj6E6QSMHS05MaPshRshqeJALugT8e2UA1i+VsMjf3pfccapEXCWGX
	0jr8WiJcsSTEM7I7y106QBsBmrPpur+58hx9I+SqDsxVGU6GJqILt0r1hHQ==
X-Gm-Gg: ASbGnct2FqI68Y8TdTuMVvwo6Fg+3i8DRfEwPZc+ca1rgKRn+xS+Xix/pUlyuLKCUhN
	2kxfNGeAvAEpr5i4kgWcMMyO2phelPGczV2b5rQJ2B49iNqWReyLm8e9mWl9KsNpOCDQTVujFwt
	OUrtPSQYxkqiCXvfnephJxu2Ksh0Axnu/O/gKmg/Ik3X+1rlPGaeCSieTTLQBA32asTqUmzyVVF
	wUupatxiFy2XyKE28QCn0MV496Ojc26cYkF1G030F81hWjLX8fuVTmpHW+uVv2YdcGt0VXOm9cw
	btgc8oWlLttZJLuXwpbvFzOpnjzH2EV7IZP4jS4drgMYJa2MCdSknmy85wAFBzqvwWA=
X-Received: by 2002:a05:6000:2387:b0:3a5:42:b17b with SMTP id ffacd0b85a97d-3b1ff9f58e5mr4716221f8f.29.1751534033044;
        Thu, 03 Jul 2025 02:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRRb+VUMKb5MUe0c9M+TZj8qdoFSn94nolph8HCnGsExIYZmC8zGq2a+/0WeZeN91ewkS2ow==
X-Received: by 2002:a05:6000:2387:b0:3a5:42:b17b with SMTP id ffacd0b85a97d-3b1ff9f58e5mr4716188f8f.29.1751534032529;
        Thu, 03 Jul 2025 02:13:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e529c5sm18486218f8f.63.2025.07.03.02.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 02:13:52 -0700 (PDT)
Message-ID: <0547d8fd-e6ee-4f59-8a7e-93d2d11cdf5e@redhat.com>
Date: Thu, 3 Jul 2025 11:13:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
To: Piotr Kubik <piotr.kubik@adtran.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
 <4e55abda-ba02-4bc9-86e6-97c08e4e4a2d@adtran.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4e55abda-ba02-4bc9-86e6-97c08e4e4a2d@adtran.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 4:57 PM, Piotr Kubik wrote:
> +static inline void si3474_get_channels(struct si3474_priv *priv, int id,
> +				       u8 *chan0, u8 *chan1)
> +{

Please don't use 'static inline' in c files. 'static' would do and will
let the compiler do the better choice.

> +	*chan0 = priv->pi[id].chan[0];
> +	*chan1 = priv->pi[id].chan[1];
> +}
> +
> +static inline struct i2c_client *si3474_get_chan_client(struct si3474_priv *priv,
> +							u8 chan)

Same as above.

[...]
> +static int si3474_pi_enable(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	u8 chan0, chan1;
> +	u8 val = 0;
> +	s32 ret;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client = si3474_get_chan_client(priv, chan0);
> +
> +	/* Release PI from shutdown */
> +	ret = i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (u8)ret;
> +	val |= CHAN_MASK(chan0);
> +	val |= CHAN_MASK(chan1);
> +
> +	ret = i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* DETECT_CLASS_ENABLE must be set when using AUTO mode,
> +	 * otherwise PI does not power up - datasheet section 2.10.2
> +	 */
> +	val = (CHAN_BIT(chan0) | CHAN_UPPER_BIT(chan0) |
> +	       CHAN_BIT(chan1) | CHAN_UPPER_BIT(chan1));

Minor nit: brackets not needed above.

> +	ret = i2c_smbus_write_byte_data(client, DETECT_CLASS_ENABLE_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	u8 chan0, chan1;
> +	u8 val = 0;
> +	s32 ret;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client = si3474_get_chan_client(priv, chan0);
> +
> +	/* Set PI in shutdown mode */
> +	ret = i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (u8)ret;
> +	val &= ~(CHAN_MASK(chan0));
> +	val &= ~(CHAN_MASK(chan1));

Brackets not needed here, too and adding them makes the code IMHO less
readable.

> +
> +	ret = i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_get_chan_current(struct si3474_priv *priv, u8 chan)
> +{
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 reg;
> +	u64 tmp_64;

Please respect the reverse christmass tree order in variable
declaration, here and elsewhere.

/P


