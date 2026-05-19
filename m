Return-Path: <netdev+bounces-289487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLsSMGl6DGoSiQUAu9opvQ
	(envelope-from <netdev+bounces-289487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FA580FE6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF0B3305CBBE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4391331A63;
	Tue, 19 May 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mXEAS/Qg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053B32F770
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202656; cv=none; b=hxltJi71ya6GDEl8D/Llbapb1ZHb4lE8kPyTNXg4BPtYv1iMf5cCcmPM6kB64QmDazR2SoUajS7ku1dT4aDHXLKindR7VmH585ZNuQlnXEi8lhqXr3ufHXcUIZO9zidmixg5Ep4VIfu4/lJg4OCLHVDQ0+bxM8HctnYV341MR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202656; c=relaxed/simple;
	bh=VOhlzXfyt3NtRjBedWxUVVcU4/zvcJ6BACjBWb8Qj/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5gEh41re49Fj8is+Ju6LkfPmL08WmL8HBBGuziJeoCOaF8fdWMbg0sAIgwLrl0NBXpTxqf1UlSdb6E+iUZYI7swUfOytR832etOpqp7knHLsOhMRsVRtHF2jwcD+dpthlO6HAM2UaXDXrHP00BTdLn1SubG3wP6Cqm6AFLS2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mXEAS/Qg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2305596f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779202648; x=1779807448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EBNNkzON228R0nJzW9A2JcF5uDKXntrK0Ded3+FE8Q=;
        b=mXEAS/QgsHzXaWgRSPY2Kcr9AuKg6/tpcrVbtxjp0HjDYXbzmgXXN4vPVhWnvOfP14
         sQxDeplemWgq+7CGb7NpHE36wBK6jjccH+T0A23j1SovY0tumIl7dsKUwwMBKtwa5rmt
         luktc8yqXtdS1hpApRUAKpjsuKcz1vI8PWXnclVeLhDlLxuDKxiW+JQQBcrV0nYVo8uS
         f0nQSgL0H3Wd7+jXkGaK8bUPaS408ZETcX08dSWnhp5Tw+mdwkNNP0yW0Adgp+MQubgj
         VBMc2QHsveznRYL7fWnSts6cS3U68PHuxB0AB/J+IlbMMGwrui9J7nvq1aY4a28HpO/G
         7H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202648; x=1779807448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EBNNkzON228R0nJzW9A2JcF5uDKXntrK0Ded3+FE8Q=;
        b=BPyIQNOWkz2sT8NRp7HT3HTo8gVdQ1sM3VUZxJK3r3ig8FaXgs9CQjoNierfUm1MvT
         zfomq/h3hiFlPHTaRVLWjpqWG/i/qpRQsWtRjFfVCmMWB2GoHeCoVJ2nQzLD55MiLvA+
         YRe0fDKyiumaBbIqL3wFBOpvBjJQNY2BNyRu7RRgAVBLTBXrUIWtLAgEHmLTS2RR7qO1
         0TSNBP6RKIlSifpBWAitnvGl6lv42NILozQu/6wuguv7RwgRIuu6Yqe9qFZEFvVVQABn
         HKUAPlileQyL/+0e+4P7WIkzO5weXJQYycAAqfsvvwwhA04EpYTJJ7jWw4rSE6U7WH3z
         G9+A==
X-Forwarded-Encrypted: i=1; AFNElJ+qqBy43+DiRgIg1OKQNDIF1LUYsGxpbDcbw2eVgkjS3MUa/R+obmkyStUMIkQpvObbYI0PTwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrex3/eXZoDbuZLsIf7kAhygi5sQEf9rGZwrm1TJYWhHTjHOP
	4K1d8nQsb7XMT6qTqsvwuvDFWd+zpJqESoBzhzcyoCtJK6/4/M3THGmTSh+7Bo1Eb4A=
X-Gm-Gg: Acq92OHyd00mGbZWyEbD0ua661KLanMbEe5ABl+zej6rodeg/VHOV+96PPEPnu+LfCY
	D1jNg4BytAF7XEeW2AkcWGD0jg6/T+sPCLcYddgB8I+/UCTtOwl5jayAgFfRCQ/2h2k2c4rFm6T
	xTAMpFjdGzEAyIqsO7haBvSRXTnhP5cI5QHn2lv3nMRCIYQROn0iiDshqVEE7HLpr3JuReeiYxK
	q0AIerXgNjEr6xyz9j+EtGamoWuEWPjQEvweXBEKxcLNMqsthvcpegsSApRVCTBtQ33/huxMazn
	tErqG/iP47jQx97aXiJAk+cKwJqmq5ZXei+V236ueo4cZzGMHDgc6GEm5s2vbQKe+4aOd3A6NrG
	35pHI5uXIJWvrTNFVZZI0ieKa6UQNMINQXA7E1DYY/PJi5pBwPcFzbT68vfbDTkCCEb/DlYH+KW
	NV9f6OGAhcFb2/XQkpPzRO0EktpkAJKWIaWDoHHzU7GERCmTtgnhVeIU0YVz3CWnN4y4DSf3Zqo
	3YcotVuIXQVzyg=
X-Received: by 2002:a05:6000:178b:b0:451:bee9:17c8 with SMTP id ffacd0b85a97d-45e5c57d3c0mr33606706f8f.6.1779202648017;
        Tue, 19 May 2026 07:57:28 -0700 (PDT)
Received: from localhost (p200300f65f47db048a8dfcf61053817f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8a8d:fcf6:1053:817f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a17ec2sm43287636f8f.24.2026.05.19.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:57:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 net-next] net: dsa: Use named initializers for struct i2c_device_id
Date: Tue, 19 May 2026 16:57:22 +0200
Message-ID: <20260519145722.1590298-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=VOhlzXfyt3NtRjBedWxUVVcU4/zvcJ6BACjBWb8Qj/Y=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiyequA/G0pOmrKecfz2ViPUt1Ou9/srDslyEe60xVKdS Wt/NMV0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARaUf2f3aJFfPN4rlVG2P/ J+e5x718daHFgqMqZ+eLIGvj4LgPBVV6Le6vFMWqLqlFxnwNf57/Su2nnFs+u9/nRPFwtfT7DQu axAqOhT294c8wPfFG+t/dRW41MT+us4Xu3p4h92GnowX/FOdl8tcypG2/pPcyV3hNbGPkXTAhW+ ZWo7/L7iXtO+rcY7jnci75m3t2VnX49JgkxV1TUz9s5a5aZM1+S/xc45qiaOZf1bb8DPMet068+ ETRrNz5yaqvf21Doiatq0yWF5zRMEXo2APTyI0qqwOaoxclcAjvT4rq6Qgpj9kfVFdorWO0zlde VvLejrjJm86b3L+hmdP9RV+XcfvzH11aCta+59L69QA=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289487-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 414FA580FE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

While touching these arrays, unify usage of whitespace in the list
terminator.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

Please tell me if I should split per driver.

Best regards
Uwe
---
 drivers/net/dsa/lan9303_i2c.c           | 2 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c | 4 ++--
 drivers/net/dsa/xrs700x/xrs700x_i2c.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lan9303_i2c.c b/drivers/net/dsa/lan9303_i2c.c
index c62d27cdc117..3a09f3907f44 100644
--- a/drivers/net/dsa/lan9303_i2c.c
+++ b/drivers/net/dsa/lan9303_i2c.c
@@ -89,7 +89,7 @@ static void lan9303_i2c_shutdown(struct i2c_client *client)
 /*-------------------------------------------------------------------------*/
 
 static const struct i2c_device_id lan9303_i2c_id[] = {
-	{ "lan9303" },
+	{ .name = "lan9303" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, lan9303_i2c_id);
diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index a2beb27459f1..6940608a65c3 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -80,8 +80,8 @@ static void ksz9477_i2c_shutdown(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ksz9477_i2c_id[] = {
-	{ "ksz9477-switch" },
-	{}
+	{ .name = "ksz9477-switch" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ksz9477_i2c_id);
diff --git a/drivers/net/dsa/xrs700x/xrs700x_i2c.c b/drivers/net/dsa/xrs700x/xrs700x_i2c.c
index 9b731dea78c1..e6a7839c4a04 100644
--- a/drivers/net/dsa/xrs700x/xrs700x_i2c.c
+++ b/drivers/net/dsa/xrs700x/xrs700x_i2c.c
@@ -127,8 +127,8 @@ static void xrs700x_i2c_shutdown(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id xrs700x_i2c_id[] = {
-	{ "xrs700x-switch" },
-	{}
+	{ .name = "xrs700x-switch" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, xrs700x_i2c_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


