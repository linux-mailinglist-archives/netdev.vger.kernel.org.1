Return-Path: <netdev+bounces-180402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42630A81363
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498778A2350
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160E2356CC;
	Tue,  8 Apr 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktH5wggp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798C155C97;
	Tue,  8 Apr 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132717; cv=none; b=ce5jrgv9ek3rZZdElA04lCcWJGG8wVfhIe2bx6K+y+AZWqe7Aa2C6/53vSxH1ooZb6zvJ6SjLgmfmHA+hBPdHGM+1JgksYZ4YGsy9N6y8f8y5hUmoi7kQggmLix3Jeli0rDDaBKI0VS8Iu4/BCHRbGj+teyJNn2Q60cu5wVEA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132717; c=relaxed/simple;
	bh=S5hwzszlwJNLau0VGr3CkyJrBYombWM4nx71saH4Ut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyvbmkpujZMEYyTDR/ez/QE+i3xIaN85OsSKCviTbWJ4tzvjsfBObF3KkbRBN3IgDDIZuaLAcRJr6Wb3ApTz/I3SGSd2u3nMNArYJucP7sjH4VKIKEU9as5a/j2UIv1cT3VInbUjKegCJ49R87jLTtomV1BXC77rxaMQIPrvY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktH5wggp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso37568255e9.0;
        Tue, 08 Apr 2025 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744132714; x=1744737514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CiTIXeZwnuUauUrRwauEywvsU+gyTYIu7GFp5cUTyWA=;
        b=ktH5wggp/d51Xs89bUh7l03uvBSxtCtNk0qjyZ9LhLptwohvL5EsXSATJKciUNz2L1
         HgxGkSaeCwVgE3iaGTAIqQ6/JJNGIhxiNmiQ5JwRkawv2G9QUOhBuAFobLDwyDG1Lk7Z
         NHW2CxtgqNVCtKYoX9LAB/jtb6ntINJ26BRyCz0hblozmX+KXHrxp/ujOxk7G/UvCJX7
         wVM5UPlZuhuygnw7rhsWBeOGN95u3WQBKJTr9E+q40sCyV7ZWVaw+jEyywGfVMHJCRhV
         fhKbhIMdIxgwLcscHW4g8MRfvm/3SoivcB8gzusstKVUuV/r9o8m1rSSGOqbCqSJoxvR
         TaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744132714; x=1744737514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiTIXeZwnuUauUrRwauEywvsU+gyTYIu7GFp5cUTyWA=;
        b=s51yvC0E8jWg78sZ2o+Pt6OVmDEVfpvdkZYuYAqn33xOOFxpQlTfR10vHgS4Z4kRy7
         qt9FCfr6z7DP/Vl8Os/X0nSq3LnOELs0q6QgA00IwUR4wEXWLK2dfV6E7gFLDmGTbmvH
         Pp2zB71QtxTmfR7S0kurYoKusGfCFWhTTMiW7+ZOuEu1S3W4zoUhgA4BiUXF0sOXkeJn
         du6p7MH4yHZ8iAy5PbywjvoKyv8budK9zZ1lw63VhcLeZwb05hbsi7xl6baFZyB4ubxn
         12D0yUVGJ3TzlwrGSlLnC9KKN+PRjFioG9rKXrWKk+6TEI44C24/7S0gInxjdH+tPZ66
         7N2w==
X-Forwarded-Encrypted: i=1; AJvYcCVNhEX7Q3ICHC45iOufe8z5PKujfmSZN78l69z82vTPRhmEtgaj2tSVH0xYe7PsWTiBsgK+tbB3TJBOOwKr@vger.kernel.org, AJvYcCWBtL0RGbnr5xiaA4nUN6GiPeWTuR7Dn3nrnnVFCQD9yj/Ivwbb7wuuWjWbI2sLlYyFYEXN4PiM@vger.kernel.org, AJvYcCWK5pXG/0TSmuT+3mg4ZQXMJ+v51oGXTdKlwvnX2BiNa/UkXkVMZTI75trVLCM5hTE6euTBn55RRhOc@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxqi7zH6sfuhKutUFRcluMqKcsgIS+2PHXzOuacJiovKujNzm
	nuPs1S9pdhugjwFu2vrT4cBblpwLYTY+dtLFfPyhNXV5022TT38r
X-Gm-Gg: ASbGncvqwbic9rLQFpi8sK4b2k1/23FACjMJwXKoUbOj8rHZyvhLYjeVKED7+SRHE7e
	r0GOclqlKw+Xrulcli/GvX1sNU2QEXnp2NRFwruPZ6zgjoSQZNn/bCNO4dPd4iKh8zFp/f5hF57
	RMUqNAbck9v5qkO63D6UIZRnLMJvG5LrzVF86UF3RzdJlZxMKm5QeZl92wk9nZbnAKZ+MdzKDns
	GAz3rQugdJfQn5RhStezNEbmE+IrXx02UvNU8sfQ1BfGz5NA9kHrfHVBNyPgtsEm4hfABSz9ULU
	1OvAHEztB40IFyk+J6oSzPlCH36DTEWDv2jRqocSKQ==
X-Google-Smtp-Source: AGHT+IEYwDbT9p1L/2oYWlI1MhpjtEFHvct3vhuaSgjgtsPmwFS9knRYrA4BJDAEeuvpZbxKlYVQvQ==
X-Received: by 2002:a05:600c:3b8f:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-43f0e64988emr40757195e9.15.1744132714292;
        Tue, 08 Apr 2025 10:18:34 -0700 (PDT)
Received: from debian ([2a00:79c0:63d:b300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8d67sm168016435e9.12.2025.04.08.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:18:33 -0700 (PDT)
Date: Tue, 8 Apr 2025 19:18:31 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Fedrau Dimitri (LED)" <Dimitri.Fedrau@liebherr.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Message-ID: <20250408171831.GA4828@debian>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
 <7dbf8923-ac78-47b8-8b9c-8f511a40dfa3@lunn.ch>
 <DB8P192MB0838E18B78149B3EC1E0F168F3B52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>
 <04dc2856-f717-4d27-9e5c-5374bb01a322@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04dc2856-f717-4d27-9e5c-5374bb01a322@lunn.ch>

On Tue, Apr 08, 2025 at 03:28:32PM +0200, Andrew Lunn wrote:
> On Tue, Apr 08, 2025 at 01:01:17PM +0000, Fedrau Dimitri (LED) wrote:
> > -----Ursprüngliche Nachricht-----
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Dienstag, 8. April 2025 14:47
> > An: Fedrau Dimitri (LED) <dimitri.fedrau@liebherr.com>
> > Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Dimitri Fedrau <dima.fedrau@gmail.com>
> > Betreff: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for changing the MAC termination
> > 
> > > > +static const u32 mac_termination[] = {
> > > > +	99, 91, 84, 78, 73, 69, 65, 61, 58, 55, 53, 50, 48, 46, 44, 43,
> > > 
> > > Please add this list to the binding.
> > 
> > Add this list to "ti,dp83822.yaml" ?
> 
> Yes please. Ideally we want the DT validation tools to pick up invalid
> values before they reach the kernel.
>
Ok, but then I would have to add "mac-termination-ohms" property to
"ti,dp83822.yaml" as well together with the allowed values ? Ending up in
some sort of duplication, because the property is already defined in
"ethernet-phy.yaml". Is this the right way to do it ?

Best regards,
Dimitri Fedrau

