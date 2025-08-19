Return-Path: <netdev+bounces-214878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57889B2B9A0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AB1162EB8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A826A0D0;
	Tue, 19 Aug 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EyEyXonY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71125FA1D
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585401; cv=none; b=EmBm0sibOOjIYnzipHj74Jy8HwYPR860YKrIbpauZSRQr4JLYfskAu51QST7fuqgpNvYuh1enSqcAIRa1tng6T8il46N5OvYK/CV/7Nn7GrjK6mCb6q73qbv5VArsLQ3NaMBrLOMPu3eJZ2wYzWQnUM5PdyFVtrV2QZZWWaFhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585401; c=relaxed/simple;
	bh=8rX82cXmDkiy7mxoulbCd1tP0xA4NYjLb7c/ZyHx9wE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lCCbhiA9s3W5Dj/+Yj+wmVLWqptjbo4mS84kTJRq+nrbA+vA6PzavTTlH2YoxUDeCWDO1Vox01TDuDbE21iv6Ih//Iz9h7RhRB3hVF/Wz92fXatYF+xeCu8XWAC35Kh19ncDhWZbX4cN/5GfQvsBWWR7ZuK8QTPNxOrhotnDWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EyEyXonY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INx2Hc001955
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BNDtdStOIIki9xxSs9/BB+
	Gr6oUDaLjPxhFCW+eeQCc=; b=EyEyXonYYSs6oBIqd3Ln5w1LpBUuXayPhDojXS
	NG3ErmNfjJRADyOdJxZpec0t5sgSYnVXjcmQgssv+XIKCSo6Ktz4xCY4FYYpWLpu
	dfHqSkicd/mXXWD+b+RotNQ3fkTpa0caLH/YBCZg4RPJ9VFIJJJi3EzNjn1l4wWr
	e+s4Z4jn3jHVDXotpBwc9YkwHda1nXxTyBzzWdsYK6g64gt54bhYSR9kA9ALF3EO
	wkwoGgh+/aV32Zxy6rY3iP2jFQHqOQMaqULtUc1AnYiFQtK8rDg3ZTFYkwu59T6A
	ADSgjhXywDifKfwj50jTFX9sg3FlAJQye+dlNtvgJ39sA2LQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vje4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so4189320a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585396; x=1756190196;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNDtdStOIIki9xxSs9/BB+Gr6oUDaLjPxhFCW+eeQCc=;
        b=FCk0Rt5k3Qnav4ZHBqwNwHxeZKBaiqIScHqegIcmbiIW4HfPqf+mnU9182fZRXq03e
         8MXGO3BszZ4Zn+7Ha4mNYR7D1wfe3kGX91P1jQZP3M49NZLnAwIuFOhquta7+1vAAir1
         Of2pKl++YyIj9gCoXie5WkMD1igd9+dXxRX9eHKD9jgnf8gQe3jffOXwF4LrXoElXC3T
         FOO5gcUE4r1oZJvjYEUtyesNpxC5wfivFttGxp25k/Vy0OZqm4vYdkvLCTys6KFGs/Ed
         HuLE17ptxSMzD1APNLxL9HInFSthFcuBrzV6yW4qDZS0nI4VLvUIcHW/FOPgd6eRsVPx
         wg4A==
X-Gm-Message-State: AOJu0YxDMn/HQdn68fEHF/SQCl0x3D0m72oX+vSAhG72mRK4fdMdPK9S
	MyLRXGU171nzSqqTyYYROCfefRSh2x79khuD80EML3iuICvWT5+BIlnQ/sh2HSnwg6PEl+nLbKq
	lv8seOhwlbb7HgL+XD8beH67kcjt80rkpIfTu7GShMwmYkdpfj45wE6LWcsc=
X-Gm-Gg: ASbGncvy/YqzzfUO8W5P/goXA7FdQrk/MVCU0N8g9zMQtghpwoZIMjV4kg8O3BTOBbP
	9mZBpQf4n458db2XvqjXPww4pwXfUPS8Bbz2Cse/Gt7W7EDVmc+ZZJjDReJmyZlCe53yKCfMAx7
	MCTHorBrEYuvcWK/8Azyn9sVZAcTIYCV+UizU804687OPJ8iU7Eg7Ipnua4u24SgthzjRLfmcDc
	656HZWc/ueBl/mC4ZIRcvgwQFXnr6dRqF8WKKpQXJzLy9Kdqj3XrdtBXoBYYCGzJ+yRtfxXZQis
	CcyslIso0f2dOKU0F7oHqzVLsrUbFC0SkPJLtlT61NZYF5C2IrNWlJYMvHy1UOguVrFMDLqafKi
	Yxf78p8Q3q/0l8d9q7gQTZI2EQ+teZExxng==
