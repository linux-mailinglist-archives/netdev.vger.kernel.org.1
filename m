Return-Path: <netdev+bounces-233731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B10C17AEA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A543401881
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB492D780C;
	Wed, 29 Oct 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew9HlEcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2622D6E52
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699380; cv=none; b=XrUx4UoUFtRydl41ZiQyN/otRH+e0be/vINgj+aw6uECWIc6BVrxaPNhWuHI0v3e82O5BaXso31oPypycnbv9aM/UWmESqARBVyyIphTh3j2Zob9PUT3T/NsZ7K1jWNd9nbBWcnRojoCqIEw0E0Nl6F6q8nFGCZHRVwzWQHOaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699380; c=relaxed/simple;
	bh=QLSCmp+DageXB/lbgTmmOjvd9XJyigv0R3q9m8lS9aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUqPPJ9xruChSXWbEXwIUz31BfrsU0BSK1o4UwbRuSMIRM5OmXIwkkHTQZxDo+4HuXTgyW4H/5FCpEgjlui+mJTZzsDn5EGZAzdvJuNQfhtcfXbee6dneeILi+YvJZ3FRIw8jikRmmlxT8OzibIweFUeVpJAiN7u9UCCdfR0ivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew9HlEcK; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso318631a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761699377; x=1762304177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pezF2VK8RuTzI7DSs1mIZQ9VJH2IBGxZMtiOZQj+jXY=;
        b=ew9HlEcKt4uoaYutWi49vf4yST4qKRv/x7Coo9jumKpIe1hI4lF6tnihNI0DL9Y8FH
         JANRfHVxTe2FdpYugEnrz7VK/nZ4yU75YiOfWcN/zB1HJm2YCOWakA24DPKq3RDhLncz
         WJNW8bjyvlVLwRPrYbR68RH6d28RGKi7TEQrPurolZtI75QMORxFJSBr0SGXxCQzitGq
         vKuBy0nyKKs7Uu3uQAqTHsBcmAj/pDdRE9H5SSScB31ZZ1tWY59IDormNG/YhhvX/xRd
         guM+EBudY9tiekigiROq+/xQSvULwMvTzzSY1r5LrFBBFqXcGf7tngiuQud5r2BilhrB
         Cn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699377; x=1762304177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pezF2VK8RuTzI7DSs1mIZQ9VJH2IBGxZMtiOZQj+jXY=;
        b=adeXk2najhMvoqOm2RPQ3/TkNUvM1jo7OClqCOO8XuRZWxeIEr/jMRLUlFlGJ6t58J
         Nwl123LzMSmy4GXnxbjtvGtNEyHKBpStQEC+cePsbRTYkCFVSxVpZ4jq0rzdtfumGvO8
         XAwkM/7RqIVXFyrCWIlsRUPvwzFllu+ApYXMsiva+VECAgnQAg95QBgQ7kIOaoyOYqcz
         jVClDU8A5BZigF1hzH2qL5axr7EeNawjrk+EkgCfhP/T/8mA7jlU3GKAbPTcAnZeaHFS
         I7/CWhto0L+qRVsLk5eRKSlcaiXZ2BH6CberRR2XvbXaeDPr415YM0CVkwwgQxNh+orU
         jXTw==
X-Forwarded-Encrypted: i=1; AJvYcCU+vZk+VUZWzsPp7XuIQnd5VhxTwSpkmusns0Y0aMixHNoeHAeGaXQZ7hE9m6AL/bLploRIiwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ln2DkIv9MvqqEeUb9beJg17/COGbztwZgZ+RfKuwl+pzAj6C
	a2d32owC4WlNXx30IJBOsI6jp6ed8S3LPd1CsBVQLBsREF1QIyCKnVTI
X-Gm-Gg: ASbGnct4bvcQaBs2Y8p4uViI0tRouX/H8j5kvJmRAxOjE4FqCj6bvGep5zOBjugxCQK
	XlO4rIg45SEz/4q1RMk0PrqbUoRNaXByyWl0ECOKpS9UpF6zqYTiNDwZQXnffS6Q0KU97x5IMfM
	c78Qj8cvK+TNroktm2enuepg/QGWVgF9yfkOyrBi4PS81mGXHmZQamPSeP9l3Hl5eWzU1go21uS
	nNWsu9oK2NC0/07LdIJAiHeQgyE0Z/RcFKrk2XonR5CzbtdXy2MWpgRHb75UfVqXVPnxY7LWh8f
	FzbIAXb82OerSZIshcOop27JgNfzaxeVF/kdJiatzbSnnMV4es6qoI955nG0lDrSMvOYGxN6pcK
	8GVZkfDn4QSt3SJHKcW7V8MxG/2ibAO/YWLbBqPF4JEp0AiYbHempk+7nsyPqd7+qiRuxGisqLj
	A=
X-Google-Smtp-Source: AGHT+IHOlz4wCJmTj/zx16kQtcK3MAOTVFHMVAoc2+es1wdMlMVDqBf6QFztVnrfW0sWZY15JATnUg==
X-Received: by 2002:a17:903:41c2:b0:26c:4085:e3ef with SMTP id d9443c01a7336-294de9f7ae3mr12621045ad.21.1761699377445;
        Tue, 28 Oct 2025 17:56:17 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d230c5sm130960935ad.47.2025.10.28.17.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 17:56:17 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:56:09 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction
Message-ID: <rclupbdjyk67fee2lgf74k6tkf7mnjcxzwcjvyk2bohgpetqt5@toxvy3m5orm2>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-2-inochiama@gmail.com>
 <20251028-parka-proud-265e5b342b8e@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-parka-proud-265e5b342b8e@spud>

On Tue, Oct 28, 2025 at 07:22:37PM +0000, Conor Dooley wrote:
> On Tue, Oct 28, 2025 at 08:38:56AM +0800, Inochi Amaoto wrote:
> > As the ethernet controller of SG2044 and SG2042 only supports
> > RGMII phy. Add phy-mode property to restrict the value.
> > 
> > Also, since SG2042 has internal rx delay in its mac, make
> > only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> 
> Should this have a fixes tag?
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 

Although I add a fixes tag to the driver, I am not sure whether the
binding requires it. But if it is required, I think it should be

Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac")

> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > index ce21979a2d9a..916ef8f4838a 100644
> > --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > @@ -70,6 +70,26 @@ required:
> >  
> >  allOf:
> >    - $ref: snps,dwmac.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: sophgo,sg2042-dwmac
> > +    then:
> > +      properties:
> > +        phy-mode:
> > +          enum:
> > +            - rgmii-txid
> > +            - rgmii-id
> > +    else:
> > +      properties:
> > +        phy-mode:
> > +          enum:
> > +            - rgmii
> > +            - rgmii-rxid
> > +            - rgmii-txid
> > +            - rgmii-id
> > +
> >  
> >  unevaluatedProperties: false
> >  
> > -- 
> > 2.51.1
> > 



