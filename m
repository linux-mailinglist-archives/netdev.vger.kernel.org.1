Return-Path: <netdev+bounces-296199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N+QOJn4+JWqXEwIAu9opvQ
	(envelope-from <netdev+bounces-296199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:48:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1D64F401
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:48:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=GZDkZ9L5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296199-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4B603011C5C
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255E355813;
	Sun,  7 Jun 2026 09:48:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D32356BE
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 09:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825721; cv=none; b=l+Qt8gD/8M84uO0gdXqRtpLtlvESQ+kJyVOm+uI0J5eQrfzHGkS0ApK4H33XhcsY9oyPiN86vueR73PtYWKV9kKivEjDsV1/xD6B2m1zuWzsUx/iThFHONepy2pGcvjbhy8qhl2IwlVqMf9jhPSMbeCclziOr6h294EpAD7z6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825721; c=relaxed/simple;
	bh=1rNxc1UaHTRXu5r2v0ow8mgrPehoHCYlRVkX/lQ2tCY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s1RPHK/Zx+dvpsm0drxUciEVtkwwWT8bIc5+7sy7uOiMKSNrvCdda3dPT+r1JA/0S0Aw0viV7k+EYkT4aESasNCAfOVFOmO8g02IQ9jeNgCFoWF7TSl0djbTwhS/6tTXBQWNIyj5vrevr0HY6/IUJqQ1g2rCpKd5x9FJ7m394Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GZDkZ9L5; arc=none smtp.client-ip=109.224.244.122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780825713; x=1781084913;
	bh=vQSZRMpoGuLhm10iyqcc9wChC3iOe39cE9LVFeXeHg4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GZDkZ9L5PYFKW97IaLe1KAMMkntmVvjsYUoRDA8qAwH51QrHlFM2lHZt0IBOe2EA+
	 M3pshDse/KEn4MXrFrbmluOYx60RYJxvO8/cP4Y7o+fvaKUph92tUMsOkndIUM3RQo
	 UWaGW4yAUEXReYVlPqfzzk2QlQItxCBzWRtk2KzCXiDU17EVnv1mx/kj1B1rzJkX3W
	 Z0OpLrJr+5jp4ofTjt6KuMXHhot6L+EFdZ2KtVnKsZ/21HGVpPZbFgXop87c9w/qaW
	 VvCMkl+SSqVwcnydLYeO3KY5gl4BinX8SIZDykNQxCePOYOxpQt/EdGIf94YL4YuDX
	 hZ72/2Fl06K1A==
Date: Sun, 07 Jun 2026 09:48:26 +0000
To: David Heidelberg <david+nfc@ixit.cz>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: nci: add data_len bound checks to activation parameter extractors
Message-ID: <20260607094822.322125-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: ee73fa13d558072a404361bd75a1ace81025cebc
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-296199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david+nfc@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:david@ixit.cz,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2A1D64F401

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
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
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
=20
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 =09=09=09=09=09=09 struct nci_rf_intf_activated_ntf *ntf,
-=09=09=09=09=09=09 const __u8 *data)
+=09=09=09=09=09=09 const __u8 *data, __u8 data_len)
 {
 =09struct activation_params_nfca_poll_iso_dep *nfca_poll;
 =09struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
=20
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
=20
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
=20
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
=20
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
=20
 =09=09case NCI_RF_INTERFACE_NFC_DEP:
 =09=09=09err =3D nci_extract_activation_params_nfc_dep(ndev,
-=09=09=09=09=09=09=09=09    &ntf, data);
+=09=09=09=09=09=09=09=09    &ntf, data,
+=09=09=09=09=09=09=09=09    ntf.activation_params_len);
 =09=09=09break;
=20
 =09=09case NCI_RF_INTERFACE_FRAME:
--=20
2.43.0



