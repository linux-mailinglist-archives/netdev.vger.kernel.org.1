Return-Path: <netdev+bounces-69293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16B84A955
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76161292B22
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B2E249E3;
	Mon,  5 Feb 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f8W6d6IB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2748CCF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172349; cv=none; b=X/SQqN+ZbsuYzH/1uV5QcXhn0j7IYzfGcaz1Ls57/yboSPfUARVWpy8oYSKkQzcEET/LUAx9A1JUK6vViXyWBnMq/xAkNiT5YMhQPcjkmFPD6IgOQ6N6kG+c3PnUn4pPIE3IYezHoTUPPnsxTQI3L2tgIJ911g065VNGw/137hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172349; c=relaxed/simple;
	bh=AB1bCTPf3UZDfPkZCqaa0Pp9gCGzt538ekc7sJ41Vzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsT/MSAN5VtXRv2F/ekpXXY5vPu9f/+9f4htgYw2Y/8kzUjeupclw2cuuFjm6fL9QbE8fJlt1GUx7b1xgFK54+QbU67OiYZipZsBo3XwvlFm1aev/4DZIqLkhDi13f1k8N7P8nxGnEKVcbdI3MqDJVVBxaIGp9fBwGxaO39MqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f8W6d6IB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c2591e7aaso11101001cf.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172346; x=1707777146; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dN3r1Dcnc91l419zFgMLk79fNtTm5YA98Xwn1Qudldw=;
        b=f8W6d6IBcPz6OKvdm6hdBp3Wxo7zNp4u5WwG3oMfquuKoquWj2V0xeypA4W8P+ER8M
         Ovj1BbM7xo4cW25KP6Eld5XaSbKBGOTk5q0SfrwTYv5aXryigd34VVwZRkAssLmrd9tA
         3fIVpwaoRXOww1QnVso8sY+Sd50t/k91bMKZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172346; x=1707777146;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dN3r1Dcnc91l419zFgMLk79fNtTm5YA98Xwn1Qudldw=;
        b=OBMYbcwLbcd+peBgtylsFkyY+cjh3FviucThTV7dbvp6grtQfkC75WWXOzmE6zfZE4
         le8BiwRle53YBfb7tiN2lvp8/avgF9v7CVQPW6gI0PC6eWxF/ygY0quxaHgz8kHYZpiw
         Teq+JW+1ESoUQeZUvQZim2nJvz6TnElmC20fW58a9mIygiAEs8pczG6JUPz4OYWu0z9H
         E1XprFwUSAala7gQmR3HzePjd41DVti8tJBYWllVgN3GZkeyYOJaCK6pUHF1gPk3k38u
         nfkWiTYyKGzw2jsAnJSdiSTd6GzoYRTFwpgWQSfuWTzyyXeNNyLn5VyHTeX2p91zG9V3
         q35Q==
X-Gm-Message-State: AOJu0YxL9m3/1vha90GbHXz5rqAPcoz90Evg79QOMQIYpme3fvzdG98P
	ODaqqnHk6tUfI9sH1UV5I2K+U23EeN5UYXuw7yM0PryowBvb6FEgOW3GRarCjQ==
X-Google-Smtp-Source: AGHT+IHR+VAY4O4r4YkZS8QGQGOhmCsebrUYxDEWtqSMw8tWFD/p9LLrV0cIo5x8cA7b9CRHu//mJg==
X-Received: by 2002:ac8:4e86:0:b0:42a:995d:13d1 with SMTP id 6-20020ac84e86000000b0042a995d13d1mr777645qtp.43.1707172346320;
        Mon, 05 Feb 2024 14:32:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXyYgxSd0vL0sPDyxFZQp+xTunIXq0lLfz1JzVARLbg6DCIiue7lL6xwro6pbwdE8eJdcJplZ/WldURkWvNS4e0svuGBbzO4gNjHx3eE615D7hetFJhSjkUoRUBTYaqBTfEIZcKIiojJUEeMIwMvRhBgB8zPURwqUMN4vljpxlImNVcN87g2JH3Y7ZnaQHNGhzc4J43VRv0wGbRx/KxTmkVe0=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:25 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 07/13] bnxt_en: Add separate function to delete the filter structure
