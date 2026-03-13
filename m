Return-Path: <netdev+bounces-267397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFCLAFzqs2nadAAAu9opvQ
	(envelope-from <netdev+bounces-267397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:43:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FF281A8A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6203931FF072
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694E390CB9;
	Fri, 13 Mar 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLteN+d4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A09kisOC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FB390CBF
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398339; cv=none; b=snjffVO/w1TDMstzoaWUG7pugTzRl39/HytvEUhNJQ2yi+nR5gtiRtVxApqW2PQusrmmOtc4tE3YVCXEKeAhjocw0rAjhakU7OfRQ1gaAMm/wNq2HQo1SYEtDIDZjTfDavFKm8YOM0yzm+IekxdaghC1zNY3fQGayMWAMnL15Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398339; c=relaxed/simple;
	bh=+1CkAGQlfKBa2d7xyuFDDNbRSbYkBjLrdPIzj5HUjvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrAQpbg6r/Hdy+IBICibKmj2J9REGEhr8abt0527Z11HwiKCezWlaWwD+yDLAlkUuDI/kX6VQzqz9rvKJ02dfXh1dFd18/ZkCuoXig9HFlukdIUpLpsXOyZc5XzMV9DGVwmpQdwTka7gqpB+d+w/MS7nbRzlqjwRfd7pkIPBGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLteN+d4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A09kisOC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5ta6q4140672
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=K6GF2IwQdB0
	l51Io87rwbIqOiKi5HOQtvyaiDj6u4EM=; b=hLteN+d4siFNl7cbZx2UNk/A3T+
	qdz0oE1JBQPGbv4vvc1tFz3DE+nJ2OXKQFB2AAMup4Updb3zuBsu1n6rWKrDrCmF
	Ngk9UDAJnb0bHjIoDX2/jQ9vRIbYZmubDvGNqkXMTsX760sJz5PfnLPOQkGOgIJt
	LGAP+eRd2Jm7ikCvfFrnrLtbzv0f6ubwshr1JL3zVm93ymTt5cEmEi8FUoGBRYEU
	gYAVRTEmB3BR4npTjv2O6FvRVr5Dgegzx0xU7mU6jRgrwB5C8uwX2rHLPT18o3MX
	68hkcdJHBxVqyQDXO9ThYXpfV+eUUcyL803dGojE+zI52eXXxGiXVV4nOdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn297qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb0595def4so1551310485a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773398334; x=1774003134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6GF2IwQdB0l51Io87rwbIqOiKi5HOQtvyaiDj6u4EM=;
        b=A09kisOCbqlJsEUy+bEz8VquiScsYy5UaCcKpCcO4OUbiSiQGeiCpjkXw2yOlxXfia
         vX6hE2hOFoGZMi1nPK51lzzYDnRr4Xl/AmlXa8fnEyccl0Lzv4Y8VS4deZc4VEtmqWr8
         2A0KrtTFESj9IT+llJYyKwZg5awaxzxhFnCQWYiEQrnYySsTDM36mXLzluAUxANQrYsH
         JotGEGHEBWc/XHSRcbt7tWsKgmeubxUDWW9L5P50eant+WwaJYdMRE0DroZG09dOX8Cc
         8QsNjVZwwOn80/moKTpdyq4nBcDRghNtzXFiYxZulvZZ3vk7zltCdBNUPOW/WuTEwC0p
         EMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398334; x=1774003134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6GF2IwQdB0l51Io87rwbIqOiKi5HOQtvyaiDj6u4EM=;
        b=ghOF/yb8MkOycdZ9cDbyBBsduE8Zv4+Ko+13cBLQMr/1ZN+Bdx3+x1TRAYMtV60LAb
         TM2mBcZuBKvAdWNpxvDh3MYUMdokyIGE7S60fVDRWTz/7ll0b/UbKLWWXlzNWkojOslo
         NOcM/N9QNZrvK0NL8eBhaNWlPwVwzzvG0jui7+h1G/w4S++/jraB6tJlcWNfeQ8LKxS/
         XYR8lX76bPNf5UkjY5TCwM1sAwUthDeMFY8J0sfwh0csNVwHS9sLTcpzXO9QXN4ya+cw
         z9eiv4b+mn2dITwkVNfXSaWyvcRxhQcr3DZRtK6fmb52bKyeSJohis3CuTiDMtbzSLZk
         dfdw==
X-Forwarded-Encrypted: i=1; AJvYcCUvYD3buka9ssKutN2QpzMiyyjpH8iu/KiiAE3ztaBHBlCTyUiM8eWQOXJl80GgdjJ5W93PI5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PaFHL8FgVjes6St/vKoOE+iefRezYQcm/TY6ikKLNyLgqm6y
	uNxb+7VBNHLQSAlu0yRFj+yMjrqD8DCL0ihaE8cH1XsgEuChDLRLGKBpyji9vehI2Z1YOiXcoK9
	gF2GzUbYJzJLkp4qlDkirUbD8LGBnLB50NLuHw+zktjovfLKHUoUttFn1Uvs=
X-Gm-Gg: ATEYQzzQnNo4O95ad9U5W6/THfFxofHpr65ZiZTY/Y+/FpdqgGtmw1Qv7855s7Gqoay
	Xw0mjUCTWn06KCUdwfvg4ZXwUwzcAcx/0JLQuPPGcBqR9TeJrBDzJHlsQ0Hqwl7yNGcQuMRahq6
	yaS0uJANzzj7s5G7LZBRdw1gqx3NAWOVCd7hs/OGZ8TVh9khZ76iKsfQiBnnnepBc8Jsspoddj6
	BNJ9VboSL8+Ym51/87lGh+wbsb3JrhtUxOPhRwwhrCbi+kcyFT5FPtjLDfzADQ4yYID8FW0PHht
	AlCXnqRBy5XTV+MSvaJkK+N0ilPDKpCoqxWdUgF8rvG7yoKby0XnmWz+QgcapSzCI+hZ/oHi3GX
	9oaOwIwSUBLWmcIE7kgXFAZ49tAiGyjAFErUbgfzD/dzYGkhE14ZcNZs=
X-Received: by 2002:a05:620a:4101:b0:8cd:9020:f041 with SMTP id af79cd13be357-8cdaa88d537mr749685485a.34.1773398334034;
        Fri, 13 Mar 2026 03:38:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4101:b0:8cd:9020:f041 with SMTP id af79cd13be357-8cdaa88d537mr749683385a.34.1773398333594;
        Fri, 13 Mar 2026 03:38:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556426be9sm20183445e9.9.2026.03.13.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:38:52 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, r.mereu@arduino.cc, m.facchin@arduino.cc,
        geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 5/7] dt-bindings: arm: qcom: add Arduino Monza, VENTUNO Q
