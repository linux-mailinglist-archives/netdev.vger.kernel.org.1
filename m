Return-Path: <netdev+bounces-64080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608383102B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 00:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655EE1C22215
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EC28DB4;
	Wed, 17 Jan 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G3ZtI3iX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B328DA2
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535133; cv=none; b=WBd0CspeojIYLLzeCKmqxO9eAejMIOYRG0Oa8+e9gLdVKQ0ip2oFrWGPexh3d+9KT4hvDUZ6vxMLka5ELv2tU6jte6TW/oxxL5wHR6fUsrGPKH98nXl+iG8giiJwcPGRl0fIUl6+1zs4+7wiOWZnDsqJWV9AbVHJVQ62gqSn9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535133; c=relaxed/simple;
	bh=yn5REuh5Y2543u//FmcT2xb+BA/3REInsZdF0H2MkYY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhGlxPRQhCNyqMFW0pWdzdKMUfpW22xoM2Y9s/NSk3Jpp0SRnpY/CT0/ny/uQ0BMz+L1qUXY0B3i89AHWIEb87mWR7jaQCYi3MM5QylPJmrXB6tFnSVAQmaQKC99E2gtO5kZBQy9c1kp9EqTVZzSxj04ri5RlGJ2DjLVuvKRJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G3ZtI3iX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7831e87ba13so1016351585a.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705535130; x=1706139930; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q19cxUbMeI0I7HBnEgEQ5bybtOuHBzAsyubyWwHdtu0=;
        b=G3ZtI3iXrDE49/d1+6EdeT7SHbo5tMNv84qlFr5vIWs5iopBSgDY7gowRTd86SDudQ
         +C5f3s9jPqkobJ4iKj7hLA8r3hn/NhwwEdbe6FompPhEjP9dvnJthj3ZDuJiJOBLrtbk
         z37u+pyytba3+ZpBXm3PN36XFibKGzHQ9LTwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705535130; x=1706139930;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q19cxUbMeI0I7HBnEgEQ5bybtOuHBzAsyubyWwHdtu0=;
        b=Al7EsKvSaLegBX6MJG81qukhbdWQROrhjBFdDgMdrsTYMAI6OfhNzmzfSuat9xGlo5
         5mRRxb4AU71ossSNHUZDpSzH32Voca3qVSA2fgo5My5atq2t2zCNPL0IDWMoyjuMBtrH
         43C/WY+U0xEoPlLYwJL9f1Z0jVWUp8fUiqktHwPxnJnX4YHs2jtfo5HROLQLzfNbruXu
         DYmwlq6NNBYR6iPK+38DszjrpwPKMXNTSQlzZz4qkkCcqjnrMc4HQF+3+R3rmsrawkU0
         mHaXN17Tq9gNQ4dlrGyIVazdwgRbdlCadO7yYMZOn3mrfybPiZtwYb6ccKbzl1TAAGmU
         X5Tw==
X-Gm-Message-State: AOJu0Yzz35s/xWay1SX2ZuYgOH0ITWFU59dcocGApvt6TWz96222/6s+
	ICWBQbqLMKBzUsiqr8vgoew3cdfe9tNz
X-Google-Smtp-Source: AGHT+IExJi4sqf5owg++NAGrQBtUbMVBkLcyIOkaHOo8s8ty9lVtrO8jHE364NIewv13NKmFlbrZKA==
X-Received: by 2002:a05:620a:2af2:b0:783:2186:5968 with SMTP id bn50-20020a05620a2af200b0078321865968mr9071768qkb.6.1705535130162;
        Wed, 17 Jan 2024 15:45:30 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b0077d78c5b575sm4851105qkl.111.2024.01.17.15.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 15:45:29 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net 3/5] bnxt_en: Fix RSS table entries calculation for P5_PLUS chips
Date: Wed, 17 Jan 2024 15:45:13 -0800
Message-Id: <20240117234515.226944-4-michael.chan@broadcom.com>
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
	boundary="000000000000a0d450060f2cd756"

--000000000000a0d450060f2cd756
Content-Transfer-Encoding: 8bit

