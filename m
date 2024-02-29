Return-Path: <netdev+bounces-76034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB186C18E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87530B237D3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7D6446B8;
	Thu, 29 Feb 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GcB56wtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0942A9F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190138; cv=none; b=kddlOCi1UDra+sM1yYZIAZiQXY4Zw9CwCW6E8Cug/bAq7++8wx3uP81fc/qPZWfJ/6IXPnnRrMM+VjdI9bByl0TyhJ9RKgIU0swAC2xSdUEUuF4+o/ZkymjGeNRTgEiETZ5XC6lpRuEXQZDAqKSQWkVwd4xV9fceaJeHAqBQGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190138; c=relaxed/simple;
	bh=FzSXRtwRfKu7eLDckEh3hLskQ1J7yN1djpzFd8DNHgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COHA4xbeaFXnStKc5TVvGDH+34gxdU+sGgEXZzBwWRnIzUpeWXeaghB86twzpYlXgLIKLLAjouVbrF07NbZPxIj/yjKmp6oC4DeoBwh1zP7hXrQ4upiQUdIKD7dELMM5roqdHn3cEjNdlbxYLQGSW56NVq9gk398FSxAJQ4z/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GcB56wtM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-787f27e634cso48997685a.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709190135; x=1709794935; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3itgKCvODrsOQvpOat3Ct+8Dtegz1tErhxfAWiZcAg=;
        b=GcB56wtMNN9szBCXHB4gf2/Bgcul6+scZ/2K5mYzd2v4se3JML8ALnnf1YaVxFW+L8
         nV/f/+EIkMMHni597IcC5VgQ0XCiDkndxn3MzUPFISlXfNVt0pxTw6ctCPkTQ3Aiks9q
         Mnho93/Fzcx/oRO6xUhf62xjbN6PbGEUl84ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709190135; x=1709794935;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3itgKCvODrsOQvpOat3Ct+8Dtegz1tErhxfAWiZcAg=;
        b=AGfIvl6ey4SCKdRYxjMz99TMgVCeVL5m0iOMjfkCqxsUKNZGI4P7F/l6hHf+PJ45x9
         58C1U9c/Sv5dg1srASMUNUwvsOKveuJYqxnygDH7MPgzrHwBcWlC4lSLP2STqfmAGOCw
         oQE5rspIHUrFWyR1MmVjuulkFDxk+HSl3uhc8JoO9ds4l1N1OQvSBsFh3w9vBN8HwW6H
         DJtZ1PYETTmvSbmfIogR0LO00QSW4UL4601VKV7qol4zOX+Hu7FHpouZXW1eeHicHOkY
         KHkMLWZuaujYcaBjXW6QQozylxCTcQscx/bg5aE/gScUpBhehjj/9mHhiN1vqLXDi8V9
         mlGg==
X-Gm-Message-State: AOJu0YyzCexy3qL+yE+rlyV6kjPp2HqVhhdJcwNhg3nr0UwUhubtuXJ5
	+hPHUgnA9+UNcDz3e+MMe0yp+gd/vrtXWT9psgLBk23qa7A9iCMWCeYfSRSvLg==
X-Google-Smtp-Source: AGHT+IEz26Mlz+gMMecj3ezNdH5qLTtKGIL4i0GvfWtH0yApaq+gPAzDu0ejJDsBAHTt46MohVcHYg==
X-Received: by 2002:ad4:42cf:0:b0:690:452b:ec60 with SMTP id f15-20020ad442cf000000b00690452bec60mr1314522qvr.40.1709190135371;
        Wed, 28 Feb 2024 23:02:15 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id mv1-20020a056214338100b0068f75622543sm435545qvb.1.2024.02.28.23.02.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2024 23:02:15 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	jiri@resnulli.us,
	richardcochran@gmail.com
Subject: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver param to set ptp tx timeout
Date: Wed, 28 Feb 2024 23:02:01 -0800
Message-Id: <20240229070202.107488-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240229070202.107488-1-michael.chan@broadcom.com>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e4985e06127fd697"

--000000000000e4985e06127fd697
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Sometimes, the current 1ms value that driver waits for firmware
to obtain a tx timestamp for a PTP packet may not be sufficient.
User may want the driver to wait for a longer custom period before
timing out.

