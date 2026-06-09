Return-Path: <netdev+bounces-297171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1EAKHXVDKGoKBQMAu9opvQ
	(envelope-from <netdev+bounces-297171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:46:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FA6628D4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:46:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=dbErejUA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297171-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297171-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D54BA31272A2
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841DB4BCAA3;
	Tue,  9 Jun 2026 16:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11514BC01A;
	Tue,  9 Jun 2026 16:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022776; cv=none; b=MvtuUs+1GRSQkYkT8RzDGpNEmZeZWWE2SIZ5cMM1TUat2HhLf1Rfnp/E9aowghwt6JAAFgeW1GSdaHpKH5bxhaNeJymmvmPuC+wp91M4AoTN2ZXYscDIWYRtmwAbfs2ShRzYSxQ2n392apxSuPVsvj62sppO752XBktaBJJpAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022776; c=relaxed/simple;
	bh=MYBn/BV06qLt+REdHK+//qM3Kxx0oxfsJkIFbD9eYmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfvWZnKFprpF2kWyc2lYRl3rJ+PwJNNcyq7IRCNYGgd9r9vhPwFGchhJPjIcgAdP38VsGb8nf3wcIghgKzX2KfCd3kgo+Er+c3qab98olQsUISWMTimOkUhc0L+/iPY+UEPOuD3UBb35aDF8zFBMrp9NTd1F8g68DrGbnZXEoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=dbErejUA; arc=none smtp.client-ip=173.37.86.77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7654; q=dns/txt;
  s=iport01; t=1781022774; x=1782232374;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8XDn75AblbgEJLBTGL0V4O3dG2zMp9DZV5PU4WcqQG4=;
  b=dbErejUAweXj1elL6kQzdmeqUY98+sgNWgkBeSFGySJ2LTo5s6pywhwI
   K7hwI1RZQVubP+ztY5IGucazhy0mnR+12lJPNW9rn9KCbyK4WV/dMN/5r
   juD6ztHuKDBeigrMnMrCgS0lQplwK/c9ot7l8o1hpZ4aR+VhxK1izcuv3
   mnmd9N/FPfWG+8EedkgXT803UNVr0dR6CUdSlTJ74Q5FN5TnT43XocUHc
   4r5E8GG5Lcv0D/B3+lwzcf2x2BvYPg4jL/3qE5mhUyzMoEwszN/WOFUdM
   A4hxAI2FpnWSJ32HHf/Ds1jFEVHDzghOgEBhHll9Ou7d0vIlzHyyOptq0
   w==;
X-CSE-ConnectionGUID: 6QutuVTfToarX9DM5ZhUFg==
X-CSE-MsgGUID: WuWXq+CBT7u2bDDSvtAt2Q==
X-IPAS-Result: =?us-ascii?q?A0AmAAAaPyhq/4//Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIHIc3giGeHhSBag8BAQEPUQQBAYUGAo03AiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdAO1IHp/M4EBhH3ZRYFmAQsUAYEKLgGFcIJpAYFwhAY7hEEnG4FJRIEUA?=
 =?us-ascii?q?YJ5b4QFJYN0gmoEgg2BDxKQZwk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYF?=
 =?us-ascii?q?QIUHBMPBBYyHXAMJxIsFzRYGwcFgUqBOxQxBCGBBYUSIx8DOYEVgXyBKGdpF?=
 =?us-ascii?q?TE1TQMLGA1IESw3Bg4bBD0BbgeMOhcPgUcBagcBgQ5COTIDDDIlFQgtCZMfg?=
 =?us-ascii?q?36NX2uBNZ9ZhCaBZqAPATKXZ5MEmQYio11ZhGiBaDyBWTMaCBsVgyJTGQ+OL?=
 =?us-ascii?q?RYcy2InMj8HAgcPApFzBIF5AQE?=
IronPort-Data: A9a23:92baxatU3MvGwM64nOL5+hPrwefnVJZfMUV32f8akzHdYApBsoF/q
 tZmKWjUPv3ZY2L3f9t1PI2x8h4EsZDRy4I2TVQ6pS09Fi9EgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZDdJ5xYuajhKs/zb+Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwpN9qHXxwy
 fIkLzkXXkGvor+EwI+VRbw57igjBJGD0II3oHpsy3TdSP0hW52GG/uM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtMYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoDbH5wMwRrB+
 Qoq+UzGHy4qLZ+04wba7yimqsP0gz/SRNgrQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt59jlvZF2jR/VSNtnOLC6g8ezGjzqx
 T2O6i8kiN07i8MX26il1U7IjijqpZXTSAMxoALNUQqYAhhRfoWpYcmsrFPc9/sFdNjfRViat
 39CkM+bhAwTMayweOW2aL1lNNmUCzytaVUwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:YxgA56njdD1YCCF9Jikn8O5iZrjpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: =?us-ascii?q?9a23=3AM9WZH2iv9ObcrMgUyBvbo7a4vTJuLETA0GruH0G?=
 =?us-ascii?q?EDm9zeOy5bAKi+J5KnJ87?=
X-Talos-MUID: 9a23:i0sNmgpvlqGj+WzgnA4ezw5/C/dxoI+ENB8Qy58ql/KaKQVsYQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492117417"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:54 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id BBACE18000268;
	Tue,  9 Jun 2026 16:32:53 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:36 -0700
Subject: [PATCH net-next v8 10/10] enic: add V2 VF probe with admin channel
 and PF registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-10-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=7884;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=MYBn/BV06qLt+REdHK+//qM3Kxx0oxfsJkIFbD9eYmE=;
 b=iICukX4K48kCYBpOGqZsNcUGFtXGfW8HUf1na/+9BYq3ouR6nswJXFDM41YE9A+/njGgaQCyh
 1nv7AIhXZKXCthEieFaERuRamhPJlFKXVP6E0B6UO/Y30t9TrlJ9Iwt
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.186];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.186, [10.25.128.186]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA1FA6628D4

