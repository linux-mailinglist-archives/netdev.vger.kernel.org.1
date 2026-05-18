Return-Path: <netdev+bounces-289073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIbTIzgVC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83456DB02
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B8F13016D31
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B950481A93;
	Mon, 18 May 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="K9ypW/vP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE586DCE1
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111203; cv=none; b=MM/ELcG/6pEmOBZqydFbaZVjYZKVKIZyQNr+ytRDS/72JARIwCznk2GXK/LCFpAKhopxNaKAh+JteGmE2fOAu71Cvfc/ctxGby00FesokexHvhhlAhduEcKBvawY16+NGDBy1CH4DWlLXxKOXbyx0z01+iqWYZTMqJYgPqpEGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111203; c=relaxed/simple;
	bh=q+NL498EPwlLrfBIQdB3BECdx05b64cjxCXzpG0xTJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWNN5KGUTWae51j70FTXa5REQnFLGZl1+gvAlWcpFMdIGyFyzdE+qeLgIy0Y8mIZo90JnvqDMtFh9i8wwzpv2GsMcb+FQ40+xGe8B2OQ/5j0L1BnMUfxUJNU5jwseCRO/OTt2ugjKTV39mU0pvFoueRZvUkrXTpkfTsNOB6md1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=K9ypW/vP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44509921fbcso1332401f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779111198; x=1779715998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwVMqQgkml/57c5J8ItJqxnkkdNf36+YjPY4g30oVbw=;
        b=K9ypW/vPEm9WqgHZl5wgy2AW2uUV4yXgFdMLe9heFd970EZZXnrrSMnNj+wRJYifbM
         8glk9iOKdEsfCWo6DcTo0GUf6TRBJ9KTLkCnoEOsW3z1JXUSPuqRjuP254HXJG2XMW09
         S50BfKTO61KnpUfVJoYIPM8Sv0aVrll9JlWbVH+u4CgFxYfD6edSA5UNITczMs9rbUGN
         X12VDZfoAnRMt1eCHm+40w+Z3dx+uaBuI3R0wbtx5ezRuC8OupJKhnpywQ7jVakXjlXK
         Tjl9k7NS9Zm21rVm5QE7aKoBQXIiazayCRVGYWCZj65T+kXI2SlHmsKl2LA2RIgcyte+
         8vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111198; x=1779715998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwVMqQgkml/57c5J8ItJqxnkkdNf36+YjPY4g30oVbw=;
        b=ec8ANQj+QPeItrrnmyRWEOG8DqofrjiTB8MxOkxgey5BBcLIQj7RZtGFl+p+ONJ16m
         yz7zxhScwL0R4RKIz/dYQAuXR615ZgkwtO79SEZVJM2QcYT0A9BqNumOdM56fkcBOiY2
         tO+2pZG5ylwjP7eoSWVhfJEmdNAUYsC92xplFnx3kc9WtZGIwPORge4laZf9Va0xwOev
         hSEUyGK/fIheyWjrjnxxsR7g/gPCEjGWCbXLP/61zA+o8TNilkWI3S+ZyW4PCZ5aVaHW
         tQg6MkaPIbHhls9XsipWKPdEzRyB6j8RoT+nRAXH8mRCXuLoNc7jttNPHUfchVnHf8+A
         lGjw==
X-Gm-Message-State: AOJu0YzEZpde3IDjoO5EPYgcDKe/g4Son/u0AlFJbvCFhJbaNWOPQn5v
	Ukm5Az3R0I+3hgDhDQYWhUwqx3n8tOTrtz6zDciJiE5Xnu3P8D0akuHUe17RSWdStZlLUrlTqNj
	SeM3M
X-Gm-Gg: Acq92OFl3ux0JuJH6seNy6JHgrYGgrBHpFt/fHLE9fDY8uBHZQuZ9MPibfKfolq0DsN
	ocRsUdFbff7kKK535cq6tSO95o/1H+cV+JGakvQmw3oR0bQFjx8lnp/fV/UUdGMZxRf/iuVmq6O
	evuLJ7Ti305E4zupq/nXn68VdXQQMTyE6o7HE8qc/2fj8A4mbh9ew0f7ujq+c8YVChCgW0RrKWf
	iSTT27k8H07HfVY7SR2u5z7pndPm5c94Qof80wTDFpaMHpD5tZ6i6Hy9La86+LKCSw3kgJgt104
	y7psiaEuGnvJa8CFb+1lwNQT0X9bfMWP9Wt5Y4jWV0ZqyYci5aTJAXOL/YVUi/9mIjsGZRCjBIk
	vIOAhc4OLwqXN30wJNBXAAYS3GQDvBPVTaVi2YL6B9uiFWoZBqZ5ANoax2oxli6a9vsFayIkknh
	u/afSLPhzw53vtZSgYeECC0zu8vXG5Q0Jo88iybcOGPw9gC3Se8j4I4jHw9d40UkD8529vpQqHf
	dB6XByd7f1a9w==
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr214543795e9.10.1779111197564;
        Mon, 18 May 2026 06:33:17 -0700 (PDT)
