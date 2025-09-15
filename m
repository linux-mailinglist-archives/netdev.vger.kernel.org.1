Return-Path: <netdev+bounces-223266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E68B588A1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D193A9014
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB12DC335;
	Mon, 15 Sep 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7y3POZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916982C08B6
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980417; cv=none; b=DHm7zroo3K87kUIf19MAhb+kmUI88FLbetpzNXF1mc0KOnUh0JmHx5bCJsgeozRvmat1RVoOx96jV6/byGN4/3qOk6E+FO3JT7eBJ749VEK7Ay88mM7hVVVaTo3NC+WQ9+SNjTnMXmKo+yXJAXcKg3C++XXPYEfB0blsazsCTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980417; c=relaxed/simple;
	bh=Xk1ngxkS5zRj3gU0t0gxFp8yUi5KZTETEFQeV3IwLsM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo12a55c0cnA19zPyXLAB3a7OJc1zPNE+ANuOjvrdfVKSLzOtelD4z8qZh3Uhg8xyAmZeo0KG4WMT+QL5oWE04uPCqMhshNMlF0y139+yqV5Ax5M0jC9bHN7T0wldi5oGxcHc8qSZHMKQlwd/eVyRs+m9v/L8P1tonmEY9OCReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7y3POZQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so19496885e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757980414; x=1758585214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BmfG0W1IgkOwpfZLkT8EPqhqG/KPrr8NPJycy9t8jkY=;
        b=I7y3POZQAZUXa6pzctMvGfeKcyYv84iYeqG9hfPsvAgzv62AyIiNUTw8t9SDQeFjBM
         30pwsS+0/ojqgEsDiqRrlvU7hAzPTPaPrnWo/BjmPOJqkrLcM58844mSIHtGTyosQ2Cm
         MW09QjXI8AEyHxKeWwm7p+FoNNBQ9/+rfDYRIo6ntcgN9/cnQAY7iTuoVNMlA0Qi6njc
         50BWnRqFyXckcr3t0KG1BdgEVP1XX/UvOvElEdvcuggbc9//dStDAiUmyiFUt/jrbibr
         QJMQ2irEhgN4r2BIuOSmfywdTtyCWHiUVcoMzj+oEEYCG39IDqFnIJkQw4XugPzVQKRf
         YB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757980414; x=1758585214;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmfG0W1IgkOwpfZLkT8EPqhqG/KPrr8NPJycy9t8jkY=;
        b=lOz/EQgrJ3ojfNc9gqVs8P0vpSlAzuW2y9Bx8laHCsDhHlz4qz+G1pKlL7DoiLFa+s
         ZYonTgeYoYht3d2+3Rrwfa98LWjdWZ3/XIRPqd/em8B2oYKrlprZRyZ9f015rJ+wWmkb
         TrE2oqf2fwqaMjBvVl9q+Bz3+GMlQxR/g+U6bZpBTTs/gWYLEDvNSi+fn8KhBjJlF26X
         zN++2dAr4IhXosfdPP2XbCkbhy+RIEMmf547KbfFRCAUq4AWuLb35hbQPZogyBtbNbKW
         aNpV9xWcNWtVhJzlAHGD0D0muWHCH1ugd/QUQR3xHotXt85jLPIGtEtp+l7hqYBuYh9Y
         Lu3A==
X-Forwarded-Encrypted: i=1; AJvYcCWnjIFsMm7Gfm9axcdH9p4YqfIdqASYxGgv+TNwSg1itPaLc78ryWPsm1X6xrVUEPa6PN47z2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDUONEoN7KcpAznJJthVR7TAHQh0ISVTC3RNoZNFnjfGFIgsG
	7KbLJbUIHzi7sGR5Lg5mPlSWx9pYqYpV2009IE3QHLwSrP37MT75wqj+
