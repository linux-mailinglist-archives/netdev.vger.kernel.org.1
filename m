Return-Path: <netdev+bounces-289078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OQlI4kYC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A376A56DF4A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D91873014B14
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53247F2D6;
	Mon, 18 May 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuCEB9vX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0A3D3CF9
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111956; cv=none; b=Cgo/MpcXw+GgXun6a9Sgd8AK+0PUUyDiTh4Yj+iMY6dYmTiafryPA7oPgUXMRCo3uYc9LD7HKeO30edywtYBV1TFbaLKju/eIXj9gHfMpxLPQQaKiQVN4Jn36SpspJJT9dtdeSXh+CmeoL8ryQJ8ZOf6I5gLuw37GBVFZ5+yy04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111956; c=relaxed/simple;
	bh=A7iji+rXKq/foenCFTEp43CEifw4NZBgLqy3/ylbp4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R54qkO7Cfu5khiDk8wUm6di8R2Ds8Am9KjUg6GeeQ+gQit1ettPGtGDDGPvSSce2eB6Zrjl83QY4eXlZCyx/S6kl1ORnfYeoN0Yvd4b0/qsjg0GwcX+LK5g5O7184oLfTV6vAQeen8mmWw6/VLAQ0avO6JDas/dCm7Nk3nWTb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuCEB9vX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so13172165e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779111951; x=1779716751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeZUOTxiux+ntqD5XfCjsj5BrXI92DULaKFsiqtZdig=;
        b=JuCEB9vXPm5YtzVMvHEAzRaHL4HV+ywz1gVzx0qSS/T7OLyVsYECTfV4gmMmE31ydd
         Tii2stRB+aFkgpgqKt1JDJs+X7DcURqv0Jsjf23BFkEb1yHG1A31SAd0l6YzutUZRkGN
         5x5N8KQMhDSgEmCKPoUFclWMVklpASmdw3HDpUZBEkyyQKB3jXILvvRg5ncUzuJHT4Uz
         c4rmPvYabPiQW+uB2myXtpMpVmWul9HowVGbjJX++SqOXAnZMjnCOe4+y4hj8IaIoQWP
         eHpcgxCof0UYbv4/wJItjVYPBA8PkYpCUPkHV2UIQd7jRxVgOZWd5Iaxfd5WKorku0B0
         g1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111951; x=1779716751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeZUOTxiux+ntqD5XfCjsj5BrXI92DULaKFsiqtZdig=;
        b=Lp9mC3D/4MTatIjMOX/8/vARWM43daeQZnQwNRUF3TZ2YrHw4evg6ksvdRevbxTvUC
         aTEXvtNzGeNd5TvNcD9aOddggcTVGD7dUJ4HHxcxdmXvmXRZpDGfvKRw6TlgpODXWb0I
         7NqP8R3CcABVBccOtjHhCBq07k14/pTcwQecwbHJNTPwdkIoY5AmZ5h+eyS58VtVpkVx
         kX6xzYGUgSzi7T3DoKg6sibYNHZoU84hZJWuuAC3+tUDiKPebY2dT4fyax9PzcXxWv8q
         SF66UnQQkeYXrZMsz1EEu7w+ebTRvRFj2o0o9muxi8v+ZrP7RHLCKltBvdc8AEW4Gw3/
         4Y8g==
X-Forwarded-Encrypted: i=1; AFNElJ9danV6/pWeM24kEPmu/ynYtQxv/uAm4SbyrZ+d57OGcN0djyalmrr6zQlHX+pPWl9qORvnKPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYif3dC8Edwgxug0AUl9jhAI5ySWfikDwoBjr2czWzIGFWtE/
	TtBump0N4iEsrimBPgM1SydeA1dfB/emOqJukZ6zjLFCppeMU1qZdRXf
X-Gm-Gg: Acq92OGfB7eAP8RYriq/xIoBSokz4IHNkEwU8zb7RT8uT4n4BNzFVxmaY7p/W76os8+
	Pax1msoIn83aGIOGaLY8zpQ++Gn5mlidqFchTTrajJyBo8h/uheXmU4Nn4PbAAjnvsdpwqsFXB8
	HeQwaEIR4OVkSnoNk5XQSvhh6q/z9S2ytX2A80apRwYwcC9YDHDVMKZ7br2F4IBBNAYC+mmlFGn
	nw5tlm9NE9i0CeY67DNn+Kx+/IEfi/Dt0V4o/n+HqZI8ivg2E21azShpmLseG4VNo6NY1z3Zctk
	4uoIbzlbYHI07YlWHhZYnLIlzrCf/oLoeuq3SrI8bgoAxvLGX1qlk9mL7ZYymulz/hYGADp9YEC
	hI+SduNgDp1l/4k+bXTQsPLMUFs93JcV1EbdDoR29gDq+nxWHtQmSmDmB6K8xpa/oxJvxO+O7u0
	21DNLH9M4DYDnXS+fuYI0ZvFLUbpF+6WNuFuUxe8Rcbi2ZRwEFI56UBS7emKjpwW+z+OrnxUrgX
	udIzJLMVA==
X-Received: by 2002:a05:600c:6d83:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-48fd635966cmr220810435e9.10.1779111950817;
        Mon, 18 May 2026 06:45:50 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm18927466f8f.27.2026.05.18.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:45:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH RESEND net] net: airoha: Fix NPU RX DMA descriptor bits
Date: Mon, 18 May 2026 15:44:57 +0200
Message-ID: <20260518134530.3683-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289078-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nbd.name,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A376A56DF4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In an internal review from Airoha, it was notice that the RX DMA descriptor
bits and mask are wrong. These values probably refer to an old NPU firmware
never published. The previous value works correctly but it was reported
that in some specific condition in mixed scenario with both Ethernet and
WiFi offload it's possible that RX DMA descriptor signal wrong value with
the problem to the RX ring or packets getting dropped.

To handle these specific scenario, apply the new suggested bits mask from
Airoha.

Correct functionality of both AN7581 NPU and MT7996 variant were verified
and confirmed working.

Fixes: a7fc8c641cab ("net: airoha: Fix npu rx DMA definitions")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/soc/airoha/airoha_offload.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index d01ef4a6b3d7..7589fccfeef6 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -71,9 +71,9 @@ static inline void airoha_ppe_dev_check_skb(struct airoha_ppe_dev *dev,
 #define NPU_RX1_DESC_NUM	512
 
 /* CTRL */
-#define NPU_RX_DMA_DESC_LAST_MASK	BIT(27)
-#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(26, 14)
-#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(13, 1)
+#define NPU_RX_DMA_DESC_LAST_MASK	BIT(29)
+#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(28, 15)
+#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(14, 1)
 #define NPU_RX_DMA_DESC_DONE_MASK	BIT(0)
 /* INFO */
 #define NPU_RX_DMA_PKT_COUNT_MASK	GENMASK(31, 29)
-- 
2.53.0


