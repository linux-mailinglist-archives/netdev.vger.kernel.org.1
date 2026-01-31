Return-Path: <netdev+bounces-255460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB6MOGYufmlLWQIAu9opvQ
	(envelope-from <netdev+bounces-255460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:31:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B533C303B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 373DB3008D32
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F9337B9D;
	Sat, 31 Jan 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="R0gNYgPw"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD7339863
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877088; cv=none; b=B2JLx7veXwwaBUSqZmghvw7MuH01pyTXQiJme9AfrPpNE5mmZ6bmIg3vMjF7/r+/EvsqPlZZJuC/6MD62obAxcCSKNnsjDcZn+ZVflmTpWMM94ka4afxynzBxGXuJ70OUp6mpFOyrswho9Rc28cuDdqvOje2YAfZhPeNX1k5irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877088; c=relaxed/simple;
	bh=a43fa1uhTuI/L1xsrsBol3ivi+tKmgeZlqR+qM4Maf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDlkzWpRxv8oe1JYJ5nC3Qtft9v/+K3gXFzeYbQDVVotUJC2zuw/yRS5t8Dgzt/vlfREiRydbh9dBfjB8ULIsn1BLzlwlgZVya6WsuPUbbTqALtZnI42Pgfw1ePaETpRKxbKsJvnVBzjaj9RknXlJ6TBsvJhBIrGiepPRV0ptmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=R0gNYgPw; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGVPea039683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 01:31:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=XkB0UJdSADANAbmF+JgfoF3mhihZYqHI6IAIOSB6NXo=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769877085; v=1;
        b=R0gNYgPwNDX86udfeD4kz63cQh1NW/Bf0EwiikmwKatkqDpH0mWANdGGduDG4I3h
         RskNGMdY3m6EvldWEiTDjOMJAkq1zNpkPB+obVQIYn8cMkXjw8fws3F7JuoKJyWb
         G1mvULGGIg0iGbfJuXKeP/2XviLmlwGcYUeCIsOcpMygsQrDundLGcQ5WzO/M0dF
         FKy7y4cQEylE5Mmi0FqXlZ0g+u815aYW9hMJ36WKriHEZktqmhH4JVFyqUUcA6rA
         +CQQLiL5KqzPVVJgUrbDKF2OgKQWH9rawpf6/Hw2BJPuIwZV7qlqihLS7RAK3lG/
         LNkYIYscEgo66BtahAj8rA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>,
        Simon Horman <horms@kernel.org>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v2 iwl-next 3/3] igc: allow configuring RSS key via ethtool set_rxfh
Date: Sat, 31 Jan 2026 16:29:38 +0000
Message-ID: <20260131163037.88108-4-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131163037.88108-1-kohei@enjuk.jp>
References: <20260131163037.88108-1-kohei@enjuk.jp>
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
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255460-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B533C303B
X-Rspamd-Action: no action

Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
RSSRK registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 +++++++++++---------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 661b044073ca..eb5b146f6f10 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1539,24 +1539,28 @@ static int igc_ethtool_set_rxfh(struct net_device *netdev,
 	int i;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	/* Verify user input. */
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
 
-	igc_write_rss_indir_tbl(adapter);
+		igc_write_rss_indir_tbl(adapter);
+	}
+
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igc_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.51.0


