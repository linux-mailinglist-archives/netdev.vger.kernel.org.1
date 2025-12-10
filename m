Return-Path: <netdev+bounces-244185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AFCB1D76
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 04:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B8B3050B85
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFEB296BA9;
	Wed, 10 Dec 2025 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ+HxWrP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BDC224AF1
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338999; cv=none; b=Pb8wX72T8sPSL5MIXq3CL56ZN2KHS0tzCIyFgSqm29Ncb/2eERIYxzcyQ61oBwyrSOiuJwc+B2I9Xrdy+l9uCZF3XD44Tx/EhJpznAv1ZYFjfy+UWG7pSmpTN3Wg56/Nh2TAk54XOoyPJWoivvQcztwcCpG75gy9q2XVY4klzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338999; c=relaxed/simple;
	bh=ZcvXQZ03NY3tQVyf9FVolzv0pdi5L0UaIHLTWMxvAOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXw9OThnKKTWOke4aZYAcPRDWXJ9su9WF9Av0v3PlvjKpaYdQnJErqLaX2rPYQBHyLyiwyZitwS4z8Xhn68tt1igbfibZqWb9A/xg9qfdSWw+heHVgusLjOQIHeLCdzRyb4ABj8hqiNMNWNZsQ5/XRb2tLKvS751FgvjA98KmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ+HxWrP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so6778476b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 19:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765338997; x=1765943797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRFMII5Dz/9KCXvya7mG/+u+ZhRpvPBA4KR1unA9ql0=;
        b=aQ+HxWrPKiKbjJXIVkrN+u9/WgTBn+nt8YyZxWqatmbUw5gffow8waaB3Ehb2QPsO1
         roDY5fO4mtmeXgehPM4WUxTSUD43JI1RXMGBwDQcwr0N3L+flbyVU5lgOh6WbLjIddKp
         7tO0o21sxEsbGUNb1zqx8Z9dhmwPGfJ5JCfQfpzIQBtzJFNhhTgtQYsLgr24E9Jwjs4S
         jkAB27PUwbPOHJ2OkflhR5npHNCJnYQp/20z9GV+LGctzW1KcboJKVkgnvDEWDHqKFp/
         Es+lbrcJLAXo1O12JwE4DlCu49fUwW26KEkQjs9fCBtzkMVqst3EoavoAwm2W85c/SIN
         8lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765338997; x=1765943797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRFMII5Dz/9KCXvya7mG/+u+ZhRpvPBA4KR1unA9ql0=;
        b=m63JtkZawsCl2CCdWS2MkXesLvnL14VfuWZhcNI9zne0A1BZJomY5j+zzejr37VjIb
         uA9dKFKN71/EFJaLlfwEIT7JDJ+xpHn2oe9/7iBunwln0yZT2uKCg89JC62JO0RnmqjD
         JZbPDdFbvgTkN2Ujt4a8IHJKb8E4/+L+xtngGngor0K9Vi9zIOJggd3JItGG1DLgixC5
         HURjugvPlzUIXrAZCmKjHjP74hdq/Gw1oL4QuXh78N/Ojh2p3hYRgibBoqVU/wl1b3O5
         e+fvaBimpkik+Jdq2GqElQkoMm/obUvo0VhH+2GaR29Ico1+h7CM3u7C7oZIl8DP1lUS
         NVAw==
X-Gm-Message-State: AOJu0YxKjZFw/1GmexBHyYEyxSX5uS9LSRveIFI2zB9w7VlQKzLhIM3j
	fX1C6/zXoSGqoZVj0fpuhq4X2T4vAwGul3WpS4kXsb+V8TpK7Dj66Rus
X-Gm-Gg: ASbGncv9TB/kDxv/elCxv6ypUmT8KQ4yHh1U+RbJfMTRZG3u546DFhyGvPgTPsC3DvJ
	e49OIczA4EODeECF4x9DjcfYWMGtSVcs7UhaimKI4+mWhQA+Ov7Q5X0DEUi3yiBGemEvSulRnjp
	sQl/g8Yu9Bf5eS23INiIG8S9ZEpqpyUknfwULSIDdL0ga9n6LRg13AwaHmfzjcZJbo1AexMnLbb
	Uu51KGn2GbeIJ4Wj4cshyMctN/nHRvQlTIioPbVuwIaixMjYlr2ocfcRZTY5JO17C0xeJx2DTwu
	XriOtzrsTXLm51mAX9gKi0geaD2l8gB0qicU/V6CbjiUtJBthSCsnmlrPNZO6D5GBjTPxW1j5ur
	vsPtkTfnnqzgLsGhq/oUjKdW8wMEIbaXs2g7xwjmQdC6R2vIwERTdXF/eGt+Vkjc50vY6Ijnk/+
	V+1ejyvvWiT7sPjpKK2A1iKXYuavLhHnQv
X-Google-Smtp-Source: AGHT+IFLbd3ySLPvNOsKG1hdjG/C+zJcN75ToWN+7s+mbuqxHfX6aRS4wBy/4XzHwRla6lRXmrw5/g==
X-Received: by 2002:a05:6a00:c95:b0:7e8:450c:61c9 with SMTP id d2e1a72fcca58-7f2303b294amr1055997b3a.57.1765338997093;
        Tue, 09 Dec 2025 19:56:37 -0800 (PST)
Received: from localhost.localdomain ([38.134.139.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae03513fsm17408190b3a.43.2025.12.09.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 19:56:36 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dharanitharan725@gmail.com
Subject: [PATCH v3] net: atm: lec: add pre_send validation to avoid uninitialized
Date: Wed, 10 Dec 2025 03:53:55 +0000
Message-ID: <20251210035354.17492-2-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a KMSAN uninitialized-value crash caused by reading
fields from struct atmlec_msg before validating that the skb contains
enough linear data. A malformed short skb can cause lec_arp_update()
and other handlers to access uninitialized memory.

Add a pre_send() validator that ensures the message header and optional
TLVs are fully present. This prevents all lec message types from reading
beyond initialized skb data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Tested-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 net/atm/lec.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..c893781a490a 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -489,8 +489,33 @@ static void lec_atm_close(struct atm_vcc *vcc)
 	module_put(THIS_MODULE);
 }
 
+static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct atmlec_msg *mesg;
+	u32 sizeoftlvs;
+	unsigned int msg_size = sizeof(struct atmlec_msg);
+
+	/* Must contain the base message */
+	if (skb->len < msg_size)
+		return -EINVAL;
+
+   	/* Must have at least msg_size bytes in linear data */
+   	if (!pskb_may_pull(skb, msg_size))
+   		return -EINVAL;
+
+	mesg = (struct atmlec_msg *)skb->data;
+	sizeoftlvs = mesg->sizeoftlvs;
+
+	/* Validate TLVs if present */
+	if (sizeoftlvs && !pskb_may_pull(skb, msg_size + sizeoftlvs))
+       	return -EINVAL;
+
+	return 0;
+}
+
 static const struct atmdev_ops lecdev_ops = {
 	.close = lec_atm_close,
+	.pre_send = lec_atm_pre_send,
 	.send = lec_atm_send
 };
 
-- 
2.43.0


