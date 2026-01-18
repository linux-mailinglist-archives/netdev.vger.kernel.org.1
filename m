Return-Path: <netdev+bounces-250822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3189AD393A6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 10:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260BE300EF6F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308A27B35F;
	Sun, 18 Jan 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maWNQGlv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VT/7i7ii"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFA1940A1
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729715; cv=none; b=bZMisPNDbSEtY/kjDlIfXyz5XelGqZed5LeLcTzv4uykfZtezGAfre4Y2v1JJsxzmn5PuU+Tw0pb08SAMXKJIWW46IxwSTaJwfztTL6O8msWGXG+qcB7gajfZ8NrVKBUIqyr3vknUvpr+4niH0M1w61JNELMpSIM4J1YKDdMyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729715; c=relaxed/simple;
	bh=Mix7DNYdYIpfrXXAPZ46FQP4jAwn6AwXZITNqiPsW8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJq1+FU5GaWUd0uzbSwvYrtA827ArwphC3mhtWE5CJiL3FpNnVpk4WZ9JaNqy2B3fGoh359uuOVlqxbJfFBCtgsmRPWoBieQwNs3J4WVW0/Blmao2rv/gzabM4PzPIHft/RPK7hhqNuJu8Tw1SogbLFsBYWw+4ZYcqzxwqTeSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maWNQGlv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VT/7i7ii; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I9btAw3247724
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8xPrqRXFK5mm8Ato5KncVJUInGeCg6K/SkQ
	V02EPwCA=; b=maWNQGlvRoWKW9fnGOfDCJAc9iwGfxWccKuhdZZXukJI1rGcEVK
	FHBX7ydAu6UNjRNzw41GFeIYHtYOIU1PSzZibcyI5EMou4OeQIiIIek/aUMcb00g
	cZTs/d1QPuyPFiD8qiLOyr2oEzUHxTQ+fJGgBLgsPweG07zaU8+QZsfZ2lbMKytH
	cF1uE3gDQEUjsjjAdNS7JAfphsNGzLIBqPQk6uBmUYGtxpbsB4j+Xie2vyQSuDXu
	ANZOiJobkZuGXtcP0fNpultKBL8MVYicI5VJN+1NjIL1aOVhwpvNvfvRTiU8mKsB
	0Q3tsGVHRr+QP1orUWIpxJ7ycsuyxr338QA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br1e5jcp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:48:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a4c50fe5so1006175585a.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768729712; x=1769334512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xPrqRXFK5mm8Ato5KncVJUInGeCg6K/SkQV02EPwCA=;
        b=VT/7i7ii0jKA5YficV0/HUYFeuZEGENTzkVWUdJC8JTWetAb1xcxKhqO344BLxE6Jl
         TOvZwbsalS3z1+kbEMZkoFySko8O3LMDCpvnWaKaK+lmHalk91o8C98DRBHtw3xNAcel
         p/XvybQq6zbyYClf4Le9Lme374CCCs9VRHIXsE640Fx9YXMjBHs5rHVL1icNnlmqgqaR
         DaB7kQpB6E11f9Pyxu9W7BNV9yS5iZZMMRSLOouQ87dZXNYh77NEgdDNTHwjowPj1BQh
         2imOBksmYg760TsYBAjx1LAuYsb1b6HFYCMugU/CyW1XfGO0EmVn3u0IzJi3w78ZGwr9
         usgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768729712; x=1769334512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xPrqRXFK5mm8Ato5KncVJUInGeCg6K/SkQV02EPwCA=;
        b=A2fM84fdwOQ51FDzhBijvSx6petrZqlzBk5yEBZ586r7eh26P7Ur3epT0ff3UJ+C/I
         Y1TRBJ15Gj1pIOPd4yDhmOKGFO50EJtNVzC9Bdhb6qaWhzPflDlg7r6ZZWZ4QfrRb0i0
         e+kYzkxNySGw4Z/K81FHweoa1jo13BBfPGBloFLK2tgdPaIQ+eTC1BYAQ96t2sbIOjjP
         m2cufuZ8Prkuv8sHiuaVYEW1c39d62FE7eVP/yAu6OkeQEi5BdTFqjc7XTqjTaRd76Q0
         No7ddYUYaiu3be7dhCSjZbtkprN0g5bbq9D9MNYg8g1Vs3XPVqonkiNC59RPvxgVWJs+
         ny5g==
