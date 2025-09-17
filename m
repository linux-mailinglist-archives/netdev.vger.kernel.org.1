Return-Path: <netdev+bounces-223920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7731B7CCBD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF4582740
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881730C37C;
	Wed, 17 Sep 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9gOSWsS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF12F39A1
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102145; cv=none; b=UJS5kuKYLNByiV7EwtKZKCiyn/m/juGTCCMAAFJo+9WZhyzrLS63Jlw9PQBVIz70OrZFXU+eMiqSy+ffX1qZOEyZnbEO9/PwHTf6X0RseLvS/e2AKh2829UIstDDYeLAiNM/Po6WmLZ5CjtFtDzG/DEtE5YDMG3D/SGzLfxLzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102145; c=relaxed/simple;
	bh=YqpsgxicT/gLX63bde2BqsbreGFWowRoNFTiwd/r9zQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pluUSiUCAfnQ2kkmEca6VDtyo4lp0AwoFaQdViidwTjvE7YS8LZXXu0ayYZPRRB4c3seunXgRgaB/57o5+3wLBQN5+tlL0+mcdfNFbwUAXCoVkEfesVW22qEdf0SaWhFEKDF7tqWIC3HKEh9JGfoLJj/mhvLUQFL4MHi7iAm/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9gOSWsS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so23586975e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758102141; x=1758706941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i09V1V+8m07vXTofqYygiTDdC5J30D33C6bZzl31WR8=;
        b=A9gOSWsSK/1gUnb4dnei3O75N19SaL/HXhgWEHSVcKBmWYOBZrggVJMZiQNWwXjYru
         gkoMX5xQL/Asz8cL4dKCvJTBAer2lTCgoHPRigUc5A2Fu3qG3qOvf7j769aMV4hP/t2s
         imOzXdzsdWK1LwupzD0U1OB1ZhtMxytxTcaM789RZlVUzhMA7HAz4sICQWSGHzqdaI59
         X1fZ0yCMAs+aen6smtZn2clZwILTWr6QThHNhv3uNsw71wfjwoj/wqxBCx5jeiYrjxHF
         fimvJAXvsG+lyoEr2wpZ4IfinWgo2UH1g3KhJqJPJMFg5AKSCgSmxfdb9zcTlH3oVygl
         GQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102141; x=1758706941;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i09V1V+8m07vXTofqYygiTDdC5J30D33C6bZzl31WR8=;
        b=RCcGYzlj3KJbYOK9T3s19sR/nun/5xsNR3OhE/ak7h7X63UBqXYhtZBdjeS9OrK95x
         4Otz9SFGCEoYvr6xcHcB6U+H29VSv0FVVrmSwZLulx2jo7HNRuEmTLj7t5YhhXLi2D95
         0tJqUUlQGJfMp9YzNYzA0jzpBt1rPqD7atYvcUPgG6zpiFUYFOdQrYs4yg/LT1HE00MC
         joWovGEvg6HoQyy7ogOm57X3rZnOND8xcom9IR0Srh/jdy7zLmGmTrsYGCA1L0S65hnd
         PWs5vTeVies9l7Z/CT/VBjD92zIOBEpb95qFkOPHdwqqovuEhA0UeavsW01GFN6eN7Sk
         2l3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjw+kSSyN9YU6gnHGVml0p6n+s+H8afTXR8hj4CvgFioO3HSkmNYX5MM3wehPkXT2rnZ+2De4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoqTXQ0yzuYZArNYYSF0l/eI5a6Asd6QB8ldVk04o+lTHEIBbE
	gUOTU9ZO92R8iPwD7PZY3vjrfMA/2xq9qpZDPUbAKMUNUIyz1fehltNh
