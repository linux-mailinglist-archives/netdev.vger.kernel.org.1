Return-Path: <netdev+bounces-60053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0D81D22C
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 05:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382271F21DE8
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 04:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676817D4;
	Sat, 23 Dec 2023 04:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y3icShDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526A8C1E
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f6729a57fso26755146d6.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703305369; x=1703910169; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0LpheEy8PSBCbQ3lbSWjy+zFqXKoBuAeyCshaTDpNY=;
        b=Y3icShDXTXKsDTOgHt49uI2PUNjyODa+scww81peVG5fn76jR+KBghjTNh2ajjXgJK
         aCeJMDBcRC47wj1gXiqQHya44T0a1qexy1n/Ua0aXU0SRaIGyVpxD8sXl5eUYBLZeD2X
         FiplBAup4D3h7yi2qR2Q0LRb1s2O0a88ata98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305369; x=1703910169;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0LpheEy8PSBCbQ3lbSWjy+zFqXKoBuAeyCshaTDpNY=;
        b=jgSAoSrNkIO9zRSm5BhIs9a/Ct7NRtzxDCwQbUR1nxxcDS7pGqAVXKQXRZqTApHfdY
         rvlulJ76PDa0mThWeZB6PE6bjnTjiQ+4jj5/yb0OGeq8tBM9x8vAFh6kZ4qmZWvnOm0r
         iZqQ82R9jReNm50MV9ra0Xj/ENugz5duLcqoHdagiCpdotaxsKneTqNHcatInIUhhAym
         qzx6w/NIb3Yz3S2+KJI66pk2MqzPzy/NINFW3e9F82AwiPOOn2VQS5AYDuabqktk0ykP
         za3K9qXkc2w0KBO6vdf+yx8IUJrqHJYIqtJE/EgsiZTkPIOqXO5jlO72w/TLIjDPcutK
         t5Gg==
X-Gm-Message-State: AOJu0Yy5MoXSZFOF66PAfvbMMLHlCrGEde6FO8sDVfh+nE1Tp3PPlwgr
	IQ2rVbunAgtj6lljQ3KUCP1rjTlWApFm
X-Google-Smtp-Source: AGHT+IEuhKy4cRvFjPDjApjArhK2MwY5Fx74LD4vm/8J9wPIamYwoqTv2YYs0Id7RM463B6/5aJToA==
X-Received: by 2002:ad4:5963:0:b0:67a:aa87:7ae2 with SMTP id eq3-20020ad45963000000b0067aaa877ae2mr3925349qvb.40.1703305369377;
        Fri, 22 Dec 2023 20:22:49 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm1299916qvb.144.2023.12.22.20.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 20:22:49 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 09/13] bnxt_en: Refactor the hash table logic for ntuple filters.
Date: Fri, 22 Dec 2023 20:22:06 -0800
Message-Id: <20231223042210.102485-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231223042210.102485-1-michael.chan@broadcom.com>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008213cf060d25af36"

--0000000000008213cf060d25af36
Content-Transfer-Encoding: 8bit

Generalize the ethtool logic that walks the ntuple hash table now that
we have the common bnxt_filter_base structure.  This will allow the code
to easily extend to cover user defined ntuple or ether filters.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 85 +++++++++++++------
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 097d440339b0..1e5bf8b7dd55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5615,6 +5615,7 @@ static int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 	struct hwrm_cfa_ntuple_filter_free_input *req;
 	int rc;
 
