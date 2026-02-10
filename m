Return-Path: <netdev+bounces-258115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAkmJslVi2k1UAAAu9opvQ
	(envelope-from <netdev+bounces-258115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:59:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441611CDD8
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D80613053CDA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BECC385EDF;
	Tue, 10 Feb 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="P43r5sur"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6C3859F8
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739102; cv=none; b=iWyAtnoawn+fZYVBwGrr4TkgVf/+kefd/AdtU4tfaO8FeH+p2e059HzO0UOIcJ1eoeqky+jjutAm1rf1XJDpejDTvLWxRq27g3IyVrB+4ZKUi1Szf0NVWLSOQNIQ7lHtNMC71eVqpAEMXvyKKnQKMhjN1hI8cbOlmcNGhIlB/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739102; c=relaxed/simple;
	bh=oc1aqvpsTfBDPbY58SSw6aVAtdwMzP/8K916FfCqlOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEoVIC5qcsC1u4hfnb23pGJ/SQBqluE6wT5ZEO5Ricb2+UBSFlEgAaub4QrJFQQqG7P7hAYsE1BNePAM163JQ1ixtaZn5jgsio1Erq9lmDkbrjp0yTWekqhe2+r2VYFVxti2ZvznMQOAV+wHJJ7FSLsWRUKoAMylLWL8jhE9HP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=P43r5sur; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (227.25.31.150.dy.iij4u.or.jp [150.31.25.227])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61AFwBhg052279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Feb 2026 00:58:12 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=AV99yFS6N2XH5Ncq0/NTS/CftT+Jd2zuUBJxQTuidFU=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770739093; v=1;
        b=P43r5surwhqNi1X2pF7KN9sf678WyvqiBOt8ni5kpFQ4GKnZETg+JekWTNSJ7+FV
         EgDjDm6LKXpYK0C9GSIKOzLBHo1JIhgP7yfhZ2ik2sZEEpkbDBhnkw8j71ioJjmL
         P8dFILQgn1c/eB0LNdjWgNopbZeRKPmb3rFzmREIml3QRM6oHQ54Dq9d6rtDghJX
         sYiUXa1Vy3sjDpEKKyePCfdbzlMTeDgqoW8v+vFBsAxRMMdDE/M8gtAtkchxGzqU
         SImjiTgYYm6XOi5/Ebhmrg1xBkg0SJmuRyab3DUsqmc04X25wIe4SkMRQHZnYDc/
         7X1Ra4NaeKSpCTN4tVtMdw==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] iavf: fix netdev->max_mtu to respect actual hardware limit
Date: Tue, 10 Feb 2026 15:57:14 +0000
Message-ID: <20260210155810.135577-1-kohei@enjuk.jp>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258115-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:mid,enjuk.jp:dkim,enjuk.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1441611CDD8
X-Rspamd-Action: no action

iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
from PF [1]. This allows setting an MTU beyond the actual hardware
limit, causing TX queue timeouts [2].

Set correct netdev->max_mtu using vf_res->max_mtu from the PF.

Note that currently PF drivers such as ice/i40e set the frame size in
vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
netdev->max_mtu.

[1]
 # ip -j -d link show $DEV | jq '.[0].max_mtu'
 16356

[2]
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 ...

Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
Ideally we may fix ice/i40e to set max MTU (not frame size) in
vf_res->max_mtu on the PF side, but this would break PF/VF API
compatibility between different kernel versions and would need
modifications on code that treats vf_res->max_mtu as the frame size.

If it's acceptable to change the PF/VF API, this patch would be simply:
    netdev->max_mtu = min_not_zero(adapter->vf_res->max_mtu, 
                                   LIBIE_MAX_MTU);
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b625ce00b836..d911c634596a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2772,7 +2772,22 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = LIBIE_MAX_MTU;
+
+	/* PF/VF API: vf_res->max_mtu is max frame size (not MTU).
+	 * Convert to MTU.
+	 */
+	if (!adapter->vf_res->max_mtu) {
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else if (adapter->vf_res->max_mtu < LIBETH_RX_LL_LEN + ETH_MIN_MTU ||
+		   adapter->vf_res->max_mtu >
+			   LIBETH_RX_LL_LEN + LIBIE_MAX_MTU) {
+		netdev_warn_once(adapter->netdev,
+				 "invalid max frame size %d from PF, using default MTU %d",
+				 adapter->vf_res->max_mtu, LIBIE_MAX_MTU);
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else {
+		netdev->max_mtu = adapter->vf_res->max_mtu - LIBETH_RX_LL_LEN;
+	}
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
-- 
2.51.0


