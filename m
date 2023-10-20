Return-Path: <netdev+bounces-43128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8557D180B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192C21C2106D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086F2B746;
	Fri, 20 Oct 2023 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GcCvvuWe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDB29CFF
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:16 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD05D6D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27dc1e4d8b6so1095897a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837290; x=1698442090; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsewz1O4dEf/OJMpchk/NqM6K0iIx4UKdLiZScLmVBU=;
        b=GcCvvuWe/HDWngM6e2EGQ6f0lqjutSjEAhm4bsuQhVq1evX45yw5NO6Nu8+pLpQJ2S
         G6iHNmGF7DnOKs3aZh6++fuqQ/b8Iw+Mc6kQDhc+zNFs7ey61JDWseEQEbFk+4vByIKz
         NtJOjOMTgnwm1mc3NrnCTb1fv2/zVjbvIEKXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837290; x=1698442090;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsewz1O4dEf/OJMpchk/NqM6K0iIx4UKdLiZScLmVBU=;
        b=ho26lEe4umfMr2cu1F+aj6VQF/PlGjaBnTWKYhCdPIeVIGZxN/Ef4U0qHG5ELUsCfZ
         AiIckUXrVwr50CurlJigj105ISM1grJ0TEeoFIbe8Vt5+wIPcJ6qCmI79G00cRW3v2uC
         qGN+4UhoY0NLrdPbrA6F78XobCXLUWunukd+IVGgdwRCAilIvQu0mwkyNMHgyu4gtAQx
         0oVrfecv2Y2cbv51Y1x7wnTQo678nn96kh+sqa7YtaLMhCf82uMdaw6WPrzKtw60lOEo
         6DwRxWcKLzh+A6kbD4n1jd6nHNp7JtwS0+7Fntq/+Q3QbzmgC5BW9RI8nPlXN11d5KK8
         M3GQ==
X-Gm-Message-State: AOJu0YwIC1+cD13fv3PAhZuPAaqJHv000Xl8AklLnwP4veZWSneRiNrM
	5javy4Ue6TVz2Z3R/7f3Oeeffg==
X-Google-Smtp-Source: AGHT+IEoJ+tHcxjjs3qYCkaLDPFI4oVj2sL8HJi/7Dw2oSSRlWFE7/Jltm361WKxeIMEZZWLyA7KnQ==
X-Received: by 2002:a17:90a:1996:b0:27d:2054:9641 with SMTP id 22-20020a17090a199600b0027d20549641mr3158023pji.36.1697837290335;
        Fri, 20 Oct 2023 14:28:10 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:09 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH net-next 1/8] bnxt_en: Do not call sleeping hwmon_notify_event() from NAPI
Date: Fri, 20 Oct 2023 14:27:50 -0700
Message-Id: <20231020212757.173551-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231020212757.173551-1-michael.chan@broadcom.com>
References: <20231020212757.173551-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009b1d7c06082c8cbe"

--0000000000009b1d7c06082c8cbe
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Defer hwmon_notify_event() to bnxt_sp_task() workqueue because
hwmon_notify_event() can try to acquire a mutex shown in the stack trace
below.  Modify bnxt_event_error_report() to return true if we need to
schedule bnxt_sp_task() to notify hwmon.

  __schedule+0x68/0x520
  hwmon_notify_event+0xe8/0x114
  schedule+0x60/0xe0
  schedule_preempt_disabled+0x28/0x40
  __mutex_lock.constprop.0+0x534/0x550
  __mutex_lock_slowpath+0x18/0x20
  mutex_lock+0x5c/0x70
  kobject_uevent_env+0x2f4/0x3d0
  kobject_uevent+0x10/0x20
  hwmon_notify_event+0x94/0x114
  bnxt_hwmon_notify_event+0x40/0x70 [bnxt_en]
  bnxt_event_error_report+0x260/0x290 [bnxt_en]
  bnxt_async_event_process.isra.0+0x250/0x850 [bnxt_en]
  bnxt_hwrm_handler.isra.0+0xc8/0x120 [bnxt_en]
  bnxt_poll_p5+0x150/0x350 [bnxt_en]
  __napi_poll+0x3c/0x210
  net_rx_action+0x308/0x3b0
  __do_softirq+0x120/0x3e0

Cc: Guenter Roeck <linux@roeck-us.net>
Fixes: a19b4801457b ("bnxt_en: Event handler for Thermal event")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 17 ++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h |  4 ++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 16eb7a7af970..7837e22f237b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2147,7 +2147,8 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
 	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR) ==\
 	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING)
 
-static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
+/* Return true if the workqueue has to be scheduled */
+static bool bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
 {
 	u32 err_type = BNXT_EVENT_ERROR_REPORT_TYPE(data1);
 
@@ -2182,7 +2183,7 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
 			break;
 		default:
 			netdev_err(bp->dev, "Unknown Thermal threshold type event\n");
-			return;
+			return false;
 		}
 		if (EVENT_DATA1_THERMAL_THRESHOLD_DIR_INCREASING(data1))
 			dir_str = "above";
