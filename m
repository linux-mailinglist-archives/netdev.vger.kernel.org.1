Return-Path: <netdev+bounces-244102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA8CAFC2C
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32386301E5AB
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06364320A0D;
	Tue,  9 Dec 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ed3abrwY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLy57Rld"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863693019C3
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279549; cv=none; b=V7zfQGM+05shLu99uGxrunoI0G8D7fqLjHLewuXHDwEDsIcTLQGbl6iZ/YLApdtJks9MLLoQphbbilLJ4IhVx7neyjEAPA5e8Gb4EUhZDTxli0nF4WgOqRzKPvqHuF83T/aFKBUeHBort8aIW03Ei6Azo7lLampz41hk+oCzvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279549; c=relaxed/simple;
	bh=DsiJN+x8Fqjt+HlhEmfCrebctPNMtUSyNZcOLLpnAeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZH7eI5qdx7Xx+8dzxqR7RAJbDOI+yX6JIgkKFOfsJc2VLPx+Ny4PE35J0tB8EGOES21w3IrpweLV3d4ivtfw+Snp4HCwpzcry0fc28af3z+qslnBRTSjk99O2idiiD+btRbsr1o1OnBpL+OJ3p8Yh8JVEMARvnEokzsKptTu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ed3abrwY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NLy57Rld; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B99lFch3347681
	for <netdev@vger.kernel.org>; Tue, 9 Dec 2025 11:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VsBgdJ+ubxIlMlId0qH8F8
	slq+A2hSv7BDe8MHbvG64=; b=ed3abrwYdom/+eT1rno8AvMC74c5yHWsG9C/hy
	ho3/zxuCilqP6vk0IaIj4UhPnEIrbjC/EQ/HTJ+HcQRXnnBk+0533y4WYJRfTWNG
	LEJ8Pd5Pkjo8yLBT7Gg2y052xsc/ZdEGS1XnxpktY4/vgzGnqdkC/FOVvppg01gb
	5L4YO4rqqrE2KbmDwR0LCxiwtrt+UMRmCYILJ2kvgqjmLbHHuJZYh326nx3t2eJB
	UjBGQlKGe1X+l6pVQKs+HaD2QSyUN2X3FULbgFlg2+EEGbahcmQ97GzHRkAQz4tv
	6m4Yba7fjpPHgERsLoXX6jtntdM5vNB5+rFKjwHU2SqxH9AA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axherg96w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 11:25:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so3558195a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 03:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765279546; x=1765884346; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VsBgdJ+ubxIlMlId0qH8F8slq+A2hSv7BDe8MHbvG64=;
        b=NLy57RldL8GFo4fF5L7S0uFnYQ95W4Ojn1T8GJXhZtbRnx2oFYLEXXEgaz56Lkhp0Z
         BVOPOD5X+cgeGMyNE0qkhdDDN8TdL9K7muLVwZZmV21Oj2Q82x1qq5VHZa4d4x33ihxu
         19z+ImG7LQ1COay5bN/99AGk31bpQw+NMwFPJtsX3yaHjBvzbVOQkkU1tL5ayZ+QpaH7
         fLp+ZQllI1JEgLAl08WF+kP8pxCkEWBfNQ+T/z869bAmE9z4kwt0ugQ6+HRSLSkEaaJD
         GENeMafZhCYknExRoQ9N1BUjrZLRnlrVCy9zrt4zIedBoV/in6XqjOmBc9/qcX/wE09l
         EPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765279546; x=1765884346;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsBgdJ+ubxIlMlId0qH8F8slq+A2hSv7BDe8MHbvG64=;
        b=jKimsRsWT13sa7oMwb3U5v+y/GQf4O9qVhlVQpY38/IojuNX7cUbi0lapBHKZg9k4e
         Ou4eYjPnSrmLLfTlM7mvBh6iWxtrpEXzEaaI9XVppT8B3wa7cuEBpvAwjZceIc61KO+G
         n1lTrlXNMm629kTQ+kD+pWSPHhvZ5z9Mv9jDPIAfUAhleVUZ2uTVntFcns4qE4GMK8do
         TtCQ6ZkA2V91T+MxVtWj5CoK047ri8Gby1mag4AOtK/txevPxCthYF4MENKH11rGtQ3h
         QOUTtNhwlOsKOL0O9GxK3AlALcLKHn26iSFuGl4ZuWh2uFvYTusiBDqO+O6U7WhfBD1P
         dAmw==
