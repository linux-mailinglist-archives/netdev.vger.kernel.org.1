Return-Path: <netdev+bounces-242048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB535C8BD3E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B068A4ECF6B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300F344048;
	Wed, 26 Nov 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbbaRCMu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E034402D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188607; cv=none; b=ft/VMmYnutXo0V9ME+qCAcIMz45eOTGOkML8Ecd2RHbrI1TpxkAyyIIIcazbT1x2dWAo99e1c558llCXaZToKzYo3mVmT1sZuHUgpM5RlAm4gaM4e0MrgQCcYYCphJejCwXHrjG5eJwm8oMHarSWJW2RMIttslWijWmRlVwxmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188607; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NP/+3Q8bb6vFQF4QSa5XdmOYxlw3WwPpxjcopKPnI29nlk7XH/Z9AO4m63kdNs8R8dqoWXTN8wxGLE//ex531xqOIjpfCfL3yJk0kNl0JdDN0wt8RzYRYRKw+khxFOImEZDOi7noOz25QR0h4guOnEcB0lBqnVYKw02wJQy8yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbbaRCMu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e982506fso2163745ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188605; x=1764793405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=QbbaRCMutWdy8VBU7QOm/Di7vDec7kR4wXzLpS8nM0UC3D8a+RcUqBiR9h0BvSl7l7
         A8bd3OaQ4dAUDCSwBqtERrTu4gQFp0/8EsDNYlZ+HKED1Vbe+bo0RpjIjTWDqKk2KQ3m
         m8/ftGRHIcEsUtRpjYCEp7t4x7AsftRSiff8yV8bYoxeDDS5teJdx4jb8+fIu0WkPxfj
         Rb6iGVa5B8slO3/208HljEZwFkLWBTrJ6mbFLmDERPijz9sesU+sFdn0ltx1EBdXgbMa
         xMx5iolKt19G0fAvb5mTk2Lul1BXEHIifXbph1VXthv/FutpLrg7g/PRqobJ3DEK1WV7
         KEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188605; x=1764793405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=HMQEmjhzA4yG1ONCwSRbS6KfKUOdnRvEn05t1xMlJVuOH31fEwE9xiQhpl7DaEm0e8
         UssNbzdFpPlfmHJBgJ8fhb2NL2BwmSoIxrzjpn+y9+ikP8+BmOwNMqnXPASm5nSvlbg/
         YMHnUl24Zu9pqXcStJ3sZcZcuFMAqqDovb/ToXbh1Y5AS4PGZ9UDLb9G4kDG/tH0+WKR
         swz0Zdv9LRZJ/FJGRzYx93Kmk5ejDc9PdY2Ll6LsFJCQUn1YJFcQROSKb6Gm+NQW1KPC
         sGPOh8afFhx3OC7pHQvN/6JRwYZn2JV5xDSs9LtY1YdYfNZvFju0iqcs12gbQago+imF
         Ug+w==
X-Gm-Message-State: AOJu0Yz7GW5dfvEahRGRqSXE1O1SPnsxL20falHeoZyLarBu52TCoa4G
	Ekd9x70hAEOc8WD/fDKIOTgHqTx6z6yuXG7OlsI3txR4cfVEF+2SzWnf
X-Gm-Gg: ASbGncv5EOBWtIuhRjYk8QyzMiXcwFz/g5Fv7bzngZi/kRkyvMKip0ZHMOYhBQg+Q5v
	LWmP3sQUS5W66HpmtK8yHxBjNceMYqNZRVVSN+I3cQ525PhHO5taloBFNPfeoQuPbnso8UG22kA
	mWl8LXT44o03fBanXApYf+0qEQ/ZzH9eCK602iyecoiDDfJZikJgQPlGMRbBT/XCwTVe2KfnJU/
	XUa2eOGSf26sngYKuJnHr09U6ddCbvm1Jjh++TPE15mpgfhfAGY0YqYBYOavPT9H0XUcp8gBSYC
	VFaR8NQzhaReRuP8YqfqP8EeUmFa0spLuzm/BWC3OepRnuLhyVSsKH15Zp33f5r+tyUKu71UZOD
	xEvbfkG2RXaQLiTtk7fI9uUL6PMSMs+YUlJ0cywly28fUfEwwm3ovPf/DHX2H9JtSWBWvdYzMth
	+nAS/n3a1YpsdGNZdSEd0czOHyuUas
X-Google-Smtp-Source: AGHT+IHGB5xyi1FRDO7qHEuNyrSdPuJIf66uTvcetBn/DBSU9Vii6oLU5Y+uncUTdE5yg8blVoT9WQ==
X-Received: by 2002:a17:903:2acc:b0:298:603b:dc46 with SMTP id d9443c01a7336-29b6bf37df2mr258195425ad.39.1764188604441;
        Wed, 26 Nov 2025 12:23:24 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm207100475ad.35.2025.11.26.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:23:23 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 26 Nov 2025 20:22:55 +0000
Subject: [PATCH net-next v7 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-netcons-retrigger-v7-3-1d86dba83b1c@gmail.com>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
In-Reply-To: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764188576; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=SAJQL5ZINCumtqkECOtyodcazmBLEaPG4kqXo8BJJNM+nb4uiY0spJyYDIMSkqHNOUpxUNvLP
 Js7kLRT7E39BoVXz89doaMvxrg303N9bDKMIWgzdmXTns8Is+sOzLHo
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


