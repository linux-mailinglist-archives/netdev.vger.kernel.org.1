Return-Path: <netdev+bounces-282347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP/KIvnj8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618D493409
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5946930B03F3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7363EF0DD;
	Wed, 29 Apr 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oewXyfUI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YmFKwi6/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669763EE1FA
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459929; cv=none; b=VzuRoKVVKwUpp8xZ0ignFuIRHAxyWlpnA1Ub98Caw7L0fvNhmCKMo4UNmlhAnA78s3BhikKki+ZvHOj9dig4hc93ySDmZ0t5y049gG2oCM+BK/lqsRSvuKb3d5okNciigmr7bffNzTRyiJGtW8rgarPey0T+Q9zt3D1IyXsWNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459929; c=relaxed/simple;
	bh=EWjSijfh5YbT4XwQ+bM9xdGSiunXFV+lVP+JIiSqvGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ay9pZ168g/3QzLcPMCAJBi5nn6MlOD45HDnTBvnuLpShMzB7KvKxywFLHDV1/bzkhrDHRW/I1qcoSN0fA1UXKQOCUWCEATXyIZDOxDmpgd0eP5SJWwOREfhDWSmM1A1BuUdW+cZBRlXYaSMgfv+2KcuZ/uFpBMcLk3u1eqmIiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oewXyfUI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YmFKwi6/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q7Fb1721232
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SfuPAxswSKgB66zXlIJSMB
	HWjJ2M2YWduAKhLIqYG50=; b=oewXyfUIs1o0GxKCgjXo5uLU3FMisq/CAtQWg4
	qk5P7k9RCm8R8q5/xJO/hV+lA1UzE5T5aJ5a3dRvoe3EBvJIxYERKPGLDO8U9Fzp
	LDr5QMI0bBGFbfsx+GJvzdk1xgkAp834Y8mFFEEU4q1DtEPX9dWr8mqt3ydYVEa5
	qfM1Vs2ibWcoSVd0usbrl/TgFQ3PIuEIkr2gYCfHgF/3UumD+QWjyTRSxRcRcrbx
	YAF0SPCGbQU+gzrnySepEeur+QKAegJDPhOwXp5IPtRhZvN7P40RKuRoyBTLZjnC
	9knYdf1EeJpMqCVMSZTqqip6PhLhExl/D3kyVw1R2772cQDA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua731phc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24af7ca99so167551375ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777459925; x=1778064725; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfuPAxswSKgB66zXlIJSMBHWjJ2M2YWduAKhLIqYG50=;
        b=YmFKwi6/BDLAQ/Hab8Uei3YEI2qdy1syuzpcGthFE3fId3BsdM4tY/+qB/Xmr9Y4jf
         rTu7XdphJE6g2wV0JE7pWZ9rOMBE1d42N1rc48ZBjXSvCUrWtVVmQdme6ztwSk38i1BG
         rWa9jfS3T9W1Ki2MDxr1Hy3Dbsc5+IxXTeZsRedeILt75gfFNPTrVkqMUS8P+cDPsbPy
         8cMU4txCNm6ggxmZpgpCwkpitWarCOKqhWljvfkcOyJ0Gu/B1dDIEzSeUn+neaGkI8mb
         dSuxAtRNYoYnUlaeEuBM+bkj0ZwqaG0o9Jw9hvCOmQyM6cbBMxm4XclvL9ekX6ZVrQYI
         iyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459925; x=1778064725;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfuPAxswSKgB66zXlIJSMBHWjJ2M2YWduAKhLIqYG50=;
        b=ZAFQ3IgKrE38p8T4xnB/eRuT2tRMQzU6HpS7psmmo2/2HrHZIUut54sQ4gPziWSN+C
         HhQkyeOmD76V+vrlPujqh6BD6fYPn9GrNp/tzqPOG6MSh2o3efCg9vhHzLA+C93NYIqd
         jydidJAxhZWjunnz03U8REMj9flIXah2NFdvYladmCsp4jt99Yxy6RurHafad0PCxPnK
         zFDfwEbT7mmtA83GZzG+3sE+M0vN9OtpF2I6gd051BZUgN7W19mskWnXGSKNEvzTfbUn
         9IMFFETJu+K1LkUvfyBrG1wwpXOuZc/2qeiP8UPSgghpCnNm8umolbl2Zn0Xt94zRhM0
         03Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+dz+rQUHHjrcgzSTUqhrzog/4iK4F0EC9Mz/jBpF2zV+0rfne48nmE9GqwJhnfUaiAUc0KICw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HbSbguNB/SzS3zpQl0wYUF3RaOghKXW9V/9RfzzzEr2f+bad
	IXQLbBtk3Gx8znsO+Eaw36YXlaRpImMW3hP8rW/cAGZ9znbHWZ96/5k5/M9sQppIwiJ/RDGdMUu
	4vlGF1232DSs2Att+XjZbP2APx+5K/1z/9bR6W7F6yy/nLZrGbQ/KdxzHgQg=
