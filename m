Return-Path: <netdev+bounces-176183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA67A69442
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2614420BE7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF11D89E9;
	Wed, 19 Mar 2025 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekq5pEBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824E17A30D;
	Wed, 19 Mar 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400203; cv=none; b=V0jgZoeTHE0yNz3tBz1nrynfNBGE5XxmB6aSl0vLfhVt2xgJ1IgYcvE4IWglb0lG5NlckjOCDdADFA5vb+qiU1ElO63YGr31qJnMbOQSE1bcb6IUgZAXPfSHp8PDhGWR0T0G9I+YZ/ATrKLEtcIHFP5xK2zjSUH+qsCTBPpbTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400203; c=relaxed/simple;
	bh=DVuO35F8L2sGQbqiohJsEyTDnHO0PLruhpjNe6ZaCVQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNaXzmDglqZN5Q1VmYD/XsonVqjNj8EYpNhHUS3FyJqb0GaMZyQCpF8jxU8fyTFNPf4P4+1em1ZpELdXf/sAjEkrq/QPdyk8+/3/NKlq8lACSgsBAd7NMMRjZSl6O8zCx2WVWL/4zlUx29omU8VsuA6ChF1xS1NxohuCzipQw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekq5pEBm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so44233755e9.0;
        Wed, 19 Mar 2025 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400199; x=1743004999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AWhqVdk5lizfnM45diF6+c9BNO2vPL4nIMp/akx31Io=;
        b=Ekq5pEBmjqviBh5mZ7guZgFUIP7phLAyfx+ltS9mAAVcmHyqGM6FS4EW5he2o7EQ0P
         RMZuodNJjWR19Htdb3UO3zCiq0W10tZvhkg6dGar5Ea1odJAjD4pHDDMg3DqskoK4KOo
         IF9TcfU0SSu2k/VMCbHN7rSb22U1u0cuVUM7wFumAoUnEhG9L5U35DfoSl9XCK211ouV
         RPeKS6sOfuOJaDzOZjcburcF9sgtJ1k6tlJuLlus9N0gPn9Q93RrVfu9PPNZ8GM4ezv4
         9WXC1sk5bJ01Vm9QyPjygaRisShpI1fqiYxFZrVVCiXr5+ozQbM/WNbYHxeEbVW1TgI4
         Qgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400199; x=1743004999;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWhqVdk5lizfnM45diF6+c9BNO2vPL4nIMp/akx31Io=;
        b=ag+zMTxtW0VkR7NJOZoNjMPvl+ZUlnfNU5FnAGZvVR7487Iatr6P+ht6lYnZxUT98t
         ZD56pASLf60glNvMMZv0XgxPiFvNBFYKsFAGkdYkaOnyy0Xp7KpJe8tXa3zbOnx2FArM
         y2cbnn5J+kf3pDhuDMUkfA1Z2Zlim3BUoZ3y6tRg1Ve3mTpbGOepH0mRtUaIQutBXyE7
         JExBHiMMU3H45XEWNXZiNytqZ8dRYa4ZshYf1K8bXSrT7kpahqGNSI7qAe4BVSFXhhts
         I3vuLTFC0WHibniyflx8B/7mRClU1JVg9aeXDXjg0gskmRBt6okTin66xapBn5fdzw9X
         E6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUdqM8JBTdZ1bieScYUvpyCXv7zJWBTI40Ne5aqYb2jDQxODHJfH51A+Xhqa77bbkYqz0tIUzoODjWk@vger.kernel.org, AJvYcCWCsz5BXPIWLg6EtQG6vMNb5Wmf1rvmIwioSh7l/yVRpp4F+HEv2X3iM3Jg9t3Y/WRDkICHRdKBpKzBGgIf@vger.kernel.org, AJvYcCWoZeKN0zbu4OXOAlONp6nkE8dBT3oL1Z51kCQlU5Bi76cBMr+Hrwf57msC253O52Dji6J7tdgA@vger.kernel.org
X-Gm-Message-State: AOJu0YxpK+OOSrSXSKmvDL5mYDUUHXnZX43NGliIOFer44Vv1OHSfG5N
	0eFoNnQeL2PLjg1H9ax3imsiy00J+QrUMAZqsjWJ06ptG/UeieqH
