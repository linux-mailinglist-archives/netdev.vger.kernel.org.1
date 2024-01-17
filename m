Return-Path: <netdev+bounces-64081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266E83102C
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 00:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BF6289248
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532328DC0;
	Wed, 17 Jan 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ejILfMCR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1B28DB7
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535135; cv=none; b=Yjg9REPYSOMOHah6Xx/bnIBivyoDiVEKHcDAm7KTnSeyXgxH6ID9X8cSZZQ97MPMyHwO+vcyeMKHaB1p7pXKjo31VjRSPRaPwGpdn7YBRF4b2a3zJyn5/W/4Zre5SIsZNOMaSQBmA/czblo8EmtN+X7obBgBb92V9K//5X5VWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535135; c=relaxed/simple;
	bh=Bc9LQGam7y4PsYNJw17E1sZN/7YmR2mSZtwPmoAxo4I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fooCRi3PZo0cBXg/FyCYeHtUrPSCw/C8f+EebuMNRHuaB1M8+wHHJpkaF1ngT1jUivINT6Knt+19VPWERWjq1/2naQ8EOg/+wL7Bq3z+LW007c9YWXe9ULZpUBbTWhUG6ta7cqtDnR+h9LgOwBWFbTO7+UhiyCePBbwVC1Jmt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ejILfMCR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7831ed13d39so929054685a.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705535132; x=1706139932; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bciOMxGneLceQ5HKR4KNKccrrAUPy9KID1LkLrkli7c=;
        b=ejILfMCRWzIdSw9CKHXpXqtUC2Fe3AIsac+a7Odj6g5+bPQhsFf0JRGnrdiLM0uc82
         SiAiLPZKOE/0H3A3OSxYP5Ww6aaEhFcQ+ROBGwIOKr4oYknZwiO+KHtEpmAQ4icWzcnG
         qyTR/yPRpuzj1Ccj+UNyJCgu49i4HiRso+5x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705535132; x=1706139932;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bciOMxGneLceQ5HKR4KNKccrrAUPy9KID1LkLrkli7c=;
        b=RbooKAbsb942BM5Om/zMtVSFrHau1Xtpw6NzVw4V6qRG7GgBZNpuIbB0aOehrMKtoz
         2dS5N1DkSGzanhtn1LbCJgjsJPyJvlgNqNrhql2G2MsnGIOeoGQhrZbywjR2Oh+fZ7eM
         bha82+fODexVJFaxb07OY0yp9BgR8oWGT9Iaz6xVmXZHNcDpaH2McANXq7+bFD4H0Z6Q
         MSzzBgdMLruZTDtQXKBYknydv5dqABmwtspBrS6yXAJokLqnGE8E8Aa5HKjMymlUblIM
         kRu3faRTxaxIaDLEtF0AKKSY93cGDrAmANDUly/Rhdg9yi5Nk18uHSC1nnhMnlEGl3KU
         pTAQ==
X-Gm-Message-State: AOJu0YzTEqgADveEN4ft5I1O8VZMiFKIjXFdmlfGLn/gt6mgigRtyzhZ
	1SHISobH7/2uLO80NTdoioxMSO5rCgvW
X-Google-Smtp-Source: AGHT+IEivC7fDU7Hvdzq8PgjeLnYkwG5NIxQu3hcAJ08LyWzsH7D8c6V4xwb11pXDKsNRDw6izwYtQ==
X-Received: by 2002:ae9:c10a:0:b0:781:5efd:403b with SMTP id z10-20020ae9c10a000000b007815efd403bmr10805087qki.13.1705535132113;
        Wed, 17 Jan 2024 15:45:32 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b0077d78c5b575sm4851105qkl.111.2024.01.17.15.45.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 15:45:31 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net 4/5] bnxt_en: Prevent kernel warning when running offline self test
Date: Wed, 17 Jan 2024 15:45:14 -0800
Message-Id: <20240117234515.226944-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240117234515.226944-1-michael.chan@broadcom.com>
References: <20240117234515.226944-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bb57bf060f2cd79b"

--000000000000bb57bf060f2cd79b
Content-Transfer-Encoding: 8bit

We call bnxt_half_open_nic() to setup the chip partially to run
loopback tests.  The rings and buffers are initialized normally
so that we can transmit and receive packets in loopback mode.
That means page pool buffers are allocated for the aggregation ring
just like the normal case.  NAPI is not needed because we are just
polling for the loopback packets.

When we're done with the loopback tests, we call bnxt_half_close_nic()
to clean up.  When freeing the page pools, we hit a WARN_ON()
in page_pool_unlink_napi() because the NAPI state linked to the
page pool is uninitialized.

The simplest way to avoid this warning is just to initialize the
NAPIs during half open and delete the NAPIs during half close.
Trying to skip the page pool initialization or skip linking of
NAPI during half open will be more complicated.

This fix avoids this warning:

