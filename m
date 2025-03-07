Return-Path: <netdev+bounces-172957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B05A56A42
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB039189B170
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20A21B91D;
	Fri,  7 Mar 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj1vUZRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C921B8EC;
	Fri,  7 Mar 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357378; cv=none; b=cQmQFPKSJg5An6bXC3saVsc1pRUNfXD2NOoIzE+9i6368zdjG2ZQZMivQB5afSBZW7MiPO8CQSF3d0JDKJ+aMk3/6uH4gR/Cog9ljnJa3gEZhZyApsPenL6zgOjIzk2x1BTrNLDBAhSg2E0wunui3v8tg6f4+/YZyqwSx8AhjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357378; c=relaxed/simple;
	bh=GvUKH5oJnoRKKMs29BXEgbZczyorqGQcyFWXcpVYfZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thRt67sA+cmwJ2CD9e6Jn3Nfr3vZBbJIaYF62iqcmy74opnke8LFptwqEZVZL39sacMKrQjpQv7icl/AWS5IRp8EZdIr7pl+l7wmsWMgHZLWXHJyI3sY45iMW0Q2qU26XISmwHdq7PUYLwpaf9rNzphr+Mg9sUAB9wV9DHTSnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj1vUZRV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so11396445e9.1;
        Fri, 07 Mar 2025 06:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741357375; x=1741962175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PejxjOLcOPCBsN9OKYEARibmDmaIRCji7dqrz9O8QL0=;
        b=bj1vUZRVP0olf6N/2u9keEr5PhnHCnZJke8JRdb0+DqU9cNbbUYIXUXUu5wI4l8Nw5
         tTl5mMKfhcvDtW/viec0DvBizZampfd6SVUXaVfpSpS3DeqJyTMA6X/MAHBi0TYZnMzd
         hVUsH6LM2k7fbz/DEdVYJR00mel+hwkFn4AMYZEJ4vViqgmnjKNVTsg9NXLuIgDNGwwD
         5ShHhEvjlMKSboidXXUF4LdwPQaMQtj9Gzt7iLxwJxSw4Qj9jVx+9VovXx8l8CZWGfih
         Y0IeyyUaJb3QUp4Z/J5J7oB/KS+W7OZ0r2BaEoH1ekoZNZ0Z4PfZtt1FEMJh00+MA5O3
         riew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741357375; x=1741962175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PejxjOLcOPCBsN9OKYEARibmDmaIRCji7dqrz9O8QL0=;
        b=jkDNp5anGxzkIHXjmhC1R595RAJmhcnXpMmqtSthVBRjycHgSpGJj2JhFIBm6EYcdM
         MG+ARkSTL0ibwen0oW8dZOrxxrwPbO2G0VNBPOkYLcpXVFBYqLgzSzZc/ymKgZ16YV5K
         EDwmRnnQMHr6EiCkwG7hF51JD08TTqZKfnnJ9tw+E1UA8PrIgTzvEbkp5u8leMkqlTBX
         Z2yKYbCBwGYve3hYbfeiG9wwutO2TBKpZ9HpEFo+GO5rS9IdYOs7RdJ8GbfbBszOc4LA
         in8ZbsXihonrRbd/6EgPpjzBgfVodFtim3453RiUap8uXuhNhn3xWXO+xlT29bMG767X
         m29w==
X-Forwarded-Encrypted: i=1; AJvYcCVGZSlwzkM8uPG3YRUpFw+RUqvJY7k3hXF+dd48mkRf7sWzDTRl9ckGUZ3EQDQW0xaRrqAtcYIJnzYF0kdt@vger.kernel.org, AJvYcCWLyuMs3Pyp+mWYax32UUjw5PD//PykfkPsQTfvhUS6JV0h8EZoCpPOB2ANlwDDTdlSQp7NZVD9hcxu@vger.kernel.org, AJvYcCWQEQpipsnXZhC8WBAjHqrZ5j+xRmLrybAFX952vr1Ff8lx8U4NZV6HLgGsXpld9Ln3Kz+JdA/C@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIXKYHwMWvGysPLQcYL3lT81bX2eOFPSyRNzpTEXGnoVeWYTZ
	oS0D4t6ooW9lKTVZR4etWaYTgO2rX9uIVT0snB5j96IhgMt82aE8
