Return-Path: <netdev+bounces-143601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9A9C336E
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C83BB20FC6
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788B61FE9;
	Sun, 10 Nov 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn/FJD54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEC22097;
	Sun, 10 Nov 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253817; cv=none; b=k8+bmU/P3tmc4q+FCYMLuiTpW0AzLqLRxAKUi64A2vL9Jm76+952CuPE9U0cX1iuaoe4W7w80YuzC5wE8l0Jc9OFDYRrebtmJPo2a9YrWbKfB8C8ZJ1/tC5STFK8madjsNtix/4fDeSAyZ2koZpIj06FGmvjtbhHtXaLnwQg6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253817; c=relaxed/simple;
	bh=X2WODjlo5k6M6C+3y9/0HbRt/kyKqfDqB/5oktD9bWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5h2MtFxg8XMFtRYCplJghKpqxQPI+UucFIeOgOhTyIaveItokc6xyN7ViYYCH6hNi6czORGIslT0e/h4gmiKJjYy1BPGywg0DBk6lhT7X6wiRLSoC+uvBiLZ2QQKX454Uo9omyqR8OrAgfCcsb3ST72pgVUtGFCdZYtcCiMUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn/FJD54; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28fc8affdaso569678276.1;
        Sun, 10 Nov 2024 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731253814; x=1731858614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=431engaI3ETj/ECuLKJ1/FXiWtPiKP8c1q4cS9zRAsI=;
        b=Bn/FJD54yGvdxE0aOUQOyExaESiidTU2T3T+tPY01HtlXRor1yNzVKcOv5PHBlNHT/
         Ba2LheaIw94DnDx33Hj2WTpdPvxfB8fYwCRG9OeEQYUUoRpSbrK6qrpei7hZjyELnKd4
         d+dfEFzAnTQ4chi70T7fyo8ODpby00cPGLrYrTkpcFujlu+FDBIc1FJ0qWNvPMItFZbu
         3HHAbckYF0bsUCPRp9wPcNdSHkDKclQCUubwmjrQGnQC3BYcBnI0KpbXnp0LmgxWqYCJ
         Mk2rta+nGgjUYJnCN2vDc4h5SVzcmJqChP5svve/lAd/rf8lJSbB0JH4j2Qx21+AlAp1
         Wf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731253814; x=1731858614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=431engaI3ETj/ECuLKJ1/FXiWtPiKP8c1q4cS9zRAsI=;
        b=P4Qy40Oc7O7lKbhAHHD+oXjDhSCWHF+pNzKmDvkZ7sw1hafHWQwvZgWVB/Mh2hny3W
         au9qxeSU/x8mWWHbx7Gl4ZVpwzL7pbLyMWhJUZLtXs4xn9g8A/iGOf2KB/Vxv8FLqqVU
         K4JuaoAwsd5M2Clj+WVeb1yX9V8hL44xht+wBtHIPpg+c0cVRQpqGAUZLcJnn9IAM4u5
         smJ5oWdVsJ8Qr01yWgFe3Ra4FJq1qyybUeEcqpL/IjmLBAHUEdA+KQFCFkwwiDG16VLO
         xkBZhYgkWxrbo2Bg7fwjgslI+RJ/gdVvQln+00WqvNhxa4Vg/odCsAw6+wnAbH5vyB4i
         uP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/76csbG2aKkR5iI7F1UZdntDx+Whxh0xWwhhPl6G09YFYGDjFK1U2Fhk9/Y73QIQzWiKSucuIB2AI@vger.kernel.org, AJvYcCU72T0JAirjqxjogtZ8ZCov7Mr/Y+X8fudtiuBNi/Cjc8bjiOXmoQbivoEcz8mCrENnkhb8enX3@vger.kernel.org, AJvYcCVE0ayCIciJVikmfMSyN0lKZmKU1hag7YXBww/tIQpC09qSb4r6RUuytWRzzDNBjCywG3sZ1liTOm/eSDCs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6P6tc4slKyL3X/p+tQjrDoNuR54PiY8J8YgPVqSJFJHK+Y0gu
	Mrgq1jaMVNYnULW5XNdn73sYdYTtur/ly22tOCldn7Coy82VErEB95sKQEXf3k7Ncu2ziV2KIIj
	xfZYDKCYmfJDhxEno9Sl4gh4I1+M=
X-Google-Smtp-Source: AGHT+IHPN/wBuMSlYobvPfwyK0eBpeDQCeS36N5ParCeUsQxZMu7SQ7a+5vgzU74VvQQ+ZK1sH5FzhoeWhu1JvyCyy4=
X-Received: by 2002:a05:690c:9b08:b0:630:ed11:e751 with SMTP id
 00721157ae682-6eaddd9f19fmr34550727b3.3.1731253813818; Sun, 10 Nov 2024
 07:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109015633.82638-1-Tristram.Ha@microchip.com> <20241109015633.82638-3-Tristram.Ha@microchip.com>
In-Reply-To: <20241109015633.82638-3-Tristram.Ha@microchip.com>
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 10 Nov 2024 17:50:02 +0200
Message-ID: <CA+h21hqWPHHqMQONY2bKZ2uA2pUzm2Rqwo7LTX+guj7CHo4skQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>, 
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Nov 2024 at 03:56, <Tristram.Ha@microchip.com> wrote:
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index f73833e24622..8163342d778a 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -354,10 +354,30 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
>                                         int speed, int duplex, bool tx_pause,
>                                         bool rx_pause);
>
> +static struct phylink_pcs *
> +ksz_phylink_mac_select_pcs(struct phylink_config *config,
> +                          phy_interface_t interface)
> +{
> +       struct dsa_port *dp = dsa_phylink_to_port(config);
> +       struct ksz_device *dev = dp->ds->priv;
> +       struct ksz_port *p = &dev->ports[dp->index];
> +
> +       if (!p->sgmii)
> +               return ERR_PTR(-EOPNOTSUPP);

Since commit 7530ea26c810 ("net: phylink: remove "using_mac_select_pcs""),
returning ERR_PTR(-EOPNOTSUPP) here would actually be fatal. This error
code no longer carries any special meaning.

It would be a good idea to Cc Russell King for phylink changes.

> +       switch (interface) {
> +       case PHY_INTERFACE_MODE_SGMII:
> +       case PHY_INTERFACE_MODE_1000BASEX:
> +               return &p->pcs_priv->pcs;
> +       default:
> +               return NULL;
> +       }
> +}
> +
>  static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
>         .mac_config     = ksz_phylink_mac_config,
>         .mac_link_down  = ksz_phylink_mac_link_down,
>         .mac_link_up    = ksz9477_phylink_mac_link_up,
> +       .mac_select_pcs = ksz_phylink_mac_select_pcs,
>  };

