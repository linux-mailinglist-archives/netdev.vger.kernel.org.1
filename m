Return-Path: <netdev+bounces-296950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hGJrDp3HJ2oa2AIAu9opvQ
	(envelope-from <netdev+bounces-296950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:58:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79265D72A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pDnRdHs5;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LCwN+FzF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296950-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296950-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 781FC305EB31
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D33F4127;
	Tue,  9 Jun 2026 07:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FD3F39F7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991617; cv=none; b=ErSHocUXeJ0ku9Y5FncCBY2VPEIis0WoUFF/vk4hWiMF9vhEni8JaIAIjdxf8yDQnOOKfimqfSHFJl632FO4ehFCwXFpqXr/t41WdVkP+mwaGWMI52LrPLiEaFZg8mr5zzt7r+pKjWJQIdGxP40OIOx+ji9BcVxzLOZAqkOCp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991617; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dx0Ecbw8yguqollTWkjl1Gei74QW3s2Oclv3/UakaqKbjW/0HTBalJTnCaamg9ZWLQ5pEyrR0Gy9RLccrojQ2JGJHwkFOX5CRph1IPKOs4FqZYnhQxkO8BZjxLhEe78TZPR+WQBsaAtf/ZDvbwPwBEr4Kgq0wjoaHQ09KnVb7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDnRdHs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LCwN+FzF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rJh01585645
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 07:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=pDnRdHs5lvUfpYdk
	Ud7E9GB+W2dPNMQO/F37Vuj4hfqhj/dnsPgXUigUgbsOozzEAotANNaANu2+epFV
	RZXk+ZcPNYW2muCs5isIcfRMowSvT8ovPCDdjGvQLfJ1fAlU2vDmP0d815XesRRc
	cEqYZgd4Ojg6gjoN18HGi0nTRx9ok2UBrBSV6TRnoovNF+dxD+9f9Rk8tWqeHaxS
	rxToI+W8CGDXDn5OOU9hNQ3hOkLV6VQC97yivM6z0UcRKs55eEXVJlQ7TmsDrkdb
	M4JeYKR0v0lrmSdYdrTrZTFD8zllT2t3jeSt57u4g8FDAM3mV34VZCPfafE/RJln
	/zyrtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgg179-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:53:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5177f07eb05so102318371cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991614; x=1781596414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=LCwN+FzF1NDTmCN4MqqtO4+rM54cxcZasLV11jjMbK/7/kRTr3l8UQMclObpboCkw1
         ucCeNbVgNHpmPozxgT0zbSHD8dxxMXOWi09bAujOxlin73Mh8wYMeaGVE50DLvRKxa9F
         jsmn6gY5MdCl9tSucm+y4ex/yPHbat1XVdZCC56wqP5SuclL5wf3u91gquzflMtpfh09
         Sb2tTSgfQduJL6nr8VajlAku3GnxzuF7MlgiycrIS7KP3lUbapTWz6IdASN/trPNzmc0
         /bvAkn0LSgDWVaq4psl6qugBjxFhgxFCVZLfa8+ol+RN0dtxHffLHBg7FbxvzaCWFCB3
         IP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991614; x=1781596414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=njsW4Ht17hWI3axOmQJrFHP3BG5J1dVPfAoZ+FUY+rSs7plsV7KxpEpiy63m3SR90o
         Fg5nT1Vb9HsyWnsFvmdAXeBXkgD3OKfkQ4HaYDOeSO+9MarnuYJWTCCsHJOi9X7IMuCT
         Z+KN8b5nP5RTcXEm85KxaYF5zJtDNIN6/aDFbJOxJEEu1o0ttwfBLi+MnxHmpshLcTCK
         Jdk7l42alQNh7XE4EwYOoja8wLbE8qDyKXgMKRH46lc7QF2k7Ke2hkCzPBfGoOG8iR5o
         9bwZ0snxN2O3Xhu+VBipSf7aN1Vv2lXcipJbK1eBWIPgg5CIE0CsQ1RhE0V6yhwVN0IE
         P83w==
X-Forwarded-Encrypted: i=1; AFNElJ/goTRdobcZmlm+F+HrB7ltxoiQCAT5EABhTJkB6ypvWYkYUJnnxdt1FXQehAlELjGpyFanR4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaRGx86oXrwStW9VNgz+zyNH4DxKRwNXe45FdemUWA6R/YcdA
	lB/zm21YzRFanpX8arD4ovdw+ifgfrmPUMNp3VrftnEpVblfkWNaPzzWdXlkXxgpFBueSxCA7Td
	gYl7j/Wb4yO8Jepr/y9m8P9ITk1AVR5RQyTxKQee3onC5nDR2LNnMEHi/BYk=
X-Gm-Gg: Acq92OH3ACelBzrU7gVEAwQ0awCadod7zY7/+ukThvhjmdhuteqoaZRtwjYNs6g3aFw
	tTeZ51lRnJcXmUi2hvdk0LSA7MPDxoLMEf9olzdeFGhJ6m4GDgc8RsKolPR1b9ZehUT9tqIGXX5
	iEgEmF198IYWnlECB3Zafscsj2bybm6OOq0ly6FAz0m8eiiLXDxhSY53645PyuLALR/xd56F3uo
	L6uHkycsIc9EDo3K2tFWU9fswx2ZahvG16n9zVLDTU1iK5rDwERIMzra55IB/Orzr/8ZqSM8jTa
	JeQQU1rHV3QiNqBlPIS0n8V1LWr4ICTlImoxnFqotmyMWpSN748XPSf1TldTdew6nSvKONrrG5Z
	sM+7SU8vZbkjkZW+/VZW1VCsbhaZOEl5htYqT6zxM95+Fb6sQBdIKak+nfNQnA64BDccT2ynEC1
	L/c5std0eDb9plza2vsuyAkA8M8MAjsq+tO/JLIutX0lEFAnvnb1tQQUd2FhEVub6oKxt9TWeGx
	aCDeZHCgZRQ
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id d75a77b69052e-51795afed1bmr263903611cf.25.1780991614429;
        Tue, 09 Jun 2026 00:53:34 -0700 (PDT)
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id d75a77b69052e-51795afed1bmr263903141cf.25.1780991614000;
        Tue, 09 Jun 2026 00:53:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:32 +0200
Subject: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfXzl4BJ3ntonN6
 +bt1M52PSjal8WKfJB32XRAX4oQkz2GVBINhCq7NByntC+w4LZCBxvZxYB0ifvAZ8lFREtwjtdK
 oW0G3j6KAhWZmxU94Qp6fg3yZBCMQBMegt4lYR/iNw27afWuKWMXTU0MPwX4JsBpURcRmU4zmVI
 8mhAQUrT3Ni9bOCeEn4HfQtco+tyyWgXXn9/x7G+BcrtEz60x+ECrZtWww4/ilWlSd6cnW2OGFe
 8p40qlHnzTh7lUuNKaLzo38rUYALUw0piGuDiBeNMM6RRXAi1z06VRzM9m1otkc+Hpcg1Bwj3ni
 oQxrB+LZJIPBLZ1gmqL1/6vLU/PJMKwLDoK49hvM1RletnYoi4FmQNnkXVPBwoaNS2bazmKso9I
 /VAAISCAZAJ6qkld80CTN+5r2PA01HK60Je8N68tmTfxK63IhwLAT4rCMsTDr2XWD3+PZhoshu/
 yp1sRF035FOA2Yf26jw==
X-Proofpoint-ORIG-GUID: SKCjfqb6Hz_OsLtaIscooTIYJSHshgLK
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27c67f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: SKCjfqb6Hz_OsLtaIscooTIYJSHshgLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296950-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB79265D72A

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1


