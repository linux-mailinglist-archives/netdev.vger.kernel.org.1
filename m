Return-Path: <netdev+bounces-241817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022EC88B17
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E6393447B0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4331A7F0;
	Wed, 26 Nov 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0QJgryF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27D31A55A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146488; cv=none; b=lKjraj+H3Frb3e4SnX7IATozDaJFqWTO7ty/H5N/NjliCzi3fm6qZnkKhWKCV0ia23IQrFVLSus2yD+IVusxMO06l62Ek5kM2/NDrtW+sNI1q6Ecn/o+d5UNdT8mftg9k8REoLK3BRtWKzbbGifZ+IuX/7XlPxYqt4GzPVdqp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146488; c=relaxed/simple;
	bh=GMqvMppgg9+kh8EZJaPvH4xH3QOVzWZS8jhDW4n9Qjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azGP5mssl83YSLW0ZDnCF/fnzXyVHTBu5vZdVJGLVatl6vR8obx7McwDerpNxMTPGo5PmS0nEH2wJYY1FB/TGV1I03aCQ/U7b1AXqf00sGvwxt+CQazPT+57ktKi0kYGyJz0aeETBAQVy1OeHWycVrk+pZUiMlxFxVxpxy+PcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0QJgryF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b75e366866so3008080b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764146486; x=1764751286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jVEFoefhamhUSCRXilkvRs0+/dJxtk9IdYrSyATDdg=;
        b=f0QJgryF+Rv9OPfmWd64T+cwYvfWEHtDdrh92OQWhAQznc8884BKoE72xQyBTDdxrn
         b+jPh7drMYqSWUH2G759Y+cHEfBnw6R4MJ2QAnNuBLVwRyTxO9ycSle3UaVVNcGCcjZo
         lkD1iatAshnCcl740//M3scf4Aw8l7tfQARnuuELLirw89g//co1YoumUKRUQbLDql5l
         +CyhlnCuPY/BIFkKlSSDlmR70Of18hrROmX17mzcvRKQkOqOOxNodXzXQYYrgaZaEnCP
         GrVdq3+p7uD4XYs0svjpLiJmLMwqNuuDXLBIK9s0W5d6cI5EV4CZVof7HkrBmnTpz1A7
         6j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146486; x=1764751286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5jVEFoefhamhUSCRXilkvRs0+/dJxtk9IdYrSyATDdg=;
        b=H1mMbnDiNYvQcSMusgVBGPRHn48tG+cyjUQ558u6o/7Cwu2W42J1T9UEDXSDorGpqr
         T1CWiNXJX4AGz/diUbNnky+4cVK6SmagKRil07/kAxfMqC7WT5Xz9RjylGxmJxIfekC0
         4WEpf+uJGL8xfGm+ngu7jIsS9YVZ4isPFzuvCycZ3LTdFXVcA5kLddvcsO0bW5hIUXQF
         roUUf0ybeLdWR3RtwKeBKWRdZAOlwGR4tpm3IqXJhNH1ppQ9bDi2lRPd1FqbZs2AuOdB
         cmQfD6Gzu5eBR/U836Z6piKOQih7a+ZE0Hz/xMMqqPUhJ5zAA/XTOdjfmS0ji01qPyFp
         KlyQ==
X-Gm-Message-State: AOJu0YzoRsQPuVuWYp/WVlaovRg8nLRi1700i4aWteNPfjeAKBP9yb2R
	HHnWPFiYG6C8rqREu9jGnLHAMr2PhjYhrIAF/9PIyxjYKlPU04HQCbU9676KBQ==
