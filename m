Return-Path: <netdev+bounces-214430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38803B295EA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B017CC1F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9A2222A0;
	Mon, 18 Aug 2025 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ez8HcdF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00249221DAE
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478241; cv=none; b=D6sgxGUgkOHvGyanSujzOaWPROah1i9mqpXFajO5C3nNbS+xg8gpb+UPNgcDyjiEZSJWqHFFO5D9iizqU5OlkR8i5/cqR7MNt0oIJPLc0Jz1lA8hxZu5uEdEnHw/bGyxu4RFoH9Y+EV0YdshpUQcV2wiydbrutseDMf/ZJCGxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478241; c=relaxed/simple;
	bh=yO3YC+S/HSL+5FbXS/9QdjNaIiNMqqs/+ffpA5bR1fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqTpVoMpBBqSuBCZLjUeV/jEw+tAkt/pSllQZXHcVYPzfctKvgnqickU48qxoDqQfR7tXgiGkO57vP4i74laN8TkVEC3R0B5TJtiUpJvhRL9IOvz7LJXU25POUQQFp0795bwkrganralFRUrRDg0Cq2xg5WROnaKRIvTTl07/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ez8HcdF6; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a927f38deso18728986d6.1
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755478239; x=1756083039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmjVnP7qpPSN2hUz0/Cxl4LBV3THbWeDOm+1Q3QyjaE=;
        b=Ez8HcdF6HG1XqyPaMK5+2+2CXm9kqs5KTY7ymzDXJf/J8p9uf1KGwhi+3xQEG9IXjg
         obj5ERvpXuZhvuvzNg7NFrh2nW5fweg2MVZKMPWG+06jqk4lGRyYMOIT67KucrLyGKQo
         BGET0AB00A1SZRqMafwXTNYK8D6srm+aWqEis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478239; x=1756083039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmjVnP7qpPSN2hUz0/Cxl4LBV3THbWeDOm+1Q3QyjaE=;
        b=HgAhvCOeZS5p2kxpy4yc05L5AhQ1GM7WEA0ged7dfqphb8KHMm1fxL8z5dXyT9s8bH
         NrYlYf6lwerEwhQ+ZVY2hh1SzKZzAo8mmGrS8uHlWGpOsEtoVvS4ucw84J3KG0J0pCLf
         8L8yLK7HH9qYfvBK7dRdqP/nnl+6sRs+NUSnoCSJmRtFQqkB/jDmecpurm9JYR/5IjCA
         yuLcglumO5HR06BafakMqyuY8O7jIFalEmsLbSUQVTjLWXXStq+sv9TPZxoIUT1zVKk4
         cUPLgEr0TAuu75zeBdXiKneHGFG6uJjIWhPQr+uM0cOEcq1vxhL5C4OPk3z1jxVj6z5c
         zyzg==
X-Gm-Message-State: AOJu0YxfA2GeIDkO6xCa1GcM2hMZDaHvhjX6dz9hYWHsUr9R/B2ggYmT
	S3UsjHyqIWXvanIv1ITG3NUKYydHFOzi2ha+KRXdiBFRoMdKXt4NIi8Dl4gc7yEpoQ==
X-Gm-Gg: ASbGncs/+3sCqBnEvujhSbUxmdqNTjzh/Si7Gy3AuctImI8bgL6VUcOIf5Ig38ht/EU
	W5Y29Q/2tiX9/fg/s0QL/kfzaslEq6dyV54gIT5lxelm3XKpizzd3jayFf0aBZpt07JzawWaKMJ
	C6788/1csL6LT/wGHVT/Z1TKxjP1TZsbnwbazZfNAl/hJv0wxmSmXHj+Gw1hl6oDyTlLjWqZqRA
	/qOPzy9tDq9qD5uEI0HnIhDWwgsewP2CP5HzHzeUDUIje1BvJCH24lilew96Bto9AmKdKERPdrk
	fUirVs7liyvR/78A+ZS2/hr8UIeFac0KWHimW5yiFRohyVpzM8uP+u9DaM4COpAT3dWDwO9mVmE
	fUuM6yjULizTT7gt40is+xnufwIRXo42vkHbPjHmatGS0lfDin48d05j9ix8GQ47Vpg4roxOGcA
	==
X-Google-Smtp-Source: AGHT+IGg9FXPKCpMdY/TdPLKWNW3B91uvNZYmUI5K0Wa4TpuYTgSDukB10Om7B7UO6y6SmLXDrhtsQ==
X-Received: by 2002:a05:6214:62c:b0:709:65c1:f17d with SMTP id 6a1803df08f44-70ba7c016e7mr119823206d6.25.1755478238818;
        Sun, 17 Aug 2025 17:50:38 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm44987526d6.49.2025.08.17.17.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:50:38 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 4/5] bnxt_en: Add pcie_ctx_v2 support for ethtool -d
Date: Sun, 17 Aug 2025 17:49:39 -0700
Message-ID: <20250818004940.5663-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818004940.5663-1-michael.chan@broadcom.com>
References: <20250818004940.5663-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

Add support to dump the expanded v2 struct that contains PCIE read/write
latency and credit histogram data.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index abb895fb1a9c..2830a2b17a27 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2088,14 +2088,16 @@ __bnxt_hwrm_pcie_qstats(struct bnxt *bp, struct hwrm_pcie_qstats_input *req)
 }
 
 #define BNXT_PCIE_32B_ENTRY(start, end)			\
-	 { offsetof(struct pcie_ctx_hw_stats, start),	\
-	   offsetof(struct pcie_ctx_hw_stats, end) }
+	 { offsetof(struct pcie_ctx_hw_stats_v2, start),\
+	   offsetof(struct pcie_ctx_hw_stats_v2, end) }
 
 static const struct {
 	u16 start;
 	u16 end;
 } bnxt_pcie_32b_entries[] = {
 	BNXT_PCIE_32B_ENTRY(pcie_ltssm_histogram[0], pcie_ltssm_histogram[3]),
+	BNXT_PCIE_32B_ENTRY(pcie_tl_credit_nph_histogram[0], unused_1),
+	BNXT_PCIE_32B_ENTRY(pcie_rd_latency_histogram[0], unused_2),
 };
 
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
@@ -2123,7 +2125,13 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 		int i, j, len;
 
 		len = min(bp->pcie_stat_len, le16_to_cpu(resp->pcie_stat_size));
-		regs->version = 1;
+		if (len <= sizeof(struct pcie_ctx_hw_stats))
+			regs->version = 1;
+		else if (len < sizeof(struct pcie_ctx_hw_stats_v2))
+			regs->version = 2;
+		else
+			regs->version = 3;
+
 		for (i = 0, j = 0; i < len; ) {
 			if (i >= bnxt_pcie_32b_entries[j].start &&
 			    i <= bnxt_pcie_32b_entries[j].end) {
-- 
2.30.1


