Return-Path: <netdev+bounces-253552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCr2MBihd2kCjQEAu9opvQ
	(envelope-from <netdev+bounces-253552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:15:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDC8B5B1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DDE23004414
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242134B1A4;
	Mon, 26 Jan 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk0ZESLa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A933C51B
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447699; cv=none; b=kV2dG4sMiwQdsdcEgoMyvTrHN1nIKIyjsjXDJiWTMYtSsaiiEVHsBIQzbNqjb70Z4KM6iZzTb3eGGC6+1wzv7mqaf9MIpbqnTvTrebWaYX6LBY/ZkLOjLhgmB6pekMyFidaeXmHw5ecn95xe9Qcwx5nGWrq1HqhDdlF0zirgUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447699; c=relaxed/simple;
	bh=m7gtpX6JlLNBi33iHKaUJijwhNaqEtEM+3TbX6tlFCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDC8A/yDjwT6xZ3/R8b0v2OdWVQNe+oPlFNeLcjc7r8VIloU3R6C9sTg6wVuYH3IFKdTakzZXMXeSO4cyckRisc/xspczQ/WmlWo/Zdm47+SNhLvMMGBF1TF5adVge2UKuOoKY19WsLQmwBBYaRWjGdk4x+wKFXakq0aOk3D5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk0ZESLa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso19277645e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769447696; x=1770052496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHXVzDDBmvnIJ3lzKbW0IxNth1KaCaSoyXj6yfLdil0=;
        b=Zk0ZESLaWO2nm1K9H7nQYEE7hCZCu0CSw0aqdObwypvMmsOkIy5xxvEiY0LgIGxFnk
         cgpe5ayLD97dLwvsaVsqIl8Ye3U/S9WYXFPbd259yjVtLAz3nGta7e/kRRDmv370SUVf
         uBz3yw6I1Z+2QkN1HoFYz4AMCR0SK1QuvDV6Ck1o/62D5k+O8TLbNPBL/VFJlwUAowvo
         72YURjduAMfBCH1ghNAgELLItizw3BTcPHA3SR5JwBuhZB8pUJL/9C0TrqA5pViIMVuG
         pZJnBg+wupLmdOXphyI4scH04DNFatLOmFsogGqWE/PKLRz3dmRhMKG68BbXmKjeMNCE
         YfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447696; x=1770052496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHXVzDDBmvnIJ3lzKbW0IxNth1KaCaSoyXj6yfLdil0=;
        b=sI0th54d+qUYx2sjatQEENe8xoh3xdHrsRX3aWB4I6x7aO55vzVigcHe7fy0nemDUu
         POrOaioGUrIZe7lxYPaYvOT8HkubJBlA+OTgPrUk4znRagXOBljm0Tn3HhH1jR8h5+Aj
         mMy6owibfxdQwZjbVTZp6JyRDlXW+TtfWcQ9cpdn4q5YZb0DNACl22/GEndVc5lP0h1n
         v6O2YlPxqJp+g1GiGzYbw8wSGrZIlBeA/HgwnZFjOLuwXbyphmoIj99lZbLX9ezH2tU2
         C1TPPJ1nnQPXwqkOpGaK3uAUI3O1KVhEYSe65bgZDkNuoqsf0Sk2zOVVioEtDGhAMyj8
         tOlw==
X-Gm-Message-State: AOJu0YzsKrPwgaJIzm2Rauariq9ITntQJruGRbDEO/zPCuIJyXxd/Wbu
	PE0fgGNWgpjxMlkNqsf2ECT3EAC1YH4VoBhuVWqhN8FA75yeh/KSpTwO0BTkNWcInQ==
X-Gm-Gg: AZuq6aIvhT9SACw/NOJMAVOdU/9LKJ5sk3rrG+HnD0AQ94cR2SmMHbzpWg+m70KSjAO
	mSVPlS46O0tI6F/3w9NbetVn6om5jgmnJNBgk4AZdPZx06PAT+Xo+cIhe3132hFCF7YHm2WnK7C
	jWYO8Ebl5zOPHswtqyI90XwhRluE0Z88S9VrSGwbVoNprYodb0puFskjn8vCCkDsep1+aymIdtd
	36HvQ8noCj3ImmiyIPy+qGQT7LYik/0+jHTqNFmPOhZkNgkNoBxZ3c2krCjByfn934UG4lns3tU
	AfmCZ6s7AMUsMKR4tLrJG5Yekj7P6Gr/yXWzAaY4JPeFW8rbCeYAcShl6nrBqsK3N0fxiMD/UCc
	1QaouAPbGzVQvD+LetVw4c5l7TRpNQ77tQ4FgUqq343dH8YElS+lTYcqaV4okzTCmaRb7eQhVNp
	/MLNHC
X-Received: by 2002:a05:600c:5395:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4805cd40961mr78662845e9.7.1769447695886;
        Mon, 26 Jan 2026 09:14:55 -0800 (PST)
Received: from localhost ([2a02:169:c21a:1:5aa8:4ea4:a58b:fc48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066aaf30esm3136815e9.0.2026.01.26.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:14:55 -0800 (PST)
From: Tomas Hlavacek <tmshlvck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Yixun Lan <dlan@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Tomas Hlavacek <tmshlvck@gmail.com>
Subject: [PATCH net v2] net: spacemit: k1-emac: program frame size registers for jumbo frames
Date: Mon, 26 Jan 2026 18:14:49 +0100
Message-ID: <20260126171449.83288-1-tmshlvck@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126135919.77168-1-tmshlvck@gmail.com>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,iscas.ac.cn,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0CDC8B5B1
X-Rspamd-Action: no action

The driver allows changing MTU up to 4K via emac_change_mtu() and
allocates appropriately sized DMA buffers, but it never programs the
MAC_MAXIMUM_FRAME_SIZE and MAC_RECEIVE_JABBER_SIZE registers.

This causes the MAC hardware to reject frames larger than the default
1518 bytes, even when larger buffers are allocated. Frames exceeding
the default size trigger jabber errors and are discarded.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Cc: stable@vger.kernel.org
Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
v2: Added Fixes tag and Cc stable.

 drivers/net/ethernet/spacemit/k1_emac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..31b1bdb2827e 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -228,6 +228,12 @@ static void emac_init_hw(struct emac_priv *priv)
 		DEFAULT_TX_THRESHOLD);
 	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 
+	/* Set maximum frame size and jabber size based on configured buffer
+	 * size.
+	 */
+	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, priv->dma_buf_sz);
+	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, priv->dma_buf_sz);
+
 	/* Configure flow control (enabled in emac_adjust_link() later) */
 	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
 	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
-- 
2.52.0


