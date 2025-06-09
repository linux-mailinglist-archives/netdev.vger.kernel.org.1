Return-Path: <netdev+bounces-195864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8BAD286E
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD3188D9C7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEE222597;
	Mon,  9 Jun 2025 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0B/N0Lp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49321D5A2;
	Mon,  9 Jun 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503307; cv=none; b=sssXj8EqwJH6DYiowZNiI/7Zn1IGGqxcOmEojcr1K95sPoNktfRZZ/zo9PFXFXtajZEmT2GAIb9+Vnaa+0VTfgLWrN7f8hEhtPH1IGcoaK+4+v5NqdbJ4IXUTiPA/op0VtPMm27LZ23bbsaxXL2V6JbkIgi67AzdGQoIwSklT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503307; c=relaxed/simple;
	bh=zJTjdCr8yR6jka+8Fl6/XXKV/YPVY/4YWXAs4bcR55U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sS8bFibjM5F5CsBqezPQHoiillKB+KT+hdOnCGwbOuUDxj0HDibZijNJMwZ9EGbfE4Pg8uritpIzos5gozdOuho7CpJxWCcb7OaxLhiM0ktfNdpAS8PWbGfnuQ+3nJjLcb6DwbkekZVgnD271wDWUxH6ePvsgB3/057RBR+qgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0B/N0Lp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad883afdf0cso867213366b.0;
        Mon, 09 Jun 2025 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749503304; x=1750108104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaer8KAt7DHXZvrLCnz/sCu0lhGcXvLJk84mttxt34U=;
        b=E0B/N0LpVCF0rcat7KgPdyKFCLMBVdc7Z97xWV7Q/nTv6kKFazzAeiPsRsTHT8OUpL
         rOhPkYYci1rzUg4fCs6IDmiSzBnVeq9fBMX3QxByilTOXzhwTlKJy/gGMQpQRH6XMAUU
         SHtQjW+SjqUVxbkYlISQjptGr1uhzk4i+I59ra7yW5BXppoz0iY7dKFh70gidqZb/ndx
         m3UJvAJjdQr/hrneRBtZtUmv6r0zXVPlZmz5nTUVAfud4EkiVqaVDRK9pQ8QYKNkmFN4
         PKSzkMSvWjhvK8TlDMQ5MVis222sJn9YmocHt/TXaEhF8B2DBIngyhQpl8ZRbB5bBM1S
         HhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749503304; x=1750108104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaer8KAt7DHXZvrLCnz/sCu0lhGcXvLJk84mttxt34U=;
        b=fU8KWbZaF5jzqZyjSezjt+xvZE6pd/9JJBYBVlRJar0SaSW7/ekrO2MKD6V2gpqArG
         oFbsfNyo+eczdpFl5/7cWHDQSBiWRf0aXET/teAoBWId5Ly52/cOglj3LX3Ij6g9HBsR
         XsW9DbUXzw1q5uJ6uNgaouXOGxvsjRkaQaPgl90nOzmJUZs7mqCTVwejKBqiKQ4GOGgl
         SAcXcjP+4uZ/4kCzTu+FxeI0L8pgW2gw22DcSDO/qViq4SHK76F3bAqiA073uqKnHGEF
         syl4Y8nc+IsOB2c1cm04o8FBUSdKE8SMagQ6U+MtEpvp682GwrBveUpxpYJzJaS4gkal
         410A==
X-Forwarded-Encrypted: i=1; AJvYcCULSHr6+WZfIfTytes29I4jO1w1Gcyvv/U7OxRN4A5YHfk/ss6Fx0pnCVucqaF5rPAhm8U6h32d@vger.kernel.org, AJvYcCXaOVxS5DMvHZpT+/fo3AspQWfxTkZx8xjEqw8rc+sQfb6YD9lgAzQN4vY0hJraZJtww+WcQ8hcFvDZQdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLE6E8WAPGViV/52dMkCq6PRYQhJ7ApqrP7zLn+4BCkXQLt4w
	Dk4tvUiqgu7+v2D4DZ5EDEgw7CVWnIAxPiYbAPdKPei2A9fu/I78UsLZ
X-Gm-Gg: ASbGncuipEGlaIiYgb/zjNGagEjIIZNcZts3TjF40bsgckqMhWs0GqpikjIVyfNwjh0
	nFWwzOSRNmCSJOD0FUQHQTLW+J5wq3kZk8A6Tus+aN+Wa2kT/q+xyqokeQqNEm7TT+b+S6UIWv2
	8nN+GYl6VseArTaS12E/UHpb0VIwpi6192eDEe/5wDb32GeleULVAxWm0bnfa9UUsMGDMHnBllY
	CTjqbMiRzx/lJyRoi2xs4pT+XQmq5/hGyBB3KMDdoNdt3FXOfcw/7Kp8AUkBBN8ce/Tl77H1nDm
	OihzHuvjiIJEIqIp6kF1BKLsdfv0jo1Qw6o+eIcn0bUiD8fo3SJ+qB9/x946o0O9NVYIT9Cm
X-Google-Smtp-Source: AGHT+IEF3fQvwd1EIVSbTlo6LUuUxv3OibA7tXvxVkt4PpEP2e2lZf2MmCaWCy6qIv21CKgts09mig==
X-Received: by 2002:a17:907:7216:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-ade1aa0702cmr1303826466b.20.1749503304229;
        Mon, 09 Jun 2025 14:08:24 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c57fsm609733366b.100.2025.06.09.14.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 14:08:24 -0700 (PDT)
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
Subject: [PATCH v1 1/2] net: bcmgenet: use napi_complete_done return value
Date: Mon,  9 Jun 2025 22:08:08 +0100
Message-Id: <20250609210809.1006-2-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609210809.1006-1-zakkemble@gmail.com>
References: <20250609210809.1006-1-zakkemble@gmail.com>
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


