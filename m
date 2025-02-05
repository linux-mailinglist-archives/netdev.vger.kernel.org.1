Return-Path: <netdev+bounces-162865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FC6A2836C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 05:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36261641D5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F58217F23;
	Wed,  5 Feb 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvxmL/kz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F420FAA0;
	Wed,  5 Feb 2025 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738730638; cv=none; b=TF3j9TSSKS3cpMC+8zhYx3hBXAuE5wWYyodVnJkNUUU3++QYTx3et+hOxh5XxQezENuoS+6NB1Chu/ISgfgi28wqYHI7wMRCAyx4d7lywHwEi9pkiw0d8IIsf7gtkS2A0OgY42WElQ+plK9Dvt2qic5+OKN96hzglxB4l4gmoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738730638; c=relaxed/simple;
	bh=FCeGUPKsvvCyKeFqox4OE6RFUhrCVn+hS26N19D9xAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVrATZ5JirYjXz0dwXuLBDOy/4m0Adn0DobfUehmf1ugasZ6Lz/cb7a3kEr0kj9VZl6bIacwv0Ma2PqUcq5slALiGrS2TJUVTwVf/p4W5YhpIXBt4L4UCusxPSsqzF/y9OxwS+tvre5w1Wh0ea9WltDSeZn/HsH+kxeNZ3QsH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvxmL/kz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43634b570c1so44710995e9.0;
        Tue, 04 Feb 2025 20:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738730635; x=1739335435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MeueWQH2gkF6PFSsIyc1iKuZuH/4fSL+B6k2prNZ2+w=;
        b=YvxmL/kzgMIar9F7tXs7c+Enjt6/s1dipF31qgZ/sSml5+DlVj0YWEFU8omp9MuA14
         nNgm6Rm3Q8ttrkupvFUcTkDNH3pyh8Wa68aR6CfiWEJdT+JDm2AjDpKNBV1C80NIbeZy
         CLvdZLBWCG1Xu2sPCIW2B12lfHgEisNtLXHTTG0FFOR5UCoDjsotvEBWViEI/UprXIbU
         /QTHFY/wcAv/2YHwjCbnRKVBD+Tpn/pX/v8ynTqItVozQBtydRA7hsjPJX/2APtToaEv
         9PvdizbGYAmCzx4VX8Wm5RYVvzFQsVS/Jqi8N27unbUhamSGY+QODVsdJEqQhbzc1HxC
         oJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738730635; x=1739335435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeueWQH2gkF6PFSsIyc1iKuZuH/4fSL+B6k2prNZ2+w=;
        b=wlKBWkWyaWamtmFDd/Enim/L/MQpIfAHUU1J/vb3nTEK4oF0/lTKnpLjDlH0h/6jef
         cGL6FQ8iJdTCgILw7oDOLdwArG+My3d2swGiN/BpE7mwPXxTZpR6fiASsSzudPvUP/sV
         nDLn8JpmeDi3yWsFsr8KVvSgEqSZyBBfYsjrQAgX8JU80UhrHYl2mXYXSrxwGJAB5idn
         x5MEUpn9YNcYu6aPS1vWh0WPB+e/XaUQZ2Cfb7jWZPDy2KSIuznMKJReDXBCNg+ixMY7
         DfuYikfU5rtZO010l/FxprV+ipDDGZVOXYpbHJjsiPjiOWmqGqVijEcomor91hQ0eWPc
         bdtg==
X-Forwarded-Encrypted: i=1; AJvYcCUKOlPFiwtSK6zKZXIovRK5YA1siQUg3y9MfXT6a0FIGgFh8NbuGvS4uIgWdc5TfG/E37GsLoJGu0IC@vger.kernel.org, AJvYcCWAuorW4xbVbJFbD8DcOnAq28xF7iuVRl8t/bMOR6DQh6hDJ2BLgdK6w92uYtgevOb95niamU/+NxfrSCcp@vger.kernel.org, AJvYcCXZx180l2s5HouA0qskPMQi+M+WIeVTYSzceLUSaBFpwC2aPcvLrYz+uoJLOqa6sQMsdyjU3yGl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57iAOc1hK05P8cYXGBE2wPJXfpaFOtW+m63rLEXuN7gYhWVfW
	X9ntPCiWxrOsz0yWxvms/O6v/jkX568+lnmNI8K0rxi0Rc8DI6df
X-Gm-Gg: ASbGnctjOXwVOpNy/ZLAf7ynZ50E8881lTby/nMc4zEjQjq1QkzUhjEeFg5bA1UPNrt
	BVGnHDT0zcxSy/tErc0IwSKOouo9etOWDNUCTRRoCMzYO3+4mSyrInEjjv/DnfsS21hOMsCYwdr
	jEMcEch6W+LcPRlX8CjnZurPgs+m5DvXmqOFazGTUalPhuFFKhpopT2rVpOBj8uurCYIzrRR8EE
	L0nQx22Ue47ApG4ed4BDiUyG7o1ux58G9eBkcsPTQT1P4nsUOJ65VsYcGzycJ5MMkTVesUjt3uk
	E8wX9aclSbeC
X-Google-Smtp-Source: AGHT+IHim/qQSXAp2trAKetGQxzqxN/o9+n5pBcBGfwYnNtjzFKGFwpRx5LFDGnn1oQq2RDf6KAWng==
X-Received: by 2002:a05:6000:1445:b0:38d:b114:4be4 with SMTP id ffacd0b85a97d-38db490f4fbmr629649f8f.47.1738730634562;
        Tue, 04 Feb 2025 20:43:54 -0800 (PST)
Received: from debian ([2a00:79c0:661:ad00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dac89b519sm3390949f8f.100.2025.02.04.20.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 20:43:52 -0800 (PST)
Date: Wed, 5 Feb 2025 05:43:49 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Davis <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <20250205044349.GA3831@debian>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>
 <173867928985.2681882.12579959912610885418.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173867928985.2681882.12579959912610885418.robh@kernel.org>

Am Tue, Feb 04, 2025 at 08:28:09AM -0600 schrieb Rob Herring (Arm):
> 
> On Tue, 04 Feb 2025 14:09:15 +0100, Dimitri Fedrau wrote:
> > Add property tx-amplitude-100base-tx-percent in the device tree bindings
> > for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> > necessary to compensate losses on the PCB and connector, so the voltages
> > measured on the RJ45 pins are conforming.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ethernet-phy.yaml: properties:tx-amplitude-100base-tx-percent: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>
Thanks, missed to check. Will fix it.

Best regards,
Dimitri Fedrau

