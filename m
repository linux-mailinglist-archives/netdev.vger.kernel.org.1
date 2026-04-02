Return-Path: <netdev+bounces-274530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MgGMG9pzmmpngYAu9opvQ
	(envelope-from <netdev+bounces-274530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A0389626
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47F783096002
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA773C6A57;
	Thu,  2 Apr 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxZWGkvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC12236FD
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134649; cv=none; b=B1NYxwBqrGuiGDQP43GXYl6Xdgz3w/BM1DVgiln5c3ZuSo44hx3v2Ia5kSkIzjS7GGhHEM7oc5u+6yFm7ZDKYHdAiVHDcfR9r4IA+lzelVRKKaKpsYTh68dlcEHNbSwqWkbVesdTWhV+jWl0DV69R0Vc+1GqLK2z3r1k1UB/bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134649; c=relaxed/simple;
	bh=V6OVjIC2l3rgrFgADrj8zqhzjtfaMmdho2sc81R4Sgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ui2NHT5BMQD1IDglBw9ekf/PIchkg5yg2YJbmC5Od4PD23FAlhr1Rc+yNvm5+ZD/q/P/h4XKUWNs8tBN6HSIl2BXeDrd3l4NibnkXw2WMRDmLnH+pkMVKlTZsqra8qWxGZwQUySt9IstrXOxrPuh9VceROnFSi0kmJNA36/rKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxZWGkvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F2C116C6;
	Thu,  2 Apr 2026 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775134649;
	bh=V6OVjIC2l3rgrFgADrj8zqhzjtfaMmdho2sc81R4Sgc=;
	h=From:Date:Subject:To:Cc:From;
	b=TxZWGkvO/QQgBy2cgsWsDxzPX0kUqBgPnH/JmFNQvw19BYgARLXjprcNaonFrFo8T
	 DiFwo0Yuu3ol2QjuuQ3jkLdb1ImmDXGqgGsH0YretZYbX/j7nMGc+38Ypy9doslmfK
	 PUqb20+5495Ttq0rPgCWOejDPHuqSNYcmyzodS+fRciH1i35rIbV9DGpMcrWqSEwz8
	 TAjXk6ZWe+FcTC5DTb4G8qPIPwumt3tXiNQoQHpo9Wj0fKgeteCnwCRwW5HWlniDeV
	 1+OgdAGHQisSi5uy0A47/zwlgsTdXZ2LrrQMtVEwkEALSR2YByB5Vpbt+/OeVs1Gf8
	 2XtoJDc9+48ZA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 02 Apr 2026 14:57:10 +0200
Subject: [PATCH net] net: airoha: Fix memory leak in
 airoha_qdma_rx_process()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMAwAf2Xk2UCtU8FfESnZmrmgbbdExmDs3
 1d8vHu428BYhQ0ezQbKi5iUXOF8aqAfKb8ZJVYG7/zNtc4jiZaRwhwTBV3DpKVnM0yc8Mv0wUF
 W9PfueokdEbUD1NKkXPX/8oTMP3jt+wGy096kegAAAA==
X-Change-ID: 20260402-airoha_qdma_rx_process-mem-leak-fix-27b53dbaaa4f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274530-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A9A0389626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If an error occurs on the subsequents buffers belonging to the
non-linear part of the skb (e.g. due to an error in the payload length
reported by the NIC or if we consumed all the available fragments for
the skb), the page_pool fragment will not be linked to the skb so it will
not return to the pool in the airoha_qdma_rx_process() error path. Fix the
memory leak partially reverting commit 'd6d2b0e1538d ("net: airoha: Fix
page recycling in airoha_qdma_rx_process()")' and always running
page_pool_put_full_page routine in the airoha_qdma_rx_process() error
path.

Fixes: d6d2b0e1538d ("net: airoha: Fix page recycling in airoha_qdma_rx_process()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 95ba99b89428e4cafb91ff7813e43ffeb38e6d9b..91cb63a32d9904e0700bcce45b53624677d75c6c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -697,9 +697,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (q->skb) {
 			dev_kfree_skb(q->skb);
 			q->skb = NULL;
-		} else {
-			page_pool_put_full_page(q->page_pool, page, true);
 		}
+		page_pool_put_full_page(q->page_pool, page, true);
 	}
 	airoha_qdma_fill_rx_queue(q);
 

---
base-commit: a1822cb524e89b4cd2cf0b82e484a2335496a6d9
change-id: 20260402-airoha_qdma_rx_process-mem-leak-fix-27b53dbaaa4f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


