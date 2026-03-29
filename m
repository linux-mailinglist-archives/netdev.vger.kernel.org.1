Return-Path: <netdev+bounces-272925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAKMOXw8yWkMwQUAu9opvQ
	(envelope-from <netdev+bounces-272925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC938352803
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95C1B3004410
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41A037AA90;
	Sun, 29 Mar 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="peKiOgFj"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417E2874E6
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795893; cv=none; b=hvB3yJHG6w7meKsK4fIoI0ey7QuxHqHIUS0L9RFsrUGq7M/h32mumsbpAqmN+8f+JF2V3VnNd9gL2LV1qMYq9+zJ4Mrx9aenMjbBmZbN9FM7HgX4RTPCygZDXFDrXR9Px7gOA6JkktQdvF6nPz3/+LeQAN1gflM1eIWPZHLx0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795893; c=relaxed/simple;
	bh=O4E5Y3r19LE2lIG2EDn+fRnvpYLYZFEOUCsd1s4MEVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1S0q+AY4pFyE6KmiGUeJx/7wfm3upcn+yRafqRIpiXrGO2rQQDEIGQQbumkexOviD2RXlyFG7SfP7iTYDTJZ9FWeN1Tb9iWgsC2UyJLk94wWsvvH0kzvcqiQh5nPmz0d8NEVm4MVidkGcADwo87XS/cKjBbd/KoYFrqJYqjNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=peKiOgFj; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (69.51.30.125.dy.iij4u.or.jp [125.30.51.69])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62TEpO7F031324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 29 Mar 2026 23:51:24 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=gjOV5C00kY76/U1S/KKA1vjIbODY8S7kc+xpGzqxKak=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774795884; v=1;
        b=peKiOgFjTsQzG/E0esMgKXrrC0Q7IK5/gZjL48SrxeGbuVZJ072Mg1SOZKb1+XoF
         gJCaB1IBifsQIsYBPYhiRHemSDzi6idHYDSo36YpQ9qd8aa7/MS4hGDvL5c53l2E
         Hq4n1e1Dt9S+IGyLagaTTSAr6hw2JZBimeZRLcwXlkLo4IYEWBRyxr0wdtAEs93K
         CLJXlC5i7I/UQE2DjNZtVTpqmp3KCcnM4AyfMoJgIJAvFDrVWdcumu7km5jHuRGc
         CyITnQfBOYwK/LGRRYHMHu8sbpEc+m5SN32fLFAuu4qCcQWiyZxeOCXPAYZ5yVoB
         rQpWVa8X0JX0y/btsz9Z+Q==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-net v1] igc: fix potential skb leak in igc_fpe_xmit_smd_frame()
Date: Sun, 29 Mar 2026 14:50:49 +0000
Message-ID: <20260329145122.126040-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272925-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC938352803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When igc_fpe_init_tx_descriptor() fails, no one takes care of an
allocated skb, leaking it. [1]

Use dev_kfree_skb_any() on failure.
Also call igc_flush_tx_descriptors() only on success.

[1]
unreferenced object 0xffff88813aee1b40 (size 224):
  comm "softirq", pid 0, jiffies 4294709256
[...]
  backtrace (crc dee31384):
    kmem_cache_alloc_node_noprof+0x54f/0x640
    __alloc_skb+0xd9/0x5b0
    igc_fpe_xmit_smd_frame.isra.0+0xad/0x510
    igc_fpe_send_mpacket+0x32/0x80
[...]

Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 8a110145bfee..eaa274248d54 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -109,10 +109,14 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	__netif_tx_lock(nq, cpu);
 
 	err = igc_fpe_init_tx_descriptor(ring, skb, type);
-	igc_flush_tx_descriptors(ring);
+	if (!err)
+		igc_flush_tx_descriptors(ring);
 
 	__netif_tx_unlock(nq);
 
+	if (err)
+		dev_kfree_skb_any(skb);
+
 	return err;
 }
 
-- 
2.51.0


