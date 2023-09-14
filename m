Return-Path: <netdev+bounces-33793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F77A02B1
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DADFB20961
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B915E96;
	Thu, 14 Sep 2023 11:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22954208A3;
	Thu, 14 Sep 2023 11:32:50 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7311E1BE8;
	Thu, 14 Sep 2023 04:32:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9338e4695so12003011fa.2;
        Thu, 14 Sep 2023 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691167; x=1695295967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtP+ORG51cOnQgAyG8Q8L/PuvqcAZFq5aTIYWfYMZs4=;
        b=UDEqhXjW/OEqJJS2rAavgtk9cYHfatxeVCSon8uQQxxeYcfnfxEodg7nErgoqNEb4j
         kVr2juhb/2LakczKz2VpfH3OrglkOvJUk2y+NVj457o+zaXOM2zujsuY49XLsV+hBmCn
         +lX7+7UxjNSGTXYrH1IrsR7gzvQK5Ly9TWZBPlNmK39VqkTclMFQuBTeYv1HyuIYKEgR
         1hn7kQ3VMNp8jy5+j3BZC2Fl9ew32xXF2Emnl1U6fcW5Of9XBk/H/6CpFUbX4YXhl3Ti
         m8QIGxH2ozO2TV3tgiNn8MF0PGUOX/KBBs4ljYPq4/0+zbJUdEDAX1vKFD+7EYHxX7Fh
         /mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691167; x=1695295967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtP+ORG51cOnQgAyG8Q8L/PuvqcAZFq5aTIYWfYMZs4=;
        b=nx2Y/tbCxzlmXpaEdCkN1m6W6hQ4XD9O+DLyzYSHENazJdhJPP75W9Ws3H/4+X5gfI
         8CdnB9XBv/D9Oyfp8cTdb0Xx1MBtHiKfqvzmDvrnFXqk/lzQmPjSZeH3209BiYYRSjZa
         8DVXs2R3NffDL8PYc6KCoG1n+LOLvOIEQXvy4/kPKJROq0VsTKwFemxFaKUgbYkDYw79
         saPOpCsH4AxEeW+Xs2SO84x/na+x8XVh95JzgJGm8sJbfUrnmGMAMucjBgFU++1XNWJY
         pyq4qazmzjgrzeroQly/NZUaSD7xyavWHm549sI4qWMnalr9Snk/pMY7ubCyiFegxCPL
         QaSg==
X-Gm-Message-State: AOJu0Yy1lWfBErYZZAO6TE56BhGjPFE1RZQ/HGWs0CKmPc4D9WaQhUrI
	ebgkJryoTMrAQeQaD8PIlgU=
X-Google-Smtp-Source: AGHT+IFU1JI/BHPOJOArjfnzjINNAJavuJJ6VMYd9VBuQkPUCgFXcEp/9CjG0Rg8PaabYFr1/HcxFQ==
X-Received: by 2002:a2e:350d:0:b0:2bc:ed75:1b0 with SMTP id z13-20020a2e350d000000b002bced7501b0mr4966389ljz.2.1694691167361;
        Thu, 14 Sep 2023 04:32:47 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906298800b0099bcb44493fsm884550eje.147.2023.09.14.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:32:47 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:32:44 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Message-ID: <20230914113244.ozj4swe7ck3l4dbr@skbuf>
References: <20230914075107.2239886-1-o.rempel@pengutronix.de>
 <20230914075107.2239886-1-o.rempel@pengutronix.de>
 <20230914075107.2239886-2-o.rempel@pengutronix.de>
 <20230914075107.2239886-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914075107.2239886-2-o.rempel@pengutronix.de>
 <20230914075107.2239886-2-o.rempel@pengutronix.de>

On Thu, Sep 14, 2023 at 09:51:06AM +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> - microchip,io-drive-strength-microamp: Controls the drive strength for
>   for undocumented Pads on KSZ88xx variants.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

