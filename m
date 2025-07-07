Return-Path: <netdev+bounces-204514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E5AFAF6C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5F77AC0EF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9251F3BA9;
	Mon,  7 Jul 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR9CzcvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3D28D859;
	Mon,  7 Jul 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879796; cv=none; b=aRogmxc6gpBruXctmzzaverROJ4wu+iDsLPMgFf+L9oRX9Y4Xbe1ffTW9e/gY0ffk927SqNtGrKaLWxZSkS5YU0ZPmDUhlyjL0uJehRY6re3+j1T4lvPg2y8IgjBDwcSTPTMLaJae1zTJhzOiEREdSSezamN8z9K4m099qB2G5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879796; c=relaxed/simple;
	bh=ghKjjOoGQAtw9BMALmm0BexzAjmhW80mDMPfIHuAecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxVpdl1IAoycD4f7bHzWyqbBL0oKHWcxZ+77ZSfWRAt0ln8/mNJnjz92WBcBxkec+5Muo3f5aLaki9WgYN+RIMy2vvGDope4e1jZpS9i4jowtTrZk48g/il5A5oLxUcykCb/ZuUdJIR68T1qklFlad0Uft6nsuR2vkz2KhOd854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR9CzcvC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23694cec0feso23417465ad.2;
        Mon, 07 Jul 2025 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751879794; x=1752484594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hTLLYw6/QBTKtK+3/a3XlzlZMqMIP2SKDniG4sqvQo=;
        b=XR9CzcvCn6vinIQf9NNSEL7o6H9LiRAUREbu45UO1Wdg47So6qQEgdT6uoQwYr5ly5
         zOPmd0vPsMhLT25xCWbySLzDAv0LxnIZS4llxgy4/K8wW198UlMPtpFyvYHQzEVTjzXK
         Vw1IkXWgjVMRXR9GRBWzKUNDUZ07Zqaa8jGFz/r16S5WhzviArsjWKSLI4XlAsJd4/dL
         16cN8Te6SGfyX8ZTuKDahuB1QOahIQ1/EiGRgPr68FhfseTQQ5AF2oGVkf+exQDa+iGw
         Zs7mCLf2mngvI+vSkiVhl0RIJF+hmbr/NMSDZlSHKjsdKGi6M1t/dCgxiQ9s7aGfU08W
         qHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751879794; x=1752484594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hTLLYw6/QBTKtK+3/a3XlzlZMqMIP2SKDniG4sqvQo=;
        b=aIxK/eha+5zxeOQeJMoMI5qW2MAh/nDBLYbBCOoK+yNnfmlGXWHQvCPvzXbxCdqbWt
         dANaxkbLlMU3Vf8VQmCYHMzeq3yN8wp8NLjn81L2szkgpsWvvSCI2csG8xgtTF6eKkUP
         EkENYShSdcQfxL4SKPzlzqL8rj+PJ+LVUyFUjpoW4fBFYxgGvktc3rygQ14lu/e8UQR7
         4wccz3Cuz8VDASOoQgTU5TCbtK3ZxMt6eWA+TUx82kFGU3DXYmd9grUiJ4C0xu5icqj9
         AeAWFJuiKaD3jZ/Elub1Cor91z82dQua88nF9GyE3L7tSill6As5NracDBdfBQFCaBMM
         tJRw==
X-Forwarded-Encrypted: i=1; AJvYcCUdfxUB+j+p5XWipHRCYDvRdkVajMKH+o0rZMtvWR0M0GvKz1qa3xFqufS4Puz/33e2knznGJS5@vger.kernel.org, AJvYcCX32L1fJ3Liup+XD28PDAep3oKYDm/GLr2uz6XSsMO+PUqDMYQByM6cgNNBQ2tNrDrfMMceTUaN0Vn5n1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ1W5aDkLQ7KStoIcJ0XWarClNRkSVT/LDYciCxSrfwoMWpph
	5xI4W5gHyaBa+EFIhrBP7q5X9iMAabLEiODKGY5cd+lb2c+rbr1/5lGe
