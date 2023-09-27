Return-Path: <netdev+bounces-36405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0977AF8EB
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 66761281B4C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55413AD7;
	Wed, 27 Sep 2023 03:58:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652813AE0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:58:13 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EA1A674
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:11 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4195035800fso15734751cf.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695787090; x=1696391890; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl0hhsXYDhWDf8zf9m+b1HhzasuTX4OsK5qZT6eI6WI=;
        b=eeK6cA4dQKZfFBuNU07oeF0vN7Xh84qFsq60qtF7uP1K3/vPQDem/iICQ4TP0DFn7/
         mgQk1B+xp/Mw/5eggcPtvMeyGpo0Fql5crLz1VWq2xlvUTChIrTV1kShVi+z6f3RjPMn
         FR1XKpGEV/WPyZHcg2IxbzRpkx7jgPU1a0k54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787090; x=1696391890;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl0hhsXYDhWDf8zf9m+b1HhzasuTX4OsK5qZT6eI6WI=;
        b=pUyE0HJB5JhhIp951+0kTQXXPRJAPDTYe4kJuaJJcAxEfwE/igYA0m+OCByIKIEdXI
         RsRgA3w+mwoTQXLCiXbPJ89oDcKkINtyyCPeAMZKEStz4zrAc0J7y4v0XkdBVz4j+rUY
         9Np8vObI0KdYRKCQqiWtLWAv1NwI++yY9GVlXYKd3L+CUwbBSl989TtiXkx21a5bNXBB
         VoulavdbnFDWqne2/4M3nJnNLG4Z8dd61ym7vLmVyY0YyYlrhM8eI/Ajuhlc0rWeHpNi
         AJzePird71/7CdN7dMOqQzqiKFF99ap7Oj8ASpG+vWky81Pa7Ih7xJUwP7tH2B/Xrpm+
         biyQ==
X-Gm-Message-State: AOJu0YxPkbUlDz3R4G2L8011LZK4TOl55r2Rynd9cu+8FWLH1pAwESf2
	30NF6l/b5TU+c059BWWoz1Hg3w==
X-Google-Smtp-Source: AGHT+IHc8nfHe+UL2EXNBAt5Nmacp6Rz6HnFW1GDEQCeGDrfEF78u1C9TLnTdajawLRxy2oTv0evEQ==
X-Received: by 2002:ac8:5a53:0:b0:417:b901:98ff with SMTP id o19-20020ac85a53000000b00417b90198ffmr905433qta.54.1695787090120;
        Tue, 26 Sep 2023 20:58:10 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm9736097pga.68.2023.09.26.20.58.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 20:58:09 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/9] bnxt_en: Expose threshold temperatures through hwmon
Date: Tue, 26 Sep 2023 20:57:30 -0700
Message-Id: <20230927035734.42816-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230927035734.42816-1-michael.chan@broadcom.com>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000029f83a06064f330e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000029f83a06064f330e
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

HWRM_TEMP_MONITOR_QUERY response now indicates various
threshold temperatures. Expose these threshold temperatures
through the hwmon sysfs using this mapping:

hwmon_temp_max : bp->warn_thresh_temp
hwmon_temp_crit : bp->crit_thresh_temp
hwmon_temp_emergency : bp->fatal_thresh_temp

hwmon_temp_max_alarm : temp >= bp->warn_thresh_temp
hwmon_temp_crit_alarm : temp >= bp->crit_thresh_temp
hwmon_temp_emergency_alarm : temp >= bp->fatal_thresh_temp

Link: https://lore.kernel.org/netdev/20230815045658.80494-12-michael.chan@broadcom.com/
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
bnxt_hwrm_temp_query() now stores the static threshold values once.
Use new hwmon temperature mappings shown above and remove hwmon_temp_lcrit.

---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +++
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 57 ++++++++++++++++---
 2 files changed, 57 insertions(+), 7 deletions(-)

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
index 05e3d75f3c43..6a2cad5cc159 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -32,8 +32,16 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
 	if (rc)
 		goto drop_req;
 
-	*temp = resp->temp;
-
+	if (temp) {
+		*temp = resp->temp;
+	} else if (resp->flags &
+		   TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE) {
+		bp->fw_cap |= BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED;
+		bp->warn_thresh_temp = resp->warn_threshold;
+		bp->crit_thresh_temp = resp->critical_threshold;
+		bp->fatal_thresh_temp = resp->fatal_threshold;
+		bp->shutdown_thresh_temp = resp->shutdown_threshold;
+	}
 drop_req:
 	hwrm_req_drop(bp, req);
 	return rc;
@@ -42,12 +50,23 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
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
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+	case hwmon_temp_emergency:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_emergency_alarm:
+		if (!(bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED))
+			return 0;
+		return 0444;
 	default:
 		return 0;
 	}
@@ -66,13 +85,39 @@ static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
 		if (!rc)
 			*val = temp * 1000;
 		return rc;
+	case hwmon_temp_max:
+		*val = bp->warn_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_crit:
+		*val = bp->crit_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_emergency:
+		*val = bp->fatal_thresh_temp * 1000;
+		return 0;
+	case hwmon_temp_max_alarm:
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
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
 static const struct hwmon_channel_info *bnxt_hwmon_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_EMERGENCY | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY_ALARM),
 	NULL
 };
 
@@ -96,13 +141,11 @@ void bnxt_hwmon_uninit(struct bnxt *bp)
 
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


--00000000000029f83a06064f330e
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFkSC4lU2Iq/cccKxSW+w0MymirTsFuj
9j4WAFUvIENBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDky
NzAzNTgxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBB/uUc/RehcHrx1lwWubNkAMkxKo95vWnb5qdJDJZsVa7rJghu
9Urlk5A64YX+i4XtoWavvsMf7xQ5OSV2w2C5VTc3A7v2RAmnA+Scgr5ODs5uCT9JTrDr1Xd7RAhs
T7J570Lo01SI6wa9WvDZfgIpw3sGv8KNFFrkO7zhsIWQNptDI+dGhORJn5S6hWs81oMDlWYwisBl
DSd01iCDA9lLPQ241sIbG5fGFzWK0lwJH5cJLWi9lSvVdOBXIHc3uzraJTSZ99HKZP1G+lL3sI65
3T39ObmANZyIajHicMfgHi8WoiWriReTejWjg+8VRidcC6YLYE/A4o9PcJLtA0zS
--00000000000029f83a06064f330e--

