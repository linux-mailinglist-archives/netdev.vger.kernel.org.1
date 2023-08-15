Return-Path: <netdev+bounces-27573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752BC77C6E0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F00280A95
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673DAD4C;
	Tue, 15 Aug 2023 04:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC1BE4A
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 04:57:29 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30087133
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:57:27 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76cded293e8so334462085a.2
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692075447; x=1692680247;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyScyO8/RdCr5chgyBpGylRo+bWvVKBul58HBBdzCMc=;
        b=RYQRDdiGuH+D9Cc4DDRFQuk9YpCIT1I19CfGk3x2gLY/AQyAl/xiDy67hJP43JZ+eR
         p2KTI436gS+FpZXYbl9iUYwjj0Fs2qAb5l3DmmFMGCp1Oyv6KjmFJAgl75eAHqgd6hI/
         YeR0N/Uxmvz5ezCYYrIldu7GM8RHHKspmZ1/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075447; x=1692680247;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyScyO8/RdCr5chgyBpGylRo+bWvVKBul58HBBdzCMc=;
        b=k1poV7Bm93M2czzdbnmdFbxvJ9YHtSMTonW4oGXwp8e33WB5dLMQlVFG1igrWCdOIh
         qfIZiLDRQAUYJayFD+PbUKxU6z4KuwnXWYqTAbdihbQjBMUN8Vq8uX+Aw3ROI+kdhmwn
         bCX32H01KEp8r2rGiJBRUGaEtaLPdy6ESaMEIJTDB+q1y/rnhe56FXvtDT9gaOiNFppX
         s9NNXLDlJPTKJJkHu76shgj3o9iyVmcDjkdnfG+YSD9e7+o7VJ178Yxus/iVx49JVCVA
         8OFpUV0juehrpKZzkeMWqRVLvBUyhhks4fnPfY9Me2lQl34oaS3Ezy+s+ANgjsLXAagZ
         N2Pw==
X-Gm-Message-State: AOJu0YxC/adsf4dCT8J8/DdKJbItTCbqHIyW9uOnbKCP0leS43GhMePX
	rkscyiOoKdJS8GblSNqZmvQYu8umqjYoe1xI+Ss=
X-Google-Smtp-Source: AGHT+IEDCu7rmxNzJJkCYPPRnnGmiNw2b8lskJpSEnSDj1bsFO+rGrUIfrMuc5hzEBT/Dojn/waO8g==
X-Received: by 2002:a05:620a:850:b0:768:efd:2685 with SMTP id u16-20020a05620a085000b007680efd2685mr12167630qku.33.1692075446789;
        Mon, 14 Aug 2023 21:57:26 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k28-20020a05620a143c00b00767cbd5e942sm3516575qkj.72.2023.08.14.21.57.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:57:26 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures through hwmon
Date: Mon, 14 Aug 2023 21:56:57 -0700
Message-Id: <20230815045658.80494-12-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230815045658.80494-1-michael.chan@broadcom.com>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f670220602ef0303"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000f670220602ef0303
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

HWRM_TEMP_MONITOR_QUERY response now indicates various
threshold temperatures. Expose these threshold temperatures
through the hwmon sysfs.
Also, provide temp1_max_alarm through which the user can check
whether the threshold temperature has been reached or not.

Example:
cat /sys/class/hwmon/hwmon3/temp1_input
75000
cat /sys/class/hwmon/hwmon3/temp1_max
105000
cat /sys/class/hwmon/hwmon3/temp1_max_alarm
0

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 ++
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 71 +++++++++++++++++--
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 84cbcfa61bc1..43a07d84f815 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2013,6 +2013,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_RING_MONITOR		BIT_ULL(30)
 	#define BNXT_FW_CAP_DBG_QCAPS			BIT_ULL(31)
 	#define BNXT_FW_CAP_PTP				BIT_ULL(32)
+	#define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED	BIT_ULL(33)
 
 	u32			fw_dbg_cap;
 
