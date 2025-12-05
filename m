Return-Path: <netdev+bounces-243761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7ECA70CE
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC8953492701
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37F336EEB;
	Fri,  5 Dec 2025 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Bc5wxWf5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217313093A5
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923130; cv=none; b=alxG8vzCB3tYyADrjOZvvMge6ME4Td2yiwnoVk4Vl2f32x3pC0mvEUIRTxqYj6W7c8yHBltPWQk1dqapbRJ9XfAHYRyCVejh9t9qgC7UlhO+PS7RTpmows0d2alOwchPWzoqGZGn0ge2dlzYYmm12l1streMrgcuID+kT8K54Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923130; c=relaxed/simple;
	bh=K60gl9Mnhetq6W/Ntrnbmtt6jeMTyUUbXPtCpqDQ8LI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofson3LQBuAr5kDicNCI87HClB83PKA0r3EmvAkSntXVOVVcf1hWrkWxJm1TiysyX5gsgTYktdXh4YbONycPGEVRrVxU/r8l9NuHADPmqrrQwgO6zc+z2WRikDCmSk8R6h8Cecy6WJCrfLifItMXPSIe1t4w6b1R8bGfHGVcA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Bc5wxWf5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EAF80401CB
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764923118;
	bh=vPAIHokCAd7ibs1BxYRl6MfcOlaVrL938oA/Hg2FruU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Bc5wxWf5jPy2+mjSeev5A9CKbIEuRqndoremvwg0ePTkhpdu8XVKSUROpAOO9jRQW
	 T4Up287A31+s0ub+4aSsZFJID3FicpOm2B4cZs24QwqhuVJHwPMEaOMfjWIrg97xCq
	 xmXjJQ13p4Sm13GNeh/jJY3wWLN0YZqv3+QM1htpo2hRIfHZHkmynjEfTsbsv58kC4
	 Mdv8G/B5SDf0+oXQb4xe/nJuHj0Htd4B/xdt+kMYKVQqoUqXe8AizI1Qq6ofPI4+Kq
	 QnfTL2gOBbW3t9bfDKGIFuHnJ9bIJLvZwt2ifCSGA68NHOtXWU+V5ZqZd4CDr4ua6/
	 0ArMlh2Ij/geYFzD2y47fKrDbN8Zcc6Ni8KoKLoSzAg596YnMlY+hqp3C+GOAeX16H
	 aneS2h6AmnHaO/OEivJLPGY67ObkiWWgpRmmggPTHFkQ1qD1N5QQql1zMLnJqx98I4
	 P33oIvlukL0d9l9OJ9q0mBQclWJYcde6n6+0VmpHBXTBn7G6P4+YN7XkCeN0Q7ZX0U
	 byNxW4Qf7mYB05pJQgeEK0IiKJ+q0fpChWegtS/LY8W+CF3QaMgCI49oIeUXuk/kNj
	 IMR83Z0mgvI2gR+RnlCT9jZYy6MFooK8NiWW79pX1k9tcILpXVrKORmer8gWyTVlCA
	 KA1rs7JqpfUBvaVjqnPfK3b4=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297ddb3c707so17105215ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 00:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764923116; x=1765527916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vPAIHokCAd7ibs1BxYRl6MfcOlaVrL938oA/Hg2FruU=;
        b=m6bzoa4XEe8adsE/HYwIkd4pETknUCxbCrBAMubppUTd1OHJf0RdjE099Yf59RkZ4y
         2FR16fB9MUjlrsYkfV77Q/XqlZ6Tguobx7x8l1CsQUT/WeC5TZx7qP3IdSWMIykIyQE8
         pp0xBg/bO481skLQ5dAdC+uSjEth2kFe/yACJcJwulnLHUINTBabL9KVsCPiMqupQHhE
         YaidXmK2+IQtvXm4vQtyujzH4Ebb4kchgIbpgyA7K3Vsg+LO2b6HjTIKuJgdo75q3t+S
         vJO5dabGFSTFHdTvplaauTlUXMOan3trdX9Ir336Wh/PGSrHNp3+kNIUgCQewtjdxMvt
         fVzA==
