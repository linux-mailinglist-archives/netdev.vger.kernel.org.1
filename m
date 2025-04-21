Return-Path: <netdev+bounces-184463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA2A95964
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A11896E6A
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F722A7E1;
	Mon, 21 Apr 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGpFZgrr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F422A4F2
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274523; cv=none; b=KplA7tquMWm+vh62nrX5DWL6zNOcseBS7YU50gIPBFnf10zNY+gPfPxn2ozluzeOCdD/wETEHC6gkvWR2Kr5W/YQ68cKU0XpZyNUPyEhTRWV3tu3Isejx8WWHsEOFUe4TF6DVpwwsWQ6JaJbpjjuVSYxg1vkjeCwR3JAMmr/qYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274523; c=relaxed/simple;
	bh=l7JLZBAXSLJVRHsayXRrlxwtxuZrRxZ1htrR0lZ/FXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e77tbM4Qw6glDlUdJQmJT7Xt19OQAfg+vUSdHLCKMwYPtK1I6xw8e3OjOCfE4HyaRLkqHqNDq//sT3bxNkQBbYyaqMLoWkqhyXCFOWiaja94C7l4FQOdbYChmdos5/mS8W+kz/AsavvccJDA0kQB+Fq23t5XM2if9NGiBv84UuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGpFZgrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49F6C4CEEC;
	Mon, 21 Apr 2025 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274523;
	bh=l7JLZBAXSLJVRHsayXRrlxwtxuZrRxZ1htrR0lZ/FXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGpFZgrrsRrdX/yLL+vonEcoblohGgub+DAVTnx89b85yZfvALe1NjwEOWaWwr4Qv
	 jKV2O71N6NeBKhhzyc0mNc2Pg0MCpEOBjrKMLN2ThMyTEJgQApJw2hxkFJByU5g0wi
	 iQ+XNQlKhIeSeIhEKq+F7ez3s5gz0lQIk1PDaFwW9RQDRES7kWEtdWhw4IuuwXLlrp
	 w2pp44CSfkynZfZRQQRIwmWwhnEBIshP0zb+kfdlbBsc0lzE3QznvxQvXJtxO0iuX8
	 vRnXf4vQYk+sGA5TzurGZ794vrArEo9swMrpmejGCgIrQJ4UkmPL6a40MDi4qgfqI1
	 lmXggkSTm0wNA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 14/22] eth: bnxt: always set the queue mgmt ops
Date: Mon, 21 Apr 2025 15:28:19 -0700
Message-ID: <20250421222827.283737-15-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core provides a centralized callback for validating per-queue settings
but the callback is part of the queue management ops. Having the ops
conditionally set complicates the parts of the driver which could
otherwise lean on the core to feel it the correct settings.

Always set the queue ops, but provide no restart-related callbacks if
queue ops are not supported by the device. This should maintain current
behavior, the check in netdev_rx_queue_restart() looks both at op struct
and individual ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 627132ce10df..49d66f4a5ad0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16039,6 +16039,9 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_stop		= bnxt_queue_stop,
 };
 
+static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -16694,7 +16697,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->request_ops_lock = true;
+	else
+		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.49.0


