Return-Path: <netdev+bounces-274158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA//OWBAzWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:57:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB637D8B3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1F6303717A
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74736D9FE;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnTEvgFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB13630B8;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057475; cv=none; b=Et8PqCMtZakQC0mxEju+BfptFYNIh4miwcLLNP86rLVxUOoJsuJlOOQGNiGXRrz9ca1Kav/w1IpAhPtFsyq3nsEYueUEkocowxRokJdpqNwSUqqQrvXfnBYT/gnGBUxOdkX4j/mGsODrZlNjVA942/Aw8K6fNeqtpQ9lmrfNcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057475; c=relaxed/simple;
	bh=BpaDyxuEEWGwH8+zxRnZgYWjvYFs0B64GTKhbxeNAS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9uK+4gT0xbnu3oirtVCT82BrXevRKiId5i1Xxv3OSTbXnvh4NJANev98BM2ZFCH66odKD/DeFG42Q/EEsps1thxc5o/1do/8z+8o9oIgZdv6EvGtS9ud0/0omW94C+IJSkYo9O2vnAeF8IjyHniEMmuOoXBGPy+c+oz8SVa+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnTEvgFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C3BDC2BCC4;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775057475;
	bh=BpaDyxuEEWGwH8+zxRnZgYWjvYFs0B64GTKhbxeNAS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HnTEvgFvL7SVHIxr09UQRIORG4Ka3R0g1NVvDzwSdP81kbQWbz//2i5FmZ3PpjcBJ
	 21H1jzjYJ0zVYEEmB2BidUDAkrZKZicC4hFBrYjwjPCYhJQUeq6V7pQ8WzqNCzBTB3
	 KL6YP9OIH7voYL78YRTpMJ/ExV24BrSpG8ON7et1YbBTss7pSy5IKCYjhqb+akVruM
	 Xt9X+w8wF0YhqaHv/taAdAjcAi2khODpOcztKmiWJzNh9/n9rrMBzs++EqT225C8ED
	 nMsSCUg1scQKmsywo5mHXNDxd46+YPiB80UEwU1U9UWAJ8Mlv+Bs3Xh//BafOp7n11
	 rmvpKUTIEywWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E4D10F6FDE;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 01 Apr 2026 08:31:14 -0700
Subject: [PATCH net-next v4 4/6] enic: make enic_dev_enable/disable
 ref-counted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-enic-sriov-v2-prep-v4-4-d5834b2ef1b9@cisco.com>
References: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
In-Reply-To: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775057474; l=4130;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=zvvdRfwq8gsBZZOSKyc4TXaUkVuYP93HpEGc0xRpx0k=;
 b=faHAjZwd4ltGsy3HOtd2pkMIBkRUiT6vgD8Is0FcEb0Nuo6GQ8M0JUPbQJqeWzqgpF+JeJS8D
 BL7reGlC7dsA4Bf8oRCLz4HoX1h8IbD9W8dsp6ls/VslCAPqOMu2uJf
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274158-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 92CB637D8B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Both the data path (ndo_open/ndo_stop) and the upcoming admin channel
need to enable and disable the vNIC device independently. Without
reference counting, closing the admin channel while the netdev is up
would inadvertently disable the entire device.

Add an enable_count to struct enic, protected by the existing
devcmd_lock. enic_dev_enable() issues CMD_ENABLE_WAIT only on the
first caller (0 -> 1 transition), and enic_dev_disable() issues
CMD_DISABLE only when the last caller releases (1 -> 0 transition).

Also check the return value of enic_dev_enable() in enic_open() and
fail the open if the firmware enable command fails. Without this check,
a failed enable leaves enable_count at zero while the interface appears
up, which can cause a later admin channel enable/disable cycle to
incorrectly disable the hardware under the active data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  1 +
 drivers/net/ethernet/cisco/enic/enic_dev.c  | 17 +++++++++++++----
 drivers/net/ethernet/cisco/enic/enic_main.c | 17 ++++++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 0fd9cd917132..67fd780b1fa1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -260,6 +260,7 @@ struct enic {
 	u16 num_vfs;
 #endif
 	enum enic_vf_type vf_type;
+	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
 	struct enic_port_profile *pp;
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
index 2cbae7c6cc3d..659787f73cf1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
@@ -131,10 +131,13 @@ int enic_dev_set_ig_vlan_rewrite_mode(struct enic *enic)
 
 int enic_dev_enable(struct enic *enic)
 {
-	int err;
+	int err = 0;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_enable_wait(enic->vdev);
+	if (enic->enable_count == 0)
+		err = vnic_dev_enable_wait(enic->vdev);
+	if (!err)
+		enic->enable_count++;
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;
@@ -142,10 +145,16 @@ int enic_dev_enable(struct enic *enic)
 
 int enic_dev_disable(struct enic *enic)
 {
-	int err;
+	int err = 0;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_disable(enic->vdev);
+	if (enic->enable_count == 0) {
+		spin_unlock_bh(&enic->devcmd_lock);
+		return 0;
+	}
+	enic->enable_count--;
+	if (enic->enable_count == 0)
+		err = vnic_dev_disable(enic->vdev);
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index acd05350ec1a..e7125b818087 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1750,7 +1750,11 @@ static int enic_open(struct net_device *netdev)
 	if (vnic_dev_get_intr_mode(enic->vdev) == VNIC_DEV_INTR_MODE_MSIX)
 		for (i = 0; i < enic->wq_count; i++)
 			napi_enable(&enic->napi[enic_cq_wq(enic, i)]);
-	enic_dev_enable(enic);
+	err = enic_dev_enable(enic);
+	if (err) {
+		netdev_err(netdev, "Failed to enable device: %d\n", err);
+		goto err_out_dev_enable;
+	}
 
 	for (i = 0; i < enic->intr_count; i++)
 		vnic_intr_unmask(&enic->intr[i]);
@@ -1760,6 +1764,17 @@ static int enic_open(struct net_device *netdev)
 
 	return 0;
 
+err_out_dev_enable:
+	for (i = 0; i < enic->rq_count; i++)
+		napi_disable(&enic->napi[i]);
+	if (vnic_dev_get_intr_mode(enic->vdev) == VNIC_DEV_INTR_MODE_MSIX)
+		for (i = 0; i < enic->wq_count; i++)
+			napi_disable(&enic->napi[enic_cq_wq(enic, i)]);
+	netif_tx_disable(netdev);
+	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
+		enic_dev_del_station_addr(enic);
+	for (i = 0; i < enic->wq_count; i++)
+		vnic_wq_disable(&enic->wq[i].vwq);
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);

-- 
2.43.0



