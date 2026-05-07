Return-Path: <netdev+bounces-285388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G+7E4Ov/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE94EB08A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B4713082123
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0E644CADF;
	Thu,  7 May 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQGKmWwP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoiEoIEG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064A45BD48
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167505; cv=none; b=UDcMW8pM7ZoH39Ow+3f/mKa5RIiesljOfUNPKKXRn4REo+Ibx0GKQ8asqad2ENl3l17Kif9rfk0FfOVmY40iulvCw4EtcsvDAO9uIk7zjYeiWkywqfjVVoFFm2CsA2A8fFMJPTmswya/Z4xRQn8seaUz2b3uUvCWBus9rKgf4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167505; c=relaxed/simple;
	bh=PTkmvq/Q7QJ06WLt1N+U7YrHr9PbicR5yuKr0MktND8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIHlb/WsjY2embmRJGJD9wDYSMofOJNaHwto7125g4kByBP/IHWX0AOATWS0gJ2BS9vBWuoxFKpMsOqCnBOTOqCA+WALoKzklZK9nev0BJvmHVOj5gXjZ4FdjWxTECxndMxAd+DLhovAtfpLkWOaH0H0e+LF2GvPSg2QCQ3mVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GQGKmWwP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoiEoIEG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647A4RWO026480
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 15:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uk7Oe1xq0TlLuceyYysifE8TQzhLGFxXPLlz8g3T7ak=; b=GQGKmWwPpcYT7z52
	bh2TBhD3xN2aVw+NnsWrysEnuoLLqDCOscuj7MW+9REwKMoW7mY5/4nq9ouPjv/g
	thwhVWE3ViIlDkCt1ycf1AQFZ1cGZ6NmEpXCVrtcQnVpGRxU3RQxdHtKryWF6KTx
	K+xYI7lTzBNnoOWbnW+5KGwx1fJchODrvLFvjUD14mh/H0p4TxPqRr84WwFrh27f
	8N9KTX/ztpP9EOfYjCzV1eoVEbr61V9zen0za/2MVIw/iZ5PXTf+/ZK+7484+EIw
	Cm7l3M9dBPTFL56gluoApthPugAaLSFg/qxw+RHO+JWjyxvQoRxJcadQFKuQf+xk
	3Wj1hw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t2kbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:24:59 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56ae34d6738so2126987e0c.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167499; x=1778772299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk7Oe1xq0TlLuceyYysifE8TQzhLGFxXPLlz8g3T7ak=;
        b=BoiEoIEGSFg2nLyqYhoAS3ipSziX+Bf0RWodsXs3iufy/Qa5PRuz7MUHqznU+dHm0/
         CqCfhVboEOvao6bgt8qedh76exBuQnXexVSN5oyVY0J4XngL5MWXWqxuvqrvcovefsDi
         38NyygRbYNg08ggM+KVxvhyMY5loN1lk8prlnui30qmnvBnG6GaXU/Pbd1pGWh68BpnP
         NtLiMrx8YmEkEXBoTRuvWGd9nYVoXNbJreQ6RAP6DvEk7RJMf6wb40CF1bFe2tUeiOvK
         Vd2epm1UVYz5f9qY8KAc/0Qxe0AHlFmHw6+TE4xzWYAUVsZjhDAlx7bHp74J0vDwYHOm
         Wb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167499; x=1778772299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uk7Oe1xq0TlLuceyYysifE8TQzhLGFxXPLlz8g3T7ak=;
        b=lRk/5J+IHX6u9DshuQDZAQ0GAxb/Q3FNLAALWKjV8WXAT1sW+JCJTPuNIqOiUBtw/H
         vnjK2d0iBW2frW3st6ylEGxMzzQA1u0CogPGAAtInodCXY43fHgO4T8vshmNpe4zl1Lb
         g2jkKiWmtxJYZULhsnfhogAMZftF2ADs5v8qVzk6VFnS9G/zd0ARzKnFRiSCeV6R1HeT
         cKxQy3LMsELuaEfmd9FwLjrs8n0WsB2cup8gDBtAm5Q4keqXcp30weRoCVHzWfZAQtLO
         w8ACdk+hBEZhYiYTLKzkEZO68VVPDYwoe+cJTVuiVi39f6ehXmYa1mOtGfw7S1qxv8Y2
         sOaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KwYmtQE8PQel8USBOPiEJ2z0+CTemr0/NnEs58fp7esi2Ajv7dv4Bmlu/2s2nh/AKmGrRzOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeiWoYE3IczMbmhv1vQvLFVGFdBgSlzZ3nuWR1n8h0Z/tJmZR
	gJ/DQ+1KcQ6ighpqRu4Ir4ksgcS0dAKaqxhG/O8QogyKoxs/Sv4miRooJ0YFhPGTowF/q+WxruQ
	11vwpoKRLegW7yC5XFZGVOz2AD1xp5Xu23nmUPctGuOe6SCAef3xe/2sRPJY=
