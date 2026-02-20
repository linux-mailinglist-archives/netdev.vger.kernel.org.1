Return-Path: <netdev+bounces-259752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A0sKbSqmGn5KgMAu9opvQ
	(envelope-from <netdev+bounces-259752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:40:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C07F16A23A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA3D3300DEED
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C6366066;
	Fri, 20 Feb 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="N1OT53pG"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97658366550
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612850; cv=none; b=RSNELP6iMCgeUymYn02JnWMWpzkQcB+1KAkrcBUS1FtBGJNo+3lw0vjbSSS93PZGtPZe2VFlm83UTuaryDHMLsb0YHA+mLRterABBX+sE+DkmPIZYPxqFy2UQNTz+vRShjBlLA01xInflUVFlXZt044S4VkdtkDYHutFvK0nbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612850; c=relaxed/simple;
	bh=PrhHRmph1yPUZgJF68obdsFfPhuCzDUqb6IS5rim2V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ou0OtAULkanzT29HOaeogIedL3zT9UBolEaUnwcR1cPZPlhpXTutaTYV2oOAbgmnVH9BZKD5/2cyLKhQmJZ3AgHZuCsn94VvsvyoZE9xqMoRyVJGe5Wdwqm9vDYDQPb5w02NxPLMf/MII4jqG2mIGPCfHEkOmDVcIQadSwFSpW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=N1OT53pG; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (54.52.30.125.dy.iij4u.or.jp [125.30.52.54])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61KIek8G071462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Feb 2026 03:40:46 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=wJcqLA4o6q0LATmfKurtxsPZruiaPYV3Pbjtcv35Kjo=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771612846; v=1;
        b=N1OT53pG3p9VV9Ngd+yeVeyf4LFe1Ti/CazfkZWs03GBQpCbLM/UtpqNioyUDP7u
         TBxrVOGhca+F9boyXNw+yvEgAmfmVhd5q2QJecinEvVGG1cpkfgurLCVsBYDDeue
         U7OROSweswkydQ/TmJbrY9lYViWdUx5dMqZOoRC16c0Qvqd62nRltcmKc8F7HsCq
         3T9qoQa8jkSoyKSt23bqGD3qzMH9KDSc5O+6QUEA2lyT3wUfPuV5zbc1jf2/Bkp9
         6HGri+G+7oI4RPHyQbIAWlh0Sv0XCOGMchKevzeYiDdEpXMVwIm+Q+d7+Dyh5PW3
         sImW+8RNhpvnsOsYBQpDow==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Alice Michael <alice.michael@intel.com>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in error path of ice_set_ringparam()
Date: Fri, 20 Feb 2026 18:39:41 +0000
Message-ID: <20260220184031.60113-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-259752-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: 4C07F16A23A
X-Rspamd-Action: no action

ice_set_ringparam nullifies tstamp_ring of temporary tx_rings, without
clearing ICE_TX_RING_FLAGS_TXTIME bit.
When ICE_TX_RING_FLAGS_TXTIME is set and the subsequent
ice_setup_tx_ring() call fails, a NULL pointer dereference could happen
in the unwinding sequence:

ice_clean_tx_ring()
-> ice_is_txtime_cfg() == true (ICE_TX_RING_FLAGS_TXTIME is set)
-> ice_free_tx_tstamp_ring()
  -> ice_free_tstamp_ring()
    -> tstamp_ring->desc (NULL deref)

Clear ICE_TX_RING_FLAGS_TXTIME bit to avoid the potential issue.

Note that this potential issue is found by manual code review.
Compile test only since unfortunately I don't have E830 devices.

Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 7f769a90dde1..5ed86648d0d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3290,6 +3290,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		tx_rings[i].desc = NULL;
 		tx_rings[i].tx_buf = NULL;
 		tx_rings[i].tstamp_ring = NULL;
+		clear_bit(ICE_TX_RING_FLAGS_TXTIME, tx_rings[i].flags);
 		tx_rings[i].tx_tstamps = &pf->ptp.port.tx;
 		err = ice_setup_tx_ring(&tx_rings[i]);
 		if (err) {
-- 
2.51.0


