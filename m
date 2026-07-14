Return-Path: <netdev+bounces-307385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pv4NKR3wVWq3wQAAu9opvQ
	(envelope-from <netdev+bounces-307385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634275242B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ayz49cLB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307385-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307385-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3CE030BEFFB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501A3F822A;
	Tue, 14 Jul 2026 08:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC13F788D
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 08:10:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016635; cv=none; b=pG0xIXvVeQDQfAJ65O51FYFX6jY0Fu36y6G+OOitlHedtw7rXa4mxr/2ywJfdXOLIAyxLOgAV+H1fI5uYakqUMSEMEnr8Ay9EdGSAv6dT0o7qTF9ITBQ9nhSTBiYoCGJB+a8BfWlofl1eubWOMSpjqenGF4nTmVqSp/zfiNcGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016635; c=relaxed/simple;
	bh=91ABqFKfMNp3kIwQItRGSHlNzSqgksOirpnlbA6UxGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i6oO5dMf0l9LjEdbCVhw0UUvW5UioQuuBGP+Eo1hbEk3y3gn3reQqENJYOh+FkgPtOBPz0+fn7kISFBErkkSN1Neii1/3AlWVXzoBiKB9MYkpXNA+7CYq1A8ienGg1g8zokuql/KW/UsarjGSKwC+0vOacCHg2UtXiAhMea/ZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayz49cLB; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so35753025ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784016633; x=1784621433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITeUKgVbKGB0qKOAiMSNRRSqKKCe5wLy1hv+dNfJzS0=;
        b=Ayz49cLBdh1LuWGu2Kbs6myTb5liZ3oXF+wA3seEUZeo9hXUTC1LUz8fPYnaujPZSa
         uIy61fLHXME7+vL94wNAUTVzeWuSMyja1pGzfS1jetL8KsQX/dYP3ii4e3E4BViMUeQj
         LIN5I04hPzlkk3KVYeymomRVMPdQ/xd/TNIJ8nG1amTBRb8o72jH3WTf3QZ5903PQdm/
         F2kfTOcgw5WjisBh3FTqmEMrRB5OTUcDU/fMePTI8+c/CpHhkZ1/qKVyU3Exw1yVXsGN
         OrLsfJfyPZk6C1bRd+L2QCox5yWFrsyq1ToNvXN6Xa0tI9/9gb5aKRxkt2WK0HxRZDeX
         fkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016633; x=1784621433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITeUKgVbKGB0qKOAiMSNRRSqKKCe5wLy1hv+dNfJzS0=;
        b=mVBgvo8Yj+YWolnYFsU38+pZhTiS5qRDAuMGuS6hhomPMR7LRPtPgd5sgIe2wPRRjR
         oNGwBYDzmDRcnXxf7y9IZxRx0h2HNuPEsHe8E9nS3rXRr1NQobNLuQ3Atikuo34pNxZx
         RjuBv+2O+aheZnIpa4u7RXP/gxoZJadAXAoEtH1K9Q3L2UOlDjbqMzVDChDlR2LP9Jgs
         Fn68fTCTC7OBS4b7Qfwo2HNu1vuyeokR/c4MjnQTvHgQJ2hj3apvDzPmSYp9cbbgezTZ
         jSk8gjj4Nyhp0V/Ebw+icL4RuSBW4E0cq3LLZYxhjTBuTuUDF2JVXD0EQ9nZAvsJ4DFU
         uJtA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5saTC1+MPqH/XJFG5ZCJzsS/gF1ZQWhw3S19J+uet18Y12gMwLRP9Jp9oQa6rjuK9f1o3bOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRj7lOSjUVuYIxlmzdERtZJv1zBbzhpjiZG5HzBriHgwFS/xgs
	g2KlfSDIJLeVP1dRedD0XiiIn3UwA0CoVzDaHHed8y6LikxvluI9CmY=
X-Gm-Gg: AfdE7cnAlY6RN0FbZv8gzGkA0eQyz+8wDAPjePmHdCmJKbL6hFN30opspFBT8f1Au1S
	PQEqIrwZcyNRRNJkvV1VXT1dI0lrDyF5GUKznZapUrm3bzJVnHCHZWP/CB+x5c9QAPJBMecNeBv
	m5F8mtD+aqJb3+WSS5uXmrzz8e6WiWsr+pBLvMGulab41DdIoPveoOZuM2w4jN2BukD2LV34Hy9
	rhj6RgS9plgHFfluYHUpBaxtuIAGvWUR2Nxx6utt+Xq2XIkzxFVMXUJD8Tbw9TQcukfPbw7LvQZ
	XlwRWH8IgXAiwfzOhOlBelJoAgz8dyYCoa/VKce1wCHt+UHvTij4U3H0P0JUryTBJIdsYEWgRjy
	K6DmrBiYfQO7icHEASdCJoyKosKUmqmFURLe8gwGm3G9P2qc6YnKPGa/hpWGWy/06NbHbsn4sqC
	VdihNh2HwCUIcjr6GxVJgM1m16tHiCr/Y2p+bEKD1kT6R00zlQArGqQ3X/H6voQKjTIZkuLHlXt
	FC1mJEKVS2NCsfJEAszOzqe99SXMvJHxcKNCnP1KAKHIpJWDA==
X-Received: by 2002:a17:903:b07:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2cef1372613mr16919425ad.47.1784016632632;
        Tue, 14 Jul 2026 01:10:32 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d968sm110856755ad.60.2026.07.14.01.10.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 01:10:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: mctp i3c: clean up notifier and buses if driver register fails
Date: Tue, 14 Jul 2026 17:10:25 +0900
Message-Id: <20260714081025.89163-1-mhun512@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307385-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1634275242B

mctp_i3c_mod_init() registers the I3C bus notifier and then walks the
existing buses with i3c_for_each_bus_locked(mctp_i3c_bus_add_new, NULL)
before registering the I3C device driver.  If i3c_driver_register()
fails, the function returns the error directly, leaving the notifier
registered and every mctp_i3c_bus object created for the existing buses
allocated.  The notifier is left pointing into the module that failed to
load and the bus list is leaked.

Mirror the module exit path on this failure: unregister the notifier and
tear down the buses that were added before returning the error.

Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/mctp/mctp-i3c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 6d2bbae747..677e77e917 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -740,9 +740,14 @@ static __init int mctp_i3c_mod_init(void)

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

