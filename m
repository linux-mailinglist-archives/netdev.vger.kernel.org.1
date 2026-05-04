Return-Path: <netdev+bounces-284035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Kx9LfD7+Gmo3wIAu9opvQ
	(envelope-from <netdev+bounces-284035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:05:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD284C3651
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 762633018591
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73D2DCBFC;
	Mon,  4 May 2026 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2XOCKS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D0242D62
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925099; cv=none; b=jV/ja+XqHh0ed+67QNLOAPkxcSzcu6zADauMr6nfamtwbOD7mJetHpjQuraxhVz9V+/KtkoXYW5TK+S1pkyGhql0gmUCbjrWBoBX72viG5pDUUDMdyxQgYmClE6Y7qX9YhR5PmmZ3rU7ZB0uR5Fi/YgN3x+Ns8TZp1Pi3g4fL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925099; c=relaxed/simple;
	bh=9FExhyEXJ4WBPBrmzB7MamfjwiWuLla0OnVKfsSONcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=azt9EdDwKLBB02QHsfyRlegBQNYBSZUnzATc9pLPi69tZCcw2wP0bx7N2VH2rNeThIy3Q5fh55qikb6tnSsneW5SRJXKbIvX995ITRL2yYwLPvOFUSshXCxjFT6s8H8XKSgHzPYpEy8IbGRFP+BLfC07njolmKZKkPS8sWFQpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2XOCKS7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36523acb0c1so1039015a91.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777925098; x=1778529898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/sRxkDkVrRV3H5gNylpkzPThQXe+Qe8Y/t+6Rr0fC0=;
        b=d2XOCKS7dwWVlHah/Rj5orx2VjgSTfgHgi9L/6CQOyxvMSm5NkPm9S82gXhbnIZ/Ad
         8yDtG3Ln3xl/3lAHMlVl7OF6V5LnkmtDrAruOIJS6hSwmGKE4LWg5hOaH7CY2zXGAIkA
         HQ/olcQDRb8iNI4jPMbasHvqpN80tIeLDXfkQhnclIwzKmSHnOCTogXEa6WHkKwR/Hd7
         ff4uP4tFM5J/NZwFsqV+MWNBsvHEi+9HRFJ0t0AWvuPbQE3uAG0YMl5dwV2bWCs2KBn/
         EqvGKhTzNqzRvqGHjXeffB0CM7bF2lGhf8uYOXhoKx2PDkGErJ5nAwG0T0er9Lx/ujvz
         NQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925098; x=1778529898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/sRxkDkVrRV3H5gNylpkzPThQXe+Qe8Y/t+6Rr0fC0=;
        b=qdP5hTBgc5JFEcuC3ffHkvXKiWHeG7xJwthtrmOTSbqNgcLQs/HQo2a4Xk3IS924yk
         tgBmgUuA5WWPp9Ri5R9T3/5eG7NLH3mVSq85dXc2zR/F9rseHfbgdpZYFKxbBZX6KZxF
         z+o73NpngKXfZfzVygn3+GuEW1r7L7i4w1vl9EQgR+UBLU4ju8u9BujrrCcSicpFNf0e
         EKXQR/GrHuoCqkATLd+Q0Dx2XxmRTfXFvL7oEX1v5Ne2DlD6r4uQQ7b2Ru7MNrhhnb1B
         665mhPtEkc8HlQRsuii4PUjxAsM5DOOjdN+wDN7xRwOxvFS/uWEmKj2cmOH4w8lVqwjd
         vluw==
X-Forwarded-Encrypted: i=1; AFNElJ93p5tWmw/GpOulJN64OLUdvjhMB/9RLhAVN1hHKJktMIVtvS+R/7fLcFTBlCAPBkpVW+vWzlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCj9thVUZ33Ssxw2wS6hH0oo7R2tZzmkoP0wC8NjHnEz8sBMB
	tc/tY7VkwHAEZ2kwPP+f1k+KXCBjvRN9RkQQZDW7B1CRW72OVmJrZ+EW
X-Gm-Gg: AeBDieuthUTzANPvSNVVELMhA788BEjbDfIcXjnUnDkqgDo7iD04a2UtesAl8f4FA56
	wJ3ihWbOz/z4knrUQX4o7FsBZODzSVqH/qNQ/fkn0dOvXAJqp9S1e/RCSEzkBVKwIaPN6kx0aWI
	dPTp0C9KORxjbtoee/iQx2iBPgkp6uQIFTzFt/X0uN2S+vdSj045R3MIzmtJdpo7y0EkNaYZyQt
	hK4ul4WvAIVN4MX27MG+ho6bTE5uS3Ov0r2/HiK7X3myUcHCrhaTZdf2dny3kvS4Y3QiWLay8ud
	d9Ed1EQJM5Q3sRNhTl88QMSIwk83HOoeH9mQAVfV/fhP1Had8pXFNxZN6MiNfu9A6kM6SwCtxuz
	nK7wBZjnYrqzF4q0lqH9yoNk8POToqayO0O/NTcXGGM1gREg81iTg1o/CSPjsVlA33FkTHHGYCm
	FX4u3YWNMSMEytJBEWE6AYwng3AD3APQAKoTOoENgNlerz9xQ5F/70oK4ONxGIhw5MyRx/10/1
X-Received: by 2002:a17:90b:578b:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-3657747c6b0mr314095a91.16.1777925097943;
        Mon, 04 May 2026 13:04:57 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm20545525a91.4.2026.05.04.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:04:57 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
Date: Tue,  5 May 2026 01:33:56 +0530
Message-Id: <20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AD284C3651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284035-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,cambiumnetworks.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

of_get_child_by_name() takes a reference. The rtsn_reset() and
rtsn_change_mode() failure paths jump to out_free_bus and leak
mdio_node.

Add out_put_node to drop it before falling through.

Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/renesas/rtsn.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 03a2669f0518..c46d991cceb5 100644
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
@@ -823,7 +823,8 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
 	priv->mii = mii;
 
 	return 0;
-
+out_put_node:
+	of_node_put(mdio_node);
 out_free_bus:
 	mdiobus_free(mii);
 	return ret;
-- 
2.25.1


