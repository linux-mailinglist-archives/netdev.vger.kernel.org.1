Return-Path: <netdev+bounces-66288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD083E4EA
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE16A286529
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77CD1805E;
	Fri, 26 Jan 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN9qgyQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CB24A1D
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307221; cv=none; b=ZhDD0OFyxqkSr8R3qXWSZEMpNqI4UtP66klwBf572SsQA5fZdl7au1++8b6wrLbEV9RVqX9J/RS58Wu2IIKr32xU3GZzcXM5Bm8ZmxD2f81ssr+PHnIYdpaEu86XMP3xZtBWInIeGVyOhThJP05L4F7Mjzd2/2x4zqL8i407ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307221; c=relaxed/simple;
	bh=iz9J6M26ufNvZvK4WV0jBufbcF5Xc6h6BkEX3JzXixs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N9U/atgQyOLdE6qMPspTDK19qsVjBX6a/oNle0uYFdBeSugZ9jiJfeoBzhjmu6Ea1sBvdr14gsy6mqeS+VWLrcgsC5lO1RM96hCmJPkO3vXzuDKZQ9s0Jaw8IRfv6KTKnMyAEcCRl5oZFBbNE82Vuj0lMOZh7v7kicaymO6onqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN9qgyQP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a34afe3bdf0so75667066b.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307218; x=1706912018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zjYZmyLvYvgL6GepoRgchL00RhldpBQuzdMcY7BhdhE=;
        b=UN9qgyQPVvoE+bavYyE9Iwhxsu9FRBjiJRnEbAwGfokFGb6Z9gdoextBPYBYJXkUYm
         YyNMuUCofbmoN6LXBOJJMOcvMa4qJjIVLur7L2SXFAY8TIjGzpqy7z2BFRY287VTZN+c
         Kz23qPNv6A23D/iP0NuaM9GSTyl6+qV449IPNjDXo5FcX7YRqZGh8UfLUwyLa3Q3UMGA
         cqVA4uG3v+v8PkBtVRTWSEzFEPXUDkmqLCzQZiHY9Sl4LeLiiAEvnDGIZhmOo0SLwW/m
         UDHz23e4pX0CkEL57/RGC7KnuY6GJR9euCB+PPAkBxbDHyvF/5byN9ZmkTtE6XAsWx0J
         tIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307218; x=1706912018;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjYZmyLvYvgL6GepoRgchL00RhldpBQuzdMcY7BhdhE=;
        b=itWbo9CHBfYTyJoVJKcKQH6oKfsWovIg2R/mZKWhf5UVQ6FrqaJ6lKdkZlgCBvNWiW
         Hc44ycGVxTJHJoBXsy9XaJQr673h8z45saJzYC91gl5KZyRfdyBT4rrg47EgupHdCLv2
         ZAoyR2Tb5qoDlduRnzvcsCnX9JXUlEHFvN3cvBqT5s00CD+a6T09qssGo//xnuXsECQJ
         P80HkLb2W0Sf+JzR3+m+iKlOvI8zlup/jSTf9KUxJ3QtzoIPqcSxWzxFJTyeSBxbfLBf
         RQlV2E5rPNvemq86KRaM9uBCiqe1Z3KY4PZvMmflD2pBRjCDBReFl8mjXyZ5li7G949q
         eqNw==
X-Gm-Message-State: AOJu0YwH9YkN/5n6TO0SaaP2l39U/DU2yZj0V+BHKyNLQFVGOLcYGuST
	jb+ZCoUf+TmG0dnVkKc+fiNrLk9xWAkI0+k2P9UZX6LJ9kxTxRL+z5tsoCI6
X-Google-Smtp-Source: AGHT+IEUAPhNtL6ftJpKTewipegCGzwazza4yDcWkle8oCcfgaZwhcMf/3YyUBLexUGsnHkUMmG88g==
X-Received: by 2002:a17:906:fa04:b0:a28:fe84:f2c6 with SMTP id lo4-20020a170906fa0400b00a28fe84f2c6mr238232ejb.15.1706307217887;
        Fri, 26 Jan 2024 14:13:37 -0800 (PST)
