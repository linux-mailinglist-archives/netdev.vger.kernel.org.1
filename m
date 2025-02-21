Return-Path: <netdev+bounces-168661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8CA4009C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB51425272
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2D253F34;
	Fri, 21 Feb 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PndFdfOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0E2512D9
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169110; cv=none; b=SeR9ePJI6PCadaoaL+QLfyY2ZfWKx5JMvn8/d8KmShlC5qxaY96dYuhoFlyepB8luGeJqZNPpO4Elr5RmidEpQd5M8Aii9vEb4roQpoZtgy6LsmnGbXxgZThkPxLgB82BwO4Mczor/oZokxyDX4agWA9wvg9SiS2b4Xev6JdZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169110; c=relaxed/simple;
	bh=7jJa2ln4PzIIo9E7wGVgrmzHlI5qVCuI6CfMd0dnF1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3oJCio0R1TEoCDOztBFnBpkn5ezB+iZLBrxhGT09Ga5ohWmsW2R0zPg0j0s+UNWJvfq5kutgFiHFve4jzZmNJOZQbafdcbOTl20I4KmFxSthIgOpEpiJyB0eurSJ6eAJ9UM0H8lp95/W3C03gZ1WgCQi+4Ut8xwslx3QOcG3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PndFdfOw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbc38adeb1so439643566b.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169106; x=1740773906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4tPBFl4fq3J74O0fqXkRaLdAicXpqRuhYbMZkQDopY=;
        b=PndFdfOwO696X2tDbqvUGX9GusE457Q5Svj8fyea5iGjwRUUDkR2l8l/leqU+D+XdY
         qBVD09/CCYaODzx6+3YhsDdWQIcMmRh7fAKnrm+CSC7A9Z6MmYNqcvIO4eF9HiHcg0us
         ru5MH3tGbqTjle++LGbSuO37DM/jphj+5n4gX0ctIGzgD0AwrmoyBMDCjGXzNkFSDc3B
         qKO1O6ht5ggeDSU9sNW9lbOd8J78r93rOLE6thgWiwNSxznDuc6fS7/jeSWbqUkq/C1I
         TKzkhHda+2kzNjTpBMrwrSEnn0q13JWg4QWbMC5kTj/gkSlMChVZgTXVqaxXgefgjeIo
         SHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169106; x=1740773906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4tPBFl4fq3J74O0fqXkRaLdAicXpqRuhYbMZkQDopY=;
        b=UMVh2p3Myt2O/2E3mLlhd0fU8e1F3+UmN5wXlfBZe0z1jQqTUTYPhfc2xR3KvjL70P
         yOIlg4Ygh3C5asPLjgs6ky0EDmdQFW8TicuOzwyrkoqkbrFX5ELyNfPlZ/+uOzhRtm1j
         wImuy72kdiH1Iu4qJkYuk7DwUEyTwxlomG3IJJxTYTFLZqSHS9jQJYPucir+xv06tDZq
         EhYyKUEjmO4UHNgLNYbBBwGlPyEYjTByd/hp2UhESkAWqivz4sQKSHh3RcFDvLNxTrtm
         QF6NxpIqkMpfgSttsYuy7vcBhicXJ9JXDDg1x5af9pwlvpS3LdDHlY5OEcI+2gQf+suu
         dXMw==
X-Gm-Message-State: AOJu0YzZidVKLNS89luoyz//bw2JndoZC++2vsZZy7BuOwdumJbqKR6t
	QIr8hEvP4KIJS535q5O/pv4LFsc4yIjYNJ74yFwJkyZtvQYqa+LaP2VpCmaF
X-Gm-Gg: ASbGnctFL8qvP24e53i7STtcOC/vfsF1MJP2QB7jKvEOks1/jpixkyqWGOtRMsg9fyN
	uC0e+lgwSXhYjp5rzfCc/TrPM+7EfrmdVHDiL1VMU4eDhOiXW06ryzcEGGIPkjCeoRfZxsueXHy
	0m4yiy/GT4Pih8429LI0XOhwuQtQSr2GBFrdvk5mfboaDT4FAWlav8JqfgDummMfqW9vLjTknyw
	DM2Sq4onixattrPuk2WRx7xo0HE3c8Gs7eaaMuMJKjiAor0MrndCOQP6MHwOE4QLWMOr0JurlcU
	eigCZFivio4fyhmcbjjU6LA=
