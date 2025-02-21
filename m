Return-Path: <netdev+bounces-168660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAFA4009F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D41899EC8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6A25335A;
	Fri, 21 Feb 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe45memB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594C2512D9
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169107; cv=none; b=PqPKcj83BcpjWBFK3Bd1O6jfIme3CdIG/2L08ks4UDubhwecjsPmWF+PrQgZEN1DGr360PBPOtQqy5EQBjJP2KJX1utDEiRtB9Us+3YJ0iuvUL00jKfgPTjYRCicfhMODGd13cU04+1T1MARZCPQWv2WtaD3tD+S6C6oje1WnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169107; c=relaxed/simple;
	bh=6dtVz82lOKNLaM07QdVUiadGpUo4vWTUrmYyVxpW3Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGXacFnU3uqWm/pHjVJoS7WTVkIoWmIA4yICMxwYUpUmgSgaPI6EOs4i9pjFZ76fNf+Q6Amt0h4kjDYUf6w7Jqh58NZWKC6SUPptEVm1DSdnW0AmhF5Dtytl/gppRQDqM5ZcZAxmBdPkUsAo0moFg1HRBrbY5A4vHsU0yWGFY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe45memB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so400948866b.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169103; x=1740773903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRpXzgWcJJmY5KulSOCp1CNPtdWbFMJJfCpA+8BDKvk=;
        b=Pe45memBH2tQi4tVPLTZqgx9hqjtogN1iyxOcPnCu6ngvYEhRiUmSDIdGlGxk1Smeb
         2NtUA1HxOiqiyRuTQ/aQrk8S2W34kqFs78EZSdVtuIjpLiXhn5490m6mk2oudW1UVadz
         PF+hr6H9iSbE576hYpEM5eS2AMor7n8Zf4csDdydEc+8y5yGzO2TMnACp2oZ0Xr3OkBM
         RECfLaDVROuOuVIxFFdVylYhvnaai4s4mzi3EuVvIvD9H+uHxh/QPxfH8H6MZFFoL/LY
         MY29qwBwu+fD5nNvj9nFUYce5jDjX+qnF3G/thVFfW947QJnCGzA1g5iA/JGJgLi+VOo
         F/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169103; x=1740773903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRpXzgWcJJmY5KulSOCp1CNPtdWbFMJJfCpA+8BDKvk=;
        b=fYomQkVOmL/mpPA4iAkugqogFzo4UhKULmuLJKDAIIs5Gys6ZlQjt2MooECxGQLuQb
         QjtcxeO7UdVQWuQDgr5wuA/sGAf/sJWnL8MCv14EoivM/GqMjrDZviFKgD8JBj0XJSJN
         vEf+SNPz0B1Cw5rOQWwuB9nsgT6vis6gxOr5HBbYrgZPTO11YwoHDW7S1P3CgTyPZdQc
         nqJr5WUTUUTwy0jEQENET6Xw87VV2KWQy0qEJTizmQJHGIocHvPX28qANPyPdr9zL0hJ
         /T+VM2IU9c0L7zdA4CQVagc0HujVcs+TEKdFEkypZaqY+Mnmqk79xPr+G7KQtXRZg/81
         oARQ==
X-Gm-Message-State: AOJu0YzXEGr6miFRPvbLxdu5nF+BkNbyf9zPh9LINq/KWCbvMKhCsjly
	wW7KmNEadbx7mEGexm/4jdR1y4rqwNd2Gc9k7hJ9oxyi/Ftnv/YpD3boT9UZ
X-Gm-Gg: ASbGncteo25pnAq9cGcb/TDUrIPO9XKbzScxFa0gqQSe7PSuqbaoavbnDlKyqn1Thzq
	IUJ0NnskxHdLbtv5MnDSHyRkKFBuRQEjlRHvvCpnOqnJBTG8Aoe+YAQ2JfMsv7wAkf4Mzt8wwWw
	UCylfcRZ1mztCjkRmEyxZx3xV50jtoa++9YHx/67rV3k9P//KOVduHsOE2MKa4pNF3dBvIjm1p0
	E6L6lgDGp+MDazaH0ypu/GizfMm3ws+VX0j24A40Lt0CMMGVqrGPtYIfxANkL0SVKk99gIOC2rk
	BhFS283eTeNm18uQBchpP7M=
X-Google-Smtp-Source: AGHT+IGxvymd+Bj8jlAdn1SyUFeu+rrY/wqYEPoageXhtJkSAdxnQ3SQ2l0tM14cCcz8CsMGTBalGA==
X-Received: by 2002:a17:907:c29:b0:aa6:9624:78f7 with SMTP id a640c23a62f3a-abc09a0bca8mr505058566b.17.1740169102812;
        Fri, 21 Feb 2025 12:18:22 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaf6ec730sm844400366b.163.2025.02.21.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:18:22 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jdamato@fastly.com,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	sdf@fomichev.me,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 1/3] eth: fbnic: Add PCIe registers dump
Date: Fri, 21 Feb 2025 12:18:11 -0800
Message-ID: <20250221201813.2688052-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
References: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide coverage to PCIe registers in ethtool register dump

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c | 1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
index aeb9f333f4c7..d9c0dc1c2af9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
@@ -30,6 +30,7 @@ static const struct fbnic_csr_bounds fbnic_csr_sects[] = {
 	FBNIC_BOUNDS(RSFEC),
 	FBNIC_BOUNDS(MAC_MAC),
 	FBNIC_BOUNDS(SIG),
+	FBNIC_BOUNDS(PCIE_SS_COMPHY),
 	FBNIC_BOUNDS(PUL_USER),
 	FBNIC_BOUNDS(QUEUE),
 	FBNIC_BOUNDS(RPC_RAM),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 6f24c5f2e175..af6d33931c35 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -788,6 +788,11 @@ enum {
 #define FBNIC_MAC_STAT_TX_MULTICAST_H	0x11a4b		/* 0x4692c */
 #define FBNIC_MAC_STAT_TX_BROADCAST_L	0x11a4c		/* 0x46930 */
 #define FBNIC_MAC_STAT_TX_BROADCAST_H	0x11a4d		/* 0x46934 */
+
+/* PCIE Comphy Registers */
+#define FBNIC_CSR_START_PCIE_SS_COMPHY	0x2442e /* CSR section delimiter */
+#define FBNIC_CSR_END_PCIE_SS_COMPHY	0x279d7	/* CSR section delimiter */
+
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
-- 
2.43.5


