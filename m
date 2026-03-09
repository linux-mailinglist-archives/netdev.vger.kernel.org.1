Return-Path: <netdev+bounces-265599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKd8H8vormlRKAIAu9opvQ
	(envelope-from <netdev+bounces-265599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:35:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C323BC7B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5383044805
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5563E5599;
	Mon,  9 Mar 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLxY740e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wl/oIEIj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D43D903D
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069881; cv=none; b=Jqe57LXzsIOGBJHMPYbvIXuhrhG95s30HAs5AP0sGoHSL0S/Zo+Omew4SFgIh+zqFTpUCmmPu71mwXeO44iZTDk73sxY/iFC0wIAjbdzJD3oQDgVvCXO84pgId/5g4Sw8BKKXbn+hlevXRDiB6oE5dtgzCV2rPWLl3fQLWoMeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069881; c=relaxed/simple;
	bh=F9n0ftLKGlM6JU8PeQyKHdnuFLu0ujL0nGM4mPk+Qlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9QOIm2wZMT9xt17WVKc2GsZHlllN6bFsBplVzJ4Ofn8PF49q5sIXBARYd+GtzJ5T3CCa43njJf7CIR7o8O/kUgRHwlKik0PHytKsmiYjPhKJDX6C9aJaYJPtpSNQ1zwIwghNIiNpSrt32gaPt89csJHEjdJePYSHEnk6aIj0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLxY740e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wl/oIEIj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629A6fg12195131
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 15:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fT0QxTs3w4o
	nOwpcb/N6xWIFXq4k74USa4Ia+RJ4IcI=; b=SLxY740eFeMHXel3oQxGTx/vPOK
	ts6zQHxpSRpSOu5czImJIHPnK6ylFHpIb0Y4gSDSJeuMIrw/oV6U6Lq1pPkj62l8
	HvXJ3JdLuVInwI9U9XFozvYpvJk9dKWOwWcUBYbprdrWE+fsPKSf0YcFE5fNIkt8
	nYzhCxeyVJIKZhjmrBMkKri63WgVbUyT1KxOkBEs+xJ8v2P9HKG6eMXuoAT6VeDr
	HVuSFxuymdMwRfsBywCv9MXm6fl5OTd7BNWyky20kd1oysVxVRn2HkM1y0onnlTL
	brJAsia8VZepycP9mXshbkryi3kLhxbHDwxDNa75/B+gsCjF1qy/RFh48eA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u90fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:24:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so1415667285a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773069879; x=1773674679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT0QxTs3w4onOwpcb/N6xWIFXq4k74USa4Ia+RJ4IcI=;
        b=Wl/oIEIjkvaMJU9P5akmev2x3UEGnOFsSNaIC0L+VVkqiJI+XRW/Xe86klFNxrt1es
         Xis4VjPiHpxZI4gWw9Itt2mc28aZOjhJIFcI94blq/wKbNQR7Sz9m8+xPViWb05ow6wx
         NX4GIVjzBR/iKeVZUWngWX/cxHQjWnopD2v5b+8xDtPFWZ1gEgO2rD+yUXDbLrwudYTh
         HaYgofe2Ol00lK+YNhboonJfW4ncCs8Xc3chqW9h+wGRAc1D8lKN7yJ6/7yrF1smVyuK
         4U1BuG7xiP+VQD2Ra0B25+iI45kekPn4Lda3ZFVPiTb1aCUJTzZNiPaq0stJCylDk0WK
         hEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069879; x=1773674679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fT0QxTs3w4onOwpcb/N6xWIFXq4k74USa4Ia+RJ4IcI=;
        b=MLpxU+65YPb8ZZufAIgggdnwrlD1hk/dQyp17Fy08B8MnwCPr6xYF2eDiH9vpK8yJ8
         lPFwUBFETzcne+QXzsE+f04EALIu45I9Dx8yzhBrEhURX892ny5hw3KO15uH0DHGyiTu
         jNDcWLBniIweMmQ/moQIaBluRPuZQqk+a8iI4U4ctmVQBeMdM3Lp1NTNuaDzTWx4vDZ5
         fpKL4sF9vbiowKaydL8V07LdQAgVJVKYRqFunp+/ZGkVVuBHSoHN8sbj8uYx0jBTivGu
         zB3eSEpjG6K3lo2L77BXc65SlveizeqAKQyAAhaYCIIj5MOT0eoZm9Py2Rv0rCYIccP0
         m2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWI8kKRXFR0eXI7IzB5kMEC5hQThVXrZcWmy2yQOejfWl3ayFHn/UO33VzRwLSuNee6HHNTBpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hhKMGMK2whxoi1/F9lLgLgXn/HSNhFRNcIyjL5RMim41JFnF
	VlN50NfcTMAVb9ylEHMt8F03SDpIAmntMh0mf8gUMealHClf2zV+HlZsHNOXm5REMgmmGtdfBQa
	Qhb34AuoLVnLcH4EPaY+C++e4gfEHkQvSuigPTP63N+Nr245N9hMBhidOD3g=
X-Gm-Gg: ATEYQzxsLyohOPYFQdpB9ZXQM9W+PSapQmx4A/ofS4utX1241EZxtatR4cBdnCTpv7h
	WvyyHNci044g+gbPniyxL+EeSjhf1p+565LD7CEs5OSrolyOEqacEhySsY2F7Wn/H4598aBdnEN
	TOvEjoSNb78CcO0S5ketkhpPS3d3GmmonUWeoLQf1wWOYSskJ+DNd/f+xgqFADaJFkzSWp9UzUs
	T2ZdF/wV4/AIQ/LlcGl7RysEdw/RxusadCN3anxlIA8hBgJMn+zbZVvhla+VDgvCQyZKEaENl3r
	q8ecp2XRgV/5QAZv4OAReDOsXvlWWE5EUZL5oFP9ljByoy8PkFWj+5yvn+RMxA0O+T23CD7matp
	iv5d5ZCmOnyB7elEhHdwFrzLkl/VTTxBUNryVishYmCT9HycRa+8nu5s=
X-Received: by 2002:a05:620a:480c:b0:8c9:fb0e:ca43 with SMTP id af79cd13be357-8cd6d3868aamr1381785585a.24.1773069878690;
        Mon, 09 Mar 2026 08:24:38 -0700 (PDT)
X-Received: by 2002:a05:620a:480c:b0:8c9:fb0e:ca43 with SMTP id af79cd13be357-8cd6d3868aamr1381782185a.24.1773069878230;
        Mon, 09 Mar 2026 08:24:38 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a59fc36sm192812515e9.9.2026.03.09.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:24:37 -0700 (PDT)
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
Subject: [PATCH 7/7] arm64: defconfig: Enable configs for Arduino VENTUNOQ
Date: Mon,  9 Mar 2026 15:24:18 +0000
Message-ID: <20260309152420.1404349-8-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: klncD6a0ON3O8aGfyBhhmPKt_ZA87YQm
X-Proofpoint-ORIG-GUID: klncD6a0ON3O8aGfyBhhmPKt_ZA87YQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOSBTYWx0ZWRfX36/81Ome5Hrs
 M6e6GTUl5lGmTHqi7k5CiLNLVPQYB75P0w7AVJnj8uDZPQr08ouxOfpzgvatEIu1gEU2f3j8HXh
 PRqpWDP4ADTbCdszuj3Xi7S6KwHqdF79GOoJJGxdghD2ggXVrRwS/MKYB7WE7/5UTFuibvdUywO
 6xj8eypma68iubftE4SJhxV7ENAvCc7SmtNcoI5esfSdfR4VNLMRMkQ+rqxkPP9785BbjFZf4zt
 79VfjKnku1ezU+WFz5F4+JN9wzhopehxI9vj/02h6p32oFe7RMguRUfSnkRad4UL3MuJ0lBvS6P
 69rhYiI62zRbmpU+3UouuXWIFuEl1+++TYiPPkD1UBCXJzQilyymP+mwBNgwcLyTe19uA+G9Qdo
 vpNORp/jjUSebQMnuD2FSsM0RoQ3k78jEtCjq61oqntzaSgagoIETr999UiyTpNFVr1wk/Xx0D0
 7y4aEGQYKjPsOA9laXQ==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aee637 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rO3wVDe-YCVyVCuK1RsA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090139
X-Rspamd-Queue-Id: 270C323BC7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265599-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Enable ETHERNET PHY and Analog codec configs required for Arduino
VENTUNOQ board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4ed70ab7ee85..aefb8a81b78a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -416,6 +416,7 @@ CONFIG_MARVELL_88Q2XXX_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
 CONFIG_AT803X_PHY=y
+CONFIG_QCA808X_PHY=m
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
@@ -1145,6 +1146,7 @@ CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_ES8316=m
 CONFIG_SND_SOC_ES8328_I2C=m
 CONFIG_SND_SOC_GTM601=m
+CONFIG_SND_SOC_MAX98090=m
 CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
-- 
2.47.3


