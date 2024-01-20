Return-Path: <netdev+bounces-64462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918083336F
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC8928147A
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD5FBA41;
	Sat, 20 Jan 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dlikXYNv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E29C8C7
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705744573; cv=none; b=UE0QQXipi8RPQ52fpwJz06TrEFjRI8U9LBzuHUevNWRtCnhC9OSDg7lOraxubAnezjTT4h3rSopW77cFrOqXIPDRHutaK8OdBBxFJ0BuiCfU+69ANJJq4Fcpr2Jw5B1hDMv0Vs8FsYArSrJdxng6/MlKQC9BmMiLSSsfCv+FxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705744573; c=relaxed/simple;
	bh=BOcX8KWEnibygk4fjeA6ev0h6FDA5vSRBlJ1zvGoVtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nT990wYiGnldQ9f2k+xvDXdwLavG8MTjfJQV7IUbthF6P9QcowvfD1/XgXFznV9dIDnoETwIzSsAjRLxTclz5S1joK3E3U78F8nApfAcYiyKvQ8eiHEwmRGFs0BmF/joP37SKmnZ4LFubo+T6zBrLekSXBoh62QCNs3RAxQn9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dlikXYNv; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id R859rc6amXxngR859rqY8F; Sat, 20 Jan 2024 10:56:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705744569;
	bh=6/Q426ZzIQUJLm346t0hoGiEGD7EVC/MiQvvpwN1st0=;
	h=From:To:Cc:Subject:Date;
	b=dlikXYNvorCGCI/zMlw+kQotCzT38LYn+0/29+wiIY+D+2X0okIBuyhrqgbaTeGCE
	 MLiREdT44J3NpJ91NyxVIJW5JAzfiezWkZW4GDFgFi821WNWYGUbNzWWzbCRr6ufYm
	 nGRStL1OW06bVoduZxNUjOatbL1M7gBTMsquonPrYmJ8uiWol4sU8cEu5fBOY5BxSc
	 CnCYtDo7by24j06iVPoUz84OMhcVsDts9s9FXWA6xOikHfBwJTEDzltFQsJGbcw/OD
	 QV3w9sOphKFjXX8Jl8b7kqp5BChAZd90U2SLDORzsqRgQMon3hYjIng0NZ/wx1IDUs
	 gSdpIxW6k/3Dw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jan 2024 10:56:09 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
Date: Sat, 20 Jan 2024 10:56:06 +0100
Message-ID: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llc_register() calls pass a string literal as the 'name' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/nfc/hci/llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index 2140f6724644..8c7b5a817b25 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -49,7 +49,7 @@ int nfc_llc_register(const char *name, const struct nfc_llc_ops *ops)
 	if (llc_engine == NULL)
 		return -ENOMEM;
 
-	llc_engine->name = kstrdup(name, GFP_KERNEL);
+	llc_engine->name = kstrdup_const(name, GFP_KERNEL);
 	if (llc_engine->name == NULL) {
 		kfree(llc_engine);
 		return -ENOMEM;
@@ -83,7 +83,7 @@ void nfc_llc_unregister(const char *name)
 		return;
 
 	list_del(&llc_engine->entry);
-	kfree(llc_engine->name);
+	kfree_const(llc_engine->name);
 	kfree(llc_engine);
 }
 
-- 
2.43.0