X-Google-Smtp-Source: AGHT+IEF40LvTS9B/Oj2c8gI60BJCbem4DSM3tCmgMNlNEF9Dl0WA/oxvAFBA6uIJPmStVKbjq6sTg==
X-Received: by 2002:a17:906:318b:b0:ab7:87ec:79fa with SMTP id a640c23a62f3a-abc09e44082mr445822966b.51.1740169105967;
        Fri, 21 Feb 2025 12:18:25 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb995d57e9sm1056131666b.57.2025.02.21.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:18:25 -0800 (PST)
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
Subject: [PATCH net-next 2/3] eth: fbnic: Consolidate PUL_USER CSR section
Date: Fri, 21 Feb 2025 12:18:12 -0800
Message-ID: <20250221201813.2688052-3-mohsin.bashr@gmail.com>
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

Move PUL_USER CSRs in the relevant section, update the end boundary
address, and remove the redundant definition of end boundary.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h | 73 ++++++++++-----------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index af6d33931c35..3b12a0ab5906 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -799,7 +799,41 @@ enum {
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG	0x3103e		/* 0xc40f8 */
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
-#define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
+#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
+					0x3106e		/* 0xc41b8 */
+#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0 \
+					0x31070		/* 0xc41c0 */
+#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32 \
+					0x31071		/* 0xc41c4 */
+#define FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0 \
+					0x31072		/* 0xc41c8 */
+#define FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32 \
+					0x31073		/* 0xc41cc */
+#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0 \
+					0x31074		/* 0xc41d0 */
+#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32 \
+					0x31075		/* 0xc41d4 */
+#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0 \
+					0x31076		/* 0xc41d8 */
+#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32 \
+					0x31077		/* 0xc41dc */
+#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0 \
+					0x31078		/* 0xc41e0 */
+#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32 \
+					0x31079		/* 0xc41e4 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0 \
+					0x3107a		/* 0xc41e8 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32 \
+					0x3107b		/* 0xc41ec */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0 \
+					0x3107c		/* 0xc41f0 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32 \
+					0x3107d		/* 0xc41f4 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0 \
+					0x3107e		/* 0xc41f8 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32 \
+					0x3107f		/* 0xc41fc */
+#define FBNIC_CSR_END_PUL_USER	0x310ea	/* CSR section delimiter */
 
 /* Queue Registers
  *
@@ -939,43 +973,6 @@ enum {
 #define FBNIC_MAX_QUEUES		128
 #define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)
 
-/* PUL User Registers*/
-#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
-					0x3106e		/* 0xc41b8 */
-#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0 \
-					0x31070		/* 0xc41c0 */
-#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32 \
-					0x31071		/* 0xc41c4 */
-#define FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0 \
-					0x31072		/* 0xc41c8 */
-#define FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32 \
-					0x31073		/* 0xc41cc */
-#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0 \
-					0x31074		/* 0xc41d0 */
-#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32 \
-					0x31075		/* 0xc41d4 */
-#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0 \
-					0x31076		/* 0xc41d8 */
-#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32 \
-					0x31077		/* 0xc41dc */
-#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0 \
-					0x31078		/* 0xc41e0 */
-#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32 \
-					0x31079		/* 0xc41e4 */
-#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0 \
-					0x3107a		/* 0xc41e8 */
-#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32 \
-					0x3107b		/* 0xc41ec */
-#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0 \
-					0x3107c		/* 0xc41f0 */
-#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32 \
-					0x3107d		/* 0xc41f4 */
-#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0 \
-					0x3107e		/* 0xc41f8 */
-#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32 \
-					0x3107f		/* 0xc41fc */
-#define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
-
 /* BAR 4 CSRs */
 
 /* The IPC mailbox consists of 32 mailboxes, with each mailbox consisting
-- 
2.43.5


