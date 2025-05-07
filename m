Return-Path: <netdev+bounces-188701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D247DAAE46C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C147AB7CB
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FED28A40A;
	Wed,  7 May 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S03gyzyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74D2144CD;
	Wed,  7 May 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631287; cv=none; b=e0K6i3YI5yS+CDaeXuZgdOr6qMafXVa/+23NBnhViCX6Qs1rPawfMc7dD/H5NIJSDwuQyG0OVGtm3TvfBCQDsXPMOdOtdoQ7KU6fE3Re7OAx73mMHUhOiceA5BXX8aENgBKP6BppZZSaHKc8dT3XzyJsSbq9xvJ0PnWavszkYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631287; c=relaxed/simple;
	bh=Rp2RWQ2SmfrP/wcKdEEy5VWXzW6C7wbaPad+wRFEvEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePzaBfMnXuFjXYGWqYbpPEFJYfhHbnNON0F4KFdxtKZ/tlj0Qs806v770gTyLhXcW8g7c5DwBf3exzzeMOZX7pPrWViSUQKytnPeje7+upX1hAQqOeUei5KroBssq9leuMtbMGp/VGCPBtFeuyH5dOG2P8aHI6W67spOTS1Pj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S03gyzyH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so80062275ad.2;
        Wed, 07 May 2025 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746631285; x=1747236085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHYXpGSD8xf0POifLdqzvkcg78XfISduLF2AQceCFVg=;
        b=S03gyzyHAop54EyMzDzN/4TznHBg6eXllPGcydI2FEHRIu8/UIrAAj1CyaeIwRnhZr
         4JXE8PKQD6hNlmYBNppGb/qefv7KNuR4VCDx64y5Aef5XXqr1Ev39diFUX/m/Slrlo9L
         iumhfTni1ckZeJfoxqs4s0OT5lFLTkq4iM0WvtZNGcP5HZk95QrdFYlXtYrz3SCyJzU6
         eItJHXfGpiJ+LqwIZmU/SAbarDgok28jcafN8Sh5aTi6LInVm19nJNrd+yKijzeGK4zn
         XU7jAjaUCgJWOJifr1hCmaAxGUcksBUdV26OzpUSj3UqQo9yL6vIxVj4gOfqUXtpHlSR
         02SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746631285; x=1747236085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHYXpGSD8xf0POifLdqzvkcg78XfISduLF2AQceCFVg=;
        b=eMusnHs6NpcQYmzn9xwaBRJmRvjtGfYNDBCitK19pI8jgBU3TlySajDHeWU9ARO1vH
         wjWI5rOVVA6P0wnovHwNYrmLh4IjMOyo5+8d6MadmJPcXUWHFMSF5viK7s6cKL/kdSAN
         rsYHKG6X7iyr0OCarmYWzvSC5mvQQ1JHxzvw5AH69aRQtlQnUGacDsWVQ6jPSWq7fi5Q
         p+G+kuYiI4lraFALsHhbCU6idRIuXg9UFUOBaEIZRKRG9JBuRhyhxsDSudwUsT23Gb0u
         OUVqj4DPB8i1Zc36D39clY5WG95K72iDexCI52vnbdjGYSj0l6OGwEmWXHwo9jxNXdSR
         ztPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0kAWsLGFFiBQ8mxPgXiom4TiUf1hBaGCJx0oMaapatHzy8xEubswOM0gEeV9IrHaIOy0AJvjww9e7REE=@vger.kernel.org, AJvYcCWxCi01+2Ty6TgjbCGZe4VIyPMLMIbRpueRumP4/lQBrlrsXBIoef75Zjp4EY5v6r8XJzThke9M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7g6SDcnmixPsKyC++U7ysITcMQsvss8rrpYGdHKPhkW1/jF1
	fmeMur1hTzpftro7fjf9xFCY61EVkWGhMUwITVU6/ziAra4n+fHD
X-Gm-Gg: ASbGncsOWtezl7+IXr+LGX1z5db/OQDzf4b6AHIaIBGkMdE8n73e85cwIYFbtKExXqo
	tkuTiFFgkeYV/h2QvHzNvys3uSyRnIGeYR0tQAAQYdtVVF7Zqt44QbN/sQR/vD3CBbUE8iZFCrL
	lmvwdvqCu0RHIa+0cZ/suD2sF+xVOtW+tE5KxKdqUga+sSb006Lu3KyZf8qP2+74wQC9WjSFPpM
	Ne2bdj8oOR6OeLjI5mfiRD7vygqUfyr5OQCObMG9JSY7ZsmOntVZ9VLohxFQK3MouuE7u8+OaY/
	AGm0t8n0zw5dczZXv75CPvPyu72D/s6lIUxy/Y2ZnoANFP2eO7DDzw==
X-Google-Smtp-Source: AGHT+IHFUiFNkkCbXkCtoDYGospKz+U/fHm+dGtocIkZN5tVhCqe60E9zpNrlEWkcod4loYukr8TJQ==
X-Received: by 2002:a17:903:198d:b0:224:24d3:60f4 with SMTP id d9443c01a7336-22e5ea792a6mr49831435ad.15.1746631284997;
        Wed, 07 May 2025 08:21:24 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22e15228f62sm94771405ad.168.2025.05.07.08.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:21:24 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: shshaikh@marvell.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rajesh.borundia@qlogic.com,
	sucheta.chakraborty@qlogic.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()
Date: Wed,  7 May 2025 20:51:00 +0530
Message-ID: <20250507152102.53783-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the error paths in qlcnic_sriov_channel_cfg_cmd(), the memory
allocated in qlcnic_sriov_alloc_bc_mbx_args() for mailbox arguments is
not freed. Fix that by jumping to the error path that frees them, by
calling qlcnic_free_mbx_args().

Fixes: f197a7aa6288 ("qlcnic: VF-PF communication channel implementation")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 28d24d59efb8..d57b976b9040 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1484,8 +1484,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
 	}
 
 	cmd_op = (cmd.rsp.arg[0] & 0xff);
-	if (cmd.rsp.arg[0] >> 25 == 2)
-		return 2;
+	if (cmd.rsp.arg[0] >> 25 == 2) {
+		ret = 2;
+		goto out;
+	}
+
 	if (cmd_op == QLCNIC_BC_CMD_CHANNEL_INIT)
 		set_bit(QLC_BC_VF_STATE, &vf->state);
 	else
-- 
2.47.2


