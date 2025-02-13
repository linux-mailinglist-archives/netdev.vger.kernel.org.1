Return-Path: <netdev+bounces-165744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC30A33461
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758C63A5390
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3548632D;
	Thu, 13 Feb 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLbuk7c3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C484D29
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408803; cv=none; b=Gws4oPYGqPBqg8K+GDLGMEZOtobVvAMM7MFe3AMxZ/HYG0j02xkasvMmzEB64RCMNQSv2CmqJVRlfBPD4I6zat/2kSKmMiQy6K8RQriz5v8JQXlESZQcOgCHpJ3zZAWAUJt64yloqb/Jh10e0LqMqPbjVf8jPyuHrThoa29Ruwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408803; c=relaxed/simple;
	bh=BnfEtkuSRakxY27SXHJr8MvG2/eU/7W7dexHODJa/pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkECT9eG+BMJQWNWegyvq6scQGw9pG3wjz6yyj1x4hVcwJCybOr7AmkZQADkH01X0FvkUF3RqJ/fLyPrUR/cAtMRRdTCxePJ+gU9zh+msqP46niogJkikFA/q4Fm5X2DBwrY5Xjo0LwcZS0sFH5MYsTUAWqpZMFPyzC3R9FVjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLbuk7c3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152D3C4CEEA;
	Thu, 13 Feb 2025 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739408802;
	bh=BnfEtkuSRakxY27SXHJr8MvG2/eU/7W7dexHODJa/pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLbuk7c3enOn5VvueHigHRg/KYeHdtXSAnXGipfIC1Mwsqs0/G6wIis5wt34bBVeE
	 zaFvHy5uPDNQ6Vcs7REbgeVNypdFcBwD5RZO8Cmahfbg/hJMIIUY8yodpNTN6dLW+d
	 6F/bySgVEsXTHN6jiw1drfl/Gna3jcARKqWaHXBkfoLyO23GQPMOMnh13yeHGPsU8K
	 Qk434RSYRnRcECC3owcY0S3o9x2Zng5gtIJz8qtow+PuWEyT91oDRXrbZIb+bbq8QY
	 kD/JBT9e2mlX2uGR0zTKitIMXSrSyqvYb/hQDL92vB6zgxgtWXNdQvZxlyF/1VUpFK
	 VwBf5TqLcrvrA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: tariqt@nvidia.com,
	idosch@idosch.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/4] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Wed, 12 Feb 2025 17:06:33 -0800
Message-ID: <20250213010635.1354034-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213010635.1354034-1-kuba@kernel.org>
References: <20250213010635.1354034-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4 doesn't support ndo_xdp_xmit / XDP_REDIRECT and wasn't
using page pool until now, so it could run XDP completions
in netpoll (NAPI budget == 0) just fine. Page pool has calling
context requirements, make sure we don't try to call it from
what is potentially HW IRQ context.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - clarify the commit msg
v1: https://lore.kernel.org/20250205031213.358973-3-kuba@kernel.org
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 1ddb11cb25f9..6e077d202827 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -450,6 +450,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.48.1


