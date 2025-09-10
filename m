Return-Path: <netdev+bounces-221589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857AB5110E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4772216C596
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DD2D12ED;
	Wed, 10 Sep 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5dMNMS1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155D2DE1E6
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492424; cv=none; b=Sa/r0z5wG1/6Cux/ajL9UZwrapHhxiuAXo4khPlB7px9tU9HCWCHLTvKPAHOhAbVlBv1rEhe9iLLmybbKYEO8Ls51ebRXebM+8A7jsaDTuet1Fbl17rzRex36lYDler6KqE1aOor65IXiWvyLV7FQPZauy8WXbPTcx4N0fAtcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492424; c=relaxed/simple;
	bh=PAz3im+y19NDT+YMJxSBDJens7K9RovOUhC6XNb8bys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chvJGN37hxMvtH/4gaNRmVAXVWB/A6rYvvY3ZtFQsOQk7K5gEuLTBHugZhiXsVQS/1LfUT9t7lFNGXJCPPNBnkZvuw7XY+6uUd8Gy8YGpRFQdtvUznL4FnnrBezPHEh7gS4sxc7KEdrZsSuMiU3O3f9JJu13Vn5dRviw6PiuA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5dMNMS1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0419ea6241so70733266b.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492421; x=1758097221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L/ZiHIMyXmxKkiSLCWK4pWAdvwcf6C/7sfjkt+r2Zs=;
        b=E5dMNMS1V1mwGjFvwsOC7Q8EV2jIm4VGtmzMbgcvbUemkURSwAeqRTwVt67gc0P/yr
         PCpDNgjzQVSs8/RC+aK1EW5mqFLIoxlxbYQdbK7CRihE9A950SQBxA2CP3r7q1L5CcBA
         sVLX1gb7jUV8IPjP4UA/OxuLuCLHKLk04K5wYR29AeW+MThz+obX3mhO2bInHhCUMBRl
         JkA4fkMTgaIm3Jwt1tdqv91epv+TcYjH37Ig9eDhUo15P6XW2MR3zdAo3j2gsoCqeuDW
         cZRq5wn1TLtvl4vCSRI2eiXrw9tkhGs6Z79jc0e8DqNTQp2QNBgqI3F4ymSLM+xn+AAX
         E+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492421; x=1758097221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L/ZiHIMyXmxKkiSLCWK4pWAdvwcf6C/7sfjkt+r2Zs=;
        b=rBNbubqROEn+9dxrRLeQkyH5inAy59ohgI3Ld8oG4fe4eFj2nbVjHg6wMMePfCYTHI
         LBO8SvsoX/LUVBEDVe9skLVnTHX5l3khWaqkyuNcwJVg0agmarOwkXTd77bqS1miDglx
         QrR+6Gfiob7w3zbc2CxvyvOcUH1IaNTql9m2lZVVOtkE4phbEpbkFv2aiOW3563e73gc
         xEqU/qGyUsWZgVzbtz7UzI7DqnpSaPzzuaXAymOyJEyKdRQmp9gxlajHPtKpNXXVBS0D
         VizB/MoBBnoVDmFoKF+1m885VwacNXPgCObYyACfzyF9Te2NdrVJLMY+D8d4X3KTXYI/
         ppgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg6LoK0BYPi92ABHNV6H+gCJSdXQHbQGv+bSHsgXDQzpt3HpoVJAfcmngXlosXX2IIq+kFq0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCM1H8BTCfaTcSAJGBUenEZXCVyroNozDrytw66Jo6GWzaN77C
	0hKreYKnE4dNQhlEoL3jBqoUNeT+Uuo9f5/tQUW5W7GCddx3sjxcuoan
X-Gm-Gg: ASbGncts1Ekd9fcgb7tZeMCc+xfUiOFKRuFU+X1Eb1PGFvnlgpknsWqVIoz/F5llidk
	sGNSrmlhe2g68pJHTsWICK2iBk3y1jEHFPx/xG1iRyQ+37P9IaxxiwsoiZWp51pq8X4nJpWEHke
	RDDiqAwC7dU1Lo52zIpfnQWyJAdN+vFhh9hc4jH2GGG3vwL9NyjVvT/x1U6tq/4kS3E1nY4TQEr
	RnVfQ4I0LMQ7PzZAIpfZTiLJ4Cg0DbiEtSKTEG9L2t1x3bdB29eJK8WEbrDIiDM8lKWM7q7Ckby
	6TvjVdITLGF3VQp7u9cEdLt83v58r1yvM8NIhLk1WoS4LbrgmBzklUMxDU8bhXDFirEdQv3qrQe
	xbuCEDYVGNobbDSQNBPHX1DiFqg==
X-Google-Smtp-Source: AGHT+IEZ6Y8m9czCHfXyGir/VeA90+bvrcMtK66llF0DDBp7AdUVUAE+7FZ2p8xLZJOlSOvaso7zZw==
X-Received: by 2002:a17:907:9718:b0:afe:b131:1820 with SMTP id a640c23a62f3a-b04b155985emr758644266b.6.1757492420788;
        Wed, 10 Sep 2025 01:20:20 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:6669:35e7:fc93:9b1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ffa91sm122826066b.91.2025.09.10.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:20:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:20:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v16 10/10] net: dsa: tag_mtk: add comments about
 Airoha usage of this TAG
Message-ID: <20250910082017.hjlq3664xvg5qjub@skbuf>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>

On Tue, Sep 09, 2025 at 02:43:41AM +0200, Christian Marangi wrote:
> Add comments about difference between Airoha AN8855 and Mediatek tag
> bitmap.
> 
> Airoha AN88555 doesn't support controlling SA learning and Leaky VLAN

Is there an extra 5 in AN88555?

> from tag. Although these bits are not used (and even not defined for
> Leaky VLAN), it's worth to add comments for these difference to prevent
> any kind of regression in the future if ever these bits will be used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  net/dsa/tag_mtk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
> index b670e3c53e91..ac3f956abe39 100644
> --- a/net/dsa/tag_mtk.c
> +++ b/net/dsa/tag_mtk.c
> @@ -18,6 +18,9 @@
>  #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
>  #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
>  #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
> +/* AN8855 doesn't support SA_DIS and Leaky VLAN
> + * control in tag as these bits doesn't exist.
> + */

I think it would be good to present the AN8855 tag using a different
string, so that libpcap knows it shouldn't decode these bits. The code
can be reused for now.

>  #define MTK_HDR_XMIT_SA_DIS		BIT(6)
>  
>  static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
> -- 
> 2.51.0
> 