@@ -2193,14 +2194,16 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
 		netdev_warn(bp->dev, "Temperature (In Celsius), Current: %lu, threshold: %lu\n",
 			    BNXT_EVENT_THERMAL_CURRENT_TEMP(data2),
 			    BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2));
-		bnxt_hwmon_notify_event(bp, type);
-		break;
+		bp->thermal_threshold_type = type;
+		set_bit(BNXT_THERMAL_THRESHOLD_SP_EVENT, &bp->sp_event);
+		return true;
 	}
 	default:
 		netdev_err(bp->dev, "FW reported unknown error type %u\n",
 			   err_type);
 		break;
 	}
+	return false;
 }
 
 #define BNXT_GET_EVENT_PORT(data)	\
@@ -2401,7 +2404,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		goto async_event_process_exit;
 	}
 	case ASYNC_EVENT_CMPL_EVENT_ID_ERROR_REPORT: {
-		bnxt_event_error_report(bp, data1, data2);
+		if (bnxt_event_error_report(bp, data1, data2))
+			break;
 		goto async_event_process_exit;
 	}
 	case ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE: {
@@ -12085,6 +12089,9 @@ static void bnxt_sp_task(struct work_struct *work)
 	if (test_and_clear_bit(BNXT_FW_ECHO_REQUEST_SP_EVENT, &bp->sp_event))
 		bnxt_fw_echo_reply(bp);
 
+	if (test_and_clear_bit(BNXT_THERMAL_THRESHOLD_SP_EVENT, &bp->sp_event))
+		bnxt_hwmon_notify_event(bp);
+
 	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
 	 * must be the last functions to be called before exiting.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9ce0193798d4..80846c3ca9fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2094,6 +2094,7 @@ struct bnxt {
 #define BNXT_FW_RESET_NOTIFY_SP_EVENT	18
 #define BNXT_FW_EXCEPTION_SP_EVENT	19
 #define BNXT_LINK_CFG_CHANGE_SP_EVENT	21
+#define BNXT_THERMAL_THRESHOLD_SP_EVENT	22
 #define BNXT_FW_ECHO_REQUEST_SP_EVENT	23
 
 	struct delayed_work	fw_reset_task;
@@ -2196,6 +2197,7 @@ struct bnxt {
 	u8			fatal_thresh_temp;
 	u8			shutdown_thresh_temp;
 #endif
+	u32			thermal_threshold_type;
 	enum board_idx		board_idx;
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
index e48094043c3b..669d24ba0e87 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -18,14 +18,14 @@
 #include "bnxt_hwrm.h"
 #include "bnxt_hwmon.h"
 
-void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type)
+void bnxt_hwmon_notify_event(struct bnxt *bp)
 {
 	u32 attr;
 
 	if (!bp->hwmon_dev)
 		return;
 
-	switch (type) {
+	switch (bp->thermal_threshold_type) {
 	case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN:
 		attr = hwmon_temp_max_alarm;
 		break;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
index 76d9f599ebc0..de54a562e06a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
@@ -11,11 +11,11 @@
 #define BNXT_HWMON_H
 
 #ifdef CONFIG_BNXT_HWMON
-void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type);
+void bnxt_hwmon_notify_event(struct bnxt *bp);
 void bnxt_hwmon_uninit(struct bnxt *bp);
 void bnxt_hwmon_init(struct bnxt *bp);
 #else
-static inline void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type)
+static inline void bnxt_hwmon_notify_event(struct bnxt *bp)
 {
 }
 
-- 
2.30.1


--0000000000009b1d7c06082c8cbe
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGqbI89ILJWfVXPsFt08Vs1SBUDzGHYd
dXEqDKlVY25zMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBC2H2fDIa0W9rxVQ+08fuFpMzDSQNCKOQjLrFHJjMjU/cTFfLn
3aM31pJT+Pkbe/vakmSeWZFcsbrebED+9wOlWJd2APeQBOQF31mv35kIF1t29cpXZdMoiBUDY/6U
aopV7mOgvIyowrjaLzQawbE3dS5d0BElQ+7Lq6rqL3A9fA46cF3TKFdgb8w2uKyp9WOSmRxYQYEj
E41CfpY/qrulZDriJgKl7oEMSzhCIhsQ9J7mOGxqXhg9Fnw6NvjHtUQz8Ho7MezPv5BekYkl7cMW
pcNqSmdVwUOpAGqphmVQ0y+9USdVpLUgmO2t5z6Wg7D1gloETmHpiyKQbzLC9Q0j
--0000000000009b1d7c06082c8cbe--

