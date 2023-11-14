Return-Path: <netdev+bounces-47730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B0F7EB114
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A19B1C20A42
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309B405CA;
	Tue, 14 Nov 2023 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C9156E0;
	Tue, 14 Nov 2023 13:44:30 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3E132;
	Tue, 14 Nov 2023 05:44:29 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b3f55e1bbbso3651905b6e.2;
        Tue, 14 Nov 2023 05:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969469; x=1700574269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVoXranZuhbJagmViZ0Bh2J7LLpRAZVBS/w9Sa8ohYo=;
        b=oo3i4EJBDK9xmtwN/AlOKqnnWDKzSPtkTocPTsjX04qmfBhVx6FV9NG6wFtNmsby6F
         VFj/shDxp4BoARd+HtkFMQRiAEt606G3HRrGUa+aV6/Yp2dLAAu1ARG6RY8W9QHEkN/5
         CzFpM8uK0cqYORRxxI+hHEQlIOSeH+lPEgdb91t+CQ7NKhYrciFweE/1hzErio0YLizB
         OuuyGndR6mB88SkNWePgJ/rtAaEC40Ee0c67dOQjU1ZrnVF4C7wAKXHJiVfTfi6VG8/2
         SQUx+2Ok/ULD3N8zuR0/6z5M/2qT4IPt1i2BjGfBkb+sp6GnJ6vqnNhuiVASHkpUw911
         XC0w==
X-Gm-Message-State: AOJu0Yzg5AII6t289z+IAcSEGKXIHjpAERh3xqCUT+psDv+KdQdprLCC
	ftiI4pmH5cBSYQ5XHaT+0g==
X-Google-Smtp-Source: AGHT+IEa2yiGK/vrgIGrYDQftkP/r/QgCl5oWffc3V6kN1weHVqSkoufro4lODlc4XqFTDIWhqoefQ==
X-Received: by 2002:aca:f07:0:b0:3b6:cc01:aba2 with SMTP id 7-20020aca0f07000000b003b6cc01aba2mr10713866oip.55.1699969469146;
        Tue, 14 Nov 2023 05:44:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a54440d000000b003ac9e775706sm1115062oiw.1.2023.11.14.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:44:28 -0800 (PST)
Received: (nullmailer pid 1651909 invoked by uid 1000);
	Tue, 14 Nov 2023 13:44:27 -0000
Date: Tue, 14 Nov 2023 07:44:27 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexander Couzens <lynxis@fe80.eu>, Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 1/8] dt-bindings: phy: mediatek,xfi-pextp: add new
 bindings
Message-ID: <20231114134427.GB1645963-robh@kernel.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org>
 <797ea94b-9c26-43a2-85d7-633990ed8c57@lunn.ch>
 <ZU1nBgdspMtsI5aS@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU1nBgdspMtsI5aS@makrotopia.org>

On Thu, Nov 09, 2023 at 11:11:02PM +0000, Daniel Golle wrote:
> Hi Andrew,
> 
> On Thu, Nov 09, 2023 at 10:55:55PM +0100, Andrew Lunn wrote:
> > > +  mediatek,usxgmii-performance-errata:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      USXGMII0 on MT7988 suffers from a performance problem in 10GBase-R
> > > +      mode which needs a work-around in the driver. The work-around is
> > > +      enabled using this flag.
> > 
> > Is there more details about this? I'm just wondering if this should be
> > based on the compatible, rather than a bool property.
> 
> The vendor sources where this is coming from are here:
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/a500d94cd47e279015ce22947e1ce396a7516598%5E%21/#F0
> 
> And I'm afraid this is as much detail as it gets. And yes, we could
> also base this on the compatible and just have two different ones for
> the two PEXTP instances found in MT7988.
> Let me know your conclusion in that regard.

I'd go with a property in this case unless you think there may be other 
per instance differences.

Rob