X-Gm-Gg: ASbGncsDRUM0MnG7ocfZehb6SzOwwFEESpHmhvfRDAbd5ZLEixttm/CeLe+DIM1n5Tj
	ZbfNvyw+LpxFKnxd7C1RdmsXXdBQvPwdA+OCv+SJr+c9BmckEcL44wcQthV8Vvk74R1lEhbrr+4
	zSIiwC565tGc9i90+2OGHghAUGuY+a5ulcn6ypcReCRlqNPHcUMLvMGSjZO6HRo8EinyivGiQip
	0JstHcI9fGTs2XBKWMq/uF+wFimpQMnV9rGAC8yGBrKPYn4SO6z7PTD4yLKc4dzsLZU5A28Cucn
	kQa/Gt4Skns85W5tlvhVZQtDQRyK3Z6oGlTaFAkxYl85MwdeOHlYmPAKpBVc/E2l2fCRGTneZ7J
	WQ1hDCtHN8dHq
X-Google-Smtp-Source: AGHT+IGkkRwlGblMPdmExw1hW/k3UyhI1KyPF4+HG/Dxr3g1aD2uQCTIqBLt7GLJrLQbKkLjIUgu4A==
X-Received: by 2002:a17:902:db0c:b0:234:8ec1:4af6 with SMTP id d9443c01a7336-23c91056ecfmr121419135ad.45.1751879794505;
        Mon, 07 Jul 2025 02:16:34 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bdb15sm80504165ad.243.2025.07.07.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:16:34 -0700 (PDT)
From: Wanchuan Li <gnblao@gmail.com>
X-Google-Original-From: Wanchuan Li <liwanchuan@xiaomi.com>
To: jv@jvosburgh.net
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wanchuan Li <liwanchuan@xiaomi.com>
Subject: [PATCH 2/2] bonding: add module param coupled_control
Date: Mon,  7 Jul 2025 17:15:49 +0800
Message-ID: <20250707091549.3995140-2-liwanchuan@xiaomi.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707091549.3995140-1-liwanchuan@xiaomi.com>
References: <20250707091549.3995140-1-liwanchuan@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows configuration parameters coupled_control in
the module during initialization.

Signed-off-by: Wanchuan Li <liwanchuan@xiaomi.com>
---
 drivers/net/bonding/bond_main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c4d53e8e7c15..c86c72bb432c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -123,6 +123,7 @@ static struct bond_params bonding_defaults;
 static int resend_igmp = BOND_DEFAULT_RESEND_IGMP;
 static int packets_per_slave = 1;
 static int lp_interval = BOND_ALB_DEFAULT_LP_INTERVAL;
+static int coupled_control = 1;
 
 module_param(max_bonds, int, 0);
 MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
@@ -144,6 +145,11 @@ MODULE_PARM_DESC(downdelay, "Delay before considering link down, "
 module_param(use_carrier, int, 0);
 MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; "
 			      "0 for off, 1 for on (default)");
+
+module_param(coupled_control, int, 0);
+MODULE_PARM_DESC(coupled_control, "Coupled and Independent control state machine; "
+			      "0 for off, 1 for on (default)");
+
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Mode of operation; 0 for balance-rr, "
 		       "1 for active-backup, 2 for balance-xor, "
@@ -6195,6 +6201,12 @@ static int __init bond_check_params(struct bond_params *params)
 		use_carrier = 1;
 	}
 
+	if ((coupled_control != 0) && (coupled_control != 1)) {
+		pr_warn("Warning: coupled_control module parameter (%d), not of valid value (0/1), so it was set to 1\n",
+			coupled_control);
+		coupled_control = 1;
+	}
+
 	if (num_peer_notif < 0 || num_peer_notif > 255) {
 		pr_warn("Warning: num_grat_arp/num_unsol_na (%d) not in range 0-255 so it was reset to 1\n",
 			num_peer_notif);
@@ -6455,7 +6467,7 @@ static int __init bond_check_params(struct bond_params *params)
 	params->ad_actor_sys_prio = ad_actor_sys_prio;
 	eth_zero_addr(params->ad_actor_system);
 	params->ad_user_port_key = ad_user_port_key;
-	params->coupled_control = 1;
+	params->coupled_control = coupled_control;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
-- 
2.49.0


