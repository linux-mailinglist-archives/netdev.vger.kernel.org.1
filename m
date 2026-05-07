Return-Path: <netdev+bounces-285389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDTYFrOv/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1984EB0F0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 366123045B07
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73D449EB0;
	Thu,  7 May 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OBsau1YP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHONmrzn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035846AEEA
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167511; cv=none; b=BkF0+KPJIYVPRD+PB9StbptlkvfUiuSfJpsZr6ujME1B70Vx/Y20hUR5T/SIkoLYOqH6Bv4Aowh1tr4abWPcSvx4r9j2HUMBXiQ4HCh0jI1WVOBos63vQMhjvbNnvvrRX6PjGpiBn0l4WHZRJBuZoMDZ6mb2BH7n5N+HKt616eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167511; c=relaxed/simple;
	bh=/5JSpbZRWY5COHZDhN4gNF7Jnw0iPmpuvearF0ixaPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj9GO6BdbLdc8oxub+E4hg3rsOLrxgMjFKsS8z0YQXWfuOV0L6gYPLArtjswnXfiwgBhQ0X2+1mYRJ4Ww96y6w8a4IGYFYS/ULINKQpp9pTWIJ7oo06mBH6DK2mg7qHbAE1P1fHcIFFevjySixlokULqGE0SWsxM4Q24wr7f1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OBsau1YP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DHONmrzn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BUrod682836
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 15:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=; b=OBsau1YP7Yy+Iv0k
	Uq5fle1uCLNF61w2iOsc5BgnzsyKJrCSbaMr3P4ys20u8HSD5tSJmzwaB3UsTu1/
	65eX6tYgK/vJ2IVXY1nORGIG2vRygbP9teOOJffIvXS9DQq/l+CTaCkjAQPuPRXG
	1ScKblMYBSjQFTZjjKwMpQ8ytpsegGBp9EB0LwFrONQgBdA8et8K4uclP2xCXQio
	f6cC/i5TRqDx0gumanbzk9exuVFBX0rmg9+a3QZ6CUuFWfgXkx5gnzYYGO+Aa+co
	KjEk5eF+GrUEiIC+/d3AGbGi+HC8STjRLvTuU8aN+urzheNgt37w6Ospq8pnDa43
	1SueFg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhat8b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:25:02 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-950bdef305bso1466453241.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167501; x=1778772301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=DHONmrznETmLNj+/HA2W9VThA2sxk1CHvggZE5NPbGJ/OWjx0mZcuN7jIXRDZv1u4f
         JbbS71anhoD2uxxG6+D4M2TRl71dW1twRmWC0UJEzBd39A45NN79yvolOeGEAJmo0mta
         7QliufA6Zb8fnAKDPx3jOpUEUPmFooQW1a4YwG3pvgsWCoheqK/BoHVT0Bc7gwed4kSU
         zOHQM7rVvIh6iT3+zhAJ4gPonh0g32ROILXv5WoKG49HL1tEx088By3w717gjm3S8sPo
         QV/D+DgbeMUGP3LTx0xqp6UJBHwV3hkrccMpf0Jt0QJKLFUXJ5YcXWQOEZeWqgGGcTuy
         2uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167501; x=1778772301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=k8ac9S+UnpzD7jZzQo9ADQLvmLaryDn0NgFJOEN7AhOCTRZyNuXvfpMQVb+QzvfY1V
         ytjEagBSzXsXz6UOrIb3JrPxUKRu8c7Prvfzwdvwz5Takc77cH4TuKVVtCMrQVpDz031
         cQDloRAV74fAdO0hoL4uuRxnEHPgGPks9lfH0JY8yx+7U9x5YS6xensSgVuArlH/Xy1t
         jyAb/YY6CgCK9oWEzhlsSpeU4YqtpSWNmwCxWmUUY2RCYiTKgtd/GQGpItDQKAnRJ6bL
         8BMi2PY22i3QPEqnJDuQQ2AyJyyDcXKawtPcQcxQEYpBUyfdRU+j3dJjpwD2XX67HhgV
         ubVA==
