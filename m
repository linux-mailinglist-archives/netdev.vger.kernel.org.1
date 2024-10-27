Return-Path: <netdev+bounces-139383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458D9B1CDB
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 10:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7411F218E0
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD56F2FE;
	Sun, 27 Oct 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6OFD55D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CB1799B;
	Sun, 27 Oct 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022172; cv=none; b=GkAD6SEWhlGzKEHc3iYAZxUV34GE9NlNKa2rX4QIcwppknY6i51Yux/guAR9o5y1c8kJe9DH8KhL56j9VAxu/Gak8C5RsToPAztTcFPWeDoZ/d2L+uHYRLXhNr0N5IjNLOcRKaXRbxair4hVZBRuurtaHZpJeQFjV0X8COGEaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022172; c=relaxed/simple;
	bh=btWSmE31FSmayxPRwcGA0MDBNO1ncxfl4zUVoT+Ceu8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NeSRq0X3qe63i3mxM9V5c5K6IZdv+f0WBYl1vEQ4x0u54yyP+UWBhoIxrGl+cL0klKWi58+OE/jw6Ga27ACw/VK9z54I3eEN5WqW0/C1T89xu/LCAuY6YlBiCaTRiqG+CnQR5Ckf7dc+Lr0n6LuSpNg6oNc8irYCmFjU6MdHXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6OFD55D; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso645660a12.3;
        Sun, 27 Oct 2024 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730022168; x=1730626968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YY5DrXBKhx+MfbfGjjReDCLRQB1YXc8GnyEu7fo66wA=;
        b=M6OFD55DOLLw0DzPLyBZ+5r2ES3dkLpiil9j4Zy55ApMoFlDwI8bEUJbkZSbf6YVmp
         LO2d/kOq/jj3AC87j5a6rhZND2J8OVz/eK+Awi3/+nA4x5SlFRVXU54X9zhZjPV+0Cny
         SCM1c59Rf9xIpKS0+X7aKBksvQiF/zHNqJksK+dbDeul054qSxwpyNwif07sSxFY0bf9
         gL5SYuQcZkJ8BzOZKL07LOkgIt3BSO0DSr7/61RFsjcXtjGEZUOUjoBi9/ER0g1suOwy
         OQl7Hhhd34q/W6A+uzdOWsNtLqucIB83EVxfVRBNFTSI+oFNk4SWjxWhd68syugdE0qG
         YZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730022168; x=1730626968;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY5DrXBKhx+MfbfGjjReDCLRQB1YXc8GnyEu7fo66wA=;
        b=urLYwt3D8fR67Fn2CsROUtqzG89ePmDkjNBx2JjDFJalj2sMLxVcZlJLE/LLNh4kBg
         TKG4rB5kK5RuL4Soe8cce2CzXR7iPhYPHT7AKRqlbN4SMU0m6+dkVzcZEvwdWSJo8pgS
         25LXBIQbLeYwxRnyZm29U8bEmoBo5m1ay0RqtASebxs9wIf/G/lSM6dKZTcnYizoK9KU
         pdHlrCXJpXq54u6obzfQ7Bax5GsIFG1M+45ViyEHti4zJp3whMGhQ+hGI7bpJyQcqI+j
         4Qgg1DcfUgD3AUizIupBxZuwE8Wbf/HKIMb+e8DzHJvTdZ6PYTYbWYvJg7jEPI7wULUr
         Fq0A==
X-Forwarded-Encrypted: i=1; AJvYcCWwvyKv5cUjd+JhGPBQKnEm0UHXtOgmholuxDFnkN0iTMDEKKLptCnzisQv8wG5o4CEl2oyMv1f@vger.kernel.org, AJvYcCXnwQgasOjpsATmlyPkSuCItm7rmE2nofGugJYs9Cf8M4x9s0hfmAvtoN2Pnd2ULtoZsSBwY/YDrVq/Q0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGr0hH9BuwQmldWqPYxiO9bUxHRWv6iCE76wKPTC9oyUboXc0Q
	52X9dBUT1Ho6kFoPKX6npSiNQMSKEf7NLPFLTkcpYlUvdkWcZTtA
X-Google-Smtp-Source: AGHT+IGIfRkTGbie0sdxgr2bFkrqd9cYqI0s4fuOvHAN9dPLLBBZC22W2WV8T+zFBGXb2tJ7Jzf87w==
X-Received: by 2002:a17:907:9815:b0:a99:5a3d:3cb with SMTP id a640c23a62f3a-a9de5f30d18mr136124566b.8.1730022168220;
        Sun, 27 Oct 2024 02:42:48 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b2fe2af87sm265968866b.143.2024.10.27.02.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 02:42:47 -0700 (PDT)
Message-ID: <f04c2cfd-d2d6-4dc6-91a5-0ed1d1155171@gmail.com>
Date: Sun, 27 Oct 2024 10:42:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] net: arc: rockchip: fix emac mdio node support
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: david.wu@rock-chips.com, andy.yan@rock-chips.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
Content-Language: en-US
In-Reply-To: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The binding emac_rockchip.txt is converted to YAML.
Changed against the original binding is an added MDIO subnode.
Fix emac_mdio.c so that it can handle both old and new
device trees.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/net/ethernet/arc/emac_mdio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/arc/emac_mdio.c b/drivers/net/ethernet/arc/emac_mdio.c
index 87f40c2ba904..078b1a72c161 100644
--- a/drivers/net/ethernet/arc/emac_mdio.c
+++ b/drivers/net/ethernet/arc/emac_mdio.c
@@ -133,6 +133,7 @@ int arc_mdio_probe(struct arc_emac_priv *priv)
 	struct arc_emac_mdio_bus_data *data = &priv->bus_data;
 	struct device_node *np = priv->dev->of_node;
 	const char *name = "Synopsys MII Bus";
+	struct device_node *mdio_node;
 	struct mii_bus *bus;
 	int error;

@@ -164,7 +165,13 @@ int arc_mdio_probe(struct arc_emac_priv *priv)

 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", bus->name);

-	error = of_mdiobus_register(bus, priv->dev->of_node);
+	/* Backwards compatibility for EMAC nodes without MDIO subnode. */
+	mdio_node = of_get_child_by_name(np, "mdio");
+	if (!mdio_node)
+		mdio_node = of_node_get(np);
+
+	error = of_mdiobus_register(bus, mdio_node);
+	of_node_put(mdio_node);
 	if (error) {
 		mdiobus_free(bus);
 		return dev_err_probe(priv->dev, error,
--
2.39.2


