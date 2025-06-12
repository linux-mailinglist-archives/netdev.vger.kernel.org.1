Return-Path: <netdev+bounces-197009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE8AD754C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B23AA9BE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8426E719;
	Thu, 12 Jun 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEqEPkg2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50E27AC21
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740917; cv=none; b=rxh/5rg5zptas/kY+tTPcyfgT6I/fsGF2z/OGa4EqJhEkPlOaez7kcY7ONsqLRvaXKXlIjrjJowGZVtcEcu+v/gnpWWbyLpcnV0vTgiL7YCyUWp8QbQx6qvzuYIMvDpwlLwTWKsTNckjvDSTa2CG/CJFNjUAhTimXF5A/8G7/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740917; c=relaxed/simple;
	bh=iwHqeSdllR+93d/aKKDDL1cVggfs/AFG+oVmB5zp6I4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qH8M7+88Nfdsmf5DrdXvm+yH/wVCnHqz1Ia3OlpTVKXzz9I+lhnElTKSRVjaFwObu495yiJpkmALTqIexU3W9/dy1r1ov6lER653jcLKVGSJNSqsaxO7jz5BP96LU17J4QOSSlvp0zyTwyQGiPMRtkC6wjeJ7gws5q/+AEB5bKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEqEPkg2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2360ff7ac1bso8412065ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740915; x=1750345715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7f9euiYwFjDamxwvZ38IMZUhr0NY/vKeiY61rwZXar4=;
        b=eEqEPkg2Hkchi338/V8Dp+6huqLToNnI3mQIl/9QRyIU2Vz/rcfy/uhFGE/HfVNT0s
         z4faBhitYmKjPQrKX+XKOa9bj/Ckq3VgAxF0q6jkPvN5RbLpzMU6is4uLKeZQvNXdTOh
         02AWlXcqoVQ3nopkRzBl5TWnKE+bcoNnKfIznN9rlOUfoxzU7FEpOykbWjG9OxBD53Ot
         Ex/1c6KIDgRCpjpAzm1wF/Pc0f7c/p0DIT+r2KaollQNqIr/bskmaKwT+PLkj8H0WY+z
         pwpYB4qnNQJEqiL9dQVHcQFgXEgx2WIidsrw14qnSCTEb73Z79/EKxE4AGJtyR7aHNxb
         k4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740915; x=1750345715;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7f9euiYwFjDamxwvZ38IMZUhr0NY/vKeiY61rwZXar4=;
        b=ZfUh3lVfSJeh7Jcen/MYFempGu2cmzxEoQRNs2fIY0W37JhaogKDSUE+5YbRCrvXp6
         0U2UYXwAcOiyYFD9padP3ssZhTnkQXkH2WR985Ig22jKnzmWTPPpftR9+pbmryEkYqO1
         PgT0LPPTL0Q1JHpFRjbzocu/SAP7iG1GcPWcRQeg/h2T8MTm9gF7ivea/5E4+efeCj6U
         491lpITWuTP5zOyR6hMXzd47LyMxKgXuP8BNAmYdXaDhHfW2TbrCESEvzu/xOEzbOEoe
         k1HoJusQ9w+aY7BeBFMxCEN+0fK9XRD3t02GDLJa5ueoJi/1leBDgxTgWgL0Rj+tIIkf
         RtsQ==
X-Gm-Message-State: AOJu0YzTQX8rhL3JfquMWDPyr+C1lpauhaqIoteziGHwVYuV0DTz7mfk
	kfGQSW22RUd+HhWYPaXVC1pg1kZpRRbpLiVJOTuVasbE+8QUF+98kARg
X-Gm-Gg: ASbGncvpkdBBSeiSI/cNnVQsEIm9HiVSNNdXJiRarlCLGFv26BYlBDYUD8XwxTuhjif
	pqwq0E3RuQfwpTMJIx8BNeZo2/UADJxvBtgDSnFSukXydgz9J0iE59nvxHNq1k9d2SkMuqpF9q6
	hRHTj8/8LfYpU4iIHnzCuQYIk9+BAEcmi5PJX2bbT7pKzHskxOVSfUYVEin9QaOhrpGDKm2bUwJ
	jzcWP61u0UMsrR016DNeE7f1NAjcJwBoFq2cKniTQVZ8XNmMZkWTB8di7fd1Wvtb1s7TpkfI1L8
	/YeOBvxHSPZUW+rlUDDjzgOmbUkQWoql2hij4zW/ShaATHl6pKvn9v61C69cGeEyWTRjaogJHyR
	VFVWnsE8XZ06+X7k=
X-Google-Smtp-Source: AGHT+IGVyGh9wWdPVWnukwhoiHnIrKrtxjr6OZNt58huDOCe6FmbUYnjsvnfVEjh8FXkxQbbzGB6Ww==
X-Received: by 2002:a17:902:e74b:b0:234:8ef1:aa7b with SMTP id d9443c01a7336-23641abca6bmr110728315ad.20.1749740915355;
        Thu, 12 Jun 2025 08:08:35 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61cd1fsm15260405ad.45.2025.06.12.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:08:34 -0700 (PDT)
Subject: [net-next PATCH v2 2/6] fbnic: Do not consider mailbox "initialized"
 until we have verified fw version
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:08:33 -0700
Message-ID: 
 <174974091383.3327565.10234461453504709958.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

In order for us to make use of the information in the PHY we need to verify
that the FW capabilities message has been processed. To do so we should
poll until the FW version in the capabilities message is at least at the
minimum level needed to verify that the FW can support the basic PHY config
messages.

As such this change adds logic so that we will poll the mailbox until such
time as the FW version can be populated with an acceptable value. If it
doesn't reach a sufficicient value the mailbox will be considered to have
timed out.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index e2368075ab8c..44876500961a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -95,6 +95,9 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
 	/* Initialize lock to protect Tx ring */
 	spin_lock_init(&fbd->fw_tx_lock);
 
+	/* Reset FW Capabilities */
+	memset(&fbd->fw_cap, 0, sizeof(fbd->fw_cap));
+
 	/* Reinitialize mailbox memory */
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
 		memset(&fbd->mbx[i], 0, sizeof(struct fbnic_fw_mbx));
@@ -1120,6 +1123,7 @@ void fbnic_mbx_poll(struct fbnic_dev *fbd)
 
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
+	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
 	unsigned long timeout = jiffies + 10 * HZ + 1;
 	int err, i;
 
@@ -1152,8 +1156,23 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	if (err)
 		goto clean_mbx;
 
-	/* Use "1" to indicate we entered the state waiting for a response */
-	fbd->fw_cap.running.mgmt.version = 1;
+	/* Poll until we get a current management firmware version, use "1"
+	 * to indicate we entered the polling state waiting for a response
+	 */
+	for (fbd->fw_cap.running.mgmt.version = 1;
+	     fbd->fw_cap.running.mgmt.version < MIN_FW_VERSION_CODE;) {
+		if (!tx_mbx->ready)
+			err = -ENODEV;
+		if (err)
+			goto clean_mbx;
+
+		msleep(20);
+		fbnic_mbx_poll(fbd);
+
+		/* set err, but wait till mgmt.version check to report it */
+		if (!time_is_after_jiffies(timeout))
+			err = -ETIMEDOUT;
+	}
 
 	return 0;
 clean_mbx:



