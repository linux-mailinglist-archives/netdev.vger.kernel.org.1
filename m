Return-Path: <netdev+bounces-81839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09988B424
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA391C3CCA6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB884D1D;
	Mon, 25 Mar 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bLU/Iucf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF684FDD
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405792; cv=none; b=rXquwExIFRK7ZPsL0h6vDQJCuWgz2AnxXk5sESmSSobhhZFCaXc8oCj26Kay3hs7rDefsk+d+bipP1rmCmW1asjLdi8owzysUnOrs2rNQPk0/tjDYX56uj0a4l6a1VTBAD7tHa2p5HQIg1BYB3KQ4/3fu0mvo7iYy9++NzU5EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405792; c=relaxed/simple;
	bh=VLAVYCUS0ARBXr0PrIJhD6AeMEiwLoAp9Pvqf97q1DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeAfZkJFBWk0iz8uL4Fq7yl7NzBhYnDBXcG7Bsjl2GjZ8ROnmEtkyRLvRNj45dh7QhImaqENEDaU7FBmEudyZRYAry+0D1QnUSTvjs1Ge5EYnIt0CRYmT/+91zUPxHDz6/Ufhw1mzoQR4C78YB4JUcZqzKdCecqkKp1WJlJlvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bLU/Iucf; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3678908266dso23203025ab.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405790; x=1712010590; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+JGkVciHq/yC1v1KfXP3S6UIMGD0RVeKWEiBerjYEY=;
        b=bLU/IucfRsgOQOa/l2YoFom+Wn9ZetcY9dEIiV5HHd6d2nalw1VWwZqNAecRqMgtnH
         /BkfqMM36B3VGDR/I9lPJqKEpLH5AnlMZ27/LjmMXpIRo7c0GuORAEqzOEk5DWG9eexn
         k+YCeIJJ6BbMoOGq8HyuyGWqZ1pPyXms17ITA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405790; x=1712010590;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+JGkVciHq/yC1v1KfXP3S6UIMGD0RVeKWEiBerjYEY=;
        b=sn3Zv/E0ZDTICaDvaw5a57ru29NHHa6VDAEDn2hnW1oIrBmVcAygrD9ID80lzsUuWG
         PvSqzPDlqJamY/JOA4WfSPC6R5h95cFl19+M22ChOcpKXsSZSKnAa11Jk0YsbB2mpDlg
         Nr4oJ8hfA1v7pw2ArGBrZHtZaq8JhQJEcGajlq56LNuhxoReIg5/VpmhCrCTUdIyRP52
         qcaE1SaEmk11tIjyirko/St3tEvOVD8uPhCfnmJs5R0ZUsZ9Nk964+eRadp1xP3L3j/u
         DJKD2cogQRTHTRnLol/ClxgzJIdAGtKCx+m6AgJ6RjoODVRREheySK0Zrk4GlMUgDxP8
         5RaQ==
X-Gm-Message-State: AOJu0YxiPmqnyU/ZQwHqCn+c/2yPuP3X8FvsfzfMIS0vcVZ40TkfDVnP
	PfI29Y+aGHZz0OZ3cfhX9XHphfEUTspFSrThQDQ9Dr4i0EIh6P/1K2fZPUXXCA==
X-Google-Smtp-Source: AGHT+IEyRwkhm50t46f5dcfcPdxGnyo0Gj4LW1B38T1gGJ+z23etxRpsTJvoxc1qD8JjibgWzlklSg==
X-Received: by 2002:a92:c567:0:b0:366:bbb9:d624 with SMTP id b7-20020a92c567000000b00366bbb9d624mr10715348ilj.3.1711405789523;
        Mon, 25 Mar 2024 15:29:49 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:48 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 12/12] bnxt_en: Support adding ntuple rules on RSS contexts
Date: Mon, 25 Mar 2024 15:29:02 -0700
Message-Id: <20240325222902.220712-13-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240325222902.220712-1-michael.chan@broadcom.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000032493e061483b62d"

--00000000000032493e061483b62d
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

When the user wants to add an ntuple filter to an RSS context, select
the appropriate VNIC belonging to the selected RSS context and add the
VNIC destination rule.

Make the necessary changes to bnxt_add_ntuple_cls_rule().

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 26 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 33 ++++++++++++++-----
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 88d4116cfd79..388e80bf91f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5791,8 +5791,20 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 			  struct hwrm_cfa_ntuple_filter_alloc_input *req,
 			  struct bnxt_ntuple_filter *fltr)
 {
+	struct bnxt_rss_ctx *rss_ctx, *tmp;
 	u16 rxq = fltr->base.rxq;
 
+	if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
+		list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list) {
+			if (rss_ctx->index == fltr->base.fw_vnic_id) {
+				struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+
+				req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
+				break;
+			}
+		}
+		return;
+	}
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
 		struct bnxt_vnic_info *vnic;
 		u32 enables;
