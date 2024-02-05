Return-Path: <netdev+bounces-69296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B21684A958
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BB51F29514
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D126ACC;
	Mon,  5 Feb 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a1YxH1xz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26354BA80
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172354; cv=none; b=LAH4oAvgsL3ipQCokF/z7P0y55f453NNLHJS4tMbEe1rRfR4HmhrL0hhDItB+TiQRhqmYkiqMyCjAbvtZewC2Pi+JZOsFX5EaMUu/UqP/8zX2tb3+ycsx7xgNPwVNrL1xsYrCdZzHXv1X0dWzDvCf43raImEi23DQNBX7ASgA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172354; c=relaxed/simple;
	bh=f0TEZ5auIr0f0fohuO8R/b0ggk+wHLZ9m9udsxReF/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSP/Hwlsdi4EP08JGz6Ta8loGWHsLvafwDP04B7CUb6oHqqusHQI7AczgVuT14uKL/0qNfUtOILmypmdsg6CqUk3Umk6h7dGhcHBJGx60YmpDVITW7tGXf2+Ex0c3gSFb2uq17f40oUOdTr05aWQ4alRs7VztS3q+0IsP1excy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a1YxH1xz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8a3973c5so32567671cf.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172351; x=1707777151; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc8bhShRns3Ka7XRAkANVdn5e6SVlv1KopwcmAiBS9E=;
        b=a1YxH1xzSYetXWQBs0NwZXiJ+A4nM2k3ehpyX7EQFlFFCuay5ZaGVYDqpf986DaW2/
         mjSIQl6lfe2e2y/HYd153oXM7NJHnVLMKRI0s1QwMUsZaTJeyzBluLHpioFS8RVhtxwC
         aPTz6ACnOy2HQft2LSJ3E8kT3Rwq0m5dcgrP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172351; x=1707777151;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc8bhShRns3Ka7XRAkANVdn5e6SVlv1KopwcmAiBS9E=;
        b=PycFVAHFaBWP7dyAEd0IDoElokiFWpiLJbbIpH0RnYTjNJLdgfigdSfIps6xjtVEG1
         Easf09DWfJuhJm49k9X9T5rvcjmxZCmrzLspBgCfEYmoIc2pmJasaLHfNPtdY0UIPZsX
         iA0ccSJQwZf9NrcU1tZhIP8hJYqEIQ3jeMqac62rHBuhRiXImHPjNQ3KOo41sgtIxahp
         pn+ZzSu03vcmGQnvbYpGWGgQSAwljMEG36TeJJGuEY8CwzRQXVculowKvAJtcJ+3zb24
         7J+QqDOuIbf5otCVEhhjd6mJoXRw0EW08516UnQE+1ep7aIkla6Sqmy4njPnLELxk3f9
         3GlA==
X-Gm-Message-State: AOJu0YyadUMIVvWAS0UD9IU06q8G4FC+scbvVbe/nzSLF0/Cm1wDB9/U
	rIbDFnmS2mG+AZsfxOFCDZ2S7iMECGvhxQZRbcA+yemB3JZJFfvb7+157bpWsg==
X-Google-Smtp-Source: AGHT+IEVgbduH1iOLKgc1nadVlsVA7uNVeG+I6bR6ZP7h9YQBBA9JqEkttHNcO4PduuUlX5uDrohOQ==
X-Received: by 2002:ac8:764a:0:b0:42a:b2b1:a800 with SMTP id i10-20020ac8764a000000b0042ab2b1a800mr474421qtr.26.1707172351210;
        Mon, 05 Feb 2024 14:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCULNlRIcXuzS1AiGcEijukubzXm4W/vI9MEQD9z8RtWORwWQFZS1X8H+XhZblLHsIdMU3NHuErioTeYEk2K13UDRus3Uexr3GOtj6ywGcxI8AXeyqSQ5shehw40NL6LFhO6k3e1Ma6u/P6/1A7Gc8Bv8T+kCHClcd1+j5qqtbrA6X4iF7QvRarnkl7L/9DcTb7HHC9Ie4yuvZBBssKZXmQeqVM=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:30 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 10/13] bnxt_en: Restore all the user created L2 and ntuple filters
