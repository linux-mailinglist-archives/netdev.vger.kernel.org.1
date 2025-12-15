Return-Path: <netdev+bounces-244707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF5CBD6C2
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04619300CE3D
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417A199FB0;
	Mon, 15 Dec 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dq1hSwv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5F329C7E
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796359; cv=none; b=OwsfCnXUuwOfxLW6Uc6ZXxPH6qCEqogdFtdBJQPvsxSU0bkUdRPXc1OBqQWcg/XT+oPA4431oA4QZHQ2VjV3m1mYn5/goZukl1UpQRIuSyflbGVVTaAxIApWE9v9IEMHAi7LuLEZuxEOUS7XOz3dBw6bG6n0lpQ7Xz2giw2mbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796359; c=relaxed/simple;
	bh=djrbPV7aDjAG4Ht6zJYVPSbYH7m2DhrIo7FgNqH8XGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQEvui6X2AvF/Fj77d5mS8dymjsEPOzyJQZSd3ILoggejy0v9IHVxS586leccq2UOr1CwdXAeHbSv31BtpgcpL1gh8vGTmKL5hB4SccUaLD9IH2z+hT3PoNiWOqsdler/OdODZ54U63h4Tlm5F27IB7M24+z1a8Ub2IcsS5VZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dq1hSwv7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so26105975e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 02:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765796354; x=1766401154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYqXtVKyq57wNwuuGpuKCQcMdBdTV6AFm/yWfAMKePQ=;
        b=dq1hSwv7Bf7kevWDaBVK2hYzelzZep3k88xx7Es6Cv158rHVW3rFbeqPfMn75fdl8C
         nL0i5r1lZ32nPCDmdybIuC3hTXvkyjy/VJbCjfJWoq4jy4hfChqzh5KRMbFpuWZ5nZxj
         qOAuB8Jg2eLInUdJ7cF2vqrE8MNSstrXNd2manO2V6HrWRuXgFBIjwvvVwY1vF6g3Tj8
         CXiPKZ8QU0yk7+BQEqZABaq0UBMHILqJZHQiy/8o6B5KmjD3LMVC3rEhKLYhJ4sDIE3w
         dOnWeV5X+8oyobrbf+c0yZntu+FvTp7Ig79M61biZTJk5ApFlaqZauVh1f1sMdXIGwYG
         mBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796354; x=1766401154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYqXtVKyq57wNwuuGpuKCQcMdBdTV6AFm/yWfAMKePQ=;
        b=Y2O2PkU8WvoewKsoP1UC1fxEoZm/h6g+EKDpm78dYj78oUluJyihv6eSOZlCAvTWoY
         nlpIAoGfZqgMpIvFBtdkdQRURNClsg3KbWjzHKfar6clcggIf8TEftCqLYDzdT1ZgIOM
         Ix5KY8beVAQ1xZOUNoVt9PVN6/9CHj0QXa8DQO96kCUwo2lVGUJLNklp5B23P2/vPTpG
         UK47KfnRJOrAO492WbCesLRyAuF9TnD3C1em+tAQo5vJ36wHwECkbABOOab9RHaOiHrr
         xh71DAApFeZxK2wPFfdNmcRX7xegziElAcpNGs3qAEw11pRjUmXP+6oCvUDKvyXlBDxF
         8OMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmwGmOLgmYofV9Va5xdG8az+HJUsFljbD6RaRU9/wjPVn13ZXvmwl6t8NalsJXi9CRo7vlY6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzih9qjbcnavln0hS2sqem6nmn4/EG0XKWtyc74ag/f+JpIhieD
	mOK0Lf6CkqpfNCVjEad6lASwAclqPrunnzNfMLxR1vYsopgHXBpbiy3aQYJ0lyg6yNE=
