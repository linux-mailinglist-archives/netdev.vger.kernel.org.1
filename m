Return-Path: <netdev+bounces-260333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tqB/IkotnWnONAQAu9opvQ
	(envelope-from <netdev+bounces-260333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:47:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0226181BA0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4126B3013465
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7C13C918;
	Tue, 24 Feb 2026 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="frUwGZ+k"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCA2B2D7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771908423; cv=none; b=FFdoEGpYUBsGBacR+2ozxTNzxclVhrqFf0GucOCWdjWxiqdgMcBcmvtgs4arzUCKlmCNPLgGaWRuGcXwXQs1cXKEQH2G/pH99IxnTWBnNn2JWjGq0POqQTe+OrEMRGtQWVNd0qf+fg3RSWrLaA0xG2avNCScsPKxkTvhavqVhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771908423; c=relaxed/simple;
	bh=XW4RD6vzWMcKLqHd7wq/YGz09SAkSgXlfU/FMWCkO38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olLvlvVQ/ingWhADf4YMlGPaKQMvXv6MbniMPjmTfTJ5emCLg+EsBCV8OB2Ayn2ITfrpvVhG+wpr+IU9jsxXHhOoFOY0XqAwXVoZL+lUvYrADSF1P8iB0+KfLfLrCxkdWkjMwYogGFIFJeq/up5IwtvPWfrJtR8c0V1m95ZUXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=frUwGZ+k; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771908419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ly3Y7DNzQZPjtRKKbAc/5HFD0QRbUkZKgKud6Tgpm3c=;
	b=frUwGZ+kf0V1WhJ3lpxxXr4xGIjn1pYfOyv95CHUAkLWp2dD1j9R3HfkasumjSfFalHwGB
	xSWon3cxT27IOqgrpOVgrlqU5FLfSJTwaScH6WoxiNtdKFN7I09saqkSKsQyhCXwiSVU44
	yGorW9mkyKj301rnsczA22Ke2BaspJw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Date: Tue, 24 Feb 2026 12:46:38 +0800
Message-ID: <20260224044648.243578-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260333-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: F0226181BA0
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
This issue can be easily reproduced using the syzkaller reproducer.

In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
When the underlying VCC is closed, lec_vcc_close() iterates over all
ARP entries and calls lec_arp_clear_vccs() for each matched entry.

For example, when lec_vcc_close() iterates through the hlists in
priv->lec_arp_empty_ones or other ARP tables:

1. In the first iteration, for the first matched ARP entry sharing the VCC,
lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
and sets vcc->user_back to NULL.
2. In the second iteration, for the next matched ARP entry sharing the same
VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.

Fix this by adding a null check for vpriv before dereferencing it. If
vpriv is already NULL, it means the VCC has been cleared by a previous
call, so we can safely skip the cleanup and just clear the entry's
vcc/recv_vcc pointers. Note that the added check is intentional and
necessary to avoid calling vcc_release_async() multiple times on the
same vcc/recv_vcc, not just protecting the kfree().

Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GAE@google.com/T/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/atm/lec.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..a5b80d6df603 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -1260,24 +1260,27 @@ static void lec_arp_clear_vccs(struct lec_arp_table *entry)
 		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
 		struct net_device *dev = (struct net_device *)vcc->proto_data;
 
-		vcc->pop = vpriv->old_pop;
-		if (vpriv->xoff)
-			netif_wake_queue(dev);
-		kfree(vpriv);
-		vcc->user_back = NULL;
-		vcc->push = entry->old_push;
-		vcc_release_async(vcc, -EPIPE);
+		if (vpriv) {
+			vcc->pop = vpriv->old_pop;
+			if (vpriv->xoff)
+				netif_wake_queue(dev);
+			kfree(vpriv);
+			vcc->user_back = NULL;
+			vcc->push = entry->old_push;
+			vcc_release_async(vcc, -EPIPE);
+		}
 		entry->vcc = NULL;
 	}
 	if (entry->recv_vcc) {
 		struct atm_vcc *vcc = entry->recv_vcc;
 		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
 
-		kfree(vpriv);
-		vcc->user_back = NULL;
-
-		entry->recv_vcc->push = entry->old_recv_push;
-		vcc_release_async(entry->recv_vcc, -EPIPE);
+		if (vpriv) {
+			kfree(vpriv);
+			vcc->user_back = NULL;
+			vcc->push = entry->old_recv_push;
+			vcc_release_async(vcc, -EPIPE);
+		}
 		entry->recv_vcc = NULL;
 	}
 }
-- 
2.43.0


