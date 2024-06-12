Return-Path: <netdev+bounces-103006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA844905F11
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE681C20F29
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D6412C499;
	Wed, 12 Jun 2024 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WdelUN2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157513210F
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234282; cv=none; b=SivWJWM+WjlviLqXT07xrHjD7O2m8FW0NnNnare1lQn7AL+Gt1gHu1LgZsjN+oyJ7WmgLRicY4DIgHsIf++iOSZX6mP4jBmWhKwPY9oj0TIEzt9qEESXgT1/a/Q0FpYhroOJPmF7tRhxPHa+yUPN9WNwvH8ZDsF7/5Qi2vqmDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234282; c=relaxed/simple;
	bh=PBlEoUgbj+wVo3PfpWLYRq8Sze+UxZjzGAik1yqNSys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MRb0cRsIraPkNccmMZYuza+qAQHR4lENH9k33FMlhl8htXAdLselAsQjFPjeEXV3OF617J7mAzemNfFfy4sgkSiWrq9LXp5saBnFyqQNypmcvU4YgaGEKw6h+1VUKhG1AgeB51iweFzkkbnz+P+Kvcrsejfv3+Z8S1OJos6Y5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WdelUN2R; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70421e78edcso326152b3a.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718234280; x=1718839080; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nZDrRcHHjDFFf70JVqwvoZOLdTMU3sSZTvxA88qB9ig=;
        b=WdelUN2RXDhzm9Jw8wHSUl6+cSCDQqD1KPgoUTPWmhBOU2f2qMu8XprqDRFGrRZ41L
         ayegwgolA2Xqdowx9L4PkA9vKELLrhZVGF9AjHJtdd5k7gUcEMORfbszAQ4Xsm23uxyW
         G8aCsX3lESJsYnoYhYSjB5lwd+OmJUON6KLvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718234280; x=1718839080;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZDrRcHHjDFFf70JVqwvoZOLdTMU3sSZTvxA88qB9ig=;
        b=gPqNqM3YR11lpgrPyYi3sycCd1FxG1QrXuNRJHoBid6nUgM0UWGVNS8jwG1BkE16Y6
         C+cX4mg6ndz6jddhgpBAEBYgWpe+jPjZtMkIzB7YAFUdO5+p2oP3D2wzMdiZPuordSsC
         GZHuDybas7mceCDz9FGV+MXG3BS7hZ7eiT8jSPfFlJU3QYXJxycCe7f9u2YbFUbPj2I9
         o/KfdnnufTnibi/FWzCBr7A+cMFnb7h4FMRBELuKymPzbgZGkM68ADqf0l4JoDE+8NSh
         lqAEgkXMRyuuCED0hO5hNdLJ7HoGKcZgF+1Xhi1O/uXjcRAhbsH8hInISPdcYQEtTU1C
         kwnw==
X-Gm-Message-State: AOJu0YwPbR+gyAkaYIRh2uVGjXCxzG95mGOzRqP/oFDWylpSHvDsDK3g
	H18iWq8ziJjvSdYFDFavHEMNE08ZvcLtkFmrGUbOd6yHZNXzI+d3/o9AxPnj1Q==
X-Google-Smtp-Source: AGHT+IEgQ++4Okwq32UtHwEJ+xixTWLbKBLz9x6RKLDjFJ9gwDZQsNK8SQqNTTRVgjaj97vGtiD6xw==
X-Received: by 2002:a05:6a00:1704:b0:705:9abf:a41d with SMTP id d2e1a72fcca58-705bce0a2cbmr4076452b3a.10.1718234279806;
        Wed, 12 Jun 2024 16:17:59 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb917f2sm94795b3a.189.2024.06.12.16.17.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 16:17:59 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net v3] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response
Date: Wed, 12 Jun 2024 16:17:36 -0700
Message-ID: <20240612231736.57823-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ef6aa3061ab99731"

--000000000000ef6aa3061ab99731
Content-Transfer-Encoding: 8bit

Firmware interface 1.10.2.118 has increased the size of
HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
forwarded.  When the VF's link state is not the default auto state,
the PF will need to forward the response back to the VF to indicate
the forced state.  This regression may cause the VF to fail to
initialize.

Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
96 bytes.  The SPEEDS2_SUPPORTED flag needs to be cleared because the
new speeds2 fields are beyond the legacy structure.  Also modify
bnxt_hwrm_fwd_resp() to print a warning if the message size exceeds 96
bytes to make this failure more obvious.

Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3: Add comment that the last byte of the compat struct is different from
    the original struct.
    Use {} to zero the struct instead of {0}.

v2: Remove Bug and ChangeID from ChangeLog
    Add comment to explain the clearing of the SPEEDS2_SUPPORTED flag

 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 51 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 12 ++++-
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 656ab81c0272..bbc7edccd5a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1434,6 +1434,57 @@ struct bnxt_l2_filter {
 	atomic_t		refcnt;
 };
 
+/* Compat version of hwrm_port_phy_qcfg_output capped at 96 bytes.  The
+ * first 95 bytes are identical to hwrm_port_phy_qcfg_output in bnxt_hsi.h.
+ * The last valid byte in the compat version is different.
+ */
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
index 175192ebaa77..22898d3d088b 100644
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
+		struct hwrm_port_phy_qcfg_output_compat phy_qcfg_resp = {};
 		struct hwrm_port_phy_qcfg_input *phy_qcfg_req;
 
 		phy_qcfg_req =
@@ -1096,6 +1099,11 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
 		mutex_unlock(&bp->link_lock);
 		phy_qcfg_resp.resp_len = cpu_to_le16(sizeof(phy_qcfg_resp));
 		phy_qcfg_resp.seq_id = phy_qcfg_req->seq_id;
+		/* New SPEEDS2 fields are beyond the legacy structure, so
+		 * clear the SPEEDS2_SUPPORTED flag.
+		 */
+		phy_qcfg_resp.option_flags &=
+			~PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED;
 		phy_qcfg_resp.valid = 1;
 
 		if (vf->flags & BNXT_VF_LINK_UP) {
-- 
2.30.1


--000000000000ef6aa3061ab99731
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL4FiT+y+UP4sAZIIlZVTQ4oWbHkj6JE
mZrF7V8gBNXjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYx
MjIzMTgwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBCkh/J4sPt0tElo1FjCSP/g103BBqMQNxm5H1uYkVjN4FjDpp+
k8/9iu6K4BwsR1xt+acVj+D7GFoMRA7fP9+RJXqXjWkE3mfeRPuQVGyJKJhoF6pgdhcPicTyV70s
r/JqraFhp15rWuHempag+ddcHHPov4H5dT13w0QaAZkAaTJHUW3tsbNFFxyweRWsnIhqdZOL6BMZ
VTGBxkYr+J5onLC7+vKhilRO3NCF8q0pSDwGY+lQ6wsp0zqgDYqxPWN80+4CJJ8FdojJMhH+nwF8
bQ7lVuyQkEsBf/doFSLVUS5A0pR3obf1H5vSjvH6Pt3kDZ5XCoEh0MperL6yHyYR
--000000000000ef6aa3061ab99731--

