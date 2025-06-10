Return-Path: <netdev+bounces-196151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C601AD3BB0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893A33A36BF
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061520DD6B;
	Tue, 10 Jun 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKWA/3vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADD1DA62E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567085; cv=none; b=j9v/cg4IVrEjWN80yTv5b+JkSq8MqaTb3aDn1GmH5XZrbzdjYBI+YfKGxTyZM91RKNNa9BMxkOgNO9VpqdZ+sT7iPmr0DVv4GY/EE0PQBuvN+Plu5x7XKLPj9nz6MGaznhwoYO51kHcif2NCl5ETOQ+QAGXluo/C+OYyP/24lTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567085; c=relaxed/simple;
	bh=iwHqeSdllR+93d/aKKDDL1cVggfs/AFG+oVmB5zp6I4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGMYzKgzBxZl9FDMdNmUQSCQhsyGy7IXssyQ8tJWM9dSkGafI5KZu+X3vpiLn7y2GsUw/XrdkWbn4VpFJ97IKBxteW8LHuNzAxKag3iUa7DyyZziQ9CBgbTkOgAW/DXDeBKpeWY7CjT8Is8FibpeWc0I0bEP9z0+5626p1GHc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKWA/3vv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235f9ea8d08so44517385ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567083; x=1750171883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7f9euiYwFjDamxwvZ38IMZUhr0NY/vKeiY61rwZXar4=;
        b=KKWA/3vvfAGlpOXfQ3n+0I92nvGlcKZhWRiMQwfGl50YjWBy6CUCmIrhI0oxNpyUgs
         i4GgFF7dbaNLNX2yD0fJGvWo6Vzt4YNksF/CxvDgGrG4e4mCHii9VXn9YduhtHqcsc+k
         KpGm81jdErgCSikS0eJFjffVqrTdgVeQk6sf0CiDTeOakxHOv2ytK/j8+O2gapMP2l4q
         zN8keUUQ79xQU8hbpZoLuJwNBGUKKxg3r7fNuclQoI47OVREyqDvE6IL5gHIgFssdAt3
         7K9Bcokw8ma8hTLgwdRHWSOy1eCz5TcKu+29RHbZQj5/Krmbgx1FnujO/ILRbKXkz343
         TEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567083; x=1750171883;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7f9euiYwFjDamxwvZ38IMZUhr0NY/vKeiY61rwZXar4=;
        b=vgsCP970kAPVwQpo5746H8CaKIKZUZLZCJQjuOp0BRGgqRpzEkYE8RTu1XbYyUfyxz
         1Lxg7pCqL41z7WhH+r9EvMVnX6hOKH/o8B4xDAZ6igSuZvGiFwak4TbLXWcJH4+GKX0i
         StV0atLCWzgKn25N1ERebOksosxt4rAVf7uOkEqX9Bz50Fl8DNkJbMUXrqIJ5DWVsT85
         gAmPfn1wP/j79FAJTjUBkMEdZiJ79Kn/azkjcN5u7gp8LbJbLETPKkynQWg1m7QgwIHR
         nLNEbVwzMK1rpNtK1DyyjwRAoWEFy0P6DP0wd/nwDItePxqaJ5nZihnJ5+Jg9UyIrkGz
         NnXw==
X-Gm-Message-State: AOJu0YxI5KI3QLHL+VWPjYZumu5Kxlx/DgFrzJ+Zkkisngh3P4GoCd0J
	zwbjCfTKbcB6V8WylnLUWveLtP4MdtSsclSXimDO3IKtpjJ7u5iK77rwoNWBpQ==
X-Gm-Gg: ASbGncu0POYlR+f6Zv9YZX8+uROyqhdmNiZTd/m0fivi8rFLXh+pOQcZew71/WPnQnR
	fTHTRpUun2PeLphbbB6IY0UeVEUomtl8cJec+spRq6rtf5aFbZmR09oOukoMIcjrqETpV+6oyN3
	IzAlvhUAZ4iN2IoTQNihhV7N8Jm8Y8EgJSXU+XcbBkYQ0l0gFOVGeoYz2hcJ7J7Agbph/K/Q+zs
	kX3/IVxRYgyMtFexqXLEHlbzQRpOQJolgd7dGrL/zHoPBAC8x3FZabY6PD0zdtdXMwiHlDzeGIT
	lkSNTSjbhscVdIorCV9UIhVfVZOI1VO68ieuW7YkItnKY1wFIUzv1dMJz6XTy6UQXkEULVbAnXE
	/PUQGpJa8ndnzECmdIMjo9qBv
X-Google-Smtp-Source: AGHT+IEz1NnYQ59EQa9xVevBg5UloQXhpp5GKCisgqngHLOlJIb5Uz4Nt7/CTLIQtiGeeWjbt7J2Bg==
X-Received: by 2002:a17:903:1c8:b0:234:a66d:cce5 with SMTP id d9443c01a7336-23640d05076mr2100135ad.46.1749567083079;
        Tue, 10 Jun 2025 07:51:23 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092ed7sm71848475ad.86.2025.06.10.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:22 -0700 (PDT)
Subject: [net-next PATCH 2/6] fbnic: Do not consider mailbox "initialized"
 until we have verified fw version
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:21 -0700
Message-ID: 
 <174956708169.2686723.15143414485068274052.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
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