X-Gm-Gg: ASbGnctL426dlL3NIj/EKu3eIFqOJO2fGU0gKSiGUnlPkU4t2LeJFZZwSA+GT33jll0
	OGrwxTmJNXyXANtV38ncx1fL67R2MNK2tYym5ArdIgb7u6uW0Z44B5Gaj4mMvX5BlbExDW5qL46
	HfuASlsyzuX/CqHmpluH4PAsQ2jo995ombvdG9eIQ+BNTL/pf+rCF1xTLYtwUHLWmeMoVeW0Ptk
	dEyoGLSeiCUA1p5AQ+DKd//Qz8qApsB7w/rhVd8d2Mj3Atf7uCixpU2FYmK8wPrINZfpqOwWYSP
	vSXo4oTOSZptuvfcOuN9fac1xyn7f/339NoNROrzT/3dNabkRSMV/AcDapIodAPW2p+XxgCMWU9
	Om6S2vbmjSzEeJ9fd9atVcfVu4vqCwADqHM2zOsavYYGqBVJvgnp0ZDILzI5G12WTthYItC2yFt
	qGyWF7C8rj5v/8Q33avOgJig==
X-Google-Smtp-Source: AGHT+IH6MlF20aBw/ekPgNeSRKYo2VxiBjnu0MoQG1M0PA3MeCaWoqn4gRIyesjAQhNiYNPyQu2Z5g==
X-Received: by 2002:a05:6a20:12cc:b0:34f:28f7:ed78 with SMTP id adf61e73a8af0-3637db6471dmr6746156637.25.1764146485644;
        Wed, 26 Nov 2025 00:41:25 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024adcfsm20918248b3a.31.2025.11.26.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:41:25 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix parsing MIB attributes
Date: Wed, 26 Nov 2025 16:40:19 +0800
Message-ID: <20251126084024.2843851-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126084024.2843851-1-mmyangfl@gmail.com>
References: <20251126084024.2843851-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hard-to-find unused fields in the MIB table I didn't notice in
the example driver code, causing wrong interpretation of the MIB data.

For some 64-bit attributes, the current (wrong) implementation took the
correct lower 32 bits, but messed up the upper 32 bits, so it would work
accidentally until 32-bit overflows happen. Fix that too.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 944988e29127..97fc6085f4d0 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -56,13 +56,13 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 
 	MIB_DESC(1, 0x30, NULL),	/* RxPktSz1024To1518 */
 	MIB_DESC(1, 0x34, NULL),	/* RxPktSz1519ToMax */
-	MIB_DESC(2, 0x38, NULL),	/* RxGoodBytes */
-	/* 0x3c */
+	/* 0x38 unused */
+	MIB_DESC(2, 0x3c, NULL),	/* RxGoodBytes */
 
-	MIB_DESC(2, 0x40, "RxBadBytes"),
-	/* 0x44 */
-	MIB_DESC(2, 0x48, NULL),	/* RxOverSzErr */
-	/* 0x4c */
+	/* 0x40 */
+	MIB_DESC(2, 0x44, "RxBadBytes"),
+	/* 0x48 */
+	MIB_DESC(1, 0x4c, NULL),	/* RxOverSzErr */
 
 	MIB_DESC(1, 0x50, NULL),	/* RxDropped */
 	MIB_DESC(1, 0x54, NULL),	/* TxBroadcast */
@@ -79,10 +79,10 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 	MIB_DESC(1, 0x78, NULL),	/* TxPktSz1024To1518 */
 	MIB_DESC(1, 0x7c, NULL),	/* TxPktSz1519ToMax */
 
-	MIB_DESC(2, 0x80, NULL),	/* TxGoodBytes */
-	/* 0x84 */
-	MIB_DESC(2, 0x88, NULL),	/* TxCollision */
-	/* 0x8c */
+	/* 0x80 unused */
+	MIB_DESC(2, 0x84, NULL),	/* TxGoodBytes */
+	/* 0x88 */
+	MIB_DESC(1, 0x8c, NULL),	/* TxCollision */
 
 	MIB_DESC(1, 0x90, NULL),	/* TxExcessiveCollistion */
 	MIB_DESC(1, 0x94, NULL),	/* TxMultipleCollision */
@@ -705,7 +705,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-			val = ((u64)val0 << 32) | val1;
+			val = ((u64)val1 << 32) | val0;
 		}
 
 		WRITE_ONCE(*valp, val);
-- 
2.51.0


