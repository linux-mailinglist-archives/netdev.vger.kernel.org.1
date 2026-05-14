Return-Path: <netdev+bounces-287771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IbPLNMnBWq3SwIAu9opvQ
	(envelope-from <netdev+bounces-287771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C453CC5E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B68293031CE2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E831E83E;
	Thu, 14 May 2026 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="divpf8Sq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7731ED7D
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722667; cv=none; b=SBXFecmPnyzmCSZkiHB9pLYEjxN4S24xHIdUHhHGk2vmU/J7L/n9Bs1sBudgacnOx5stFIFNSAG/QdzHxKQ977/7i1oTOvCTLE0fk0rDn00hs6RxaV0Ss2Evvt6Z8Yak5qkRltXhHh1iFk89bv8vMLO2rvk+UMv5pkWDSK27FyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722667; c=relaxed/simple;
	bh=zdhzlq+hCZGUwKs1WDO4+HiklAD/YGebTHiQm1EUhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xxzrczwrxv2oSf3DmuOdjeknbq4sDiWPuac74NaOZnjveQCyAChhqv0L53Z3yCSZ+aGGnKctURaXnNJyZqhL8LkBuhC1sI5Kf6vdnGpXLZs0Hto+Zco7W+tsrXZs6Tt3rqJQ/KS8M/g7O0PTdYpm05j4ekjeTIg0JkzXSLs1mPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=divpf8Sq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d75bfb259so49642181cf.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778722665; x=1779327465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvnHZLXtklaLX2hJogKEOeSBdsibxvGmpqRAV5GTCjQ=;
        b=divpf8SqnDewP+6fLSuJk81bagaqe21aAIg3zMyFpvUVY+0Z8O21Xr4h9hPx6syLAK
         vKWxKvyBjL25uN60en/S5lnRdi1xWLMlYrUJwD/Jft21SQgpfYxnsG7+aka1KAP81aY7
         YLA1Ji/KhBsZgwZr7kOKcdJ+/6zm4rgKD8SxchNuYjf/dAAK4h6nVC4FyqaqGOqoGeM/
         hPoX2vm6PKVONaqZCYW2hiudEp1uDWvll9xELcvgvia+33Qz2ENVivoDY0M3bdjVmMML
         2LiSW/TMOilSnW/od9mpPFQ/ryS4IWLY8Rm5TxNkNGSEn5di9O100K0BGahETXQP/rj9
         rKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778722665; x=1779327465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvnHZLXtklaLX2hJogKEOeSBdsibxvGmpqRAV5GTCjQ=;
        b=sDOc5Ss29uPNDIWhAvJYsD3NXxvU4M4WnqXnaVvL93DZnkdFxCGf4kNqM1SS0slY6P
         tPQ6LTHcMWSZ5t6DZ2eh10dDSp7yt+b2dm/CgOupGKAntt0EvzMqMGP3yV+y6u8Z/Csw
         VtKMWzhNgpAG6G+2GE2cSNx2OBo8TZ6ddOnTf9Hzof2S5+54nuCIpF6XtYtz9Lw/vm7+
         nb5l8FcqvAP4kzWGQUmmBN4qs1MOxnBF5z0qEzDGm3ux+9K/ZWuEYUtjD1tk+kYz/q2k
         6ni8Pm7C/qIl3kQvg1nM8FLW65ziZkXjZ0PvnUhz+/6/pWeZvNZ2/RGSkw2/U548fG7i
         KLvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YKyDq+j1uN+EzuFYzbH6KXbLuEM/8H7j2xoSCj1J9RKsG1IPC0KYnlQAG6FhRz7vld825dBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6mrqwX/Jvi/E2O7EYTZBrE6JJCJ39+FisYuJilZswnbRdJv9
	AulJGa80NB1asV1GT5mlEF/61nTEb9ey0xCj9W+5s0ewYWKB+4NP88kY
X-Gm-Gg: Acq92OEB6NO9gbQJU11i8dU7CC506gt45OxnVt49EyMispf+jKAk5IUiCa0255IyePm
	dJf5jGXAPim1hukhqAkhVhXmDHk4GZtiL1prBgZ1Aleo6uaD6UrbvhMTV37IAC5I4MUCintNAQh
	+h25QiDaqk1rwv4nRnxuCmbJy4aO3zZyOrB6Xxqled0k/ftOR21jToI4Yg0y7KLTnNKTDlK3x/L
	qIPdKyhnwPbtAXF2DkccOQ9iQzbatCStQY48gZJ1emNm2GzvMZBnK1BIDCgpzA5HtlJKoug0LCA
	RVVBaurYVU026z9MsrfPbJaj7j+5YrDtm8RCMCi1N6u6ZDneqK2O0zib1FlLKd1pfHiNLEMc1uh
	VRMo4VzDGk1EYGUxyG7zSR5EIq+/hQpCQHnoa7GTJJnOhnSolL5LNG1h+FKwLrTGfB/zj4awn43
	nIXNdjGIq+lggSLsgCQJlIo0/VyUCEu7bxqBrxhdhtq6f3e+RComBzpHjDD4sjDyvqWhlsQDSIO
	xSB9t3wkl5y0J1x2IqQZe21O/hhaU+N6mZQKQNdI2U=
X-Received: by 2002:a05:622a:54:b0:50e:423e:2870 with SMTP id d75a77b69052e-5162ffc219fmr77402941cf.52.1778722664782;
        Wed, 13 May 2026 18:37:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581f1eesm4468071cf.25.2026.05.13.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:37:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: ifb: report ethtool stats over num_tx_queues
Date: Wed, 13 May 2026 21:37:39 -0400
Message-ID: <20260514013739.3549624-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3F5C453CC5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287771-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ifb_dev_init() allocates dp->tx_private to dev->num_tx_queues
entries via kzalloc_objs(*txp, dev->num_tx_queues). Both IFB
per-queue RX and TX stats live in those entries: ifb_xmit() updates
txp->rx_stats using the skb queue mapping, ifb_ri_tasklet() updates
txp->tx_stats, and ifb_stats64() aggregates both over
dev->num_tx_queues.

The ethtool stats callbacks instead size and walk the per-queue
stats with dev->real_num_rx_queues and dev->real_num_tx_queues. With
an asymmetric device where the RX queue count exceeds the TX queue
count, for example:

    ip link add name ifb10 numtxqueues 1 numrxqueues 8 type ifb
    ethtool -S ifb10

ifb_get_ethtool_stats() indexes past the tx_private allocation and
copies adjacent slab data through ETHTOOL_GSTATS.

Use dev->num_tx_queues consistently for the stats strings, the
stats count, and the stats data walks. This reports one RX stats
group and one TX stats group for each backing ifb_q_private entry,
which is the queue set IFB can actually populate.

Reproduced under UML+KASAN at v7.1-rc2:

  BUG: KASAN: slab-out-of-bounds in ifb_fill_stats_data+0x3c/0xae
  Read of size 8 at addr 0000000062dbd228 by task ethtool/36
  ifb_fill_stats_data+0x3c/0xae
  ifb_get_ethtool_stats+0xc0/0x129
  __dev_ethtool+0x1ca5/0x363c
  dev_ethtool+0x123/0x1b3
  dev_ioctl+0x56c/0x744
  sock_do_ioctl+0x15f/0x1b2
  sock_ioctl+0x4d5/0x50a
  sys_ioctl+0xd8b/0xde9

With the patch applied, the same UML+KASAN repro is silent and
ethtool -S ifb10 reports only the stats backed by the single
allocated tx_private entry.

Fixes: a21ee5b2fcb8 ("net: ifb: support ethtools stats")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Follow Jakub's review: IFB has no RX-only queue stats independent
  of tx_private, so dump both RX and TX ethtool stats over
  dev->num_tx_queues.
- Update get_strings() and get_sset_count() to use the same queue
  bound as get_ethtool_stats().
- Drop the v1 zero-padding helper and report only the stats slots that
  have a backing ifb_q_private entry.

v1: https://lore.kernel.org/netdev/20260511122835.441911-1-michael.bommarito@gmail.com/

 drivers/net/ifb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 5407d2ed71b3..43aa1bfd41cf 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -211,12 +211,12 @@ static void ifb_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < dev->real_num_rx_queues; i++)
