Return-Path: <netdev+bounces-166957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0DCA381C1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC93B2E66
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D04219A8E;
	Mon, 17 Feb 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTQP0jOT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzDO0377"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F63218E85
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791894; cv=none; b=TLsOZqS+qGD4IoF5XvpNCLE71EaRFFDSrK4QrlYleBHOqyH2kal2H7X2AlS/9z8c2BcNl3JxB/Yq8FoRb0y30AumZlkH8diVe/hgr3uPw/ueLoGkB8D4Q6iJu8VDm1dqjVaZlAAQpLRq2et6wflsMCEmyKzRGGAfgxeOOJtuj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791894; c=relaxed/simple;
	bh=FN5nzazODH8aG0JG9be7ppb8sj14zK7rOLmT/meFlbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU1roBj1ix5v55+dqrl7mn0op4MAbfqG6rID57Q0HQbaYe4EHJ0HwvagCa7y440f8kdG9Ue8D1l28eg3QS+gORrT+4uAO4we036RSvdGAF6iZ3biMREuFUoDoXapPyaczQzI043UYVelGJdPtNCcSBK+hITkc+QsgUvoFrP6mXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTQP0jOT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzDO0377; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739791891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgl1FMMF39J553DH0zGtOZJgZzZjk2b79cKwl3uaRjM=;
	b=xTQP0jOT3FAFIUVFRYY0tov/5nPsqyVAP65LfWtYzb+3+arWVY5Aq4924ApXm5oCfupZ8c
	30tkhWVg1Q0VUnodVG0ZfazuvL6UzXlfVqqgneg8eg9DAOLkUsHSdF8EPPeqvSe/L/y9KK
	d+gkrt0iyGg5z62ftRDFoYl01yBjKBDFWK/WW23yBtmph8XbE6Nd3Nicz6J0s/riHmLwXe
	4ZwP6x1u4BdJwNIBnE4RnhuOgYpUJLATehCEynF3KWx5TydhwPRkf/zb8qVgdPc/vJGksI
	b42L0CFeghYdS6IohxRfIr/PVmLr1T/q8nnHfxOW4MzZ9NN5EKFnq4mtlGqzzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739791891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgl1FMMF39J553DH0zGtOZJgZzZjk2b79cKwl3uaRjM=;
	b=rzDO0377lbDyzgm2gQraeTTuKmRETs1/tY2jbveowCFSFLFGIAxLXh8XkPuKsFs+MelHe1
	p5DfIHpK2q4YGKCQ==
Date: Mon, 17 Feb 2025 12:31:23 +0100
Subject: [PATCH iwl-next v2 3/4] igb: Add support for persistent NAPI
 config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-igb_irq-v2-3-4cb502049ac2@linutronix.de>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
In-Reply-To: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=FN5nzazODH8aG0JG9be7ppb8sj14zK7rOLmT/meFlbE=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnsx4PufkwRmlz+ht+1rekjU4bU1xmjG5NQOvel
 YirMIH1BeOJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ7MeDwAKCRDBk9HyqkZz
 gjufEACpCNcjX084537zxJtaUdqOdfdoYC+0nGVlpH0xdABtRGgwte/PaXmxgsbQim7QwTizr7y
 8d1Xo0cZADwNR6QjXMix8LGlMSh4nD3VamFCHuMVrBI/rSO/S3DgRZWkrwNr6xzIMuPno61lmnm
 D9mrlY9Ph4oh1fk5OUb64Oqfo7xvR2DQQfR6xTazsdXGSeXYa2TWropzi0F4Mq8zLd/0peVCC0v
 Uwy8/4dXon9AcbHrzS56kXdwmFW93YobxpjeHxBV/ocFkw7VQ9ze0gCwfPrMKEjZQdcBj+ChOQ0
 iObUIub+H8tc08wrfLpUUhpS2mWmBre8VBmL35MZE+tXBeL7x/V0Az57aC0et1Wg7jIyu2XiFub
 kIe9580VVOFUpNjeWKzGCBMNFRVbCiv751SKpy0z4VnvugM0Pd0Xi8pQsxhtSbnwxk4Ns5e7dPQ
 abYEt+ayr2f+zbsb+6laTNBV2+itw8KZYvy5go5j+v1yrrWpYmlH9SejP9kEK0z4qoGC53fUuEa
 GjbIYTXwIvu4xmJnUYsosGnDc3U8wkb4VnMNvvhYehU3ntR3n4dKGl87uwbmcXMQ9BnmVGzpbQK
 qHRZzTFqxiujfToRtf9/cgaepQvegre7iXYH9rrQTdTtBEIcz+lBSPNFWQ4k/dwzWqjnNwwmyxI
 K8fnNRrkSBYmJ0Q==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Use netif_napi_add_config() to assign persistent per-NAPI config.

This is useful for preserving NAPI settings when changing queue counts or
for user space programs using SO_INCOMING_NAPI_ID.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6870803a42455aa1d31f39beb027cf282064388f..054376d648da883f35d1dee5f879487b8adfd540 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1197,7 +1197,8 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 		return -ENOMEM;
 
 	/* initialize NAPI */
-	netif_napi_add(adapter->netdev, &q_vector->napi, igb_poll);
+	netif_napi_add_config(adapter->netdev, &q_vector->napi, igb_poll,
+			      v_idx);
 
 	/* tie q_vector and adapter together */
 	adapter->q_vector[v_idx] = q_vector;

-- 
2.39.5


