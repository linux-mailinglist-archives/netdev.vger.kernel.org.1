Return-Path: <netdev+bounces-180095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293EA7F911
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F40816FA20
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724B264A85;
	Tue,  8 Apr 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr6Ho6Oq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBD21ADC4;
	Tue,  8 Apr 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103618; cv=none; b=ei6zsPOnc9rIWLtMHlidTMzbeSk8G7+EetbwgpPOcO48kHnXq/qCZ5OV35FK3SJn6bLIBcuT+K87KWaosUdMEJdAMbkAgcZUbSKlG3FbYyJDmjZtAxEETdbP2x3G+bCJxpZvZQYSXLAoYbsl7Zvm6CFQJGDUc8JayEbIZ51Jg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103618; c=relaxed/simple;
	bh=lX374fK7hl8i0okOxSeURBAL+h/slCG4NEZH1QURphg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQifCV0MZ9A53Sgy50ZarN6zh954JTO0Yb44U9HvHHXL9dG/tNNNmATkG3v4YgfWyG92WkT9nYE7YyQM+RDt49495oNEsZRsf+QyGM1hCZYbkok4STtl8MXQCQ/O2fiVHC1kTqjJ2tSPSRzrKOk24a05zSXTK9bg9myD1TLEhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr6Ho6Oq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913b539aabso3082577f8f.2;
        Tue, 08 Apr 2025 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744103615; x=1744708415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HU3jlfHL29/51vRr+ClhtWxfhwAXBGkQarZA/yxGO2g=;
        b=mr6Ho6Oqs9HEtEHWngAfA6l8rUC5KVjd7alUG+aMC9r3CDjPV1esuFHbDnY6zSllvq
         yVBwnNaV0LFwqWR8cKFGAXxlRm6CKowYV+DCKph5AFqD+m63pcMgjDOdYiN8PLKjCU08
         UP9siElT+3BD6J+zv0LugXZT0YLBgm/gLsnFcej3WjVfXbV/Ih73YweVk7rqiFDBWKRN
         FlvBa8y02gWa8MGQoUFf7JmgQXTbpgsANSL1OzFrruGcAaBlbqRca+XoGWoxH2BZJlUe
         sFExaAjwijUcP6p2GqeT8rOVAxSTKO+zmP5Hegn5DdC9yQDw+Fr1p9Kn86/iYlapKJZd
         cUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744103615; x=1744708415;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU3jlfHL29/51vRr+ClhtWxfhwAXBGkQarZA/yxGO2g=;
        b=YbB4VwWiexxwoQybo4GWAIcg4VxEqjFKSG2TMOgP4iiiZlOjKbMLclDrsWljVhi7iO
         3tL3z3v+tA4XQ4+JBkGtN1WaGI53frQmgTrfwhmHAaYVbHvadbFbE9vQgkRAJoBE9vd4
         /n8x2M1ajF5fv6tdlTQKw8AeIrNNst8vMo2m93dGcHSsqZC5HwQyNpK8U0h9vm6ykS5p
         2DWZ+iZKA02Jm6C2sqDbiazn0/DkqhQ1EkZyddDNkAzeR8Z6WMG/mvSb/+mS4xUpim4L
         7RwleerV9lOTeD7NpB6TxyO0PHCd3ullCmh495xE1jBWW1ubfVkxKOGmveGe2ECy2AI4
         /rnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG75vxQ6Pw4BkNw/MGYeQOOn6yAemZLYE3hCBiJRG2ksrArG3u08GP+Kg5x4v7pfVl3gxYgM8fL59j@vger.kernel.org, AJvYcCXk43BLS65v/6AuuLxrb5Wuuj4VCjWDOj6MRmtkBEF7feAa3hCxndc1nfeGvU5Z2fkMk5+ch4Sc@vger.kernel.org, AJvYcCXyfBSz2QhhMS8IIqpzwSKoi9pbNHwQ7USp3UiNeaFudhd46jsZqCQAIsZ7V+mhKGEMKBjQbZsABLzGF7YU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyia38hePRBfzh1jchxKL3/4NZ4s46duKqNseyD0wxQLLELaEQL
	thn8z5zV7XSilnBv3EBGm+ywLnBCcyaZBF7//xiNgB6/AQNzDYqK
X-Gm-Gg: ASbGncsPAf2xGd9ZK6QgFJ7vESr1i+smBWpkxeZuOZS6BZwPxgD6OwEi8Gkm6xF2Vfk
	g4/frkrZwio/wOFzBSp+QAXSJjR8JFAk8vVs6LTu0V4FGj09z68q3rrca99i7NLxJy1m6TC7P8d
	ARns+ZFfxJfrNlxNF7neDqBjFSl9fKupMgftYyhxDYMc5IejxcX36AoyaX9J4HmJqqW2Whdm6Z5
	ZNRo2jGwf4IspZKxW3BjQGw6i6sS9AcM5JNbT35oqcR/Zo5VSkkWUzxfCLbr2meG/3umsB3rg2S
	X/ls/VxwmAncVIOeo9bTR8dgd3e3/Jt7BQgXg2Ty9hBtZ/QjJWAI1YtUnmStFhqmS5mbWFyINTq
	9
X-Google-Smtp-Source: AGHT+IFmpUD3WDEfYZdyJZMlUcmM3Uz/pG9KD9AKQWX9zm9kiZbZimr4FaqPmFNyWRNVcwv9d/OHeA==
X-Received: by 2002:a5d:64ce:0:b0:39c:1257:c7a2 with SMTP id ffacd0b85a97d-39cba93d0aemr12569839f8f.58.1744103614388;
        Tue, 08 Apr 2025 02:13:34 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b72d5sm14132111f8f.47.2025.04.08.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:13:33 -0700 (PDT)
