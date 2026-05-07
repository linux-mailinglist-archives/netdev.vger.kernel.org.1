Return-Path: <netdev+bounces-285390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J05DtCv/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321C4EB11B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFE45301A249
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945A47A0C4;
	Thu,  7 May 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNRuu/6t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAlW2kYb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A78472767
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167512; cv=none; b=MDMy/M8lQvFJHIb8GWJ7h3L4vM5cqw8O2FRDmXzJD/P++LxRYAFPXoCQERxdPh60jueRXHKqFKJxyAtx+4nTnUdI8Y9UzYC7ZOX5/p7Z0ggg7W8NI8/O6mOv3j2lvhU3fD4i3EmDGmBoE3bGjMNFBy4uAvOFCu4pLsbQQSMuf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167512; c=relaxed/simple;
	bh=cLdgwybwmVheaxNq3A4ptASzy5fGo7sa3nM19lVmCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfpTt/vgSPwUXCvfpF5U4mhCkA4RQkOZq+YBzf3F7JrfmP8+SU/wjU8cGotMAT5oKCpoaM8YSowy7Sw57C6ihPB2y91dJdmf/4AN8kuPV5A3HGen7oJPdXzYzp9QyK259ZN+1amD2CPOwBkIEwd4Qw4mB2wHB4ABQUlf2Zrr9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNRuu/6t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAlW2kYb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BkQ5Y3924169
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=; b=JNRuu/6tQg8Iq2yd
	efyuW8NpXjne8LakeYYrmxE2IXd0811URgteAZuuZe7hSFzFIjLDs4geR7VhamFG
	n83UxzHDzPwQY0bf2pDm74l1Dbpi+19LuNU2e8Iozs8RmX3DhPdqyCEXe9F58AMu
	8VrFY4AoYHnLwTjLpcLSAYm7/UY4JMH+8frEp7SibnG5+D/O78QB0nBkVdm1mpO8
	TYSdd5vt7KWPhF+nOUX3+HPbeX0X8iooViDwgbzYKKlaHtpQU+ybcnyGr9XHY6wG
	ikXlCr+7RoRcCJ5Tl11QBu+mpsMILrxsHNJNLdBXZoQUHPyBKpG/LJw4k/Phl2WZ
	rI3n2Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88bs4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:25:03 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56ae34d6738so2127163e0c.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167503; x=1778772303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=FAlW2kYbEFbSRezWYKrHriJT1nLtx00Hme0Ybkk+Wq/NiOaZ/Y/JcLJn+mnHNNS9cA
         Qz3fZOVCJc0CZn/RhXTbWqKaXvK66YfCSDnKZdOBLVUzhqJ9WpjyebFW07P4HucUe7q9
         iC9p8DZiM09iujRtRkcp2hE2RZdIX1KXEgJ+LzjYmH5gpOcWq3tVtOsjLp/GLb3Dd/Z+
         hSK+wAZyvLkBXBSEKJciEKr/Af4kcl2AEyxgR0BLIjMo6rDNUCdGQoMXyCV8XpNRD26q
         Zm3AWKTJjwBp7cyoNjDtgKs5TZhgY5EX2t/yqgZOJJD3fqT7cdrfWN7wjugMNFK3Eq+P
         083A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167503; x=1778772303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=qvp00wdP8xvz/+pdH7T86H36MedSMOJIWzYYQut6A9oUMfxn1rPXmTBDuI73AwcHL9
         PUXmZGoQQCiUULQ0r4UgLIWSgw9LamiZVYiJXqiFWuG+JuahWGEElORJOejWBU68sC8K
         tXQQvLmnYQEYd1PPTrHolcD04gQZCoELfqRgXIptULxVIEy8GjevTeKpVK7q7U89xWqx
         gynfVRq3TB7mg649Dmle7s9pP/iTh5Cdruz+T85kGJF2LDxNZ6lG20WHGRzh97KtUykq
         iPRuBxQqgrAob2UIJjCvPgMEudZiq3uwIBckWAZoeFlsRIWOpytLZcLI9jzolPEqBuvW
         LEtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8D5+e80yr5lJVUg+dn1jh9TKgoUbBUgZai6snB9j1qy3azuHyEoBzBwRBm2UI6LLcuv6V0tKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7D4/eQpM6DdnlQgkbN6WfFY1kICCPjpqWWOKt2gB5vQVXIIt
	fiaFROW0leMf/EZ1kSJAVuKq9h6G+YdemfQzC8d/VX7h4z5iRM4UYvsOr31ggspP1qpSpIvEbi3
	m7/HIAZMkc4r+JUy1B4AGrsG7fO8ZUcG4vUa4m5OyzH5eYHSRNqMTZRfXbPQ=