Date: Mon,  5 Feb 2024 14:31:59 -0800
Message-Id: <20240205223202.25341-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009a76560610aa09b2"

--0000000000009a76560610aa09b2
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Walk the usr_fltr_list and call firmware to add these filters when
we open the NIC.  This will restore all user created filters after
reset.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 40 +++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 41e1c6d2c127..a6e2b65c45ce 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5853,8 +5853,7 @@ static void bnxt_hwrm_clear_vnic_filter(struct bnxt *bp)
 			struct bnxt_l2_filter *fltr = vnic->l2_filters[j];
 
 			bnxt_hwrm_l2_filter_free(bp, fltr);
-			if (list_empty(&fltr->base.list))
-				bnxt_del_l2_filter(bp, fltr);
+			bnxt_del_l2_filter(bp, fltr);
 		}
 		vnic->uc_filter_count = 0;
 	}
@@ -11537,6 +11536,42 @@ static int bnxt_reinit_after_abort(struct bnxt *bp)
 	return rc;
 }
 
+static void bnxt_cfg_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
+{
+	struct bnxt_ntuple_filter *ntp_fltr;
+	struct bnxt_l2_filter *l2_fltr;
+
+	if (list_empty(&fltr->list))
+		return;
+
+	if (fltr->type == BNXT_FLTR_TYPE_NTUPLE) {
+		ntp_fltr = container_of(fltr, struct bnxt_ntuple_filter, base);
+		l2_fltr = bp->vnic_info[0].l2_filters[0];
+		atomic_inc(&l2_fltr->refcnt);
+		ntp_fltr->l2_fltr = l2_fltr;
+		if (bnxt_hwrm_cfa_ntuple_filter_alloc(bp, ntp_fltr)) {
+			bnxt_del_ntp_filter(bp, ntp_fltr);
+			netdev_err(bp->dev, "restoring previously configured ntuple filter id %d failed\n",
+				   fltr->sw_id);
+		}
+	} else if (fltr->type == BNXT_FLTR_TYPE_L2) {
+		l2_fltr = container_of(fltr, struct bnxt_l2_filter, base);
+		if (bnxt_hwrm_l2_filter_alloc(bp, l2_fltr)) {
+			bnxt_del_l2_filter(bp, l2_fltr);
+			netdev_err(bp->dev, "restoring previously configured l2 filter id %d failed\n",
+				   fltr->sw_id);
+		}
+	}
+}
+
+static void bnxt_cfg_usr_fltrs(struct bnxt *bp)
+{
+	struct bnxt_filter_base *usr_fltr, *tmp;
+
+	list_for_each_entry_safe(usr_fltr, tmp, &bp->usr_fltr_list, list)
+		bnxt_cfg_one_usr_fltr(bp, usr_fltr);
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -11623,6 +11658,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		bnxt_vf_reps_open(bp);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
+	bnxt_cfg_usr_fltrs(bp);
 	return 0;
 
 open_err_irq:
-- 
2.30.1


--0000000000009a76560610aa09b2
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILcjD9XFZydO3szkVH8m6Li2iKKcsfv/
wYHQBrg/AQfrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBbTCJoE3jvJ9ov1bwi8v54EOND8Z+8+i4YSbJYRN335i4nHkle
nu5PMTGB4gCL61DFEBxlLZQOJPrXJEscYiR5CmR/rwd+fQ3jw9joqPrd4bUkC/nZawNcAWz0iD4h
2rLlS8f0wjA7COdB50CPZfSA7yelKNvK9KSiJmibbucI/eVhtS2X0GWtHvBMLKD1ddeenkXcc7ty
BddSZEhy/HpO3xhBL/Xy6rnkYdYrZCAUo7AMJtRF3ksY7Okk57GEy2+C/OsdS+w1Hh22goE3W7e8
MOxGUbSymEra0HULMmeBFx9vAhmoNaOM3Te6s3CDAj+JZZdPqHR7xSMlZd6b/DoJ
--0000000000009a76560610aa09b2--

