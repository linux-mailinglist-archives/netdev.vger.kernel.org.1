Return-Path: <netdev+bounces-232187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EFEC02362
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12D39543256
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C633FE08;
	Thu, 23 Oct 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLsEC/hK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10A33CEB7
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234150; cv=none; b=qNgh+qq8c1CI+GFB1ZqY3DL/cc7vl2hlOHRIFxOE59BeIabkYnvYT5J1WY9B7L1kGfCjfh31kHSei73ubFcSnKGbKDqxTOorngkRSNVesbG1MUIjUS8XmYLFTku1VnAqkRz59uvUwKumsbhiKjl+FaSD+TGBqTHSGwU/aouW5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234150; c=relaxed/simple;
	bh=CdcIJyHX4clb96PckgG+JIrIZVu7Cky4+dgR8wQZ0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhzcJAU9EwO3mmgK0Q1FYYGDK1GTzLp23MAOFljoExIo5xbA0Udmum1rBba+Xd6UYJE+kzGAuzN6yCcHj+HeyNBx3+54R+n6viyjhjMo63bL5tK5J3pYqYs2/HkD7vRIxhTvtEUhYKzGWL1tV0cGczLJ8p6r3st4eHDNvnRy/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLsEC/hK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1026214b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234146; x=1761838946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiXLImZ7fPO15Ek72Gzubnx0U1bgG0nde4mxLe+ZreM=;
        b=XLsEC/hKI9rcYtvZep1kAQCqqw3YI29awmGXe1rBHmx869IAnxsBuaeEQYB0t6jLQs
         imXwO/2IUFcQ/T4FXrbzCa4iK4fw1KiOFu5ITCVwnTwBKQFw/Ld6UhdCElxyHmrOnC6L
         ZlL0a4p9RqTAN+T048bJ/RrIYJM+v6w4/AwZafr2sonvbFsXG58KyM/1bY5LSWq7BmH0
         3sFqTzk+Cpf+GXDmZpQEcqhfDS4YOKcZ/CeX/sZSZCikzQoMak/Sjbj0n1nb+YU+m0Qa
         D8WzDb1sjN9Dk5u+tUXh9878VLKtcU+YcYZlNPE3+zGCQNIaoO7A4ZRnOKxhG75gCRmX
         9aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234146; x=1761838946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiXLImZ7fPO15Ek72Gzubnx0U1bgG0nde4mxLe+ZreM=;
        b=FyTpF4R237EAd3qFrQrjMz8bN0T+xs3Oj2xbB9TXgsSvg9XO51ebNcWXuWhppWHMEu
         SmO8o2Yrz45F9uu8J97FEvl8FkINjYeyveWKljMY7Nfo/yWPd4H+7PA4Q7EIBwkmM+tT
         nV0D8uT52WgEAbtTPLdUPwt/ODVykDufaTnD82L/l/jC+qNm/k/1o8FmZhVJ22rJGIk5
         tfgUaN2xYVY4nF9NRGgIF2mlURsdO9z6tmrpi3cSuqZxEVDTmJ+LB0cvRI1S8INlOnY1
         F8CeQFkKdqTXFKJFkoPOqEvSQM/a80XFFHKUjiXNsiuBp8HrL8iTD41WMpashh4xsobL
         MJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIcInViXrUhj9UX6zWzYTgO1/TJbcagVZfbMTKdWfjrVQIZ5Ff2stHSXT9qTmM2Nne8mKAIi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ940H1moBockE157RJ9xsok8QmgGD33NrZOGqgygmSZbMVtQN
	eGlpAY+gGtN+7+I5Evtk9ibSnPUqPp2rkg9eP+p2MritW3OxM2r/8HbL
X-Gm-Gg: ASbGnctrbulAXyGSt1hlSSPyFiL5LB4jvVX7JuFAplC8iCpjPQjwFXCZsaLnPImj61a
	eByyjSCATesOkAAWJSsnA8zVrJ14z9uQTYGtfcPzUwwkWcoixd8eaIrSSUL3qp+5BW13yD22LQV
	dULPipY5pXz0QEDtrqzUpjsrqq2VUj3ZrzCe/DOaCeNF9/zRsS6tagy70zeInKmHX+fggV7KcTP
	CYCiH/3M7ei7dqo+HuASC1fY+gCI7vKEVc8Tv7RcPJDrgQy3xIn1rRNC8CKmbixq/zgFWbNxjkD
	rKKyibabqbQZMoFtAY4oGqQODvgypilQYGzglROq98JHCqslF7/GSuqjce0etR8GaLh7XwWZnNw
	QiszS8LHxypjRj6ERM3Zjwi96efm5puXXs6wVVKf7SjeRc+R2C2z3shwuAqXWGVXV7LJT8asave
	yCwtexG1s6NoWw
X-Google-Smtp-Source: AGHT+IFivLiKbkP0y2KMH2ZNEJ7GlEhOb9t2a5oI0W2mRRwwxItjHXvAd1GZTuvYOgULd0RdTXOLyw==
X-Received: by 2002:a17:903:1746:b0:290:9ebf:211b with SMTP id d9443c01a7336-290cb07d223mr295078455ad.40.1761234145718;
        Thu, 23 Oct 2025 08:42:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72ddsm27825615ad.6.2025.10.23.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:42:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 Oct 2025 08:42:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
Message-ID: <0d01d218-15df-4553-8e84-fef84fde211e@roeck-us.net>
References: <20251023143957.2899600-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>

On Thu, Oct 23, 2025 at 09:37:56AM -0500, Rob Herring (Arm) wrote:
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

