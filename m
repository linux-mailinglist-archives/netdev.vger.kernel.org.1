Return-Path: <netdev+bounces-56166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34280E080
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B456FB21310
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36161639;
	Tue, 12 Dec 2023 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JOPrcZf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62726A6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:51:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-42589694492so39940871cf.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702342315; x=1702947115; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SERu6RxsbEVFhDOFKQ6k8RPmhIGpfdfq8Cwt3oIkPZA=;
        b=JOPrcZf04h97MCxeNwNR1W2FdQYxI3yVDPzt+ittKMRYB94AWzF0DTbTZO9BH4iK/U
         W84xsIOcBtVjUzvKuA/uyXvGVreeQfPGHoQ4boByETNEQ7QWDf16mCstzDTKD8fxz/sm
         xTVIhuN+dBSmuOXQOlmwSejlofSa+wZcxuxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342315; x=1702947115;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SERu6RxsbEVFhDOFKQ6k8RPmhIGpfdfq8Cwt3oIkPZA=;
        b=YKEDm9zhtzXoo4/IjPHvnhsR8HVe9hI4e5ksNAq3iFHavXm8wqmU34QlKwLTvW9v1E
         zT+Y/Ef0jSXZlTleMPjV6PuQyJOLsTI+ohOZstjTcBbFd4xYgelrTY8JER+29fGMNXpd
         kx850nKKWDVe8a5M0BOTBXUQ2/PHtBkKXDq7t6GT6y3YfkEw5VG1xCELRCdmIlG99JXm
         +NuZgGLNS7whAa3FCD0aGjp9ylGvm7JTGaCrungCMOFl+lpyOOUQj0Roum2+h9yPPUR3
         sNhMzVVVCWx2tqT6Dea0ogQqK/Ulfvsuz+GDAyDbrqju90oMgqL1Yazql70Axu1XdHxP
         U/sQ==
X-Gm-Message-State: AOJu0YyGA7uKIuCPCisjigLJUJ529/W+Izj2W7+YBTeiuOV8qX5EUzwZ
	DfFVnn/TTAA6v5M4vtFG0vAWYg==
X-Google-Smtp-Source: AGHT+IEqPcbY+X0FJiv+y/ozmmAGv2ksTG9MUqyI7eWQAfKu/fIRmigU9iVvxUsWBanTrassEHPGPQ==
X-Received: by 2002:ac8:7f0c:0:b0:425:4043:5f0e with SMTP id f12-20020ac87f0c000000b0042540435f0emr6682465qtk.76.1702342315375;
        Mon, 11 Dec 2023 16:51:55 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b00423ea1b31b3sm3619664qtt.66.2023.12.11.16.51.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2023 16:51:54 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 08/13] bnxt_en: Add support for VXLAN GPE
Date: Mon, 11 Dec 2023 16:51:17 -0800
Message-Id: <20231212005122.2401-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231212005122.2401-1-michael.chan@broadcom.com>
References: <20231212005122.2401-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000004ee11060c45753c"

--00000000000004ee11060c45753c
Content-Transfer-Encoding: 8bit

Add a new bnxt_udp_tunnels_p7 struct to support the new P7 chips that
can parse VXLAN GPE packets.  Add VXLAN GPE tunnel type handling to
the .set_port() and .unset_port() functions.  .ndo_features_check()
is also enhanced to support VXLAN GPE which may encapsulate inner
IP packets instead of ethernet packets.

Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 43 ++++++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f2e8904de97f..b9eb3e0c5995 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5179,6 +5179,11 @@ static int bnxt_hwrm_tunnel_dst_port_free(struct bnxt *bp, u8 tunnel_type)
 		bp->nge_port = 0;
 		bp->nge_fw_dst_port_id = INVALID_HW_RING_ID;
 		break;
+	case TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE:
+		req->tunnel_dst_port_id = cpu_to_le16(bp->vxlan_gpe_fw_dst_port_id);
+		bp->vxlan_gpe_port = 0;
+		bp->vxlan_gpe_fw_dst_port_id = INVALID_HW_RING_ID;
+		break;
 	default:
 		break;
 	}
@@ -5222,6 +5227,11 @@ static int bnxt_hwrm_tunnel_dst_port_alloc(struct bnxt *bp, __be16 port,
 		bp->nge_port = port;
 		bp->nge_fw_dst_port_id = le16_to_cpu(resp->tunnel_dst_port_id);
 		break;
+	case TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE:
+		bp->vxlan_gpe_port = port;
+		bp->vxlan_gpe_fw_dst_port_id =
+			le16_to_cpu(resp->tunnel_dst_port_id);
+		break;
 	default:
 		break;
 	}