X-Gm-Message-State: AOJu0Yx856BFLlZeoRO7HcXfPrJITqA7IvrfHXWRpf7n4wpvrXxef4zY
	Kd8tVcSJwC36T7j9z84Fn4YFDYL/sZcT928rLoChpFwzheI961e+m2um2jjIISgasSYMjZfBRU+
	z7+vdgjw7cHjuJUvqEPAJTqNWRsd+jP/COx53yuobJ/4o6HJFX3v10F6bpvJKzBPQ2xo=
X-Gm-Gg: AY/fxX7aMwa8uys2qqM356akZ9aA9j550TB65kxErTGrv1U+vrGRsFvI3hejCydhGwZ
	YbxUzEG5uqwb1segJly8fiEelf1qM8IA+MFOWfn7SnOwyG3ID17slk1fg1OWdzPS3F4U9BdI9bd
	LnSOgWflDw28DLoJ5jGqrtclB4Yj9RLzakp/hDS+pFPDN+amOSAcIFEsFYiB2KNvLMODhEbYspj
	l1wa/bVQ9qmM4cWZkgumzHuFh6wSvX1VAVQvsHHebXKUNDcziZgIS4IXB7BzPQsY0m3d0y5HL07
	ya2kHeaW8K17SeGA5fIhtaJ7jL5m679YErSqe35q+qihLiTlpNsF0e55ahfLIihVpeuF1p+8XUO
	VpxLagE8MdSQg7EdslDhMB48oJyDTCtYBX/XK
X-Received: by 2002:a17:90b:1f87:b0:349:7f0a:38e0 with SMTP id 98e67ed59e1d1-34a4f8bc3d6mr942782a91.17.1765279545542;
        Tue, 09 Dec 2025 03:25:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGczqed4JYXeBh97lxyTB5anIJMDGPxDqMP+bWLrjssFzZu758BmfhApm7fzoyy9+J7HleFog==
X-Received: by 2002:a17:90b:1f87:b0:349:7f0a:38e0 with SMTP id 98e67ed59e1d1-34a4f8bc3d6mr942765a91.17.1765279545080;
        Tue, 09 Dec 2025 03:25:45 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b9178csm2135964a91.12.2025.12.09.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 03:25:43 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Subject: [PATCH v6 0/2] net: mhi: Add support to enable ethernet interface
Date: Tue, 09 Dec 2025 16:55:37 +0530
Message-Id: <20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADEHOGkC/y2MQQqAIBQFrxJ/nWCWUV0lQiKf9TcWGhJEd0+i5
 QzM3BQRGJGG4qaAxJF3n6EtC1q22a8QbDOTkkpXSvYiWSTjcZ3iV53BuZnUiqWReoatagdLuT8
 CHF/fe5ye5wW+OMAHawAAAA==