Introduce a new runtime driver param for devlink "ptp_tx_timeout".
Using this parameter the driver can wait for up to the specified
time, when it is querying for a TX timestamp from firmware.  By
default the value is set to 1s.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 42 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  3 ++
 3 files changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index ae4529c043f0..0df0baa9d18c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -652,6 +652,7 @@ static const struct devlink_ops bnxt_vf_dl_ops;
 enum bnxt_dl_param_id {
 	BNXT_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	BNXT_DEVLINK_PARAM_ID_GRE_VER_CHECK,
+	BNXT_DEVLINK_PARAM_ID_PTP_TXTS_TMO,
 };
 
 static const struct bnxt_dl_nvm_param nvm_params[] = {
@@ -1077,6 +1078,42 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 	return rc;
 }
 
+static int bnxt_dl_ptp_param_get(struct devlink *dl, u32 id,
+				 struct devlink_param_gset_ctx *ctx)
+{
+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
+
+	if (!bp->ptp_cfg)
+		return -EOPNOTSUPP;
+
+	ctx->val.vu32 = bp->ptp_cfg->txts_tmo;
+	return 0;
+}
+
+static int bnxt_dl_ptp_param_set(struct devlink *dl, u32 id,
+				 struct devlink_param_gset_ctx *ctx)
+{
+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
+
+	if (!bp->ptp_cfg)
+		return -EOPNOTSUPP;
+
+	bp->ptp_cfg->txts_tmo = ctx->val.vu32;
+	return 0;
+}
+
+static int bnxt_dl_ptp_param_validate(struct devlink *dl, u32 id,
+				      union devlink_param_value val,
+				      struct netlink_ext_ack *extack)
+{
+	if (val.vu32 > BNXT_PTP_MAX_TX_TMO) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "TX timeout value exceeds the maximum (%d ms)",
+				       BNXT_PTP_MAX_TX_TMO);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
 				 struct devlink_param_gset_ctx *ctx)
 {
@@ -1180,6 +1217,11 @@ static const struct devlink_param bnxt_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			     bnxt_dl_nvm_param_get, bnxt_dl_nvm_param_set,
 			     NULL),
+	DEVLINK_PARAM_DRIVER(BNXT_DEVLINK_PARAM_ID_PTP_TXTS_TMO,
+			     "ptp_tx_timeout", DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     bnxt_dl_ptp_param_get, bnxt_dl_ptp_param_set,
+			     bnxt_dl_ptp_param_validate),
 	/* keep REMOTE_DEV_RESET last, it is excluded based on caps */
 	DEVLINK_PARAM_GENERIC(ENABLE_REMOTE_DEV_RESET,
 			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index cc07660330f5..4b50b07b9771 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -965,6 +965,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 		spin_unlock_bh(&ptp->ptp_lock);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
+	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
 	return 0;
 
 out:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index fce8dc39a7d0..ee977620d33e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -22,6 +22,8 @@
 #define BNXT_LO_TIMER_MASK	0x0000ffffffffUL
 #define BNXT_HI_TIMER_MASK	0xffff00000000UL
 
+#define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
+#define BNXT_PTP_MAX_TX_TMO	5000 /* ms */
 #define BNXT_PTP_QTS_TIMEOUT	1000
 #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
 				 PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT | \
@@ -120,6 +122,7 @@ struct bnxt_ptp_cfg {
 
 	u32			refclk_regs[2];
 	u32			refclk_mapped_regs[2];
+	u32			txts_tmo;
 };
 
 #if BITS_PER_LONG == 32
-- 
2.30.1


--000000000000e4985e06127fd697
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG0fPFjPNOTL5poUrCeVRLgpRB7MgdYc
EGW79x4YNF9fMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
OTA3MDIxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBvSOfOYJwOJ7eA2oc3x5OAzEMjEIJkQx6UOMB1d1Y44Ra4sJAv
VkfS8a1XUVP3f0C6dDOolYmxr560KjDs9phFRl11MSX/rOMvFY4l1Y51AOJQ832WtAcB+WxEs+S9
qjRehoypLeZT3CxeZXWRq2drJLXTPm/60eYTnF3NJqeUyVBYY+Aq3ESPKMN98/0RZXxSpeEcNLMi
sjJKnZo0uYmJWBDufHmpoz7CkfG1J5k9P3hfFujXLoiOhkReTpqolL+HT1k+k3TR9IlBHnlv3aZJ
dXdF4TJZ5xcC4AHoYwmGQq5Xm0vf/n1lr3dE2VxeGP/bxG6k6lu2bM1XdR5pDjHW
--000000000000e4985e06127fd697--

