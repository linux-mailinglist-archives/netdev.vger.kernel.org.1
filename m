Return-Path: <netdev+bounces-81832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619788B41D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B171C2B91D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38983A0C;
	Mon, 25 Mar 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MOeEz+wf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84785823B5
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405780; cv=none; b=JmjCtgKYKAixFa0udg2ajlzUkenXT9vAa8/htgl02CUM98LGKHY+bPL/CXf9cJVTWoUUHD7YgbRRCD6jCNDkOV7L5Qk1WYlmpzwmMVUgBbQG6y25s12AGP5pUrJTTknrNhzpRvpFBoVjLYUaXhCKtrlQS1NcGxeVJ0KepZse3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405780; c=relaxed/simple;
	bh=hLBBJFTqPTsXFBRVfn8Hx4y5tv6bg4Z5YAiRJroIJ4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzIKJaAA+T1ckiBl657FY/f2yIXxaHf03f45X22kkq6+oAPlWqtG5S1PkKjvTtfT+GBXc1U6Ux9Q5xUl5+j1HXkx4ofwpdbm7qCe9JTCIKKHdqu2LpwwxTrCQFL7j1VAg0/gxYFKw2ZAyWkIQn4GRyO4RAl0GkmLGlKZKqOmD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MOeEz+wf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c3915a7afaso3166371b6e.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405777; x=1712010577; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9K3D/iMsEPLjmnJRU/TDVnGD3kmnn2dDmy/1tIXIjPs=;
        b=MOeEz+wfHLTH9kkySfLceWNkws3MPsxJ6rG9NEtPM3KLBhWVeQTyYdRCHOxadDcPGK
         JMBdXmKpAwYmmu9Ogz9tKRwi4kGTI63A4a/bMQ/heIpeSwcnk6leiWOsTq5Vq4NkILIg
         n3qtlyN0C4Ry1205Mj/Z4/532pWVMek9ynLbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405777; x=1712010577;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9K3D/iMsEPLjmnJRU/TDVnGD3kmnn2dDmy/1tIXIjPs=;
        b=I0Uq3daptoLTRL3Dq1dgakSM84I+jNCB8lhuhyYPVYbKkV0Blelcq7KIyIrWupjw1a
         5DH0Cg7zG+l4DqfQ8M1ljqq011hNH9T6lS5ZV++9ICGAPPN1ayoGKKIXDzLDwtqRLSIl
         5rpBvYHUnilLhZvzn4YAnWhSj38hqjbYr9C7LXjhoVE61AMuEAGp0L8ILpa05q8/rsJV
         Z53wDNGEWur/oBo8dnr1KMtVeCSHhXsV1czWi+B6G8NQKc5LSUeDNgd8FtJfNrBCA57N
         f8skSxKDJ+JMHgTBNlGRLHqAi1oYLkJMQZM9Fak3pmioqZFLYovPq6lrJ1vnB0P9Rcpo
         wWWQ==
X-Gm-Message-State: AOJu0YyrNUUd8zF7vaU6VCxSGsww2Z7kV5mx9/bFPqRsQzsrJ3DLhzL7
	WTGZWGpW5Q1ElTIJk8THjBooVCLSRw4TC9jpNTlr9gxQY0p/x03KVPpQQAv1Jw==
X-Google-Smtp-Source: AGHT+IEhxUMnna4dqF8ECTbUtA3utEmJFzXhOtGDlV1ifyP2rbhGKJvNThZ5UUFsamrEC7XizdItfA==
X-Received: by 2002:a05:6830:1681:b0:6e6:baca:a0fd with SMTP id k1-20020a056830168100b006e6bacaa0fdmr9141347otr.0.1711405777240;
        Mon, 25 Mar 2024 15:29:37 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:36 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 05/12] bnxt_en: Introduce rss ctx structure, alloc/free functions
Date: Mon, 25 Mar 2024 15:28:55 -0700
Message-Id: <20240325222902.220712-6-michael.chan@broadcom.com>
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
	boundary="00000000000074b715061483b577"

--00000000000074b715061483b577
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add struct bnxt_rss_ctx, related storage lists, required
defines, and its alloc/free functions.

Later patches will use them in order to support multiple
RSS contexts.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 54 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 24 +++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +
 3 files changed, 80 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3f5d7c81a281..0ede267904ad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9925,6 +9925,53 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 	return rc;
 }
 
