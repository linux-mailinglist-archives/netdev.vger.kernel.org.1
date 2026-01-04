Return-Path: <netdev+bounces-246799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A67CF1347
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 868BE30019DE
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88C2D7DE9;
	Sun,  4 Jan 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtckQmtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139C2D7DDD
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552115; cv=none; b=IlGosvDZgi4d7zmDdVGrpOt5ieVVLIynZj9S+XpweGNP1j17wTWZb0K6np/g30Fpv9dMkOKqoMpnQbq/2hysiVXAeu4Jw6e0wAw2wtiwVHLDHjG3UtSrUdX3fCpAlTR7ESu2E0Z8xZm22SrjBGYzkf1srH8bHN/Y9xzvmo5jPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552115; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF+ipTwJQXv7f+TMiGTAkWB4/XXyNbK0BNYRJ3krZtt7+lkYHZnFCSLlnwqhxZDQRYgd1N++ekpvqWwOaX2e4N6NU2ihlS2DvLtD6pisSTTkTLB6i/k9B91HGBi9pzfd8Q8jQp5BMt/86oxZJhTdXZ+Hcko4UR5JAs0FZd7caCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtckQmtq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a2ea96930cso151984795ad.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 10:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552113; x=1768156913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=jtckQmtq+Z0flE/4z9TctNvX9W9LWLunJWaNZjTtukk+oNHZfnwiUiDy8aFq1Lodin
         abW8vXQwIBx/6IFCeqO73GdkEWfdna1tto32eniSu50sS3b3UG/+bARuvPrCeoWFEZIZ
         /TByR3xbQvRIbejFJ734q5VpyY+OLVgGK72IXQYHNJOKfF61THsLN2RCJwwX4+oLqidD
         5lqU76x4TVbqVhAtH9j1CIpY5IfdSkzeVpvrkE9GIWmyKvkFXotcyeJUolpdNwPSndDf
         qozu1y5wZtwQ0JYZXVJjVGRNwzoQNO9Ht3FkmSQAB1sIvUM289+WrPKr9ikvapI0GXiN
         uRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552113; x=1768156913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=F6k5IIxWtE8PJ4YvZX1Bnvbu2ZMuBGHpq7C/aAH+5wXUgIJHMnEHjp/SCm544iMWW8
         1jXWUYpluL08rFi+n1s3oe3823Hqdl8c18Iri8PW5ug4ZL4hrEBrkXLwiKyPSRF41Tc6
         7bIoUxXd7O2hjKJeN8GiCSMwSHK9g8b5BVJerdaVQFk1saBPbVzwgt91q7tLX2sZLhI1
         i5XuDV5fuaotawyUIC10S5wsGcfYSn3s1a2+mPSlbEsMcGu/vJet0JtCUMkT0ImNQEoF
         GhIgwAl2peUjoNIcpIEq61rgi74wtsQfLr8cvYhSHiGOz/klNEoUMt1SmtfqAbKYtVtf
         aaGQ==
X-Gm-Message-State: AOJu0Yxiihgu6ZCkvsH8I8phLypG43al8i5yeFrPX73yyHoCdz5DwGwD
	1ILTdV2nV/Q3THSyISB73oiy9XEaFAPfO47oqtOc5Io3Ik71YtyTDSHl
X-Gm-Gg: AY/fxX6PU5xwvQwSOqC9gqwasJNiOJrtWCEVmeaMF/xzBfierocEvsZqWAZIMp37IZ2
	coKfkO+LiGnMw1GFfPAel9N0fZ/Sl1f4FCp3admhHAWACNeP+vtnxYNX7wW8Unhp4s63DIpkhB9
	2FgYBYDpWhuKiO6udDJkVe4qRhewebqfgIRmrhK02gzoBr9tKfGWarSiL/vQUMuO6xpj334QRb8
	A9jYsFgX6HDYqcifFe+9AgFlH7EcA8xjP2ZBbR+zx2CtWO3m2ViyZRTcspRzctAf0I83U98+nrk
	3d8mM4VIHtXIgaKwsA4avcA6F4genfOUBrLUnhgndcFeqnn3ESFYQb+7QnrYJsjilROLqGE1bFc
	UB4j/sGxpSA/C8lEO3XNT6OSHWK0+XM0GJcwbmYQwwwpeHoX2b8/gKryw8wNqgIv2j396kI8wwA
	TsPExFSu/mlnw5nHDu
X-Google-Smtp-Source: AGHT+IEQqPsuEeqSwJnEmQG6HRSkHTjK4rOFxwa+Org4QKZJRNkBh+LEQ9iqbFn0O6b3i5bQUEEUxw==
X-Received: by 2002:a05:7022:f307:b0:11d:ef84:6cff with SMTP id a92af1059eb24-12172308947mr41968866c88.37.1767552113327;
        Sun, 04 Jan 2026 10:41:53 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:52 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:13 +0000
Subject: [PATCH net-next v9 3/6] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-3-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=9BWcXu9Fg7r9j3L7E5V0TBCP14D0o6QF69OAWDX50MoYWCkS/CfIzLkCaOhni/6GXsEDKlWxP
 g+k4/TDEhnfCR/UNaLWnaqv7wSY6dpVpZqpB15KHJCnGq5BdslcaI/M
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

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b21ecea60d52..7a1e5559fc0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -580,6 +581,14 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -1445,10 +1454,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


