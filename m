Return-Path: <netdev+bounces-54753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 375CA808135
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 07:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30941F2136E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C1913FEE;
	Thu,  7 Dec 2023 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrCGOR01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2519B6
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 22:51:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so7481535e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 22:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701931873; x=1702536673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P021h3HtosWIlf7YJKZvwxMCdUSfZ2ZSmafpEm4qnvY=;
        b=ZrCGOR01tsI06Nb1os2hQQrqqiSCuUqdkELAwFnzK/ap2QRXiZeykSRSbf5ZWEkCx6
         /OslsH/efWxu0ergjii0L81MxHfKURFDI5Fg0H/IMcR0xDSXaw42C/v3lUSbhGc8z94J
         CodYqEAYhcGmn6Cb9mVHJFyCQUOST2ZvhGy/1Er7l/k0KhMRVn9soCiI2K8fuvppYPED
         x6rSQ8XbpEH3eP8p7xMzaKiStTzbZCy5fsHLZMHZlQsMx21Dw3y9vh378KuW70kdQAVw
         ytQsQ7V/omBLuH8sIVQ8Ea2pz4Xmi7bUNf2zLQiuEdtHx4vnXwS+0ZqsVd/rGgua3Sb1
         A8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701931873; x=1702536673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P021h3HtosWIlf7YJKZvwxMCdUSfZ2ZSmafpEm4qnvY=;
        b=W92Az6gTa0HwFDC0ZHBb5uyWuX/LFZXQ1BZpzQSv/dyo8NtaW/bRhWiPbeusStPRwl
         ZkPyVzKYUUImkG0PjlC0BIGVhOa09VxLWAzSO1yw0sy5BFUbk8xVwhrOC9eZYf8OwWjz
         NwlqEj/hAttsMIoWj5dGL18roIqGuL3a7S/HZR34KoWnPvWfbzGgJcZWyBREMlPeOiWe
         /BmZ6ByqoZTOUlfMWotOOBeKKABqKvyLv8NL2LyfPekkeae3QXhInFAwsPl6YCf3AhYS
         Q15MP+4UFoWMNLKBLjBe+flpWg/RkFlU3NnxLq9wzRcKFsDpBRvu9+yhv8PQbf+Cz3nk
         Dj6A==
X-Gm-Message-State: AOJu0YzttAVm1roFKbKmn3JvfirhDuBZkoQ6y9Kgvp/MG2emrqWbCtKY
	tH9Zj5a0so4BUgvOsfz8qNhX4Q==
X-Google-Smtp-Source: AGHT+IFhsEzLwvQ1xEOGNTKHZpCXxRYgK+1SXpQhMJn2ZA471m64pWH+rUiU1rMJx9WFhAf1qzAyhw==
X-Received: by 2002:a05:600c:3381:b0:40b:5f03:b3f6 with SMTP id o1-20020a05600c338100b0040b5f03b3f6mr670880wmp.280.1701931873077;
        Wed, 06 Dec 2023 22:51:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b0040b4562ee20sm450698wme.0.2023.12.06.22.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:51:12 -0800 (PST)
Date: Thu, 7 Dec 2023 09:51:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>

On Sat, Dec 02, 2023 at 11:45:42AM +0300, Arınç ÜNAL wrote:
> 
> I'm not sure why it doesn't catch that for mt7530_setup_port5() to run
> here, priv->p5_intf_sel must be either P5_INTF_SEL_PHY_P0 or
> P5_INTF_SEL_PHY_P4. And for that to happen, the interface variable will be
> initialised.
> 
> for_each_child_of_node(dn, mac_np) {
> 	if (!of_device_is_compatible(mac_np,
> 				     "mediatek,eth-mac"))
> 		continue;
> 
> 	ret = of_property_read_u32(mac_np, "reg", &id);
> 	if (ret < 0 || id != 1)
> 		continue;
> 
> 	phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
> 	if (!phy_node)
> 		continue;
> 
> 	if (phy_node->parent == priv->dev->of_node->parent) {
> 		ret = of_get_phy_mode(mac_np, &interface);
> 		if (ret && ret != -ENODEV) {
> 			of_node_put(mac_np);
> 			of_node_put(phy_node);
> 			return ret;
> 		}
> 		id = of_mdio_parse_addr(ds->dev, phy_node);
> 		if (id == 0)
> 			priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
> 		if (id == 4)
> 			priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;
> 	}
> 	of_node_put(mac_np);
> 	of_node_put(phy_node);
> 	break;
> }
> 
> if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
>     priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> 	mt7530_setup_port5(ds, interface);

Smatch doesn't know:
1) What the value of priv->p5_intf_sel is going into this function
2) We enter the for_each_child_of_node() loop
3) That if (phy_node->parent == priv->dev->of_node->parent) { is
   definitely true for one element on the list.

Looking at how Smatch parses this code, I could probably improve problem
#1 a bit.  Right now Smatch sees "struct mt7530_priv *priv = ds->priv;"
and "priv->p5_intf_sel" is unknown, but I could probably improve it to
where it says that it's in the 1-3 range.  But that doesn't help here
and it doesn't address problems 2 and 3.

It's a hard problem.

regards,
dan carpenter


