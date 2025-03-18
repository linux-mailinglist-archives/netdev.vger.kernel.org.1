Return-Path: <netdev+bounces-175781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E4A67777
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72EE17EF09
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE320F063;
	Tue, 18 Mar 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8F8yrZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAAC2C8;
	Tue, 18 Mar 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310948; cv=none; b=et+XncyHZz9mcsg2ey9CRbjB9TxersbgH/POxAJxASuWKFjnKzoO3P3EQlY1TI8mlzs6x850S5tJq1+CJazBxvmkwy+/KGRZoTjx8px/1kIxMnv6BnXPT+P693RIOzUOGblNPhnlXXLozeBE/sOU+PUIMbh9jevWGnwwys0j9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310948; c=relaxed/simple;
	bh=MTvGD/HLFcaWAg3V8FM8ucXkDq1L3xRV98aw/ozj9gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohpakS2G7VnjJ/BaKGfj1Or1oG4BVsczWa+BGEqHd83T8i50io1qLkXyxT5R1Qg9U6IH5qV42XZLqBQBJCWSDnnNfXh+qiQ4AA3A6fUwO5k/BeXjihwrpCRlaw4WDgiNAKIdHFDdN5a/6V+CdSKJf0h5Musw1tVn7WazM3f6lYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8F8yrZW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43935d1321aso2212635e9.1;
        Tue, 18 Mar 2025 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742310945; x=1742915745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfsZ4Hr0wmB5sa2cUchGQZzT0be/9tuArc+VqsT04RU=;
        b=T8F8yrZWlGt8n0Pv+/I6dhtw5AEyFPghYBLTyCc2iZxZVTIIw+ZkuZvwC+34rpSl0k
         Fsms1Velu/3zFxlBm8EWZRc4rWyuUrjCMcnB1aNjk4dQwKJqfJEW9jmB7g9BaOtezjCr
         Bn/iYMtfNwkHHw9jZjOUCCE0n+W22gE8/HAklA93Dh3Tjd7pdhoSMdfQ6q4tdGM4Cj+4
         rsJV5AfNeALjH+gWDGOlzIeGxdh8BmbuJVFfMlt1vE++USknXO0suJKS80dDBOpb3apj
         w8WasNtg1/MgAFnZAFPNXrU9uX7p4bfNz3UBelI9sPjWBGPSwx0NZgiG4vI5wGvFCjFv
         SgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310945; x=1742915745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfsZ4Hr0wmB5sa2cUchGQZzT0be/9tuArc+VqsT04RU=;
        b=K3O7uEdpy5astgN1JrLVahn40se13WFLC9NR4KDKBRSxxlGwlqQrk3NqcYevdpWRxa
         zrUrPKy/FvUNJqmWSnk0gzMSTI8PPZWjwP5ZjeVBj6efheUFax6LjPG2u+wJlRD+FNQ5
         y2h7i1V0cE1KWyJvLmEEZDpMZcnXYUrra78rxVd1qwOlSj+V9hYDF1PcBq7CllezUO7p
         PQI+yqNREXw1M6lG3IM2GDG+64ZT+/a+vfgUqs9zeYEvyC+1e6u5rNtStck6oOU3vchM
         fwtipjnd8fTHGEBghpB5KtVTiwRMVmBNoCf8ZooWEX6I/AmnipM1q4WAUlY0wu6w28j/
         jEhw==
X-Forwarded-Encrypted: i=1; AJvYcCVCFWynPY7ZHVFCCqzOFXkw0+W+iTkOu5XSCWF4IxGUnQ6XmXt3eIooelOOOBQXwcsholLxLgHahp7P@vger.kernel.org, AJvYcCWchxhdvxO/SfWa/HwxW5J9DoeCg9Cnulz2+i9p3Q+0JQX8H8n/MHcxzje+4LFKiKMPFnEIs0Pq@vger.kernel.org, AJvYcCWk1c7BzTYWncytSYIT6ilriKN8R9Uc6SgVapDdBD2OkEKafAVQtyDNRYwsco8q9DUnXP97Bsn6Ziq0VP4U@vger.kernel.org
X-Gm-Message-State: AOJu0YwOymsPWlxJ06ISrXwtuUZC906mKLhpPp0sPuUojvZYfD2ANZyW
	f8OV1yeIBG+7FsSHtZnBeaP9kzQUpoL0qQjl+rJmvMJPIhW7Yt5F
X-Gm-Gg: ASbGncvZDI2SWmcdZT9sKzqou9WJaDr5VYwiwHMqVqPyLDsgisRSZoweMau3FE93IHR
	XahGanv1/5NsIncmmzADuDu4wu0kbHQmFNaM+b3MmlUWY4ENBRAtveFs3QXqgKML/Grc76V5GqG
	UUrLcZXDYYV9BFK6Toohlc4iBJllN8FhgvGcpjgWONnN2kLiDzH+YBdbZyPn0a+pJL9SOF/9lcL
	DgUzMWIfRE40NLvgjTv6ann3DGsAOBNfje7Ymnp5iCl8kPzk7McIRBiMKq2MF+wv3VbEkbU90dh
	vSAK5dSB2pLtCs7JMN8hAT4l0WwcmQg+
