Return-Path: <netdev+bounces-69294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85B84A956
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C40292D0E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F1487A5;
	Mon,  5 Feb 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NBgtxnyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583FBE66
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172350; cv=none; b=XlYX3tCYLuK5VooSVXwdxxjMoa2fyQf8cH36ZTaXDuZF9nOJyypn7BUcSLSrZarAiGQFqcuE4rdVR/RUo3kcZf96Dx6n8BlLqn7LBkpS7ObYQCN4KHHzfXojQJwUsho35HDBiCJ5KJ+yO46P1u8+ryOyEz8OvWqNASApfG8GH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172350; c=relaxed/simple;
	bh=cjauYpdUoG91mbBQY8DfeRAcWS0TyX2ffWuk/RiLnuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwXRSnVzL05ejS71JDORKP3ZyFPqZDjPy1W5bh/jrKSCCdzCBUQhKmLOwLDQm/Y97kLsibykd7gia1b7ckiThi/jplybCZQ50WQvfeXh04svLyDLbnA8NTJeABV2zz2U5SianmniY6Jkea098Ev7q7jsm9C9tjAYUe2YQ3LwcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NBgtxnyU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bba50cd318so4113860b6e.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172348; x=1707777148; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oK4+kWXxklj9dqNQ/n9BQVndrHgiGL9o2jbYXxXYzuU=;
        b=NBgtxnyUsI0b2qE2Jjye4ecy/siBdAJssYWpdhV5uiZ1JJf+mwnP0Gi6kacJ/Gytd5
         uRYOtn7XrOiNkcE7qZ17KDNS2Dnl6eWm4OY9YEh6KmWqXh5qwtF/EIYcC5RNPsMPwa1L
         42ZNjS0uWs4RC0s5VvG7+EQF1rA6ismKVwZPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172348; x=1707777148;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oK4+kWXxklj9dqNQ/n9BQVndrHgiGL9o2jbYXxXYzuU=;
        b=aaqv5Cxm5/M89l3w4K5tixo5SW4nQlRPy3X2VZr8/KKNnnIdNoCWfjAo8+qi+5s4DB
         85z/iyM6o8Y9Fxyx/ynTFODU91IqWAZCQCBZdkz9wzuHmoAHzqBFE4UATCkBLOHJFJxz
         ox4c3bAyw54VNQ7xzOkJfJMMPiGgjLZ4cuokCpW2g0qJgS76TmZUQQrm/R/OzOURSjUB
         l4H204iFCuPMrUI3fyIlAirM/sAsKxeNUtGQM6VTU/42wNXXAkKQX9EXgjhfESLBqwdC
         QgUZSUk5PES5Pl8IwmvmoCHk9ioNpVxvtMaMd9HtGvmHMWsiQBvM4DBN0HBna7i6a1G4
         uFkA==
X-Gm-Message-State: AOJu0YwOko/l4Ydy3d9qngkV3U0tpuVjayUUkxZcfKwdd3zeOsegHmoo
	4nTJy2owgw4lmWHbA5aDmpSi+IEVtCunxP+DPxGB0yKMZ7zwCPzrE0YYjgngGg==
X-Google-Smtp-Source: AGHT+IEcY8Ol/BIL/Jbc9K4sdETb3/awhPI7EHXKVf/uYUCXEbJhkKPPYOc8tW04c0qeo3Dc01VSWw==
X-Received: by 2002:a05:6808:120a:b0:3bf:d0ee:9873 with SMTP id a10-20020a056808120a00b003bfd0ee9873mr670141oil.3.1707172347970;
        Mon, 05 Feb 2024 14:32:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGEfzuQ6y6LKDLwsI69gn32bqEbJdbRZw/1FYvY6hvnaxm/9T314R97m9GgMpODkR2j5j6aQ9euoqkpO2mwv9XhKu9Oj3rPnHAhp5p+wbcHUf2gNNXxQEkjMpqD+JDBOA2Uv402cOSYcQVxkUvhoSlBLM22Oy0q79tJrxZkierxIqNTybIrYsi+A3CZWBhG94WazBJf5Jd0qb0DtqT/YH35jc=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:27 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 08/13] bnxt_en: Save user configured filters in a lookup list
Date: Mon,  5 Feb 2024 14:31:57 -0800
Message-Id: <20240205223202.25341-9-michael.chan@broadcom.com>
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
	boundary="00000000000068f0200610aa090f"

