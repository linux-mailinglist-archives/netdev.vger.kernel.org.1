Return-Path: <netdev+bounces-303341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6KzDLagWRGpIoQoAu9opvQ
	(envelope-from <netdev+bounces-303341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAC6E781C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=Ko3VMJcd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303341-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303341-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6966B304C349
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876C3D16F4;
	Tue, 30 Jun 2026 19:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2003i-snip4-6.eps.apple.com [57.103.91.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0836C9E4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:18:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847086; cv=none; b=L4tjEKV1E2wwoURZapd+dKcH/e3NbM5UwBaOn6BKR9b4FVAFrfYvd4Y+sv7hckAzgTCLoqKrKvdWGCdAGYEvai/nLPILmTJCCYTXgRQyyGngcoGYjYW5WgCjzJs+lUDH2lEL2+F8UTENcuSFx6oGBk6oMc78u8KRsRdBwPP7r2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847086; c=relaxed/simple;
	bh=kh5fcCXpkYLKC0cAWDz9UTGvuglGCUePt+9wd9XMYWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV862rOoOWIFX2AoVJfr2RHrgjD9aE27ATV5asl7IU47KuwhqIbGw44fC8iNUtXzbiRk8mYkTcO9bozfKqD99tuYORQEMO5CgLM2qQEoSjMM9/UQiVnH91lQLsv4BDrvq2oBWjmu/Y+wuLx/ZJdjMfGOanTVUHD0QnHU72eVhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=Ko3VMJcd; arc=none smtp.client-ip=57.103.91.217
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 962B318015E6;
	Tue, 30 Jun 2026 19:17:59 +0000 (UTC)
X-ICL-RepId: 019f19f7-8460-7657-9c49-3e0b08a3b9aa
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGl8fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847082; x=1785439082; bh=nfuDUbrMiXUEuPYWWoAWJp6RaiKlQWjsjrRMEpG79Gg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Ko3VMJcdvsjYrfQC2nRdqJtGzq8z7zvoSvVFaOKscM1iVihYX1Cc3DaDo6kTyiqD+CmqwRiMRbKUYEp0ZJtNtOzFw1er16qi7B2Z9b/eDiMDhkELF/CLjpbZGXKN7d7XIUBV5PZzBmF1fpAR2P48JG9h4E9q1ycv+ET76Mx704a0V9Wur6zohSyajh+p+o+/AYdBI9zYC+JbaPFTX1xjTN4BjSE66SeCJBYQpV0Zlz/qegO61KrVAs0YiQbzN1xqHHJxPki352eo/YNVPNkqFpBL6X0n+Hq3ePFrd8w7QfM1THWg9LpBBccMQY2G7VCD3iVeSaVOhELbXY3Ells/wQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id C89B118015CD;
	Tue, 30 Jun 2026 19:17:56 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 3/7] xdp: add bpf_xdp_metadata_rx_csum() RX metadata kfunc
Date: Tue, 30 Jun 2026 22:15:06 +0300
Message-ID: <20260630191510.81402-4-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX5lZt3LKW5MxB
 KOf2w1/xIcviEoEQaOuGCUOW3Qu4YoOzP2r/jxKOp/xkfx+nc103w88NGw6oaik1Aw0ucnyfgy6
 q51JE3PUSbyWuJCIwXSUuJB8HhNVjAz+3TFdXZvpflRSyskxu4WnIUa+0dv8M/zLmKBhrrYqUqS
 lExRkuOjX9JNOjGXr1bCaopb8a6q8iLBatcwbJQ07YuMG+SnvZJwCqYxw0zJK6q638tlxlmyL1K
 bEuqkPIy/Mi4aXb6vehve7Atb3nPko21xgILkFzDObFbGishJTjCnlEDhdJuWepr2xgExeeROmN
 X03WtXgMwbnn1IrgRfj
X-Proofpoint-ORIG-GUID: b-iRx3IjrmUO2LPF5_GoeRGtW8y7XxhU
X-Proofpoint-GUID: b-iRx3IjrmUO2LPF5_GoeRGtW8y7XxhU
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303341-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38AAC6E781C

Add a device-bound RX-metadata kfunc that reports the hardware
checksum verdict (enum xdp_csum_status: XDP_CSUM_NONE / XDP_CSUM_VERIFIED)
through a new xmo_rx_csum operation, so an XDP program can make an
informed decision (e.g. call bpf_xdp_assert_rx_csum()) instead of trusting
blindly.  Wire it into the XDP_METADATA_KFUNC machinery and advertise it
via NETDEV_XDP_RX_METADATA_CSUM.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 Documentation/netlink/specs/netdev.yaml |  5 +++++
 include/net/xdp.h                       | 12 ++++++++++++
 include/uapi/linux/netdev.h             |  3 +++
 net/core/xdp.c                          | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  3 +++
 5 files changed, 46 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 5f143da7458c..86017f7402d9 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -61,6 +61,11 @@ definitions:
         doc: |
           Device is capable of exposing receive packet VLAN tag via
           bpf_xdp_metadata_rx_vlan_tag().
+      -
+        name: csum
+        doc: |
+          Device is capable of exposing receive packet checksum status via
+          bpf_xdp_metadata_rx_csum().
   -
     type: flags
     name: xsk-flags
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 5a1e2cc9c312..40f6fba41962 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -597,6 +597,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
+			   NETDEV_XDP_RX_METADATA_CSUM, \
+			   bpf_xdp_metadata_rx_csum, \
+			   xmo_rx_csum) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -654,12 +658,20 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+/* Checksum status reported by bpf_xdp_metadata_rx_csum(). */
+enum xdp_csum_status {
+	XDP_CSUM_NONE = 0,	/* HW did not validate the checksum */
+	XDP_CSUM_VERIFIED,	/* HW validated the L4 checksum; it is correct */
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
+			       enum xdp_csum_status *csum_status);
 };
 
 #ifdef CONFIG_NET
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2f3ab75e8cc0..99cda716f0ee 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -47,11 +47,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive packet
+ *   checksum status via bpf_xdp_metadata_rx_csum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CSUM = 8,
 };
 
 /**
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 63ee36ec93de..7f4b5c6f7c87 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -964,6 +964,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_csum - Read the device's RX checksum verdict.
+ * @ctx: XDP context pointer.
+ * @csum_status: Destination pointer for the checksum status.
+ *
+ * Report what the hardware concluded about the packet's checksum, so the
+ * program can decide whether to assert it (e.g. via bpf_xdp_assert_rx_csum()
+ * before a cpumap redirect) instead of having the stack validate it again.
+ *
+ * On ``XDP_CSUM_VERIFIED`` the device has checked the L4 checksum and it is
+ * correct. ``XDP_CSUM_NONE`` means the device did not validate it.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
+ * * ``-ENODATA``    : checksum information is not available
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+					 enum xdp_csum_status *csum_status)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * bpf_xdp_assert_rx_csum - Assert the packet's L4 checksum is correct.
  * @ctx: XDP context pointer.
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 2f3ab75e8cc0..99cda716f0ee 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -47,11 +47,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive packet
+ *   checksum status via bpf_xdp_metadata_rx_csum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CSUM = 8,
 };
 
 /**
-- 
2.47.0


