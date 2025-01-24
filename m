Return-Path: <netdev+bounces-160739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C801A1B071
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045073ACD84
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6281D90A7;
	Fri, 24 Jan 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA2A4xWk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5D1D6DC8;
	Fri, 24 Jan 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700617; cv=none; b=G6KijQuYmwVOGXQf8ded6pUd62TpszdldnVLh9AlfrOQPUgntl0pue8+jxxlNBjgsXkZVwr/VoBAYokoblTGOR40YUm3bph1myJQveVXxjHIczle2h+NIIUNbJExlCXhufVI1Jbh8X2AmYp8MlRQNWzkllYNCgbQWgN+n/IlGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700617; c=relaxed/simple;
	bh=L/cxqniFp/YvovrC3aJ7w5qlG0gQyGBbm59E/eveoSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI7c++3rNC1JkUQeu88ewAjzSMs2yl6w60JhAAhTxmc6Z8ylyIaVjdE+N5Gx5zDWIUzCEeWQVmU1vG82Z47M5XClC/cq0NOqhGYZayOvwPcNmqeqO04WQQWc19tn+3m/RWmU5hejy1E1g6vFLZyKdPZoSPVs947/o2U5cuHvM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA2A4xWk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1243935f8f.0;
        Thu, 23 Jan 2025 22:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737700614; x=1738305414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qD42bGDiKgUU3jqwhIoJJ3N7RjHnLjnUN9aCwhVaCNA=;
        b=aA2A4xWknNeNloQCs5LWoMZK6AI9SYusRSQvIkWeE+j4rOxn17KwEZU/3cTNFeXrGj
         HAPGlDeZx+pfRdb3pNcRbW6Gu1OQMlQhbOjHcTyDkETJZ1+xBUi4gIxi8uDdl4TtUzG7
         UfIj9Na06jbXSQDxYBOz0UaaSIiaw0Yh5/zcbvlaYKIBLore1PY4Oah8TeWLHop8QOqU
         cJNC9OD+MN0C1NX3eJbYQFf5lruqm0b/feekG5LzzgZ3Jtl+Olk3tMtqIrbrGBhO0lD/
         vbMv6Ko8ZF1sDRCvIRtomQ9Aa3maQ0irV9NIaz/qv4pWkUmUfi/UeFum61UpY0g89irS
         GWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737700614; x=1738305414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD42bGDiKgUU3jqwhIoJJ3N7RjHnLjnUN9aCwhVaCNA=;
        b=kd+kI/3GPW1Et/CQ6WU9d3j7ZO/pOn4MiJF79qQ9BTaUIrNvZhaoXE2RUKOVfPcA1d
         bwk5P4nKfJO75jPDvgX+rKAJ2FR8Pb5GuYtsTKEIyeVJuqkffScasOxlHA9BAWQt3U95
         sLidE7jOdF1yRaz/75YEpDT5vxA/DvoCLQLgmvMySub2m1vqCPfbDA6OzOJ4YuSTTNDZ
         E+7bUdcYvJCldm9t1coDfZ1D9qK8RH4kttYMniyAtRJtcUFk7Ly5GJdIhPBDLNdkGKoK
         zv7PNUynH9/KNWs2R/O9nor+fmiJMuGCvF9ryjUT8MHlvVihXjQDBKG0CPLRajGffKXA
         h6HA==
X-Forwarded-Encrypted: i=1; AJvYcCU2XnME7bVJyHUYpf1Tritdy9TUNAvVotlV6QrNT/0jTiDd8QIOHhsCAwJf97zmc2DaEQIifEu7W/tO@vger.kernel.org, AJvYcCVbRLFOCAk0p8Do84o0KsC3Id4JzwkVb86Ei20DYcA0gRY4FMbS8MgRvv9xCDmA7ruVOdkt/ERN@vger.kernel.org, AJvYcCXkc8Jl3hPfve93KKjQitWjIR0sXMvqPYMcAtkQ4jBAfjU3hDvZDBzctzxK1Rf9q6CYokR8y+kchRevKZxb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjo8NIP8RJbietZa9ogtJHRIVDtxammdobsprfUN4xPyrf9UUV
	fIU5fzKxnmNIU2s88upjASmPZS8/4c/hvQ6Y/b3HLdZiCq802G10
X-Gm-Gg: ASbGncv4sxrGUFDCatQl8+jQU3YlGO8Gax3wHaFvXo2iC24CxQgfyXBtqOuQchZ6wL1
	MiIegHXXq4r29pRfdeIicRDF6LQbJpvdgEz1p3i+ZDuum5Z0hhZdQra4ioTqX9OQTot1z1gV+s3
	eJy8o6TTgIuz+GCSirPfAuwpdpAc82wWZFfqCzxXghQ+IRLz8CU9ZPp1aYQNXl9LbdovzuFEu8x
	E16EahblRwhutKnnd+7lqBno6CiU/rw8dj8AP6VDM2SxGmn9661tEMwGM6SJ0Np/PP0IIDwVpc4
X-Google-Smtp-Source: AGHT+IF/tPKOK5uKHtTT55cjsVYoXp0pX/8CStvn6oo+Uu7E0hNcuca78Ym4KT0IHBa4IA7aO4lbsQ==
X-Received: by 2002:a05:6000:108d:b0:385:f677:8594 with SMTP id ffacd0b85a97d-38bf57a238bmr21881677f8f.43.1737700614224;
        Thu, 23 Jan 2025 22:36:54 -0800 (PST)
Received: from debian ([2a00:79c0:60b:6500:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3fedsm1682552f8f.85.2025.01.23.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:36:52 -0800 (PST)
Date: Fri, 24 Jan 2025 07:36:50 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-gain-milli
Message-ID: <20250124063650.GA4002@debian>
References: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
 <20250120-dp83822-tx-swing-v2-1-07c99dc42627@liebherr.com>
 <20250121-augmented-coati-of-correction-1f30db@krzk-bin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121-augmented-coati-of-correction-1f30db@krzk-bin>

Hi Krzysztof,

Am Tue, Jan 21, 2025 at 11:17:34AM +0100 schrieb Krzysztof Kozlowski:
> On Mon, Jan 20, 2025 at 02:50:21PM +0100, Dimitri Fedrau wrote:
> > Add property tx-amplitude-100base-tx-gain-milli in the device tree bindings
> > for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> > necessary to compensate losses on the PCB and connector, so the voltages
> > measured on the RJ45 pins are conforming.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 2c71454ae8e362e7032e44712949e12da6826070..ce65413410c2343a3525e746e72b6c6c8bb120d0 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -232,6 +232,14 @@ properties:
> >        PHY's that have configurable TX internal delays. If this property is
> >        present then the PHY applies the TX delay.
> >  
> > +  tx-amplitude-100base-tx-gain-milli:
> > +    description: |
> > +      Transmit amplitude gain applied (in milli units) for 100BASE-TX. When
> 
> milli is unit prefix, not the unit. What is the unit? percentage? basis
> point?
> 
I think it would be better to switch to percentage. Resolution should be
fine. I would switch to:
tx-amplitude-100base-tx-percent

> > +      omitted, the PHYs default will be left as is. If not present, default to
> > +      1000 (no actual gain applied).
> 
> Don't repeat constraints in free form text.
> 
Will fix this.

Best regards,
Dimitri

