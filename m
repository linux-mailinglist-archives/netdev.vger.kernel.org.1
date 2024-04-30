Return-Path: <netdev+bounces-92635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2629D8B82BD
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC54B2293D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A001C0DE2;
	Tue, 30 Apr 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cpw8qlZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114961E86E
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517184; cv=none; b=TfnRyi+1FMEFuYV5zaYFLl29W+y3JUvJ9aAr/4gbLCjR0RVdXF+FbvxY884wpCLixcGfH2OV8W2rRMSfgRV+5G11fqfRGiWafXhQsj8DacT2dfP9tQFiiZ4QRnblvjIC/KslFLkrZhwZ9EVr98xR8T864LtgcTGdlhS+xFL3EQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517184; c=relaxed/simple;
	bh=REEi6FCvPYgY8s901rpqmat1FA1f7KjS3zghBxLTepY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivhutjycHZK5WTL0yy/3IlQKv1wuj4ZkbQ/fE/hzlLJ3i+QJKicxZy6NcEfoW3fjzXd0jFer4VDTI3rn1DH6cB8eyfCGJuRVa51xjG6Dj+OHXGAYgy++fw2/1HJMj2Fe6RFR5nq2Lxo+bzUm8Da5u3VPf9TqX6mboEHLf2x+GdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cpw8qlZZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4f341330fso58285275ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714517182; x=1715121982; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKl26w8FEt7WfcZ7WONzzntRM1njhxf1a8zSMePoihk=;
        b=cpw8qlZZD5AeUPof4MQuRVrdHlc/zRvjoMruHnhQbzcNtDlcOlAN+2O7n1l+jW8ifl
         1KNFBx0Qm48RAI9+O4MruoJbA258tmpMVeM5KvhwgThvO1+HCuY2wX9dgzlFkTFr226f
         V3SbZ59FnD4lQ8DmUtcEw27ceG0Q9v2YAwh9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517182; x=1715121982;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKl26w8FEt7WfcZ7WONzzntRM1njhxf1a8zSMePoihk=;
        b=hdX2JpepLP+xcgDsgNC6aDNrnAg1beibcDsSQ2eHrFVvM1pWrMagTYbJQPl+4f/ahI
         PA4YgNHU0mdK6IOrcmysXw50CnDLOETHyqSk5c88lePcBk5926p9VLMgcBoyuTNnGUu8
         0f3HMFujCis7uyVKAsCay16cpl5jKy4CDR2rqhMqM4QyhD9pJ2h2Xs6nvQm/YBmA9Ale
         O/pLHLk1rosjeyExgcYgIWvgfOb649IBxpWwhY8R807KhWYabjthaN4zFptkqFfHYB/K
         qhO24oY61TCFEE5g+LOfwgveDQ0mMsz39Blw35QFxhpLMAL7YuZ4ymfGcPNS+xqV6oYz
         IYEg==
X-Gm-Message-State: AOJu0YyEDdPMGaD7BbWb49UZoB/pI46F2jidtm9nwNtR3ztcCSFOa1EU
	MtDZgG9V+LRcRloHt8y74MJU99R4p9YbOWIVs3HT5F79FJXiTqKl0dOkQyb9ww==
X-Google-Smtp-Source: AGHT+IEwU0Wbwv0Eh004rBBBcgcwF5yh9ge8PYPAx0YSwY4m1WhnMGMCwMd+fbiOCv8EAChG4/lBGA==
X-Received: by 2002:a17:902:d38d:b0:1e2:9ddc:f72d with SMTP id e13-20020a170902d38d00b001e29ddcf72dmr839580pld.26.1714517182110;
        Tue, 30 Apr 2024 15:46:22 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001eb2fb28eabsm7836476plq.227.2024.04.30.15.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:46:21 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH net-next 7/7] bnxt_en: Add VF PCI ID for 5760X (P7) chips