X-Forwarded-Encrypted: i=1; AJvYcCW8biCYaaxpyqwXO4LAj0jPEfCBWL/eXTIUVu4jWDvTigD7szzPzaevORxLujh5KlZ4+zKYeTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXSAKC0S81QMUjO3Ba5lIATUZB4GYJ4I4y++rhWyKQ0ydydI1
	5wASHXyVdOXBNnW4/I7u1dnwlV4Kfw0kGaeVfdXCeEwNEwvTOI8ANj/dkL1ilYfWPY2/AywTRHU
	EhjUJ2tl7Fvbu10ue4cieQ9Wwxi6Bs+XuEHl2dACytVf/2iJmn8RRUC69+hMtq5GQMQNJW5L+X4
	u50JLG8pRf
X-Gm-Gg: ASbGnctuTsB7E1Z+zBpye0G4vNUliQTGFhEidOq8MYnwd1hWk88QS2SPVQ5DffPL2nt
	StL6yacwEav9M0E+UGBzR5vQJnr4Zc94O3G8q8GxEZz9bfYycO+jceQp3N8i7AU+4SUYtbTfko1
	xSOQ7+D0xwl092xzWvM4jx0Ff2Ce0zS1GzugbQRELrz3TQs4bBYSl3Hwvp5jWWRi6UjGyODXjKf
	1FJwjITEtK0ngYmncdIZFQ4fgGv6Erx+nSmPu2IN7O9EGy6RTcrUlj8UygCU7JjYXBv8oxZ13/M
	fnWEaR+m0OAfdolkHvyyE83lA7nfrOXFq62apyzzmlC+N+EhUjBRskn5Ql2ZkstBlDTF1LLWV5N
	880v1hvbPyzaBPbuzfU/VyuOn
X-Received: by 2002:a17:903:41d1:b0:298:5fde:5a90 with SMTP id d9443c01a7336-29da1eea72amr76286035ad.58.1764923115920;
        Fri, 05 Dec 2025 00:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/emSI1vAJLDPvRoUuEvwKwrwhdDo47cnuu11gTK6CsB4P3+sbvvwIcQoU91SQafUrHCG18A==
X-Received: by 2002:a17:903:41d1:b0:298:5fde:5a90 with SMTP id d9443c01a7336-29da1eea72amr76285705ad.58.1764923115542;
        Fri, 05 Dec 2025 00:25:15 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfaecsm40896875ad.27.2025.12.05.00.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 00:25:15 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ice: Initialize RDMA after rebuild
Date: Fri,  5 Dec 2025 16:24:59 +0800
Message-ID: <20251205082459.1586143-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205082459.1586143-1-aaron.ma@canonical.com>
References: <20251205082459.1586143-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After wakeup from suspend, IRDMA is initialized with error:

kernel: ice 0000:60:00.0: IRDMA hardware initialization FAILED init_state=4 status=-110
kernel: ice 0000:60:00.1: IRDMA hardware initialization FAILED init_state=4 status=-110
kernel: irdma.gen_2 ice.roce.1: probe with driver irdma.gen_2 failed with error -110
kernel: irdma.gen_2 ice.roce.2: probe with driver irdma.gen_2 failed with error -110

IRDMA times out because the initialization before the schedule reset.
The ice_init_rdma() function already calls ice_plug_aux_dev() internally,
ensuring proper initialization order.

Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on ACPI S3 resume")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
V1 -> V2: no changes.

 drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2533876f1a2fd..c6dd04d24ac09 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5677,11 +5677,6 @@ static int ice_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
 
-	ret = ice_init_rdma(pf);
-	if (ret)
-		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n",
-			ret);
-
 	clear_bit(ICE_DOWN, pf->state);
 	/* Now perform PF reset and rebuild */
 	reset_type = ICE_RESET_PFR;
@@ -7805,7 +7800,12 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_health_clear(pf);
 
-	ice_plug_aux_dev(pf);
+	/* Initialize RDMA after control queues are ready */
+	err = ice_init_rdma(pf);
+	if (err)
+		dev_err(dev, "Reinitialize RDMA after rebuild failed: %d\n",
+			err);
+
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
 
-- 
2.43.0