Date: Fri, 13 Mar 2026 10:38:20 +0000
Message-ID: <20260313103824.2634519-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FqYy-6UsxGXshSyqukLR19Um-1734bDO
X-Proofpoint-GUID: FqYy-6UsxGXshSyqukLR19Um-1734bDO
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b3e93e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=cYMVCVoaxOtvnoqWShsA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MyBTYWx0ZWRfX3nTnR2lBmhsU
 ou+DWb9sx3cJE1fTdL3iqjU+jQ7C+yyanBRn/bhDHIVEa3P//OUtX9uLcPZjLyzZHjf/jeUoSYH
 9/DEDziLQS6phjI7foZnxoEhpIBbEJaDc71H/ZzS42gIawJMD3BRzkulZgRO4ro05EuEtd18ZkU
 tNOcZjUpImX+3TWXRtIyjz9mJDiiYE5xFfvYecBeKBsXhRjUGi4NJ+szwgQd8B/OX1SLknrsrmd
 RJ4C4XyYEQ/3YaeAcw6CvPtgoQItqzfAhnzWygKEe2Si4J4A0XvRJ/ypVidHdv9XgdXevLg7iez
 OjcvzQzYyOZ7s58z13jf9OHRkIVsLXYP+3YXr6HxTXhJyUU0D6Zj7+LR0PTMi47ArT6F9oh0Ola
 oent1y7mPHcd0xdG46VhTv8sIDnUuRhOAXobLwFyfP7JSTBfz5998FhiqbrQmijEGMAnqRxcNtn
 mXhJP7Y4Y0WEanC7kow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130083
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
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267397-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 566FF281A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

Document Arduino monza, VENTUNO Q codename. It combines Monaco
based SoM with STMicroelectronics STM32H5 microcontroller.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 153664da91d9..b93297520bed 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -888,6 +888,7 @@ properties:
 
       - items:
           - enum:
+              - arduino,monza
               - qcom,monaco-evk
               - qcom,qcs8300-ride
           - const: qcom,qcs8300
-- 
2.47.3