+		for (i = 0; i < dev->num_tx_queues; i++)
 			for (j = 0; j < IFB_Q_STATS_LEN; j++)
 				ethtool_sprintf(&p, "rx_queue_%u_%.18s",
 						i, ifb_q_stats_desc[j].desc);
 
-		for (i = 0; i < dev->real_num_tx_queues; i++)
+		for (i = 0; i < dev->num_tx_queues; i++)
 			for (j = 0; j < IFB_Q_STATS_LEN; j++)
 				ethtool_sprintf(&p, "tx_queue_%u_%.18s",
 						i, ifb_q_stats_desc[j].desc);
@@ -229,8 +229,7 @@ static int ifb_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return IFB_Q_STATS_LEN * (dev->real_num_rx_queues +
-					  dev->real_num_tx_queues);
+		return IFB_Q_STATS_LEN * dev->num_tx_queues * 2;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -262,12 +261,12 @@ static void ifb_get_ethtool_stats(struct net_device *dev,
 	struct ifb_q_private *txp;
 	int i;
 
-	for (i = 0; i < dev->real_num_rx_queues; i++) {
+	for (i = 0; i < dev->num_tx_queues; i++) {
 		txp = dp->tx_private + i;
 		ifb_fill_stats_data(&data, &txp->rx_stats);
 	}
 
-	for (i = 0; i < dev->real_num_tx_queues; i++) {
+	for (i = 0; i < dev->num_tx_queues; i++) {
 		txp = dp->tx_private + i;
 		ifb_fill_stats_data(&data, &txp->tx_stats);
 	}
-- 
2.53.0

