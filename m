Return-Path: <netdev+bounces-36408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05467AF8EE
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D0DFE281BF9
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2CB134B3;
	Wed, 27 Sep 2023 03:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4B14266
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:58:18 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37E21A1F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4180adafdc6so50382491cf.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695787094; x=1696391894; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZJjFmUalbc9+razahL7WHeY2CGspNez5de+hyZuGcM=;
        b=YyPtaDXti9EuKn14Ar6vbZIOnVGUuAyJWR3CCEK15Al927kKdyLrtZjg5pNMRR5B7h
         PwotTURXwuvkph4Pa1edhBAK9l1EoSWXnfb7ulVxnKHgOa/csKg1HXSf798mxWvfyIVP
         acJXx0ADJXl7iKGByfGxWX6nBjhGj3Z2fPvfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787094; x=1696391894;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZJjFmUalbc9+razahL7WHeY2CGspNez5de+hyZuGcM=;
        b=iHQwIqG3ye4BdQLoa/ZHVBYqvlljqX0+0h+V3F1CMCY+ZOOCKru524bsx210G4VPWH
         3ZemeZDVikWpuWJXtAotLNILeRhORntftPreZ/qvGSn0SQtaz7/oSWpoK7Q+rWLDvYj2
         d63k9AflCQaF4S8REKVbg24k9r8TQLjLXpqPVIGfnzy5idhcpuoI7FBSTamw+dfwCecs
         ZCvTSp5Gud3QMQiZWcXTZeG4LxoJji0daLhDMPXZXO6gzEbjlVEb6XlfWPRbzYOv8u2k
         a92O/dFJ6cUga/EyUOdBvFx0KM5NTcgNlxyMjYfrbbUCjE3HVGPEl+kCF9pad0sHi+6h
         3S9Q==
X-Gm-Message-State: AOJu0YwlFK1OZ29J5t3rlTzpMEmPDz/19NCmZ127QoApSK/LsYn8GhGc
	73bIm+2DRkAMeB3fK+yIwmDVHA==
X-Google-Smtp-Source: AGHT+IEyzLdBMI00ofrUy0u9nDeXQIzVc77/UR+0BWj0HTBUrEx9KS2I7QtI8Dku7/K40pxZJsXAUg==
X-Received: by 2002:ac8:4e4f:0:b0:3f8:71aa:f11d with SMTP id e15-20020ac84e4f000000b003f871aaf11dmr1067248qtw.37.1695787094221;
        Tue, 26 Sep 2023 20:58:14 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm9736097pga.68.2023.09.26.20.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 20:58:13 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH net-next v2 8/9] bnxt_en: Support QOS and TPID settings for the SRIOV VLAN
Date: Tue, 26 Sep 2023 20:57:33 -0700
Message-Id: <20230927035734.42816-9-michael.chan@broadcom.com>
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
	boundary="00000000000064605506064f3371"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000064605506064f3371
Content-Transfer-Encoding: 8bit

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

Add these missing settings in the .ndo_set_vf_vlan() method.
Older firmware does not support the TPID setting so check for
proper support.

