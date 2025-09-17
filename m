Return-Path: <netdev+bounces-223961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B26CCB7C542
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558634E2FEB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCAB343D92;
	Wed, 17 Sep 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixNeAMcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156B32D5AC
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105473; cv=none; b=HZoj/CN3kVHDgRE20iu3p8BAMxvd+/BFs4MpJ4+04etAHP9sIo/i6BieegryY3HxF16Fr/+h3gfzoP+84ZTg89cUBwqOXq8jMJ48/cbvvyX3jTJBHFaeYMrztYCPV0V9iqOSfoxT9Ki+lvHpG3YjcR3yT+Dhm324HniKUsJ5VTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105473; c=relaxed/simple;
	bh=+jUeO/7waznrAiGaH6nmbusoTFDyzVVMGz6K6davJk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgG+6rLUIxDgWpcUTz/4cdpf8K3/iWcGjjijVkGJRHH3jC9Ki4XvX4j7/Eu2d1AbdurzarBJdTK1ecQo7i0rZD8o0YteEzkdw1Rc7k558of3mR/IURE8kGAGbNrn6N+/PKE/iibw7PlPWnn2/AEfS4GueMHeaMm+eJTY4v879lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixNeAMcC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso9574055e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758105470; x=1758710270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYcWLS54K1ej44Yjhz6yrulC2XJ3aJ+2KhXmhL8N/4=;
        b=ixNeAMcCtIwuhadNQBJP2UfBAm9SUCCGrfVtT2EPDG3TsEWMjB6nGC6D+fsT1OVdxq
         LLx5P4Vjal47z5jUXRKMgeIY/WUV7mBVscAfIBIWxWLB+PJu2IN1oQYCfIOVJVyKpWu0
         lFTCQmVubbambfUhvkiW2YOJ4OuuTaWJg5JmG/or24hT+Qlayp4pD2+rxmG6rx42oJho
         U1CMkIzhyihb9HfgKBx+wFsgwRRHcnbZUnGLfHIkCjkoeAf075UmCeJC9E2AGzCizuhy
         bEEcA1SZoYTulRZU+JjQz5NNFeSkmcCRn6uCSc3QXmx3KsVSW8Q/O6/L0X9SRkmi0wFp
         X/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105470; x=1758710270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsYcWLS54K1ej44Yjhz6yrulC2XJ3aJ+2KhXmhL8N/4=;
        b=bdHAbtBcpGSzLU8on13PvRZ/irgjhmWRIFuMt3f30w2U2P1IWIPoWfSZNJ3vhrpmmH
         gcY3MCNl0W7ug6fPpvI8mKgnBkBchV3jEzw+qYJfRX3Sj/D1+5xGeCA9BguOFoF8Sm+a
         x2kvWVjswK72QUbCUfmQWBEAhe3sG8pyKluZYwWwo/rWiU9LQzIUwiJxb5tmxd+6vZhJ
         LeB/2T/YHtVvlxuM9yN+4dFYhTEBiPOpcv4cFRigQURIkDFX4aIM8iOzH+m3ZAWI/C2M
         lJucx2zmTrvwcZ/Qafa6Sns6LL4LMfLPgSC5q+H7UcLMXkek8FNhYo+zONzOEYlHHvYW
         bNmw==
X-Forwarded-Encrypted: i=1; AJvYcCWIAX3Ws/Y2SyArFRRXfvg/UarqcbS2e9QIt/IR4R8/QuVDEzIiXGvFIqkUaKRofRGtrncoK4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+f5nnqSu+fIDe8w0f7CJjm4GylUqkI0wawolCiwq8QkbmVeSO
	hzEohQlZk9LUkcx8uvBfxDm88uFj3Uiz9+1+KKLUngyV3wKj/huegry1
X-Gm-Gg: ASbGncs55yEnhREsYp4gLhAlmT9Xm+/PQJRlC+JKP3tUa+PHnjvUkp8XdAlgB7wR+/C
	4nozJC0goqS0zAAis4xfWhZkYwcQfZpxQL63YqtXTD1pveAB4krxUqyPJxnCx+4BTfOPEA7Y/mj
	VpzDC0DF4eim54O8xKTJa2mKyssjjzpU/4EPElWbQ5/nDQe1e9fvzWTKpq7eaqqKI7UMs0Tu3hH
	fXTUfuaKH597D5TcE7EiExay45m6evqQLU2yZIe6HR13+LTZZlIrCQGKLOX6Ge7g+F961TTyA51
	jgrA6nGTAO79GhC5jOhALUhA1AyoYGC+vnebx3SeLwK5sfP5xrV2rtZ6nAhV2cchO4HfuRWcfU3
	rIPXmccg2BKQaPeY=
