Return-Path: <netdev+bounces-269573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBKOOPYwvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:23:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE82CFDF5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CF430D7C4E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147543E024F;
	Thu, 19 Mar 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="xEuAmbsW"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB572ECD34
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940629; cv=none; b=AaBDcr75fvZEj6DpZzbIr8cikhS5mNFEzeaemRrOVuffkuA1ac0cxKPmSiuTL8Ciu7WrZOaRIBmk8qNyvx8W1ZgsQnFZSZc+lPTpeY6A/SoCU3yJFuPazJnLeVU50+rBGeH28VVoDtwvK7woLBBlZ8K4PZFNVxotZ8QM0nJG8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940629; c=relaxed/simple;
	bh=8xf9behZCkERMvn98dmjaCAFyym+EbqImKHu9YNuySk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAE+9fHAEbLaUYUfgjBrNpHy1VI/z005/X2vZBunQN1WDsLnlOkD87NjkUJWzu5JraeMtxlmKkDOoyU0dr4dFi2q+jDoM17RTPSIEJOnxMEbdQFb02DEPbzcFWqvRKw3sH81bWc/Y/HXlEnJdK+w2tnevJvgrXkEWEHyIE49Fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=xEuAmbsW; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62JHH6xw076845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 02:17:06 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=t7tQWDB599mgzXVu98rsjNCBJh04E4IB3vAFUErTcSE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773940626; v=1;
        b=xEuAmbsWx2tlWHC2vSSvQu8Dm2r5gcipiR6jl9TiDD/9u3VYgSV0WVTOyC//dcRA
         M606VcjKCzGKSPqYbXEzE9ieGyqD7TwTEbadPcX6/Ld04jzG3tmEqbA6drzSWOoc
         gQh8tug2E9afijTz+drxS4Qq6Ze7rIBD38E9+atcDLq/mAnhOW2MkGP2ZlLb7F6Z
         oGAPOZgr93Im+OFpEV2QTKMWsw/htxVxmv4mgIrEiB81cJkafdJSqLFEDkeivAxh
         CH+Q1vWIByoUruJSn4YFcvtw9Fkckl5wTOV2+mJU0wJ5PTqcqsT30qmjcAiyxPCs
         /cjVRaFNtJmSQ8kCI/IBvA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 3/3] i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
Date: Thu, 19 Mar 2026 17:16:44 +0000
Message-ID: <20260319171650.5815-4-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171650.5815-1-kohei@enjuk.jp>
References: <20260319171650.5815-1-kohei@enjuk.jp>
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
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269573-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:dkim,enjuk.jp:email,enjuk.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DCE82CFDF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce i40e_xdp_rx_vlan_tag() which takes the same approach as
i40e_process_skb_fields() to extract the VLAN tag from the RX
descriptor.

Tested with X710 adapter using xdp_hw_metadata, and confirmed that VLAN
tags match between bpf_xdp_metadata_rx_vlan_tag() and
skb->vlan_proto/vlan_tci.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6b7e34b16a8d..3749f32ef95a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13610,8 +13610,27 @@ static int i40e_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 	return 0;
 }
 
+static int i40e_xdp_rx_vlan_tag(const struct xdp_md *_ctx, __be16 *vlan_proto,
+				u16 *vlan_tci)
+{
+	const struct i40e_xdp_buff *ctx = (const void *)_ctx;
+	const union i40e_rx_desc *desc = ctx->desc;
+	u64 status;
+
+	status = le64_to_cpu(desc->wb.qword1.status_error_len);
+
+	if (!(status & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)))
+		return -ENODATA;
+
+	*vlan_proto = cpu_to_be16(ETH_P_8021Q);
+	*vlan_tci = le16_to_cpu(desc->wb.qword0.lo_dword.l2tag1);
+
+	return 0;
+}
+
 static const struct xdp_metadata_ops i40e_xdp_metadata_ops = {
 	.xmo_rx_hash		= i40e_xdp_rx_hash,
+	.xmo_rx_vlan_tag	= i40e_xdp_rx_vlan_tag,
 };
 
 static const struct net_device_ops i40e_netdev_ops = {
-- 
2.51.0


