Return-Path: <netdev+bounces-221593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34CB51151
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABCC560B3B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68531062E;
	Wed, 10 Sep 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMLu5Y9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167E30F544;
	Wed, 10 Sep 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493105; cv=none; b=dQ/NOycQydU1GMOD2Njk+oXcntXMr8FOefBnOsN6RvDt97lq8lEquaO5o6+HzfZjRN7MAeYeZ0uQgTVPLlBNkOCmexxx9rJeIBHS+Gd7ezk3ErS9O2j1Rw0sRZhe3zk08RXBaPp45KmbbZMECzbzqBGqlB3xOggVXisp5mIUSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493105; c=relaxed/simple;
	bh=YMeOTS2s5UrKb4GkderWVzhb5EkilUWg4YaxZ3sZMjo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGiMIT0GhEiQzqmJCGR8NWVwEjUYd7nG7WKejqJQOQBb0u26ytRtBfs7EBQyVK1odrmqnONoLPnEFce+Kq5g9YerG4yxOQPI+gETsoPUfKm7Uw6YX8eKaTyFz2aO7wgkjKm0TevmxYVCEpsawpg6vJs3YpT6QnJSg2ahTNQ+C3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMLu5Y9Z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so3572717f8f.1;
        Wed, 10 Sep 2025 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493102; x=1758097902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7+Vq3ysZS2lc4WhA67yDwpubRjl51dbZS1N3bA03ln0=;
        b=mMLu5Y9Z+xIV9D6wXsHKyKeOSJhjqfKqg65wIsoDACdgp+Zz3gbYHFwCp7t/HpiqPx
         rh2q7dCOaResaXyXtcE/4DMvOi+lo6CCfjbT7xuXCksdLVdshuOauv23Jzo8i0+6cAiq
         BWGNEmCmdZX3NGyQkHgVoY9kNfKcoAexLdfxqFL9CG4GmQyeqYVkjgiPDS7vVH4E+pIz
         +Z+BBdyEVmrz4QXTSLAs5aIieDUqJU06/n2Fs7MvDURs8INSmQsIV39NFqF21yfBCiQJ
         Qlco7PRcVw42IiDZ9+TPBBQotkruzBSO3pjoK34PO6rbqY8S48sORgPxU5OmQiFm8s0V
         dVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493102; x=1758097902;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Vq3ysZS2lc4WhA67yDwpubRjl51dbZS1N3bA03ln0=;
        b=vl5BB7dVg14NRGycmqsB4itDxph6YNItq8+4buGCNjOchj3O0bACfPgMUXKFVOlZKK
         NTn/Sg0b133MX0x6iUbEFVeWQrTvgzhp/Jl20rPRflfGWvPgaMfB51hIA9ZzDv8j5Thn
         p0PWaXOB+DGsETqP5zm4eLbGQ5k5I/NI7aJz46ohGJpPafbxfU6sM2bmvZVAUJA2RGIF
         8hXMjqBwvLubOORO8EPzKRmKlAswrndfSqjee511fmJi33HRkvXgtREMRLrMpMERirvi
         kLONLwrbbC7HkqkUOd99P+2Bo/8j4Tq5O7ItDJpwvE3aXyYsEv+fUdkd03qvvfc1d8Pf
         ZXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWNdMs3enasyWcFVRkfFkbgGGKls/bjr2Kaz6qnJrNX21y8FlGz4FUDsp83qwBHc2oROPvXciBqI2+@vger.kernel.org, AJvYcCWqrKsevEG1g2LBdqiv5EdMgA7wr+B8lepcNdC+c9922WkgCQJJHYttP05752Hik4n9wjy6ROJm@vger.kernel.org, AJvYcCXnkYK9GEqoLDw9vE1FiI/htUUw+3VB8Um0kPatlegG8P6i6Tp6OEljw1bur74a6ZgWh7isCOQ1TWT3BQJX@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjrH8SOTNUq18dpqvl2ZsV41qiPz0aWWM7Eu3j+eYmIzb5A7r
	fqduaQUqRMlF6msan1619B7wPt2ffBQtV0yI3ENykxynyOmL6M84t3MX
X-Gm-Gg: ASbGnctF3ZucoMhQCC+cKQzRkHvAREKoENUUBlb1nRqvg2XJ4vYH62aifUOd1nsiM5I
	MElK8FHhuzOoSRgFghncDBxWJTElWHoRXYSTllrRWw6tdOyKxhtr8p8CDUnfTokb0yu9Zg5Gcn0
	sAjPajrRDnpqGq2sVNDEvQwayNrLN0XCmFnyCamZAdMlND5kMiXD46e9WDC4NvnHQUuYZt6ovIa
	qpErz0Jt5y0+pUthTPyGmMjPIlfVQicKvzQfu6zaNJBhcjtH1ObRrf4KBHauN7mQ7yztAvuntQ0
	p5ZPnIGSq6BEDCl/cdRRT2sS9XMVL2FHwaKRkTVrB811FFQObue3VIht73bhnpQma5ngv2ir4aI
	DT2mDXlI7rnzvsQy1yn0D8pg8GR+qz+1eiQcm2b9ZsidYZl2RoafRf5wWhVqH5/muwbGGUA==
X-Google-Smtp-Source: AGHT+IGx/xbJUIH4+beV7q9PMqx0glsggALR4qg5rZZAhjCkYIwZFcTKRYd4C8GT0jF1ei0YocGGkA==
X-Received: by 2002:a05:6000:2f87:b0:3d7:df92:5e31 with SMTP id ffacd0b85a97d-3e641e3b09amr13400380f8f.16.1757493101468;
        Wed, 10 Sep 2025 01:31:41 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca2aesm6060026f8f.26.2025.09.10.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:31:41 -0700 (PDT)
Message-ID: <68c1376d.050a0220.2085dc.675b@mx.google.com>
X-Google-Original-Message-ID: <aME3Z0CacqPJNZT8@Ansuel-XPS.>
Date: Wed, 10 Sep 2025 10:31:35 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250910082017.hjlq3664xvg5qjub@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910082017.hjlq3664xvg5qjub@skbuf>

On Wed, Sep 10, 2025 at 11:20:17AM +0300, Vladimir Oltean wrote:
> On Tue, Sep 09, 2025 at 02:43:41AM +0200, Christian Marangi wrote:
> > Add comments about difference between Airoha AN8855 and Mediatek tag
> > bitmap.
> > 
> > Airoha AN88555 doesn't support controlling SA learning and Leaky VLAN
> 
> Is there an extra 5 in AN88555?
> 
> > from tag. Although these bits are not used (and even not defined for
> > Leaky VLAN), it's worth to add comments for these difference to prevent
> > any kind of regression in the future if ever these bits will be used.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  net/dsa/tag_mtk.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
> > index b670e3c53e91..ac3f956abe39 100644
> > --- a/net/dsa/tag_mtk.c
> > +++ b/net/dsa/tag_mtk.c
> > @@ -18,6 +18,9 @@
> >  #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
> >  #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
> >  #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
> > +/* AN8855 doesn't support SA_DIS and Leaky VLAN
> > + * control in tag as these bits doesn't exist.
> > + */
> 
> I think it would be good to present the AN8855 tag using a different
> string, so that libpcap knows it shouldn't decode these bits. The code
> can be reused for now.
>

Do you think I can implement 2 tagger in the same driver or do I need to
make a library of this driver? Just asking what is the correct way to
generalize it.

> >  #define MTK_HDR_XMIT_SA_DIS		BIT(6)
> >  
> >  static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
> > -- 
> > 2.51.0
> > 
> 

-- 
	Ansuel

