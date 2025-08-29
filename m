Return-Path: <netdev+bounces-218077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C4B3B064
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7732B58360E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FCB20F08C;
	Fri, 29 Aug 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skt7vIBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2720D51C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430596; cv=none; b=e0Nr9NgtRlrpiLpS8gRS8oyP21l/zfRUyzGiRfyqj/wedMKItNxEsRX1DMa1Ena8XjOBoY8icfv8v40I1jIIleV4PlD5r0bTVE3o4PQDYRhfTxfyjVjWMvCrZLv48A2zWt/ME01gsCWanjBmcyHIfR4IGLOEazfBomwXXPmQmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430596; c=relaxed/simple;
	bh=99MljO3wALEyR1+PuxKTzvSi/oPtgMqQvzBUaERC0Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb8AFSo5bEi4g6cNwSN9TXVdXlZ+N/ZZcWpMVqbrSNSZ3afADEmzAV+lAf3JbyLCnN9zAAediVqSEJm8Rdns3E8oDAHM23xrNIMb01RmrHg1l7DIrMf9QQB0+r5mx6hT+gwsJobyb/ZmI9PuhTSxlxdnsCDQj8XS23XLjxUKNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skt7vIBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ED3C4CEF9;
	Fri, 29 Aug 2025 01:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430596;
	bh=99MljO3wALEyR1+PuxKTzvSi/oPtgMqQvzBUaERC0Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skt7vIBGHbyxvuas8HJyhH1HaFoqF+/zkZArnY1ElPVo2V3yWHfrXRylzZteqswoN
	 LrryQakYEYrVjXqm6+Tjt6SzCtE5O5KBPKT5wuAdSoOByhdLxBGtQHGwdGvO1vAfei
	 7GB5G39NB5f3ClYOKYGgutR8Nx0lcsbs7QXEJprn79BgYkaSsWFvaA3QCy3hEX9lFC
	 7AsDb2dlNjrus4RCP+8VFYXA1L0bWLI1aZJ/7OX8KWpObSIExrOzaIuvlr4xLvbiWf
	 /Mlh5wxKFFORX+e+yFDRKSKF+6YDBLg1QgJxS+LY62QNa+OgC9103YQc4qk6LS/7Id
	 BX8IVdgUa7ctA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 06/14] eth: fbnic: split fbnic_disable()
Date: Thu, 28 Aug 2025 18:22:56 -0700
Message-ID: <20250829012304.4146195-7-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out handling a single nv from fbnic_disable() to make
it reusable for queue ops. Use a __ prefix for the factored
out code. The real fbnic_nv_disable() which will include
fbnic_wrfl() will be added with the qops, to avoid unused
function warnings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 46 +++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index dc0735b20739..7d6bf35acfd4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2180,31 +2180,35 @@ void fbnic_napi_disable(struct fbnic_net *fbn)
 	}
 }
 
+static void __fbnic_nv_disable(struct fbnic_napi_vector *nv)
+{
+	int i, t;
+
+	/* Disable Tx queue triads */
+	for (t = 0; t < nv->txt_count; t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		fbnic_disable_twq0(&qt->sub0);
+		fbnic_disable_twq1(&qt->sub1);
+		fbnic_disable_tcq(&qt->cmpl);
+	}
+
+	/* Disable Rx queue triads */
+	for (i = 0; i < nv->rxt_count; i++, t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		fbnic_disable_bdq(&qt->sub0, &qt->sub1);
+		fbnic_disable_rcq(&qt->cmpl);
+	}
+}
+
 void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
-	int i, j, t;
+	int i;
 
-	for (i = 0; i < fbn->num_napi; i++) {
-		struct fbnic_napi_vector *nv = fbn->napi[i];
-
-		/* Disable Tx queue triads */
-		for (t = 0; t < nv->txt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			fbnic_disable_twq0(&qt->sub0);
-			fbnic_disable_twq1(&qt->sub1);
-			fbnic_disable_tcq(&qt->cmpl);
-		}
-
-		/* Disable Rx queue triads */
-		for (j = 0; j < nv->rxt_count; j++, t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			fbnic_disable_bdq(&qt->sub0, &qt->sub1);
-			fbnic_disable_rcq(&qt->cmpl);
-		}
-	}
+	for (i = 0; i < fbn->num_napi; i++)
+		__fbnic_nv_disable(fbn->napi[i]);
 
 	fbnic_wrfl(fbd);
 }
-- 
2.51.0