X-Gm-Gg: AeBDiesxlAICR85vsaem3VEj9MMg8ri9HH1+vVcwoc+xXAXpoM3Xh5eOlHVj83lGB91
	NrOFEX1l29bX0XOUoos+EivEpM578IAl3Pytkx5VIJqIdMyMaCDLiyRD5kPCj1GK8AwObdZNbBG
	SRxv5mTT71hJSKl+MF37rfZuB306K6vPdF0ye5k7SUib9HbcX+szTfG5rR38G3uFuNqXSSp9h0C
	8r34h70VlGyVEt4JuT+IpuEXbS8qfdvQHoPNwxPNDCDQQ7cIZVMk8fD+7uxiAxgxJrC2FjskBKt
	8Bt8i42nhTMbcEuGLgcac/gvbnsxeos2HviqSi0REZJ4iB3jEx9yZj8cejZkPhuc4tMCZlEsssR
	DVREcXI5he81YXenlQF/c4zPIdtAnDPpWbo2MIIzeTraETYBSxAo05C8kCujW7uk=
X-Received: by 2002:a17:902:ca15:b0:2b4:5b1a:d09c with SMTP id d9443c01a7336-2b97c400babmr48210755ad.15.1777459925075;
        Wed, 29 Apr 2026 03:52:05 -0700 (PDT)
X-Received: by 2002:a17:902:ca15:b0:2b4:5b1a:d09c with SMTP id d9443c01a7336-2b97c400babmr48210525ad.15.1777459924591;
        Wed, 29 Apr 2026 03:52:04 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e9csm18316715ad.9.2026.04.29.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:52:04 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH 0/5] clk: qcom: Add RPMCC and GCC support for the Qualcomm
 Shikra SoC
Date: Wed, 29 Apr 2026 16:21:48 +0530
Message-Id: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTi8WkC/x2MSQqAMAwAvyI5G6i1CPoV8aA1rcGVBEQo/t3iZ
 WAOMwmUhEmhKxII3ax8HlmqsgC/jEck5Dk7WGMb42yLuvAqI0bvUa4902+rojWtozmEUE8Gcns
 JBX7+bz+87wdNVaWDZwAAAA==
X-Change-ID: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0
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
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f1e2d5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7Nf7qm-7OTtRn44RyKYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwOSBTYWx0ZWRfX0hZHy/Q+6/KH
 IWWFDYZcEUyizkjtIwaceM+aXHmnSnaAo9uHlHgXiG+5WDIxTqw71WRz0XSMeeZ3jwvYPcBoIIU
 DuAhn5vDOnzYbELQfIT1+r40GlVqhlBfBTA0BCyZN7kVaVeiC3SUNfJuF2aON+HU05BbWJjpd8b
 pNlvdxdDO/W5NbBvmfO53im7JzSGTDxMIy8Wdw55abJ77r0/1jDjwzK1BcHiXJ9IK3YMmETQM/k
 bUFL+3AicxMjHcS/LebBfobt+CPK1dS8S6gHwF16QW/WR8nV79lfYjjZeVU65OhK9Zz9WZuFC3Z
 JMs3IP8FAOdCa6W02Oy2ql1wIAWQxohLauEZ/HHjW6uPMOhrmVlSZSqys+PL9CEpm9CCBb+uQOP
 U5ax7xpEbeG9B3spRj8xLdjgl+HJN1t9fEdo+0mwIpcLIZVvaeMWfU2/l6Z59tQVM557NU4677a
 hNLCCUmdFhSgXqIxVjw==
X-Proofpoint-GUID: 0_aU4687ZNmumdv78zcUaPCbXFyrYN5I
X-Proofpoint-ORIG-GUID: 0_aU4687ZNmumdv78zcUaPCbXFyrYN5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290109
X-Rspamd-Queue-Id: 1618D493409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282347-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

This series adds support for the Global Clock Controller (GCC) and
RPM-managed clocks on Qualcomm Shikra SoC.

Qualcomm Shikra SoC details:
 - https://lore.kernel.org/all/20260428-shikra-socid-v1-0-6ff16bad5ea2@oss.qualcomm.com/

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Imran Shaik (5):
      dt-bindings: clock: qcom,rpmcc: Add Qualcomm Shikra SoC RPMCC
      dt-bindings: clock: qcom: Add Qualcomm Shikra SoC Global Clock Controller
      clk: qcom: smd-rpm: Add support for RPM clocks on Qualcomm Shikra SoC
      clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC
      arm64: defconfig: Enable Qualcomm Shikra SoC Global clock controller

 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |    2 +
 .../devicetree/bindings/clock/qcom,shikra-gcc.yaml |   63 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   39 +
 drivers/clk/qcom/gcc-shikra.c                      | 4428 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,shikra-gcc.h        |  259 ++
 8 files changed, 4802 insertions(+)
---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>