X-Google-Smtp-Source: AGHT+IHmbRK/RR/f6CMsiKwgVCww0CbZLWw9FNcy1YCsTBab4ScCzhgCjBGfKDPKwCMgjbZt1yeo9Q==
X-Received: by 2002:a05:600c:3d92:b0:45f:2919:5e8d with SMTP id 5b1f17b1804b1-46201cac25dmr7562685e9.1.1758105469624;
        Wed, 17 Sep 2025 03:37:49 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e93dd85sm34991125e9.22.2025.09.17.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:37:48 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:37:45 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	DENG Qingfang <dqfext@gmail.com>, Lee Jones <lee@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v18 3/8] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
Message-ID: <20250917103745.vhdsvrrv7z23qpnn@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-4-ansuelsmth@gmail.com>
 <175795551518.2905345.11331954231627495466.robh@kernel.org>
 <20250915201938.GA3326233-robh@kernel.org>
 <68c8a6fd.050a0220.26bdf7.871a@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c8a6fd.050a0220.26bdf7.871a@mx.google.com>

On Tue, Sep 16, 2025 at 01:53:27AM +0200, Christian Marangi wrote:
> On Mon, Sep 15, 2025 at 03:19:38PM -0500, Rob Herring wrote:
> > On Mon, Sep 15, 2025 at 12:01:47PM -0500, Rob Herring (Arm) wrote:
> > > 
> > > On Mon, 15 Sep 2025 12:45:39 +0200, Christian Marangi wrote:
> > > > Document support for Airoha AN8855 Switch SoC. This SoC expose various
> > > > peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> > > > 
> > > > It does also support i2c and timers but those are not currently
> > > > supported/used.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../bindings/mfd/airoha,an8855.yaml           | 173 ++++++++++++++++++
> > > >  1 file changed, 173 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> > > > 
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml:
> > > 	Error in referenced schema matching $id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml
> > > 	Tried these paths (check schema $id if path is wrong):
> > > 	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> > > 	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/nvmem/airoha,an8855-efuse.yaml
> > > 
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: soc@1 (airoha,an8855): efuse: {'compatible': ['airoha,an8855-efuse'], '#nvmem-cell-cells': 0, 'nvmem-layout': {'compatible': ['fixed-layout'], '#address-cells': 1, '#size-cells': 1, 'shift-sel-port0-tx-a@c': {'reg': [[12, 4]], 'phandle': 3}, 'shift-sel-port0-tx-b@10': {'reg': [[16, 4]], 'phandle': 4}, 'shift-sel-port0-tx-c@14': {'reg': [[20, 4]], 'phandle': 5}, 'shift-sel-port0-tx-d@18': {'reg': [[24, 4]], 'phandle': 6}, 'shift-sel-port1-tx-a@1c': {'reg': [[28, 4]], 'phandle': 7}, 'shift-sel-port1-tx-b@20': {'reg': [[32, 4]], 'phandle': 8}, 'shift-sel-port1-tx-c@24': {'reg': [[36, 4]], 'phandle': 9}, 'shift-sel-port1-tx-d@28': {'reg': [[40, 4]], 'phandle': 10}}} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#"}
> > > 	from schema $id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
> > > Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: /example-0/mdio/soc@1/efuse: failed to match any schema with compatible: ['airoha,an8855-efuse']
> > 
> > Why are we on v18 and still getting errors? I only review patches 
> > without errors.
> 
> Hi Rob,
> 
> the problem is that the MFD driver and the schema patch subset of this
> series has been picked separately and are now in linux-next.

Link for MFD driver? I don't see the MFD driver in linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mfd

> I tried to make the bot happy by using base-commit but it doesn't seem
> to work. Any hint for this? 
> 
> The errors comes from the missing efuse schema.

So the efuse schema is in the nvmem tree and this schema needs to go
through the mfd tree.

For v17, you used "base-commit: 04b74f665961599e807b24af28099a29d691b18c":
https://lore.kernel.org/netdev/20250911133929.30874-4-ansuelsmth@gmail.com/
I ran "git show", after fetching linux-next, where all trees should be
included, and didn't find this commit. What does it represent?