X-Forwarded-Encrypted: i=1; AFNElJ8GZsqn1Xj+MEeVkIz4nVzRpHp57QARFq20s6ar8kZ4s++BCD25YAh9tG1DLfTJwVCNPZ5uMU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdT90ScXFFoxYnA4hjMsh0BG1IA6RcOEj6VyTqWMxIZtowava
	UIT6IHuQAMUg1ToAYwdkEobsMc5aCE/XEl8ozIPXyOmw/IQFHpbIRU4tZpj4plDrP0LMRT/0Cle
	gyLjcvWw4i2Dq025IcY1+KehBiIXlxulMNAASwiBhKgMC1FDg4FLnRCQSB3U=
X-Gm-Gg: AeBDieswY73RFlPu5jRbjoMegbcoLygpsSkKysfVKtM+34RmHGeOHQn0KPzxlvyJcd5
	2CFpWNEIfZQFWGUcZZ/XyFGBXPTZIgbF1HQ2zDRPrnxZ8NQf688TdGWTnVfSaKPjd62NI7y9n+4
	I6H/uGq6v/CSN29Xk5DBmoILiQIduEYBQgoi5jLB4/PDZ2V1ZNPJ063D/8ZT6hziSIQF/h9BZo0
	Qh8zlPxyxLYbiFyw2gMxMKReGnI2tRy8KIbwVyTu+VWzhM3s9AeC1EntdrNSNHxEGPjtO8CXG/1
	TMkJmm2A4d2HweexrIRs9r8cqjT+wgr0+0vMFR7Ae0iYGR63BIWLB1ydTN1YQL13KiH6a98qoO+
	Er4QxZXKqpktorVjHGkWFafHzdj+AGBjQKcVOuQmHIF2A8qoVhMPhj7Xe9TXt/PeRAKQ8RM2x/O
	ARKJVgaK3I8o8/SWr6MZJkEWUayXs=
X-Received: by 2002:a05:6122:a07:b0:56b:8e17:25f5 with SMTP id 71dfb90a1353d-575595c4094mr5143502e0c.11.1778167501301;
        Thu, 07 May 2026 08:25:01 -0700 (PDT)
X-Received: by 2002:a05:6122:a07:b0:56b:8e17:25f5 with SMTP id 71dfb90a1353d-575595c4094mr5143393e0c.11.1778167500580;
        Thu, 07 May 2026 08:25:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:59 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:41 +0200
Subject: [PATCH v2 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-6-bf17edd5134e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfXzMafO/bguGoz
 bXrJHABtu+36mFH9Wh0oTGWoUXjYKb3Xw47gcL1dBtwylhRxhPg2k17+njvNWslqRTtAhTR6MZR
 jNjCedn/eYnpNMCKqIsVR1pvcHsP2gdqYmXbGTRrHIGvsxleAcFLyzjYTNn5t21CYL2y83Gcc6m
 zypHRhSPvtkIXrZrn+6QlZHRL6L10zI3al9F+U6D8FfjvLf/DgB8JRmsKpLV95wy3uhD8NGF/fb
 f5k+2esltmA3BWCPGc0eARRpnLAvvUAAFjyRx/JOmi9iO3ua130EKID2kzfEORIJ8bZXu3s7iJP
 uLruNR72HHHIv11i7we6YqA96L9Fa7xE4mq9RC3HIY06PJLe5FklK40AjDY3pOPPqCzPDyO/9O4
 42k+8itfaB2V2+vrIvZpsgFBg4dSGmA8tz2Uex8aEAViyNgyeNbcDLpm6tA+7sorAxhI/XTj0bh
 CH/nwP0oK4NHwjMi38w==
X-Proofpoint-ORIG-GUID: 0hUD1sj_bBpD1pXhuDaWYkXsKq5s1EqU
X-Proofpoint-GUID: 0hUD1sj_bBpD1pXhuDaWYkXsKq5s1EqU
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fcaece cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070154
X-Rspamd-Queue-Id: 1C1984EB0F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285389-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

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
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..589ccdfa26c1281d6eb979370523fff0d7920302 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,37 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5074,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
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


