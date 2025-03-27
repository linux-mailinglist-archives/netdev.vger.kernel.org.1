Return-Path: <netdev+bounces-177977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A84A735F1
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 16:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E599D1894FD8
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC319ABAB;
	Thu, 27 Mar 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Um6QHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067B155C83;
	Thu, 27 Mar 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090566; cv=none; b=B5vPNgDO7naXiA8hjUN08eEd2cEqU7EDpciqzsz6GeASSGQCwQFMWa5/rk0rIzQkM22f5XIV38Rdtnn9r275bkeO1M7MLFqkfeWkojvrR9DlI+mV1Hh+FnC+X6GOMu73gi2UskZgA90zgslycl2skW+qobLCT0oK36B8iXX8QUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090566; c=relaxed/simple;
	bh=Fx0i3p4mlf7xc+F7De5cWrUOeKfN8zxZXVFfC6n4sEY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWC5ezaAjyrq51D0bRoGZ/TPedEEQe7zlK4ACe8TWLMTallqtW6w2aoiAfplTimqKukTqOHZYlGzgTrbZdpEvVDoZMfrW6hVU36y2TJj4F0hx/YpYwQoaVPP6vCuTrB6XoN9T1M3w1wsUg2Abt17saJq00rOGnNanUdxpbLIHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4Um6QHO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso12742335e9.3;
        Thu, 27 Mar 2025 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743090563; x=1743695363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0IXK2rCyNqiPkcVyjGixix5uWCxqfElYtjg0TfVyEE=;
        b=m4Um6QHOpzKXVwxZCxu2xvVa5mB5Ee2bEqU0h3HoJZ3uYuNSImi4n/qH32L68hL+dL
         Jr5hc/e45WrxFwlvz3sJk/Rv0etyu8S+HMovQFqitfHxQxjr9yol5qx3J2eG3z6USwDM
         bTBSHFGNh7fb+wnncZhw31VALuK9Yjz3Fo8OjnpA/6lf6g4T2ocsUsMk2nD75SHCEOdY
         8HgwpdnMv+kZg+lHmM1BoClfTibfTJMIFmJx3aw0bOKtmWbRRDS6JxiFtjKs07GQ8v7/
         49/iqzU481Tv8fK0VqRpnsQ1AnWW21JptPVBFLiiEEJfyBcQPdTfI9TyWpk4Ip1K+I7l
         I3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743090563; x=1743695363;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0IXK2rCyNqiPkcVyjGixix5uWCxqfElYtjg0TfVyEE=;
        b=p8xvbC4Db/IeeRlJ6Q0+w3N+BPrpyA4tmzRr14uJoHP7Zt95XXIra3fWxlxvVc9GgI
         gj4+5LgIsgn7hXAwzKEPXKJj2+VgDMFuXbhb1eAbqywr961cq3xYP4JMsBr28FWoZ48C
         8FV5cUTS0SsCWMvVIYuV0mIzpB++wZQmKEQcINSmeqmdxTj+1aOs+ro2HAprRegjjW/k
         8MnnKu0U6PVZC6iL5bd1Tr7tsvnbElV1eI40NVW37kg7TWfe7omn4QET7SV98ra2fM6o
         HX+cQo4/QLDQLeWh3JvQRgT+6OqcyzoROK+1m9ac9xUqxXO0DNCflbtNf38xkWVwk9q2
         +4xw==
X-Forwarded-Encrypted: i=1; AJvYcCUWcnAjC2/59pR1P4fnFVf5M6Pp92Zt0y2AFbwWAE/m1lOFlzOHAY4GStzoRq2aEIgQwwYRK5z26lNQ@vger.kernel.org, AJvYcCUtMlDRYhUNQuNylqzvzdEhRXBR5/6+2CvyNOSJ7FhqXT4FOC31Q2JR4yMbPZNMUy1udeFTgVxci+TQXQsE@vger.kernel.org, AJvYcCXX21wQaBYo69NaL7Xn00FQshfMjQlmyKH93wL40vwzDL4bwf/NVi8sR0DCYIpS198KQgJbLk5A@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9OPunZiWzYwotU7I4embsfRDM/FId9jfzXqkWltccLQb2/3Z
	KfyWOotFRrXGNdb/mfiLKlwaNYwrUnv/qgmvX31vxShfG3OflHK/
X-Gm-Gg: ASbGncvGDoNo773QKogKYI4CXgio4Jj7FFZQADwFuqyzzQFdlGAgVhKAPeHGoIXeJVc
	/ReRCcK94CRtCKxuOBApAQkfsq3vwlDask3ZM1okZs5DkmtrAECYkQ5gRPGx/D9vKej03dA3y6Y
	fBdMYH/jclMpBrHt8fqT0tIN1sTwdSznt8nGt9Z+LebgNfM3qNyUlSoYYrE4euva71MeaGZmEcT
	zLkv2eAQUpfNT/kOB5abrXm0MVE+Ts2WsrM0/yzHl4pezkcC1ydj6KQwgfVHX0G3OhYzUanZHOm
	WxyUvUkTELav2vGImI8M9HcQ+hc+8FnpjB2BmJIw96yzORdv3BgGbT9bta4/UJA5xlWumF/FRQi
	J
X-Google-Smtp-Source: AGHT+IGWLcvkiw2IlWT9/Bezt8to1CnGT4k9RihRRIS9ghrz6OqCYVFB+fUqZB1wJCuaLVEvvjMSXA==
X-Received: by 2002:a05:600c:3150:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-43d84f8a7dcmr45977415e9.7.1743090562763;
        Thu, 27 Mar 2025 08:49:22 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe678sm41416485e9.20.2025.03.27.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:49:22 -0700 (PDT)
Message-ID: <67e57382.050a0220.3ce63f.a120@mx.google.com>
X-Google-Original-Message-ID: <Z-VzgNZ8jyQp9yMS@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 16:49:20 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 4/6] dt-bindings: net: ethernet-controller:
 permit to define multiple PCS
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-5-ansuelsmth@gmail.com>
 <20250321161812.GA3466720-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321161812.GA3466720-robh@kernel.org>

On Fri, Mar 21, 2025 at 11:18:12AM -0500, Rob Herring wrote:
> On Wed, Mar 19, 2025 at 12:58:40AM +0100, Christian Marangi wrote:
> > Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
> > can be defined for an ethrnet-controller node to support various PHY
> 
> typo
> 
> > interface mode type.
> 
> What limitation? It already supports multiple PCS phandles. It doesn't 
> support arg cells. If you want that, either you have to fix the number 
> of cells or define a #pcs-handle-cells property. You've done neither 
> here.
> 
> Adding #pcs-handle-cells will also require some updates to the dtschema 
> tools.
>

I might be confused by doesn't 

pcs-handle:
  items:
    maxItems: 1

limit it to 

pcs-handle = <&foo>;

and make it not valid 

pcs-handle = <&foo1>, <&foo2>;

?

The cells property will come but only when there will be an actual user
for it (I assume QCOM PCS will make use of it)

> > 
> > It's very common for SoCs to have a dedicated PCS for SGMII mode and one
> > for USXGMII mode.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > index 45819b235800..a260ab8e056e 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > @@ -110,8 +110,6 @@ properties:
> >  
> >    pcs-handle:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> > -    items:
> > -      maxItems: 1
> >      description:
> >        Specifies a reference to a node representing a PCS PHY device on a MDIO
> >        bus to link with an external PHY (phy-handle) if exists.
> > -- 
> > 2.48.1
> > 

-- 
	Ansuel

