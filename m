Return-Path: <netdev+bounces-271426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FRRBAmNw2nJrQQAu9opvQ
	(envelope-from <netdev+bounces-271426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:21:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C793209B7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FE49303D7B7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB844361663;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOr8Oc/k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7263502B3;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423299; cv=none; b=o6bT7MGDcp0bDSzCE8L4jF/XqOF5G38z3GV4DPH3d+VjNWG7DnLGNqbUBbt7uvuoXUsT2CNMcXpOJW1gdW/LAm7FpwTfPF6grR5Ahc83PKLKrsKqOSjBmuRTY/doU445QnPe7uT2vk7ZMLOiLb9g6ON8pSB4Z6H5dbK/pIjw4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423299; c=relaxed/simple;
	bh=qHwtEmiaUzALs1U8lxciI7QvUZJpw94pPRYf1wfFSqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0itGvfoiHiLs8UrrIPspc9CRzFLzXUIxm6M/UDknvzasdAmAbkMRDXM+cr3WDzy7BlvxNGwOVAHJYl9pqjzOF5QOVOatNXCvtfrXnGzC3MG30NsTO80zQfTWmVJvyGXbzif3duxrXIK1tXUq2gbq7aqKDsF6zBcgStTFwaqeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOr8Oc/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 711EAC2BCB1;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423299;
	bh=qHwtEmiaUzALs1U8lxciI7QvUZJpw94pPRYf1wfFSqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bOr8Oc/kBY5QP6r6s1IvMd7HzrnHb5Wb2udr97GBd7fuUkIdTKU+vTXOwm9TQzG13
	 7h5DXY45PdiuKFEjp9L2X324sl2Vj67igQJ3Qa4aCaPNmmFMLTtgiunhpYwfnc69/h
	 PpGmSaHqCQdEoxeFTm8FGZZa/y2L+NYjHMQTopZWGkQ53uIG8ADY7HSnIVEniknvvx
	 x4OTPdzns4Qh1fQvGWByD5IEo0C/Kqaoy1PedMcIX7h0ooz/DRyqjtcHWUSk6qyuQw
	 DmKFRQ648kAOi+PmLH5TKE20tcclUe8SkZ7gzqRJhP8saAt/JaIfA1u7L+XsnJE5L5
	 sanT++Vqj8qJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94FFEA81E;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 00:21:39 -0700
Subject: [PATCH net-next 1/6] enic: extend resource discovery for SR-IOV
 admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v1-1-48f04ce110cc@cisco.com>
References: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774423298; l=3356;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=y0pGwL9wW5ULZUwdK19OUJqESwm7dxXUYk9R9IIroV8=;
 b=/Ktl/J5AWX9pZs9J6xApCzbj2/lHJxS/snKUdAMK8d8XJd5UaQMRiJdfIyuOA9Eo4xZbOvi3M
 ZSl/yuOa2bQB/sN9F1UuRG91Py4zPCrLbF70ULtBnZt0CZO8gntFRmc
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271426-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: D1C793209B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

VIC firmware exposes admin channel resources (WQ, RQ, CQ) for PF-VF
communication when SR-IOV is active. Add the corresponding resource
type definitions and teach the discovery and access functions to
handle them.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h          |  2 ++
 drivers/net/ethernet/cisco/enic/vnic_dev.c      | 10 ++++++++++
 drivers/net/ethernet/cisco/enic/vnic_resource.h |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 6959e85ab516..366c65d072fc 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -297,6 +297,8 @@ static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
 	dev_warn(&(vdev)->pdev->dev, fmt, ##__VA_ARGS__)
 #define vdev_info(vdev, fmt, ...)					\
 	dev_info(&(vdev)->pdev->dev, fmt, ##__VA_ARGS__)
+#define vdev_dbg(vdev, fmt, ...)					\
+	dev_dbg(&(vdev)->pdev->dev, fmt, ##__VA_ARGS__)
 
 #define vdev_neterr(vdev, fmt, ...)					\
 	netdev_err(vnic_get_netdev(vdev), fmt, ##__VA_ARGS__)
diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index c72452749f5e..c8d657e97094 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -77,6 +77,9 @@ static int vnic_dev_discover_res(struct vnic_dev *vdev,
 		u32 count = ioread32(&r->count);
 		u32 len;
 
+		vdev_dbg(vdev, "res type %u bar %u offset 0x%x count %u\n",
+			 type, bar_num, bar_offset, count);
+
 		r++;
 
 		if (bar_num >= num_bars)
@@ -90,6 +93,9 @@ static int vnic_dev_discover_res(struct vnic_dev *vdev,
 		case RES_TYPE_RQ:
 		case RES_TYPE_CQ:
 		case RES_TYPE_INTR_CTRL:
+		case RES_TYPE_ADMIN_WQ:
+		case RES_TYPE_ADMIN_RQ:
+		case RES_TYPE_ADMIN_CQ:
 			/* each count is stride bytes long */
 			len = count * VNIC_RES_STRIDE;
 			if (len + bar_offset > bar[bar_num].len) {
@@ -102,6 +108,7 @@ static int vnic_dev_discover_res(struct vnic_dev *vdev,
 		case RES_TYPE_INTR_PBA_LEGACY:
 		case RES_TYPE_DEVCMD:
 		case RES_TYPE_DEVCMD2:
+		case RES_TYPE_SRIOV_INTR:
 			len = count;
 			break;
 		default:
@@ -135,6 +142,9 @@ void __iomem *vnic_dev_get_res(struct vnic_dev *vdev, enum vnic_res_type type,
 	case RES_TYPE_RQ:
 	case RES_TYPE_CQ:
 	case RES_TYPE_INTR_CTRL:
+	case RES_TYPE_ADMIN_WQ:
+	case RES_TYPE_ADMIN_RQ:
+	case RES_TYPE_ADMIN_CQ:
 		return (char __iomem *)vdev->res[type].vaddr +
 			index * VNIC_RES_STRIDE;
 	default:
diff --git a/drivers/net/ethernet/cisco/enic/vnic_resource.h b/drivers/net/ethernet/cisco/enic/vnic_resource.h
index b4776e334d63..d327821fa9b9 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_resource.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_resource.h
@@ -42,6 +42,10 @@ enum vnic_res_type {
 	RES_TYPE_DEPRECATED1,		/* Old version of devcmd 2 */
 	RES_TYPE_DEPRECATED2,		/* Old version of devcmd 2 */
 	RES_TYPE_DEVCMD2,		/* Device control region */
+	RES_TYPE_SRIOV_INTR = 45,	/* SR-IOV VF interrupt */
+	RES_TYPE_ADMIN_WQ = 49,	/* Admin channel WQ */
+	RES_TYPE_ADMIN_RQ,		/* Admin channel RQ */
+	RES_TYPE_ADMIN_CQ,		/* Admin channel CQ */
 
 	RES_TYPE_MAX,			/* Count of resource types */
 };

-- 
2.43.0