Received: from localhost (p200300f65f47db04e77777300859e43d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e777:7730:859:e43d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe537c788sm243844645e9.12.2026.05.18.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:33:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Carl Lee <carl.lee@amd.com>,
	Tomasz Unger <tomasz.unger@yahoo.pl>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] nfc: Use named initializers for struct i2c_device_id
Date: Mon, 18 May 2026 15:33:11 +0200
Message-ID: <20260518133311.644160-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5358; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=q+NL498EPwlLrfBIQdB3BECdx05b64cjxCXzpG0xTJ0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCxUXThEW6Nq13Oz81FfCrtatidoB3q7GafQ65 dmkO2+lBbKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagsVFwAKCRCPgPtYfRL+ TqsiB/0XWNdPHkDty7XNjYW9I9f5kgKbFADXrVc3AqBxY4nfHJkTfPVX5o+CQEJ+NfEmvfNWvHl A0/Zx5xQvJmJmSuUgviIT0/4p2QbOh2MMARHD2dflqWmjEbdaObReOp2AiXx1ZZno4TcWuq3/Bs cQKq59gTy5CwtGmz+DYEwStMmOW3FdXAH8dGU7dfyz88KRLZgSgdPj47P0dIvvuSGWfT1ZZ7i2d RJVDDGam3ovd4yNKjrLnaWLEZY6L+hzu9mccMFJLLb4d7fvtT7AYuGhsAFg4mrE30iLTMmmRQSt PfRJemSMacCnxWEVZ0Z7OwuHEgFPFyGvmG2+b5wU1VzKbqpD
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A83456DB02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289073-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gehealthcare.com,amd.com,yahoo.pl,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:email,baylibre.com:mid]
X-Rspamd-Action: no action

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

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

According to MAINTAINERS the nfc subsystem is orphaned, so I hope
someone feels responsible to pick up this patch.

Best regards
Uwe

 drivers/nfc/microread/i2c.c | 2 +-
 drivers/nfc/nfcmrvl/i2c.c   | 4 ++--
 drivers/nfc/nxp-nci/i2c.c   | 4 ++--
 drivers/nfc/pn533/i2c.c     | 4 ++--
 drivers/nfc/pn544/i2c.c     | 4 ++--
 drivers/nfc/s3fwrn5/i2c.c   | 4 ++--
 drivers/nfc/st-nci/i2c.c    | 4 ++--
 drivers/nfc/st21nfca/i2c.c  | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index f00cff7f9693..f45e883b8730 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -276,7 +276,7 @@ static void microread_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id microread_i2c_id[] = {
-	{ MICROREAD_I2C_DRIVER_NAME },
+	{ .name = MICROREAD_I2C_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, microread_i2c_id);
diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 39ecf2aeda80..66877a7d03f2 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -252,8 +252,8 @@ static const struct of_device_id of_nfcmrvl_i2c_match[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, of_nfcmrvl_i2c_match);
 
 static const struct i2c_device_id nfcmrvl_i2c_id_table[] = {
-	{ "nfcmrvl_i2c" },
-	{}
+	{ .name = "nfcmrvl_i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nfcmrvl_i2c_id_table);
 
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index b3d34433bd14..19b019e3557f 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -322,8 +322,8 @@ static void nxp_nci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id nxp_nci_i2c_id_table[] = {
-	{ "nxp-nci_i2c" },
-	{}
+	{ .name = "nxp-nci_i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nxp_nci_i2c_id_table);
 
diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 132c050a365d..94aca9119f0f 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -249,8 +249,8 @@ static const struct of_device_id of_pn533_i2c_match[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, of_pn533_i2c_match);
 
 static const struct i2c_device_id pn533_i2c_id_table[] = {
-	{ PN533_I2C_DRIVER_NAME },
-	{}
+	{ .name = PN533_I2C_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pn533_i2c_id_table);
 
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index b31b5bef7187..dcfa96bd4345 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -44,8 +44,8 @@
 					 PN544_HCI_I2C_LLC_MAX_PAYLOAD)
 
 static const struct i2c_device_id pn544_hci_i2c_id_table[] = {
-	{ "pn544" },
-	{}
+	{ .name = "pn544" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, pn544_hci_i2c_id_table);
diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 91b8d1445efd..e9a34d27a369 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -205,8 +205,8 @@ static void s3fwrn5_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
-	{ S3FWRN5_I2C_DRIVER_NAME },
-	{}
+	{ .name = S3FWRN5_I2C_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
 
diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index 416770adbeba..9ae839a6f5cc 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -257,8 +257,8 @@ static void st_nci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id st_nci_i2c_id_table[] = {
-	{ ST_NCI_DRIVER_NAME },
-	{}
+	{ .name = ST_NCI_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_nci_i2c_id_table);
 
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 6d7861383806..aa5f4922b6b0 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -572,8 +572,8 @@ static void st21nfca_hci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id st21nfca_hci_i2c_id_table[] = {
-	{ ST21NFCA_HCI_DRIVER_NAME },
-	{}
+	{ .name = ST21NFCA_HCI_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st21nfca_hci_i2c_id_table);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