X-Gm-Gg: ASbGncvcP+8tkuqVdfHorLsLb9bUWeygWvwj0PnTPHiD4AHc+l2XTpOMyISFq6RZ3Do
	BccJUbyFKbgbQpEg5ieeKXycYOt8AiGVi2AsyB3gfsy2lo5vXVLG6w+yT+2X58deVbd0rX2FtNr
	Ip2THlUuo8kaCu54I4qGJOaW4w1J+HuV71Q1FCWDXAugmIwvCYGhGLE2+yxzsWIC1kTX4vM+5En
	muifxqw7YpohdNMBvZjGtsWlyv7mS3tHEswYCrJmGoZlJlHnwzjKaoZftqofYXb/vS9ZZdFLpFW
	tB9v6KgbU8t4jNiHWlgNVdAMFYuZxbaW3FbwAQcXOfk=
X-Google-Smtp-Source: AGHT+IHRSH7+mnghk5+K6OY1NH52/2MRSnfqJmNP3IiaQH5tQ5r0hWfDAhatgkUrfGbEuoehDRIFqg==
X-Received: by 2002:a05:600c:190d:b0:439:99ab:6178 with SMTP id 5b1f17b1804b1-43c601cf229mr24881215e9.6.1741357374842;
        Fri, 07 Mar 2025 06:22:54 -0800 (PST)
Received: from legfed1 ([2a00:79c0:614:ea00:1ebe:eb51:3a97:3b47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd948c1bsm51706755e9.36.2025.03.07.06.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:22:54 -0800 (PST)
Date: Fri, 7 Mar 2025 15:22:52 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dimitri.fedrau@liebherr.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: dp83822: Add support for changing
 the MAC series termination
Message-ID: <20250307142252.GA2326148@legfed1>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
 <6aee57d3-8657-44d6-ac21-9f443ca0924e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aee57d3-8657-44d6-ac21-9f443ca0924e@lunn.ch>

Am Fri, Mar 07, 2025 at 02:39:32PM +0100 schrieb Andrew Lunn:
> On Fri, Mar 07, 2025 at 11:30:00AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > The dp83822 provides the possibility to set the resistance value of the
> > the MAC series termination. Modifying the resistance to an appropriate
> > value can reduce signal reflections and therefore improve signal quality.
> 
> I have some dumb questions....
> 
> By referring to MAC from the perspective of the PHY, do you mean the
> termination of the bus between the MAC and the PHY? The SGMII SERDES,
> or RGMII?
>
- Yes, the perspective is from the PHY.
- Yes, but only the outputs towards the MAC. Resistors can be saved on
  the PCB when they are integrated into the PHY.
- The PHY is able to operate with RGMII, RMII and MII.

Should I rename then "mac-series-termination-ohms" to
"output-mac-series-termination-ohms" or similar ?

> I'm assuming the terminology is direct from the datasheet of the PHY?
> But since this is a bit of a niche area, no other PHY driver currently
> supports anythings like this, the terminology is not well known. So it
> would be good to expand the description, to make it really clear what
> you are talking about, so if anybody else wants to add the same
> feature, they make use of the property, not add a new property.

The datasheet calls it MAC impedance control, that is what someone might
want to achieve when selecting the proper resistance value. I named it
"mac-series-termination-ohms" instead to make sure what is done to
achieve impedance matching.

Should I add the proper description in the bindings ? Description of the
properties are somehow short. However will expand the description.

Best regards,
Dimitri Fedrau