X-Gm-Gg: AeBDieslcn7o/KG9VEYNpA9ssUrpE53zLcnt1VBicTm4nhUP/clvNkopFL0F3yPIkMW
	CJWd0YDDt+QfmINFGDAnM4BSVmaZitCztFoShK63ckS5reMda5YySBK9gJrTOIGl7PsN/7M4PVm
	MaPsJyZxgxaali8RsS+biN6V7RzW6qq0Eredey/EKv0/UndI87xfUmaXOq6H5XafStaQhq/X2s0
	Yv0zTn2V7Sxn1iGsZ4HHf5k88xjICPeJzFFLFBwyD4h0uVuc7Sgvk90jsAiMph5Jk8EOwgPGzBc
	wWoz2SUXkUs4F5hOq1pw4i56FcQbjcbDhvtCsLZXm9syD7AcNqMHoQEntwUm1yjwru0Vi+v1oC2
	OGwe3PiaB/6cGomSDC16dvy/Q/hId8wnf3dPgBycAP2QxNb1Ah4v2BdzwN2Q6fFUUS2QrrLTgn1
	/TcQNQfL19Fm+Vk5+nk5qPtvgkPbI=
X-Received: by 2002:a05:6122:1822:b0:56f:6add:9029 with SMTP id 71dfb90a1353d-575593aea76mr5335423e0c.1.1778167498697;
        Thu, 07 May 2026 08:24:58 -0700 (PDT)
X-Received: by 2002:a05:6122:1822:b0:56f:6add:9029 with SMTP id 71dfb90a1353d-575593aea76mr5335377e0c.1.1778167498276;
        Thu, 07 May 2026 08:24:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:40 +0200
Subject: [PATCH v2 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-5-bf17edd5134e@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fcaecb cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=C98JESGoZJZpJ7w8-ywA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: Kr2tF9PYavDbWUu6wagfmI43hcqIaaU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX9wJpyNd57LsC
 hWFGroSy4QCh3Eq3nVFiLZMIPKm/hE6NRi0I+Rs1dN8hJiXSGaMYAoXkRRxo0LWnKAxmefroMMA
 ta0bt8+FKZjTiXdFZHvbKHWgCmOaDKiFl9cx9EtKUhXP96ziqCMjfbr/INuK7zIAe9prZdVKqHX
 8KwLV9Hhd5FDs1p6YBhmO9T2lXPIFFtYJJusjOVKn4dDenpi48Sltg/VcG7eXKsgZmQMTbsFfNg
 1jB+M8JHxKE30pf/guALG/SySWJI6EzaRBv8MeAw6I+oIjay2ShVFA5XfgTQvYcalOKIswUr+Yd
 kr8BVCGeTy3CthNjOPy0JCY5FL1c8pDt4Ro51b+AZKZCFWXs6woULq7mvMQ0LsNOt7AhNvw3H+S
 Fa9UxDsuconuGsEV1SqkB5eSA/g84TPMpkGddvAXQBqlBemz+xLQ6qUc75Ma5a363N22/BVaHuB
 EoIwwq9/6p2b25R8KhA==
X-Proofpoint-GUID: Kr2tF9PYavDbWUu6wagfmI43hcqIaaU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: 0FFE94EB08A
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
	TAGGED_FROM(0.00)[bounces-285388-lists,netdev=lfdr.de];
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

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 47 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..79b289de0f16aa5f8724e84d6f2300648c25b6c4 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,6 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +72,53 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", addr);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(addr))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1