+	set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
 	rc = hwrm_req_init(bp, req, HWRM_CFA_NTUPLE_FILTER_FREE);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 73e2fe705caf..f37d98d7962a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1349,6 +1349,7 @@ struct bnxt_filter_base {
 	unsigned long		state;
 #define BNXT_FLTR_VALID		0
 #define BNXT_FLTR_INSERTED	1
+#define BNXT_FLTR_FW_DELETED	2
 
 	struct rcu_head         rcu;
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 65edad2cfeab..8cc762a12a3e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1012,28 +1012,60 @@ static int bnxt_set_channels(struct net_device *dev,
 }
 
 #ifdef CONFIG_RFS_ACCEL
-static int bnxt_grxclsrlall(struct bnxt *bp, struct ethtool_rxnfc *cmd,
-			    u32 *rule_locs)
+static u32 bnxt_get_all_fltr_ids_rcu(struct bnxt *bp, struct hlist_head tbl[],
+				     int tbl_size, u32 *ids, u32 start,
+				     u32 id_cnt)
 {
-	int i, j = 0;
+	int i, j = start;
 
-	cmd->data = bp->ntp_fltr_count;
-	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++) {
+	if (j >= id_cnt)
+		return j;
+	for (i = 0; i < tbl_size; i++) {
 		struct hlist_head *head;
-		struct bnxt_ntuple_filter *fltr;
+		struct bnxt_filter_base *fltr;
 
-		head = &bp->ntp_fltr_hash_tbl[i];
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(fltr, head, base.hash) {
-			if (j == cmd->rule_cnt)
-				break;
-			rule_locs[j++] = fltr->base.sw_id;
+		head = &tbl[i];
+		hlist_for_each_entry_rcu(fltr, head, hash) {
+			if (!fltr->flags ||
+			    test_bit(BNXT_FLTR_FW_DELETED, &fltr->state))
+				continue;
+			ids[j++] = fltr->sw_id;
+			if (j == id_cnt)
+				return j;
 		}
-		rcu_read_unlock();
-		if (j == cmd->rule_cnt)
-			break;
 	}
-	cmd->rule_cnt = j;
+	return j;
+}
+
+static struct bnxt_filter_base *bnxt_get_one_fltr_rcu(struct bnxt *bp,
+						      struct hlist_head tbl[],
+						      int tbl_size, u32 id)
+{
+	int i;
+
+	for (i = 0; i < tbl_size; i++) {
+		struct hlist_head *head;
+		struct bnxt_filter_base *fltr;
+
+		head = &tbl[i];
+		hlist_for_each_entry_rcu(fltr, head, hash) {
+			if (fltr->flags && fltr->sw_id == id)
+				return fltr;
+		}
+	}
+	return NULL;
+}
+
+static int bnxt_grxclsrlall(struct bnxt *bp, struct ethtool_rxnfc *cmd,
+			    u32 *rule_locs)
+{
+	cmd->data = bp->ntp_fltr_count;
+	rcu_read_lock();
+	cmd->rule_cnt = bnxt_get_all_fltr_ids_rcu(bp, bp->ntp_fltr_hash_tbl,
+						  BNXT_NTP_FLTR_HASH_SIZE,
+						  rule_locs, 0, cmd->rule_cnt);
+	rcu_read_unlock();
+
 	return 0;
 }
 
@@ -1041,27 +1073,24 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fs =
 		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct bnxt_filter_base *fltr_base;
 	struct bnxt_ntuple_filter *fltr;
 	struct flow_keys *fkeys;
-	int i, rc = -EINVAL;
+	int rc = -EINVAL;
 
 	if (fs->location >= BNXT_NTP_FLTR_MAX_FLTR)
 		return rc;
 
-	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++) {
-		struct hlist_head *head;
-
-		head = &bp->ntp_fltr_hash_tbl[i];
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(fltr, head, base.hash) {
-			if (fltr->base.sw_id == fs->location)
-				goto fltr_found;
-		}
+	rcu_read_lock();
+	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
+					  BNXT_NTP_FLTR_HASH_SIZE,
+					  fs->location);
+	if (!fltr_base) {
 		rcu_read_unlock();
+		return rc;
 	}
-	return rc;
+	fltr = container_of(fltr_base, struct bnxt_ntuple_filter, base);
 
-fltr_found:
 	fkeys = &fltr->fkeys;
 	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
 		if (fkeys->basic.ip_proto == IPPROTO_TCP)
-- 
2.30.1


--0000000000008213cf060d25af36
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH9gDetIHUc52RhKeyovG+BwtaW9qOaH
kyaIInj++IFQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MzA0MjI0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBnmDjCRYoF2kkz32AZTwhmOKLH0UHts07jLKIhkUuyFVTqn5YQ
4uJLnv68Bhx+0uvBiWqw1Z4lhdODW0ViP6ocb82C7U0CgKOtRdfoiIEL6WiQQyQPHFzHk94Pb4oS
FNCrtHqOkqOHNVCgQmbqBUJkGhiOWGxcNMq5ljbvBjcSrRnc+66x1oOz7BCOGbMlkl+DQaldux7p
kJZnr8zb7GLnRcZyejyZlro1DqcbbQ9DXOFI+JyHhhxI8DRZWlFSCrE3hkighhUiOQcechjc+XOg
Var2JGWZCpdX20FkWFJA0F4fgkxpxIaxagfatnX5IZS1AO+QUjcrsVvOHIK4P93u
--0000000000008213cf060d25af36--