X-Gm-Gg: ASbGncuooWuh1zXftWouyo2BRP1VVcCO0/H9ukRZm5CiOaiXu3w0OBuT+egfdKb3hoD
	eOtnB8pM8au+PDA+7zW1v19nUERZXv4Gdx0q8VERxs/hcm0hNxNcKyvrZ2ir2CRevU9RaKteGmz
	Ppzk9xYhdLOQHYWM/AzxFA4C0NDVQZqQrnOoExIM2hvhTnljoIW2g5/OoHYiJ+nMTEk196Na0ne
	KjKbuICcExXKwyNHTIf/i2TJLAS6gAlfJ3zFtRZaKE9QnDz+z6YVVrud4GoTsg5OqoAQ5ZMVvW0
	5YVYvdJKvIFwMyI05YYj82uZMDA6yy9F/S7EBLqp5DBUOCwPtQ8oJbnRFnHFaWWsON139xiXPwG
	OruPwTgXEHsXHv3UOSnKW3ezlMilERqhgYU+rBMpfY2yO32r5RfHSWLsqlwlcIehO84hhOA==
X-Google-Smtp-Source: AGHT+IEKiwJZQCrLPEgkzRNnTHskaZnK9OmVkfYp3uZ3v0rYXitoWfeTluLHukDJc9g2ASRO8v71/A==
X-Received: by 2002:a05:600c:1c87:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-461fd2e4377mr14209635e9.0.1758102141144;
        Wed, 17 Sep 2025 02:42:21 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139e87614sm30184935e9.23.2025.09.17.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:42:20 -0700 (PDT)
Message-ID: <68ca827c.050a0220.11f9b4.a3f0@mx.google.com>
X-Google-Original-Message-ID: <aMqCdW_r6QYeldBm@Ansuel-XPS.>
Date: Wed, 17 Sep 2025 11:42:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 4/8] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250917093541.laeswsgzunu3avzp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917093541.laeswsgzunu3avzp@skbuf>

