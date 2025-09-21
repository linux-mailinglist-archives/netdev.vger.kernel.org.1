Return-Path: <netdev+bounces-225111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F2B8E7B7
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC518995CE
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69A2D94A1;
	Sun, 21 Sep 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exP9qs56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FEC2D7387
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491784; cv=none; b=l+/PYnNDMBy7pqDi09BoENm7H3lD6IFTSpuH1P87xO80Sryw1uY7niwEJ7jcQVzFcTPoPczHyCci/boQ1M4XABtah42du+IXCteTyKiJyYk5LdAgZda7jIr0o5wUg4jbH5exDgVjf62eIGnfgv+uZ35FwsP7Np6qaBkTxlVYIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491784; c=relaxed/simple;
	bh=5mhr6jsCmNwNcnFO+5SOJs2r7HZGP3JEvC2ipj5IjA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Telf9ARdhM6CfXc01RXlejETdArfUIrRC+COLKZbCgmh89Owxk1mqJN3/eTcF2whQKF63c+84ff2Mj6cPjOjVufT9uxKqiomqpk9Bgn5J1cZHpTzYG0eYV75XKvMbacErC0tpfRrZjSNBPNNGufUEXekuAR0EH01mhRzQRcZogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exP9qs56; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so2621290f8f.3
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491781; x=1759096581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIdf/p+W7Ujz2zhxctFos5mKw5BeHeIDmEYf9Zo81XM=;
        b=exP9qs56EheJ0KTyavSfU4CutrSm3AZGDYNksp9wcRVQqwpjuPXEnbFGpsTif0XOEj
         u97F3L0MneGN2XahP07v54YBvcxyxGbmYw/75jwiwHV+w0EOroaskCGD690GBiUbGzkJ
         JIL8Xy0qpxzObRNfNLDW0vCq/cdIRvXpQK+y6n9ilojXJqZ1ECqbG4spQPEJl/hb7qav
         2mKXShJ2Q9Ya4KmLyDf5/k+8ahg+CYkbqOkVIfni//AtjW1mSMPdk89XzTWPAk6XaYHS
         gODsMJwC5Bx019xmpU98NUsm2DYteFt7Bh1KFUZXnB7baUF2oBc/Zi+I/vm0GT8YNTxQ
         VTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491781; x=1759096581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIdf/p+W7Ujz2zhxctFos5mKw5BeHeIDmEYf9Zo81XM=;
        b=BF0BvbulsKfrR6R0TSqAVv8qrBForJOaLpT7JsRydr7g9cKgItfqTykJmrNt7hGrkj
         j9TeVv/kuB5FFfquTD4ZwIDuTf3AT/dGv/OCfq66pthkPG/qYHlKdOrCL7YiWkSQH4At
         rg7PcB4c00HDG/tFfkTqqRzazvWjbO8ILE22Y1ZB+gNojbN7LJbdgq0XYUaGEuFP6szb
         /i/J/7C8nIGxJaAdH5iFOcT9qfhdUcru95uix8ouzwxy05pOkeeC0fRijfkV5TyhkdOY
         RKnFLAnAzVYQWMmJmSQhKYXJ3GK+GNDTgUCDv7SNr1ibpTgJ43eev9d2/utHlDk+lXKZ
         xI+A==
X-Gm-Message-State: AOJu0YxlnrQwZK/+HwvKMh1pZAwHFbUVZH7feSvs4SPLdqV75puaVh7o
	gMF61HMAMtW31crrB/SYBMmh/X7My09UJMewdhHoXpXml19C0AbiN913
X-Gm-Gg: ASbGnctz0r4/IgcdMXAWarYPPUskQxNGsInfqxPtnzwrVviyn0OuLdZwKFujywmsSRF
	xbOUKxJ4ctHU+87WVq4apEGV+4fsvBvSm1Uk0WnUdknqJ0BR0WoXCbKpW2U+z/ExBM3/HDhgHH5
	2AeFJR/OA4dvmc7MmxvHKM7diRVVbMhdK/Wi7WWfrnKCvRmq5q6/7TtJd2KBqfhQjJwnPvo2FMl
	+qBg16MYYVq42shafREfJ+oDRumLz01wriCjDQ05magQdd0T/odMIwGsyTeBnVJ7QQhM9ETInf3
	QjZ7ZFbK/tqvoM1NwR7j6dJL2muUhFsP6fg8ogjUQ1z/M3ytHelfLZcJn3jF0R2xbRpFNrBSDx9
	z58zfsSBYerNbJorS72dz5i2tDDk=
X-Google-Smtp-Source: AGHT+IGmt6XLl3zQskh0zYm6CtZaqKN29aHDDxgwtm82G8MAOnuWyw277HU2wC6kT7gu0jDroko1Iw==
X-Received: by 2002:a05:6000:604:b0:3ea:80ec:8552 with SMTP id ffacd0b85a97d-3ee87327999mr8985604f8f.57.1758491781147;
        Sun, 21 Sep 2025 14:56:21 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:20 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:43 +0100
Subject: [PATCH net-next v2 3/6] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-3-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2084;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=WsXzbr4oh2tgdkoPqzROUayYBAGNEehpMnq5WhfJccU=;
 b=LhIkGrcYxDjv8+RfVaEAQ724BmARmMrU8Kdv7X/xIwney+vtPBHaNAwvzpolmZrkvi0FXESSg
 D+YOAd9sg0IBqJ2kuYBNebJb9FcO7xuXnyWVV4iCp34zyq0e4cZ4Wn9
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.
Mark the device that is down due to  NETDEV_UNREGISTER as
STATE_DEACTIVATED, this, should be the same as STATE_DISABLED from
a code perspective.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 688ed670b37b56ab4a03d43fb3de94ca0e6a8360..59d770bb4baa5f9616b10c0dfb39ed45a4eb7710 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1446,7 +1455,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->state = STATE_DISABLED;
+				nt->state = STATE_DEACTIVATED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}

-- 
2.51.0


