Return-Path: <netdev+bounces-181371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6EA84AE5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAAC7ABE80
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790F1F09A5;
	Thu, 10 Apr 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0gJmHzb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7F1EF363;
	Thu, 10 Apr 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305840; cv=none; b=u8y2kKvxqKpnxkq4e/9mR1N7OKVSuj7yd768TyKymVz6kktuxQWuuGaJ2OXpvz89EDt1cJm8BDyA0vpw+yCwNkKyMSqfvlZJ+tbipvtGm7Qjva4QjPZzKI82W8GRuHhyAw9Y4KkjRvKuG/34wc5SJBgvG7uKi0YZAeGF8mPKGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305840; c=relaxed/simple;
	bh=ClReNv4tZNKYKHIKcr+3YRA9kSYs6eYQ6ZoMhlVPy0I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsknDtMqTQ4DtiHRVS9ljnerAXaIcnTZoWGbEztwm8IAl2oGihb1BxkdzgpG2s5ksZWsMa7WmeesB4QU47/Ttfdrm92t8NAxg5m4kO/ARQ5/UtAMjT422/ZyrzhAp3JzeCIs7fagWuWQJ5ZfALGwfCA5MpGBhn0rEZRESmuQoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0gJmHzb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso569449f8f.2;
        Thu, 10 Apr 2025 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744305836; x=1744910636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RVEmfdcIK+nAC24P6F8Ud5S0YAAGuFYjRvgCZ39ZrCQ=;
        b=S0gJmHzbpt4uWdJ5XDWZodPTbEJFbfn4vAjDlsOTNKl/WuUqPCGbaZoYvkHQd6Emef
         Nof2K+CVxvfrBFL6JTmGKrrxmRsqzLIotk1jAUTPuN6Y++PyykumCTMkRBV+DDjnzMrH
         GiPotdoonWaPtRsFfEkO2xDHDOBzqz4jMLAMlD1WAv6+usSUmeKuus56WivnEyUJHrrF
         Y1F+39mLK7vUq15u8qTaclykr4t6lzijCkJe8JCUuB1902ExK/eyh47LCk2RJASC7C3N
         UkUI3lFd/NgLzbRDgmVGjdq+WG29mu8fRGRh8lx2TzmlljcFn84gqE9XmUgnE3e9FrwQ
         yotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744305836; x=1744910636;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVEmfdcIK+nAC24P6F8Ud5S0YAAGuFYjRvgCZ39ZrCQ=;
        b=TcB6f46/5hRuZWIzJDeTROsR2SXGOTVG3zeN90sy7SGPEvFLG1ZyHklY7hEhjQHxOX
         vpDz/Y+CsXNG2x7lDQpUdM2tE3ZmD4w2x1ZZM8JGJKi5ZdmDhzKohMdfFX5zsqyA4IB1
         uovr8Fx1tb5ETa3jxmKkPn7xAncDDcRw9dyjbVXJVy83+Ehf3XODKlXYxpcICbsWCRVq
         tRJUvfBB5gBxfe8Dcj1UrrKgRJxmxoCzKJgfR6K1tDCtNJdjiQNq/M5360Cm2QrhFqLN
         c6itbZhc+uC7Cj2zXUUMAtWMO1aDTjV37tO5DTVKySsFu/BVAov5xld0tP9KoHTNyKX3
         gjQA==
X-Forwarded-Encrypted: i=1; AJvYcCU508S7r7LMviC/KniFSNIzAU0rbv1WhPcuvt+G0Zbucmaejr2KHMAeGf1Lihe7WaQpQUoPa8F6A39xT5+9@vger.kernel.org, AJvYcCUVhxMf5BEkPX9FyQGbluINLnPSWgioTU/nZCv0LbCTAKXXvAx2TES9ga77YET/d3f/b0JCAzCw@vger.kernel.org, AJvYcCUsHDLgneAtTeA9fOsCsY9VlW8/s6h4TbczE5UvqAVquU6LNCEAfftCxhdKPvh4nOcn1XINUZZ+4OCp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5T+7n33/7wdGETsWTzwORUmgeL20sSdAnT9UlNqTprBc1fl9
	NzE7TwNfpciMg+skLvnfrdwxE+tjp+hnecEW3qBOQ3bzNStAeBNu
X-Gm-Gg: ASbGncsKAdhA+UX/cyfwLXMCv/WWK0vH08SC3jXteNqagf2SH9+16xB3loO7o7nyLeJ
	fUXUWBEjgjlDdOCHJ2aidrcXxhPes3a1veU/O4cotomzT+0clyUC4DntvWc7ZfL1kLo6m0T+BoB
	OUA+cF2she86PzeOU84ZNo2I0TZ8PXjM/4XCaIM43bWg15rL8bRjM0EbZihow7prWLup1zw3rpt
	dhDaGKjJbLLwCvyaNReGU4KDhQ+fp/MPNPaQpmRZtd0FCx9o5UBIqegLQCoYKFnyVL2rzINnElX
	eOYDDWQDSvvSihG9T49hnBEVsRBLEbFfDzV6H1iQea6qYRox8ts6TFck2S3IdiFjTcLoaZMX6Wc
	PFO8E3fk=
X-Google-Smtp-Source: AGHT+IFqhoIbl8rG6Xm1pydrcNvSBmIecSBYlMaEofFIFMZzgUR9B34igWvZcOG2E52kzZjCqGGyAw==
X-Received: by 2002:a05:6000:2586:b0:391:3aaf:1d5d with SMTP id ffacd0b85a97d-39d8f47497bmr3207232f8f.27.1744305836300;
        Thu, 10 Apr 2025 10:23:56 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5495874f8f.62.2025.04.10.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:23:55 -0700 (PDT)
Message-ID: <67f7feab.df0a0220.40a6f.c911@mx.google.com>
X-Google-Original-Message-ID: <Z_f-qflwHutRYS6_@Ansuel-XPS.>
Date: Thu, 10 Apr 2025 19:23:53 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 06/16] net: mdio: regmap: prepare support
 for multiple valid addr
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-7-ansuelsmth@gmail.com>
 <6f29a01d-35da-4d51-b309-a1799950a707@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f29a01d-35da-4d51-b309-a1799950a707@lunn.ch>

On Thu, Apr 10, 2025 at 07:18:02PM +0200, Andrew Lunn wrote:
> On Tue, Apr 08, 2025 at 11:51:13AM +0200, Christian Marangi wrote:
> > Rework the valid_addr and convert it to a mask in preparation for mdio
> > regmap to support multiple valid addr in the case the regmap can support
> > it.
> 
> I think it would be good to pull these MDIO regmap patches out into a
> series of their own. We know there is a user, so i'm happy for us the
> accept it without that user. But this code needs further discusion,
> which will be irrelevant for the switch.
>

Ok so how you would like to proceed for the remaining patch? Repost as RFC?

Still waiting feedback for nvmem and mfd so I would love to get feedback
for them (that are also irrelevant to the switch)

-- 
	Ansuel