Date: Mon,  5 Feb 2024 14:31:56 -0800
Message-Id: <20240205223202.25341-8-michael.chan@broadcom.com>
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
	boundary="0000000000004c9c370610aa0946"

--0000000000004c9c370610aa0946
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Since we are going to do filter deletion at multiple places in the
upcoming patches, add a function that does the deletion.  Future patches
add more code into this function.

Since we are passing the address of the filter base to free the
entire filter structure, add a comment to make sure that the base
is always at the beginning of the structure.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 382b4a559c9c..d39de72bffea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4841,6 +4841,16 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 	}
 }
 
+static void bnxt_del_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
+{
+	hlist_del(&fltr->hash);
+	if (fltr->flags) {
+		clear_bit(fltr->sw_id, bp->ntp_fltr_bmap);
+		bp->ntp_fltr_count--;
+	}
+	kfree(fltr);
+}
+
 static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 {
 	int i;
@@ -4858,10 +4868,7 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 			bnxt_del_l2_filter(bp, fltr->l2_fltr);
 			if (!all && (fltr->base.flags & BNXT_ACT_FUNC_DST))
 				continue;
-			hlist_del(&fltr->base.hash);
-			clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
-			bp->ntp_fltr_count--;
-			kfree(fltr);
+			bnxt_del_fltr(bp, &fltr->base);
 		}
 	}
 	if (!all)
@@ -4904,12 +4911,7 @@ static void bnxt_free_l2_filters(struct bnxt *bp, bool all)
 		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
 			if (!all && (fltr->base.flags & BNXT_ACT_FUNC_DST))
 				continue;
-			hlist_del(&fltr->base.hash);
-			if (fltr->base.flags) {
-				clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
-				bp->ntp_fltr_count--;
-			}
-			kfree(fltr);
+			bnxt_del_fltr(bp, &fltr->base);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 16f18c70c7bb..d070e3ac9739 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1365,6 +1365,7 @@ extern const struct bnxt_flow_masks BNXT_FLOW_IPV6_MASK_ALL;
 extern const struct bnxt_flow_masks BNXT_FLOW_IPV4_MASK_ALL;
 
 struct bnxt_ntuple_filter {
+	/* base filter must be the first member */
 	struct bnxt_filter_base	base;
 	struct flow_keys	fkeys;
 	struct bnxt_flow_masks	fmasks;
@@ -1395,6 +1396,7 @@ struct bnxt_ipv6_tuple {
 #define BNXT_L2_KEY_SIZE	(sizeof(struct bnxt_l2_key) / 4)
 
 struct bnxt_l2_filter {
+	/* base filter must be the first member */
 	struct bnxt_filter_base	base;
 	struct bnxt_l2_key	l2_key;
 	atomic_t		refcnt;
-- 
2.30.1


--0000000000004c9c370610aa0946
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPHD/O5RrOwrUdXFCcs+4KKFTJ9lNzE1
BE2MzMD9OhxAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBPb9QSIUa3Q0jzWPZFtL3WX+/7T4+ezghBkotXnG8eD4UbrHEx
8qx9xp90Pos53C2eNC9nyDA84K0nb6ZQ6rXD1EjuLw1PWt5k8EHjnqav+Pf1R1rfxm5QQ6ELsjqF
f/ztfsloUReWBkFV22BPy5A0QgiINl4qG4lkfLyI7BqiopaeTEbxQIQb5Kiq3W84e94YY/J3BtQx
JpxePIRa6LiL+ml4LYVqOQpjBeVkTMmjpYQiglU1ddBTX0nDebeSPO7qfY7rJHtXbKEQjyBpw4dD
zRoSAYFsKPCg5Gvsvllf7UgeE1zc1Lv99m3Fba89MJks83Gum7fgz1myG0x6iPj/
--0000000000004c9c370610aa0946--

