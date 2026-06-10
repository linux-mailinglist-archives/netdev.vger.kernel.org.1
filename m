Return-Path: <netdev+bounces-297485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ekqkD3sIKWpgPAMAu9opvQ
	(envelope-from <netdev+bounces-297485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:47:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AF76665DD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:47:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=G0pDnmEy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297485-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297485-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BC4F30034A7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FCF3769F6;
	Wed, 10 Jun 2026 06:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FA375F9C
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073686; cv=none; b=RAGjTsBRisFD3yVFqx6QBuuneKievx2WVxjqmhSf2figpTWVBO3yUCXfv+o3Kh7GdHNDQX8h16OgFMe/+bbvdSmLw/WepGW4mjIdWouoh9MPeiHePCFr9ajQSfYQOldkGaFEI3c3zzcY9evTk2tmk+4jqWp0xnlgdhRfQ5D0bT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073686; c=relaxed/simple;
	bh=5ohSV1senSBYP367LMcv7ypDaWZ2ZIHigLiKwiF4Wdk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kAweiy1JWAUDVx6+q+r6YOeFecTcPycSSilm9M8XRpLSTK7ruFLwESHFX7VbkD5+Rw4Itn+AtmpR9H3ike3vxzpq2oQamlwAfsPsIaN1GUiJkrY62+ZPi/CMPiwSRoZ64m5b32cICd9o08oTewTkyBi45Pvtt5a8003/ZObQ4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=G0pDnmEy; arc=none smtp.client-ip=79.135.106.119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781073675; x=1781332875;
	bh=28RGYCY/6vRrF5swlXj8TafDmaZjT45mQ9JGQeGoON8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=G0pDnmEyt9TFQ4uo1eiZVjpcj4HoqpOkAW2arjEsV9dW/yFAOhYIXintCgq6mYwaH
	 yeOr52jfErh1gA7eZ9sZg7FNtxf7AH4uv7Ur+K4xof1WQMgvpN/KQuJ+XKB2yZTyrL
	 BsmglJZPzuJaCek++j56gP7U6bRWFEFI95Nlo5/u3UrrmMrbqbuOnOH5Fip4D6zDBo
	 x4T8C8NalNo0PVYl4lGx/9Rxxa5jbip0yjCNc9MYbeYRT2kbJCdUVlVVJTBPWS84rs
	 zblG2ne5tzxVlV5iFB2yp4m/PbgSnGIGgANpZS3fi1g6+//JGpZZNnZ7/P/OQEUC9L
	 KzZcEbumwWPtw==
Date: Wed, 10 Jun 2026 06:41:10 +0000
To: David Heidelberg <david@ixit.cz>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nfc: nci: add data_len bound checks to activation parameter extractors
Message-ID: <20260610064104.143042-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 369b714db19cee64cd16caeac9ccaaa9313e7c48
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297485-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31AF76665DD

nci_extract_activation_params_iso_dep() and
nci_extract_activation_params_nfc_dep() read an inner length byte from
the NCI RF_INTF_ACTIVATED_NTF payload and use it to memcpy() into fixed
kernel buffers, but neither function receives the caller-validated
activation_params_len.  A crafted NCI notification with
activation_params_len=3D1 and an inner length byte of up to 20 (NFC-A) or
50 (NFC-B) causes memcpy() to read that many bytes past the one valid
byte in the activation params region -- a slab out-of-bounds read of
kernel memory adjacent to the NCI skb.

The sibling nci_extract_rf_params_*() family was given equivalent
protection by commit 571dcbeb8e63 ("net: nfc: nci: Fix parameter
validation for packet data"), but the two activation parameter
extractors were not updated at that time.

Add a data_len parameter to both functions, guard against an empty
region before consuming the inner length byte, decrement the remaining
count after consuming it, and clamp the copy length to what is actually
available.  Update both call sites to pass ntf.activation_params_len,
which is already validated against the skb at ntf.c:801.

Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: no functional change. Resend of
    https://lore.kernel.org/all/20260607094822.322125-1-hexlabsecurity@prot=
on.me/
    (2026-06-07), which did not reach the NFC maintainer: the MAINTAINERS
    address for NFC, david+nfc@ixit.cz, rejected delivery ("550 User
    doesn't exist" -- the +nfc subaddress expanded to
    #/Kernel/Linux/NFC@ixit.cz), so this is resent to david@ixit.cz. Also
    added the Cc: stable tag for the backport and dropped stable@vger from
    the direct Cc (it should follow the mainline merge, not precede it).

Verification (NFC-A ISO-DEP, NFC_ATS_MAXSIZE =3D 20):

  data_len  inner_len  without patch              with patch
  --------  ---------  -------------------------  --------------------
  1         0          rats_res_len=3D0, clean       same
  1         1          memcpy +1B OOB              clamped to 0, clean
  1         20         memcpy +20B OOB  <-- PoC   clamped to 0, clean
  2         2          memcpy +1B OOB              clamped to 1, clean
  21        20         memcpy 20B clean            same

NFC-B (attrib_res, max 50) and NFC-DEP poll/listen (atr_res/atr_req,
max 62) have the same shape and receive the same fix.

 net/nfc/nci/ntf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..753f4cf08748 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev =
*ndev,

 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 =09=09=09=09=09=09 struct nci_rf_intf_activated_ntf *ntf,
-=09=09=09=09=09=09 const __u8 *data)
+=09=09=09=09=09=09 const __u8 *data, __u8 data_len)
 {
 =09struct activation_params_nfca_poll_iso_dep *nfca_poll;
 =09struct activation_params_nfcb_poll_iso_dep *nfcb_poll;

 =09switch (ntf->activation_rf_tech_and_mode) {
 =09case NCI_NFC_A_PASSIVE_POLL_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09nfca_poll =3D &ntf->activation_params.nfca_poll_iso_dep;
 =09=09nfca_poll->rats_res_len =3D min_t(__u8, *data++, NFC_ATS_MAXSIZE);
+=09=09data_len--;
+=09=09nfca_poll->rats_res_len =3D min_t(__u8, nfca_poll->rats_res_len, dat=
a_len);
 =09=09pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 =09=09if (nfca_poll->rats_res_len > 0) {
 =09=09=09memcpy(nfca_poll->rats_res,
@@ -542,8 +546,12 @@ static int nci_extract_activation_params_iso_dep(struc=
t nci_dev *ndev,
 =09=09break;

 =09case NCI_NFC_B_PASSIVE_POLL_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09nfcb_poll =3D &ntf->activation_params.nfcb_poll_iso_dep;
 =09=09nfcb_poll->attrib_res_len =3D min_t(__u8, *data++, 50);
+=09=09data_len--;
+=09=09nfcb_poll->attrib_res_len =3D min_t(__u8, nfcb_poll->attrib_res_len,=
 data_len);
 =09=09pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 =09=09if (nfcb_poll->attrib_res_len > 0) {
 =09=09=09memcpy(nfcb_poll->attrib_res,
@@ -562,7 +570,7 @@ static int nci_extract_activation_params_iso_dep(struct=
 nci_dev *ndev,

 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 =09=09=09=09=09=09 struct nci_rf_intf_activated_ntf *ntf,
-=09=09=09=09=09=09 const __u8 *data)
+=09=09=09=09=09=09 const __u8 *data, __u8 data_len)
 {
 =09struct activation_params_poll_nfc_dep *poll;
 =09struct activation_params_listen_nfc_dep *listen;
@@ -570,9 +578,13 @@ static int nci_extract_activation_params_nfc_dep(struc=
t nci_dev *ndev,
 =09switch (ntf->activation_rf_tech_and_mode) {
 =09case NCI_NFC_A_PASSIVE_POLL_MODE:
 =09case NCI_NFC_F_PASSIVE_POLL_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09poll =3D &ntf->activation_params.poll_nfc_dep;
 =09=09poll->atr_res_len =3D min_t(__u8, *data++,
 =09=09=09=09=09  NFC_ATR_RES_MAXSIZE - 2);
+=09=09data_len--;
+=09=09poll->atr_res_len =3D min_t(__u8, poll->atr_res_len, data_len);
 =09=09pr_debug("atr_res_len %d\n", poll->atr_res_len);
 =09=09if (poll->atr_res_len > 0)
 =09=09=09memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -580,9 +592,13 @@ static int nci_extract_activation_params_nfc_dep(struc=
t nci_dev *ndev,

 =09case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 =09case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09listen =3D &ntf->activation_params.listen_nfc_dep;
 =09=09listen->atr_req_len =3D min_t(__u8, *data++,
 =09=09=09=09=09    NFC_ATR_REQ_MAXSIZE - 2);
+=09=09data_len--;
+=09=09listen->atr_req_len =3D min_t(__u8, listen->atr_req_len, data_len);
 =09=09pr_debug("atr_req_len %d\n", listen->atr_req_len);
 =09=09if (listen->atr_req_len > 0)
 =09=09=09memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -806,12 +822,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
i_dev *ndev,
 =09=09switch (ntf.rf_interface) {
 =09=09case NCI_RF_INTERFACE_ISO_DEP:
 =09=09=09err =3D nci_extract_activation_params_iso_dep(ndev,
-=09=09=09=09=09=09=09=09    &ntf, data);
+=09=09=09=09=09=09=09=09    &ntf, data,
+=09=09=09=09=09=09=09=09    ntf.activation_params_len);
 =09=09=09break;

 =09=09case NCI_RF_INTERFACE_NFC_DEP:
 =09=09=09err =3D nci_extract_activation_params_nfc_dep(ndev,
-=09=09=09=09=09=09=09=09    &ntf, data);
+=09=09=09=09=09=09=09=09    &ntf, data,
+=09=09=09=09=09=09=09=09    ntf.activation_params_len);
 =09=09=09break;

 =09=09case NCI_RF_INTERFACE_FRAME:
--
2.43.0


