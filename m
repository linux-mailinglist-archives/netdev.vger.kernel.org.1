Return-Path: <netdev+bounces-36406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6327AF8EC
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 08310281BFE
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFB1426B;
	Wed, 27 Sep 2023 03:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885913AF0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:58:13 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5C2009B
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d8c05784so7936556b3a.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695787092; x=1696391892; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbcD5QbJf/+Bo+NZ7PVbYwqdMqhmtUDrH5ej23aZEqA=;
        b=apW6IJVwTQmRkp2Zv1oC9QlWVb1PYBxJHx+LEE6S6aL3jRKj5ybLKECWtro4dR8TNY
         7Ms4uZ0sKA8O4RpImkNjKUMUaLOL5N6uMzrssBQcmD6ry01c0R+At98ZtRpDOh2TUw8k
         cX55qiWFwUMl2PA0UCbuv9GE1MVjQ/Fi06lXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787092; x=1696391892;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbcD5QbJf/+Bo+NZ7PVbYwqdMqhmtUDrH5ej23aZEqA=;
        b=qh7DhobpZ3aroqK+VBR/F3Z0F6TLS8zBFI5cdkbyQDyVZn4cW+moiaGzgyHO4dzTws
         7kgFAidbjod1vahGgY5qZeZHggWhZLHD1gZcYav4RNgvuOJ1+D6IcqGJGZqOsMec1LUc
         vr+kcVbMvG47icLLgxRR/wok6BuavRWNRHccxFP89z+UsWZ1HsuPQIwJJCf+mLsfKkO7
         nH6f9lv9sTAN3V2oYhDNAtw2ouidVrGpAbEldZI+umTB65LobzyG+rdz74cF5dJx90DA
         lkZUOWZ0YRwLeb0N0JPyd0Qo7GqoWIhQ1b/zqApQ0srckNCP0FzQoin1swNBQoJIBBRP
         MIEw==
X-Gm-Message-State: AOJu0YxpV6QwbReGScjKS9yKjaPimMMDMa9tHfEdfuCZ1J9u42GKT0g5
	bae2LBoNRcNsYdyxvxIQK8EDqg==
X-Google-Smtp-Source: AGHT+IHA08KsmXWFl3xsixFFapqLo4TLEDM6J72UUi6CsCCpdbPkn3971jMy+KLtFaAHOQjJxr1tvA==
X-Received: by 2002:a05:6a20:3d90:b0:14c:a53c:498c with SMTP id s16-20020a056a203d9000b0014ca53c498cmr889406pzi.10.1695787091156;
        Tue, 26 Sep 2023 20:58:11 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm9736097pga.68.2023.09.26.20.58.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 20:58:10 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v2 6/9] bnxt_en: Use non-standard attribute to expose shutdown temperature
Date: Tue, 26 Sep 2023 20:57:31 -0700
Message-Id: <20230927035734.42816-7-michael.chan@broadcom.com>
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
	boundary="0000000000003baf5506064f33c9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000003baf5506064f33c9
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Implement the sysfs attributes directly in the driver for
shutdown threshold temperature and pass an extra attribute group
to the hwmon core when registering the hwmon device.

Link: https://lore.kernel.org/netdev/20230815045658.80494-12-michael.chan@broadcom.com/
 Cc: Jean Delvare <jdelvare@suse.com>
 Cc: Guenter Roeck <linux@roeck-us.net>
 Cc: linux-hwmon@vger.kernel.org
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
index 6a2cad5cc159..6d36158df26e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -131,6 +131,57 @@ static const struct hwmon_chip_info bnxt_hwmon_chip_info = {
 	.info   = bnxt_hwmon_info,
 };
 
+static ssize_t temp1_shutdown_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct bnxt *bp = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", bp->shutdown_thresh_temp * 1000);
+}
+
+static ssize_t temp1_shutdown_alarm_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct bnxt *bp = dev_get_drvdata(dev);
+	u8 temp;
+	int rc;
+
+	rc = bnxt_hwrm_temp_query(bp, &temp);
+	if (rc)
+		return -EIO;
+
+	return sysfs_emit(buf, "%u\n", temp >= bp->shutdown_thresh_temp);
+}
+
+static DEVICE_ATTR_RO(temp1_shutdown);
+static DEVICE_ATTR_RO(temp1_shutdown_alarm);
+
+static struct attribute *bnxt_temp_extra_attrs[] = {
+	&dev_attr_temp1_shutdown.attr,
+	&dev_attr_temp1_shutdown_alarm.attr,
+	NULL,
+};
+
+static umode_t bnxt_temp_extra_attrs_visible(struct kobject *kobj,
+					     struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct bnxt *bp = dev_get_drvdata(dev);
+
+	/* Shutdown temperature setting in NVM is optional */
+	if (!(bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED) ||
+	    !bp->shutdown_thresh_temp)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group bnxt_temp_extra_group = {
+	.attrs		= bnxt_temp_extra_attrs,
+	.is_visible	= bnxt_temp_extra_attrs_visible,
+};
+__ATTRIBUTE_GROUPS(bnxt_temp_extra);
+
 void bnxt_hwmon_uninit(struct bnxt *bp)
 {
 	if (bp->hwmon_dev) {
@@ -156,7 +207,8 @@ void bnxt_hwmon_init(struct bnxt *bp)
 
 	bp->hwmon_dev = hwmon_device_register_with_info(&pdev->dev,
 							DRV_MODULE_NAME, bp,
-							&bnxt_hwmon_chip_info, NULL);
+							&bnxt_hwmon_chip_info,
+							bnxt_temp_extra_groups);
 	if (IS_ERR(bp->hwmon_dev)) {
 		bp->hwmon_dev = NULL;
 		dev_warn(&pdev->dev, "Cannot register hwmon device\n");
-- 
2.30.1


--0000000000003baf5506064f33c9
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILNE6y1mUEZ65qXj+mpCer+IGhXeHRej
HoURmGNrx3KGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDky
NzAzNTgxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB4PFTvYfQgPfUuV2BddIfvZViK/KJFo9tVwB163HxQS8KZE6Ol
+ZLPu/qVqqFVrM7DZg7iJOHknpLobP9G9c1KXwF7kV1uJ/jaeBLn01Y2WQSDTg5+YSEAl5Ido084
2ghXfpDyPk73+5RF+TVWoW+pmsT5+pxFP4BE2sgJ3z65IwQK9PPp83pgipK6D2I0SLiruH32Dnk4
lUEuYPy33gDsEKnfNwOQ/igYYD3VYlMF+sqKE9+y0XubEJ+tWazo1qeSobMYXBc4GSFc57wAaGBs
IGq3RQVlmdbf6PBMNDrKkVwx2mIxGko052ckLFpRuYPQ7McsJ1ot8j/3XY8WQhTr
--0000000000003baf5506064f33c9--

