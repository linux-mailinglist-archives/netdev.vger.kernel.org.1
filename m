Return-Path: <netdev+bounces-284367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KYeGNTk+Wn2EwMAu9opvQ
	(envelope-from <netdev+bounces-284367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:38:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BBA4CDB02
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EF7730B7717
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527A42E019;
	Tue,  5 May 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCL3nz+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D63B7A8
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984406; cv=none; b=Rrtd6WHkAx5tIfoo7GxQOk6Kkv1u7X3bQI2+JwVvy6MvS8VVMKvUZxkmPip0Q7wYFWrarXJ0W3tLGWmKwhB2PhlIxSvxC2aDa2inrf2k0bowqjQ0p4ml6w3ZsQa6OfOo77OBI+c45VrxmBE0UGsfgu5A9g+n4NO8FA+vsO2NzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984406; c=relaxed/simple;
	bh=y3tW/Xv+dA6fK9zbbtZuPIX3+JTpxgxF57IG/or79zM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bzk5osMK9fr9Il5wuO+694WkXRpGw84xwx2VorXb7i6Nd8dA2sNa6m84q1AbAGh8AvSwo4/w2mvRhQ5W1kSyPAE4Gn5SmkAqkoXuvhKSk6bQ5yWdb5PmA4uorIgjjMIqYtUcrQvYK5vDVI9YWLmAoI1Fw0HFnYeL20TFel9dww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCL3nz+z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad617d5b80so31016835ad.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777984404; x=1778589204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvEm19d6uRu2W3J0XJxAC912UPvSOn8nmJ7XsYfi08Y=;
        b=SCL3nz+zjo3/UeiHlEDRIj7dDByjBjyN/y79R+tK9kjDxE+BZOKQL+ZgpH3BeX3HWP
         H+CYp4Mh/ex9cIxCeqCeoX1hwzcPHYwE9k4bJ1Bk/XOAjI0T0+CwHEEXLDvIEGJtpTqJ
         6hapmV/bZAiyylRGl3RrlaSlS8cmzFDQY7ayttFVUnQzuRxOuehGJXlGqH7JaXV2bneI
         WRikYhH798nq/nwWnC67cBmNmthHMTvR/PC+b5OPoPt7ILsjY2P2qnKvCqnR+eFsfUFM
         sjgL5ZAxNh01T0iRS+PqP9Y3goQm47jyPnmsDmCE6ZihxD9Jw8KDqKriFVMJ3uvz8paZ
         US8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984404; x=1778589204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvEm19d6uRu2W3J0XJxAC912UPvSOn8nmJ7XsYfi08Y=;
        b=Vg6fdkC38mugfKJUPvADrIFfM0RciWote1zmpx+igx5EFIfMLI70Mg1DtAAUlWJGpq
         QJs+NFPJSFC7jBYoOHuKTdqttJSxgspZPYs8tIdw0M5c5CzYU0zl5jJvsA38gwMk3NrO
         ZhODze7xW3SjbNTBiwhvffM8BokYMa++6+4S0inCSLeaXTjH06MUNPzq7r3ZUWR94eYu
         +gBA/rrLdX4JSH5uGUgClzblyWoYt2N+iYkoOoLQnHrC+YTfE9ScyZOMPJHDo7Ul97BF
         HD5pbvYveVz/aHhDNw/fgidwOo+K6qBhy0R2dxtXn4jd5+d4x1lOTtjDLCNWGGx5Wez6
         ilRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Scut8+ZialZgmI6i/NJK50kS13frlB0Cxl+a50UciR9Dk8+oBzC+fhGivrT7cFG1tvjjMI1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2cklsFZiDKD+0FLsD/Hp1Q3esSF/QvC59y0Pgp1kB3fu83YC
	iHm0/mW0l9AzReyobK+EfW9OSnSgX1BXv2BBQN8QtRpSh/g4hUhTmp6k
X-Gm-Gg: AeBDiesn7uHOcVqrjMlDMyjV9JF/k5+hitp97QSN5PbTGD0Azysv0Ur/wCym7ENmgfy
	ZKPU7I7tvhwT1EiC/2ABunkwxg8vrx1RoiFBcWt7AfKkO3ebVV9QN9bWMBc2SY9YrdxlvDGBTFK
	bXEh3OB9WDY5z7T43RZXk0Gczy/mYhGRhUhjJ68sLK1X67TftV5YawivHqKYmkJ78bN270T7bYl
	mrP52UgK8wBQ/HwnQW6tnSYxHtLbSa+yrKi7QB+a1doH0jzRDmUcf4fQ6bd6J+NbBYMsDoADFLB
	a52nWC79jfyGPNZSXmzqNnBxgrE83mdacyKvAfwKbd4V2DIBtE6VC+NWmoqYeqIATLIbkO/Pb2U
	rHH6jB8CGVz1eW1NNRuTo0gAqG1ebwnDYCGlaCJS6Zs/3oeSBJw2kXEm1VXHXwBw9UZr6cn4lg9
	TI8IqMo9Q7bvMBu7aT/VDiHXMy8TUwhpt/7fz9FAZWsfb32oFdA5blRPu9HbeIM6FsYrNlUSQ7
X-Received: by 2002:a17:902:ea09:b0:2b9:4941:7f6e with SMTP id d9443c01a7336-2b9f256745fmr144236685ad.2.1777984403595;
        Tue, 05 May 2026 05:33:23 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaaf0e5sm138853715ad.18.2026.05.05.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:33:23 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v2] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
Date: Tue,  5 May 2026 18:02:36 +0530
Message-Id: <20260505123236.406000-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0BBA4CDB02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284367-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email,cambiumnetworks.com:mid,cambiumnetworks.com:email]

of_get_child_by_name() takes a reference. The rtsn_reset() and
rtsn_change_mode() failure paths jump to out_free_bus and leak
mdio_node.

Add out_put_node to drop it before falling through.

Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes in v2:
- Restore blank line between `return 0;` and `out_put_node:` label (Geert)
- Add Reviewed-by: Geert Uytterhoeven

Resent as a new thread (no code changes) so netdev CI picks it up
(Andrew).

Link to v1: https://lore.kernel.org/netdev/20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com/
Link to v2 (mis-threaded): https://lore.kernel.org/netdev/20260505085840.352206-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ethernet/renesas/rtsn.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 03a2669f0518..ee8381b60b8d 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -797,11 +797,11 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
 	/* Enter config mode before registering the MDIO bus */
 	ret = rtsn_reset(priv);
 	if (ret)
-		goto out_free_bus;
+		goto out_put_node;
 
 	ret = rtsn_change_mode(priv, OCR_OPC_CONFIG);
 	if (ret)
-		goto out_free_bus;
+		goto out_put_node;
 
 	rtsn_modify(priv, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 		    MPIC_PSMCS_DEFAULT | MPIC_PSMHT_DEFAULT);
@@ -824,6 +824,8 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
 
 	return 0;
 
+out_put_node:
+	of_node_put(mdio_node);
 out_free_bus:
 	mdiobus_free(mii);
 	return ret;
-- 
2.25.1


