Return-Path: <netdev+bounces-28650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC1878019D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E14028224B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61D1C2A8;
	Thu, 17 Aug 2023 23:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF361BEED
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 23:19:39 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F335AE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:19:37 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76d77da274eso21490285a.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692314376; x=1692919176;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6skaNLV/RRvreKXpowrVaHK5+/nU9FaAVxFgHO2mOU=;
        b=Jc83VQNn+q9YwbKlbtCiuNwKI9C0qe4h2r5/2MSiAMsLbBUNZ7Z9dnA1fTVWDdwnfQ
         q+N/c5x4raSkAv6xIvEPq8Y/ldSH5/ieg0Oxp+G6QXDWB8bZfaQq3l4ik73NmF1SJWRn
         ikwo6O7uNKlhMZklpkR2iMwq+Ik5r7FDNYolQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692314376; x=1692919176;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6skaNLV/RRvreKXpowrVaHK5+/nU9FaAVxFgHO2mOU=;
        b=mHAGZRZFyrocZ1uc3OE3vC+d07rUnZ8zTWRFOOD4GR4HD80rAqD6ToVbMYRD9FPkOu
         GfVDA4wz2XBa1n/AYESne2EGAcOo7mD7qCdEN1QefL+Y+SkfpJjnTWhHWqdJgPyKN7L8
         Jj3C2AkJ2vsgG63Vw2wzrlCC4KYvG1OSwjl3lP4teEek9M3TuBTl3vXjkoKih1haOPbC
         SQPhqbb9MApvIn3COKZd3HfTDeZwIKWhfUea6fTwX75IKcEVrw4uzeCPodxAg/sJSJt6
         i1KCyBqM6y9lucfzBVAWdFx4QbYbrvUEotg+5vgRkwV9iIS4fVsbSNMjFgQ/tOsb9sfx
         SqKQ==
X-Gm-Message-State: AOJu0YybHNbgGDccel2sXLCCKb/tAJohi4gW0l4MpE0xfUWs+GbRCFke
	CUAnIM2A79Db2WaEb5nJuHLD/g==
X-Google-Smtp-Source: AGHT+IGRuJPY2pKzzZWWObZQsbiccCSqG45hR4Q2VvCl23+blWnq4tCAau1RdxDkkSsHg+tPbEU+kg==
X-Received: by 2002:ad4:4bc8:0:b0:647:21a8:19b2 with SMTP id l8-20020ad44bc8000000b0064721a819b2mr977282qvw.19.1692314376082;
        Thu, 17 Aug 2023 16:19:36 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a149b00b0076d25b11b62sm145516qkj.38.2023.08.17.16.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 16:19:35 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 5/6] bnxt_en: Display the ring error counters under ethtool -S
Date: Thu, 17 Aug 2023 16:19:10 -0700
Message-Id: <20230817231911.165035-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230817231911.165035-1-michael.chan@broadcom.com>
References: <20230817231911.165035-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000041e598060326a5c9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000041e598060326a5c9
Content-Transfer-Encoding: 8bit

The existing driver displays the sum of 4 ring counters under ethtool -S.
These counters are in the array bnxt_sw_func_stats.  These counters are
summed at the time of ethtool -S and will be lost when the device is reset.

Replace these counters with the new total ring error counters added in the
last patch.  These new counters are saved before reset.  ethtool -S will
now display the sum of the saved counters plus the current counters.

Link: https://lore.kernel.org/netdev/CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 48 +++++++++----------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 8fd5071d8b09..a9f1eede24e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -339,13 +339,15 @@ enum {
 	RX_NETPOLL_DISCARDS,
 };
 
