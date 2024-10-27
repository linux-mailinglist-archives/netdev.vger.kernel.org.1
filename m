Return-Path: <netdev+bounces-139391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B09B1EF9
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 15:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF5C1C2248C
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C43482CD;
	Sun, 27 Oct 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="MpYlCmCH"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38D168497
	for <netdev@vger.kernel.org>; Sun, 27 Oct 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040394; cv=none; b=J5R8UMrZXVVoZuPljvDiyNSU9n7EaYcLa4Imf9a9rh9rG8lo9HWNQub5IQ/h/LJDlagjIEgl28ze76b5I5kshsUaiwA/x6l0xbdrRenB8Roamn+rkeoo+l2RvZDDA/SKj1iND5R0O4hKyF6DrWDAtV4lTso+GByu0fUNetL/ftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040394; c=relaxed/simple;
	bh=r5PY9bVlWulUR62TcAHZ0bJOd00p78BNAdxHMaTMQDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dEvAQK+CG015NuC6X6A5kmCeUUBD24pcOwkPa5mXuVVONKEGCN5kYxw+mHbDSBWwP9HusTymUjlD6NXcsZisN5SiUSOzdrR9NV7k3tMDwPUudplhOyuNSEZMHvSBD/yr5OMXl1KeogRTe1J3rBOt6h4xuGlSuqnhDFxZW3egdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=MpYlCmCH; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1730039849; bh=r5PY9bVlWulUR62TcAHZ0bJOd00p78BNAdxHMaTMQDY=;
	h=From:To:Cc:Subject:Date;
	b=MpYlCmCH3BkBXQMLxA24FKamvlb8D+N0kStoPCqeHBFAeM21uk9MyZYooGGm5r+xz
	 gbi3HHAR8CZAhvMu7C8oq3Je5HoknKwRB8hK6+0wd9mlaqc6Q8xB08zmlS1trj00oi
	 4NyN7BQy9KinTHMJQ9y+H4Y4Czci3MyVVsX41Kl6ft4Y0tmOR/FDEMX33KKzL4Ulk5
	 LPfxWop8zxhlzn9oT6/hg+89ggZwiO7MVgaegpF3+vII3bRrLThBTa2Ycu+x7DZbc6
	 Iwrev+YikOAByng/5aB9FqMMbOl2egzcySIAQE/yat7FSbpZVsXRMKccL4WnZgWTKd
	 IxaUec9+TVCIQ==
From: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>,
	krzk@kernel.org
Subject: [PATCH net-next] net: nfc: Propagate ISO14443 type A target ATS to userspace via netlink
Date: Sun, 27 Oct 2024 15:37:10 +0100
Message-Id: <20241027143710.5345-1-juraj@sarinay.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a 20-byte field ats to struct nfc_target and expose it as
NFC_ATTR_TARGET_ATS via the netlink interface. The payload contains
'historical bytes' that help to distinguish cards from one another.
The information is commonly used to assemble an emulated ATR similar
to that reported by smart cards with contacts.

Add a 20-byte field target_ats to struct nci_dev to hold the payload
obtained in nci_rf_intf_activated_ntf_packet() and copy it to over to
nfc_target.ats in nci_activate_target(). The approach is similar
to the handling of 'general bytes' within ATR_RES.

Within NCI, the information corresponds to the 'RATS Response' activation
parameter that omits the initial length byte TL. This loses no
information and is consistent with our handling of SENSB_RES that
also drops the first (constant) byte.

Tested with nxp_nci_i2c on a few type A targets including an
ICAO 9303 compliant passport.

I refrain from the corresponding change to digital_in_recv_ats()
to have the few drivers based on digital.h fill nfc_target.ats,
as I have no way to test it. That class of drivers appear not to set
NFC_ATTR_TARGET_SENSB_RES either. Consider a separate patch to propagate
(all) the parameters.