+void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
+			  bool all)
+{
+	if (!all)
+		return;
+
+	list_del(&rss_ctx->list);
+	bp->num_rss_ctx--;
+	clear_bit(rss_ctx->index, bp->rss_ctx_bmap);
+	kfree(rss_ctx);
+}
+
+struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp)
+{
+	struct bnxt_rss_ctx *rss_ctx = NULL;
+
+	rss_ctx = kzalloc(sizeof(*rss_ctx), GFP_KERNEL);
+	if (rss_ctx) {
+		rss_ctx->vnic.rss_ctx = rss_ctx;
+		list_add_tail(&rss_ctx->list, &bp->rss_ctx_list);
+		bp->num_rss_ctx++;
+	}
+	return rss_ctx;
+}
+
+void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all)
+{
+	struct bnxt_rss_ctx *rss_ctx, *tmp;
+
+	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
+		bnxt_del_one_rss_ctx(bp, rss_ctx, all);
+
+	if (all)
+		bitmap_free(bp->rss_ctx_bmap);
+}
+
+static void bnxt_init_multi_rss_ctx(struct bnxt *bp)
+{
+	bp->rss_ctx_bmap = bitmap_zalloc(BNXT_RSS_CTX_BMAP_LEN, GFP_KERNEL);
+	if (bp->rss_ctx_bmap) {
+		/* burn index 0 since we cannot have context 0 */
+		__set_bit(0, bp->rss_ctx_bmap);
+		INIT_LIST_HEAD(&bp->rss_ctx_list);
+		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+	}
+}
+
 /* Allow PF, trusted VFs and VFs with default VLAN to be in promiscuous mode */
 static bool bnxt_promisc_ok(struct bnxt *bp)
 {
@@ -14612,6 +14659,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	unregister_netdev(dev);
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
+	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
+		bnxt_clear_rss_ctxs(bp, true);
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	/* Flush any pending tasks */
 	cancel_work_sync(&bp->sp_task);
@@ -15223,6 +15272,9 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+		bnxt_init_multi_rss_ctx(bp);
+
 	rc = register_netdev(dev);
 	if (rc)
 		goto init_err_cleanup;
@@ -15243,6 +15295,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_clear_int_mode(bp);
 
 init_err_pci_clean:
+	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
+		bnxt_clear_rss_ctxs(bp, true);
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	bnxt_free_hwrm_resources(bp);
 	bnxt_hwmon_uninit(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 81460a96c0dd..4d3104c26cfa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1256,9 +1256,21 @@ struct bnxt_vnic_info {
 #define BNXT_VNIC_UCAST_FLAG	8
 #define BNXT_VNIC_RFS_NEW_RSS_FLAG	0x10
 #define BNXT_VNIC_NTUPLE_FLAG		0x20
+#define BNXT_VNIC_RSSCTX_FLAG		0x40
+	struct bnxt_rss_ctx	*rss_ctx;
 	u32		vnic_id;
 };
 
+struct bnxt_rss_ctx {
+	struct list_head list;
+	struct bnxt_vnic_info vnic;
+	u16	*rss_indir_tbl;
+	u8	index;
+};
+
+#define BNXT_MAX_ETH_RSS_CTX	32
+#define BNXT_RSS_CTX_BMAP_LEN	(BNXT_MAX_ETH_RSS_CTX + 1)
+
 struct bnxt_hw_rings {
 	int tx;
 	int rx;
@@ -2228,6 +2240,9 @@ struct bnxt {
 	/* grp_info indexed by completion ring index */
 	struct bnxt_ring_grp_info	*grp_info;
 	struct bnxt_vnic_info	*vnic_info;
+	struct list_head	rss_ctx_list;
+	unsigned long		*rss_ctx_bmap;
+	u32			num_rss_ctx;
 	int			nr_vnics;
 	u16			*rss_indir_tbl;
 	u16			rss_indir_tbl_entries;
@@ -2242,6 +2257,7 @@ struct bnxt {
 #define BNXT_RSS_CAP_AH_V6_RSS_CAP		BIT(5)
 #define BNXT_RSS_CAP_ESP_V4_RSS_CAP		BIT(6)
 #define BNXT_RSS_CAP_ESP_V6_RSS_CAP		BIT(7)
+#define BNXT_RSS_CAP_MULTI_RSS_CTX		BIT(8)
 
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
@@ -2341,6 +2357,10 @@ struct bnxt {
 #define BNXT_SUPPORTS_NTUPLE_VNIC(bp)	\
 	(BNXT_PF(bp) && ((bp)->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3))
 
+#define BNXT_SUPPORTS_MULTI_RSS_CTX(bp)				\
+	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
+	 ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
+
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
 	u16                     hwrm_cmd_kong_seq;
@@ -2723,6 +2743,10 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_fw_set_time(struct bnxt *);
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
+void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
+			  bool all);
+struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp);
+void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1d240a27455a..771833b1900d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -969,6 +969,8 @@ static int bnxt_set_channels(struct net_device *dev,
 	}
 
 	bnxt_clear_usr_fltrs(bp, true);
+	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
+		bnxt_clear_rss_ctxs(bp, false);
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
-- 
2.30.1


--00000000000074b715061483b577
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJWgxNy/tUwVW5+vNV8ILoejY+EdN6DK
NlqQCI/FLBEgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjkzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBQPWdCq07A2gYkSOj3jwXjEF+hV6v530qnJGTWzlzGWts3+Wvt
wh9Y5iu+3UP7+34SdqMre6/TDbQuzZU6Vgb4z5QfsUZcNvTQTwZ6ctzM1IqErQ+vVKMl6eKl/MRh
SMFtq/39O2ye4RA3f6nzr37aFhQm1G7UlX1Ob6AN9kud0Acl1rDZQ1urKwqYscVh6XjhiTO6Z5id
FpHTAu5Vl0O73MvkN9eUVk1Z6GPW9/kdrwsET0+AZM8nodZAYxomDtoYG3SeDGSSkO35pmB3q5KT
DgdEziZQdToW6TkZPxvDfqhHCzl0tOR6Xo0IG3h/Us9wFtUWA6Nc6Doj0f8Z1nxr
--00000000000074b715061483b577--

