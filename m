Return-Path: <netdev+bounces-280366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNjQMy2Y6GnVNAIAu9opvQ
	(envelope-from <netdev+bounces-280366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1C44426C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D1AA301FC98
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47473C3BF5;
	Wed, 22 Apr 2026 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp6nUaW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25583C141A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850657; cv=none; b=ki+5Q8b+Gf45Vf5g8Rd7IsalXeakYW617lp4AgqkoZjx7OApxZG+yhjtTA1z0mUoagyT1mxIKXu7J6aYo6ryVSI6DcF4ik/EzpnKl+diMDK7JGNeQcDhv4h49v7p3xtyBqJVPbFntQZeUOUkA4YBjnpO6t+gYigHPE7wYHkVxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850657; c=relaxed/simple;
	bh=assRPxTm8mKLq5gjHIa9mhiSShFLq+2oead/LObDrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dcmao3Lee5VPAsnqdYH4E3+QEZ6ok4E5ySj8VJl5EAXEKw6XTXiaRHC6N1yK1F3dwwswRcqdXxL2zNv6cUOeVXa0pTbru7NlE2olR3TMm7P2ltRH4ig/SMBaCQMFp1azdtOdpnr1yM2c4woLSZ5y6axXxAayC67N4O7CGOVGijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp6nUaW1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8eab809593cso328862385a.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776850654; x=1777455454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gBU1pu8QsPNstduPRfvmVm9CS8+f3Jc6GwFzUDbDC8=;
        b=jp6nUaW1f0iBthdnojTvWI0wBsHrsImaKeoJDA0jrPzrlt/b2DgiWLriunbzNrbBdj
         6SN9uPsITatUHwnxG93AsQYvHjodvl2bq3YUbjSNZQ0XA5GZ2vYMO3hqzJ18M32Gdziy
         bV/qh+OFXxVH5Kr3WgIgH5QOzpfCOlZmf5ElvPpP71C//c+rRf0DMxSSvsrfOZJuVrtB
         5Bb7fCNVTesl4QS/ebvO2Nxji60Px3qet+ARarIsHeZY6y8kx9iP3MvtXImiwxh6S/c/
         1jn8c3pmPZa8vGlASiu2laxmb1vKRHjfChMfmtaspxQRav6Fa49RfzB7a7MKfeutpY6A
         Icaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850654; x=1777455454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gBU1pu8QsPNstduPRfvmVm9CS8+f3Jc6GwFzUDbDC8=;
        b=qnVPIzVlSsujzIxnAhAUqoLxEXW8ePu2AcCF579ahAVwuTCBixN6r7b2PfGHmeOu5Z
         LrIe4+bpvCXFHpXfBywcNWbqt+H6l3kCisJ8NIsm/+NHLGB05ftivMF3rWMdo6IBjejm
         OP6WiDCj2WF1Ocvgeoyxm+t2fkJwPZwchame8nV9yO1K05Vm69cSpsLJytXTzKDy+uUi
         iQ9vjGGKS+oz8Bx0QsYG5cNEPF1hhMDlhSn0MfwjWIoE3Hh816F3JL6LEn8348eMh4SL
         yGwfkI8fdVgwZFNI056SkgVNR9PfSppaN0dfmxOLH90K2DCUGL3SeB8ZYhqGBpppvLP4
         7upQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/FrIR5DBeYqCoBkVkeXyA84rgLM58TiqNZzKmAljBoCWWrbFp8dBfKSitSrwmfL1YOSE7JLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrF8tvXjPQ0JGTriPaY6Hw87fX79ahVtnxX1CMX9SzYohz5IOa
	Gh7Fa9+p2S2QsRYAKPfD5cNoqkhlAwlMdIH3G/ivkZi6i1pFrqQqUVnG
X-Gm-Gg: AeBDiev8hckWfXOlVz865jB2FkwcN4Pv+whOho2sHjB2e5wdo5i6a2yhBA0SW5Qx2V5
	Qi3e6fR3wZeufwTUnyKLkyeIQHIjbOVZnzBVX+ZDD1DuALn2vvBx5YP3qGIyWs6GDtKcf4FVr0/
	sDVVt0QmeJTdIVocPdNQ4AaXGLyb1LfbwYmM5bm3Q+VsD1uh5Da1HoZ1aePAOWnHaZJUspC0aXw
	VEwCrzsmIlXdVnm9GAMtxqDlj/4snWwkS3CeNs79uycsci9VLQ02ZiMlRFg5iaob7venjSI5BNx
	hodTISG7p6giraC7o2h89cg91MVKV+Sacgl937cKSnT4cdV+c754zae6gFF33hFTAXvKh4OwmD6
	cYcyhTn9zHF/LcsZK2FB1t8o86M4hU4bnL7p9dMpB1LNYIOmp2+vH3iR0cZ5S8yICRZqkt+KEHD
	aPsF1eCPv02Vu4twYJTWNOj3FYQTELvzER1G5L/fx9DqPKS2Vb8/puxT0ZpVcAy9CvtILjAxRQE
	DCkHQpgSvgQeNmjU5TwFnu+LqBejWHa7C8nzErcoej3hofNuCmhPlPBPUUEjlXGVIu+quD1VGJc
	RGJBzJtBqw==
X-Received: by 2002:a05:620a:4728:b0:8cf:d441:c7bd with SMTP id af79cd13be357-8e791b8fc3amr3049338485a.38.1776850653843;
        Wed, 22 Apr 2026 02:37:33 -0700 (PDT)
Received: from 2045L.localdomain ([144.229.20.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef1250fe07sm278422785a.20.2026.04.22.02.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:37:32 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: Chris Snook <chris.snook@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] net: atheros: atl1e: use atomic functions with memory barriers for next_to_clean
Date: Wed, 22 Apr 2026 17:37:17 +0800
Message-ID: <20260422093717.893646-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280366-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90E1C44426C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

next_to_clean synchronizes Tx ring cleanup in atl1e_clean_tx_irq()
with slot reuse in atl1e_tpd_avail().

atomic_set() and atomic_read() do not provide ordering. Without memory
barriers, out-of-order execution can lead to concurrency bugs on weak
memory architectures like ARM. For example, this can let the transmit
path reuse a slot before tx_buffer->skb = NULL is visible and trigger
the BUG_ON() in atl1e_tx_map(). This is a constructed scenario, and
there might be other undiscovered, potentially more harmful bugs caused
by this lack of ordering.

Use atomic_set_release() and atomic_read_acquire() for next_to_clean.

Fixes: a6a5325239c2 ("atl1e: Atheros L1E Gigabit Ethernet driver")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing atomic operations used for synchronization.
A similar fix can be found in 6df8e84aa6b5.

Do not change atl1e_init_ring_ptrs(). Its atomic_set() runs during
bring-up before NAPI and interrupts are enabled, so it is not a runtime
publication point between Tx cleanup and Tx submission.

In my opinion, implementing ad-hoc lockless algorithms directly within
individual drivers is highly error-prone. To avoid these subtle memory
ordering and barrier bugs, drivers should rely on established, well-tested
kernel libraries like kfifo to handle this type of concurrency.
---
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 40290028580b..4ac8d4786820 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1232,7 +1232,7 @@ static bool atl1e_clean_tx_irq(struct atl1e_adapter *adapter)
 	struct atl1e_tx_ring *tx_ring = &adapter->tx_ring;
 	struct atl1e_tx_buffer *tx_buffer = NULL;
 	u16 hw_next_to_clean = AT_READ_REGW(&adapter->hw, REG_TPD_CONS_IDX);
-	u16 next_to_clean = atomic_read(&tx_ring->next_to_clean);
+	u16 next_to_clean = atomic_read_acquire(&tx_ring->next_to_clean);
 
 	while (next_to_clean != hw_next_to_clean) {
 		tx_buffer = &tx_ring->tx_buffer[next_to_clean];
@@ -1259,7 +1259,7 @@ static bool atl1e_clean_tx_irq(struct atl1e_adapter *adapter)
 			next_to_clean = 0;
 	}
 
-	atomic_set(&tx_ring->next_to_clean, next_to_clean);
+	atomic_set_release(&tx_ring->next_to_clean, next_to_clean);
 
 	if (netif_queue_stopped(adapter->netdev) &&
 			netif_carrier_ok(adapter->netdev)) {
@@ -1562,7 +1562,7 @@ static inline u16 atl1e_tpd_avail(struct atl1e_adapter *adapter)
 	u16 next_to_use = 0;
 	u16 next_to_clean = 0;
 
-	next_to_clean = atomic_read(&tx_ring->next_to_clean);
+	next_to_clean = atomic_read_acquire(&tx_ring->next_to_clean);
 	next_to_use   = tx_ring->next_to_use;
 
 	return (u16)(next_to_clean > next_to_use) ?
-- 
2.43.0