@@ -2185,7 +2186,13 @@ struct bnxt {
 	struct bnxt_tc_info	*tc_info;
 	struct list_head	tc_indr_block_list;
 	struct dentry		*debugfs_pdev;
+#ifdef CONFIG_BNXT_HWMON
 	struct device		*hwmon_dev;
+	u8			warn_thresh_temp;
+	u8			crit_thresh_temp;
+	u8			fatal_thresh_temp;
+	u8			shutdown_thresh_temp;
+#endif
 	enum board_idx		board_idx;
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
index 20381b7b1d78..f5affac1169a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -34,6 +34,15 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
 
 	if (temp)
 		*temp = resp->temp;
+
+	if (resp->flags & TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE) {
+		if (!temp)
+			bp->fw_cap |= BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED;
+		bp->warn_thresh_temp = resp->warn_threshold;
+		bp->crit_thresh_temp = resp->critical_threshold;
+		bp->fatal_thresh_temp = resp->fatal_threshold;
+		bp->shutdown_thresh_temp = resp->shutdown_threshold;
+	}
 err:
 	hwrm_req_drop(bp, req);
 	return rc;
@@ -42,12 +51,30 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
 static umode_t bnxt_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type,
 				     u32 attr, int channel)
 {
+	const struct bnxt *bp = _data;
+
 	if (type != hwmon_temp)
 		return 0;
 
 	switch (attr) {
 	case hwmon_temp_input:
 		return 0444;
+	case hwmon_temp_lcrit:
+	case hwmon_temp_crit:
+	case hwmon_temp_emergency:
+	case hwmon_temp_lcrit_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_emergency_alarm:
+		if (~bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED)
+			return 0;
+		return 0444;
+	/* Max temperature setting in NVM is optional */
+	case hwmon_temp_max:
+	case hwmon_temp_max_alarm:
+		if (~bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED ||
+		    !bp->shutdown_thresh_temp)
+			return 0;
+		return 0444;
 	default:
 		return 0;
 	}
@@ -66,6 +93,38 @@ static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
 		if (!rc)
 			*val = temp * 1000;
 		return rc;
+	case hwmon_temp_lcrit:
+		*val = bp->warn_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_crit:
+		*val = bp->crit_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_emergency:
+		*val = bp->fatal_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_max:
+		*val = bp->shutdown_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_lcrit_alarm:
+		rc = bnxt_hwrm_temp_query(bp, &temp);
+		if (!rc)
+			*val = temp >= bp->warn_thresh_temp;
+		return rc;
+	case hwmon_temp_crit_alarm:
+		rc = bnxt_hwrm_temp_query(bp, &temp);
+		if (!rc)
+			*val = temp >= bp->crit_thresh_temp;
+		return rc;
+	case hwmon_temp_emergency_alarm:
+		rc = bnxt_hwrm_temp_query(bp, &temp);
+		if (!rc)
+			*val = temp >= bp->fatal_thresh_temp;
+		return rc;
+	case hwmon_temp_max_alarm:
+		rc = bnxt_hwrm_temp_query(bp, &temp);
+		if (!rc)
+			*val = temp >= bp->shutdown_thresh_temp;
+		return rc;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -73,7 +132,11 @@ static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
 
 static const struct hwmon_channel_info *bnxt_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT),
+			   HWMON_T_INPUT |
+			   HWMON_T_MAX | HWMON_T_LCRIT |
+			   HWMON_T_CRIT | HWMON_T_EMERGENCY |
+			   HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_EMERGENCY_ALARM),
 	NULL
 };
 
@@ -97,13 +160,11 @@ void bnxt_hwmon_uninit(struct bnxt *bp)
 
 void bnxt_hwmon_init(struct bnxt *bp)
 {
-	struct hwrm_temp_monitor_query_input *req;
 	struct pci_dev *pdev = bp->pdev;
 	int rc;
 
-	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
-	if (!rc)
-		rc = hwrm_req_send_silent(bp, req);
+	/* temp1_xxx is only sensor, ensure not registered if it will fail */
+	rc = bnxt_hwrm_temp_query(bp, NULL);
 	if (rc == -EACCES || rc == -EOPNOTSUPP) {
 		bnxt_hwmon_uninit(bp);
 		return;
-- 
2.30.1


--000000000000f670220602ef0303
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN44ovTSaE56EC9MTsl20jlAMfkDWnIH
ex/4d0yrxHgsMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NTA0NTcyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCem9SF7GPF+ACxfddL0AAEb+yOcxXBAeCrkc0VW6LdsUJDtsua
LnvMqD0CPA/gCT2wlSbaXNE35Xy2EPH6TEv49TrE9bLZR2UR7Dt/Zh6q5arDb4nlClKDwdkOyudS
c6rk3DOeJ5gNQ1CC2yr1o9QIr4SzJAqMq7+ybwzdh5ACxaKrpnIH7SDKdINlqfR29THlNGWZjfEw
gmiHjqXDADRbuX1nYgo8fUMnLPVrYx/Yz6RxwW0AWxNFbVf1czZVRt3e4Tj5Loj55zRkvviZIhAt
b4O7BH8Sj45QOGLdqORn8ghMDOgRsXr/SiwIrJcsvyLc83FS9hCgXZOz9176U/m9
--000000000000f670220602ef0303--

