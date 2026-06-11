Return-Path: <netdev+bounces-298235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7HrpA1/nKmp6zAMAu9opvQ
	(envelope-from <netdev+bounces-298235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:50:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1630673B66
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:50:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="OoHKPxa/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298235-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26D713144B73
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AF342B753;
	Thu, 11 Jun 2026 16:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941D3CAE81
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:46:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196384; cv=none; b=jQcGfrcOJUToH5qAjg3F8ZCQ76Jo0865xf1GA94M7ffDiyWYQHoWm2hR6ay+05i+hCvBcodNFN5+5zIyylXBFb3S88WweVLmMP6oh0/KRYPBpPLUJVWpsA2xYWi5ddk0Gyl79CV/Szl9M3tPHOFZgErzVnoA3EJIxkUvHorbFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196384; c=relaxed/simple;
	bh=EEJdlU9SdhHdb36BhqrkJanPZEeTi59NSuyZZFm2VrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3tT0/8DuZE69RPv1mqxbQ482DOiRzOBknkzCe+pKtnKw41Kl65WJU1pGlLHcxcwPxnZ6H5HcsH2P47BGV+quFlph12BA8NSfsIc8DybnWDoG+ptU+rWudca0mcELwuhkgjn2cwK4buHe0VhJ3QY0CmZdk5bGwHHOIqSkye3zps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OoHKPxa/; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65B6HDsL2485677
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:46:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=042rDf1bYsfHgsRjwT/IB+2TVDBYS7DHhXWbJC6IyLg=; b=OoHKPxa/O6HZ
	xFD7XEF3eKFgswXMF+l90lAbUF9oUqooDQAD9HEf6Sc10ASDFiQNixKq4ZCt+04C
	lRQLwT9L3YtqA2kEtj0lJ1k0lm5ouI87jvV+M7OnaI9zCy/CgR+U7SCVggUQp4VT
	sm5YVRlMbEXrHYYl5F50hXK/dWekIlZy7tMsoyX8I39wEgiiHVselm9UeOOT51bY
	RVzcG/0LHbUMvZUsb1hBUPRqBGx0MQXz6NiA1s0vdjrCDfosZng3wPz5C/tr3ipz
	5kSUpQQ4MLIgszTN/CNzpjYNszU7sJd/syLXWkwMS9JBhCdWJ06wKKQ3SwAAxyr6
	BEDglh01UA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a6yvx-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:46:21 -0700 (PDT)
Received: from twshared22650.04.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:12 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id F12833DD363E2; Thu, 11 Jun 2026 09:23:43 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
Date: Thu, 11 Jun 2026 09:11:18 -0700
Message-ID: <20260611161546.4075580-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX8L8dAow38mBp
 8TTxn8K2rT1UNe8SL+Vpcnve4P5SYeH5vXqQ15ed+5Wu9pBpnTPQTJqwiMFmQZ80C04Qjuh4Ppr
 JtWfG3f73VM342GDWGxRuCWGhSEXaaKlw0VWvSCRPZZ18gCdTCasuNTdgUwq+W/zNSslmC1YKVb
 MoQ1m0C2v28DL7v5ZI7B3tUfCTBtsNwkpyQcuH4VnNxBo2zsV7qmPjUTBbLQNvIrqCA4bkSA2HP
 qj9/vYaVxvG5kRmQ3Jp99vtx5P8iS8i40uSJCV+OqCOJItK2mwTRo8Rdqkx5v7/OO/LKT93ribN
 d4TXMsldCBs6LaRzN5+v/MilckkmUfPdcVDHzQFXnstHCGpnuRza2C6g39xfWCiupFQDvt93yrf
 I5WS+Y58pdf/+wFOQ2bkwbisUGObhXqsZABXaPy3kSyAG4k5r3dsTtkiD2M068CEU0REIHQD8iJ
 Ey2UcJWh9jCr9s4WQbg==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2ae65d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8 a=DhvycHomHhz2uGJtbakA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: cLQsV0fsOFlx6CjOcm0kGVDML102RfyO
X-Proofpoint-ORIG-GUID: cLQsV0fsOFlx6CjOcm0kGVDML102RfyO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfXwtL0b6a+/SSQ
 PrvOcdMN4/bz7O1dXdMqgq8Is0AOW2wN5BvgrwsalSKAry9jz4Pmt0Kzg2F3cqp3/rhuuOEOVhB
 aJOCPpm0t2xb4aklK9BoXRptcL80xjo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298235-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:mid,meta.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1630673B66

Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
wrapper for importers.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
the importer requests the namespace it can emit and the exporter
returns the matching ST/PH tuple or -EOPNOTSUPP.

dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
when the exporter lacks the callback and requires dmabuf->resv to be
held while the callback runs.

The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
mlx5 as the first importer.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
 include/linux/dma-buf.h   | 21 +++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..aff79ea12e43 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
=20
+/**
+ * dma_buf_get_tph - Retrieve TPH metadata from an exporter
+ * @dmabuf: DMA buffer to query
+ * @extended: false for 8-bit ST, true for 16-bit Extended ST
+ * @steering_tag: returns the raw steering tag for the requested namespa=
ce
+ * @ph: returns the TPH processing hint
+ *
+ * Wrapper for the optional &dma_buf_ops.get_tph callback.
+ *
+ * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
+ * exporter does not implement the callback or has no metadata for the
+ * requested namespace.
+ */
+int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
+		    u16 *steering_tag, u8 *ph)
+{
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (!dmabuf->ops->get_tph)
+		return -EOPNOTSUPP;
+
+	return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachm=
ent;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of=
 the
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..6a54e0f251a2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,25 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Return TPH metadata for the namespace selected by @extended. Return
+	 * 0 on success, or -EOPNOTSUPP if no metadata is available.
+	 *
+	 * This callback is optional. Importers must not call it directly;
+	 * the dma_buf_get_tph() wrapper is the only entry point and handles
+	 * the NULL-callback case. The callback is invoked with
+	 * &dma_buf.resv held.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, bool extended,
+		       u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +582,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
 		    struct dma_buf_attachment *attach);
 int dma_buf_pin(struct dma_buf_attachment *attach);
 void dma_buf_unpin(struct dma_buf_attachment *attach);
+int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
+		    u16 *steering_tag, u8 *ph);
=20
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_inf=
o);
=20
--=20
2.53.0-Meta