X-Gm-Gg: AeBDievrCSs4iCo4dcoCFMBK/ja+UiTstsi2cgv5BBXhWRz6CmG2KfBJceJnIaBhToD
	J9FaZV8QUDdnSLT/Pd6Hyf3IULbpi7JJFHONfJBOGjJpOzmCeQaaERWiHnWB47zCaGnjM1LXsDN
	DUkTP8nLpWSHJiIx4oF+bH3zJgmCOzGKI0kARPpt8xhIoSJtMB5n7OcqefA0ZBBc5UtP4iTWkT1
	0KX2tsxu+Y37hRxqCjaiPLHzGrkZMNM6+mkETHdfGsMknaKizTFD1tPgENQ8iIYbTqHaJUDjotL
	IB8nABD8EqfPVLKCZTBevhMyCqv1eBtTCiPc/qYNDeS+wWgFtk8P53C91kzlSAefGXRt2M3CoXS
	CTHfdtZTztKYZmoSYX0+e8ahJhGpFGnDdroV245W1sj31hOWzt+teG6o/kED3ah3jL0voKDuLfu
	7UHMRgLJdMtllqs9Pyn0aK/1chvZ9DzN9E3+Alpg==
X-Received: by 2002:a05:6122:e14b:b0:575:37ed:f787 with SMTP id 71dfb90a1353d-5755968ada9mr5305805e0c.13.1778167503436;
        Thu, 07 May 2026 08:25:03 -0700 (PDT)
X-Received: by 2002:a05:6122:e14b:b0:575:37ed:f787 with SMTP id 71dfb90a1353d-5755968ada9mr5305758e0c.13.1778167503042;
        Thu, 07 May 2026 08:25:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:25:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:42 +0200
Subject: [PATCH v2 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-7-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Rq3ep8D7DA49rYXB6IueR7LCWN20K0wr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfXwyj9ZlszOXuc
 9hUOqmA7iuI3pUOy+VhPGSsXEbsdLFuSPmACLHSrIEQq2yjABt4UYvJwJ1g/Z+fdFjBT49eE39d
 oyP+QL0F+61ajPn/55BY5wu7Bf0gff5zqCBpfS/y3wjkp7LLys5zqF0c/+Vu/EpNgJFN2nIknuY
 xpZ7BmNjsvYLikTZybxsQeu4fhmEgFL4yAjELZIquy/qJ1JX8lfAAewyCnc7kElw4xRmkUG0tOY
 pD4Rs3NQuFKU/Fx5AZv+hWOwiVC2/L4ZvxEQ127YYkpe/+SWqi6XkbSbYFtyUh67ppg0Pnm21WK
 Oy4g5BqD3fKh/eRXI3qd31yL4citGoklaNXjq994GuohDe7d183G+T050xtr8HayXSS4iGh2H4D
 0xlthEmKcoVA8KXaseVi6nXGRr/66WDNv40gLpQEdX3kmaWQtrVKMUXipPavuiUR4wSCxcyOXrn
 pW2n4CqmCBd3KqRN/QQ==
X-Proofpoint-GUID: Rq3ep8D7DA49rYXB6IueR7LCWN20K0wr
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fcaecf cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: 5321C4EB11B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285390-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

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


