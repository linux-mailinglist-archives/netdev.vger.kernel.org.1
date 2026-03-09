Return-Path: <netdev+bounces-265593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ISGCl/mrmmsJwIAu9opvQ
	(envelope-from <netdev+bounces-265593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:25:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE91A23B997
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31C53301DEF9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259A3D9048;
	Mon,  9 Mar 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgpV29Qc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRINjPyl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257823DA5AD
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069872; cv=none; b=PYFmP2RcJMtS3weUk47/QCsgRoE6x7wcP8C6nwLmatsbK2CKTR63eHs7s7DPjbv4R+Mbgs6v8JtFNrxa+LQ+dP6GHPCiu68ehUBU5KWn/EP78i2/YHSy8NQBAYdeq0RbL1ppHTA6TSIQizjLiCVAuDfz6T8vTJmvhTHBQxRCkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069872; c=relaxed/simple;
	bh=7AwlygV5h7t5DG64R8q28g9wbx8HDiNmnHNcPtMhQC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5Qug9uD6ql9DgADCfSFU0Cd9d6THfAxL2MrlFq2CDajYmAS7+/oSn0Qwy5yCuT3N1nS17M/ZozDQRDPYd8bWSji0abu+v9GMzDuBTcT9UAgEpwCOvDcrIqkMxF4EG7wnhqUNk6Yb3S3td67av5R8Mv02eAktFff0XJ+UjrYFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgpV29Qc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cRINjPyl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629A6gsF2195134
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 15:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4x3hsyPkSkMASBni3nsDPns5dGXwhA79Gc0sG642gds=; b=hgpV29Qc3AoQAL5+
	HYfoSl9vyHIkH61H2bDLNa/ZbmeQ4q6R0AFvtKFg20wmihHkWQa0acf37m0QwQox
	K3QMOS2fOUdbm4MBYRixB6Gz5tBILPMoQSm4xXX5GvQUs5Sn38yXRUvLEqj0qTyl
	HzBKkVy2X2USnIdtnDLSXsLWuxx7sImRG3bEAXR5Z9sLQtltA0m7XkUMs9+BvTQU
	9EJ2cM5bznu/06fBeoJT8bnhccy/ODZF54iISAOJ/lu6NqDYzM28v63HdoHaVcz2
	t/XW9sAX3ROTqlHrNcbVJf4DmRZ5yesH3tdDltQY31pFEr7B/Tb5mPC2OR201ntt
	0lBhCA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u90ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:24:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso1523004185a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773069870; x=1773674670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x3hsyPkSkMASBni3nsDPns5dGXwhA79Gc0sG642gds=;
        b=cRINjPylM7gTSnilpxe3YgPpw5pqhzMQ3vAPM6dbqpOzYzhHMCLDCatHCB7RLQ7Bxj
         H/wCklBEMKHbk+QSUF43HNUZ/o/m/+FRL1zbBwRANWSxjN1Z2ALZqLa4priMC2Ia+5Dz
         VCjA7p5WNhbEIS4+R/5KLJFFixrrj7T+LNMYpEcKDEeu5vx0k5bi2c+nVArgBEssygo8
         eU5XhvRDLTC4NFcrnNJodEzV7QZgLBUjwkHCA/GwCl2ae5rp+A73zd7B3zX0IIP7pu/Z
         hFb+FKGdSoxEcx3/h+hFJq2/9caXv7u/h/uPeVTk2PZogLhkNuyJIe4U+0JrpeEdGf51
         izTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069870; x=1773674670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4x3hsyPkSkMASBni3nsDPns5dGXwhA79Gc0sG642gds=;
        b=eeagBxy+ixAeArIBuBNMsgOMlsDdunrB2rr07/d0DrY4FoMegaFs/PiApADdjmHjB4
         R/jSge8cCEMa26P1yoN2hG2D9JTGGbmPBNXRzFtTY9pJtLHk2KPcdvlRusEwJmE/9Txb
         ZB6AA1//wPwPQ2obK1but7eoCebnO7ss5Xl8hNx239LMfVVigJYYgNoq9PXHKLS22eoO
         nWFzKDUjocPx2Uj77liR39IwbwXR9JmOw9Axj9cxpGkxQbZFgJoELsalK09BcqTTRV+q
         +2kWMM4h6v/UfYEWK61h97lu4V4gFIYnXae3jlYIcc+sYPcUfHZ4QX2FiGYRoUQz/PCi
         wEDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDOpjizv3XZRFKuAuwPXbdQeOLTyI1fyTTqdEMV+zZsQJeT+Hb7hBF/vG1hv1z3uknSnPI2mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQ65gRmFOpk+sjqTHHHIWhbU3fYeK17yh2yKEVmYb4aSk/XVH
	Q3d4bSyIp+gcjT5ddONpJvYgqtqBKJmFzOlQH98f+vvICvQUCCHKuCKqM8MQBksABGGRw8gCswo
	E/0uHO6N1NGUXGsGNj+eGSitTyByK+wUNUB3ZIYXyn+oJeDXzeObMbR2Y4lQ=
X-Gm-Gg: ATEYQzzz5QlXyL6zxiMb69fIKvkG9EEae8D375rvYlCgTIu55E8FxbsBG1L4d7Ul99s
	qWTeWZ/tDNDJUgPq8ROFEBPx8VqMUbonvSDYjF81E6be6XH2ou8pR2ImMgVnDdIgtsJivwK2o7q
	qWJXBNix47ZLLZj0kdhkYh7m48pc1NMXeLBR41kMTEOGdP2wfTlNaZ9yUbYhOg2xcZDHXOQf31G
	VBij58J/QWMTBlHC7xoVqb0d8am9bU5SGJqH1Zz4bruk2NGCkammuUvGwgabyIZ1phyNDK2v3Ov
	VUBQeyFvUfxU6tBIfNIvkgHHgOAtKbUZNSV61vJieEjxunjNKYXeWfCciXMGDQVkG1js+LhVeKV
	1WwpQiPCnjoySx1tAoiGQ6jHlGUDAoy+dw5SdyYl+qi6wnMFxJ+o06GQ=
X-Received: by 2002:a05:620a:190d:b0:89b:9b75:f5f1 with SMTP id af79cd13be357-8cd6d42831fmr1515070385a.53.1773069869481;
        Mon, 09 Mar 2026 08:24:29 -0700 (PDT)
X-Received: by 2002:a05:620a:190d:b0:89b:9b75:f5f1 with SMTP id af79cd13be357-8cd6d42831fmr1515063585a.53.1773069868836;
        Mon, 09 Mar 2026 08:24:28 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a59fc36sm192812515e9.9.2026.03.09.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:24:28 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 1/7] arm64: dts: qcom: monaco: Add HS/SS endpoints for USB1 controller