-static struct {
-	u64			counter;
-	char			string[ETH_GSTRING_LEN];
-} bnxt_sw_func_stats[] = {
-	{0, "rx_total_discard_pkts"},
-	{0, "tx_total_discard_pkts"},
-	{0, "rx_total_netpoll_discards"},
+static const char *const bnxt_ring_err_stats_arr[] = {
+	"rx_total_l4_csum_errors",
+	"rx_total_resets",
+	"rx_total_buf_errors",
+	"rx_total_oom_discards",
+	"rx_total_netpoll_discards",
+	"rx_total_ring_discards",
+	"tx_total_ring_discards",
+	"total_missed_irqs",
 };
 
 #define NUM_RING_RX_SW_STATS		ARRAY_SIZE(bnxt_rx_sw_stats_str)
@@ -495,7 +497,7 @@ static const struct {
 	BNXT_TX_STATS_PRI_ENTRIES(tx_packets),
 };
 
-#define BNXT_NUM_SW_FUNC_STATS	ARRAY_SIZE(bnxt_sw_func_stats)
+#define BNXT_NUM_RING_ERR_STATS	ARRAY_SIZE(bnxt_ring_err_stats_arr)
 #define BNXT_NUM_PORT_STATS ARRAY_SIZE(bnxt_port_stats_arr)
 #define BNXT_NUM_STATS_PRI			\
 	(ARRAY_SIZE(bnxt_rx_bytes_pri_arr) +	\
@@ -532,7 +534,7 @@ static int bnxt_get_num_stats(struct bnxt *bp)
 {
 	int num_stats = bnxt_get_num_ring_stats(bp);
 
-	num_stats += BNXT_NUM_SW_FUNC_STATS;
+	num_stats += BNXT_NUM_RING_ERR_STATS;
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS)
 		num_stats += BNXT_NUM_PORT_STATS;
@@ -583,18 +585,17 @@ static bool is_tx_ring(struct bnxt *bp, int ring_num)
 static void bnxt_get_ethtool_stats(struct net_device *dev,
 				   struct ethtool_stats *stats, u64 *buf)
 {
-	u32 i, j = 0;
+	struct bnxt_total_ring_err_stats ring_err_stats = {0};
 	struct bnxt *bp = netdev_priv(dev);
+	u64 *curr, *prev;
 	u32 tpa_stats;
+	u32 i, j = 0;
 
 	if (!bp->bnapi) {
-		j += bnxt_get_num_ring_stats(bp) + BNXT_NUM_SW_FUNC_STATS;
+		j += bnxt_get_num_ring_stats(bp);
 		goto skip_ring_stats;
 	}
 
-	for (i = 0; i < BNXT_NUM_SW_FUNC_STATS; i++)
-		bnxt_sw_func_stats[i].counter = 0;
-
 	tpa_stats = bnxt_get_num_tpa_ring_stats(bp);
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
@@ -631,19 +632,16 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 		sw = (u64 *)&cpr->sw_stats.cmn;
 		for (k = 0; k < NUM_RING_CMN_SW_STATS; j++, k++)
 			buf[j] = sw[k];
-
-		bnxt_sw_func_stats[RX_TOTAL_DISCARDS].counter +=
-			BNXT_GET_RING_STATS64(sw_stats, rx_discard_pkts);
-		bnxt_sw_func_stats[TX_TOTAL_DISCARDS].counter +=
-			BNXT_GET_RING_STATS64(sw_stats, tx_discard_pkts);
-		bnxt_sw_func_stats[RX_NETPOLL_DISCARDS].counter +=
-			cpr->sw_stats.rx.rx_netpoll_discards;
 	}
 
-	for (i = 0; i < BNXT_NUM_SW_FUNC_STATS; i++, j++)
-		buf[j] = bnxt_sw_func_stats[i].counter;
+	bnxt_get_ring_err_stats(bp, &ring_err_stats);
 
 skip_ring_stats:
+	curr = &ring_err_stats.rx_total_l4_csum_errors;
+	prev = &bp->ring_err_stats_prev.rx_total_l4_csum_errors;
+	for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++, j++, curr++, prev++)
+		buf[j] = *curr + *prev;
+
 	if (bp->flags & BNXT_FLAG_PORT_STATS) {
 		u64 *port_stats = bp->port_stats.sw_stats;
 
@@ -745,8 +743,8 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 				buf += ETH_GSTRING_LEN;
 			}
 		}
-		for (i = 0; i < BNXT_NUM_SW_FUNC_STATS; i++) {
-			strcpy(buf, bnxt_sw_func_stats[i].string);
+		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++) {
+			strscpy(buf, bnxt_ring_err_stats_arr[i], ETH_GSTRING_LEN);
 			buf += ETH_GSTRING_LEN;
 		}
 
-- 
2.30.1


--00000000000041e598060326a5c9
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDh2d9g8KiXBQr9b03tOwCNMhn2jZ5bm
lUJCLiR0L7IcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NzIzMTkzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQC3nMNTpwMLhrDmrDCqQT0YC4jgo1tSJ4AW5jyCWNP/pNI45Ici
jce6Ai1ycJec1pSsl+5frwhfpR1PSyNfCHzcDgtD8QGzDSXzgba35ZGl3bevOEjWfJl8z7iOXyMT
j5f2o17Pl+xjr0VrgJ09zmZitiuGcl/j0xl7ZNkyNrxkVq40Q2FD9RdyDIi0pjTrW8MpCohriD3e
V5FTkGiuUVjlAPXplCLWSElFXJxsDk3V/SAg2ZbsRHN68QL/2cb3x+Do9mEGFrv2p1Lvr8BmOoOk
ERVNJZZeY1D8D355U2Zsiz9VGDDfufK0dlaQwx/xQGhO3uo4dOkSJjJRyT+qypAy
--00000000000041e598060326a5c9--

