Return-Path: <netdev+bounces-273054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbTAtTjyWlC3QUAu9opvQ
	(envelope-from <netdev+bounces-273054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AD354DA7
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A74A3013244
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089F3939B6;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxH3Mw68"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A339151B;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838717; cv=none; b=aalfCdPQspUEAmjyX4L6erTPN8tlo4M+zPk4m3qrsPXpBCoSiiXkBBqaKTGi38y59DslnHoVMfjjI3xmM2aU7JRX+8749g7j84TfWYu4MEyLMnBAyQRPKMYLSE8lxk4Iu/s5wFv9e41CBJni7hHDXb6kghEPRwgxTCl9zexSihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838717; c=relaxed/simple;
	bh=BpaDyxuEEWGwH8+zxRnZgYWjvYFs0B64GTKhbxeNAS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYkw/mW+6Wrs8//AYR9INz9qY8HQz2VOobnRBcdFpzEugMDYU8srKMj+wUydrVN9YiC8BtF7/lxOdi+ap2m8YxHeYVyNKGG91ziI7RjWlDkgtLEsd8p3yfaTLhjaKrBRI0MnkAMHo++YwS/RRNaebf5B8lKNaxxi9pwj6J9LG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxH3Mw68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1C07C2BCB7;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774838717;
	bh=BpaDyxuEEWGwH8+zxRnZgYWjvYFs0B64GTKhbxeNAS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IxH3Mw68UQRXjzB1HOpN/KqKXtYzk/XWZ9dTKAtdFpqhTOgZTCO6e2Uwd54qSdqCk
	 BTigMD/5SgJB6H82xkw/q2VhQEjI87EhL96vdsEqZ65wFfHwAMRa57hCYjUo2dvx8+
	 +MvQsuDlbEEMyOEpYpk153Mp2I9+zvR7l3ZNScgJvDc3HIzvUFIMdPSHKr7QHsyMil
	 pZwg4cc36lQO4bIsSLN35NN0X+fqBO/ls2wYNdc6ir72P9h2xcGJ4JWRFL/as24Lz0
	 BBGekgnHDTcajIIrBMwokMyTsbldT+CeYJVbH7HO1RM5vqq/Ih2Flm2ib+cWNdEdxC
	 533M52YVtIiQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CBFF492D;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sun, 29 Mar 2026 19:45:20 -0700
Subject: [PATCH net-next v3 4/6] enic: make enic_dev_enable/disable
 ref-counted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-enic-sriov-v2-prep-v3-4-19a477549ef6@cisco.com>
References: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
In-Reply-To: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774838716; l=4130;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=zvvdRfwq8gsBZZOSKyc4TXaUkVuYP93HpEGc0xRpx0k=;
 b=KflXMJygQFdksHqK2PJ5a9eLSq02ebxaBkEXTmD1qq2XkgOrJIVA3mLuJkMSdvUwDNOP5gUdy
 0etpzaTfZBwATXKb9/agR8LFnU3pVBPiA6l2C/UC4m3gFKzTuZpA2G1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273054-lists,netdev=lfdr.de,satishkh.cisco.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 628AD354DA7
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



