Return-Path: <netdev+bounces-53125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635BF8016A3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA81C20B34
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26094619DE;
	Fri,  1 Dec 2023 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X3WluVq7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB752AD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:59 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b837d974ecso751485b6e.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470399; x=1702075199; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yiwMsA8+UUMeDOCdekRJ3Fxueivu0rDI11CiMc87iw=;
        b=X3WluVq7LmgsIxxFSwWOdVnUht7UhGS5KjB8Vw0TnUqPf7a2tn2lXnminHFsON9wF8
         jw+ccz4dLAJaU8EN6yaW6yN14SQjHU4QfbNMQl5GrSP0xSILQZdl6lBVFLwGrVjWiMre
         4vTR/TrOjZSCrQOzkhTEBq1uiAPEfbv3ccivE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470399; x=1702075199;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yiwMsA8+UUMeDOCdekRJ3Fxueivu0rDI11CiMc87iw=;
        b=RJMWhYupP/U+NZkiJ2taZpO1rdlKCiPrnCbRj0xeHTHwz0/DMWss5AVhAglfZvz/5g
         BbF9gUMK8UlQ3cFLsZRRzJpCg9yeZrJ1WodrGuHkLB35f0cnlS1dHeg1qOFoX6NAPUaY
         pu3Sf3w+X27HReGUVC8Q/VMql/lOSDF5X20Y31kH3FWC4JZFJhHnaKQ78/qA21HXQ2H3
         vEkRqsvuDN3g0zZCs/8u92qhopzNxysve4C4NfYYtvYkJ5KU1Ea9BdGf8FT0HhYV/Mzr
         /enlbdZi4g5VPS19PCnQlqlNwHuvEMprCQR70if0PRAZoKVDdeZs5BKaZNtP3tu7VTPM
         ImWQ==
X-Gm-Message-State: AOJu0Yx6qhWOLRvyQyKhQy0ZQ13iuiJ74R1uKO4Bvyc4g+DxSmD1F3Ec
	8hMc6IDyIJu0l71B1+l+Jj6s/w==
X-Google-Smtp-Source: AGHT+IHme3sfXC3bk1JsNMYxLxymJ1StnwS0wjw+SrzguU/xV+UZuHlM9gxtPm4fLLUdFrFoukFc3g==
X-Received: by 2002:a05:6808:14c6:b0:3b8:b063:adf1 with SMTP id f6-20020a05680814c600b003b8b063adf1mr319848oiw.78.1701470399116;
        Fri, 01 Dec 2023 14:39:59 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:58 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 08/15] bnxt_en: Refactor RX VLAN acceleration logic.
Date: Fri,  1 Dec 2023 14:39:17 -0800
Message-Id: <20231201223924.26955-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c1edd6060b7a72f7"

--000000000000c1edd6060b7a72f7
Content-Transfer-Encoding: 8bit

Refactor the logic in the RX path that checks for the accelerated VLAN
tag by adding a new function.  This will make it easier to support
the new receive logic on P7 chips.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 ++++++++++++++++-------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b38c17a27903..9aca38b6f196 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1783,6 +1783,34 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 	napi_gro_receive(&bnapi->napi, skb);
 }
 
+static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
+				    struct rx_cmp *rxcmp,
+				    struct rx_cmp_ext *rxcmp1)
+{
+	__be16 vlan_proto;
+	u16 vtag;
+
+	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
+		__le32 flags2 = rxcmp1->rx_cmp_flags2;
+		u32 meta_data;
+
+		if (!(flags2 & cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN)))
+			return skb;
+
+		meta_data = le32_to_cpu(rxcmp1->rx_cmp_meta_data);
+		vtag = meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
+		vlan_proto = htons(meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SFT);
+		if (eth_type_vlan(vlan_proto))
+			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+		else
+			goto vlan_err;
+	}
+	return skb;
+vlan_err:
+	dev_kfree_skb(skb);
+	return NULL;
+}
+
 /* returns the following:
  * 1       - 1 packet successfully received
  * 0       - successful TPA_START, packet not completed yet
@@ -2001,20 +2029,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	cfa_code = RX_CMP_CFA_CODE(rxcmp1);
 	skb->protocol = eth_type_trans(skb, bnxt_get_pkt_dev(bp, cfa_code));
 
-	if ((rxcmp1->rx_cmp_flags2 &
-	     cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN)) &&
-	    (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX)) {
-		u32 meta_data = le32_to_cpu(rxcmp1->rx_cmp_meta_data);
-		u16 vtag = meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
-		__be16 vlan_proto = htons(meta_data >>
-					  RX_CMP_FLAGS2_METADATA_TPID_SFT);
-
-		if (eth_type_vlan(vlan_proto)) {
-			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
-		} else {
-			dev_kfree_skb(skb);
+	if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
+		skb = bnxt_rx_vlan(skb, cmp_type, rxcmp, rxcmp1);
+		if (!skb)
 			goto next_rx;
-		}
 	}
 
 	skb_checksum_none_assert(skb);
-- 
2.30.1


--000000000000c1edd6060b7a72f7
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOMrpj2NANfRM578qVJkDV3YLfe2aiud
EAAPhAX0UiJSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA6tx9/EAFX1jONkXKqdzyFdscaFaqJZeYruX7MNYkrSmiIdy8D
5af7I54CwM8c7NJQyK7fpKggZvTk6jkdLtSWC/u1YhSdZV+H3vyF/qQb9U7lXIqpgsHVWIkuuoMX
9qJrURD5unrkxuJP93gP6gpN8ikxrUzDK7xeGFUTBaYaxG0pFUdHhS9h/hNMwahNXuKDd2uV7aT7
KeTH8EzxafJylnvpIwEvo55BOwy9O7QdZLtKScj/oShx8sKOYUKvwywuZy3Qlk/Nv6pexliDAP//
wPXgPE1tnZ52SUk5RAe1y+QyZb58wglnXVlkvrxHobh749f81JOQa6ex0b4/k+59
--000000000000c1edd6060b7a72f7--

