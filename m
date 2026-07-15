Return-Path: <netdev+bounces-307680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ekQGP41V2qoHQEAu9opvQ
	(envelope-from <netdev+bounces-307680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:25:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF775B68E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LuPuuhcy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307680-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84496300D154
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E32931D1;
	Wed, 15 Jul 2026 07:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBEA3C1F4F
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:25:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100336; cv=none; b=e/P4gaijG2NqOYYYKEPyLeul1kyssuv3b4F2qdbTDm2tvUWQ4T+iMyHxL0mhzCzdGMEwuV/UN1N5R+tVSiRFGVlcKgOuxkJvb1EHTzHTRfaC4rsOqE5PD1Y0a6qKFqu5FGx8vXVaoffnnVYSfsdqzZAheUyY6Ljz+IFfthY05S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100336; c=relaxed/simple;
	bh=+xNeKad0my5Lxbp051jpwUdn5q02n5i0vkLtt1z+Qw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umfXILrwJlkI3QtQM7RF3v4pZUmFWnjEgHhXIru65mGZC7lp/ll3UKq2muLN212s2juF4f4RoWkynKdFNcUyr5nE7zX4G8aqUixTKJaLZ/ciuL0TTS/pXNno/05XDv9Chc3nRLRRFhdVdlUD4oJkTAwcfPb1sBHWsE38OJfD/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuPuuhcy; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2584910b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784100325; x=1784705125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGt2cr+LeB3UkXqtVqaVVeyWXI4uRWYJcILUaXR46qQ=;
        b=LuPuuhcynMq3MywZoXProRlXalVJEwi/ll9aIT9TNS/BF9r+m1sfmGhFlZbSzxuYrv
         RyzKz1iNvhjNIAVsCHfxIVoloU8oOHRFoWUSlnX1dJ965vFTwLgD9GtL4Ut3PTcHnpKQ
         Vonq5G+RxRxeK/z6yPaqyPsJmvSmFx9rGGWkb+1YIMU3bj+FWuSgGKA10urkOtSmov57
         KvhFTu9jmp3mxnYpFzbfOFSpSeaSefKc5roaLYrmf2/eP4cBkaQziKifazzgpcUbxamf
         ApZh0ZA8cDt2H+KolPQ4rz0Q0DiOZnseRdeL8XUHAnzJxCpcs9WE06v4wa+5vLwC89iI
         5sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100325; x=1784705125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGt2cr+LeB3UkXqtVqaVVeyWXI4uRWYJcILUaXR46qQ=;
        b=JeA/8CcCE7U9R5NH4qP9QFmRD3Od1EgXeY5M0la8wjWtXibaAZe/D938AGjhjOIhGj
         lsQRIAui3an1DnB8UGkjOJ1HhWii848EjV2Rx+Nya+kbP+iCh7dk1JyGzLWhwIXtfW/2
         XJPlb7fGy9iB7kM3xRFGkfGA96lo1JGDoQ0K3+NtSLw4rtDeehHvAzgMhG6hf08PkJuZ
         in0EbBqZku+ZROXcQxpXzVLMKdDDMeBozZept8kNbX6u8mvzyijlaTJQCFpRV3Tral//
         yIJyE2bGBvUs5jBJ4MQXa/8cujVbYf7JPKvVWI/GxAr65Horlw7c3YS7oostxpKplu/h
         Nyqw==
X-Forwarded-Encrypted: i=1; AHgh+RpGt6cC00v9Uo7Zk87WRpEGxkI/yhqnXII8gY9BitE9pBYT9NjSS3I80BQaI5bM9iDL6xGsbnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx992e/g3qa0xlWp/wNuLnt9tQYfXLsENY2kB7ATkAFV46/YWNj
	yJAu/dbREtTOBEmAOVS2DeX+eYW0x9ri8NYMGJwKUW/8y3wgRslGAKQ=
X-Gm-Gg: AfdE7ckVW4b7gMXO1RPA3B1c5p89yDAxwC6UMffAOiamF9pI7uJnQTTa83a+27MWHzR
	fZAFCaRYReI9fypmz0RORO+Go8fEnq7ebNidNWzKuCb6YbUrPnK0POiPxTfM4CK9/ddMZl9RPc2
	hYh5IGA1X90VSnSHUp3J3is/CbuawQesaxW82EhCCF+n/e5LWFTgOu7IHfJ4+2ijPzoF5kFMOqM
	ZNs3sE9wMVaj+ejtSdLjXioBvRaI/30Ay5Jq4Lk2rOkI05iTEN7zZYo6hq9XJ8fSN1AJnVQYMpm
	fGf9ghMuruZzgFgDU/t9zRpznNPGOXNu6bGeoY2U63GzoXL6WVGWJhnybNJ5oQT6fzwi1nF+8an
	7lkubmvYRLaov3LNUL9RGG13GSki7UEfbE83DXZjQzDyBDpcPnx61uLnY2E0HXPheAuAWE9x+d0
	QvwY5gCaV8qPjnvV81TswDdHE5HvBMwvjqUkdKaYcGx1dNiijif8s7Qu2TrTHLDbXtVzQrEtDdj
	ImQgRVXKLMVkKk68AlLBhnppfdzookSn01kLicON9WzeR84WiRq0aLqGn8I
X-Received: by 2002:a05:6a00:3d4b:b0:847:8bf0:b82 with SMTP id d2e1a72fcca58-84889758b03mr15624999b3a.60.1784100325483;
        Wed, 15 Jul 2026 00:25:25 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afbc1363sm10759807a12.8.2026.07.15.00.25.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 00:25:24 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] net: mctp i3c: clean up notifier and buses if driver register fails
Date: Wed, 15 Jul 2026 16:25:17 +0900
Message-Id: <20260715072517.13216-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307680-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CADF775B68E

mctp_i3c_mod_init() registers the I3C bus notifier and then walks the
existing buses with i3c_for_each_bus_locked(mctp_i3c_bus_add_new, NULL)
before registering the I3C device driver.  If i3c_driver_register()
fails, the function returns the error directly, leaving the notifier
registered and every mctp_i3c_bus object created for the existing buses
allocated.  The notifier is left pointing into the module that failed to
load and the bus list is leaked.

Mirror the module exit path on this failure: unregister the notifier and
tear down the buses that were added before returning the error.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Remove the unmatched i3c_driver_unregister() from the notifier
  registration failure path, as suggested by Jeremy.
- Add Simon Horman to Cc.

 drivers/net/mctp/mctp-i3c.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 6d2bbae747..88d9e36cd4 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -731,18 +731,21 @@ static __init int mctp_i3c_mod_init(void)
 	int rc;
 
 	rc = i3c_register_notifier(&mctp_i3c_notifier);
-	if (rc < 0) {
-		i3c_driver_unregister(&mctp_i3c_driver);
+	if (rc < 0)
 		return rc;
-	}
 
 	i3c_for_each_bus_locked(mctp_i3c_bus_add_new, NULL);
 
 	rc = i3c_driver_register(&mctp_i3c_driver);
 	if (rc < 0)
-		return rc;
+		goto err_unregister_notifier;

 	return 0;
+
+err_unregister_notifier:
+	i3c_unregister_notifier(&mctp_i3c_notifier);
+	mctp_i3c_bus_remove_all();
+	return rc;
 }

 static __exit void mctp_i3c_mod_exit(void)
--
2.53.0