X-Forwarded-Encrypted: i=1; AJvYcCWcICgGsrKiQAiX1mWPR0J0swaP6DAV29Ck2d9I+3gHJxVthpX9qc8x5thGafm4AyMBHlqc/e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UrkaJcjLGZrwjIcm54iMwpuvpzra7vLoe8mZbh3eFl8sccXH
	xaFYCdSM4DlOolAcHdNcSq1iUWNH+QQUCePhxWNkgEYTX6BHWpfx+Judb8Vb51wGa/hGCf+2oDu
	IMGvKySNKm2P6HgS6sqXvV918c698LyOCGUdYopHIGDzwjGrkrRbzaig/D9OzTc34Vtc=
X-Gm-Gg: AY/fxX4ylI7Q5GhaSYOu+75nLksFqU/2H3u2+XvJa//ZVnSw/Tvl6mX8io/2zwofL7W
	6zDlsGKw/rSvk833jLdaA81SdEKIQQdVF/iS5V/gg04ws2CwHuhR2U1mSJJRDt2kAK5PYm8isAv
	wtd2CymaId6BV7fovgJ4v5XWWWy3VgzteLAaoAcPFpCHqXslz6d94PCHFXFBLXLpSZVE/slgujy
	njyr9zfjDfMWnI7ZI0AC8OeZZI8x5ZMwo8LTFxKfk05WH8lUZrsvS2sTczEtkDSCFolLNyFxX9N
	3X8NT9eGxsUaCcHEJ1NLE/+q8ObdprJVvJ3XUaiJbmiyt64uOobXzm9f6zbqGzMZse/D73nS42Y
	0eJRZK47eQeDYgitKDHILS1qZPQ==
X-Received: by 2002:a05:620a:1909:b0:8c3:6f20:2ed2 with SMTP id af79cd13be357-8c6a6963386mr1071917085a.84.1768729712205;
        Sun, 18 Jan 2026 01:48:32 -0800 (PST)
X-Received: by 2002:a05:620a:1909:b0:8c3:6f20:2ed2 with SMTP id af79cd13be357-8c6a6963386mr1071915785a.84.1768729711752;
        Sun, 18 Jan 2026 01:48:31 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe6307asm57528025e9.7.2026.01.18.01.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 01:48:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mark Greer <mgreer@animalcreek.com>
