Return-Path: <netdev+bounces-281928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCm3MJ7I8GmfYgEAu9opvQ
	(envelope-from <netdev+bounces-281928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E44874CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBE332BDBF2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4ED46AF10;
	Tue, 28 Apr 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EcpAQh6T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JGCxDVa7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F5466B59
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386219; cv=none; b=ZLXkxXeQFB60SmQ3ZXuXysaQl2OEXoKcFB+imqyOGy1MvFOKvLSf/KFRw7bosB6l4iRqPpQPeSG/vy2lT/qwLzLQ6ezY3CkqNUAPQHS/5Y8Va0yG4Q1jJTff30I5m4+ex5V1YfaVLCL/+w5pQAWJtoQ1kmx2Ws0wdkj5jtZeVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386219; c=relaxed/simple;
	bh=JHOUVT0V1f6mw0N8o8TQITsurij+VJ8yGqDAQM2x4i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzVD4wKX0Wcf0A+B0QoWDaL5tHVFzLqX5SeserBtp8Sl65nhihBBTp+POajxvHybxDB5EHJd01P0LTht9Nmo8/GeG+XINN1qLTTMuhet3dqW+Wjm0Sz2QEa40pbktzAqnSEnYo4cnEnw2KLTsL3AdzC5sTUPIO9L9ou5wbev8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EcpAQh6T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JGCxDVa7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA6DTl1329492
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=; b=EcpAQh6T9qPyWr8l
	yo7/iDh2mvD2DmoZ3LQIwNGfL8V4wJTtdC2zRUwwoXlwlRKw7tuOUg6KOifU/4CP
	UrnUdvNmG+IvkyXs+9OstpsQK6fmAMM9MszTdh+SBWw4GJhbcoH2O2H0sCXclvQ7
	zoQQHAxmYz57Lr4TzeDb6+Jr7aXyC6L2tYn3tLfT/nfiK/O4c/WIlXw5WlgrjQBl
	/Hew6k6EWh6JBV4EyzP1TFMWHhfVzoCxdksYi8IHo4xF23hRwQ2L8nqYY0/RS+8H
	ksRpS6lFHVd3bJAYFxshm0dDtohw4J3Yyx1GzURiV5VtZ3cRULJSRIAlJ418s5Qh
	CVh6MA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhaja27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:30 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56eeaefec9bso11285125e0c.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386210; x=1777991010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=;
        b=JGCxDVa7xDL3CmLidLCAsUs+l7bdiNDKSJ8Uch2sM7jiSyOzwEZTiqCws9hMyw0s2Z
         kZfe4Uo4vx06KZpEwvjUqSTCwy+DP7N2moOCB4WoMiVCUuIEZ0X/tCF97PCB45D2PN+h
         UbhI/eyeXoUd+i7og0r/++0EUyL9F9kErQFVPFjF0WgdQ7JGbFtf+GAwB7c7JhqlCTRN
         utUyfXcUvMDVjhKX7dEXoj0RdroXsf7H9jKlM36ekx25clmvdggnXLDGGMxPHJ2PuqyR
         xpjfSzw4WNX8WyPODAth4jESX/0G2TCCwhhEZtywoCnI9wBXsArqYeb+b64Qd2G5iTDH
         xIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386210; x=1777991010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=;
        b=oJT8KcfWTwo2YeYd3QqMdMvNC5p0oDnJE4kd3FisgI6YQCkXbooZHGTG+iQFB0lDCn
         sGF0B/TnCpk53yZqmNRcXtAYMsiHh+OWAQklTlrI80SMmwsQP3vAVS/rMNI/sjE4Cm38
         bLU082BI0i0szRGS9zqyMSFLhVAwWldWPKvV0wp8orGTf1Zx80axxoLD/95u9G8AUyFK
         ro8NDDVis3W52xdp7VLMznAQSXIbT0pqdC3LQgGOYlvrEB7UYJ59rSGx4cC4+bLAQG2i
         2/XIUi8xtDS42J5nRENrng+S/gX8EOvhidcSj0l3FEccObMk3iFQCtHfN1j3m7GfLGUY
         MOZg==
X-Forwarded-Encrypted: i=1; AFNElJ/e3kmCF2q94OyuHTPm78bh4Jjr7841M35W9eKPxF+nhhChGVbQUhy6f6jT71ksTwdB6aIDTXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XtIfHQUgkbGWMYKuAssWM/3LIx1XhFYes3sqoe6zR9aT4tAt
	NFCwM+pROSmVMKI8gFjGxxf8fOfO5QXEFb3iuoaHWlsAXPnga9YvuS+0DYXcEULpKl0J0sxT3h3
	zxUAryamu80xJ41sFWCYGG0f+3KW1TU1fmv5CAqrR4IuYyyukvLgPsRKnsmk=
X-Gm-Gg: AeBDietOGYzpHAPm5pHbTfcTlgyifGlLdOKzaCiCVq84/q4zUGUiUmVWloP94vGb7tv
	uLHyc/mPHIRhKF/gf8VOmAksbAe82nVOn9N1UZ8UkuEgcJRPZ69BQn2bBpjxA06GMZukVpAp57b
	FIf989tlBweMNHIDOX4NSLLBeAL4YofbgWmFLrotMof/nv2ujjkdcNTHwVaF/ZWDfUf92872rVF
	XJimfKrhCjxfOOQCIGj7FWadL/eMsEYwfHhlEsdLI+B7yL1mSxXpcgbU2S7NjRbSU3KxtK2q00m
	1W7p+CwcqewkYlYLpV2vwi+bc6kGKvrGdZsQsFHufyhGfaTNEbjhtoZZWgjn5S4znFmOMzfdN2W
	c8WVOAcQQXytiWOZjQwn8Adm4zoxEOZ0nTVR/MEKK2JP8hgVjfqRvNoS1w24r4+9J7PnUjYJI10
	B/ixULnap/cCdg5Vm6iBnCRzz5BN0=
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr1580823e0c.14.1777386209728;
        Tue, 28 Apr 2026 07:23:29 -0700 (PDT)
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr1580768e0c.14.1777386209190;
        Tue, 28 Apr 2026 07:23:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:12 +0200
Subject: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX4jeA8hB5L1eH
 0fDsreU2vGvhqezzx4HKdYTxav0br0zWru5YmCvNi0HD5y9k4TI/50uaT9CskWO068DPs1jHjk0
 pd9ZIETWww4auJwyP7w1X/4zuXUSU+18BVNO4o4lMQ0ZOe3doXvVp27Sw6ArGOPA6p5BzHry+eY
 F1V8xFe6tzSTGs4DNpDt49VrkjcrX25XUZhNpvLMd7jeJiqaSYMYdS61Q5qb1eoIuybcfuXJX+I
 WcS2GC1lHDEr5sYmZaP4M/HTvcUjmXpeMQGrjKifNxRSPdqpIlc6AYtAKSyEkQavf+7Sgo9NHRD
 6Cav0csJVwHE5dx0TFIzJ+RpaxQafhejA0X8QFWj0w/qmC/2MMyOPYgAeIFbonIAGKMs6b1TZnJ
 c8XVVaQYwOWEDca0U7QaWGVkvlDlHXBsCohaMJz7CvyA3KF3pJYiViCNmYRyYWw+Me0OFpwKEM3
 8Xyu/SChAbu7y52ghFQ==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f0c2e2 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=teJl78XSWlBvCPfQsyoA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: tQGf7Ekn2kuaDEqmwf1m5P7ceLN27xRi
X-Proofpoint-ORIG-GUID: tQGf7Ekn2kuaDEqmwf1m5P7ceLN27xRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136
X-Rspamd-Queue-Id: 808E44874CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281928-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 +++++++++++++++
 net/bluetooth/hci_sync.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..f87cb6ae85c3a5754fe79f415ba05dd177f75fad 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6,6 +6,7 @@
  * Copyright 2023 NXP
  */
 
+#include <linux/nvmem-consumer.h>
 #include <linux/property.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -3588,6 +3589,54 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device *dev = hdev->dev.parent;
+	struct nvmem_cell *cell;
+	const void *ba;
+	int err = 0;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, "local-bd-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	ba = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(ba)) {
+		bt_dev_warn(hdev, "Error reading BD address from NVMEM (%ld)\n",
+			    PTR_ERR(ba));
+		err = PTR_ERR(ba);
+		goto done;
+	}
+
+	if (len != sizeof(bdaddr_t) || !bacmp(ba, BDADDR_ANY)) {
+		bt_dev_warn(hdev, "NVMEM BD address has incorrect format\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+done:
+	kfree(ba);
+	return err;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5091,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1