X-Gm-Gg: ASbGncu9bb2KpmhGHNMeMiZtVKB5KLm+9Qjn96iGWtQvhvfX8R2bbKBfDakWZZ39hgd
	XuSZn/+UwJ6aaLXSabjAT/VdzAN06vEs86HLr1pfKlzAnGht/lNQvPj6qnZNhK8ngnLLs6EU+q+
	1Oob1cZqqfTP3cYvZvw0R32uOakkrn8cxIUc2foCR8PCBh5YGdO5fIVKqRy70V0L8CgjHzzs6iC
	6ko2ZSlOqVAm1YWvHKIXS5l8vS45PvqAZw4xgO98BoX/g3qo6t11pBabkcztohwhBV3epeyxS8a
	3ava8BeZ7VcrFii5jR0FKWmVjC/OnuUGpf00ooB7Rri1ZfDQQQ+Ksb7T0QSuaPc5lLqXtAP3soJ
	JvTgnZIhTzvzV2Z8ohS4oz8P+OrDNRh6HwtEzAdgbXPlsKDffnqvdt5D2J5/fFVLzrTl0RQ==
X-Google-Smtp-Source: AGHT+IHLVAgIWoi+HRjIu3glVhna2GE9VgX3EjwtlAMYebMBvwok+xVV62qMLLci45mipK73hQudIA==
X-Received: by 2002:a05:600c:4f83:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45f211f87c8mr150676285e9.24.1757980413716;
        Mon, 15 Sep 2025 16:53:33 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f28c193f9sm118455135e9.2.2025.09.15.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:53:33 -0700 (PDT)
Message-ID: <68c8a6fd.050a0220.26bdf7.871a@mx.google.com>
X-Google-Original-Message-ID: <aMim97cvziXHysYI@Ansuel-XPS.>
Date: Tue, 16 Sep 2025 01:53:27 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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
	Vladimir Oltean <olteanv@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v18 3/8] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-4-ansuelsmth@gmail.com>
 <175795551518.2905345.11331954231627495466.robh@kernel.org>
 <20250915201938.GA3326233-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915201938.GA3326233-robh@kernel.org>

On Mon, Sep 15, 2025 at 03:19:38PM -0500, Rob Herring wrote:
> On Mon, Sep 15, 2025 at 12:01:47PM -0500, Rob Herring (Arm) wrote:
> > 
> > On Mon, 15 Sep 2025 12:45:39 +0200, Christian Marangi wrote:
> > > Document support for Airoha AN8855 Switch SoC. This SoC expose various
> > > peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> > > 
> > > It does also support i2c and timers but those are not currently
> > > supported/used.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/mfd/airoha,an8855.yaml           | 173 ++++++++++++++++++
> > >  1 file changed, 173 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml:
> > 	Error in referenced schema matching $id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml
> > 	Tried these paths (check schema $id if path is wrong):
> > 	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> > 	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/nvmem/airoha,an8855-efuse.yaml
> > 
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: soc@1 (airoha,an8855): efuse: {'compatible': ['airoha,an8855-efuse'], '#nvmem-cell-cells': 0, 'nvmem-layout': {'compatible': ['fixed-layout'], '#address-cells': 1, '#size-cells': 1, 'shift-sel-port0-tx-a@c': {'reg': [[12, 4]], 'phandle': 3}, 'shift-sel-port0-tx-b@10': {'reg': [[16, 4]], 'phandle': 4}, 'shift-sel-port0-tx-c@14': {'reg': [[20, 4]], 'phandle': 5}, 'shift-sel-port0-tx-d@18': {'reg': [[24, 4]], 'phandle': 6}, 'shift-sel-port1-tx-a@1c': {'reg': [[28, 4]], 'phandle': 7}, 'shift-sel-port1-tx-b@20': {'reg': [[32, 4]], 'phandle': 8}, 'shift-sel-port1-tx-c@24': {'reg': [[36, 4]], 'phandle': 9}, 'shift-sel-port1-tx-d@28': {'reg': [[40, 4]], 'phandle': 10}}} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#"}
> > 	from schema $id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
> > Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: /example-0/mdio/soc@1/efuse: failed to match any schema with compatible: ['airoha,an8855-efuse']
> 
> Why are we on v18 and still getting errors? I only review patches 
> without errors.

Hi Rob,

the problem is that the MFD driver and the schema patch subset of this
series has been picked separately and are now in linux-next.

I tried to make the bot happy by using base-commit but it doesn't seem
to work. Any hint for this? 

The errors comes from the missing efuse schema.

-- 
	Ansuel