Remove the unused BNXT_VF_QOS flag.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 24 ++++++++++---------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7104237272de..d0a255bd71da 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7750,6 +7750,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
+		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 43a07d84f815..ae03c5ba83ad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1135,7 +1135,6 @@ struct bnxt_vf_info {
 	u16	vlan;
 	u16	func_qcfg_flags;
 	u32	flags;
-#define BNXT_VF_QOS		0x1
 #define BNXT_VF_SPOOFCHK	0x2
 #define BNXT_VF_LINK_FORCED	0x4
 #define BNXT_VF_LINK_UP		0x8
@@ -2014,6 +2013,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_DBG_QCAPS			BIT_ULL(31)
 	#define BNXT_FW_CAP_PTP				BIT_ULL(32)
 	#define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED	BIT_ULL(33)
+	#define BNXT_FW_CAP_DFLT_VLAN_TPID_PCP		BIT_ULL(34)
 
 	u32			fw_dbg_cap;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index dde327f2c57e..98c167ff0ffb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -15,6 +15,7 @@
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/etherdevice.h>
+#include <net/dcbnl.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
@@ -196,11 +197,8 @@ int bnxt_get_vf_config(struct net_device *dev, int vf_id,
 		memcpy(&ivi->mac, vf->vf_mac_addr, ETH_ALEN);
 	ivi->max_tx_rate = vf->max_tx_rate;
 	ivi->min_tx_rate = vf->min_tx_rate;
-	ivi->vlan = vf->vlan;
-	if (vf->flags & BNXT_VF_QOS)
-		ivi->qos = vf->vlan >> VLAN_PRIO_SHIFT;
-	else
-		ivi->qos = 0;
+	ivi->vlan = vf->vlan & VLAN_VID_MASK;
+	ivi->qos = vf->vlan >> VLAN_PRIO_SHIFT;
 	ivi->spoofchk = !!(vf->flags & BNXT_VF_SPOOFCHK);
 	ivi->trusted = bnxt_is_trusted_vf(bp, vf);
 	if (!(vf->flags & BNXT_VF_LINK_FORCED))
@@ -256,21 +254,21 @@ int bnxt_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan_id, u8 qos,
 	if (bp->hwrm_spec_code < 0x10201)
 		return -ENOTSUPP;
 
-	if (vlan_proto != htons(ETH_P_8021Q))
+	if (vlan_proto != htons(ETH_P_8021Q) &&
+	    (vlan_proto != htons(ETH_P_8021AD) ||
+	     !(bp->fw_cap & BNXT_FW_CAP_DFLT_VLAN_TPID_PCP)))
 		return -EPROTONOSUPPORT;
 
 	rc = bnxt_vf_ndo_prep(bp, vf_id);
 	if (rc)
 		return rc;
 
-	/* TODO: needed to implement proper handling of user priority,
-	 * currently fail the command if there is valid priority
-	 */
-	if (vlan_id > 4095 || qos)
+	if (vlan_id >= VLAN_N_VID || qos >= IEEE_8021Q_MAX_PRIORITIES ||
+	    (!vlan_id && qos))
 		return -EINVAL;
 
 	vf = &bp->pf.vf[vf_id];
-	vlan_tag = vlan_id;
+	vlan_tag = vlan_id | (u16)qos << VLAN_PRIO_SHIFT;
 	if (vlan_tag == vf->vlan)
 		return 0;
 
@@ -279,6 +277,10 @@ int bnxt_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan_id, u8 qos,
 		req->fid = cpu_to_le16(vf->fw_fid);
 		req->dflt_vlan = cpu_to_le16(vlan_tag);
 		req->enables = cpu_to_le32(FUNC_CFG_REQ_ENABLES_DFLT_VLAN);
+		if (bp->fw_cap & BNXT_FW_CAP_DFLT_VLAN_TPID_PCP) {
+			req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_TPID);
+			req->tpid = vlan_proto;
+		}
 		rc = hwrm_req_send(bp, req);
 		if (!rc)
 			vf->vlan = vlan_tag;
-- 
2.30.1


--00000000000064605506064f3371
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJIVy6Qvb/jByhqSb9tlyhY/NbYPaO5b
0viwzBSzNaKVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDky
NzAzNTgxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBc4lDaCjNFWGG7daL17pxQje4Pa8Lmn+v2ZU6bNl9fogK4Zy2E
G/XwYSMbbdogNY3xUAePa8tNv94XeQyOPPWl0y9QH0z1G7BGMc40zLrqFbQgrSPYW7IqvmrEWHRs
fupHj39Ca7tKP77irlp3dpKclIFnuuGXJw44pcUJsnYaZl9YO+zzzaAqm6Kvxu8XzBlxE0i1U+Su
h7tIRL8ZAltcGTjDzfxArme43eeY9x5ejj/Em8rTZVKtRJniksAysHTzs9k+LoqvpVfspq+V5uTA
CmwrJLCrx7WBZY2rIzEBtZ5qtovL/iYWsJsShXYK5HLTKjtvXl2+grdGhKcuMJgN
--00000000000064605506064f3371--

