Return-Path: <netdev+bounces-49006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC27F0626
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 13:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE22280DA9
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207AF504;
	Sun, 19 Nov 2023 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgVFtLTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C60F115
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:20:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40a48775c58so9448005e9.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396447; x=1701001247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Grj92Y3GJCXrm3qACBBXwBOJUW9eNF47PsNlvr6THXs=;
        b=OgVFtLTkZbphOLz1iVLF8yCht1ttNCOjSfEEeLE0ABQMN6ZKgzP6C+LPmjOMkDx4Ih
         Wq5k+VvsuQM3kdmFPugp4YW2VCMF+84hHDcUHKsfU4rR1LmQQixX7qKuv/n0GfEm7XMa
         rqGCWkMNkNwhiTTIUeQFbrJ96lFSBOAIVoB9lHVEmGpr3T/TVKEVjldp4kySqIQ/DRvh
         ArbbYz6Z/kfmpCKm6UUJLTspSGuR0CiqXGBIux233ZnOd4KuSWN3SKRycMJuSTSZdXXY
         cuXb+xIDpBI7K/fUIOkz3tvT0o+BR2tN9cI2PJQjmlb5e7c6qWzdO+uN+TC/2xLB0KMe
         CPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396447; x=1701001247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grj92Y3GJCXrm3qACBBXwBOJUW9eNF47PsNlvr6THXs=;
        b=UxkJE+ZVBdMLxxQot6h9Yfm+D37OqWblxDJzvDYYSGaogFpa3OSEoZMnGnZjyHIPi1
         bGgCBK8ZxdL1frUX+NhAz3mWi3eQS1ryWD2+WM0/LrUi9nvXajz0fpl9lkZEXOxS7qWb
         hbC4VbXDWO+P20WoUlIg3l1ragBTdqZUpHqf/02k9xS8F2ekIeg4QdSUOQX9VKrSt9er
         ifJY25/bmIFcv1vAb4EuYHkAtuGfUoNG60RlSgaZcbS9qD2g2oST5zDxeCkNGtSrFTwj
         I9nnn2PjC7u4cqjpsgQVkIEQtyqRioSzqsKotXOLsByRW+oEbF+fZpNkygW5AkslPxSs
         RJEA==
X-Gm-Message-State: AOJu0Yw2zspOgt0KJ0YKjOfNA0hrMSFaaUPR7jXw7Dgq9zPab33teOHD
	z6XjEIqKrK5QT80Bkjdcnj4=
X-Google-Smtp-Source: AGHT+IH7otGc2dKs2f1WgviCDvBiecp6uJPgC1T05gAjfOqKs5x4OBzW97K6YlATx7lRtSVhWB94Rw==
X-Received: by 2002:a7b:c451:0:b0:405:e492:8aef with SMTP id l17-20020a7bc451000000b00405e4928aefmr4256266wmi.40.1700396446546;
        Sun, 19 Nov 2023 04:20:46 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040813e14b49sm14164001wmq.30.2023.11.19.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:20:46 -0800 (PST)
Date: Sun, 19 Nov 2023 14:20:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [net-next 1/2] net: dsa: realtek: create realtek-common
Message-ID: <20231119122044.ttvoep3j4vlxyj3e@skbuf>
References: <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-2-luizluca@gmail.com>
 <20231117235140.1178-2-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117235140.1178-2-luizluca@gmail.com>
 <20231117235140.1178-2-luizluca@gmail.com>

On Fri, Nov 17, 2023 at 08:50:00PM -0300, Luiz Angelo Daros de Luca wrote:
> +void realtek_common_remove(struct realtek_priv *priv)
> +{
> +	if (!priv)
> +		return;

I'd leave this check out of realtek_common_remove(). You also have it in
the smi/mdio callers.

> +
> +	dsa_unregister_switch(priv->ds);
> +	if (priv->user_mii_bus)
> +		of_node_put(priv->user_mii_bus->dev.of_node);
> +
> +	/* leave the device reset asserted */
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, 1);
> +}
> +EXPORT_SYMBOL(realtek_common_remove);