When a V2 SR-IOV VF probes, open the admin channel, initialize the
MBOX protocol, perform the capability check with the PF, and register
with the PF. This establishes the PF-VF communication path that the PF
uses to send link state notifications.

The admin channel and MBOX registration happen after enic_dev_init()
(which discovers admin channel resources) and before register_netdev()
so the VF is fully initialized before the interface is visible to
userspace.

The admin channel is opened before enic_mbox_init() installs the
receive handler.  This is safe because enic_admin_rq_cq_service()
checks admin_rq_handler before enqueuing received buffers, so any
interrupt that fires between open and mbox_init is harmlessly
discarded.

On remove, the VF unregisters from the PF and closes its admin channel
before tearing down data path resources.

V2 VFs are not provisioned with an RES_TYPE_SRIOV_INTR resource by
firmware, so bypass that check in the admin channel capability
detection for V2 VFs. The PF still requires this resource.

The admin MSI-X vector reserved by enic_set_intr_mode()
is used for the admin channel interrupt.
enic_adjust_resources() ensures the reserved slot is within
intr_avail bounds even at maximum queue configurations.  The
admin INTR uses a RES_TYPE_INTR_CTRL slot shared with the
data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 88 ++++++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_res.c  |  3 +-
 3 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index db9c76d1150a..6f2f2c6e92b1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -442,6 +442,7 @@ void enic_reset_addr_lists(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
+int enic_is_sriov_vf_v2(struct enic *enic);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index f3d335f06fbc..162c5e75ed0f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -316,6 +316,11 @@ static int enic_is_sriov_vf(struct enic *enic)
 	       enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
 }
 