X-Gm-Gg: AY/fxX7Omwn9Xo4HyLPGJu/ay6v/C8T90m64+k+gdJIt8bG2Tg8p09MjpVuuzDohjwD
	aXkN1jqiHgJR2SUgySlmXyd7faj7yV2Pp3YXG7zTBxVf3UFPAlW7fRvi3ljRkush3ph/TcA/vWn
	xdN+DhBXt83cLOa34X22XHhHOBEee5cDCI6E0PIob/h9vSwAuKA0dfV5p0/saUV3Pi46UdF4Fo7
	X8EIpjlepqPCwmZt8tQUo1OcjHhsXJ0HEifVw094sfS0t67/inYlLq8B5dehQ/GliJdM5OGs7tl
	A/O9XSgQSi2+B434oCH0IBV8rh+fpNW+qi0onsiucpV3AKTzZcCze97VyVMsFAFNQ9jak2ApYKC
	kkZUb4hjd2lpJTZIAXuY8pmlnfV5gnXlKBaYyPOg0+sEY7+Tw7G7b57+1Zw1hmykiJaoyRW6J45
	7gyWiOjz1diucFMbPi
X-Google-Smtp-Source: AGHT+IHzuHMc+1EqAojQlJLPTccSt6L/oqVylXvWSnMxI2jVuwsY9rZt+YJM1Zn/rmatqjYye/VhgA==
X-Received: by 2002:a05:600c:a31a:b0:47a:9165:efc4 with SMTP id 5b1f17b1804b1-47a9165f157mr86631275e9.33.1765796353574;
        Mon, 15 Dec 2025 02:59:13 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6e5baasm191989945e9.13.2025.12.15.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:59:13 -0800 (PST)
Date: Mon, 15 Dec 2025 13:59:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH 3/4] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Message-ID: <aT_p_aGfBpyEOC3M@stanley.mountain>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
 <333487ea3d23699c7953524cda082813ac4d7be3.1764592300.git.dan.carpenter@linaro.org>
 <16bb96e9-c632-457c-8179-82c17bd2a685@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16bb96e9-c632-457c-8179-82c17bd2a685@kernel.org>

On Mon, Dec 01, 2025 at 06:33:07PM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2025 14:08, Dan Carpenter wrote:
> > The S32 chipset has a GPR region which has a miscellaneous registers
> > including the GMAC_0_CTRL_STS register.  Originally this code accessed
> > that register in a sort of ad-hoc way, but we want to access it using
> > the syscon interface.
> > 
> > We still need to maintain the old method of accessing the GMAC register
> > but using a syscon will let us access other registers more cleanly.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> > index 2b8b74c5feec..17f6c50dca03 100644
> > --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> > @@ -32,6 +32,11 @@ properties:
> >        - description: Main GMAC registers
> >        - description: GMAC PHY mode control register
> >  
> > +  phy-sel:
> 
> Missing vendor prefix.
> 
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - description: The offset into the s32 GPR syscon
> 
> No, first item is not the offset but the phandle. You need syntax like here:
> 
> https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42
> 
> The description of the first item (unlike in example above) should say
> what is the purpose, how this device is using GPR region, what is it
> needed for.

I had to do it a bit differently from the exynos-usi.yaml code.  When I
tried it that way I got the following warning that the "phy-sel" wasn't
a common suffix and it doesn't have a description.

$ make dt_binding_check DT_SCHEMA_FILES=net/nxp,s32-dwmac.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
/home/dcarpenter/progs/kernel/nxp_gpr/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:nxp,phy-sel: 'anyOf' conditional failed, one must be fixed:
        'description' is a dependency of '$ref'
        '/schemas/types.yaml#/definitions/phandle-array' does not match '^#/(definitions|\\$defs)/'
                hint: A vendor property can have a $ref to a a $defs schema
        hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
        from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
  LINT    ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts
  DTC [C] Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dtb

The exynos-usi.yaml file doesn't generate a warning like that and I wasn't
able to figure out why that is.  But what worked for me was adding the
phandle description like this:

  nxp,phy-sel:
    description: phandle to the GPR syscon node
    $ref: /schemas/types.yaml#/definitions/phandle-array
    items:
      - description: offset of PHY selection register

regards,
dan carpenter