The existing formula used in the driver to calculate the number of RSS
table entries is to round up the number of RX rings to the next integer
multiples of 64 (e.g. 64, 128, 192, ..).  This is incorrect.  The valid
values supported by the chip are 64, 128, 256, 512 only (power of 2
starting from 64).  When the number of RX rings is greater than 128, the
entry size will likely be wrong.  Firmware will round down the invalid
value (e.g. 192 rounded down to 128) provided by the driver, causing some
RSS rings to not receive any packets.

We already have an existing function bnxt_calc_nr_ring_pages() to
do this calculation.  Use it in bnxt_get_nr_rss_ctxs() to calculate the
number of RSS contexts correctly for P5_PLUS chips.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Fixes: 7b3af4f75b81 ("bnxt_en: Add RSS support for 57500 chips.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 17 ++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c   |  3 ++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9fdc90bfce38..3d090d4403df 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5935,8 +5935,12 @@ static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
 
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		return DIV_ROUND_UP(rx_rings, BNXT_RSS_TABLE_ENTRIES_P5);
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		if (!rx_rings)
+			return 0;
+		return bnxt_calc_nr_ring_pages(rx_rings - 1,
+					       BNXT_RSS_TABLE_ENTRIES_P5);
+	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		return 2;
 	return 1;
@@ -7001,10 +7005,11 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 
 		req->num_rx_rings = cpu_to_le16(rx_rings);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+			u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, ring_grps);
+
 			req->num_cmpl_rings = cpu_to_le16(tx_rings + ring_grps);
 			req->num_msix = cpu_to_le16(cp_rings);
-			req->num_rsscos_ctxs =
-				cpu_to_le16(DIV_ROUND_UP(ring_grps, 64));
+			req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 		} else {
 			req->num_cmpl_rings = cpu_to_le16(cp_rings);
 			req->num_hw_ring_grps = cpu_to_le16(ring_grps);
@@ -7051,8 +7056,10 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	req->num_tx_rings = cpu_to_le16(tx_rings);
 	req->num_rx_rings = cpu_to_le16(rx_rings);
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, ring_grps);
+
 		req->num_cmpl_rings = cpu_to_le16(tx_rings + ring_grps);
-		req->num_rsscos_ctxs = cpu_to_le16(DIV_ROUND_UP(ring_grps, 64));
+		req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 	} else {
 		req->num_cmpl_rings = cpu_to_le16(cp_rings);
 		req->num_hw_ring_grps = cpu_to_le16(ring_grps);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 27b983c0a8a9..1f6e0cd84f2e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1574,7 +1574,8 @@ u32 bnxt_get_rxfh_indir_size(struct net_device *dev)
 	struct bnxt *bp = netdev_priv(dev);
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		return ALIGN(bp->rx_nr_rings, BNXT_RSS_TABLE_ENTRIES_P5);
+		return bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) *
+		       BNXT_RSS_TABLE_ENTRIES_P5;
 	return HW_HASH_INDEX_SIZE;
 }
 
-- 
2.30.1


--000000000000a0d450060f2cd756
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEjN5S9XbOZFmqgSUXvSp5mClj8KG77s
TdMkDMNIQ7H+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEx
NzIzNDUzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCCzeQr/LIaeo2/iW1ZsOYmMMpI0CrrY8BdtdHY0fRenHSP3SG8
Az0UYTwPtSzCEYdwhN9pqmkIRKvul32vq6FkrsgHBu6cTgszItQc6iBx0BcRyAvL/DhENQtEpEr9
z1pxrP6hBc3jDMs+e4qzktQxWRahU0EId2eVMEqYj6DxV/7HXjGxOUNk1OfGvj7UF9gKdsDNLH3o
u6wO6+EnoZZkbb7u4GEHjmWv4BG6psqSSX/EhwAE70pxt5YTBZRNBKMgd+s7D27nALychRwQOOTl
KU1xm5tZASj8HybnecwUTOx2NRz3Pt0SB13cR9T1auT6NGCZOO0tor553GYfvOk3
--000000000000a0d450060f2cd756--