X-Gm-Gg: ASbGncv+c8U0/GzCVby1n/VAU4wosb8e5kXHO6pJWR/hjUutDYbY4PYbglWdbnaDXLI
	W+I4YKtVxd3fHxjSGyxBPngXi7wiBgDJgi1jNff1z0wohlp77ZL6QfNkNHkW3Bt2OCerbLbrApi
	R81Uz/3y6mlL5j+jY+AxED0j5q6xcYQ0Wp7xgPhcmtwPavlCD9TJ2uDkY6Da/M0A/LgOmkqDCo1
	L4BBUFFXf7pYM3s+X2QGHWtvvaupfR3F+yQcJuCEvmbrCdbX6L98qkpw91I4TXRSq8grQWlG1/0
	H/248bW9Sfp7qfAM8vuxHZpt+hVfYZa0hrMS63h6L7vSH6Wk0F1gqyGDtYQ7FlQGiId2L+Uo5Yz
	KkbgLU9dOlqo=
X-Google-Smtp-Source: AGHT+IFERc5v2mO4lalIwgWjnukq43jplhJcqA0pJGLYnC1HVeAYILu5yMeSPz845/a0c+8IbYxFbQ==
X-Received: by 2002:a05:6000:1a8d:b0:391:23e6:f08c with SMTP id ffacd0b85a97d-39973b0576cmr3098297f8f.47.1742400198192;
        Wed, 19 Mar 2025 09:03:18 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f378a1sm23220105e9.3.2025.03.19.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:03:17 -0700 (PDT)
Message-ID: <67daeac5.050a0220.3179c5.ce19@mx.google.com>
X-Google-Original-Message-ID: <Z9rqw-zGmaNVBVL-@Ansuel-XPS.>
Date: Wed, 19 Mar 2025 17:03:15 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS
 driver
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-3-ansuelsmth@gmail.com>
 <Z9rgB1Ko_xAj44zS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rgB1Ko_xAj44zS@shell.armlinux.org.uk>

On Wed, Mar 19, 2025 at 03:17:27PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 12:58:38AM +0100, Christian Marangi wrote:
> > Implement the foundation of OF support for PCS driver.
> > 
> > To support this, implement a simple Provider API where a PCS driver can
> > expose multiple PCS with an xlate .get function.
> > 
> > PCS driver will have to call of_pcs_add_provider() and pass the device
> > node pointer and a xlate function to return the correct PCS for the
> > requested interface and the passed #pcs-cells.
> > 
> > This will register the PCS in a global list of providers so that
> > consumer can access it.
> > 
> > Consumer will then use of_pcs_get() to get the actual PCS by passing the
> > device_node pointer, the index for #pcs-cells and the requested
> > interface.
> > 
> > For simple implementation where #pcs-cells is 0 and the PCS driver
> > expose a single PCS, the xlate function of_pcs_simple_get() is
> > provided. In such case the passed interface is ignored and is expected
> > that the PCS supports any interface mode supported by the MAC.
> > 
> > For advanced implementation a custom xlate function is required. Such
> > function should return an error if the PCS is not supported for the
> > requested interface type.
> > 
> > This is needed for the correct function of of_phylink_mac_select_pcs()
> > later described.
> > 
> > PCS driver on removal should first call phylink_pcs_release() on every
> > PCS the driver provides and then correctly delete as a provider with
> > the usage of of_pcs_del_provider().
> > 
> > A generic function for .mac_select_pcs is provided for any MAC driver
> > that will declare PCS in DT, of_phylink_mac_select_pcs().
> > This function will parse "pcs-handle" property and will try every PCS
> > declared in DT until one that supports the requested interface type is
> > found. This works by leveraging the return value of the xlate function
> > returned by of_pcs_get() and checking if it's an ERROR or NULL, in such
> > case the next PCS in the phandle array is tested.
> > 
> > Some additional helper are provided for xlate functions,
> > pcs_supports_interface() as a simple function to check if the requested
> > interface is supported by the PCS and phylink_pcs_release() to release a
> > PCS from a phylink instance.
> > 
> > Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> As a general comment, should we be developing stuff that is DT-centric
> or fwnode-centric. We already have users of phylink using swnodes, and
> it seems bad to design something today that is centred around just one
> method of describing something.
>

Honestly, at least for me testing scenario different than DT is quite
difficult, we can make changes to also support swnodes but we won't have
anything to test them. Given the bad situation PCS is currently I feel
we should first focus on DT or at least model something workable first
than put even more complex stuff on the table.

-- 
	Ansuel

