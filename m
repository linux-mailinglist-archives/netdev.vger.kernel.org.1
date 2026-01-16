Return-Path: <netdev+bounces-250592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908BD383D6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDAA309145A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1034105D;
	Fri, 16 Jan 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="COjtgShh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HRLVi0CV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D322868B2
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586745; cv=none; b=rfyg0Ehq1ZtphQTSruqNuzJ0XJtBsKRsb215NIFBuS+/oc183dyGwHAQQmAg9VjOBkEkhZoXaE62/LAI9r/HF9qF/MrhWxz80fcNNyESMIWI2s74J9pXV9ckvQzCr/PqBiaAajltBDa9i7Unfd9YqVFGe25JeZDKVqPKW76WrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586745; c=relaxed/simple;
	bh=wyBctZjhCXqnxRRF6cn+0ZwXD1cZPqH3k9DmhIA0xSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iB+HPrKrKXRVC+177xLY4F0g5gliiAL6KLC1mJXDUnP6IehjpKND2qjUyrL2f1HDuQdGptLXAxQ7lEQEefeSj4ytf5zZA7r7tGVRX6uAvdkZoXIVxKQBNMHNO3bQU9AEisu2r+PXFvtibWrWsh22qzJdi2IdGDERk4QEdaSnShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=COjtgShh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HRLVi0CV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GFK39c2819045
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pyrGROWRjUTsqZTjp33Or36XXJMN3jk1cUP
	iESYP+FM=; b=COjtgShht0XD1s8yT8NfQB1IWTexLfAiW/Lbmx9Fgl9qRmTB+Et
	/eBrwplyKzxDZyQstR3ac6KFwv5UW46l25n3jW6rMH7o8c5Fm//QJ24tw7ckiMKH
	kHBMEr1LyVCRv9MBB1BvGnui+YU1B/xUd3SYhMTvi+ZJ23t+ozahLzKDuq3CABh7
	73DIK0hfKfEkXgz60ovSo3PTHa1KV4qnH4d0gYfacjpzyJwZghQ4e64N1GImHdpR
	sCd2vEI6mdRHArZ+nJRoRAiKs09p5YsMYEDuKM9U3WnFr+2h8nvA6N7IJ4LYmv0l
	aUyBoJao5RsAPQq3pqRwLDOQDns7N+bm4Sw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99ak4s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:05:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c2a3a614b5so573768485a.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768586743; x=1769191543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyrGROWRjUTsqZTjp33Or36XXJMN3jk1cUPiESYP+FM=;
        b=HRLVi0CVY0BFN+GVMo9mlKEkTJPRc/cozULh3uJT/O8KtVJ0iPL+iwzRKsPB6tl3jA
         KzhKbw0qOopK5v4vuCu6UIvEFinQDTfHTj5XeqGV7brhCjStfQbFkEK1E/rU4Tn4ARjV
         sz00DKlEbV9QC5vPBo+uSTLq3NKbAwQeJRpa0/3Mq3SFtN//37laAulpM2Yzv2SNsJPc
         BjLk3PVIDuzsfWQqlyYQsVW9QGpnw/SEM34VBxxR7v6kJJcKmeu6J56x1xDo88zMXqxm
         wEzOTzrg1LWdpuZkJq7hn0SX5jqukEHNrEqzihETgPX9vEH9U0r/29Cz95ENCGc/XzUV
         TR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768586743; x=1769191543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyrGROWRjUTsqZTjp33Or36XXJMN3jk1cUPiESYP+FM=;
        b=UMVYG+Lp0kAoHJ4ZvxfFAStF/dzZCUPf2pkTKIltZh7zGvD9OCRCs2WhTZphxyn3Ob
         6MvPCXgcWlMh4iHDwfI+g+kRZyO8v3HM+3iaiAyejWaEKj3Vd40/ILiUwj6+wb3aJdHL
         7MBebSIa2txWCSrtOgzMt3gBQcoO0EpeX8/l2FgeyzYp7byfeDNi3i+GP4CHkW9rUsFp
         gn5XHtiP5pjI7V8ES6ZK9q+EaY95/zsMXzrNJsu4TW0oHpQCZx7CBm4UVpD9NTNNFsGY
         dbwdArXKF+amYA5n8cTmHUq5dJs+yEre4TvxaFFgY1bYGN9KCX9er9PEYutgfBItW+Rr
         SfwA==
X-Forwarded-Encrypted: i=1; AJvYcCWOJZjdT+9FSH1MfOzCEYdVEcxzMCKu9QZ2/yrGcH1Tw4G63zdRWu493ooJPiWOfVVFAwx6sO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwS2e8tG8dRpXRshN9Chho+oaYoOY2q2IfMJrtmLJd/BVZKVe
	aBh9gRDaz3JUNAINfY/yh40CLC7oKwIq8zFEbByAMg5J6eZ+R9dHQNbGOcZl7lrNReWBzlZ0cGV
	mllzzcBtSFq8DZK/6wWAz5gh51DPpZKcOmtnnd7T0GjgoSCyO7YRMt9VKLQ8=
