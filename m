Return-Path: <netdev+bounces-109734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4C929C9F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890C81F215CF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163D171D2;
	Mon,  8 Jul 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2z+naOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC218C36
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421907; cv=none; b=FrFtmcwbh1j2V0nTOG1Wgtzhyh4qqCtrhi8ESXoQpvKVz8vGL3QXkIk9SZO7Lbj+jHcWd680ZIb8XSk1V0qTHGFcR8njm7OpWJIuffKtERbb5Efcr/S9+bMC70RsJgvxEnwY3VNCpMgOHn7EwJaS3Gn6S8Hedu09jNCg57HQXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421907; c=relaxed/simple;
	bh=w6n2XtZAbd4uA+APTTv+2Vc+iMaH7gJW+4J7RHH9Ljc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRJF7yS1CxEc/tZShftaUmWyWjcVr2MzOaPcjz1hdRBrP0evws4urIr0V1kqYeUSbpjKiVERY+ncKEuhwsQPs1eiA4cOnZoOZyOIHfpSppD1zvs+ZmtWCnpLR2jnyWaUgsI0RHtV9j6uCTdrw4FSnzyBjvkwAIDb0aCsSj3hecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2z+naOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F484C4AF0D;
	Mon,  8 Jul 2024 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720421906;
	bh=w6n2XtZAbd4uA+APTTv+2Vc+iMaH7gJW+4J7RHH9Ljc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2z+naOul1WKYEbyb8LXpBILJA11i+RGM4RUMIk7SoZc6qtxHenOU37uq9NzFMA5F
	 71WdyyGc8oZICXPjp6/0+57N89f7SlilUiGUckzE6kISuscuc3xakQZt8A+ga6gRok
	 Y3S+UVd4UslEHzcHbdI2afimoqM/oxOBjzvpG6EuZReNcwYnjLO4AnG7T/Cko1Mz0x
	 dQbNWzXSaUbuCNrDBGOPaGOqsfTP048IsjgUzX7XSuoKnnlsJ1IBi6gZ4s/ZWc8aP0
	 zo4GGo0Ey1RnizXAFmEg4KFdCVaV0EDw0mtsnvl8bBNX0Nzljvy6H9YqIODiN/5P6b
	 ixREWEyzZ4tZw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec 1/2] xfrm: fix netdev reference count imbalance
Date: Mon,  8 Jul 2024 09:58:11 +0300
Message-ID: <7496160665a6e1cbc93bded06c4bcc31d595e6a2.1720421559.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720421559.git.leon@kernel.org>
References: <cover.1720421559.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

In cited commit, netdev_tracker_alloc() is called for the newly
allocated xfrm state, but dev_hold() is missed, which causes netdev
reference count imbalance, because netdev_put() is called when the
state is freed in xfrm_dev_state_free(). Fix the issue by replacing
netdev_tracker_alloc() with netdev_hold().

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_state.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 5249c3574bb3..bf7904edd2fb 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1274,8 +1274,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			xso->dev = xdo->dev;
 			xso->real_dev = xdo->real_dev;
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
-			netdev_tracker_alloc(xso->dev, &xso->dev_tracker,
-					     GFP_ATOMIC);
+			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
 			error = xso->dev->xfrmdev_ops->xdo_dev_state_add(x, NULL);
 			if (error) {
 				xso->dir = 0;
-- 
2.45.2