--00000000000068f0200610aa090f
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Driver needs to maintain a lookup list of all the user configured
filters. This is required in order to reconfigure these filters upon
interface toggle. We can look up this list to follow the order with
which they should be re-applied.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 23 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d39de72bffea..b5bd88f33028 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4841,9 +4841,26 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 	}
 }
 
+void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
+{
+	u8 type = fltr->type, flags = fltr->flags;
+
+	INIT_LIST_HEAD(&fltr->list);
+	if ((type == BNXT_FLTR_TYPE_L2 && flags & BNXT_ACT_RING_DST) ||
+	    (type == BNXT_FLTR_TYPE_NTUPLE && flags & BNXT_ACT_NO_AGING))
+		list_add_tail(&fltr->list, &bp->usr_fltr_list);
+}
+
+void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
+{
+	if (!list_empty(&fltr->list))
+		list_del_init(&fltr->list);
+}
+
 static void bnxt_del_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
 {
 	hlist_del(&fltr->hash);
+	bnxt_del_one_usr_fltr(bp, fltr);
 	if (fltr->flags) {
 		clear_bit(fltr->sw_id, bp->ntp_fltr_bmap);
 		bp->ntp_fltr_count--;
@@ -5387,6 +5404,7 @@ void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr)
 		return;
 	}
 	hlist_del_rcu(&fltr->base.hash);
+	bnxt_del_one_usr_fltr(bp, &fltr->base);
 	if (fltr->base.flags) {
 		clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
 		bp->ntp_fltr_count--;
@@ -5533,6 +5551,7 @@ static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
 	}
 	head = &bp->l2_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hash, head);
+	bnxt_insert_usr_fltr(bp, &fltr->base);
 	set_bit(BNXT_FLTR_INSERTED, &fltr->base.state);
 	atomic_set(&fltr->refcnt, 1);
 	return 0;
@@ -13984,6 +14003,7 @@ int bnxt_insert_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr,
 	head = &bp->ntp_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hash, head);
 	set_bit(BNXT_FLTR_INSERTED, &fltr->base.state);
+	bnxt_insert_usr_fltr(bp, &fltr->base);
 	bp->ntp_fltr_count++;
 	spin_unlock_bh(&bp->ntp_fltr_lock);
 	return 0;
@@ -14138,6 +14158,7 @@ void bnxt_del_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr)
 		return;
 	}
 	hlist_del_rcu(&fltr->base.hash);
+	bnxt_del_one_usr_fltr(bp, &fltr->base);
 	bp->ntp_fltr_count--;
 	spin_unlock_bh(&bp->ntp_fltr_lock);
 	bnxt_del_l2_filter(bp, fltr->l2_fltr);
@@ -14954,6 +14975,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto init_err_dl;
 
+	INIT_LIST_HEAD(&bp->usr_fltr_list);
+
 	rc = register_netdev(dev);
 	if (rc)
 		goto init_err_cleanup;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d070e3ac9739..a6b6db1546cc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1334,6 +1334,7 @@ struct bnxt_pf_info {
 
 struct bnxt_filter_base {
 	struct hlist_node	hash;
+	struct list_head	list;
 	__le64			filter_id;
 	u8			type;
 #define BNXT_FLTR_TYPE_NTUPLE	1
@@ -2442,6 +2443,8 @@ struct bnxt {
 	u32			hash_seed;
 	u64			toeplitz_prefix;
 
+	struct list_head	usr_fltr_list;
+
 	/* To protect link related settings during link changes and
 	 * ethtool settings changes.
 	 */
@@ -2646,6 +2649,8 @@ u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
 int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
+void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
+void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
-- 
2.30.1


--00000000000068f0200610aa090f
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFmrcbWoC/oa3dMeErV7widRT7Rvmmpe
Q7wEfq0Ci0hUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCNh6oMVpCWFHyKh1/whM82GM5uQ/PSVArtpzwn5ItJpZGlsB0t
bSamL9hS0gPQJWd3CCJ8fTB5CrHYi+fvkX3ll62+tIVeFj5SP+CG0jKInuRhJxD95ey00r77Z4Qe
wo6mI/H5YSfw+VzThHHuRe0RV/HF3C0gWZw+4MdhJXeWaUrf13w9FS1ZTchYjfP5qZ9IXy4KF96C
r3zTFAiDA0v4/hSTOKS2FME9fRpZLyUco7N4UBHZNQ1HoTxMWJVMKLD9m/ZV0hEZ0c/7BUyn3Vk+
Lj/Tlq5beVMaDBazu5GNWS8CmNhlVolPVYg3oCo3LnMSxlHy9NsVKYlzlBpsHzc9
--00000000000068f0200610aa090f--

