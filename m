Return-Path: <netdev+bounces-199256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B2ADF930
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882321BC2E0B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96E27E7F3;
	Wed, 18 Jun 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWNBu62+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1F27E062
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284452; cv=none; b=Jd2vLuyCw0R9bTKZlwrQ05yIPoclm4+sG5gao5ooV9LaJ+0Try2rA7scvCT+s2q0TNXoa8YCJEKVA7WQd1QFAgql2oQDVGk+QrUnH1s6nA92FBPYw1gD2kSAmTANIKm1d8J/Sq7zoiTWZaUSkQWdz35eIS5zKIJ4LqPc0gl/53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284452; c=relaxed/simple;
	bh=iwHqeSdllR+93d/aKKDDL1cVggfs/AFG+oVmB5zp6I4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xj3J5gBWHKPVj5Qxwaue3VYTcYmLnKhZ20hs8M7sQcsH+GITlRw3FhViLPK08Dr5sX38MKJNeeOy5xo8ity0QyuquuQXPjGgcq3+p0DVDmBrVvXUOa5y/rSM9U8UMDbpFbcNppiZMvYcgfDIg++nsD7daVkwl9FY0bHPMlNX/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWNBu62+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso156095a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284450; x=1750889250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7f9euiYwFjDamxwvZ38IMZUhr0NY/vKeiY61rwZXar4=;
        b=SWNBu62+s4lx5gBhGhMuxXi2ZkdzEzHbASR59I2MGSwzvhIl1fJ9op9XA27hBL9BXa
         O98Gq9qHW7N6K6yxOFAPHheLKIrlKUBfhRLkeW7z3LM1A7p4EBM/RwRaGX9QqXfVtjxb
         Gnf1UJSGL1DNYLRUk5hykUXAB8xwLHweRtjitmVXcpxilk3YwSBM7cuwC0ln3wJt7LYe
         S02dRBWSkLDzEzUlwCTtuEr14TvYi/9BZ7JbJ+j9RZrRsK2fzSbexmVDs6EmX+kJxlIv
         VK00XG/awV7yNZD6XWGZUN/jUT1FZ/3TWmiJeqZ1z9nvBLX27d7hUTpIvM64I+ViSDIX
         OyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284450; x=1750889250;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7f9euiYwFjDamxwvZ38IMZUhr0NY/vKeiY61rwZXar4=;
        b=lXLxfx2cGtLw2cdVZ28laiZpKqQF2Q3TcOWF9k0cQlQwF0ZcExUMhx3HShmL3tCCau
         Ay/hzzxn4ljzfcehZyGmoQzEN/iJsB/LMe6YIAviiup3O1OSMTiTPaciyLYYw38xmZGi
         pjNvxpEZFSN4fLtP0m17EySxpd86pDoK2dkEQovyEKPWFewZttAQVLb2IqLLvoUDdBEx
         pUI9A8AnBwR7fg4ahCHrWKnAsmo7rqVPjltqHmoKOVlc68t5DS4ayqhCzOWLc+ChdSG0
         Qs4C/+mw6lompG4kSNZsQkrL1MCo4ys+0hTPyr7Pcnxyei6pgT8PrYICdpoLGy6byGkx
         di+A==
X-Gm-Message-State: AOJu0Yz4jkucDEsuJnqRG4hP5HUpKoMw5wnC/aIzvQkf8oyYxz0RswUx
	Gnsd5FjkJWfxuD83fZl1gq5E8DOO9qYmjFK6pDlfZg01EGp0LubVYGLF
X-Gm-Gg: ASbGnctdmRcxhjPv3PHmeNnTC60yIGGkcVqwFYM74EP7zsDXIXqSKncBSJjmdML37cV
	wP/DEEa2LNagXaUsj2eeaGHkWPBaeTuJN2jEsVK3km3Gow47/ncbPZzsCKI9w+a8E2eBMB+PtKL
	QAnyL9UyuPrNqqgdU+j9Lfvovc+fmTXoLxbedy5+26Wfk8bNf9VHNgVsY2Y9jhhD6f4hmDRLCSa
	GL1SfMOFIloTXzQbFTd0cysB5qdALpQRh8W1fXNbEGDE3xp/XwD/hbGyQAikGUv9RBanaA4thSy
	Fl4+DLvnzrRqhA4ky4PIGyDhye/r5eNJdynC6frxrv56VAlgTvB0uTpN1iqWicO604/aReQB4IK
	IoXoNEDSryCwf3CbA+bXJ
X-Google-Smtp-Source: AGHT+IG+nwqRbE8s8ApsUNA5bfUR55LIkEsPlbVsMKWkkZkDrSPfm5dAY671VHjwSk0xYFn/7NGziA==
X-Received: by 2002:a17:90b:2f84:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-313f1e19ad5mr28236443a91.29.1750284450306;
        Wed, 18 Jun 2025 15:07:30 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a270e83sm545508a91.39.2025.06.18.15.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:29 -0700 (PDT)
Subject: [net-next PATCH v3 2/8] fbnic: Do not consider mailbox "initialized"
 until we have verified fw version
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:28 -0700
Message-ID: 
 <175028444873.625704.10269838393153693403.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
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



