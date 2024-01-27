Return-Path: <netdev+bounces-66398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAF083ED47
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D66C1F22847
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B62557A;
	Sat, 27 Jan 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfY1m8JX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B651288AE
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361970; cv=none; b=LSqsRN0VzC93RUWkKU5atwbGrxm2RCtbWcfKMu72mFqmnqHvnh9danEfzccp0ICkgF0wmkiLM3oHNlHWeIa/mCzTaBFXbpYmHVS2s+FFTZYywvVDHcG8/xnwPY6TKBZ0fNrwC0PwHDwBVpvaW8FL+Xcbam8A/PBlNvHOPs8BadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361970; c=relaxed/simple;
	bh=iz9J6M26ufNvZvK4WV0jBufbcF5Xc6h6BkEX3JzXixs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b8Z3u2syV4O7k6ljJenpVrTI8npPjgRI1znk3GA+xqB81JVulmE6xM6bl1CoVW9fZkcFI6Ryl9iIOeTHULZDVEF8InQlFt4uF6CJcRufGaZUM9uVPRgqv9ew9+kLhVxHT5mmL1Sh5Oo0yMMl1JKdzfvkPNkgzZB6J6GnxcbK6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfY1m8JX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef0908c84so1495275e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706361967; x=1706966767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zjYZmyLvYvgL6GepoRgchL00RhldpBQuzdMcY7BhdhE=;
        b=QfY1m8JXfijYayvvIK+31jCOqhQP91TT2mYzV+JQ3K90PH8daHlc8Qr2WAkrWCSqJF
         ubtB7LSLrE5wX9v933ee3WOmvzCzSi1A2u9z5pkC92ewN3pwTc6RlvzfO/cvcXa7iKCo
         iCsj4SIMxf2zHgHrd/ZqAFkzdz/d40jGNEpPc8ERaX2zP68RCDC9qqE11wuwELDkimDv
         j3Y7zanQq5GIP7kFFYts2iYfEOhp0r2TzpxHvUXenqkImWHEh1iUY/GG4/ashm/kHgNW
         WCTj5DvqqH+MfUY/zFDM8Ei2x9Q6YQiAqCu5KNd52ZaCAPPMljmMoLbhT/n7sOtFjB78
         NJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706361967; x=1706966767;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjYZmyLvYvgL6GepoRgchL00RhldpBQuzdMcY7BhdhE=;
        b=ZdyIzASxv9+T/F0RRETHpbFoo5qdwMmP09Pq6Lns7SSlXDWemoCoxcfKznlnPgI4EF
         ZbrVceKaDHIExwnGdous74yohZGmWi3XJYDuShB65JvI8bVbZ4cshI3f9DSsBFyZCKYu
         JtWDIyndh43v+4g954sALhjsOGEFaHl/Q1s89ArwfrGtmzQXKspv7mj6tFWmXCYe6yCT
         hi5MiGyKKeY0x4wqlxbFl0+y5oB2F94fYhYbNRWq3q4Raae2B1cBJl+Gi8hck3pzjP87
         DnbE4OG8H/gjLv+yFjRXzD/UqYGWQtFR/zK0C7SwwxYn+KhWcaBr9esbsQbWQwrKP1xh
         Wydg==
X-Gm-Message-State: AOJu0YyK4zbEb0Me5cljfW8icJRtsHS3l+pa3Z4h+R+FB8vb6n3iPGR6
	Y5cZG3MdvQ//k3DZDY4MGlvgp7iEBQV22vnjYVrDnXtR+eYgL0mf
X-Google-Smtp-Source: AGHT+IEwu0KjpWYQjAgHEIDcPHro/yFCapj3yTAeVDLEx43Mj9HPN84vLs/Aw6vR754Lw5z3jxHE2Q==
X-Received: by 2002:a05:600c:310d:b0:40e:ce97:445c with SMTP id g13-20020a05600c310d00b0040ece97445cmr1268371wmo.13.1706361967178;
        Sat, 27 Jan 2024 05:26:07 -0800 (PST)
Received: from ?IPV6:2a01:c23:b938:5400:11ba:857c:4df8:38b0? (dynamic-2a01-0c23-b938-5400-11ba-857c-4df8-38b0.c23.pool.telefonica.de. [2a01:c23:b938:5400:11ba:857c:4df8:38b0])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b0040eccfa8a36sm4732850wmp.27.2024.01.27.05.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:26:06 -0800 (PST)
Message-ID: <23d684d4-7e3a-4b3f-8b73-11d954b1a375@gmail.com>
Date: Sat, 27 Jan 2024 14:26:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 2/6] ethtool: switch back from ethtool_keee to
 ethtool_eee for ioctl
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
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




