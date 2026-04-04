Return-Path: <netdev+bounces-275410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zQZcK6KQ0WlfLQcAu9opvQ
	(envelope-from <netdev+bounces-275410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A111339CC0B
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACAE03003BDF
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 22:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8A370D71;
	Sat,  4 Apr 2026 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFXKqzV8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2D175A6E
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775341722; cv=none; b=CQcL6z0+KA0pbuECqSk3OOmlNZnKI2V9vhEE/TBbNNHikoAN+cviRWkTdnYxN6zBDUqXzeEY0udjNF3l70jgMArugU4+qyreybRQCkOio3wiwX2crF7TdwAXBLLP2EbhPGAByZF4OJgpzACQEVcJqH11micndOGl39HyihfyRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775341722; c=relaxed/simple;
	bh=mIJUbIAq175QxljvTviB0dw/i/cUVMNsW6CWFZPk9eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pu250XmY2EB0pdELt855tg6veuwKhbCc1iCtFzkUkdq7NpX+T3+5VNghgSyuyIe6OcmsmE0WgEbs393nbU5utbf0Zxl50zgoGaDPUGX5z+AuX4H2q8pN+0WdlA7GM3mDmFSx2RXxJ972HASVzamS3lSN6PuIBsS/zw3YmsuIPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFXKqzV8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38ddeb0f5abso8517571fa.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775341719; x=1775946519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9hJKuJXkv3L2+g4JNiDLT3ppLeDxzPZOsnHVZphWPs=;
        b=GFXKqzV8UdgDawdJvwnMYrjT3icPRFYHDgm2owfoFN+Pn7c7yqSfckEWDfqEbp1V7h
         53n0acUqwBr0LjDnxB6fuffuOSXOuJrCWQL6IJhm/VUv5qndlDiAl8yg9Gjr4QX+qDai
         g3Lr9/gNr3y6DwkvDMwgKE10rilotpExl/+k6Pgtp0svoG3Y6uVG6wO324d2reXPvaRM
         WjdYYxn6KJi/6hiPhVI+BmTKM0nBPxmuO2jcrx502759aJC0WSBsYKjEKjWzlnlIq2ET
         qx30/tu1IA8QaW8ugC5OU4YP3ERkMMl9oSHrVqW08Q4iX502H04OpOUdNX+gmTrvp8Xt
         ASOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775341719; x=1775946519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9hJKuJXkv3L2+g4JNiDLT3ppLeDxzPZOsnHVZphWPs=;
        b=lXKsMB6OQLR8jUXmQya9Uc9/6zppGdPOEcTWA0aaMQw5j9OapvHYNS8pNcCgSmiPNh
         sKQpvtpISqiiNZhrAbbeiB2JKgoRKTP/l2DrfCcXM/PDQca93djNExO1MUlX29vrOa8+
         oJgrvUUjL1leY3pQXOHrxU6eVYqkvAl6VvzBfxOn4KhY8EmHlR38+RxI1C1cQjBLrE8q
         FVajuG8yazwCE2a1IXN73KdbMRHG6bD1ynxzJ1663x94m5G3pPGZO7d2XFsec+WAuDIz
         f0iLTCLIZi/+5nryhdOxWnNqnZdt/tzOYhBa/uq1aP3IkPzdIVMEkdNdllHIPVNmGvv9
         kXpw==
X-Forwarded-Encrypted: i=1; AJvYcCXAN7WcBSzyzKuFFJYmf4XInc9ho5zNomKnZqOHNZxB23mtV4ipzxE4E3RcgcCe0Gbh5qzK/8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL13iSm1BKgKm9suPdUcAFhFgRtn/QlQPFnklD6iktPgjrmP+J
	66GSbVFwGjeY56IO33gzlPPxhnaRTPLhwSC4S56ERFYuQl5Kwc2TaM5i
X-Gm-Gg: AeBDievN4bVPlgkPFeSHEv53zZd/2sUS4hUR94vi7utYffW8F8aXM0FVVLpj6IP6Qzg
	lRpvHQ+SHmyi0zQY4pHC6JDRLuNFYm4+hm+mroqSmiPiIQYB8t7KCSaGnXIILohgWlA3Ns/COH3
	G41MYRFrq/cHUTOWq78MbyJUjHIR+iD1+mtnBJYgxmBdwH8HL/iwh0ZXVugdgVnrr6rcG7xXR1d
	U7j7nQBFPvCO/JYY3QSnYmenCGvmL799m1S/nw0Ni4yBbCA3VNPC+RnMD5i7zAu6QjlqyF4ApH5
	mazimU/AJcv/HsUQgrORuHFvHtoufxPc9Ze8YvUGcNnjpgOUajjkQoPRq79dOtg6orPNLOsaEqH
	ysk5zMa+tcdeoyO0cbYv/4uCOhp/vxT8eeKzo0xRUDNC0wpS07RAsivEUu7lie3HPwJhNhTWtY2
	ysLdsb4vtWk+ylYN/9FzjHpMZsD6G9bZhcrfSIrDiltN0BmvulR8IPF60cMijxClMxX2Y5X1UMf
	7HT
X-Received: by 2002:a05:651c:3253:b0:38c:125d:73cb with SMTP id 38308e7fff4ca-38d8d36693emr25628381fa.5.1775341719270;
        Sat, 04 Apr 2026 15:28:39 -0700 (PDT)
Received: from T6NXCV08J99224A.localdomain (m90-129-201-111.cust.tele2.se. [90.129.201.111])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd1fa8a79sm20898811fa.1.2026.04.04.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:28:37 -0700 (PDT)
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
Subject: [PATCH net] tg3: Add PowerEdge R740xd to AER quirk list
Date: Sun,  5 Apr 2026 00:28:33 +0200
Message-ID: <20260404222833.936-1-rayfraytech@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-275410-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A111339CC0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PowerEdge R740xd is a variant of the R740 that also triggers
a fatal PCIe AER event during system reboot. Add it to the DMI
list to apply the same workaround.

Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..ae06ed4f0ed7 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18216,6 +18216,12 @@ static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740xd"),
+		},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-- 
2.43.0


