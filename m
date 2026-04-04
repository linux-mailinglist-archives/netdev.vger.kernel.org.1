Return-Path: <netdev+bounces-275414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pKNGGr2V0WkmLgcAu9opvQ
	(envelope-from <netdev+bounces-275414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8139CC92
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8086300B440
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34463612EF;
	Sat,  4 Apr 2026 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD65SIZc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B67332EC1
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343032; cv=none; b=KJTErNKT69//t8EVHqvA9V5nXLqEDwhMM95PNlBcvgiQjEUeHLQXslyseZo0iAUs5BSTppJGa5/0oHmjnre6h8q2ocnYyQLxsPjc+M6Dr8Gj0j4Pqo9un+8z8g48bMMkcLmP6DVAimAUjN2i437JUvfcNxtQGr5W4ubaEBCQdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343032; c=relaxed/simple;
	bh=CTDSKyMjb4Ul7VAHjrU7o/RaEMj9I2+2BIQfqFtgBQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5Ke8GD9f7VS+RGxslgZL2RNmVV7q6bts5O60uHR5chahRNmAvRSeivIloJa4DkDGsWk3PpKchSwwv0qQmbM8mxe2ZSZo5tmMeGzm/WJlTe9RrNrvtNOdu+os4HzF98rltCxkMXxQa4dY3y3Zn5Z4ZCHjs8Y4xTZ5oM1rpM7F00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD65SIZc; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so3410133e87.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775343030; x=1775947830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9D+3eMPh9Rh9s0cMnffvlj7XMKf6U6CNTrrpvV0+TE=;
        b=MD65SIZcS5NLU+njohJ9gXCUdE6DxSjmRE1krlu6yPgsbzSprL/K9LNWSrp1n3vnZE
         j/QQ9GK64Pm6G4PAwBwbjMTVFGIBeAsHlUlouP0361eiSq+3HDgrw37yW35fF9CvU5Kw
         98nSkS99cwVbKuahohxwjjne5ROthNlbs+S1cI4teORchi0BmKSac4HnGXeyuAQ8wdsW
         izWlSPrPog0aCB/PVhaHwfh7LH9AKhAeZbufAQsk9HrIOfKiGUvx195gbXwQF1tSmbOn
         jAeLrQUTDf3MPkYqbnKPzngs1t/3ZYTXtiGKuqUZ9BZslLsgV0AvwKlwkIKxJsAs67Sr
         RIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775343030; x=1775947830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9D+3eMPh9Rh9s0cMnffvlj7XMKf6U6CNTrrpvV0+TE=;
        b=pVAqlm+oj6lUmJAvY/HLLyS4G++eP+pVdolAZxPyaD0MY23ha6BM0rzvKP8XC9gvLq
         wCFM5r6+GAxddaCz+xoKQiE08LFm/RJENCzuNCEA0cwviS5q1DibI1XYldHqDwg6uLa0
         mFESFWvNDy/tOGas5mKpbFxvABkG/HCns8IFvSobo5+PtnvDbNQKrc6eFJ2y1bmap6u+
         2oA8lBJ4RDu5GyXQrct7Upcrw0JRxXFHtJaX50ymFKNS9VDarkiJbgCPsaHSxAkNsLRd
         O5uyqVQbr0Oid6Ume8Yxr5yHba430wgM2HTY2/aByfLnXPurIPtIuxVObguW5KXbZoLs
         UhFg==
X-Forwarded-Encrypted: i=1; AJvYcCVIA4h99s6PQJ2I/rHjSUYzqAATf20HqGFZdAfQHRgNOD8h+9e0aHdOCkPuX5AmNQA9vmgIRIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+wAIfbkN0tKV4XKbDcbe8Mu+ixwM6cQid0xYNYd2cYkwAXOs
	fw2kvzBogu2zxg0TgOY7s9lnoFEr2iPHRsYGW9/ofrRE4r3RqsJw5pD+
X-Gm-Gg: AeBDievoJX8Caqnr8ZLyysLTHe+kM/3LIT0dTYA7weEA4oBm6YkdRWzXurQFs8w05S/
	KWFOKSN6nZSqQOzZGYPgMkhA/Ofvg0VJxudticvTGTppDm1u6ath5Q12iygjEoWBn6mZcD2+xc1
	rqug/6yDCJijyM6cTxVWrBqFgOtjclwznIA3L7QSUJvPlp7OMgFNf8DQty2NnCDlpQaNKjw7YsR
	95mxr9vv3+gAJWeAHnShOCW7aMNxYuURcxNOJ5DGBHcbaqMyqTlrb4ep6+hIy3hN/a+OBCIlyZX
	i4mGzXZotaWBiApdES2xgRiP0KtiAadOWBdcj03AVBIyVguesacVA5tdlSKGX9CWGYgfo/hEpIQ
	Q6IE5BOgS8pSUcAaAPCmzQNVMCGZvYxpOA7KA5g+g9QgwW3UZnujSs372cUyBgaGO8m1O4K/FTt
	5Cd+l3+IMqRtqHKM6nJt923eQ6PZqZzvnBHT2vAkwYwf66uwQ0XZasKhypgohlgmMj3S8Yvpm6A
	NVh
X-Received: by 2002:a05:6512:1387:b0:5a2:bebd:45b5 with SMTP id 2adb3069b0e04-5a337556025mr2296613e87.4.1775343029281;
        Sat, 04 Apr 2026 15:50:29 -0700 (PDT)
Received: from T6NXCV08J99224A.localdomain (m90-129-201-111.cust.tele2.se. [90.129.201.111])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c951b1sm2412023e87.6.2026.04.04.15.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:50:27 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: pavan.chebbi@broadcom.com
Cc: mchan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lszubowi@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH net v2] tg3: Add PowerEdge R740xd to AER quirk list
Date: Sun,  5 Apr 2026 00:50:23 +0200
Message-ID: <20260404225023.1254-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-275414-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2F8139CC92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PowerEdge R740xd is a variant of the R740 that also triggers
a fatal PCIe AER event during system reboot. Add it to the DMI
list to apply the same workaround.

Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
v2: Also add "R740XD vSAN Ready Node" DMI name as reported in
    bugzilla #221279 by Thomas Berger
v1: Add "PowerEdge R740xd" DMI name

 drivers/net/ethernet/broadcom/tg3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..2b95c97e8161 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18216,6 +18216,18 @@ static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740xd"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "R740XD vSAN Ready Node"),
+		},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-- 
2.43.0