X-Google-Smtp-Source: AGHT+IFoFkrvmKX6oudoUNLDCMY8f1EeKRpKsVXrfH4lPyc9AssKZHYKJOieMoARGtgxMGgZdLntEA==
X-Received: by 2002:a5d:59a9:0:b0:382:4e71:1a12 with SMTP id ffacd0b85a97d-3971d239c31mr6323034f8f.1.1742310944949;
        Tue, 18 Mar 2025 08:15:44 -0700 (PDT)
Received: from skbuf ([86.127.125.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2bb5f987sm82930845e9.24.2025.03.18.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:15:43 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:15:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v13 13/14] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20250318151540.4rmw6jj5hh2rp4b4@skbuf>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-14-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315154407.26304-14-ansuelsmth@gmail.com>

On Sat, Mar 15, 2025 at 04:43:53PM +0100, Christian Marangi wrote:
> +/* Similar to MT7530 also trap link local frame and special frame to CPU */
> +static int an8855_trap_special_frames(struct an8855_priv *priv)
> +{
> +	int ret;
> +
> +	/* Trap BPDUs to the CPU port(s) and egress them
> +	 * VLAN-untagged.
> +	 */
> +	ret = regmap_update_bits(priv->regmap, AN8855_BPC,
> +				 AN8855_BPDU_BPDU_FR | AN8855_BPDU_EG_TAG |
> +				 AN8855_BPDU_PORT_FW,
> +				 AN8855_BPDU_BPDU_FR |
> +				 FIELD_PREP(AN8855_BPDU_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> +				 FIELD_PREP(AN8855_BPDU_PORT_FW, AN8855_BPDU_CPU_ONLY));
> +	if (ret)
> +		return ret;
> +
> +	/* Trap 802.1X PAE frames to the CPU port(s) and egress them
> +	 * VLAN-untagged.
> +	 */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PAC,
> +				 AN8855_PAE_BPDU_FR | AN8855_PAE_EG_TAG |
> +				 AN8855_PAE_PORT_FW,
> +				 AN8855_PAE_BPDU_FR |
> +				 FIELD_PREP(AN8855_PAE_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> +				 FIELD_PREP(AN8855_PAE_PORT_FW, AN8855_BPDU_CPU_ONLY));
> +	if (ret)
> +		return ret;
> +
> +	/* Trap frames with :01 MAC DAs to the CPU port(s) and egress
> +	 * them VLAN-untagged.
> +	 */
> +	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
> +				 AN8855_R01_BPDU_FR | AN8855_R01_EG_TAG |
> +				 AN8855_R01_PORT_FW,
> +				 AN8855_R01_BPDU_FR |
> +				 FIELD_PREP(AN8855_R01_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> +				 FIELD_PREP(AN8855_R01_PORT_FW, AN8855_BPDU_CPU_ONLY));
> +	if (ret)
> +		return ret;
> +
> +	/* Trap frames with :02 MAC DAs to the CPU port(s) and egress
> +	 * them VLAN-untagged.
> +	 */
> +	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
> +				 AN8855_R02_BPDU_FR | AN8855_R02_EG_TAG |
> +				 AN8855_R02_PORT_FW,
> +				 AN8855_R02_BPDU_FR |
> +				 FIELD_PREP(AN8855_R02_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> +				 FIELD_PREP(AN8855_R02_PORT_FW, AN8855_BPDU_CPU_ONLY));
> +	if (ret)
> +		return ret;
> +
> +	/* Trap frames with :03 MAC DAs to the CPU port(s) and egress
> +	 * them VLAN-untagged.
> +	 */
> +	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
> +				 AN8855_R03_BPDU_FR | AN8855_R03_EG_TAG |
> +				 AN8855_R03_PORT_FW,
> +				 AN8855_R03_BPDU_FR |
> +				 FIELD_PREP(AN8855_R03_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> +				 FIELD_PREP(AN8855_R03_PORT_FW, AN8855_BPDU_CPU_ONLY));
> +	if (ret)
> +		return ret;
> +
> +	/* Trap frames with :0E MAC DAs to the CPU port(s) and egress
> +	 * them VLAN-untagged.
> +	 */
> +	return regmap_update_bits(priv->regmap, AN8855_RGAC1,
> +				  AN8855_R0E_BPDU_FR | AN8855_R0E_EG_TAG |
> +				  AN8855_R0E_PORT_FW,
> +				  AN8855_R0E_BPDU_FR |
> +				  FIELD_PREP(AN8855_R0E_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> +				  FIELD_PREP(AN8855_R0E_PORT_FW, AN8855_BPDU_CPU_ONLY));
> +}

Is there a way in which you could group the registers a bit more?
The function occupies 2 screens :-/

There are 4 read-modify-write operations in succession to the RGAC1
register. Maybe you can converge them into a single regmap_update_bits()
call.

Also, for packets which reach the CPU via a trap, we shouldn't set
skb->offload_fwd_mark = 1. In other words, if the bridge layer wants to
forward them in software (including to other an8855 ports), let it do so.
The common example given in commit 515853ccecc6 ("bridge: allow
forwarding some link local frames") is 802.1X PAE (01-80-C2-00-00-03).

I notice mtk_tag_rcv() calls dsa_default_offload_fwd_mark() with no
pre-condition. Do you know whether there exists any bit in the RX tag
which signifies whether the packet was received because of a trap
(or if it was autonomously forwarded by the switch to the other bridge
ports as well)? The offload_fwd_mark bit should be set based on
something like that.