On Wed, Sep 17, 2025 at 12:35:41PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 15, 2025 at 12:45:40PM +0200, Christian Marangi wrote:
> > Add variant of the MTK TAG for Airoha Switch and comments about difference
> > between Airoha AN8855 and Mediatek tag bitmap.
> > 
> > Airoha AN8855 doesn't support controlling SA learning and Leaky VLAN
> > from tag. Although these bits are not used (and even not defined for
> > Leaky VLAN), it's worth to add comments for these difference to prevent
> > any kind of regression in the future if ever these bits will be used.
> > 
> > Rework the makefile, config and tag driver to better report to
> > external tool (like libpcap) the usage of this variant with a dedicated
> > "Airoha" name.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  include/net/dsa.h |  2 ++
> >  net/dsa/Kconfig   | 11 +++++++++++
> >  net/dsa/Makefile  |  2 +-
> >  net/dsa/tag_mtk.c | 36 +++++++++++++++++++++++++++++++++---
> >  4 files changed, 47 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/dsa.h b/include/net/dsa.h
> > index d73ea0880066..bf03493e64ab 100644
> > --- a/include/net/dsa.h
> > +++ b/include/net/dsa.h
> > @@ -55,6 +55,7 @@ struct tc_action;
> >  #define DSA_TAG_PROTO_LAN937X_VALUE		27
> >  #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
> >  #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
> > +#define DSA_TAG_PROTO_AIROHA_VALUE		30
> >  
> >  enum dsa_tag_protocol {
> >  	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> > @@ -69,6 +70,7 @@ enum dsa_tag_protocol {
> >  	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
> >  	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
> >  	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
> > +	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
> >  	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
> >  	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
> >  	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
> > diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> > index 869cbe57162f..7d63ecda25c8 100644
> > --- a/net/dsa/Kconfig
> > +++ b/net/dsa/Kconfig
> > @@ -98,12 +98,23 @@ config NET_DSA_TAG_EDSA
> >  	  Say Y or M if you want to enable support for tagging frames for the
> >  	  Marvell switches which use EtherType DSA headers.
> >  
> > +config NET_DSA_TAG_MTK_COMMON
> > +	tristate
> > +
> >  config NET_DSA_TAG_MTK
> >  	tristate "Tag driver for Mediatek switches"
> > +	select NET_DSA_TAG_MTK_COMMON
> >  	help
> >  	  Say Y or M if you want to enable support for tagging frames for
> >  	  Mediatek switches.
> >  
> > +config NET_DSA_TAG_AIROHA
> > +	tristate "Tag driver for Airoha switches"
> > +	select NET_DSA_TAG_MTK_COMMON
> > +	help
> > +	  Say Y or M if you want to enable support for tagging frames for
> > +	  Airoha switches.
> > +
> >  config NET_DSA_TAG_KSZ
> >  	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
> >  	help
> > diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> > index 555c07cfeb71..7aba189a715c 100644
> > --- a/net/dsa/Makefile
> > +++ b/net/dsa/Makefile
> > @@ -27,7 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
> >  obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
> >  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
> >  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
> > -obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
> > +obj-$(CONFIG_NET_DSA_TAG_MTK_COMMON) += tag_mtk.o
> >  obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
> >  obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
> >  obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
> > diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
> > index b670e3c53e91..32befcbdf4be 100644
> > --- a/net/dsa/tag_mtk.c
> > +++ b/net/dsa/tag_mtk.c
> > @@ -11,6 +11,7 @@
> >  #include "tag.h"
> >  
> >  #define MTK_NAME		"mtk"
> > +#define AIROHA_NAME		"airoha"
> >  
> >  #define MTK_HDR_LEN		4
> >  #define MTK_HDR_XMIT_UNTAGGED		0
> > @@ -18,6 +19,9 @@
> >  #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
> >  #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
> >  #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
> > +/* AN8855 doesn't support SA_DIS and Leaky VLAN
> > + * control in tag as these bits doesn't exist.
> > + */
> >  #define MTK_HDR_XMIT_SA_DIS		BIT(6)
> >  
> >  static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
> > @@ -94,6 +98,7 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
> >  	return skb;
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
> >  static const struct dsa_device_ops mtk_netdev_ops = {
> >  	.name		= MTK_NAME,
> >  	.proto		= DSA_TAG_PROTO_MTK,
> > @@ -102,8 +107,33 @@ static const struct dsa_device_ops mtk_netdev_ops = {
> >  	.needed_headroom = MTK_HDR_LEN,
> >  };
> >  
> > -MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
> > -MODULE_LICENSE("GPL");
> > +DSA_TAG_DRIVER(mtk_netdev_ops);
> >  MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MTK, MTK_NAME);
> > +#endif
> >  
> > -module_dsa_tag_driver(mtk_netdev_ops);
> > +#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
> > +static const struct dsa_device_ops airoha_netdev_ops = {
> > +	.name		= AIROHA_NAME,
> > +	.proto		= DSA_TAG_PROTO_AIROHA,
> > +	.xmit		= mtk_tag_xmit,
> > +	.rcv		= mtk_tag_rcv,
> > +	.needed_headroom = MTK_HDR_LEN,
> > +};
> > +
> > +DSA_TAG_DRIVER(airoha_netdev_ops);
> > +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
> > +#endif
> > +
> > +static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
> > +#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
> > +	&DSA_TAG_DRIVER_NAME(mtk_netdev_ops),
> > +#endif
> > +#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
> > +	&DSA_TAG_DRIVER_NAME(airoha_netdev_ops),
> > +#endif
> 
> Unless the few tens of bytes saved matter on OpenWRT, I think this is
> overkill (and you went too far with my previous suggestion).
> Two Kconfig options are unnecessary from a maintainance point of view
> (and config NET_DSA_AN8855 isn't even selecting the correct one!).
> I suggest you register both tag drivers as part of CONFIG_NET_DSA_TAG_MTK,
> at least until the differences increase to justify a new option.
>

Ok, was following the pattern done by the other. Will drop the
additional kconfig.

> > +};
> > +
> > +module_dsa_tag_drivers(dsa_tag_driver_array);
> > +
> > +MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.51.0
> > 
> 

-- 
	Ansuel