Date: Tue, 30 Apr 2024 15:44:38 -0700
Message-Id: <20240430224438.91494-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240430224438.91494-1-michael.chan@broadcom.com>
References: <20240430224438.91494-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a459a706175823cb"

--000000000000a459a706175823cb
Content-Transfer-Encoding: 8bit

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

No driver logic changes are required to support the VFs, so just add
the VF PCI ID.

Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 67294835e10e..2c9ced024250 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -137,6 +137,7 @@ static const struct {
 	[NETXTREME_E_VF_HV] = { "Broadcom NetXtreme-E Virtual Function for Hyper-V" },
 	[NETXTREME_E_P5_VF] = { "Broadcom BCM5750X NetXtreme-E Ethernet Virtual Function" },
 	[NETXTREME_E_P5_VF_HV] = { "Broadcom BCM5750X NetXtreme-E Virtual Function for Hyper-V" },
+	[NETXTREME_E_P7_VF] = { "Broadcom BCM5760X Virtual Function" },
 };
 
 static const struct pci_device_id bnxt_pci_tbl[] = {
@@ -211,6 +212,7 @@ static const struct pci_device_id bnxt_pci_tbl[] = {
 	{ PCI_VDEVICE(BROADCOM, 0x1807), .driver_data = NETXTREME_E_P5_VF },
 	{ PCI_VDEVICE(BROADCOM, 0x1808), .driver_data = NETXTREME_E_P5_VF_HV },
 	{ PCI_VDEVICE(BROADCOM, 0x1809), .driver_data = NETXTREME_E_P5_VF_HV },
+	{ PCI_VDEVICE(BROADCOM, 0x1819), .driver_data = NETXTREME_E_P7_VF },
 	{ PCI_VDEVICE(BROADCOM, 0xd800), .driver_data = NETXTREME_S_VF },
 #endif
 	{ 0 }
@@ -294,7 +296,7 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 	return (idx == NETXTREME_C_VF || idx == NETXTREME_E_VF ||
 		idx == NETXTREME_S_VF || idx == NETXTREME_C_VF_HV ||
 		idx == NETXTREME_E_VF_HV || idx == NETXTREME_E_P5_VF ||
-		idx == NETXTREME_E_P5_VF_HV);
+		idx == NETXTREME_E_P5_VF_HV || idx == NETXTREME_E_P7_VF);
 }
 
 #define DB_CP_REARM_FLAGS	(DB_KEY_CP | DB_IDX_VALID)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c62bdbb7249f..656ab81c0272 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2013,6 +2013,7 @@ enum board_idx {
 	NETXTREME_E_VF_HV,
 	NETXTREME_E_P5_VF,
 	NETXTREME_E_P5_VF_HV,
+	NETXTREME_E_P7_VF,
 };
 
 struct bnxt {
-- 
2.30.1


--000000000000a459a706175823cb
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJencuZ6doFMtuA1VnuLYuUBgcOPaZmc
IwtfY0pvZxZrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQz
MDIyNDYyMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCGo9sX6+8cY9pHH1tl9xU9HA2MJK6bMBeYb0uFTEx8bmgvdXSH
I6C6zcqeW3SdaoyMS+HJxX4Z0MKfb3C1j7lMrYt9OSD9/eObPuOd5VCogRUNb/HLVoTDL51hm4WF
qCoUdPa+n+hiCAxD7pYy4fvRmzkmRQ1eiqVDG7b40lDvzNBLpDWrm3RT6WuIddrfJThHYhP0GdiZ
Ty++d+1uSCrvZ+mYiODozQOw7GyHN9GhQUZrHydIo9CD+n0cy2eQPgVT0oKE8uT6Ck+JtwyI3KY4
pWG4x3imp4N7vPSJhHRLwx1ftB0rfHsL8WVw5vnimbNPZCUCN7FW/fuF86tAsz6S
--000000000000a459a706175823cb--

