Return-Path: <netdev+bounces-36409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD017AF8EF
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3F279281E3C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7F14266;
	Wed, 27 Sep 2023 03:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544C134D9
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:58:20 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875E221BF
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so7892586b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695787096; x=1696391896; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlhF0jeSPJwYp+AIaSV7vaQC1+utwBR42k7VCmw4a48=;
        b=RxVOA7z/DE6rX2TKVQ0/23U0pCygTHuw5Fkwylzn6UDmICsF3BY0mRRKVUVfUzc5Og
         dM/2+VysdK6J8KVbm6rgxAAry6F695qzNEl7Prt45lY/CYAKC3M/gzMiil/fS9f/grr+
         g7rHtAFx+hHKeinSiNma7X2sPxGap+1Jxcy8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787096; x=1696391896;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlhF0jeSPJwYp+AIaSV7vaQC1+utwBR42k7VCmw4a48=;
        b=AbhtyMbyMb5ptMiNyVRiqAeD/UrMQ8q2S+sA0hHZkta+UuYoZscLySuidPj64tlYNZ
         pdLAVQnV7ZcFnQI0HXOlDv32hRzH9C7feP29+7iyq2CFypdCJYVy5m50OJOCVrm5uJDx
         kWfeuW+zQaHzCp3sumF4nDFrdV7s+jjSHy00938yEffYIeL9q9vswxbKTSHMaMnZk3Du
         fWocHQbKdOS89dRSVzAPvb7Ndvi7FKkT+u8wRGMaw1aCXtZCFa8lBW7nhi/hnSDg+GPa
         n9z7tNv/FRMfiOyNmq6xTDFR3Std9RzxGUScSdF4BxfPaxmSd1jALw+gLANyjDFe03V6
         Raiw==
X-Gm-Message-State: AOJu0YzKlTUtJ0cTjmRUWyabdCkNzvNcKHxkKtCtrE8PQ84GDrrV0tjL
	wNgjZ2jm9D+FsgS1i1wmRDNSPw==
X-Google-Smtp-Source: AGHT+IGVtsTvtMg+L28q4Rm0tITBRTjtDMM7ZYaN1holkr5J9bdUllLtrlYfaqgK+cMF6G0USjL7/A==
X-Received: by 2002:a05:6a00:1412:b0:68f:c215:a825 with SMTP id l18-20020a056a00141200b0068fc215a825mr986775pfu.12.1695787095500;
        Tue, 26 Sep 2023 20:58:15 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm9736097pga.68.2023.09.26.20.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 20:58:14 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v2 9/9] bnxt_en: Update VNIC resource calculation for VFs
Date: Tue, 26 Sep 2023 20:57:34 -0700
Message-Id: <20230927035734.42816-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230927035734.42816-1-michael.chan@broadcom.com>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f6b1b06064f33ba"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000007f6b1b06064f33ba
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

Newer versions of firmware will pre-reserve 1 VNIC for every possible
PF and VF function.  Update the driver logic to take this into account
when assigning VNICs to the VFs.  These pre-reserved VNICs for the
inactive VFs should be subtracted from the global pool before
assigning them to the active VFs.

Not doing so may cause discrepancies that ultimately may cause some VFs to
have insufficient VNICs to support features such as aRFS.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 17 +++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 12 ++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d0a255bd71da..82833326a852 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12215,6 +12215,20 @@ static void bnxt_init_dflt_coal(struct bnxt *bp)
 	bp->stats_coal_ticks = BNXT_DEF_STATS_COAL_TICKS;
 }
 