X-Received: by 2002:a17:903:1a0f:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-245e04fa7ecmr18015895ad.53.1755585396142;
        Mon, 18 Aug 2025 23:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7x2rlLjLEjoY6XNFKv6eIKH4qPemYI90LbCuQyKWX6k4A4fAbmZ2rJWHEIcg7kMoDk+m1Xg==
X-Received: by 2002:a17:903:1a0f:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-245e04fa7ecmr18015545ad.53.1755585395617;
        Mon, 18 Aug 2025 23:36:35 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:36:35 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v4 0/6] Enable ethernet on qcs615
Date: Tue, 19 Aug 2025 14:35:55 +0800
Message-Id: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEwbpGgC/y2OzQ6DIBCEX8Vw7jaCP5Ge+h6NMYhr5SBWoMbG+
 O5d0eNkZr6ZjXl0Bj17JBtzuBhvJksivyVMD8q+EUxHmolUFGnFM5i1L3nRYBhAopC5KMpe8ox
 R4eOwN2uEvWrSrfIIrVNWDweCKk0X/JV0OH9pLZzxM6uncTThkVhcA1yLgh2owfgwuV+8ufDYi
 D4XHIjZnK9gySCFXuW5LGWRdpV60og2Vt8Jzep93/9hUL5Z8QAAAA==
X-Change-ID: 20250813-qcs615_eth-9e294256f913
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585387; l=1876;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=8rX82cXmDkiy7mxoulbCd1tP0xA4NYjLb7c/ZyHx9wE=;
 b=aePfqudwbcAPoG0PPnBbU0FLS0s8F7btntlHW3vUPmGfocAQIUpjWpRbyjMfijPe2uqxhVKJY
 McDY75ufw3tBmlF2fvkzXQ/MPEjYHaStCQJMuO2NDkjLw3U+Y3RiqW5
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX/SER1prQ/1Kh
 Jd9TiLn4BdCsP9ZzfrqnE4lZm6liMVFyhXBJmP3sQpiph8nBx6g0g3S2jx86BfOW79TS34bjCJf
 XUEPu/fgiYF/FPaEHAjtOltgxYlye2ZrRKRwn55UayTWD05a5BYvuWMiNYZghsFjyEVoAo9UgNg
 huwkDvcKmCUGqJbqc5i62bz9PGdcvw5j3aVXF8KQ6Wzu39LXRcrKQA9ZpdJYWumZZHhJ7JK9i2r
 d2m4FKVhS+DjpnedSiGt9gw+ptCNW82Eah8Lc4OovQLKfzEy60tdqKrbA8vPyjOFaRJYRuu+R9E
 96myFnz90Rkt9wLbz0I0aH6/s/bL7veTPhHE0bwxJB6aTq49qDSRMlnOd9H9srA+dcmdCbuF7Oa
 HP2ejZFz
X-Proofpoint-GUID: fPHisq6Jp-33jSyeDqVYxpyZ_M0J3enK
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a41b76 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=wApU7nzg8TAj0S4BVTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fPHisq6Jp-33jSyeDqVYxpyZ_M0J3enK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

Adds device tree nodes and EMAC driver data to enable Ethernet
functionality on the QCS615-RIDE platform, supporting all three
standard speeds.

Switches the semantic interpretation of 'rgmii' and 'rgmii-id' in the
driver code to match upstream Linux kernel definitions. Updates the
device tree files for affected boards—QCS404-EVB-400 and SA8155-ADP—
accordingly to ensure consistent behavior across platforms.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
Integrates the thread:
https://lore.kernel.org/all/20241225-support_10m100m-v1-0-4b52ef48b488@quicinc.com/

Changes in v4:
- Change the phy-mode of QCS404-EVB-4000 and SA8155-ADP to rgmii-id.
- Remove the DT binding change related to the phy-mode definition.
- Update base commit.
- Drop ABI compatibility and update the driver code accordingly.
- Link to v3: https://lore.kernel.org/all/20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com/

---
Yijie Yang (6):
      net: stmmac: Add support for 10 Mbps and 100 Mbps Ethernet speeds
      net: stmmac: Inverse the phy-mode definition
      arm64: dts: qcom: qcs615: add ethernet node
      arm64: dts: qcom: qcs615-ride: Enable ethernet node
      arm64: dts: qcom: qcs404: Inverse phy-mode for EVB-4000
      arm64: dts: qcom: sa8155p-adp: Inverse phy-mode

 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts       |   2 +-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 104 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts           |   2 +-
 arch/arm64/boot/dts/qcom/sm6150.dtsi               |  33 +++++++
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  28 +++++-
 5 files changed, 162 insertions(+), 7 deletions(-)
---
base-commit: eb91b04da2c3ac17e4e67079e455fba4bfd1b4f0
change-id: 20250813-qcs615_eth-9e294256f913

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>


