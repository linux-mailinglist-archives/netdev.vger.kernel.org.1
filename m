Return-Path: <netdev+bounces-285456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHvhGy3W/GlvUQAAu9opvQ
	(envelope-from <netdev+bounces-285456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 20:13:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65F44ED43C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 20:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 023173022955
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038A450910;
	Thu,  7 May 2026 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="IXIxnJtn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BD42668F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177564; cv=none; b=k9EAVf73cNjb/RT+zVkdl9QunE8c6u3P0so57leEOJ0uXyVKaYDgEj6lCjpC2uICXzDuqnpeCaGQn/fG0r2vEX6b+Edzh0EMi7aykrH1ahvkODiYj/c4PL0d3Si0MGNWwezlFM30gU34GBCbR/tdqIkun/m8m674gfxDltacx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177564; c=relaxed/simple;
	bh=W1R0D0Z/pLwadnENcix72gOksTcRzH7nKi7KUac7rUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfvzEz4ouvPD5JSkS/e1yfS3ocOJqj1yBUgFWWHEkps0wlP7na2YDL2DDrUN+BjStpB3EdXjDaC8jSaTRGhks9Ls4nNQ/GBxF/7T4or52v5N5Udr2vZhmUO2RcenE0+ZdqElplIdUVcC+liqwPf7s7CLiC5f6uJip5UjIGLwkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=IXIxnJtn; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b0mdeVf4f/k0tra0/ipWb27hIKiBf4S4nVOXBPDXkwc=; t=1778177563; x=1779041563; 
	b=IXIxnJtnrRWgdTEIH3+Uwd5rSEmPTbJLvjAXxHpiWhOFBKxgDHKgtMUjryDDdy3YTLNiZNHCNgO
	lJ70evRiHHJktPWY1m7oKMQpqICP6Vi1m3GbdbsFgXbR+UyKd6TB+S1UpWfvkNaC6m7fQruKWAmCo
	IHgTXQVqb0HR/ZA1PNnc4nM9HHS4lPlDn8Wccp3kOUStnr95dgmQmoZ3JNWHIQCeTFb3saqquaBnR
	OP8VnNqbDtBJiOKpDRQwyDWcH+5TZCK+u12mWG4+5z3akt2n8hEtamHa53sP7E2iISsvX4deWse70
	b7RQXdcmVLdb1Sp+32icclU+t/0/Zp7eI+3g==;
Received: from [70.228.78.207] (port=63938 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wL3DA-00033n-8t; Thu, 07 May 2026 11:12:37 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: anthony.l.nguyen@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	netdev@vger.kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net] ice: fix packet corruption due to extraneous page flip
Date: Thu,  7 May 2026 11:12:08 -0700
Message-ID: <20260507181208.1322-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.1
X-Scan-Signature: 26b8f8cb9d50f38c95a96ded60a4c5d6
X-Rspamd-Queue-Id: C65F44ED43C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285456-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanford.edu:email,cs.stanford.edu:mid]
X-Rspamd-Action: no action

Consider the following sequence of events:
* The bottom half of a buffer page is filled with data from
  packet A. The page has a net reference count (reference count
  - bias) of 1. The page is returned to the NIC, flipped to
  use the top half.
* Before the reference on the page is released, the NIC returns
  the page with no data in it ('size' is zero in ice_clean_rx_irq).
  In this case the bias does not get decremented. The page still
  has a net reference count of 1, so it gets returned to the NIC.
  However, ice_put_rx_mbuf flipped the page so that the bottom
  half is active.
* If the NIC stores another packet in the page before packet A
  has released its reference, the data in packet A will be
  overwritten with data from the new packet.
The fix is for ice_put_rx_mbuf not to flip pages that have a
size of 0.

Note: major revisions to the ice driver make this patch irrelevant
for recent versions. It applies to longterm stable versions
6.18.27 and 6.12.86; it also seems relevant for 6.6.137, but would
need modifications for that version. I have not examined earlier
versions

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 51c459a3e722..371e6db3c272 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1215,6 +1215,9 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		xdp_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
 
 	while (idx != ntc) {
+		union ice_32b_rx_flex_desc *rx_desc;
+		unsigned int size;
+
 		buf = &rx_ring->rx_buf[idx];
 		if (++idx == cnt)
 			idx = 0;
@@ -1224,10 +1227,20 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		 * To do this, only adjust pagecnt_bias for fragments up to
 		 * the total remaining after the XDP program has run.
 		 */
-		if (verdict != ICE_XDP_CONSUMED)
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		else if (i++ <= xdp_frags)
+		if (verdict != ICE_XDP_CONSUMED) {
+			/* Don't "flip" the page if size is 0: in this case
+			 * the data in the current half will not be used so
+			 * it's OK to reuse that half. And, since the bias
+			 * didn't get decremented for this half, the page can
+			 * be returned to the NIC even if the other half is
+			 * still in use, so flipping the page could cause
+			 * live packet data to be overwritten.
+			 */
+			if (size != 0)
+				ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+		} else if (i++ <= xdp_frags) {
 			buf->pagecnt_bias++;
+		}
 
 		ice_put_rx_buf(rx_ring, buf);
 	}
-- 
2.43.0


