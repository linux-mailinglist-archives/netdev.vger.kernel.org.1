Return-Path: <netdev+bounces-115508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FADF946CAD
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 08:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B071C21327
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDFD531;
	Sun,  4 Aug 2024 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ys3DwchW"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF5AD59;
	Sun,  4 Aug 2024 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752503; cv=none; b=QQ7W2re8AnkmBoRKBveSmeA1HQl+CTJuAm79C199zNkdUBe5fKl3UDJRaFOtDsGMOlGduJS5ix3bM/w6/XJE9RF7M4H1cNRxEIwpPQ72iEA+kszvYsF/5d9a+1uuZrWcqk2R5MT9Jimo/t4p+lrRn61FyKvz0cv7Q9fa/AKu9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752503; c=relaxed/simple;
	bh=oURTL4z7EwTZ+wwgMJpvnhXRloDEhni/d+4fvczDmFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDy+mUyRwdr3XcFDtOv9ALghpn4VBz/GiiR8Rct2wYBI3FbstTTDyX9p4Vl0nnwe7seOqHs4+M/YMj8Bgq2WHQoRJcLr7Q1d2IXOHSGqG/vdzLyLZiiknPbnQzpUENKErgEemu4oC/XUImAXe8e9a1dAOZ2bnVF1yB/qF0w1D40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ys3DwchW; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id aUbMsJNvIHEYLaUbMseFez; Sun, 04 Aug 2024 08:20:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722752421;
	bh=XhsuUlKPKCQxLvLuiaDj5BLJuAdn0Jr06e3Dg3PwYzo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ys3DwchWGhwFiD1UbkMxIm2Np12uIUujKaV7JK4NrRNl/vgoZmWDCVL4O24V4k5Y4
	 ExRIhS+qcsy+/ktEgA0Ajfi8pV8hmD8cM3jH/s32cdMmMEJU2x2oELCvvbMG13j79n
	 TJeS3q1yo99xsH/MPvN+B0EHXkLyVTbEhccDOvzp81ZUqwrvaQo8EN9CKzvLvjGUf/
	 Jix3yYgZH1mC9Y/xpFB3sSuQE4deIWqzx92xoEtMay2zvOk4LR7850zMxAlIMNZ6gZ
	 tZHd6E9lx5BszDLHJmcdLLshGtTTa5lLyGcSQ3pE1MTm2dkm6ME+pn1MlC3RfS8Rrt
	 /oid708nTux1g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Aug 2024 08:20:21 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] tcp: Use clamp() in htcp_alpha_update()
Date: Sun,  4 Aug 2024 08:20:17 +0200
Message-ID: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using clamp instead of min(max()) is easier to read and it matches even
better the comment just above it.

It also reduces the size of the preprocessed files by ~ 2.5 ko.
(see [1] for a discussion about it)

$ ls -l net/ipv4/tcp_htcp*.i
 5576024 27 juil. 10:19 net/ipv4/tcp_htcp.old.i
 5573550 27 juil. 10:21 net/ipv4/tcp_htcp.new.i

[1]: https://lore.kernel.org/all/23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Changes in v2:
  - synch numbers with latest -next

v1: https://lore.kernel.org/all/22c2e12d7a09202cc31a729fd29c0f2095ea34b7.1722083270.git.christophe.jaillet@wanadoo.fr/
---
 net/ipv4/tcp_htcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_htcp.c b/net/ipv4/tcp_htcp.c
index 52b1f2665dfa..81b96331b2bb 100644
--- a/net/ipv4/tcp_htcp.c
+++ b/net/ipv4/tcp_htcp.c
@@ -185,7 +185,7 @@ static inline void htcp_alpha_update(struct htcp *ca)
 		u32 scale = (HZ << 3) / (10 * minRTT);
 
 		/* clamping ratio to interval [0.5,10]<<3 */
-		scale = min(max(scale, 1U << 2), 10U << 3);
+		scale = clamp(scale, 1U << 2, 10U << 3);
 		factor = (factor << 3) / scale;
 		if (!factor)
 			factor = 1;
-- 
2.45.2


