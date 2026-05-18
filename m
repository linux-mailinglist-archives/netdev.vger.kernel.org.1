Return-Path: <netdev+bounces-288848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W3hMM2qYCmp+4AQAu9opvQ
	(envelope-from <netdev+bounces-288848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:41:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC44565B41
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8AF30071DE
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9315382F03;
	Mon, 18 May 2026 04:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVPmDekH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86005380FF6
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079266; cv=none; b=H7xA0asd9H2JK170Xc2qbIjHSXDLw7dlAJbaat7mumgFfqTgLh0ePfLRyl2n3I4tla2CQvBVXLU8Ao6yDJs+36X0xy9QwyH11YjmYI1bguqmXnqCStA+tWfPIRotZf6uO8WwhV4UxzS15p1UFx7sLSEB3sAp0mj0IdxZFXkoVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079266; c=relaxed/simple;
	bh=tbEcojhBwPHp3WUd/Fvs/dx1PwA7U85Hi0g6JGxauMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRaGgKFCEu+IhRtm0W04lOPMKRM6yThia7FkVBe50DZlR3OXngjq57zjs/7Jt2z3UshcznGi0AxlEr9Q146h5Hp7KsXG8EwASSx6nkMrJ45ltcsaFl1hDUYobJHj+zRKQ6MHu0EyzZw/21gJBf8B0uZi4W7nCuFjiplO4dd2NWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVPmDekH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c80291e6237so1376574a12.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779079265; x=1779684065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0SLBawiq5jmL6Ad4dYKeXESqY0Fju0c8SolsBJJiag=;
        b=YVPmDekHm5mWVYIkixoQr0zhRwRuePqxLGj5l1GrSue6nCP1fFpf14qHYnfjt+9dOF
         qASkN0UbwPHLan7bMeGNsk5FRCTZzRFAMDtL1gHt30eUZ6/zeHU0FOVUeI7IbD2x8zAo
         NeN+ChJTgqbAE2R8jixD+NNDeNMNUDqDdyqBb8mRzBKMHFsqZmQjYjIvVbTCYnpe5vAg
         oY2fEPXGGuoiB9he/FfzOXdxE8a4cDf/qsb0+4ZTYNRZNXS5I51XNQGZ0ZWtnBlF+IPj
         y135ENRaG0nni3u97SQAx3yCSwCPF7nVLAtCsUNxz1A9o0vZ3DKKduJZYbwVygWUeBiC
         aiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079265; x=1779684065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0SLBawiq5jmL6Ad4dYKeXESqY0Fju0c8SolsBJJiag=;
        b=D0qUXsfLVkspa3RRzC5z7NJx09YiU5EMaBfgNdQoj06jA2bHSiqiN2d2hZY8PvosjZ
         r5KXSIF4tVmPvRglq8KFWqCbDojH7FRnuyjgYkmp5ICvC9sXbZbmZYmLCiYZyES2wvlO
         GiP/aFaLkSjZU/fg8c+9dw+j6EJErG2zmGJ0gnWNj3jQ/vXygOOxxhYJwwx/nclioZVM
         HCR9ziOHF/gZS0xz0gHY616K7Ousxobd/A9zuGc/hUUs5HBEnnZcsSTr56E61PzSEkrZ
         WJmLCD13dUZpaUbgIGBCSa/OgTYJ3h5gdVmbFfX+VUUsBeNITuefOw/1OWtu4yBY5rW7
         UZ4A==
X-Gm-Message-State: AOJu0YwEbLVc2ve2o5XBNKXWe2q9B1Ewtl+OlbkpT5cukVHfhBJkc2p0
	J7TdQhDlpUotD/9R7H0rfppjjptsihY4z3UnLn41mg/ifFiqso8sX62oI6WvzV9A
X-Gm-Gg: Acq92OH1F0kGzrHM0g5IuZOs/T2UZ4rI3AQ1fSP+VsuYUWwLxiEUB0Yuw0mjeUmufFN
	u6YjuBt9PCnJepdlqJKqqugZrQP8osObw30Vx4+oRwxj9oFa5cCOPccEUzQPwZ0Z0yKz2gDusaT
	MCdg8N1gbjuJEWRzPUVQnt7k6D+Nv4V2tkYd4pwIX2H+QdbC3QdyyFIozFhL0cCpuudrnhDHvWB
	cVb4wBRcw5yX80QoDP92rKajH2EV+vYgAgqDXHDfiAZrPw5bLAyBwgbhf2E7Dug+n9nz1Z2bCXN
	egoboWJzQcpAwL1GK8PKFQJCc71u5YT0rvZEyI4wglvPiDBHKLKjlbwaSOvXmvzNJhy3asava2c
	uUeG7RATxga4nFd0RfUWBdQtdBP6rbCzPn/EbVxqSrlHbufz6erdvpQP7+LrVLOO3DIhWaR9LRJ
	8e8pCcMlE0cfNL9blX+6/61C2ptA35DSOgss2Lp90R7u0KN6h7t4h07J3yDYgKsSLyIPI2z6hpY
	7/75SGqpflcC/2X1zDMJkZoGD8mY3WFbcE=
X-Received: by 2002:a05:6a20:7492:b0:3a2:bd1d:d679 with SMTP id adf61e73a8af0-3b22ee02ee4mr14721564637.48.1779079264900;
        Sun, 17 May 2026 21:41:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2b9bec8fsm11286128b3a.33.2026.05.17.21.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 21:41:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Perches <joe@perches.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: fec_mpc52xx: Fix resource size format
Date: Sun, 17 May 2026 21:40:47 -0700
Message-ID: <20260518044047.1002235-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2EC44565B41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288848-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

resource_size() is printed after casting to unsigned long, but
sizeof() returns size_t.

Use %zx for the sizeof() value so the format string matches the
argument type so that 64-bit builds compile.

Assisted-by: Codex:GPT-5.5
Fixes: 31b7720c8259 ("fec: Convert printks to netdev_<level>")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fec_mpc52xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 556f646073af..a770e7edb1dc 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -834,7 +834,7 @@ static int mpc52xx_fec_probe(struct platform_device *op)
 		goto err_netdev;
 	}
 	if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
-		pr_err("invalid resource size (%lx < %x), check mpc52xx_devices.c\n",
+		pr_err("invalid resource size (%lx < %zx), check mpc52xx_devices.c\n",
 		       (unsigned long)resource_size(&mem),
 		       sizeof(struct mpc52xx_fec));
 		rv = -EINVAL;
-- 
2.54.0


