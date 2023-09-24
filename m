Return-Path: <netdev+bounces-36021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1637AC89A
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CC5921C20506
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737C613D;
	Sun, 24 Sep 2023 13:18:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7E1FA4
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 13:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B034C43391;
	Sun, 24 Sep 2023 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561502;
	bh=zbFmQ45HpDOudC7crOmoknEiEDeFeWVX6XUc7yFMAUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFY+rDLr7YpEQZqk6gnSmDjAFHmDqK53bLNp1t0MkPQ/Q/aoXhmLeLaKzmdCxAQzN
	 zHKVIuiVJtuvuCtGdWx81pVQ+yPeSv3Rnnud39z757d3jhCHYJ0WKinQ3gtNE1EvhF
	 XUQ1MeMtoVR7GoVOMQ2N3KJA3epkN6VOPZ17KLCG+T/+RMdhYCV3F8WDlb+l2p1JWa
	 7pGn5SXUMDoBBEYVLQajLpWhXtNmVKeLalL/9jmWGjlAdkzUS9dnxcDyW2SjsYcfZ/
	 5QF9AuZ5YjtZvPbK+xphGYHJ4xvokPGpLFE5QclYoqytYNezKYn6wAcBiDaN2rGUyz
	 N3YB23l5WuKqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/28] net/smc: bugfix for smcr v2 server connect success statistic
Date: Sun, 24 Sep 2023 09:17:32 -0400
Message-Id: <20230924131745.1275960-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
Content-Transfer-Encoding: 8bit

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit 6912e724832c47bb381eb1bd1e483ec8df0d0f0f ]

In the macro SMC_STAT_SERV_SUCC_INC, the smcd_version is used
to determin whether to increase the v1 statistic or the v2
statistic. It is correct for SMCD. But for SMCR, smcr_version
should be used.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_stats.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 84b7ecd8c05ca..4dbc237b7c19e 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -244,8 +244,9 @@ while (0)
 #define SMC_STAT_SERV_SUCC_INC(net, _ini) \
 do { \
 	typeof(_ini) i = (_ini); \
-	bool is_v2 = (i->smcd_version & SMC_V2); \
 	bool is_smcd = (i->is_smcd); \
+	u8 version = is_smcd ? i->smcd_version : i->smcr_version; \
+	bool is_v2 = (version & SMC_V2); \
 	typeof(net->smc.smc_stats) smc_stats = (net)->smc.smc_stats; \
 	if (is_v2 && is_smcd) \
 		this_cpu_inc(smc_stats->smc[SMC_TYPE_D].srv_v2_succ_cnt); \
-- 
2.40.1


