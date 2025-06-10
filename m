Return-Path: <netdev+bounces-196353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C623AD4596
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6456517DB15
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACA289811;
	Tue, 10 Jun 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR5LQH9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527222882B8;
	Tue, 10 Jun 2025 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593063; cv=none; b=JM8BqU0phXU2Qfn1zDF+rJA/+vWPZeAJGs604j2eAaqBMs2IhUF8WE/m4bp0sudYqbKUr9h/ABLtTwZzpACc10rtbFR26FLFXiL2Y97sUhrUyYd/wZIPAE+oZIKFf8VfjwsxblVzp+1AYJ0UiQhE2I1va3EtI+7lzkoddOlAKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593063; c=relaxed/simple;
	bh=GbFn6Sw9/tDkSqro2zccBiNaEf8q7Fhd2VFITJvagAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwXMOPZbaeAsU82yBOUM5kHg8EU/SEv3JOcSN2ZhLKpt8zSNZ6HGRNDqQGGPfF53CBH0tvGM2B8G6T1fEnG+cC9fPpjCEPu6ZsI0VbRPsz3i8JoWiie1erkMXC1KixHYa3ifU0sOo4EOjiHyxYH/g2wAq3+26LyBjD6JVkvoIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR5LQH9N; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad93ff9f714so1071162566b.2;
        Tue, 10 Jun 2025 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593059; x=1750197859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctkw1MHX23+uY+bCDb8d8aTJL0+7p5b7une/U6EU1Rs=;
        b=iR5LQH9NoPmgudwr/DJFKB33f2BL8cTpbwdg7jEaWm+Hin3e8kNxpD8qcihk/prfIE
         WsqXu6Y4D/vhC2lGPqhgMjTSith67F3Rs4RLy5Wif7W5efs140CDOe04WJ+8C9Ozzf00
         WIS+/TSv97TClOOqOyBhbJs6PZEjKP922BpaUYKEdrQprfdKcxJ10QvO1viXKt+JEhj7
         iZTj3Yfhz1nU0jn37NyFArl0e0QnSDn/3btljGPcSOV1TUmn6evx9bVDeCxv+SBNhJYO
         3QQgUsDOU8lMQV7ZeeVtNVy52OvZpLlIWFe1Th1PVlnY7FN4TEBA1KPSPqrNS6Ys7hn+
         7MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593059; x=1750197859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ctkw1MHX23+uY+bCDb8d8aTJL0+7p5b7une/U6EU1Rs=;
        b=fRwHE5BHeHhmXgplIdUJJaLkx6wppslSiLkMFrZGsctwvv9KhI4tHG/MeA99IHYcku
         0hgsDYlgJApH2H/kLD3K66lgEiSUDDh9w7xzxWmlqyYY8fVaSk9XNi+1Wtjugdz35ZwA
         la5NyVr+WO79tejBKmKgMtvuHhTaGpSP1qkjeDR+05wNnrKU+uMBNkuhZtQIwBt3GFwv
         gsT+AQh7aprP0YnpNiGwN+iKWwast7ue1VatkH7y2gsFT2sIbGZ2lfYNQEm4OKCwL2sX
         5HYtFoURjAw7JDH3y1f1L2M3ApNboHhTPpeKMLsWK1jh0MFaLvUloqsUjxw9C3ft3gus
         nzFg==
X-Forwarded-Encrypted: i=1; AJvYcCW0wGzreapAttVkhqyp43m1Q1Ql4bsWdTj30gdqsRx9vKiuqXOHfp8WXU4SU+8srNLuR0Fc8gFN@vger.kernel.org, AJvYcCWnCeuinlNuUBApU6byjji6EYkERIRhEXZ0v0pgNdfqHcCJkJPy+tH9pTRSvSIEHPHOXumz9wHxAkwmgak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqdpOGt8Sv0gsKOXSgp2S/RxfyzF8Yiz8ET2qzOVL/yp3743E
	YOzQ8lsY7xfpVI1zrFrMGJ7/KZPM19KHSK50sdEGO6ZU/ldTvjY+uXdL
X-Gm-Gg: ASbGncufni7AHpYTvLuDXCMk+RZUOrOueOxDUZhrni6W6cHsrPIQUwGERUK7+ibYUv+
	P670R2OOg0knYRUEUyMuR2qYFw86IwJqIN/nm1/cM3pC1zcGjYzc2EHXx7kQRmWtYsWa80PfUcl
	rwysH/N4vUOdG8Ols1g57Hj0fHgZwfRkP0qq0z3FZNSXCTqPbwPNy6YwG9hbku0gZEDdumCclOG
	Z/G3dKWXx3amVDRu5QERcC0wOkNMFv68IwyoskE6iHAjESBG+k2D+xmQBMvOsNxklRXU8V4rxZ/
	v73VxL2UcnwnQK8t/p9CE9ai/P6Jm5X+Y1NnPLwqpC0NbHV6ciMqV0EQ751VKsu4AWEJGy8a
X-Google-Smtp-Source: AGHT+IHCmEhHKDuFNrHrAxrTmVO50fgiBQMIT+h8e9HbST6nKQy67zUV13uyK5a3ATUZLErK0drq+A==
X-Received: by 2002:a17:907:7252:b0:ade:4295:a814 with SMTP id a640c23a62f3a-ade8c91d11fmr36889766b.53.1749593059311;
        Tue, 10 Jun 2025 15:04:19 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c92esm785605466b.168.2025.06.10.15.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:04:19 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH net-next 1/2] net: bcmgenet: use napi_complete_done return value
Date: Tue, 10 Jun 2025 23:04:02 +0100
Message-Id: <20250610220403.935-2-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610220403.935-1-zakkemble@gmail.com>
References: <20250610220403.935-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the return value from napi_complete_done(). This allows users to
use the gro_flush_timeout and napi_defer_hard_irqs sysfs attributes for
configuring software interrupt coalescing.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index fa0077bc6..cc9bdd244 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2472,10 +2472,8 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 
 	work_done = bcmgenet_desc_rx(ring, budget);
 
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
+	if (work_done < budget && napi_complete_done(napi, work_done))
 		bcmgenet_rx_ring_int_enable(ring);
-	}
 
 	if (ring->dim.use_dim) {
 		dim_update_sample(ring->dim.event_ctr, ring->dim.packets,
-- 
2.39.5


