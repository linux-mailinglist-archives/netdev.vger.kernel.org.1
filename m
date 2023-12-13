Return-Path: <netdev+bounces-57109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A8681229E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA98281479
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67F83AE0;
	Wed, 13 Dec 2023 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q009b1o/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA64E4;
	Wed, 13 Dec 2023 15:10:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so70452215e9.3;
        Wed, 13 Dec 2023 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702509047; x=1703113847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=27lXn/0eKgoZmqmgopJ3Fi7Q+GCy31HzcvAZfnCfdRk=;
        b=Q009b1o/ppPGuKd9J3rm/tlBzNBBjNdEKbl1c3L8I8UUMizeN1CGtUojrpX5mpGgEq
         TY39N2jjtp56bFNrzQAc2hnLOw34zqJw8ViZVJH3rSBSO817fvQOURcrULsMdrewajNd
         +RmL4BjGgVrvdJuWKR+Q9gZTN9yd/6Jksf2jfOCqlSsEH3G0cxwfupWPNVboOt781LgK
         ooNZV7/VesJhBKpJyr/tnLYKLVYM9KLP3MnPsZkfADO7EOnj3uEXpcjGI3wjKcR3Lgr0
         DxfOLSpmMXV6lWAWyxU9IDk+c2ZtEN/9HxfhoGOfDD1x/m+NFgE8f/E9Vtd7N8QPTbhO
         r7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509047; x=1703113847;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27lXn/0eKgoZmqmgopJ3Fi7Q+GCy31HzcvAZfnCfdRk=;
        b=nAJ/yFEhz0CZ0SNA4TGrIu3M35qzKp1I9Xy08yqEFr3UCyI0X1xllRmbA4FyMTKocE
         xcwR/b8BViUQgdnDXgk+6DkcEYCx7dPBvUzSQPysbfoEIHjoR9WPAjisxd25g9GKr+uY
         pRagCCF2eqZSlN4hJYb5Fw5I9OFUGGPZyC8Pon1T5OZ3OxC1ZINLR0yweCpXa1kAAx6+
         1AYs97sQeU98IQh6/nyOOkY/3R8Ljqm/UHoCJ3Ec5NIy+Wc2z6+pxGcXJOf4vhebgBVO
         DHqExoOPh7SIiX1Am2tH77LLQ59xnT9acpLzdRoY83Z1HmRFKeSydJQM9rRYQMYj0Dxb
         siPg==
X-Gm-Message-State: AOJu0YwpMaESuS4Wc4BDNyAAler16bhHh+AosqpAq/oEtHR57MhXDK5l
	+3k4AKzHdlqdjQKCBbVve1c=
X-Google-Smtp-Source: AGHT+IHZVV3mGhIMNdNFGZ8VFWEtdvmavOMakWVXsv72jmuTYkwHpGivTKnraBmLNvZzfMc+vraUxQ==
X-Received: by 2002:a05:600c:450e:b0:40b:5f03:b3c8 with SMTP id t14-20020a05600c450e00b0040b5f03b3c8mr2176250wmo.234.1702509046514;
        Wed, 13 Dec 2023 15:10:46 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040b2c195523sm24407629wmo.31.2023.12.13.15.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:10:46 -0800 (PST)
Message-ID: <657a39f6.050a0220.50ffc.9232@mx.google.com>
X-Google-Original-Message-ID: <ZXo588MHn3AuZLOm@Ansuel-xps.>
Date: Thu, 14 Dec 2023 00:10:43 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 0/2] net: add define to describe link speed modes
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
 <a4661402-414a-4b0d-82e8-97031fa46230@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4661402-414a-4b0d-82e8-97031fa46230@lunn.ch>

On Thu, Dec 14, 2023 at 12:05:52AM +0100, Andrew Lunn wrote:
> On Wed, Dec 13, 2023 at 07:15:52PM +0100, Christian Marangi wrote:
> > This is a simple series to add define to describe link speed modes.
> > 
> > Hope the proposed way is acceptable with the enum and define.
> > 
> > This is also needed in the upcoming changes in the netdev trigger for LEDs
> > where phy_speeds functions is used to declare a more compact array instead
> > of using a "big enough" approach.
> 
> I'm trying to figure out the 'big picture' here.
> 
> The LED trigger will call ksetting_get to get a list of supported link
> modes. You can then use the table struct phy_setting settings[] in
> phy-core.c to translate the link mode to a speed. You are likely to
> get a lot of duplicate speeds, but you can remove them. For each speed
> you need to create a sysfs file. Why not just create a linked list,
> rather than an array? Or just walk the table and find out how many
> different speeds there are and allocate an array of that size. Its
> currently 15, which is not that big. And then just use the is_visible
> method to hide the ones which are not relevant.
> 
> I don't see any need for new enums or tables here, just a function to
> look up a link mode in that table and return the speed.
>

The big picture was to have an handy define and statically allocate the
array with the max amount of link modes possible without having to
allocate kernel memory at runtime.

With the current way of allocating only the needed space, I have to
parse the settings table 2 times (one to get the number and the second
time to compose the actual array)

Not a problem since these are called only on LED register or when the
device name is called... Just extra code and the fact that kmalloc can
fail with ENOMEM. (but that is almost imposible and would be in an OOM
condition)

-- 
	Ansuel

