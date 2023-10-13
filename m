Return-Path: <netdev+bounces-40720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B57C8743
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA23282D46
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636251805C;
	Fri, 13 Oct 2023 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eMJEWclI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E015E94
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 13:58:01 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609395
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 06:57:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c8a1541233so16559245ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697205479; x=1697810279; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jsX0nrgmp+XOc5zRs9vYOic8Z/e92RdpDpf/C0GLLg0=;
        b=eMJEWclIiPnstADOHKKRK8YEXICqiRA14mj931FPUTAwj3thTBu7D71WrS87fXDfgs
         UDYaBmo7Y70sZ7LAdtswIro57yeU7LsXqEfXbM5VsneGnTHKVyNSqrXwfX81orPL31dU
         Qc8rYkcqts6CjZFLHSOWKFm5TAiVbaSh3N+S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697205479; x=1697810279;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsX0nrgmp+XOc5zRs9vYOic8Z/e92RdpDpf/C0GLLg0=;
        b=geIsBppyPkCEZqf5ZkV9hIOWU74DWvGEGLttU4DRa0RDePMLhIz0YY9hwPzxBJSMiz
         jeSNEwkt0kYAI7G2vN1vJ+mBifOo2R2WZ/QddETJbMFogAaugm2sQrAYM6ERTKKRHUAZ
         OTNOsgtz4R+PQ8lMndfo7BWYAlYSYqmiAbKKdYdd14S/inlbduR/j5ELBczLyv9u5EYo
         pTclbpJwnx6UD7z77IkwaH4+UKgi3OiWZr8FnPtzdkJrawthEZ9L+1UCJulfwVbZQF8A
         SNava4clqo+LgYV7EYC8qFN+GUasGd3FkHYnkxp20weAevAHIH6EyDckiKO9EHhZn8e3
         dq4Q==
X-Gm-Message-State: AOJu0Yx3huTZBTTM/frjnYTbMCqIJe8hhzGNhKUGOdD9huGpXcN7ByC7
	jiZpe4u2nPUJvdB29DrEQQopNNUaw5sf1fO90RU=
X-Google-Smtp-Source: AGHT+IHAImDP0NkoHsOj6oFauOleS9S0hCNUI1TAQ6hwuvaKwBbB7aA6t2SxAu0DlwZPhx21d8jlhw==
X-Received: by 2002:a17:902:e809:b0:1c0:6e92:8cc5 with SMTP id u9-20020a170902e80900b001c06e928cc5mr25184667plg.17.1697205478931;
        Fri, 13 Oct 2023 06:57:58 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001bf11cf2e21sm3933201plb.210.2023.10.13.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:57:56 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	gospo@broadcom.com,
	pabeni@redhat.com,
	edumazet@google.com,
	richardcochran@gmail.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Simon White <Simon.White@viavisolutions.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next] tg3: Improve PTP TX timestamping logic
Date: Fri, 13 Oct 2023 06:59:19 -0700
Message-Id: <20231013135919.408357-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b7814706079971f1"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000b7814706079971f1
Content-Transfer-Encoding: 8bit

When we are trying to timestamp a TX packet, there may be
occasions when the TX timestamp register is still not
updated with the latest timestamp even if the timestamp
packet descriptor is marked as complete.
This usually happens in cases where the system is under
stress or flow control is affecting the transmit side.

We will solve this problem by saving the snapshot of the
timestamp register when we are posting the TX descriptor.
At this time, the register contains previously timestamped
packet's value and valid timestamp of the current packet must
be different than this.
Upon completion of the current descriptor, we will check if
the timestamp register is updated or not before timestamping
the skb. If not updated, we will schedule the ptp worker to
fetch the updated time later and timestamp the skb.
Also now we restrict number of outstanding PTP TX packet
requests to 1.

Reported-by: Simon White <Simon.White@viavisolutions.com>
Link: https://lore.kernel.org/netdev/CACKFLikGdN9XPtWk-fdrzxdcD=+bv-GHBvfVfSpJzHY7hrW39g@mail.gmail.com/
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 81 +++++++++++++++++++++++------
 drivers/net/ethernet/broadcom/tg3.h |  3 ++
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..59896bbf9e73 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6314,6 +6314,46 @@ static int tg3_ptp_enable(struct ptp_clock_info *ptp,
 	return -EOPNOTSUPP;
 }
 