Received: from ?IPV6:2a01:c23:b936:a00:2153:65f5:37dd:e726? (dynamic-2a01-0c23-b936-0a00-2153-65f5-37dd-e726.c23.pool.telefonica.de. [2a01:c23:b936:a00:2153:65f5:37dd:e726])
        by smtp.googlemail.com with ESMTPSA id qc10-20020a170906d8aa00b00a34a47ca2b2sm1047973ejb.85.2024.01.26.14.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:13:37 -0800 (PST)
Message-ID: <9a1d17fb-f571-476d-bf78-cb5c576bce28@gmail.com>
Date: Fri, 26 Jan 2024 23:13:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 2/6] ethtool: switch back from ethtool_keee to
 ethtool_eee for ioctl
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to later extend struct ethtool_keee, we have to decouple it
from the userspace format represented by struct ethtool_eee.
Therefore switch back to struct ethtool_eee, representing the userspace
format, and add conversion between ethtool_eee and ethtool_keee.
Struct ethtool_keee will be changed in follow-up patches, therefore
don't do a *keee = *eee here.
Member cmd isn't copied, because it's not used, and we'll remove
it in the next patch of this series. In addition omit setting cmd
to ETHTOOL_GEEE in the ioctl response, userspace ethtool isn't
interested in it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/ethtool/ioctl.c | 48 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b02ca72f4..46c29b369 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1508,22 +1508,50 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 	return 0;
 }
 
+static void eee_to_keee(struct ethtool_keee *keee,
+			const struct ethtool_eee *eee)
+{
+	memset(keee, 0, sizeof(*keee));
+
+	keee->supported = eee->supported;
+	keee->advertised = eee->advertised;
+	keee->lp_advertised = eee->lp_advertised;
+	keee->eee_active = eee->eee_active;
+	keee->eee_enabled = eee->eee_enabled;
+	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
+	keee->tx_lpi_timer = eee->tx_lpi_timer;
+}
+
+static void keee_to_eee(struct ethtool_eee *eee,
+			const struct ethtool_keee *keee)
+{
+	memset(eee, 0, sizeof(*eee));
+
+	eee->supported = keee->supported;
+	eee->advertised = keee->advertised;
+	eee->lp_advertised = keee->lp_advertised;
+	eee->eee_active = keee->eee_active;
+	eee->eee_enabled = keee->eee_enabled;
+	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
+	eee->tx_lpi_timer = keee->tx_lpi_timer;
+}
+
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_keee edata;
+	struct ethtool_keee keee;
+	struct ethtool_eee eee;
 	int rc;
 
 	if (!dev->ethtool_ops->get_eee)
 		return -EOPNOTSUPP;
 
-	memset(&edata, 0, sizeof(struct ethtool_keee));
-	edata.cmd = ETHTOOL_GEEE;
-	rc = dev->ethtool_ops->get_eee(dev, &edata);
-
+	memset(&keee, 0, sizeof(keee));
+	rc = dev->ethtool_ops->get_eee(dev, &keee);
 	if (rc)
 		return rc;
 
-	if (copy_to_user(useraddr, &edata, sizeof(edata)))
+	keee_to_eee(&eee, &keee);
+	if (copy_to_user(useraddr, &eee, sizeof(eee)))
 		return -EFAULT;
 
 	return 0;
@@ -1531,16 +1559,18 @@ static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 
 static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_keee edata;
+	struct ethtool_keee keee;
+	struct ethtool_eee eee;
 	int ret;
 
 	if (!dev->ethtool_ops->set_eee)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&edata, useraddr, sizeof(edata)))
+	if (copy_from_user(&eee, useraddr, sizeof(eee)))
 		return -EFAULT;
 
-	ret = dev->ethtool_ops->set_eee(dev, &edata);
+	eee_to_keee(&keee, &eee);
+	ret = dev->ethtool_ops->set_eee(dev, &keee);
 	if (!ret)
 		ethtool_notify(dev, ETHTOOL_MSG_EEE_NTF, NULL);
 	return ret;
-- 
2.43.0



