Return-Path: <netdev+bounces-282351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKx4Ohzj8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB444493335
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7866C3017D41
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665FE3EFD06;
	Wed, 29 Apr 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ll5u/ufO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cI5CrIze"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D33EF650
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459955; cv=none; b=lfvheTzmWZm9fxpV2NAet88+iXFLkRNb3jywUAL77o7JzvuscmNp6NV+rFgP/heGT/Qb5RDJ58CswMVN5DRq2oDCOe0Xc0Obf83Gc8RMb5NIeT4W3NeFfJsByP2rkCjCH4i4M96ZHrlEDiLPtqITwNYC2F8Oa9ZB+UMoBM1meIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459955; c=relaxed/simple;
	bh=hpI7Hg/aEZhSjGdObruRDwA35829K1m3CN7LKanOqs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clcM16qXuyQFAm8w3Lhrr7V+6BwrfU6Yyt7tM34uphvEX7do3ZfmyK2NYawruDoXaMcAx6/vz02lHCkR1LfqbreHgYV9m5ri7LG5vcq/3DsTZrNFGirPIgMK4+ude12XIPAzdKIXW/1UvH+dkAfS14sWtqwp7/OBq1JRSxxUphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ll5u/ufO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cI5CrIze; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pnJL901616
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nD929g89ZCPAv1t5vqTauaakssk3+hyDU+nP/UUmTpo=; b=Ll5u/ufOibdVwuSS
	Vw2k3UCUpWQIXgX1OsJorgkApyI695foA3qEdhqJlcEV5Sfo90SLtVQcx0i8AFEa
	CPHYGUqKNxodvBsoXJV9vbuMx9o90Rns8hkiK7elj6bfnrMRwqdCIYghwCJmaC6S
	05cRUaQ9USzJ8BIRy4XPNEJLtUPGLCI4ypCVbrVHmcBPN7XZd2rB6iwxpg//ftEx
	Wwv8oZ17CfqwihU5s5uNcoZOXFx81dyJEecQ/dfqBoTOar5Ms6gukfV6pLR2BLKh
	5QZWZ6F3tlaDeFRbYqSQw/gYH6b6p01si2txilo/uO9WDPkkO6nolaQKw01K2B3L
	ckgC3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9hb6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b7c904d476so47370595ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777459952; x=1778064752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nD929g89ZCPAv1t5vqTauaakssk3+hyDU+nP/UUmTpo=;
        b=cI5CrIzeoOfL0bnfJjfg98So01vSzkbbbGU1/pBSev5rHkv9nFHc8Mi+4Zjve6Pppr
         qOcfZnrvGX0+2A81TSYqzCCmZqqvWWAtELD0GJ7iEUa20pNZnCYpcMAPucgbId0ILVJq
         SLdEKSH9sX0yuVJiN1OV0NqbnZ6kmmhl4I8p7OqYR1dc/J6Fc5V7g5GEOWz9lNuupqxL
         fpZKEPbinpa5+u+v2czzgVyUxmpSyEFY4y2YNjNOiYmxge29YgLiINpDETbT1N1YpTVn
         JiUW5uUft4wlz2KeV8edIlgmXvTH52PdC48skc9OmhUedOxCunH7+cNSr7qI5WprrUNU
         RGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459952; x=1778064752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nD929g89ZCPAv1t5vqTauaakssk3+hyDU+nP/UUmTpo=;
        b=YhU3n46+DKmYB93M8pY3QR/yiWQFoNal79Bbk0qN2PwKiXb2lpq4+QFA4BTKvRI1gQ
         6WHhH0USXj4HLsBxcwq/XgTbVKU6lirakzG2cvNQbvczEbYGa0RDY5c3Gbhuwdv/xUio
         QxqkNk8E/j94zkPgcfPG4LI4Y/4B1ToF9bkWTCiIAVV1Aj/ntUSSVPnDnt6lr2A41zgx
         0SppB1Hb0Uros+JHgJbFMvfrGox7LpcaOXaN5v0DbZ7XpV6dg3HrPd+O9+q7w3e117Dm
         k5cUnmOzVdlayMX0Y0y3rUgm53O66yzaG6ny4ODtX/VVDSOpf5H/UttaIeR+mz5sNs0l
         FFgA==
