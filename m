Return-Path: <netdev+bounces-110736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918A92E090
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD69FB2104A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620812FB29;
	Thu, 11 Jul 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CBofupvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360212FF71
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681734; cv=none; b=AdleP71XwiSM2L9gXelCPai9DTBTdazlFbJVP+i9Dx5Nrm1iHKRRqIIyV0ZdS11hWi9S4w5SA75ObuFh8neksKYOhTc6SoEM8GJd/JSKiUp0OAMS9hSrNBTlPZPzYuGSv27AbD3R0uhrV7kAQnCImokQ0Wes6+OMb6S+k4wz1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681734; c=relaxed/simple;
	bh=lRJVMCOJV6C2BB1+59lQPrxBIFylkWwSVhJb5SRi6+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OE25RQ6vQiyIirZpPSllzn/aeFWyWmDh/y21jNqb/iwnnufpw/vya3rMbWvMh17mH5bnXm4YcgB82fUDWx8t5fdmyvy5T1JOwGkJOpxtw77TrJcA6xgOKIu53Dvc5lCer8785Xk+kV/anytYpsqwPQ0DGMZFL3v6zzny9+zTq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CBofupvq; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f48434d70cso258976e0c.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720681731; x=1721286531; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkaqHRPa8CP74K/DzZdBPq2E/lOLynVEe2WdM/aVYlE=;
        b=CBofupvqCzRMIVOy94f3xOAizrewOe7cAKqhPqVHcfbrWBS3x4pljnFlCHYhlIbrUr
         mGx2Wicx1HVVSnGTCuaVqeQFGWLN2QkEtCkaazhHY19N72pjne6WEF4vS5IGpQDPH+xn
         y5p6iKs1UbepxKP30gXN11g/Qp8KGAMfou/7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681731; x=1721286531;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkaqHRPa8CP74K/DzZdBPq2E/lOLynVEe2WdM/aVYlE=;
        b=tAOlVqbNGjgFZksWRWHiT9WOv7ZwHgBXO513R26n05B3H3mkZqgfWqIIWxsyc/LBVi
         kWeumpHQJ5+YyaHRyXHFAK7EFGNcIGD5G86vMOY5MmBGt8rIxmn3khQiqCdqARCUJbTr
         d6pFa41k+UfKgjEWK7yzhcNmukZYchvsVyC8yCd/FkNYf547R8KjrqEqjxlO7siI3sCV
         c/12p4CKjad+3zBSOBf3A6oNHITX1UwPTTW2+ws+Gtr4jNYUnmet5vNHMhPDCNYhgDti
         P4k27zAYUi7ScJxDUCQSLSJeLqdvJKWMIX8nxiIyI7vOFpYMv8/VlucE3FsX2uhIJQCz
         tUfA==
X-Gm-Message-State: AOJu0YzdKJplhi0U6rkPcQfIJUqMCDHM5SB0TB+zmqPTlV48F3dD3RpG
	mr/aqmlTuBov8vl3GbXlGwmHBh/PUdwPAsOgkxhYDMP7ZFZChx6smWubm3/VesG/iG+CBLNjS8m
	btPlbl/k2tcGou+h0OMftgXHukI0ka3G5Ub+ynJ1EPODxDMpHxG0HK/gCrcptWosDXp+Ov+b1MC
	ZuxuzkZJaJKmf+4b8TLc4pPIj3XQ21zTnFsSKycmM+C2pwy6Kk
X-Google-Smtp-Source: AGHT+IE9UF++qddERsrGeWMWFt+nq6Z/JG3DqG5FYfAkezvSZI9hR2ZGxfba+VYlZI20BdwVyf9a8w==
X-Received: by 2002:a05:6122:4682:b0:4ec:f4ea:6495 with SMTP id 71dfb90a1353d-4f33f31ca0cmr9582906e0c.11.1720681730789;
        Thu, 11 Jul 2024 00:08:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8d86asm23090006d6.125.2024.07.11.00.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:08:50 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Mina Almasry <almasrymina@google.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next 1/2] skb: skb_vlan_push gets VLAN_HLEN as an argument
Date: Thu, 11 Jul 2024 10:08:27 +0300
Message-Id: <20240711070828.2741351-2-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240711070828.2741351-1-boris.sukholitko@broadcom.com>
References: <20240711070828.2741351-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005e7a2e061cf36f1b"

--0000000000005e7a2e061cf36f1b
Content-Transfer-Encoding: 8bit

In case of vlan tagged packet, skb_vlan_push flushes current vlan header
into skb packet buffer. It also advances skb->mac_len by VLAN_HLEN
amount.

Some of the callers of skb_vlan_push (e.g. net/sched/act_vlan.c)
may want to reset skb network header by themselves.

To allow this we pass VLAN_HLEN as an argument to skb_vlan_push.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 include/linux/skbuff.h    | 2 +-
 net/core/filter.c         | 2 +-
 net/core/skbuff.c         | 4 ++--
 net/openvswitch/actions.c | 3 ++-
 net/sched/act_vlan.c      | 3 ++-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9c29bdd5596d..e13f44fe33df 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4046,7 +4046,7 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len);
 int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device *dev);
 int __skb_vlan_pop(struct sk_buff *skb, u16 *vlan_tci);
 int skb_vlan_pop(struct sk_buff *skb);
-int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci);
+int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci, u16 hlen);
 int skb_eth_pop(struct sk_buff *skb);
 int skb_eth_push(struct sk_buff *skb, const unsigned char *dst,
 		 const unsigned char *src);
