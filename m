Return-Path: <netdev+bounces-87509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A338A3575
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D109B1F245A6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4314E2FE;
	Fri, 12 Apr 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SOGOCTZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEC14D70E
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945800; cv=none; b=t9wwek9RfRZxjRjjQebu3V4HlXwN1yvW0HzLXMvZzTAO9ikRDvsnhc/e7f2NDN3Ie6ZOhZwXFGqKHUliMmDROcHae5TTdc27GnIbXNlWPwqIV46y0Xm6EhAz6fC0On9H8/YZ1FzQxdRUk9GL9kAjtT42iM2VnX/qWm9WJ/vIRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945800; c=relaxed/simple;
	bh=SVNaYR3dzHXVQV/G5Ed7sNUY5mYXdizIlHKqrkijVbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UJ2xBcuINUl/L0B75LP4KToT8HBggDEau5FvOlp6jVTh03fEW576CyVk9U2bMoD8TSUhEcXS0745NkSiExf+VnyUuQWj03h43M/2zf+fs36+2pHMOxgUblP+1qyYuDoyIdc79B5D7N1igUkkvqX7jxBhL7OtN5wRLdtIuFZ15dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SOGOCTZb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6962e6fbf60so9207466d6.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712945797; x=1713550597; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e6Yqh55BDJbEAhV39C84P1rDmlh9typ31HrHe4uFSK4=;
        b=SOGOCTZbra8tu2jbYjVwmWV9QJhDWPJ7MzO5Zx6VZESLwyB0mi/F1CVjxNsD3k2MGh
         Zms18SPKJACYoskBAmJoZvEuaWyLKzgkJrPPiJ7ZiNYzUczD6K9Kbspw7+a8agsxhjOP
         OIQup753C7gltVnAgKMUe9pO9HAWqEgxySjAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945797; x=1713550597;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6Yqh55BDJbEAhV39C84P1rDmlh9typ31HrHe4uFSK4=;
        b=ns1tBB8s/4EG9Rg+9icubLA3VdvOgno/mzcrOe4aEXM5l48TNyxIvwkJVFQ90vvZ3F
         hVSCec47lQTJjG4cRNLOFNTq7VJygFuWyHIJnOwhZMa+O3bgPN+qyMkhijaldnztNISU
         isKf2Yc9Ixr85hGodpdnvN9MOq0oljbruVC+mBW1V2imCNwuISiP0vQ3ntw8vLmVFYXu
         lkRCCgRjqIJ0T3tjDsjpQEhzM0jQT6CMaekc2106svpHXTO1u1uyZEMSMWranLpxYQWh
         DH+ibdPJC7enyGGOxej6tUr20i302FvOjwWPJVQyLav96YV5cqA421A8R18H/ENjRlob
         kmxw==
X-Gm-Message-State: AOJu0YzyMNImCZXKbwvv/QOrKUagp+Qgfx04emk1z9o/tKte5MU0ufM8
	xrTITUcWz6iXtg81GUVSu2ugTn3hSel/uhPmhOMVpdJmQVwY28kg8zO6tnPmtzcpB926L3WL39P
	08BIqOlsMQ3hvtDjEhRdY3FO7TmpRB51lHgIn2k2PdeSffqmlrydcNETsEMgEnv+zYfLiTa0lZT
	wcgP9hkmrRiG+eHBWOTPuBld6u23H8ngu1/XrI/jU=
X-Google-Smtp-Source: AGHT+IEgB2Sddo3XpH1ARQCO/FiveNZkextRNMmMjprfWcjVubFk4cJtu4MxV1xx7FhHl8hVs7rqWw==
X-Received: by 2002:a05:6214:888:b0:690:d000:c819 with SMTP id cz8-20020a056214088800b00690d000c819mr3916384qvb.60.1712945797275;
        Fri, 12 Apr 2024 11:16:37 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id eb18-20020ad44e52000000b0069b57c83f32sm1174202qvb.26.2024.04.12.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:16:36 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bcmasp: fix memory leak when bringing down if