+int enic_is_sriov_vf_v2(struct enic *enic)
+{
+	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
+}
+
 int enic_is_valid_vf(struct enic *enic, int vf)
 {
 #ifdef CONFIG_PCI_IOV
@@ -2348,15 +2353,19 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->intr_avail;
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX: {
-		/* Reserve one MSI-X slot for the admin channel interrupt
-		 * when V2 SR-IOV admin channel resources are present.
-		 */
-		unsigned int admin_reserve =
-			enic->has_admin_channel ? 1 : 0;
-
 		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
-		 * used based on which resource is the most constrained
+		 * used based on which resource is the most constrained.
+		 * Reserve one extra MSI-X slot for the admin channel INTR
+		 * when has_admin_channel is set so that
+		 * enic_admin_setup_intr() can allocate at intr_count
+		 * within the intr_avail bounds even when the data queue
+		 * count is maxed out.  intr_count counts only the data-path
+		 * IRQs (registered by enic_request_intr()); the admin INTR
+		 * lives at msix index intr_count and is set up later by
+		 * enic_admin_setup_intr().
 		 */
+		unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+
 		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
 		rq_default = max(netif_get_num_default_rss_queues(),
 				 ENIC_RQ_MIN_DEFAULT);
@@ -3037,6 +3046,38 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
+	/* V2 VF: open admin channel and register with PF.
+	 * Must happen before register_netdev so the VF is fully
+	 * initialized before the interface is visible to userspace.
+	 *
+	 * admin_channel_open() runs before enic_mbox_init() installs
+	 * the receive handler.  This is safe because
+	 * enic_admin_rq_cq_service() checks admin_rq_handler before
+	 * enqueuing any received buffer, so interrupts that fire
+	 * between open and mbox_init are harmlessly discarded.
+	 */
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_admin_channel_open(enic);
+		if (err) {
+			dev_err(dev,
+				"Failed to open admin channel: %d\n", err);
+			goto err_out_dev_deinit;
+		}
+		enic_mbox_init(enic);
+		err = enic_mbox_vf_capability_check(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX capability check failed: %d\n", err);
+			goto err_out_admin_close;
+		}
+		err = enic_mbox_vf_register(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX VF registration failed: %d\n", err);
+			goto err_out_admin_close;
+		}
+	}
+
 	netif_set_real_num_tx_queues(netdev, enic->wq_count);
 	netif_set_real_num_rx_queues(netdev, enic->rq_count);
 
@@ -3061,7 +3102,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
 		dev_err(dev, "Invalid MAC address, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	enic->tx_coalesce_usecs = enic->config.intr_timer_usec;
@@ -3159,11 +3200,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Cannot register net device, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	return 0;
 
+err_out_admin_close:
+	if (enic_is_sriov_vf_v2(enic)) {
+		if (enic->vf_registered) {
+			int unreg_err = enic_mbox_vf_unregister(enic);
+
+			if (unreg_err)
+				netdev_warn(netdev,
+					    "Failed to unregister from PF: %d\n",
+					    unreg_err);
+		}
+		enic_admin_channel_close(enic);
+	}
 err_out_dev_deinit:
 	enic_dev_deinit(enic);
 err_out_dev_close:
@@ -3200,6 +3253,23 @@ static void enic_remove(struct pci_dev *pdev)
 
 		cancel_work_sync(&enic->reset);
 		cancel_work_sync(&enic->change_mtu_work);
+
+		/* Close the admin channel and unregister from the PF before
+		 * unregister_netdev() to prevent a late PF notification from
+		 * touching a netdev that has been freed.
+		 */
+		if (enic_is_sriov_vf_v2(enic)) {
+			if (enic->vf_registered) {
+				int unreg_err = enic_mbox_vf_unregister(enic);
+
+				if (unreg_err)
+					netdev_warn(netdev,
+						    "Failed to unregister from PF: %d\n",
+						    unreg_err);
+			}
+			enic_admin_channel_close(enic);
+		}
+
 		unregister_netdev(netdev);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 436326ace049..74cd2ee3af5c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -211,7 +211,8 @@ void enic_get_res_counts(struct enic *enic)
 		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
 		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >=
 			ARRAY_SIZE(enic->admin_cq) &&
-		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
+		(enic_is_sriov_vf_v2(enic) ||
+		 vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1);
 
 	dev_info(enic_get_dev(enic),
 		"vNIC resources avail: wq %d rq %d cq %d intr %d admin %s\n",

-- 
2.43.0


