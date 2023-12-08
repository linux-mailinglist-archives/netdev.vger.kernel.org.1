Return-Path: <netdev+bounces-55114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE5880970D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96061F2137B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1610B643;
	Fri,  8 Dec 2023 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aOsXQtc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD13B19BB
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 16:17:29 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso1011385b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 16:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701994649; x=1702599449; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPUIM/SWTOd4abqKXMlSgtSF9VmXa011aEIRqhAxGo0=;
        b=aOsXQtc0Wu6lQR003eTk/vN9oTPiC+KeDivTqr1JS78DYgZiko/OjN7ErIO4eJCf/I
         uaoSRC+nDN3lUXtT0A6g2XdAepgdLwGNCglzRfVujiylRFmEaF+OCFZf9QJmOSk/PD2O
         HXB6dxYCuypR5Snb9Tqk3jAUMu9vQNWguc0Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994649; x=1702599449;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPUIM/SWTOd4abqKXMlSgtSF9VmXa011aEIRqhAxGo0=;
        b=qkANzMb0GbfvxZ8PA1hp60Hh0baTiPpc7o+FNUw/zJi2TJxBinBCubO2XdqvAqqpmG
         2VfkngXDXsQsH3ysGMaOsACFSXb2ImpEeuqnYUzH78SmBpKdJXapj9dNhecx4PCIFoMA
         M3nG0Btwn7Cl/g5Pgl12mXGkyhag8hZkmN0K7qT3slm2d9QEYUpJTo4HuYwdMKD7xjdL
         KPRp1AZELlSNJm6tuW8w2Kl4sAlj4BgWH+m4r/TCK61jfiJ14ol3v/3EypLQJvgj0csq
         WHXCidAwtU1VH8D+2QSSh5kigVcJfj+BJnVBl2029EWqfFBLJVwtYs54Tz1JfuqHvsP7
         5JSQ==
X-Gm-Message-State: AOJu0YzvweB883rohRE6V/lIcMmgsiRahRCMSChD8XnwmjuUaLvt73eq
	az77mEmjVVC3YBQunIPVxWGe0g==
X-Google-Smtp-Source: AGHT+IGht+/qKPlYplffNFnN4EHKFvEVUDPqqGYa1714U92mo1EIo6IlT1N59atTy/1kptLeaR/K6w==
X-Received: by 2002:a05:6a00:1806:b0:6cd:d53c:f5ea with SMTP id y6-20020a056a00180600b006cdd53cf5eamr4256416pfa.6.1701994648988;
        Thu, 07 Dec 2023 16:17:28 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id o4-20020a056a0015c400b006cdd369e3d0sm356493pfu.201.2023.12.07.16.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 16:17:27 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net v3 4/4] bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic
Date: Thu,  7 Dec 2023 16:16:58 -0800
Message-Id: <20231208001658.14230-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231208001658.14230-1-michael.chan@broadcom.com>
References: <20231208001658.14230-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f6c85060bf48241"

--0000000000007f6c85060bf48241
Content-Transfer-Encoding: 8bit

When the chip is configured to timestamp all receive packets, the
timestamp in the RX completion is only valid if the metadata
present flag is not set for packets received on the wire.  In
addition, internal loopback packets will never have a valid timestamp
and the timestamp field will always be zero.  We must exclude
any 0 value in the timestamp field because there is no way to
determine if it is a loopback packet or not.

Add a new function bnxt_rx_ts_valid() to check for all timestamp
valid conditions.

Fixes: 66ed81dcedc6 ("bnxt_en: Enable packet timestamping for all RX packets")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 20 +++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  8 +++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index aa1f5b776b5a..579eebb6fc56 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1759,6 +1759,21 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 	napi_gro_receive(&bnapi->napi, skb);
 }
 