@@ -12002,9 +12012,10 @@ static bool bnxt_udp_tunl_check(struct bnxt *bp, struct sk_buff *skb)
 	struct udphdr *uh = udp_hdr(skb);
 	__be16 udp_port = uh->dest;
 
-	if (udp_port != bp->vxlan_port && udp_port != bp->nge_port)
+	if (udp_port != bp->vxlan_port && udp_port != bp->nge_port &&
+	    udp_port != bp->vxlan_gpe_port)
 		return false;
-	if (skb->inner_protocol_type == ENCAP_TYPE_ETHER) {
+	if (skb->inner_protocol == htons(ETH_P_TEB)) {
 		struct ethhdr *eh = inner_eth_hdr(skb);
 
 		switch (eh->h_proto) {
@@ -12015,6 +12026,11 @@ static bool bnxt_udp_tunl_check(struct bnxt *bp, struct sk_buff *skb)
 						 skb_inner_network_offset(skb),
 						 NULL);
 		}
+	} else if (skb->inner_protocol == htons(ETH_P_IP)) {
+		return true;
+	} else if (skb->inner_protocol == htons(ETH_P_IPV6)) {
+		return bnxt_exthdr_check(bp, skb, skb_inner_network_offset(skb),
+					 NULL);
 	}
 	return false;
 }
@@ -13674,8 +13690,10 @@ static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned int tabl
 
 	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
 		cmd = TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN;
-	else
+	else if (ti->type == UDP_TUNNEL_TYPE_GENEVE)
 		cmd = TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GENEVE;
+	else
+		cmd = TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE;
 
 	return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti->port, cmd);
 }
@@ -13688,8 +13706,10 @@ static int bnxt_udp_tunnel_unset_port(struct net_device *netdev, unsigned int ta
 
 	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
-	else
+	else if (ti->type == UDP_TUNNEL_TYPE_GENEVE)
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
+	else
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE;
 
 	return bnxt_hwrm_tunnel_dst_port_free(bp, cmd);
 }
@@ -13703,6 +13723,16 @@ static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
 	},
+}, bnxt_udp_tunnels_p7 = {
+	.set_port	= bnxt_udp_tunnel_set_port,
+	.unset_port	= bnxt_udp_tunnel_unset_port,
+	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
+			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
+	.tables		= {
+		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
+		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
+		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN_GPE, },
+	},
 };
 
 static int bnxt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
@@ -14298,7 +14328,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
 			NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			NETIF_F_GSO_IPXIP4 | NETIF_F_GSO_PARTIAL;
-	dev->udp_tunnel_nic_info = &bnxt_udp_tunnels;
+	if (bp->flags & BNXT_FLAG_CHIP_P7)
+		dev->udp_tunnel_nic_info = &bnxt_udp_tunnels_p7;
+	else
+		dev->udp_tunnel_nic_info = &bnxt_udp_tunnels;
 
 	dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM |
 				    NETIF_F_GSO_GRE_CSUM;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 67915ab13f50..609f4073f5ff 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2284,8 +2284,10 @@ struct bnxt {
 
 	u16			vxlan_fw_dst_port_id;
 	u16			nge_fw_dst_port_id;
+	u16			vxlan_gpe_fw_dst_port_id;
 	__be16			vxlan_port;
 	__be16			nge_port;
+	__be16			vxlan_gpe_port;
 	u8			port_partition_type;
 	u8			port_count;
 	u16			br_mode;
-- 
2.30.1


--00000000000004ee11060c45753c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILXSXQuonlTaLJFRwQ1srbNFevPyapfG
tqumO5Pmt00wMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIx
MjAwNTE1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQClLEnvrC5k8DW6hi/LTdZnX1C36pGu1E2RAB9uZunf6jQewtkm
dOBCoa0Bh7vDQKzL3ii9zT5WLc2B/9aADmlB+SiP9iWJp01Ktgvcv6R8s1lvEztpsupya29vg2qf
HQwgbhfvhlM/hpZ8NmmZD8PcYQ+ljDD3b56SXvVtea0EeHQDuNvRJykKbKQw63YNjky+il9jjwmn
66E3PI3IwsGBsTgX5Wm8SI9Bask9TQBB2fNeP1aR+HVtedGSD3bYSiHwF7Qj0raEbooI6cdiHYhA
g1SFlCOFYywH4ZRHtEaORCeKxCj6eBZUwO5kkms+tSk38nnAhY3Lt+EfFcGCbZyD
--00000000000004ee11060c45753c--