@@ -9944,6 +9956,8 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all)
 {
 	struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+	struct bnxt_filter_base *usr_fltr, *tmp;
+	struct bnxt_ntuple_filter *ntp_fltr;
 	int i;
 
 	bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
@@ -9954,6 +9968,18 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	if (!all)
 		return;
 
+	list_for_each_entry_safe(usr_fltr, tmp, &bp->usr_fltr_list, list) {
+		if ((usr_fltr->flags & BNXT_ACT_RSS_CTX) &&
+		    usr_fltr->fw_vnic_id == rss_ctx->index) {
+			ntp_fltr = container_of(usr_fltr,
+						struct bnxt_ntuple_filter,
+						base);
+			bnxt_hwrm_cfa_ntuple_filter_free(bp, ntp_fltr);
+			bnxt_del_ntp_filter(bp, ntp_fltr);
+			bnxt_del_one_usr_fltr(bp, usr_fltr);
+		}
+	}
+
 	if (vnic->rss_table)
 		dma_free_coherent(&bp->pdev->dev, vnic->rss_table_size,
 				  vnic->rss_table,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 37a850959315..0640fcb57ef8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1374,6 +1374,7 @@ struct bnxt_filter_base {
 #define BNXT_ACT_RING_DST	2
 #define BNXT_ACT_FUNC_DST	4
 #define BNXT_ACT_NO_AGING	8
+#define BNXT_ACT_RSS_CTX	0x10
 	u16			sw_id;
 	u16			rxq;
 	u16			fw_vnic_id;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4dbe80b11dda..9c49f629d565 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1312,22 +1312,24 @@ static bool bnxt_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
 }
 
 static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
-				    struct ethtool_rx_flow_spec *fs)
+				    struct ethtool_rxnfc *cmd)
 {
-	u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
-	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
 	struct bnxt_ntuple_filter *new_fltr, *fltr;
+	u32 flow_type = fs->flow_type & 0xff;
 	struct bnxt_l2_filter *l2_fltr;
 	struct bnxt_flow_masks *fmasks;
-	u32 flow_type = fs->flow_type;
 	struct flow_keys *fkeys;
-	u32 idx;
+	u32 idx, ring;
 	int rc;
+	u8 vf;
 
 	if (!bp->vnic_info)
 		return -EAGAIN;
 
-	if ((flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
+	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
+	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
 		return -EOPNOTSUPP;
 
 	if (flow_type == IP_USER_FLOW) {
@@ -1435,6 +1437,19 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	rcu_read_unlock();
 
 	new_fltr->base.flags = BNXT_ACT_NO_AGING;
+	if (fs->flow_type & FLOW_RSS) {
+		struct bnxt_rss_ctx *rss_ctx;
+
+		new_fltr->base.fw_vnic_id = 0;
+		new_fltr->base.flags |= BNXT_ACT_RSS_CTX;
+		rss_ctx = bnxt_get_rss_ctx_from_index(bp, cmd->rss_context);
+		if (rss_ctx) {
+			new_fltr->base.fw_vnic_id = rss_ctx->index;
+		} else {
+			rc = -EINVAL;
+			goto ntuple_err;
+		}
+	}
 	if (fs->ring_cookie == RX_CLS_FLOW_DISC)
 		new_fltr->base.flags |= BNXT_ACT_DROP;
 	else
@@ -1476,12 +1491,12 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	     flow_type == IPV6_USER_FLOW) &&
 	    !(bp->fw_cap & BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO))
 		return -EOPNOTSUPP;
-	if (flow_type & (FLOW_MAC_EXT | FLOW_RSS))
+	if (flow_type & FLOW_MAC_EXT)
 		return -EINVAL;
 	flow_type &= ~FLOW_EXT;
 
 	if (fs->ring_cookie == RX_CLS_FLOW_DISC && flow_type != ETHER_FLOW)
-		return bnxt_add_ntuple_cls_rule(bp, fs);
+		return bnxt_add_ntuple_cls_rule(bp, cmd);
 
 	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
 	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
@@ -1495,7 +1510,7 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	if (flow_type == ETHER_FLOW)
 		rc = bnxt_add_l2_cls_rule(bp, fs);
 	else
-		rc = bnxt_add_ntuple_cls_rule(bp, fs);
+		rc = bnxt_add_ntuple_cls_rule(bp, cmd);
 	return rc;
 }
 
-- 
2.30.1


--00000000000032493e061483b62d
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJkJ1YMz5NRn1X01BHo/FN3Wv7ItJPIp
nF5bIBt1JOviMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjk1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAAnfA6zsfC0q7Ze2V8Bom/BgiBt0zLFIRNfO8KOOo4HOmzo7Tq
KmDy45Yjn7YW1BnQoazOui607tXSviHRfI3tV4mEDrkx/5vWXvhU8Chx7AFarGXkd2CLAPJKlXUa
Jqj5Ip4YeCdpNjIGi/hvOv+JSuzj4IWQ++0tA38/qFw0p4h20PEar4qt8El3wp401RMppac1YxD+
fS1VT5pdmGZg4OletMPm1RHnhJYP+uEdf3YE0tsX3fAufP8+1yljW8Qyu8m5PUwPWXiEYbXvPCsK
tU8ZgklKAPg4f0UROhIW+mZ39dSXPNGLRaXc9X1aercBUcnOU03nmulyVFGU9P7c
--00000000000032493e061483b62d--

