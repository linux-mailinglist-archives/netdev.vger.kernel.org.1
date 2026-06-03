Return-Path: <netdev+bounces-294764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1H0cDJI2IGqoygAAu9opvQ
	(envelope-from <netdev+bounces-294764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ED4638724
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:13:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bOQPueHa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294764-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294764-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7529430425A5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C133F8A6;
	Wed,  3 Jun 2026 14:08:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA03806B6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:07:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495680; cv=none; b=CMQYoTxoXA4sveUARJZ5gEYh0PEBb+UGWUtL5cEi5rbktx3SuH90u0TZewH8I4nnLremWeVfkvVLe8HavmEdwKzqPJtp22Myr5qxRsdoBxG17ozaiZ/WTkAP1qi3t6Zp1fCkI46wr/nPsWsstQjLtk5EjeR5TzaZAnkN/HJWNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495680; c=relaxed/simple;
	bh=XGKzH9s+2q27a9w2p/I1TF7QHbREPEMPONGhf5bDR30=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oMI+vRhOYrquxcEwvAQvGHPeKwNpiuM9v9jo34K3IMoI4y0sH8umguldIFJEV5AsjIb7wXX5ohxhsLzx8er7cfEcVnLuKvBh9UhFJf0xGhxLGdKBp0U5hZNBRyXarcWSEaGU9ye2zoZgzyvS2EDO730FPjEbyxcoonBl5hawhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOQPueHa; arc=none smtp.client-ip=74.125.224.52
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6603d8697d2so6269999d50.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495678; x=1781100478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zxTk+9izXoTQNzySWiMV38Wz1CdNNANMN1wpKE+69g=;
        b=bOQPueHagCodEiXtX/jnqQ1Q2rrPGs/B7KT+8kMTXtXgHKvinSV+b5P9QSBZ/e4nWh
         bm5h+VEzJRMTvv6KXZp2hPSQ7wDT92PtK9+gPWm8qfZE5rb+bg6yk60YL6wueCKsRnsy
         DLeLC26lW6N0dpYi/UtKJVtpr6jgFwzBa8g1SaMb259MOkymSAuuzlIpEFvWO/Ylsosk
         aY7Q4sSq4GOCrph4t3ElHaUVs9B1+iN4Go5LmbG893qUXOtgZSyT5Hqmhk40mxDPB2Pu
         5uSpQ5tZcNtKrW8Pl78UlkLcoWQHK5Rdt2m/25RE76wujwOlh8VEWtM0vSFj8zzS9dC+
         cMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495678; x=1781100478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zxTk+9izXoTQNzySWiMV38Wz1CdNNANMN1wpKE+69g=;
        b=AU+UYJgfRJmEsqlrbFQdl/PWvT8vVDiif5diS3xCrQhhcwPYo+LhNt8nOmP89D+CSR
         fgS0wXwZxPgeKVd+VAqzs9/9tcmzRkREIw8Wi2YHnlu79UteGHHDjuvfnuXNJnmaaKSY
         oWJCe9ybTNAroyPdhSZddfDxvMroIY03rCAWKdO11ZBHB+Yb4thtDF9NValEHDg+eAbU
         mvHCiuRRhm1R3vekIKXRiUY8zuEfR2DCjDRGuIu3oYif3WvJHQp8xDa+6QMUbdkK+77b
         wlVACypyeGHDKd3Z34uA9Jko4BQtoKcXJc4gO7ldZbZxn8QHUTpwH6nnLXMIGzEn5srT
         CK7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/gPOWdAycE/GidJiuMoiuBwAvGthbBJ23iFSXO1YjjO86aWcI2WGDV8fJKI/WKBhoo9GNA/A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmaYe5U3uHy+0Xl+LUwqZPq8LMjwoJEjAvhxS23CdmvTFI642
	yaTnhdUX75DHJiJ4ugT6kFqridzZQ1BNZGk/j2s2iFHzc1+TJBQks9Sj
X-Gm-Gg: Acq92OGo5jfa1KT9az1oDwfGKbjhSd8nA1WYqVWYhH6sdbpNt6TIhMkYtxED26Tvz80
	SUw5cRtOGml7WXoIvvDMHE6z6jhcZ5RQie5R7oxd3rNav6fB29bCVcUuqmiKJnTtBgA1pjmVmsL
	sAAMaYbymOo/upMmLgDiDt3DIzOka7CMBkRoUqb85kPl6Q8RQ78iaD5zkT8YLnHoVRL0hUScVQz
	u1wzCfz2kkGYp/weXkiO0TY6R4/b4OClAy4+lGUf5BMk+v7GADQ9caMAoG73i0nIWhILUsFXwwJ
	XiCTZbhQ6T/AVEUB5SeV62e/P8PcPs2bp5X3wBhuoiWsUPZff8kV0IX15r+cJZ6zyLg7aKwDrzt
	MC7nbnb+qQpahKl96lT8F2M1ZJZFS3AKh9A3Ggtt9nOKsERzyhdMU5AgTTh7qMwjIOfoBife6dJ
	zVmnPAv2srZ77gIHky6515H1Q=
X-Received: by 2002:a05:690e:4812:b0:650:3952:3d3d with SMTP id 956f58d0204a3-660dbfd0026mr1783021d50.44.1780495677652;
        Wed, 03 Jun 2026 07:07:57 -0700 (PDT)
Received: from lgs.. ([118.193.39.24])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d647d3aesm1885466d50.18.2026.06.03.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:07:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: cpsw_new: unregister devlink on port registration failure
Date: Wed,  3 Jun 2026 22:07:42 +0800
Message-ID: <20260603140742.1398659-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294764-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:s-vadapalli@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haokexin@gmail.com,m:alexander.sverdlin@gmail.com,m:aleksandr.loktionov@intel.com,m:daniel.zahka@gmail.com,m:lgs201920130244@gmail.com,m:ilias.apalodimas@linaro.org,m:m-karicheri2@ti.com,m:grygorii.strashko@ti.com,m:linux-omap@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:alexandersverdlin@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,intel.com,linaro.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74ED4638724

cpsw_probe() registers devlink before registering the CPSW ports.

If cpsw_register_ports() fails, the error path only unregisters the
notifiers and then releases the lower level resources. It does not undo
the successful cpsw_register_devlink() call, leaving the devlink instance
and its parameters registered after probe has failed.

Add a devlink cleanup label for the path where devlink registration has
already succeeded, and use it when port registration fails.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 7f42f58a4b03..95b3b58db6e0 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	ret = cpsw_register_ports(cpsw);
 	if (ret)
-		goto clean_unregister_notifiers;
+		goto clean_unregister_devlink;
 
 	dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
 		   &ss_res->start, descs_pool_size,
@@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	return 0;
 
+clean_unregister_devlink:
+	cpsw_unregister_devlink(cpsw);
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_cpts:
-- 
2.43.0


