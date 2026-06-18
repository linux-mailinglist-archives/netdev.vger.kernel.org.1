Return-Path: <netdev+bounces-300393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /EWfNerFM2paGAYAu9opvQ
	(envelope-from <netdev+bounces-300393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BD69F35D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:18:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=ZdPgfVt1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300393-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7EF308A5EB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98823EBF3B;
	Thu, 18 Jun 2026 10:15:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF543EC2F8
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:15:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777720; cv=none; b=YetgL21CHOAzpFlEj795dvwpTWEpL1Qm99VsHpmuhhm9rg7qBhJ5OU3B7h+CMYxYT1K79uEoFpAocXet+RQ5EYj8frEGZ6V2NDTNAFeY9+q2a4rbW3pAL68Po9oXTOZAvPjYN6h/ZWh38dcttEcD2Io35zKSEbbH5PmQMreip78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777720; c=relaxed/simple;
	bh=BWcvhUW+0cc5VX+GP36rvT15yne5n9RmucB5Uo/uotk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJb/5loL1o8xDyW8m+l11Agr5Ze9zkFsxNgDfBAwL35JY4jKnai/0lLpDdNZOmXewqSnbquYADGF/Au2lEy0SEkfjICO0/i4x3b4JEzvXphDxvc+UFZFxHP7U89uVjMXNFRGqshFbryE7HRZQbz+I2Y6P61d89tgGacE+MiQAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZdPgfVt1; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef29c5561so460370f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781777711; x=1782382511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxcIh58Ro8lbA8Z7AdmochDFxerQSeNXvjZHG1Ej2DE=;
        b=ZdPgfVt1kE2ZaVtU53o5akgU1DgCVRjXIqbxbOeb+SnN93Py2j33xiKcOoVcScw1+m
         87N1V1EZZssn003Nl2bB18c2cN6pK3zl5XytXdYYRP0DDtcB6qAoD7z0mWFZkI4o8mFs
         tVqiq88H7/cgkF/6hZLOjLG4ZRHivrX7UrQsqKDooZDjxw3t4ao4d/cSyQjZgZ/SeyH0
         N991mE41o+0YdxHFrQXyejnnnuJvu3xt/0gFMNkNdsXQDF4yiIgM2ZxIVWa2zwFLu6r0
         Vhrb3B4prX6ofs0lRvlVjYIgNsat84T3wWUhKZHi8r8NoCl61rH/HmlNok/RwvkSNdqm
         Fh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777711; x=1782382511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OxcIh58Ro8lbA8Z7AdmochDFxerQSeNXvjZHG1Ej2DE=;
        b=aBnUcLl9X7yhL+kVCkBO+Egy+QbqQQBYohKIHHqMTi6XOJ2MHBtRRyxLdrI5fS1elt
         mgStTw7OxjgoQ/BVvLzSjTMBX31dfI68Wc7yVjRt+jJ9oiWzeUrjPjOdFUBOb52hWGir
         22bpA6L4N6lmPyXZZ+mobr7YcpHYi5OAfQsS9C75qgva1MODDm/iLkHbDiOqw+m45OBS
         m33OAdtxpwLU+gBtK1MWgkWS4y5qx+5/NhkYZEXImiD0qK3/ziRw9U8EE9+mJOs4lYrK
         WrmS0gsUGPRt2t2q/U95KT/VeQlH4FiDc/1Vi5pY+CdjmdgaExBLLL3TZeWbJ/aZ5Aoo
         4HpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IpJV2olfUegWsjxJtEU+vewNgNfE6TLvjtTO00o7WS/5fMUDiYpC0Dsz6LzWYXMnYZNVQdD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHccNY2UsNXNVLRjGCA9oFNPmbBmGUMhfdb4Nc9+SrgKxQ4Ssh
	iBvJ79CfqC1dcGgo6ZQREEPur1/cxHKCKSijuniSelxmRRYCw5rRBZs57BzeTEyJoWY=
X-Gm-Gg: AfdE7cmaM3OPg+AmQp7Vm1cu5FsdUQjPwK7cp7bwuvy81J3eFVvdWc67PxYRCpCXjyR
	Z1FFX1lNfN3GfpXmvcFv8fT2KS3AarP0fp8xyaa17De27xO41Hp5NAGvEMR3wYGN8DtmBxFj2L7
	j8N2zp+iw7XdxPs7QuWEI6l++/lpkwHnX9K/WoqEZ8kcyYr6preW6X1fbuq6ieIhIEzL5f9JQvz
	XcIeE0WX3mPM1sBKF7uYWSkXCKkpTTYKs24tYcSeLi2doEdOWl/7eyC+zMFDUNSk930qBb3lXvO
	flXdZfGaDJ+HBXFpeZg+wodjnYmbr/q/QmEFw5cr8NIvKN6U/nEm2Nr0kH4V/6lksWNGLIIOrRv
	ZOB36Tizirbca/nTA8HeJFuFOOn4FyY6RJWovmBcPZPjeylCKE+WxP2kOzKf7R4YHtVWhlWhu0g
	m6tCJCONaEDz9U8Z3+mTQKQYU89R2IXDs2dL7GWmHVQoPfDVLiRCoLcNAtxqU7TOM2PlcZzBwGm
	iTD
X-Received: by 2002:a05:6000:2087:b0:460:70ff:fe14 with SMTP id ffacd0b85a97d-463adc9236bmr4887039f8f.42.1781777711239;
        Thu, 18 Jun 2026 03:15:11 -0700 (PDT)
Received: from localhost (p200300f65f47db048595530b320b6c5c.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8595:530b:320b:6c5c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-462236047c8sm17760805f8f.10.2026.06.18.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:15:10 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 3/3] thunderbold: Drop comma after device id array terminator
Date: Thu, 18 Jun 2026 12:14:52 +0200
Message-ID:  <329e2c612b360a01524df7630a8a3acc34a90940.1781776904.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
References: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=BWcvhUW+0cc5VX+GP36rvT15yne5n9RmucB5Uo/uotk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqM8UiytK7hE/SMYGmvn17tEkYw4JJmFqOZ+FZ2 TZ5qPoMm06JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajPFIgAKCRCPgPtYfRL+ TraLB/sEasozUm4YNFh+0ZWpXwFBATBMd6XdLIle165DLme+RkDZn/OSuY3SXYYspOq5PRZZZG7 8EZ7zdpJEdeE6YEYt9Ls5VYG0W1bkqC6ROoie7T75DTFHG6jQZEsH4YKUQ3EIF+zmDfDCVJDKTo ieJ2dKxNrkKgN15TInMfAm60gKjeBc+Zz+Xgjjlh3ldDmeoT9FrBjPW4PPKdzqrPKRgqlXITzcP xFaQUNIaEsHT2dIoCrnNxJL5helTWll5KCzqsQoMa8h9Wi/zVHyZK8AcfKpok02gDFAuv0mnSNA wsnSRoi/lBFIIzrIJ6bsIpUdI7gF6AVbGB7evuFsBnAq99QG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andreas.noever@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andreasnoever@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:dkim,baylibre.com:email,baylibre.com:mid,baylibre.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A4BD69F35D

The usual style for other device id arrays doesn't have a comma after
the initializer.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/thunderbolt/main.c | 2 +-
 drivers/thunderbolt/dma_test.c | 2 +-
 drivers/thunderbolt/stream.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index edfcfc41a316..c1003e06a8bd 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1455,7 +1455,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tbnet_pm_ops, tbnet_suspend, tbnet_resume);
 
 static const struct tb_service_id tbnet_ids[] = {
 	{ TB_SERVICE("network", 1) },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(tbsvc, tbnet_ids);
 
diff --git a/drivers/thunderbolt/dma_test.c b/drivers/thunderbolt/dma_test.c
index 63e6bbf00e12..519c67678b08 100644
--- a/drivers/thunderbolt/dma_test.c
+++ b/drivers/thunderbolt/dma_test.c
@@ -689,7 +689,7 @@ static const struct dev_pm_ops dma_test_pm_ops = {
 
 static const struct tb_service_id dma_test_ids[] = {
 	{ TB_SERVICE("dma_test", 1) },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(tbsvc, dma_test_ids);
 
diff --git a/drivers/thunderbolt/stream.c b/drivers/thunderbolt/stream.c
index b28e4e95b422..68d81958262e 100644
--- a/drivers/thunderbolt/stream.c
+++ b/drivers/thunderbolt/stream.c
@@ -1630,7 +1630,7 @@ static const struct dev_pm_ops tbstream_pm_ops = {
 
 static const struct tb_service_id tbstream_ids[] = {
 	{ TB_SERVICE("stream", 1) },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(tbsvc, tbstream_ids);
 
-- 
2.47.3


