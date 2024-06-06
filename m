Return-Path: <netdev+bounces-101532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED038FF418
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7D0B22B02
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349C1990DC;
	Thu,  6 Jun 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VMAv23Lm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7B1FAA
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696299; cv=none; b=pjEYHLf5u164krNuhfwkQvOVb4X40LnyOdhhylt2B2jgD2aVaTqgokCVzdcvL0D/cqGfjR4bE9nhBjdyggMJW1K0pVahEpxgV7FgqCQ0/H3AOrdHQMnJ7FWmocTc+Q5i1WOBnRmQSJhXzUAkT14YSFtouVsWVO9Brq7DxF74FKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696299; c=relaxed/simple;
	bh=/6XWtAJvxpRAhPtjOC/YlU5wZPql/oGV385pjFQ7J7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FejxqwEFkktGaXySG/YHN2CfPvcV/wB2P4yAePlHMKp/iprf0MtVGqr1mejiRt9mvNbgbIBvylIDFhadiRHj/UlBJX733uiNX8BZOQ76p//nVl+Ge3sKSNeCHvpETXNDyVf1zPupqjp8CeAxnCbqQvRekj5KlveaTfVourCRbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VMAv23Lm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f94086e1ccso745082a34.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717696296; x=1718301096; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vNHcogskWfVK3C3BZFdMYSyV9rtHd7dUKRAlnAR6LE=;
        b=VMAv23LmZkbw0uVYPt4KhTgBRyTd9q0AX2Iq+RAfey+rNVAyvXil6okpWamVh+ObQF
         Alye+fNK68SLlcBTYwnhXpEoJxX/IrO7Cb+pl8wxE8Q/5UgD8X/djfeYq2TKdEB0bf0G
         E0PjYL1AJjTLas1lMcKIF4FKi6mqTJ8v4kya8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717696296; x=1718301096;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vNHcogskWfVK3C3BZFdMYSyV9rtHd7dUKRAlnAR6LE=;
        b=Lodz6DpT6CggEbgsIhqN5wntxTz5dmzbLLY+ze3lUgUJri/Rkk/BzxI9FV51LhKd3e
         y/nmt/DDRudgfdA+BO3g1coTUt/hGc3NY5s4fXGvB3f7Th9VNVkEX3IRBt+20arcOtFQ
         kiRSfMiQNqNXUNb0VYJrfR4vcfcSwYIOawBr/8/D6BjaxKTwr39BfBbgMN6IHUIbtNWr
         /GzUrxC3VuCUpW4zMnE9MgJSYmSpM03Kk65ygSRvkIRHdRf6lZ566W3HLE4U2Sl0bFki
         QmAz92BDwdAoRtC3DKYdvw50vhUCYmdl4MkAzzOn70WdcoPv8hvYEcAO5Iftnxk3yqQ6
         whkg==
X-Gm-Message-State: AOJu0YxL504jnaTAD0o0fLe8/eTRQ8zE8lmEVCZ58EJ9qMqPk+mLkACN
	aBFTSwb7V/BeBHc577X4UbeNc8IGbVRxDXyDsuBRfCDZuvE1t87RvnImbvBGyw==
X-Google-Smtp-Source: AGHT+IHXXbQqP/wkV3Z9gnTU2N4nO/da6jMJOONWSLdWRKylFmrvL+3BJsiObgnSdMLJysZ9x1leWA==
X-Received: by 2002:a05:6870:f10c:b0:24c:b820:6fe3 with SMTP id 586e51a60fabf-254644e8509mr248334fac.22.1717696296260;
        Thu, 06 Jun 2024 10:51:36 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532811283sm81391585a.11.2024.06.06.10.51.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:51:35 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response
Date: Thu,  6 Jun 2024 10:51:07 -0700
Message-ID: <20240606175107.53130-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009cb328061a3c55fa"

--0000000000009cb328061a3c55fa
Content-Transfer-Encoding: 8bit

Firmware interface 1.10.2.118 has increased the size of
HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
forwarded.  When the VF's link state is not the default auto state,
the PF will need to forward the response back to the VF to indicate
the forced state.  This regression may cause the VF to fail to
initialize.

Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
96 bytes.  Also modify bnxt_hwrm_fwd_resp() to print a warning if the
message size exceeds 96 bytes to make this failure more obvious.

Bug: DCSG01725771
Change-Id: I4cd5e06a7625f9d06e779e4acd9603d355883e7c
Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 48 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  9 +++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 656ab81c0272..94d242aca8d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1434,6 +1434,54 @@ struct bnxt_l2_filter {
 	atomic_t		refcnt;
 };
 