+static void tg3_hwclock_to_timestamp(struct tg3 *tp, u64 hwclock,
+				     struct skb_shared_hwtstamps *timestamp)
+{
+	memset(timestamp, 0, sizeof(struct skb_shared_hwtstamps));
+	timestamp->hwtstamp  = ns_to_ktime((hwclock & TG3_TSTAMP_MASK) +
+					   tp->ptp_adjust);
+}
+
+static void tg3_read_tx_tstamp(struct tg3 *tp, u64 *hwclock)
+{
+	*hwclock = tr32(TG3_TX_TSTAMP_LSB);
+	*hwclock |= (u64)tr32(TG3_TX_TSTAMP_MSB) << 32;
+}
+
+static long tg3_ptp_ts_aux_work(struct ptp_clock_info *ptp)
+{
+	struct tg3 *tp = container_of(ptp, struct tg3, ptp_info);
+	struct skb_shared_hwtstamps timestamp;
+	u64 hwclock;
+
+	if (tp->ptp_txts_retrycnt > 2)
+		goto done;
+
+	tg3_read_tx_tstamp(tp, &hwclock);
+
+	if (hwclock != tp->pre_tx_ts) {
+		tg3_hwclock_to_timestamp(tp, hwclock, &timestamp);
+		skb_tstamp_tx(tp->tx_tstamp_skb, &timestamp);
+		goto done;
+	}
+	tp->ptp_txts_retrycnt++;
+	return HZ / 10;
+done:
+	dev_consume_skb_any(tp->tx_tstamp_skb);
+	tp->tx_tstamp_skb = NULL;
+	tp->ptp_txts_retrycnt = 0;
+	tp->pre_tx_ts = 0;
+	return -1;
+}
+
 static const struct ptp_clock_info tg3_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "tg3 clock",
@@ -6325,19 +6365,12 @@ static const struct ptp_clock_info tg3_ptp_caps = {
 	.pps		= 0,
 	.adjfine	= tg3_ptp_adjfine,
 	.adjtime	= tg3_ptp_adjtime,
+	.do_aux_work	= tg3_ptp_ts_aux_work,
 	.gettimex64	= tg3_ptp_gettimex,
 	.settime64	= tg3_ptp_settime,
 	.enable		= tg3_ptp_enable,
 };
 
-static void tg3_hwclock_to_timestamp(struct tg3 *tp, u64 hwclock,
-				     struct skb_shared_hwtstamps *timestamp)
-{
-	memset(timestamp, 0, sizeof(struct skb_shared_hwtstamps));
-	timestamp->hwtstamp  = ns_to_ktime((hwclock & TG3_TSTAMP_MASK) +
-					   tp->ptp_adjust);
-}
-
 /* tp->lock must be held */
 static void tg3_ptp_init(struct tg3 *tp)
 {
@@ -6368,6 +6401,8 @@ static void tg3_ptp_fini(struct tg3 *tp)
 	ptp_clock_unregister(tp->ptp_clock);
 	tp->ptp_clock = NULL;
 	tp->ptp_adjust = 0;
+	dev_consume_skb_any(tp->tx_tstamp_skb);
+	tp->tx_tstamp_skb = NULL;
 }
 
 static inline int tg3_irq_sync(struct tg3 *tp)
