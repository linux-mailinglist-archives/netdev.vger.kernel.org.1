Return-Path: <netdev+bounces-274154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLb8CltAzWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:57:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5837D8A5
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B5F03011F1F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D535A39D;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMmyiwom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F412272E7C;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057475; cv=none; b=BLcz01OXQl54ZXYeydVb7VGZuHAJuxt5zBCrJvCpTh5CtU9Om2micWgWee02oAHeq+YSSt90+ONYBNE274I53YdysKDxhM/l+eFJy832TL4mZkcx/5M3trZnsxvRAYvE0IGKYXvGYyno1tIulgTkO8z4uubMboJXXkAfQToMEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057475; c=relaxed/simple;
	bh=qHwtEmiaUzALs1U8lxciI7QvUZJpw94pPRYf1wfFSqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8VO83eW7W25kURYO5cGqUbtGIYMk1iXHUb5XDdBoxtW4jIAro9yv7mLTfW4n+FJePSHVPNzqJ750rKo86cg2OCrMQ/XfjyMbHwtbKZOHgK7Spxdo5nFSKReQ0fU/o94biJ4HOp1L/FNPL6vUKZZnWrG4P5fRZ8DBZzfZ2CkEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMmyiwom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F1DC19423;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775057475;
	bh=qHwtEmiaUzALs1U8lxciI7QvUZJpw94pPRYf1wfFSqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cMmyiwomhgLSso3TKn4eYkzFQVY088BFI58f3gpMh8a6LLqnd17myfxG7CP4XU3ti
	 XMX6Gxp+SN2GtVexdhjqNVkR3wwvTwri1u/2gYMiywHa3r5eLwNACCkYm+xTxCkpFx
	 dbkG2nKNnMngWzTLfwr3nqcJY9g7HBnPihV6PPeZfcgMQJMWlDpjZYKD8ph9HvwSA7
	 MnMzztkmaQ2dqwfrfxmS9p9CuuEFvbG8/cfjMW3y5xLR+3J66KKH7GtSLa0T35Lk0f
	 QQnUIBmBl40X07f3jgFtAUTI8ypZ3S4ionfG0ByI45fQtiMCa5VL8HBbHIelDU6UJR
	 hK+fDr/xJSMqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FED10F6FD9;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 01 Apr 2026 08:31:11 -0700
Subject: [PATCH net-next v4 1/6] enic: extend resource discovery for SR-IOV
 admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-enic-sriov-v2-prep-v4-1-d5834b2ef1b9@cisco.com>
References: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
In-Reply-To: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775057474; l=3356;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=y0pGwL9wW5ULZUwdK19OUJqESwm7dxXUYk9R9IIroV8=;
 b=ZP9Adj0tYDtyKk8NvLNaGcW7dIiyFFcr0tbrBPONiWiuehFPYidDcpH6qC7pmXcqmXfbajRdE
 0FnBEGKIU2pDQEMzhIZh4oo313Rk0QtzRildB1suTNEcikpT5Phf8Ds
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
	TAGGED_FROM(0.00)[bounces-274154-lists,netdev=lfdr.de,satishkh.cisco.com];
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
X-Rspamd-Queue-Id: 95E5837D8A5
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



