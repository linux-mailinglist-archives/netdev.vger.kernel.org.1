Return-Path: <netdev+bounces-46238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458047E2B91
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 19:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14BD281408
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9292C85B;
	Mon,  6 Nov 2023 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="n3XlSfI+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43018035
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 18:02:09 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE18D47
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 10:02:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso41522605e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google; t=1699293719; x=1699898519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDm506CW1CfmWdc8ZEPy9UyaSh27+NblN2O42wc6Ric=;
        b=n3XlSfI+EJkXgZ8IZLr47V57EQeA2XyjilPCsf8ZdWHCdAtHZ/kz0qhIfq/mdd4cfh
         Z48kIXXUzlhf62FnfQ0aFuLaULB9+mksAfEJ2L2zqjQZh/+IC1uB7TVXS56UVHqFKERz
         2FDKXZjwADB4PnbvRL75+s5XZGx8Mqj5f3LSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293719; x=1699898519;
        h=content-transfer-encoding:cc:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDm506CW1CfmWdc8ZEPy9UyaSh27+NblN2O42wc6Ric=;
        b=T6qDV/Xt57oWS9WwjXFKjKBDRkSngbacPep3MTfPjxgUKZmKehTWT88+pZlt1HfKe1
         vdvFQTUi2vVkEtq+2gJYuuOnlKWVZSGg/VXY/gu78OZK/AEfU2sMMW8P7NnjHoFnuX4R
         61ZcvNZIJNzAOJtiENS8nwh+ipWkdC2UYrRwKRWmcE0zLMFSEZtWxAj9EqSWxSv7V4Z7
         F7YnUBpBebTD+b8Uy8X/cjj+Vwq8yg7a2xf29DN0WVG34mcz4iwdl+1XW4MY/ouybISz
         RdRrZC9pmT/gOBnE/ocq2cs/S5RRVKwRz3MGNWt1xaGfbewo/6qN6489xmwsY9bivwRw
         xUsQ==
X-Gm-Message-State: AOJu0Yyaqecccw+aT+upOg6ykoOUfwen+BbfHkPq6lBYkvgIg7p2erOH
	MEUSB3XvVJtmVBucDwBMfSzKAA==
X-Google-Smtp-Source: AGHT+IEN04Uu8Xyw8RUlVXXHKf0i80rZNPf69h/WP9HYr9XT0vrLjOEwh1KX8/yJvOWvKUwZqfwCyw==
X-Received: by 2002:a05:600c:4fd4:b0:405:3b92:2fed with SMTP id o20-20020a05600c4fd400b004053b922fedmr372167wmq.26.1699293719033;
        Mon, 06 Nov 2023 10:01:59 -0800 (PST)
Received: from [10.42.42.90] (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b004097881d7a8sm10027857wmg.0.2023.11.06.10.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:01:58 -0800 (PST)
From: Maxime Jayat <maxime.jayat@mobile-devices.fr>
X-Google-Original-From: Maxime Jayat <maxime.jayat@munic.io>
Message-ID: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
Date: Mon, 6 Nov 2023 19:01:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: netlink: Fix TDCO calculation using the old data
 bittiming
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The TDCO calculation was done using the currently applied data bittiming,
instead of the newly computed data bittiming, which means that the TDCO
had an invalid value unless setting the same data bittiming twice.

Fixes: d99755f71a80 ("can: netlink: add interface for CAN-FD Transmitter Delay Compensation (TDC)")
Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 036d85ef07f5..dfdc039d92a6 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -346,7 +346,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-			can_calc_tdco(&priv->tdc, priv->tdc_const, &priv->data_bittiming,
+			can_calc_tdco(&priv->tdc, priv->tdc_const, &dbt,
 				      &priv->ctrlmode, priv->ctrlmode_supported);
 		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
 		   * turned off. TDC is disabled: do nothing
-- 
2.34.1