WARNING: CPU: 4 PID: 46967 at net/core/page_pool.c:946 page_pool_unlink_napi+0x1f/0x30
CPU: 4 PID: 46967 Comm: ethtool Tainted: G S      W          6.7.0-rc5+ #22
Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 1.3.8 08/31/2021
RIP: 0010:page_pool_unlink_napi+0x1f/0x30
Code: 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 47 18 48 85 c0 74 1b 48 8b 50 10 83 e2 01 74 08 8b 40 34 83 f8 ff 74 02 <0f> 0b 48 c7 47 18 00 00 00 00 c3 cc cc cc cc 66 90 90 90 90 90 90
RSP: 0018:ffa000003d0dfbe8 EFLAGS: 00010246
RAX: ff110003607ce640 RBX: ff110010baf5d000 RCX: 0000000000000008
RDX: 0000000000000000 RSI: ff110001e5e522c0 RDI: ff110010baf5d000
RBP: ff11000145539b40 R08: 0000000000000001 R09: ffffffffc063f641
R10: ff110001361eddb8 R11: 000000000040000f R12: 0000000000000001
R13: 000000000000001c R14: ff1100014553a080 R15: 0000000000003fc0
FS:  00007f9301c4f740(0000) GS:ff1100103fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91344fa8f0 CR3: 00000003527cc005 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x81/0x140
 ? page_pool_unlink_napi+0x1f/0x30
 ? report_bug+0x102/0x200
 ? handle_bug+0x44/0x70
 ? exc_invalid_op+0x13/0x60
 ? asm_exc_invalid_op+0x16/0x20
 ? bnxt_free_ring.isra.123+0xb1/0xd0 [bnxt_en]
 ? page_pool_unlink_napi+0x1f/0x30
 page_pool_destroy+0x3e/0x150
 bnxt_free_mem+0x441/0x5e0 [bnxt_en]
 bnxt_half_close_nic+0x2a/0x40 [bnxt_en]
 bnxt_self_test+0x21d/0x450 [bnxt_en]
 __dev_ethtool+0xeda/0x2e30
 ? native_queued_spin_lock_slowpath+0x17f/0x2b0
 ? __link_object+0xa1/0x160
 ? _raw_spin_unlock_irqrestore+0x23/0x40
 ? __create_object+0x5f/0x90
 ? __kmem_cache_alloc_node+0x317/0x3c0
 ? dev_ethtool+0x59/0x170
 dev_ethtool+0xa7/0x170
 dev_ioctl+0xc3/0x530
 sock_do_ioctl+0xa8/0xf0
 sock_ioctl+0x270/0x310
 __x64_sys_ioctl+0x8c/0xc0
 do_syscall_64+0x3e/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Fixes: 294e39e0d034 ("bnxt: hook NAPIs to page pools")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3d090d4403df..0f5004872a46 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11572,10 +11572,12 @@ int bnxt_half_open_nic(struct bnxt *bp)
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
 		goto half_open_err;
 	}
+	bnxt_init_napi(bp);
 	set_bit(BNXT_STATE_HALF_OPEN, &bp->state);
 	rc = bnxt_init_nic(bp, true);
 	if (rc) {
 		clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
+		bnxt_del_napi(bp);
 		netdev_err(bp->dev, "bnxt_init_nic err: %x\n", rc);
 		goto half_open_err;
 	}
@@ -11594,6 +11596,7 @@ int bnxt_half_open_nic(struct bnxt *bp)
 void bnxt_half_close_nic(struct bnxt *bp)
 {
 	bnxt_hwrm_resource_free(bp, false, true);
+	bnxt_del_napi(bp);
 	bnxt_free_skbs(bp);
 	bnxt_free_mem(bp, true);
 	clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
-- 
2.30.1


--000000000000bb57bf060f2cd79b
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINRr2sDerc+mMNCJ31LjnIlPqu6Ba4Yd
YD3tkoHr0u9AMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEx
NzIzNDUzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCAEhDbhOIQly1OsO3BGf2PGs0FIRNh7NwYOpYeClA9QL+RyzcN
J9PKOafqMEM+Aab99d/pvc0xNfv7GLnFjBAojGbUuWX3fMQpZ8eqp4Ksi+Fknfu/mhVpIkhZcjFe
9W9Wb1/u+x9MGxW/3Irwe89LdeV665F8udeFFTjWJ3jpeTQA5pLZ0Mp3TiWuuFv+P3WdaUZaSxmf
Tz8OYD5uAvuRtx64SYj4SH0Md7g2hNDqq0EjvCSsYfGe8h9FD5sy14fZ+CsPq/SWZz3KhKtxS2pt
+4y3uLxxLpEP478OEU5ukKk1uatsCnLkiSwm5ozc3E+uF8YN5/zwzjpJ4q3sQZCr
--000000000000bb57bf060f2cd79b--