Signed-off-by: Juraj Šarinay <juraj@sarinay.com>
---
 include/net/nfc/nci_core.h |  4 ++++
 include/net/nfc/nfc.h      |  2 ++
 include/uapi/linux/nfc.h   |  3 +++
 net/nfc/nci/core.c         | 13 ++++++++++++-
 net/nfc/nci/ntf.c          | 30 ++++++++++++++++++++++++++++++
 net/nfc/netlink.c          |  5 +++++
 6 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index ea8595651c38..e180bdf2f82b 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -265,6 +265,10 @@ struct nci_dev {
 	/* stored during intf_activated_ntf */
 	__u8 remote_gb[NFC_MAX_GT_LEN];
 	__u8 remote_gb_len;
+
+	/* stored during intf_activated_ntf */
+	__u8 target_ats[NFC_ATS_MAXSIZE];
+	__u8 target_ats_len;
 };
 
 /* ----- NCI Devices ----- */
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 3a3781838c67..72be94e5ecb1 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -105,6 +105,8 @@ struct nfc_target {
 	u8 is_iso15693;
 	u8 iso15693_dsfid;
 	u8 iso15693_uid[NFC_ISO15693_UID_MAXSIZE];
+	u8 ats_len;
+	u8 ats[NFC_ATS_MAXSIZE];
 };
 
 /**
diff --git a/include/uapi/linux/nfc.h b/include/uapi/linux/nfc.h
index 4fa4e979e948..2f5b4be25261 100644
--- a/include/uapi/linux/nfc.h
+++ b/include/uapi/linux/nfc.h
@@ -164,6 +164,7 @@ enum nfc_commands {
  * @NFC_ATTR_VENDOR_SUBCMD: Vendor specific sub command
  * @NFC_ATTR_VENDOR_DATA: Vendor specific data, to be optionally passed
  *	to a vendor specific command implementation
+ * @NFC_ATTR_TARGET_ATS: ISO 14443 type A target Answer To Select
  */
 enum nfc_attrs {
 	NFC_ATTR_UNSPEC,
@@ -198,6 +199,7 @@ enum nfc_attrs {
 	NFC_ATTR_VENDOR_ID,
 	NFC_ATTR_VENDOR_SUBCMD,
 	NFC_ATTR_VENDOR_DATA,
+	NFC_ATTR_TARGET_ATS,
 /* private: internal use only */
 	__NFC_ATTR_AFTER_LAST
 };
@@ -225,6 +227,7 @@ enum nfc_sdp_attr {
 #define NFC_GB_MAXSIZE			48
 #define NFC_FIRMWARE_NAME_MAXSIZE	32
 #define NFC_ISO15693_UID_MAXSIZE	8
+#define NFC_ATS_MAXSIZE			20
 
 /* NFC protocols */
 #define NFC_PROTO_JEWEL		1
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index f456a5911e7d..1ec5955fe469 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -757,6 +757,14 @@ int nci_core_conn_close(struct nci_dev *ndev, u8 conn_id)
 }
 EXPORT_SYMBOL(nci_core_conn_close);
 
+static void nci_set_target_ats(struct nfc_target *target, struct nci_dev *ndev)
+{
+	if (ndev->target_ats_len > 0) {
+		target->ats_len = ndev->target_ats_len;
+		memcpy(target->ats, ndev->target_ats, target->ats_len);
+	}
+}
+
 static int nci_set_local_general_bytes(struct nfc_dev *nfc_dev)
 {
 	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
@@ -939,8 +947,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 				 msecs_to_jiffies(NCI_RF_DISC_SELECT_TIMEOUT));
 	}
 
-	if (!rc)
+	if (!rc) {
 		ndev->target_active_prot = protocol;
+		if (protocol == NFC_PROTO_ISO14443)
+			nci_set_target_ats(target, ndev);
+	}
 
 	return rc;
 }
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 994a0a1efb58..9259a30964cd 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -531,6 +531,28 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	return NCI_STATUS_OK;
 }
 
+static int nci_store_ats_nfc_iso_dep(struct nci_dev *ndev,
+				     const struct nci_rf_intf_activated_ntf *ntf)
+{
+	ndev->target_ats_len = 0;
+
+	if (ntf->activation_params_len <= 0)
+		return NCI_STATUS_OK;
+
+	if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > NFC_ATS_MAXSIZE) {
+		pr_debug("ATS too long\n");
+		return NCI_STATUS_RF_PROTOCOL_ERROR;
+	}
+
+	if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > 0) {
+		ndev->target_ats_len = ntf->activation_params.nfca_poll_iso_dep.rats_res_len;
+		memcpy(ndev->target_ats, ntf->activation_params.nfca_poll_iso_dep.rats_res,
+		       ndev->target_ats_len);
+	}
+
+	return NCI_STATUS_OK;
+}
+
 static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					     const struct sk_buff *skb)
 {
@@ -660,6 +682,14 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 			if (err != NCI_STATUS_OK)
 				pr_err("unable to store general bytes\n");
 		}
+
+		/* store ATS to be reported later in nci_activate_target */
+		if (ntf.rf_interface == NCI_RF_INTERFACE_ISO_DEP &&
+		    ntf.activation_rf_tech_and_mode == NCI_NFC_A_PASSIVE_POLL_MODE) {
+			err = nci_store_ats_nfc_iso_dep(ndev, &ntf);
+			if (err != NCI_STATUS_OK)
+				pr_err("unable to store ATS\n");
+		}
 	}
 
 	if (!(ntf.activation_rf_tech_and_mode & NCI_RF_TECH_MODE_LISTEN_MASK)) {
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index dd2ce73a24fb..6a40b8d0350d 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -96,6 +96,11 @@ static int nfc_genl_send_target(struct sk_buff *msg, struct nfc_target *target,
 			goto nla_put_failure;
 	}
 
+	if (target->ats_len > 0 &&
+	    nla_put(msg, NFC_ATTR_TARGET_ATS, target->ats_len,
+		    target->ats))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
-- 
2.39.5