Date: Fri, 12 Apr 2024 11:16:31 -0700
Message-Id: <20240412181631.3488324-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ca16fd0615ea457e"

--000000000000ca16fd0615ea457e
Content-Transfer-Encoding: 8bit

When bringing down the TX rings we flush the rings but forget to
reclaimed the flushed packets. This lead to a memory leak since we
do not free the dma mapped buffers. This also leads to tx control
block corruption when bringing down the interface for power
management.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 72ea97c5d5d4..82768b0e9026 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -436,10 +436,8 @@ static void umac_init(struct bcmasp_intf *intf)
 	umac_wl(intf, 0x800, UMC_RX_MAX_PKT_SZ);
 }
 
-static int bcmasp_tx_poll(struct napi_struct *napi, int budget)
+static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 {
-	struct bcmasp_intf *intf =
-		container_of(napi, struct bcmasp_intf, tx_napi);
 	struct bcmasp_intf_stats64 *stats = &intf->stats64;
 	struct device *kdev = &intf->parent->pdev->dev;
 	unsigned long read, released = 0;
@@ -482,10 +480,16 @@ static int bcmasp_tx_poll(struct napi_struct *napi, int budget)
 							DESC_RING_COUNT);
 	}
 
-	/* Ensure all descriptors have been written to DRAM for the hardware
-	 * to see updated contents.
-	 */
-	wmb();
+	return released;
+}
+
+static int bcmasp_tx_poll(struct napi_struct *napi, int budget)
+{
+	struct bcmasp_intf *intf =
+		container_of(napi, struct bcmasp_intf, tx_napi);
+	int released = 0;
+
+	released = bcmasp_tx_reclaim(intf);
 
 	napi_complete(&intf->tx_napi);
 
@@ -797,6 +801,7 @@ static void bcmasp_init_tx(struct bcmasp_intf *intf)
 	intf->tx_spb_dma_read = intf->tx_spb_dma_addr;
 	intf->tx_spb_index = 0;
 	intf->tx_spb_clean_index = 0;
+	memset(intf->tx_cbs, 0, sizeof(struct bcmasp_tx_cb) * DESC_RING_COUNT);
 
 	/* Make sure channels are disabled */
 	tx_spb_ctrl_wl(intf, 0x0, TX_SPB_CTRL_ENABLE);
@@ -885,6 +890,8 @@ static void bcmasp_netif_deinit(struct net_device *dev)
 	} while (timeout-- > 0);
 	tx_spb_dma_wl(intf, 0x0, TX_SPB_DMA_FIFO_CTRL);
 
+	bcmasp_tx_reclaim(intf);
+
 	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
 
 	phy_stop(dev->phydev);
-- 
2.34.1


--000000000000ca16fd0615ea457e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH+a5PBC5AccxPEEiyNJfu+UzkZX2gDkA1ow
vaRpTLBxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxMjE4
MTYzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAEbu3pheAD0YOupJaJo0dwGXTs7szdNH7vSDbYrfHG7mMSXEemk9Ed
rj+EplxYvmEIyya/qUFNwrKgN9o7AoxLtKVa6pOhv+U1YVmrOeyvd9gnLrgGVZ6uWbVopROVHKSs
6jb1dbCdZblu02ODmYPkN9g3Nm2Rjb7cjd5DYjPem74M0HICpgKIfpaUilSyKKdTFupb28j+vG8D
Xniu+1VqnGqiT3E0U4DE+0X4ZE5BSqawhbxA1JeF6UOfeS06hfO05XDtMg3FJNzIrTRtysRDaEmo
K69IgJ+9Bs5v/U8OcIQgzjQdHLe4Cv0tNHhrIxeXkCNjWW5yRA4la9sRGAVl
--000000000000ca16fd0615ea457e--