+/* hwrm_port_phy_qcfg_output (size:96 bytes) */
+struct hwrm_port_phy_qcfg_output_compat {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	link;
+	u8	active_fec_signal_mode;
+	__le16	link_speed;
+	u8	duplex_cfg;
+	u8	pause;
+	__le16	support_speeds;
+	__le16	force_link_speed;
+	u8	auto_mode;
+	u8	auto_pause;
+	__le16	auto_link_speed;
+	__le16	auto_link_speed_mask;
+	u8	wirespeed;
+	u8	lpbk;
+	u8	force_pause;
+	u8	module_status;
+	__le32	preemphasis;
+	u8	phy_maj;
+	u8	phy_min;
+	u8	phy_bld;
+	u8	phy_type;
+	u8	media_type;
+	u8	xcvr_pkg_type;
+	u8	eee_config_phy_addr;
+	u8	parallel_detect;
+	__le16	link_partner_adv_speeds;
+	u8	link_partner_adv_auto_mode;
+	u8	link_partner_adv_pause;
+	__le16	adv_eee_link_speed_mask;
+	__le16	link_partner_adv_eee_link_speed_mask;
+	__le32	xcvr_identifier_type_tx_lpi_timer;
+	__le16	fec_cfg;
+	u8	duplex_state;
+	u8	option_flags;
+	char	phy_vendor_name[16];
+	char	phy_vendor_partnumber[16];
+	__le16	support_pam4_speeds;
+	__le16	force_pam4_link_speed;
+	__le16	auto_pam4_link_speed_mask;
+	u8	link_partner_pam4_adv_speeds;
+	u8	valid;
+};
+
 struct bnxt_link_info {
 	u8			phy_type;
 	u8			media_type;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 175192ebaa77..377e66d5a23e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -950,8 +950,11 @@ static int bnxt_hwrm_fwd_resp(struct bnxt *bp, struct bnxt_vf_info *vf,
 	struct hwrm_fwd_resp_input *req;
 	int rc;
 
-	if (BNXT_FWD_RESP_SIZE_ERR(msg_size))
+	if (BNXT_FWD_RESP_SIZE_ERR(msg_size)) {
+		netdev_warn_once(bp->dev, "HWRM fwd response too big (%d bytes)\n",
+				 msg_size);
 		return -EINVAL;
+	}
 
 	rc = hwrm_req_init(bp, req, HWRM_FWD_RESP);
 	if (!rc) {
@@ -1085,7 +1088,7 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
 		rc = bnxt_hwrm_exec_fwd_resp(
 			bp, vf, sizeof(struct hwrm_port_phy_qcfg_input));
 	} else {
-		struct hwrm_port_phy_qcfg_output phy_qcfg_resp = {0};
+		struct hwrm_port_phy_qcfg_output_compat phy_qcfg_resp = {0};
 		struct hwrm_port_phy_qcfg_input *phy_qcfg_req;
 
 		phy_qcfg_req =
@@ -1096,6 +1099,8 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
 		mutex_unlock(&bp->link_lock);
 		phy_qcfg_resp.resp_len = cpu_to_le16(sizeof(phy_qcfg_resp));
 		phy_qcfg_resp.seq_id = phy_qcfg_req->seq_id;
+		phy_qcfg_resp.option_flags &=
+			~PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED;
 		phy_qcfg_resp.valid = 1;
 
 		if (vf->flags & BNXT_VF_LINK_UP) {
-- 
2.30.1


--0000000000009cb328061a3c55fa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJmBON1OCjdZOqmNSnq+oR6RY/+nsIRk
AWOcWOlm8J/QMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYw
NjE3NTEzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA/NFvdN/d/zun2zFT3zNkuUpm9xOGDd7x1lPUoPKLxwlEeHQ51
5fg/BI3erhrWdRW01CWLH+tnUzuGr2h/QZWagPSeLrXJYKBEj/IrRBXrBjoYmGeOl6qcyGGyoaJm
KnGNLNXD9+Xic1Ztotx+y+6BZX86T6aYGUYgd7Xrab80RaD9azkzqaAs5VH5owtBHPg5cr1ea+9k
XCHU6QBW6QpV7e8Oa0ycA/Pq+YHtuXD+XZGK0C6Qa/o6ooNtlItT1kgwDZ8SHTm14bMOFeHyd5EQ
j2d3SIbqxPAWMrxDuicx1RhT6/khXnIdjVcxyektIkCr/JJGjRvUeVRKYhQUd5l9
--0000000000009cb328061a3c55fa--