X-Forwarded-Encrypted: i=1; AFNElJ+r3OlgqSTB+tZWevOm+na/pfUUXzJs2s7XAK9rSbGcZC6QV+zWXzMhrTTr62qz8S1E639PFqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzeVu0S2bG/pZou0Wsagt4r4Ms0o4Xl7MDMvHlBgTzcEPKja7
	HWkn+IhMuY2F1M+pOmHaIdlTR7Gn99fDpYiNTPSQaRUO0kqBOpBlYiuA3DSiJNTCOtH0K7NpPVb
	6Oum29RNDMBDK6c7fvvGihzdt8qlOYX9vubX1c5FhhxZ+sm0IQJmAN0F8vxw=
X-Gm-Gg: AeBDieu0rk7fhnXUhRNv49RVUuR6gLqG5/lAapUgUhzBEWD21aXJV4t6BxPGulCPrdO
	Y7D8tr5S2LfDYwiwBdDDs+jwGDCOroOvePPD4aChgD/yxxszfMlI2RDiyPrrRx9QAy/EpnpQHeR
	yNj+ofnwC6j7N9Mw6PpLywTvpQaxN/5Rrmj1IULU4M951zSAmGLjYPcoFk5dQSGPhuQyrwwL21A
	cPrtYuFTtTCjIbstbAB2Yrw0wZWix3SxRF1YSwUYXcLzrE8DEtDI5SnkrfV45aegPDF6B9eLpNj
	FHGavgqXbOcW64un1DB4EV8cum19puLLJQZdJG+gEksfQv074sEZP86yVQ2Z0z+N8y6zLlesxxm
	KSv4d0ikXdr8aEUrxEFY0JmPgi8Wz4qr3teETp0MBAcWICtQmqzSuwO84ThvLfFk=
X-Received: by 2002:a17:903:11d0:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b97c3df3d6mr68504115ad.1.1777459952254;
        Wed, 29 Apr 2026 03:52:32 -0700 (PDT)
X-Received: by 2002:a17:903:11d0:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b97c3df3d6mr68503805ad.1.1777459951717;
        Wed, 29 Apr 2026 03:52:31 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e9csm18316715ad.9.2026.04.29.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:52:31 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:21:53 +0530
Subject: [PATCH 5/5] arm64: defconfig: Enable Qualcomm Shikra SoC Global
 clock controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-shikra-gcc-rpmcc-clks-v1-5-c3cd77558b7a@oss.qualcomm.com>
References: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
In-Reply-To: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: RIeMZU1owzdk1rULFjQlho99hXpasFi5
X-Proofpoint-ORIG-GUID: RIeMZU1owzdk1rULFjQlho99hXpasFi5
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f1e2f0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=kW1cseVQmWd4RU_XbDIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwOSBTYWx0ZWRfX/NX2tuPTX9qO
 8s0aYEQQIX6bMczH48kEDdENOTG+oJf7llrV6UyDc/QSQesReRIgWFn6ASRH2tssCgP5+5uUUf/
 moRCInf6ZU+aNupQRhl8922h9XbuF5vD/oshQvzDeu+GmQG0JRQ4XDJb5zBDu2JYaamr8ta7lxg
 BGs9e6MTa+rxfXiaLrNsXmkQ2lLeDOkMF05Mo9lD+igfPhftKdophnIi+bIGg8ej5znmivmNaw/
 51QMk3N2TWSlvItj7yY3A13xf1ovlhN+J99dR+e3hoEhK2x3HatU2lia1ayNP4iQn7JzgpzRQoO
 lo+pIU2D4uuwxdtZ29Tj4w/Aqlnl8f7PLeQbG0MNiW3D36WMvXfJ0/WKT3IO20OTJxxr/rO+5bi
 1ZRzN/jgPsYkAGVgxN2g0zXPaO0zR9m+AQsOV83u9h/5WPUlFjaJH5T87hQm3HexjQYElzodIQC
 UHWifaYRWaVG8wfpAcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290109
X-Rspamd-Queue-Id: AB444493335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282351-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Enable the Global clock controller driver on Qualcomm Shikra EVK board.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dd1ac01ee29bf631d517c38486f6896ffd82dcc9..13e04080b37160129ccd47b0148a64277b8e0e4c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1461,6 +1461,7 @@ CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
 CONFIG_CLK_IMX93=y
 CONFIG_CLK_IMX95_BLK_CTL=y
+CONFIG_CLK_SHIKRA_GCC=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_MT8192_AUDSYS=y
 CONFIG_COMMON_CLK_MT8192_CAMSYS=y

-- 
2.34.1