+static bool bnxt_rx_ts_valid(struct bnxt *bp, u32 flags,
+			     struct rx_cmp_ext *rxcmp1, u32 *cmpl_ts)
+{
+	u32 ts = le32_to_cpu(rxcmp1->rx_cmp_timestamp);
+
+	if (BNXT_PTP_RX_TS_VALID(flags))
+		goto ts_valid;
+	if (!bp->ptp_all_rx_tstamp || !ts || !BNXT_ALL_RX_TS_VALID(flags))
+		return false;
+
+ts_valid:
+	*cmpl_ts = ts;
+	return true;
+}
+
 /* returns the following:
  * 1       - 1 packet successfully received
  * 0       - successful TPA_START, packet not completed yet
@@ -1784,6 +1799,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	u32 flags, misc;
+	u32 cmpl_ts;
 	void *data;
 	int rc = 0;
 
@@ -2006,10 +2022,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (unlikely((flags & RX_CMP_FLAGS_ITYPES_MASK) ==
-		     RX_CMP_FLAGS_ITYPE_PTP_W_TS) || bp->ptp_all_rx_tstamp) {
+	if (bnxt_rx_ts_valid(bp, flags, rxcmp1, &cmpl_ts)) {
 		if (bp->flags & BNXT_FLAG_CHIP_P5) {
-			u32 cmpl_ts = le32_to_cpu(rxcmp1->rx_cmp_timestamp);
 			u64 ns, ts;
 
 			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0488b0466015..a7d7b09ea162 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -161,7 +161,7 @@ struct rx_cmp {
 	#define RX_CMP_FLAGS_ERROR				(1 << 6)
 	#define RX_CMP_FLAGS_PLACEMENT				(7 << 7)
 	#define RX_CMP_FLAGS_RSS_VALID				(1 << 10)
-	#define RX_CMP_FLAGS_UNUSED				(1 << 11)
+	#define RX_CMP_FLAGS_PKT_METADATA_PRESENT		(1 << 11)
 	 #define RX_CMP_FLAGS_ITYPES_SHIFT			 12
 	 #define RX_CMP_FLAGS_ITYPES_MASK			 0xf000
 	 #define RX_CMP_FLAGS_ITYPE_UNKNOWN			 (0 << 12)
@@ -188,6 +188,12 @@ struct rx_cmp {
 	__le32 rx_cmp_rss_hash;
 };
 
+#define BNXT_PTP_RX_TS_VALID(flags)				\
+	(((flags) & RX_CMP_FLAGS_ITYPES_MASK) == RX_CMP_FLAGS_ITYPE_PTP_W_TS)
+
+#define BNXT_ALL_RX_TS_VALID(flags)				\
+	!((flags) & RX_CMP_FLAGS_PKT_METADATA_PRESENT)
+
 #define RX_CMP_HASH_VALID(rxcmp)				\
 	((rxcmp)->rx_cmp_len_flags_type & cpu_to_le32(RX_CMP_FLAGS_RSS_VALID))
 
-- 
2.30.1


--0000000000007f6c85060bf48241
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO2I/vSr40x7mCMpU4sqbYptTik6WrJP
htyd/xowgJ5RMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
ODAwMTcyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBMHbvDBfpLWXK9Ne56vLSVJiq0WDL4V5Lf1LnMQdhowzxJ5nb2
UfzNAA+Rdhdh3WRfXSySJ2qRs9TBHLiCiXWSzkE89c+gOl6+YllUICsL3tQZrR0HTIsiIYz2fIHf
dS5Hsqf5bDgQf6wnHRm1USS/MtpN5snpvldhEmcPjqcpOcZgMf8f0+paJp+g0hBeXO1Skc81sdQW
xs8aCgV8WZC0Vvp7eTrZ7Cia+YiqyQDCq30HTmVG4xQeDzfPmEI4KXNnSVqMbc+5CJgPQkdFoqCM
HBql99+pApM+koGlzrnhDOCN7zGPnRV2jc5Dja4O+3NJCGp5k3B6hOM1Ic+GgXHu
--0000000000007f6c85060bf48241--

