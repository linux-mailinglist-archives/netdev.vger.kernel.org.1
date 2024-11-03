Return-Path: <netdev+bounces-141280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98789BA570
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 13:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61181C20D54
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76141EB5B;
	Sun,  3 Nov 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="oM0U+ltR"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C52A50
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730637935; cv=none; b=sEdw/cXI8liIEWbQ1h9dHuy9LQ9vcblax6afP/3tv7t4YNvzIvS8gLSZXeSoNUHDf67Vy1qN1KjsyuqDyTrQRBw5P0l85HEQGc+fuV0kXxD6Sxe5a2R8ivBCK6tGhfQkuDMgTj390uXv39Ap+9URGwHA95fo/+DRpC6xNPeN5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730637935; c=relaxed/simple;
	bh=axG7UUWgL6+y8w3rR5thrd92/BueE/DU71S1yOBFF+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jxylB1APVGNzs9LVlXUEMfv8VKCx2JQrG4E7RTEnKZKtVcpw6gtMZmWVF/GB2kGOrHakwEB98EozKqatDSI6l7j/FAfKIazxJO9LJVMwyQongm/s/eM/R52M07PYB9VgErvtZ1blKTb7Ufs6c4I3NRrjUTtREnCkmMzwabmBSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=oM0U+ltR; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1730637931; bh=axG7UUWgL6+y8w3rR5thrd92/BueE/DU71S1yOBFF+U=;
	h=From:To:Cc:Subject:Date;
	b=oM0U+ltRx30xN6FvWA/DeIgAXa6w7Fb7Mluup9c+FO1Ayaruc4Gmuq5kasNI63Qyv
	 S1f3UfZ/ugfEN6EizoYaTY5HMRULVzlFtzmwW31SGOdTh13WdsrCibGzohBbpMNWL7
	 F0OF5bDRSVe3fc+cjQhqc3m4cEvSAP9TuZ7bje2nWbVNz3UAgJvR2aijhUX5sVTyIw
	 Q5uSFZxNj62JXwNdePdQM4Jahk+iItioZQ5r0RFAQAjDtYNK2J9+ynvoB7lQ1o/xHB
	 tKuYnvZN9ZlCdk5hnGbZxYHgrUbKpmirlNSv9/HyesazqvLAjBydL+SgcyDnZsIOid
	 ClEH1Si/UNzyQ==
From: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>,
	krzk@kernel.org,
	kuba@kernel.org
Subject: [PATCH net-next v2] net: nfc: Propagate ISO14443 type A target ATS to userspace via netlink
Date: Sun,  3 Nov 2024 13:45:25 +0100
Message-Id: <20241103124525.8392-1-juraj@sarinay.com>
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

Replace the hard-coded size of rats_res within struct
activation_params_nfca_poll_iso_dep by the equal constant NFC_ATS_MAXSIZE
now defined in nfc.h

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
v2:
  - add kdoc to new entries in struct nfc_target as suggested by Jakub Kicinski
  - use NFC_ATS_MAXSIZE as the length of the relevant buffer within
    struct activation_params_nfca_poll_iso_dep instead of the integer 20
v1: https://lore.kernel.org/netdev/20241027143710.5345-1-juraj@sarinay.com/

 include/net/nfc/nci.h      |  2 +-
 include/net/nfc/nci_core.h |  4 ++++
 include/net/nfc/nfc.h      |  4 ++++
 include/uapi/linux/nfc.h   |  3 +++
 net/nfc/nci/core.c         | 13 ++++++++++++-
 net/nfc/nci/ntf.c          | 32 +++++++++++++++++++++++++++++++-
 net/nfc/netlink.c          |  5 +++++
 7 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/net/nfc/nci.h b/include/net/nfc/nci.h
index dc36519d16aa..09efcaed7c3f 100644
--- a/include/net/nfc/nci.h
+++ b/include/net/nfc/nci.h
@@ -475,7 +475,7 @@ struct nci_rf_discover_ntf {
 #define NCI_OP_RF_INTF_ACTIVATED_NTF	nci_opcode_pack(NCI_GID_RF_MGMT, 0x05)
 struct activation_params_nfca_poll_iso_dep {
 	__u8	rats_res_len;
-	__u8	rats_res[20];
+	__u8	rats_res[NFC_ATS_MAXSIZE];
 };
 
 struct activation_params_nfcb_poll_iso_dep {
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
index 3a3781838c67..127e6c7d910d 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -86,6 +86,8 @@ struct nfc_ops {
  *	is a type A one. The %sens_res most significant byte must be byte 2
  *	as described by the NFC Forum digital specification (i.e. the platform
  *	configuration one) while %sens_res least significant byte is byte 1.
+ * @ats_len: length of Answer To Select in bytes
+ * @ats: Answer To Select returned by an ISO 14443 Type A target upon activation
  */
 struct nfc_target {
 	u32 idx;
@@ -105,6 +107,8 @@ struct nfc_target {
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
index 994a0a1efb58..a818eff27e6b 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -402,7 +402,7 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
-		nfca_poll->rats_res_len = min_t(__u8, *data++, 20);
+		nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
 			memcpy(nfca_poll->rats_res,
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