Message-ID: <67f4e8bd.df0a0220.369157.fb3d@mx.google.com>
X-Google-Original-Message-ID: <Z_ToufQVD2WfPA5t@Ansuel-XPS.>
Date: Tue, 8 Apr 2025 11:13:29 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-14-ansuelsmth@gmail.com>
 <20250318151540.4rmw6jj5hh2rp4b4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318151540.4rmw6jj5hh2rp4b4@skbuf>

On Tue, Mar 18, 2025 at 05:15:40PM +0200, Vladimir Oltean wrote:
> On Sat, Mar 15, 2025 at 04:43:53PM +0100, Christian Marangi wrote:
> > +/* Similar to MT7530 also trap link local frame and special frame to CPU */
> > +static int an8855_trap_special_frames(struct an8855_priv *priv)
> > +{
> > +	int ret;
> > +
> > +	/* Trap BPDUs to the CPU port(s) and egress them
> > +	 * VLAN-untagged.
> > +	 */
> > +	ret = regmap_update_bits(priv->regmap, AN8855_BPC,
> > +				 AN8855_BPDU_BPDU_FR | AN8855_BPDU_EG_TAG |
> > +				 AN8855_BPDU_PORT_FW,
> > +				 AN8855_BPDU_BPDU_FR |
> > +				 FIELD_PREP(AN8855_BPDU_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> > +				 FIELD_PREP(AN8855_BPDU_PORT_FW, AN8855_BPDU_CPU_ONLY));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Trap 802.1X PAE frames to the CPU port(s) and egress them
> > +	 * VLAN-untagged.
> > +	 */
> > +	ret = regmap_update_bits(priv->regmap, AN8855_PAC,
> > +				 AN8855_PAE_BPDU_FR | AN8855_PAE_EG_TAG |
> > +				 AN8855_PAE_PORT_FW,
> > +				 AN8855_PAE_BPDU_FR |
> > +				 FIELD_PREP(AN8855_PAE_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> > +				 FIELD_PREP(AN8855_PAE_PORT_FW, AN8855_BPDU_CPU_ONLY));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Trap frames with :01 MAC DAs to the CPU port(s) and egress
> > +	 * them VLAN-untagged.
> > +	 */
> > +	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
> > +				 AN8855_R01_BPDU_FR | AN8855_R01_EG_TAG |
> > +				 AN8855_R01_PORT_FW,
> > +				 AN8855_R01_BPDU_FR |
> > +				 FIELD_PREP(AN8855_R01_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> > +				 FIELD_PREP(AN8855_R01_PORT_FW, AN8855_BPDU_CPU_ONLY));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Trap frames with :02 MAC DAs to the CPU port(s) and egress
> > +	 * them VLAN-untagged.
> > +	 */
> > +	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
> > +				 AN8855_R02_BPDU_FR | AN8855_R02_EG_TAG |
> > +				 AN8855_R02_PORT_FW,
> > +				 AN8855_R02_BPDU_FR |
> > +				 FIELD_PREP(AN8855_R02_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> > +				 FIELD_PREP(AN8855_R02_PORT_FW, AN8855_BPDU_CPU_ONLY));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Trap frames with :03 MAC DAs to the CPU port(s) and egress
> > +	 * them VLAN-untagged.
> > +	 */
> > +	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
> > +				 AN8855_R03_BPDU_FR | AN8855_R03_EG_TAG |
> > +				 AN8855_R03_PORT_FW,
> > +				 AN8855_R03_BPDU_FR |
> > +				 FIELD_PREP(AN8855_R03_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> > +				 FIELD_PREP(AN8855_R03_PORT_FW, AN8855_BPDU_CPU_ONLY));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Trap frames with :0E MAC DAs to the CPU port(s) and egress
> > +	 * them VLAN-untagged.
> > +	 */
> > +	return regmap_update_bits(priv->regmap, AN8855_RGAC1,
> > +				  AN8855_R0E_BPDU_FR | AN8855_R0E_EG_TAG |
> > +				  AN8855_R0E_PORT_FW,
> > +				  AN8855_R0E_BPDU_FR |
> > +				  FIELD_PREP(AN8855_R0E_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
> > +				  FIELD_PREP(AN8855_R0E_PORT_FW, AN8855_BPDU_CPU_ONLY));
> > +}
> 
> Is there a way in which you could group the registers a bit more?
> The function occupies 2 screens :-/
>

I will use local variable and pack it.

> There are 4 read-modify-write operations in succession to the RGAC1
> register. Maybe you can converge them into a single regmap_update_bits()
> call.
> 
> Also, for packets which reach the CPU via a trap, we shouldn't set
> skb->offload_fwd_mark = 1. In other words, if the bridge layer wants to
> forward them in software (including to other an8855 ports), let it do so.
> The common example given in commit 515853ccecc6 ("bridge: allow
> forwarding some link local frames") is 802.1X PAE (01-80-C2-00-00-03).
> 
> I notice mtk_tag_rcv() calls dsa_default_offload_fwd_mark() with no
> pre-condition. Do you know whether there exists any bit in the RX tag
> which signifies whether the packet was received because of a trap
> (or if it was autonomously forwarded by the switch to the other bridge
> ports as well)? The offload_fwd_mark bit should be set based on
> something like that.


I did some simulation checking the full tag and also yesterday Airoha
confirmed that those register doesn't affect the CPU tag.

There is an entry in the TAG that signal some kind of packet but it
doesn't react. From what I can see it only comunicate when fdb or other
really special thing.

-- 
	Ansuel

