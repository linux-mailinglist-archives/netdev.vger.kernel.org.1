Return-Path: <netdev+bounces-27574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD9477C6E1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615C2281229
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A08AD23;
	Tue, 15 Aug 2023 04:57:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61BBE4A
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 04:57:32 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A6BF
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:57:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76ce59842c1so308941385a.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692075449; x=1692680249;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2eZVc/pzXvltuS6N5RuzHBWF2iOOYm1b92U8RFA4ck=;
        b=LVJgj0UXpIv2lqCqDKfBAix9iRtcYTrh4XR0MJxrtuEMKmdYWx2SG2cVipw/68S5dG
         NBlstfvEQaykT5uHXVIngcAqd/5GfFVoDHlCjauijLn3MS6HT0L3WvutL4wDbwfx/emp
         MoMQePSiVx/WqNYJ+Q4hg2kL3VWj2YOA4eD44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075449; x=1692680249;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2eZVc/pzXvltuS6N5RuzHBWF2iOOYm1b92U8RFA4ck=;
        b=XccWlzAv/htc2CeSP47v3/5m1rip6Cp695LCONuyG59eqwTIzpyX4LJlHOejRV+nti
         vAwF4VeIUODMO3+/6lPIU9rYCi7ah7pPXWwoTAAuEpDvrrF1f7hzl2cUzI7YGuLhBr5P
         fBp8qveGJ484iNh7sfMUgmPn2R7eGnVWWiz6g9q0oSAXmxAu9BLWOA7ktyiNx1eixeQm
         GbwE2i4MUhOgEn0VjrhiUmonPgJhH5zdq0/tBf+gRoQsi0z7kwY216B7slXwmb+oSUDL
         1UdWoNU9hEJ/pzi9iDACX+auFz3l/k6LCY+TowZmITrKtb4Ux3Pf68FwCaV7XoQjJRr+
         kguQ==
X-Gm-Message-State: AOJu0YwBiq4bv56NlyT9YzGxa+vSjVYlw1elyaIRYVlnfH+9nV0OuvVV
	lNYqUVgN3yonihPUaivRCSWpPQ==
X-Google-Smtp-Source: AGHT+IFxERCkUGDxFTT/vKVeRwmahoXOIEyiSMop6ckEzy1zcXfj8pQ4d6Zrfai6WT+lWm+DGVTKdw==
X-Received: by 2002:a05:620a:668:b0:76c:ddf8:522b with SMTP id a8-20020a05620a066800b0076cddf8522bmr11017372qkh.37.1692075448575;
        Mon, 14 Aug 2023 21:57:28 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k28-20020a05620a143c00b00767cbd5e942sm3516575qkj.72.2023.08.14.21.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:57:28 -0700 (PDT)
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
Subject: [PATCH net-next 12/12] bnxt_en: Event handler for Thermal event
Date: Mon, 14 Aug 2023 21:56:58 -0700
Message-Id: <20230815045658.80494-13-michael.chan@broadcom.com>
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
	boundary="000000000000183a540602ef0489"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000183a540602ef0489
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Newer FW will send a new async event when it detects that
the chip's temperature has crossed the configured threshold value.
The driver will now notify hwmon and will log a warning message.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 44 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   |  8 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.h   |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5e97a3d93e87..c8e04c9501ee 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2130,6 +2130,17 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
 	return INVALID_HW_RING_ID;
 }
 
+#define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
+	((data2) & ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
+
+#define BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2)					\
+	(((data2) &									\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_MASK) >>	\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_SFT)
+
+#define EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1)			\
+	((data1) & ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_MASK)
+
 static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
 {
 	u32 err_type = BNXT_EVENT_ERROR_REPORT_TYPE(data1);
@@ -2145,6 +2156,39 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
 	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD:
 		netdev_warn(bp->dev, "One or more MMIO doorbells dropped by the device!\n");
 		break;
+	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD: {
+		char *threshold_type;
+		u32 attr;
+
+		switch (EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1)) {
+		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN:
+			attr = hwmon_temp_lcrit_alarm;
+			threshold_type = "warning";
+			break;
+		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_CRITICAL:
+			attr = hwmon_temp_crit_alarm;
+			threshold_type = "critical";
+			break;
+		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_FATAL:
+			attr = hwmon_temp_emergency_alarm;
+			threshold_type = "fatal";
+			break;
+		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN:
+			attr = hwmon_temp_max_alarm;
+			threshold_type = "shutdown";
+			break;
+		default:
+			netdev_err(bp->dev, "Unknown Thermal threshold type event\n");
+			return;
+		}
+		netdev_warn(bp->dev, "Chip temperature has crossed the %s thermal threshold!\n",
+			    threshold_type);
+		netdev_warn(bp->dev, "Temperature (In Celsius), Current: %lu, threshold: %lu\n",
+			    BNXT_EVENT_THERMAL_CURRENT_TEMP(data2),
+			    BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2));
+		bnxt_hwmon_notify_event(bp, attr);
+		break;
+	}
 	default:
 		netdev_err(bp->dev, "FW reported unknown error type %u\n",
 			   err_type);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
index f5affac1169a..483571264276 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -18,6 +18,14 @@
 #include "bnxt_hwrm.h"
 #include "bnxt_hwmon.h"
 
+void bnxt_hwmon_notify_event(struct bnxt *bp, u32 attr)
+{
+	if (!bp->hwmon_dev)
+		return;
+
+	hwmon_notify_event(&bp->pdev->dev, hwmon_temp, attr, 0);
+}
+
 static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
 {
 	struct hwrm_temp_monitor_query_output *resp;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
index af310066687c..5cf127702764 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
@@ -11,9 +11,14 @@
 #define BNXT_HWMON_H
 
 #ifdef CONFIG_BNXT_HWMON
+void bnxt_hwmon_notify_event(struct bnxt *bp, u32 attr);
 void bnxt_hwmon_uninit(struct bnxt *bp);
 void bnxt_hwmon_init(struct bnxt *bp);
 #else
+static inline void bnxt_hwmon_notify_event(struct bnxt *bp, u32 attr)
+{
+}
+
 static inline void bnxt_hwmon_uninit(struct bnxt *bp)
 {
 }
-- 
2.30.1


--000000000000183a540602ef0489
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOKI+XPl1z0B43JrKrCamownR7uwotCM
/I3xCOcco56uMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NTA0NTcyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB6qeWKFlNcpNOtSYAEZBlXl8HwQJkKN6PZ2hE2ZqOy+QroCr1n
4b1BGiCnmBecCSJxVI0AHBzAsi2HS75lGnYcsSh9PARxW71dO4VsU7Y+CY52dGStLIAlDtM6EKot
cGnvdHxZ7PVmcMErtN3M7lxXyZTyq7W9KWfvcz5FR/VRIatbaXbyZNK70E1UGCc2ZRrfHr6qDxI5
E7epuDhB+mLzqLcVLsfEm4lzdYxkmsvgRpnTEfaS+cyY9Lu55P1Tg2K+RpdCqMfkP4Eq7kNiGWBN
cqEsKGup+BvUU2K6c9ew5skNHhRP98PGZ3NN2RKl2j71L7E/q1NySTHP59OMqCG8
--000000000000183a540602ef0489--