X-Gm-Gg: AY/fxX4WiodzYAZ8PkbcMvPxMB3O8naHA6sKTQTFe7k6YooW1W4qQdGq6M3M7g2F2/P
	++ctDnh2jefkl1H35P0j0EnHVf4AeAdKX6yxg8vrwfSxdk4K5Aa0DTOXzf34e08JfiqFx9EHff3
	gy+JiB+P35l4rt3S0HdkYGWWyA2FMGCKw85dBZQTRWAFqvFPkgxMoAFd579SvGu+eWzS6s0+9R5
	nyxSMINemfAzmBjVbf2wfv23Maqn0kZruy0qPdb5Tf4MFHKZF9Qtueq82Rhw1YHX8J65YamnNZS
	vfkCNYimdUhUizztV97OR4jon8E/SzyOYrvzGduAbcixy3EXY5xKyiXGbLmtIBDW0b/I6q1t+Hm
	K9DZW9KoN9XCPxQC+KKag1nZDSg==
X-Received: by 2002:a05:620a:450d:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8c589b9791dmr1176255385a.13.1768586742572;
        Fri, 16 Jan 2026 10:05:42 -0800 (PST)
X-Received: by 2002:a05:620a:450d:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8c589b9791dmr1176248585a.13.1768586741990;
        Fri, 16 Jan 2026 10:05:41 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ee5c3sm24129435e9.2.2026.01.16.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 10:05:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mark Greer <mgreer@animalcreek.com>
Subject: [PATCH net-next v2] nfc: MAINTAINERS: Orphan the NFC and look for new maintainers
Date: Fri, 16 Jan 2026 19:05:36 +0100
Message-ID: <20260116180535.106688-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=wyBctZjhCXqnxRRF6cn+0ZwXD1cZPqH3k9DmhIA0xSE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpan3v+xfzU1d/FMAih/synKBxwgmDjrlDM3fAd
 4DAS8+E3KqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWp97wAKCRDBN2bmhouD
 1yJ0D/44odYooweZxopHUIkDclaaoQW099CEtR0x7wKAoJdGGofA/neg4dyRpwiAS8lYGqhOmMq
 2JW55DfkwwG1eiyToPMMZaDCZHJEUNuvKenfjet7LNkmPUKyC/SHyfXkDxcOtRuthpm/dOjGwhW
 nwQj21LZo15llA85WP+Poy5PBl+rFfNSw1vlKwnEIVX1NfoqvsJ4MArdF0qbfKuZTL/YtO950+N
 i28UTI8TQD40zyBLu3l+0j7draDDYA8pyZ8vt8sWgbbxFQ2dJHQ9/dKqpf9V3fpwYDPhtKawYgE
 BZ/eH5wiHSO4LykD0i46mpjln+U12kJu04kQLU1TPN8halNYjJUY8vodhwm+pAvZkttpsbssCf5
 I5xxMfDaI1AHEaLn8WC7/k5N1Qb6czzwIcvx/TTpJ1XI2VYGKwB5ZLzoP52IzkTtzDL6+Be+lsy
 41Zs5OWPK+jQjIGPMXHxYg/2W9e43BybrwhxixuqbCXnahrg1g6bTdGFtY0cecBMgseY3yFwc3V
 oavtxWihONdWcYHVN5uWR154eUr6x4uRT5HyNMGcf8DjHSVSza/44dLml5kkyDOwiPOGN5rQR6W
 j3jiQ9OaqSQVaYnYqW5X5d8x45aJZnqNTaHvZ59JnM18jrVmAGF+jSy5ma/9/xGcfpbLHtlPk9e Y/tuUGYeiKKLelw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _0Di0bQDO5kvYb_MzWPMO1Fo2FCQbNL-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzMyBTYWx0ZWRfX+PcYvT8UiN5V
 D7KanubvTJer2lmOmfx0aHxp3OidyEvwYNy+DNBhA4reUSKVizAOmop5HyaEEuqs+FFlB+C9Eo6
 ADtXOnWPzOrB+hX5RmPd26AO/tjGT7adhxJfx5zymjkcEFsrvhKicE481FWqurFDk1CYyBMA7xG
 PBSOUrUE5LM1W5VlLAdb5ykS8Z7lyHq68OaXxKVRRZXlvySgcDEn5tCw/pNX6bY//phSC8JzsFA
 xq9s4rx6EQqeTq7HTPICfKKjErHMwhccNlv6NrYZzx2yB3eMdBOfB9sTA2c1cPBbSzW+Bw6H20z
 0k9aEjBQYcmV+DmtuyaelvVSQicxv6kJpJdDqeSZpU48ugrm6XxHCIqOJSEOMBJg/x5CUu2Wk38
 McIxs7RoTSFdWe+VDSTBI12kaDhohzOPInEQRdAVeqLxpvfBQQJxMFAdWOCOqXmTbJ95rDUy/Db
 88ersZc6YfFszKyPvdA==
X-Proofpoint-GUID: _0Di0bQDO5kvYb_MzWPMO1Fo2FCQbNL-
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=696a7df7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QYXpOU9IAAAA:8 a=j54Niaw2A8URRynr5ecA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=EP3QPQphjMYIGEFU6_zu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160133

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
index ca75f110edb6..a5384223f536 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2231,6 +2231,10 @@ S: Markham, Ontario
 S: L3R 8B2
 S: Canada
 
+N: Krzysztof Kozlowski
+E: krzk@kernel.org
+D: NFC network subsystem and drivers
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