Date: Mon,  9 Mar 2026 15:24:12 +0000
Message-ID: <20260309152420.1404349-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wd6cieXSGbDhkwKR--1njDQe52PxvFNj
X-Proofpoint-ORIG-GUID: Wd6cieXSGbDhkwKR--1njDQe52PxvFNj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOSBTYWx0ZWRfX+eUau1dzd6AL
 pH+tTFPDtZ2dxYi1eLrvG+0bVBav2BoR9g+sadDgtpH+9xUc7Cs8wrZM8eeKAAsY3cOh4hjDkW+
 z9PeK7U5Y8PSML3kAY8qITrGcfEqdo1qJpJpOYSrNEsND73YbkzPUUjwEhE5ahsPSrfo2S0BPwT
 QrhQ89yxTtj1JfFgm/bKs1600j3G+2+05mvoEVKoMgY0cWXoYeuzAwYaPjM61Yx6XFYBwbu1ZgN
 3P3Tx3kwAbjJej9mETUFGxHS+8/ivkV+4+eA0GlNZhj1wAbeYtDxtKvEj9dAWxHJLLs0NGi5cgI
 S2susdrhTEUlbKMZiHoomTi3PicVAhUv2DLhSJXX9uy6vIfTICM7tx9fDpc/F3qob012EIkBhNv
 HUnOULkncZfAr9w7K+N+ijHd0OFOShct3mxDkO4OHE8glrN6j0EBrehYsfqHWzBhLCdBtSYuEvN
 LeuirZWmSVwihbJ39Uw==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aee62e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=yIVWX9dL_PbMwCFNGlkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090139
X-Rspamd-Queue-Id: BE91A23B997
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265593-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.0:email,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,a400000:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

Add a port node exposing the High‑Speed and Super‑Speed endpoints,
allowing the USB controller to be linked through the device‑tree
graph.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index a58dc60e64f2..ce1565c7cc3b 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5180,6 +5180,25 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			wakeup-source;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_dwc3_hs: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_dwc3_ss: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_2: usb@a400000 {
-- 
2.47.3


