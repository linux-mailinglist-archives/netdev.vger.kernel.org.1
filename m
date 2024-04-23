Return-Path: <netdev+bounces-90686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9FA8AFBDE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506171F22BBE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483491EA8D;
	Tue, 23 Apr 2024 22:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103D18B04
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911976; cv=none; b=ZNkPOst1NrFYWbCsmPL0ciWo8E5TDjqNfljhgWVYO5tePoABB9abAfTEdE2oDmx1uSB7UfWRTDiPAxzkVsZoHLYWtAEAkZFldEIPz3hjNLd3y3lJJBAwTOBGC/k+9/Dh5P4ajpgRVxRqQ948m8kQJdshgVoJGFWq1O5QwWRhQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911976; c=relaxed/simple;
	bh=0aAEOOQw/QRRYv4rzeP8/VnxLuD8cae+s5CYJAZR3ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHk13kBH56nFihcufydgD1dz08jNM1Fw5PaEQ/5hGqMrfi8zUOBcrgV3iGn62dS0q7Vw/hmD6nehigLD8PIs0CEYIRjydjhjeqaXv/qFSLt7DdfJiyGhXwOml3sl/DlZQxFs5oIYQRhZ6RNcUZxBGTCzPxL83r4PACJId+lv82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de
Subject: [PATCH net-next 01/12] gtp: remove useless initialization
Date: Wed, 24 Apr 2024 00:39:08 +0200
Message-Id: <20240423223919.3385493-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423223919.3385493-1-pablo@netfilter.org>
References: <20240423223919.3385493-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update b20dc3c68458 ("gtp: Allow to create GTP device without FDs") to
remove useless initialization to NULL, sockets are initialized to
non-NULL just a few lines of code after this.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ba4704c2c640..4680cdf4fa70 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1009,8 +1009,8 @@ static struct sock *gtp_create_sock(int type, struct gtp_dev *gtp)
 
 static int gtp_create_sockets(struct gtp_dev *gtp, struct nlattr *data[])
 {
-	struct sock *sk1u = NULL;
-	struct sock *sk0 = NULL;
+	struct sock *sk1u;
+	struct sock *sk0;
 
 	sk0 = gtp_create_sock(UDP_ENCAP_GTP0, gtp);
 	if (IS_ERR(sk0))
-- 
2.30.2