+/* FW that pre-reserves 1 VNIC per function */
+static bool bnxt_fw_pre_resv_vnics(struct bnxt *bp)
+{
+	u16 fw_maj = BNXT_FW_MAJ(bp), fw_bld = BNXT_FW_BLD(bp);
+
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5) &&
+	    (fw_maj > 218 || (fw_maj == 218 && fw_bld >= 18)))
+		return true;
+	if ((bp->flags & BNXT_FLAG_CHIP_P5) &&
+	    (fw_maj > 216 || (fw_maj == 216 && fw_bld >= 172)))
+		return true;
+	return false;
+}
+
 static int bnxt_fw_init_one_p1(struct bnxt *bp)
 {
 	int rc;
@@ -12271,6 +12285,9 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
 	if (rc)
 		return -ENODEV;
 
+	if (bnxt_fw_pre_resv_vnics(bp))
+		bp->fw_cap |= BNXT_FW_CAP_PRE_RESV_VNICS;
+
 	bnxt_hwrm_func_qcfg(bp);
 	bnxt_hwrm_vnic_qcaps(bp);
 	bnxt_hwrm_port_led_qcaps(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ae03c5ba83ad..5d8252272cc9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2014,6 +2014,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_PTP				BIT_ULL(32)
 	#define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED	BIT_ULL(33)
 	#define BNXT_FW_CAP_DFLT_VLAN_TPID_PCP		BIT_ULL(34)
+	#define BNXT_FW_CAP_PRE_RESV_VNICS		BIT_ULL(35)
 
 	u32			fw_dbg_cap;
 
@@ -2054,6 +2055,7 @@ struct bnxt {
 #define BNXT_FW_VER_CODE(maj, min, bld, rsv)			\
 	((u64)(maj) << 48 | (u64)(min) << 32 | (u64)(bld) << 16 | (rsv))
 #define BNXT_FW_MAJ(bp)		((bp)->fw_ver_code >> 48)
+#define BNXT_FW_BLD(bp)		(((bp)->fw_ver_code >> 16) & 0xffff)
 
 	u16			vxlan_fw_dst_port_id;
 	u16			nge_fw_dst_port_id;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 98c167ff0ffb..38fe44838639 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -552,7 +552,6 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings;
 	vf_tx_rings = hw_resc->max_tx_rings - bp->tx_nr_rings;
 	vf_vnics = hw_resc->max_vnics - bp->nr_vnics;
-	vf_vnics = min_t(u16, vf_vnics, vf_rx_rings);
 	vf_rss = hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs;
 
 	req->min_rsscos_ctx = cpu_to_le16(BNXT_VF_MIN_RSS_CTX);
@@ -574,11 +573,20 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 		vf_cp_rings /= num_vfs;
 		vf_tx_rings /= num_vfs;
 		vf_rx_rings /= num_vfs;
-		vf_vnics /= num_vfs;
+		if ((bp->fw_cap & BNXT_FW_CAP_PRE_RESV_VNICS) &&
+		    vf_vnics >= pf->max_vfs) {
+			/* Take into account that FW has pre-reserved 1 VNIC for
+			 * each pf->max_vfs.
+			 */
+			vf_vnics = (vf_vnics - pf->max_vfs + num_vfs) / num_vfs;
+		} else {
+			vf_vnics /= num_vfs;
+		}
 		vf_stat_ctx /= num_vfs;
 		vf_ring_grps /= num_vfs;
 		vf_rss /= num_vfs;
 
+		vf_vnics = min_t(u16, vf_vnics, vf_rx_rings);
 		req->min_cmpl_rings = cpu_to_le16(vf_cp_rings);
 		req->min_tx_rings = cpu_to_le16(vf_tx_rings);
 		req->min_rx_rings = cpu_to_le16(vf_rx_rings);
-- 
2.30.1


--0000000000007f6b1b06064f33ba
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHHFwvuZa52TfGX8i7ovVgvbgZNhbqub
533Tlvl1cKmiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDky
NzAzNTgxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCprI1B6LVetrN6F024qkZP+xg9cQYztjk9E2Xi5yHj9T611i9k
baNzP7d7av+n8HLaF6MSv+PAlRT02CHT2qJ9K5gOKSArvIF0kLE3T+dVlFE7TxJiK7wt8dBVRXBx
3klzFUUUTFYoJdILYx4jQ6atjhVMn1dtaUkJh1iMIO0otUi1eRBrwP8vME+Y9NQdIqakSlDu1QB5
Jysw8Vu7MxqP1m5AuQBlBcSiIv3tCbmXhobpmkNBebOJlmjfBDunMx3Pqn3PR+OmRqXArm1BR20h
EKELc8dMRvaqxdHINWAEpq/EhrOKNuPes4Td2wt2Gp/0nU8n8qXEE9W+GwNiOR9z
--0000000000007f6b1b06064f33ba--