X-Change-ID: 20251209-vdev_next-20251208_eth_v6-c405aed13fed
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765279540; l=2389;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=DsiJN+x8Fqjt+HlhEmfCrebctPNMtUSyNZcOLLpnAeg=;
 b=yCEy1+3+fTCjhl2Y2Mp6zaC9Tm+MeaGfiLGbPV1B2s+Yc6xPUPOrHwQ3WONSqCqgIxIk9Lv5t
 TKTiGS9px4PC4bCbXD84RTbn8ojO9JSsFabbiY8oCUER/apsllhZMPP
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA4MSBTYWx0ZWRfX+uByxVnl2pPI
 ZvNg5D6+msnhE5cnn7glh9mejKOdAcaEtoD9jgZbGd4o7Ga0vulcQN7yynPOXMEIuglYpE8vXCq
 Hv3ESSj6ZQiKfaj/Emm29f+wRps8E4UBnZ46Vm9rtNyvrrA4geRyyItgWLgaIfEYk5Iw5wNL+r5
 yESRSZU0ZqZCjRjtHOynmPRhe+w9KFA85/bCumtNAvvC+c7EJsCPvqp401eCu+xFeded9rjDhVw
 R+eSSsYU31T4jyzZxbPKQOAnaD8m8Fk8JKACwpIrTN1duuP9kXtZ4pkL+GDR8Q+ECsa0O9jgP36
 QOzldTaDBPRHAzs8GZeDkX2pS6RzFog1R9fKAiUtnZYaIz3XoDjjO8sd2szSKz2QxMBTWtYW98z
 rrBVZOge1DsvLQ7NTjBoR6G00mwfDg==
X-Proofpoint-ORIG-GUID: mwifdczp6ANOhV9eoGe6UHa9yOE-lYt7
X-Proofpoint-GUID: mwifdczp6ANOhV9eoGe6UHa9yOE-lYt7
X-Authority-Analysis: v=2.4 cv=P7M3RyAu c=1 sm=1 tr=0 ts=6938073a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=QULB0W7ECN1Zqye5N6MA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090081

Add support to configure a new client as Ethernet type over MHI by
setting "mhi_device_info.ethernet_if = true". Create a new Ethernet
interface named eth%d. This complements existing NET driver support.

Introduce IP_SW1, ETH0, and ETH1 network interfaces required for
M-plane, NETCONF, and S-plane components.

M-plane:
Implement DU M-Plane software for non-real-time O-RAN management
between O-DU and O-RU using NETCONF/YANG and O-RAN WG4 M-Plane YANG
models. Provide capability exchange, configuration management,
performance monitoring, and fault management per O-RAN.WG4.TS.MP.0-
R004-v18.00.

Netconf:
Use NETCONF protocol for configuration operations such as fetching,
modifying, and deleting network device configurations.

S-plane:
Support frequency and time synchronization between O-DUs and O-RUs
using Synchronous Ethernet and IEEE 1588. Assume PTP transport over
L2 Ethernet (ITU-T G.8275.1) for full timing support; allow PTP over
UDP/IP (ITU-T G.8275.2) with reduced reliability. as per ORAN spec
O-RAN.WG4.CUS.0-R003-v12.00.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
patchset link for V5 : https://lore.kernel.org/all/20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com/
patchset link for V1 (first post) : https://lore.kernel.org/all/20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com/

changes to v6:
- Removed interm variable useage as per comments from Simon and Dmirty.
- Squashed gerrits 1 and 2 in single gerrit.
- Added more description for M-plane, Netconf and S-plane.

changes to v5:
- change in email ID from "quic_vpernami@quicinc.com" to "vivek.pernamitta@oss.qualcomm.com"
- Renamed to patch v5 as per comments from Manivannan
- Restored to original name as per comments from Jakub
- Renamed the ethernet interfce to eth%d as per Jakub
---

---
Vivek Pernamitta (2):
      net: mhi: Enable Ethernet interface support
      bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for QDU100

 drivers/bus/mhi/host/pci_generic.c |  8 ++++
 drivers/net/mhi_net.c              | 75 +++++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 13 deletions(-)
---
base-commit: 82bcd04d124a4d84580ea4a8ba6b120db5f512e7
change-id: 20251209-vdev_next-20251208_eth_v6-c405aed13fed

Best regards,
-- 
Vivek Pernamitta <<quic_vpernami@quicinc.com>>