@@ -6538,6 +6573,7 @@ static void tg3_tx(struct tg3_napi *tnapi)
 
 	while (sw_idx != hw_idx) {
 		struct tg3_tx_ring_info *ri = &tnapi->tx_buffers[sw_idx];
+		bool complete_skb_later = false;
 		struct sk_buff *skb = ri->skb;
 		int i, tx_bug = 0;
 
@@ -6548,12 +6584,17 @@ static void tg3_tx(struct tg3_napi *tnapi)
 
 		if (tnapi->tx_ring[sw_idx].len_flags & TXD_FLAG_HWTSTAMP) {
 			struct skb_shared_hwtstamps timestamp;
-			u64 hwclock = tr32(TG3_TX_TSTAMP_LSB);
-			hwclock |= (u64)tr32(TG3_TX_TSTAMP_MSB) << 32;
-
-			tg3_hwclock_to_timestamp(tp, hwclock, &timestamp);
+			u64 hwclock;
 
-			skb_tstamp_tx(skb, &timestamp);
+			tg3_read_tx_tstamp(tp, &hwclock);
+			if (hwclock != tp->pre_tx_ts) {
+				tg3_hwclock_to_timestamp(tp, hwclock, &timestamp);
+				skb_tstamp_tx(skb, &timestamp);
+				tp->pre_tx_ts = 0;
+			} else {
+				tp->tx_tstamp_skb = skb;
+				complete_skb_later = true;
+			}
 		}
 
 		dma_unmap_single(&tp->pdev->dev, dma_unmap_addr(ri, mapping),
@@ -6591,7 +6632,10 @@ static void tg3_tx(struct tg3_napi *tnapi)
 		pkts_compl++;
 		bytes_compl += skb->len;
 
-		dev_consume_skb_any(skb);
+		if (!complete_skb_later)
+			dev_consume_skb_any(skb);
+		else
+			ptp_schedule_worker(tp->ptp_clock, 0);
 
 		if (unlikely(tx_bug)) {
 			tg3_tx_recover(tp);
@@ -8028,8 +8072,13 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if ((unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) &&
 	    tg3_flag(tp, TX_TSTAMP_EN)) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-		base_flags |= TXD_FLAG_HWTSTAMP;
+		tg3_full_lock(tp, 0);
+		if (!tp->pre_tx_ts) {
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			base_flags |= TXD_FLAG_HWTSTAMP;
+			tg3_read_tx_tstamp(tp, &tp->pre_tx_ts);
+		}
+		tg3_full_unlock(tp);
 	}
 
 	len = skb_headlen(skb);
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 1000c894064f..ae5c01bd1110 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3190,6 +3190,7 @@ struct tg3 {
 	struct ptp_clock_info		ptp_info;
 	struct ptp_clock		*ptp_clock;
 	s64				ptp_adjust;
+	u8				ptp_txts_retrycnt;
 
 	/* begin "tx thread" cacheline section */
 	void				(*write32_tx_mbox) (struct tg3 *, u32,
@@ -3372,6 +3373,8 @@ struct tg3 {
 	struct tg3_hw_stats		*hw_stats;
 	dma_addr_t			stats_mapping;
 	struct work_struct		reset_task;
+	struct sk_buff			*tx_tstamp_skb;
+	u64				pre_tx_ts;
 
 	int				nvram_lock_cnt;
 	u32				nvram_size;
-- 
2.39.1


--000000000000b7814706079971f1
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
XzCCBUwwggQ0oAMCAQICDBX9eQgKNWxyfhI1kzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE3NDZaFw0yNTA5MTAwODE3NDZaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDFBhdmFuIENoZWJiaTEoMCYGCSqGSIb3DQEJ
ARYZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAK3X+BRR67FR5+Spki/E25HnHoYhm/cC6VA6qHwC3QqBNhCT13zsi1FLLERdKXPRrtVBM6d0
mfg/0rQJJ8Ez4C3CcKiO1XHcmESeW6lBKxOo83ZwWhVhyhNbGSwcrytDCKUVYBwwxR3PAyXtIlWn
kDqifgqn3R9r2vJM7ckge8dtVPS0j9t3CNfDBjGw1DhK91fnoH1s7tLdj3vx9ZnKTmSl7F1psK2P
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGbWx+5B9/PGBPx/UodXVEUdx4w+6YR2
CIsqdqpnTob9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAx
MzEzNTc1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBKxdXxGwU7XgIOH2nsfFaxNetkPJxKMC1fYg8xj2tivRtHbXV3
biRq684uIMwV+Y2Svv0UvepnjW5iDtStp4UgFKftnvKmQDNJ35IP126sUarMxtaRPyIOdBRbvHbt
/zreJLfAFOo64/n3UCAEHrXGm464/ph3iFmAZlU4zFTyAvtiU8NVh4O04VwqUZdKhNBoTyTk5Ad4
+uF+wwvXxRN2iFJlF8FamWlGXQ9Fnsyykkc8JwIAZL/Fe2/5q8JDuusT1M93Owgmj4DISgb7Xmvj
KGsdY05YygR2i33lLJ589f44oyiLiddZEU8jTgCSmjtp+KteZg6yhHGCe2ettlTJ
--000000000000b7814706079971f1--

