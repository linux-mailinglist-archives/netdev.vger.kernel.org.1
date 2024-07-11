Return-Path: <netdev+bounces-110737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553892E091
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EBC281DED
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03412FB29;
	Thu, 11 Jul 2024 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hkGYUVBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AE12EBE3
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681740; cv=none; b=IgF3hoa1ZfNFmI+mNB7hGfIAjP8kN6DDFfBWpHMCNTevKXfduRzdwpx/w20pnd5+zy/Yb8d2h+CjBRAJ3/jzXOeufJriRSt2DpaWDCkuRoCDRBzNI3R5D9aB9fy/wNrP7TIOCslXZexrlKqRTGsZwkpvBr6gO3czzmvxXcfPqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681740; c=relaxed/simple;
	bh=XwEGmZToecg9xaCcceekHtX1376JIYfrBI0ooxsZv4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvwkeDKvpZMnctxYMq1mUIegRNw/t7OiVT8a54nlMseHjk3lBTxqnFzzjsy+6qfjVt9gy2LBAAC0CTkFbiVBuuQxKNIDGM0qMxTA+fgUkrBiyOJA326u7vk3GZaeb+TzbHN2w4hS/jkBuaDEunhC9iEHfHoB4A7NTh5LyFrvxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hkGYUVBt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b5eb69e04cso3458596d6.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720681737; x=1721286537; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Duv0Ov175boKFl/FzQMFuZ//R05ouVIrxMGUwrIPH8c=;
        b=hkGYUVBthtVccu9WAOIenVteCXdPHtpg+Nptsph5NUQNC/kvHH7zUfkzwrwtVb0uht
         jgDLmiFSIDGQfeQa7e/4Cu0MoZfzPGJ9aysFeHVtn4wijOs+Jfpa/H3W1lasIZ9AaO8j
         WEC8mPi5+UCg436ejqALXeuvwxitDiWLGymK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681737; x=1721286537;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Duv0Ov175boKFl/FzQMFuZ//R05ouVIrxMGUwrIPH8c=;
        b=SYpn1XWOMvHUC+lfU9tT4hpuoZWt2VRdkQ8oljGVvY0jhXqssV+1oOKOzwl1RYMw5E
         Gchb37oVdMlZL8GvrNn03NfvjhMroBrZVwxhbCQ+KHgYHlaa6rKQfuf8AATWzq2+0sMY
         n1dv9foP5Qt4lf/oZn4YsSeEGeTP0DOJ5jAqBJg4o99hiO9G8CLzSBCm1RVCc5i4N3Ga
         MHKEuXj/cgVulHcCS8RBipZq1wPhU0fQETwM9+3h9r28zI8o/XlNwsNsmw7ykHdXNVBx
         IVEJQGNnLxnpnp9DjpLCPjErzT5mOuOoGPgVpDYQy4xAHL8hukslZTmZ7jdCxFvSJ74o
         pS5Q==
X-Gm-Message-State: AOJu0YxAIRqgpJGlBJU4ixvjqQ2NZgWOCMDnbehjaAV0O2F/zkgxOysC
	5i/bxpZqU9KVav6d0AOwPR90U2NrjZr7JrZBQISZ/7nC25hU2iVM5ztmBNzhOhehthevQNCk8cX
	ZMMbJL9iK1Cn/ka4NN9tkYoc+xCQBNKFrKKEKRPqfmTcgoz6HRHTkj24n/ZWtaPHLiaOaOFbG/o
	7YfbedBgRcOsrXrOBB/jzAcsvAkb1eJ8lCTA0taWFqWJ1rHJJa
X-Google-Smtp-Source: AGHT+IEThDsaR4nrdM9QUkfr2fvtoqk6MDSSNv7MdpTh7rVfrWjDIv+GGAfMkKnIH5f3gGJ9izW+qA==
X-Received: by 2002:ad4:5aad:0:b0:6b5:dfd0:a712 with SMTP id 6a1803df08f44-6b61bf31393mr102912326d6.38.1720681737093;
        Thu, 11 Jul 2024 00:08:57 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8d86asm23090006d6.125.2024.07.11.00.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:08:56 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] tc vlan: adjust network header in tcf_vlan_act
Date: Thu, 11 Jul 2024 10:08:28 +0300
Message-Id: <20240711070828.2741351-3-boris.sukholitko@broadcom.com>
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
	boundary="000000000000bce47e061cf36f7b"

--000000000000bce47e061cf36f7b
Content-Transfer-Encoding: 8bit

When double-tagged VLAN packet enters Linux network stack the outer
vlan is stripped and copied to the skb. As a result, skb->data points
to the inner vlan.

When second vlan is pushed by tcf_vlan_act, skb->mac_len will be advanced
by skb_vlan_push. As a result, the final skb_pull_rcsum will have
network header pointing to the inner protocol header (e.g. IP) rather than
inner vlan as expected. This causes a problem with further TC processing
as __skb_flow_dissect expects the network header to point to the inner
vlan.

To fix this problem, we disable skb->mac_len advancement and reset
network header and mac_len at the end of tcf_vlan_act.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/sched/act_vlan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index f60cf7062572..8de6f363885b 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -51,7 +51,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 	case TCA_VLAN_ACT_PUSH:
 		err = skb_vlan_push(skb, p->tcfv_push_proto, p->tcfv_push_vid |
 				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT),
-				    VLAN_HLEN);
+				    0);
 		if (err)
 			goto drop;
 		break;
@@ -94,8 +94,11 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 	}
 
 out:
-	if (skb_at_tc_ingress(skb))
+	if (skb_at_tc_ingress(skb)) {
 		skb_pull_rcsum(skb, skb->mac_len);
+		skb_reset_network_header(skb);
+		skb_reset_mac_len(skb);
+	}
 
 	return action;
 
-- 
2.42.0


--000000000000bce47e061cf36f7b
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
ydoyIjshhiv/IkUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOdEgKM0NtOsmTd+
6aT+NoKcAWZ5TIlTdRKu9Y9OucWFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDcxMTA3MDg1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQANkcma+/dG0MRyNCouZMbvnpMg2WZb4zpM
3gloIdtzGEoX1wQWfLfpje31jBwYobJmJnIDewozZdgL95MeEIC5aGa9CuaHivlvnswfSQuxBA7i
F8vDRBvtAKcvuSDAGRQHqNp5kzQmqX6uj46PIpIVWbhuvfsvCRBwYBf+n3RPMjAAyZoBA1kwHwrl
DPJjjpFxgEeJxVWbiCYxb4Pd5yOCoiGEiyTU85U0wxobDqRY6eyao3jHNzPWg3c+1oDKhYPZiTjI
t9WdCddodvSiViO2s1GsJTfILo9OOUbtwprWjyShF4PkE9w4XP0ArRvKsHusjhrmw0k3MJ+qBibX
HU3H
--000000000000bce47e061cf36f7b--