Subject: [PATCH v3] nfc: MAINTAINERS: Orphan the NFC and look for new maintainers
Date: Sun, 18 Jan 2026 10:48:23 +0100
Message-ID: <20260118094822.10126-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=Mix7DNYdYIpfrXXAPZ46FQP4jAwn6AwXZITNqiPsW8s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbKxmsIP0Npgmr0xr4dfDnuyT37Pr8icIRsml9
 fAsiMQVTxCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWysZgAKCRDBN2bmhouD
 102+D/97qg1FuFnmldyusg/qE7R8RqHTh3/2G/GU3SAYKN6wb7C9PAEIcx9RxijeGDmTv6ll649
 5WosKCob65nxtvZhuoM3/mxoSnzfZ27BxpT013t2OaYRMavz0U+y/TKa29vJTguak+YmoeZQ84O
 bbwLFYZNYT7Qg4ZZgXj1KCA9pSBbyOS3sSOcsLixYb0qsVl824Y2MGm7lwyJd57VaY4u3uYQnTG
 qmexhG1GCIIDDIFsBg7VKL/lej7HkTFEgYS25FcFWpuMC97CjBT/XEhEVreWv+zGGBYgQAfmwgo
 A5C/pHZfpm6+HXgWhwjjSR5ZTYVaxllXRFDFObI1PCBPt4X9OASXXlmDGMnBcSjACANDuDs/ZMG
 sHtgYGb/yjxW7+XujARscrgU7avorIVlfXBctjdg7zYq+ERMfmDm2Qx0C3Go1xUQbcCzXw4Xvt1
 b1Sgue+9/d6nGQoYkamj8Mukj5XbkBrh2qhCA7Yq85lsXyuTYLZWNw6RjQE1YLq+j63fTsONLMe
 SwFysI+ISoQqmSCBq8uZphn3Q+KXq8WivynBEiis140/MtavYO0ikx/VR0BswF8tbCmaN/t4Mhd
 J0o3Qzg5EoEOmml0qf63PqBj1T6Pl79Z7C5QP9Uo9qEMYfMy0Px/+vVdugSW2SRvo0vwkxIhbSP SN0lyVs22Pvl/9g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDA4NSBTYWx0ZWRfXztVnXQxdWQrD
 hqZ2toccqxnKnFuYhVDrHXnSEv4e/D1D+9b2OVusAJA4zcuF63kkurYcelWnZX92DV92+fixBFP
 miXqsn3WeigleQ2ofx17Fy+oMS5cOjWQq6atdwxWl8REn9BAyiG+a0kuziRvZFWi/54mPBdt21J
 jyUV+jludTPFBLxkPg/p6jlyhPCeSy8ZHIJ6B2mBq/PCiNGY5Ztp+kgTLsrYAjSZg3NnooSbM76
 gO1x0wXHFMZDn0SUDZYse+ruTk6/qqhJNmU8pyQIZM0x8C7qhqaeR8Zj8vgMRZYs7rGdM3s032S
 GUyNFtq56w7HoPY74XPxVVFNHi8whUpqTujiy1WOXzjfnwMyIVmkNY5JsoorUWPEgXXJZ21OTiW
 MqjxS0rRM7ULYDoGEP3hvvxZH3n7Qvysw5dL2G8rSQ7bNYxxT/6FfZkmOUjrtjpWDle+b9T8S5Q
 qraJLmsS45RZkGqE8Ng==
X-Proofpoint-GUID: aWUlJDiwLjfUeGnuPXbhO8vdrSbVAasb
X-Authority-Analysis: v=2.4 cv=U5yfzOru c=1 sm=1 tr=0 ts=696cac71 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QYXpOU9IAAAA:8 a=j54Niaw2A8URRynr5ecA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=EP3QPQphjMYIGEFU6_zu:22
X-Proofpoint-ORIG-GUID: aWUlJDiwLjfUeGnuPXbhO8vdrSbVAasb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180085

NFC stack in Linux is in poor shape, with several bugs being discovered
last years via fuzzing, not much new development happening and limited
review and testing.  It requires some more effort than drive-by reviews
I have been offering last one or two years.

I don't have much time nor business interests to keep looking at NFC,
so let's drop me from the maintainers to clearly indicate that more
hands are needed.

Cc: Mark Greer <mgreer@animalcreek.com>
Acked-by: Mark Greer <mgreer@animalcreek.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

One might argue that poor/non-responsive maintainer is better than no
maintainer, but I think it is better to admit the real state of
affairs, so people would see there is a vacancy to take.

Changes in v3:
1. Clarify credits - maintainer (Jakub)

Changes in v2:
1. Add myself to CREDITS, this will conflict with:
https://lore.kernel.org/all/20260116175646.104445-2-krzysztof.kozlowski@oss.qualcomm.com/
2. Add ack

v1 was here:
https://lore.kernel.org/all/bddcea45-388e-4a97-a404-c193e915eb77@animalcreek.com/
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index ca75f110edb6..9e852b0fee40 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2231,6 +2231,10 @@ S: Markham, Ontario
 S: L3R 8B2
 S: Canada
 
+N: Krzysztof Kozlowski
+E: krzk@kernel.org
+D: NFC network subsystem and drivers maintainer
+
 N: Christian Krafft
 D: PowerPC Cell support
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 6edc423933a7..e98855ef1899 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18523,9 +18523,8 @@ F:	include/uapi/linux/nexthop.h
 F:	net/ipv4/nexthop.c
 
 NFC SUBSYSTEM
-M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/net/nfc/
 F:	drivers/nfc/
 F:	include/net/nfc/
-- 
2.51.0