diff --git a/net/core/filter.c b/net/core/filter.c
index d767880c276d..bb14574422b5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3187,7 +3187,7 @@ BPF_CALL_3(bpf_skb_vlan_push, struct sk_buff *, skb, __be16, vlan_proto,
 		vlan_proto = htons(ETH_P_8021Q);
 
 	bpf_push_mac_rcsum(skb);
-	ret = skb_vlan_push(skb, vlan_proto, vlan_tci);
+	ret = skb_vlan_push(skb, vlan_proto, vlan_tci, VLAN_HLEN);
 	bpf_pull_mac_rcsum(skb);
 
 	bpf_compute_data_pointers(skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..9c69c9bff55c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6223,7 +6223,7 @@ EXPORT_SYMBOL(skb_vlan_pop);
 /* Push a vlan tag either into hwaccel or into payload (if hwaccel tag present).
  * Expects skb->data at mac header.
  */
-int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
+int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci, u16 hlen)
 {
 	if (skb_vlan_tag_present(skb)) {
 		int offset = skb->data - skb_mac_header(skb);
@@ -6241,7 +6241,7 @@ int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
 			return err;
 
 		skb->protocol = skb->vlan_proto;
-		skb->mac_len += VLAN_HLEN;
+		skb->mac_len += hlen;
 
 		skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 	}
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 101f9a23792c..34909aca3526 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -244,7 +244,8 @@ static int push_vlan(struct sk_buff *skb, struct sw_flow_key *key,
 		key->eth.vlan.tpid = vlan->vlan_tpid;
 	}
 	return skb_vlan_push(skb, vlan->vlan_tpid,
-			     ntohs(vlan->vlan_tci) & ~VLAN_CFI_MASK);
+			     ntohs(vlan->vlan_tci) & ~VLAN_CFI_MASK,
+			     VLAN_HLEN);
 }
 
 /* 'src' is already properly masked. */
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 22f4b1e8ade9..f60cf7062572 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -50,7 +50,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		break;
 	case TCA_VLAN_ACT_PUSH:
 		err = skb_vlan_push(skb, p->tcfv_push_proto, p->tcfv_push_vid |
-				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT));
+				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT),
+				    VLAN_HLEN);
 		if (err)
 			goto drop;
 		break;
-- 
2.42.0


--0000000000005e7a2e061cf36f1b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDADJ2jIiOyGGK/8iRTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTU2MDBaFw0yNTA5MTAxMTU2MDBaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEJvcmlzIFN1a2hvbGl0a28xLDAqBgkqhkiG
9w0BCQEWHWJvcmlzLnN1a2hvbGl0a29AYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA1uKd0fo+YWpPYs389dpHW5vbrVQvwiWI4VGPHISUMVVVcCwrVXMcmoEi1AMN
t+KhIYltFzX7vj+SjHzSWLGrXUX/DW2tDJRYRXdc8+lVAu1wBO4WIhcYCMY8BDPfpxkMoY4w/qIa
1rC9tzBPzIGAdrBfdEzjjqblnqi+sIG7bakS6h7njOPNf9HuyLSQOs+Qq3kK8A8pX6t6KtAdq4iP
td/fua/xzT9yf7xQ0v0AVUPd9O3rahX4kX4sHlUcEVb6eXSNRwdyirUgDaJkDPrhIPKFapov5OeK
9BR0SGqf9JnBbAcQrigtBfEwkeDY+dJprju7HLWVNFkaW9u8vvvbiwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1ib3Jpcy5zdWtob2xpdGtvQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUB46dIlYd
tkC0osZXFEatb5Hu+C8wDQYJKoZIhvcNAQELBQADggEBAE/WXEAo/TOHDort0zhfb2Vu7BdK2MHO
7LVlNc5DtQqFW4S0EA+f5oxpwsTHSzqf5FVY3S3TeMGTGssz2y/nGWwznbP+ti0SmO13EYKODFao
6fOqaW6dPraTx2lXgvMYXn/VZ+bxpnyKcFwC4qVssadK6ezPvrCVszHmO7MNvpH2vsfE5ulVdzbU
zPffqO2QS6e4oXzmoYuX9sCNfol1TaQgCYgYoC4rexOBLLtYbwdKWi3/ttntZ2PHS1QRaDzrBSuw
L39zqstTC0LC/YoSKC/cU9igMELugG/Twy9uVlg2XXTY1wUYSWMsYlpydsrVyG18UScp7FlGFbWX
EWKS7pkxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwA
ydoyIjshhiv/IkUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMGWvUln2yPPHV3W
fu01LKUcb0x628eYNdxwX0cXoiiYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDcxMTA3MDg1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZjJCIOvrfyh+3hnxVPrTEOfe1jbBp1WRN
sxiIS16UsoIeDgkj6L36ulr4mJQcuJfiPt42zcGJkPEXBFtbwFCVYANNH49fq3ZvrOTs/3QROZYs
nCMQ5zWOeYJGDt6gVEfAb5gPGG5xawK9dzIt0F69Qf7vo//z4UulgEyFFl6xXG8FC65WOtQB7cQZ
BZksAPcIU7VlOMzYEv4BOcUvlFcUADMgGNwMdfRRebe5wf2cd7G5oVeFD9hh5XSeO0MrTU3qTaEm
6Kb7TKwCBf2D0KJKJicEAKPowttnKI9KhjWMVlG3BFcoJen77Z1KwZGd9TOcOdIKazmpQ4Ch9voY
LXJS
--0000000000005e7a2e061cf36f1b--

