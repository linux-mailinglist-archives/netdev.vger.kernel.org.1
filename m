Return-Path: <netdev+bounces-293535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILyrGKcKHWqWVAkAu9opvQ
	(envelope-from <netdev+bounces-293535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDE6196A0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FDDA300D686
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9F31F9A5;
	Mon,  1 Jun 2026 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcBE1YZU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gk4/EWve"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F593093CB
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288164; cv=none; b=AepdK2jDzoAYciMvwX1SrcI4qG9CgWb2DVZ9nLUqeYbXPaUauZ8xh9j7/AIGlnlCWJezFNKt0BNl+1sMYhfRT0fKcJ744wHjOrIL/o+ivyb/iiV8hUi2k7OFQuDTtNmPb8uTRFqRHc23lU4J0lwRYHXTx5MVuOMThsIK9SjtpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288164; c=relaxed/simple;
	bh=oj9NMY0dHTGaZ+fF8PHGfV+wg6hs7AbMX7SVDbau+aE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kx+NyCdzyBQdhErJkWeyB/fTCHYXyDE6LU0Eo3+VoWAQ6P9wUXZ7n3KkMogp3zXEN1HT7TMPW7zUNDCDUodyGNmDevohXlQRUl2DpGRwx1+yv1KcDhe7CIVedyroVmMV4ARevUpkJJJXNZRaTpewwTom8o4LhcEZTOEktWxeVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcBE1YZU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gk4/EWve; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VKNGUU1169742
	for <netdev@vger.kernel.org>; Mon, 1 Jun 2026 04:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RKGMQInl4zv/ejwicadaXC
	R+S8YrLXcWc62MxjTRBcM=; b=XcBE1YZUdE1JcLfjwWsiVHEdYkj4eBbsYoyD0Q
	PlErcJ7TNfNVmVx6GSkFjBUyO50uInsuu7kknpzsumqcxTPxRwRqm2+Gmnq+wsiP
	vqbReIg9iw3Ryt1crKdjReGCb8urY/A/3AH3oZ+WHqzC8BsM+kGwYskrrUkgbjTO
	MOK4gOj6Y+Z/6Dm0CzVYZPbp6SqB5bpgVjhUOd6xQGcnZQmfdyaSl3vpnTft5iG/
	FlNQp7VSJeS6b4wcKljaY7uxHXvIra3JaJnsrMwAMALVo5dylSwSSJTq9hda+uXp
	N2HKAarj58dMUSlNigh8/toW0T7HHAcMohO7w1m9f6rgQ3FQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr41dmj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:29:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf243973c2so18292595ad.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 21:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780288162; x=1780892962; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKGMQInl4zv/ejwicadaXCR+S8YrLXcWc62MxjTRBcM=;
        b=Gk4/EWvez3RGql6Gh980VRfRLgiCSa4Zd0NmJJV3XqZddqcUjg2AaWs9cNlEUQKE03
         dEiELpQlE1lLXOjp6nL98zSIG5ztElDYC9PEZ00R6nyaHvAUZhKS1fX42ZWCMEHRrf2l
         zktUiMamzCI7G0TD0JWqg7V6c4EchAydsVoSXYT1GYv7PNKx0rfKYgr53Np+Wa3zjDOw
         rvH1TJGvfI8O415s6vhOpdM4rwS17uGspCpuuPVIy2QstTY9BJ2ic5tMbqGdx8GB+6Eu
         +VdKYpTchgpqlEJfAVZW961EG8Rm6vQimuXN+3jD/OTCSGtwRgL+hCSErySUyxXDLrVn
         Q7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780288162; x=1780892962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKGMQInl4zv/ejwicadaXCR+S8YrLXcWc62MxjTRBcM=;
        b=NjPPUP4dMzmGqP+PE+wqgVCiP8slMJw7Hf0F+6FqiJMOic57oatwdZHY864/xy0xHy
         5goTNKd/1NfzN0lMtdGrizDTrFEBL/fKp1gs+iAu+j7ZyVcs+RU4j3f1hTaS20YmR8NZ
         LWVC37xC/AdmTdD/4NDwViZmPS9Qv/1lN68V5pYMbD09nSAq+1jFWNn/ovzUrS5JBQDJ
         yUACdPFyLDdjUOtjtwi5GCsJSGFQ7+cjQkiPwdnKKvqc857dH9nDt4vA8o3hZAuq4enu
         2qf2u2J4rCKpud9H9tccJ/W+oVSJwYfjWgnjIBvCXQQWacbHswBTOkKUa8Lpn+yddmzk
         eZaw==
X-Forwarded-Encrypted: i=1; AFNElJ+rDeohTE69EsxoUMoBJawRv0wSbPxWuZAuznPqM6uXdSQrRiHe0rh6FYk+SskXoqx2p3t1W5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojtM9FyEzMgTvxzPvKNZjQDN9aP3YsAYaNHTXWs0q9OG9s0vy
	FvvTIuTS2DXow5GFLjD75nQ0Bj951zsJ+Kqn4PeqXcxK10ddg5LXTU5/u8ofVL7UBQLzUL9198L
	tnAq9gTRoBgsNOQIYAs/LuyyM4MdXIXT8R9GHZ0J4PQogQ6kes8TAMs9l98E=
X-Gm-Gg: Acq92OFxmOhAj37SVjGL9nWTF5kQj8crlFOv8GvdPBbz0236T7oTw8JxxN0zFqsNcKB
	74/Il/mTVbLIEzDBhBCLZ2tNDHZWJ9PO6f0vIC5tArRxKTHsAqhfS0gkFmVeeoEugOmMe9miDYM
	2OXli8FRr2ulkTHecPmdd5VYrpHuchnisdIXAUL9nJ6L2+bIaFBolD8TKv4hwEY5bW5ll03OULE
	sVPp5N2JAF375qjZTs/MYK7jrFG6JZLcQf4oIRPkWjVJern6tTn6ppLKimnEzpxZhiwWRzsNz/m
	uhAYTF2UZFbhVq4H6LxjIbDeae2kEWvJWzNk9AbXxk+I/qolOvp14VZPiF5JV0UgNw6s05bf0tb
	cvG4edtAVqkCKmgWo+SDD412BeO1FxJ3t2AEYtCf3xEkqWEqt0m4SZdJsli0JdvY=
X-Received: by 2002:a17:903:46c4:b0:2be:e3bc:e8e4 with SMTP id d9443c01a7336-2bf367dfc87mr97329635ad.18.1780288161455;
        Sun, 31 May 2026 21:29:21 -0700 (PDT)
X-Received: by 2002:a17:903:46c4:b0:2be:e3bc:e8e4 with SMTP id d9443c01a7336-2bf367dfc87mr97329155ad.18.1780288160930;
        Sun, 31 May 2026 21:29:20 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm117215715ad.41.2026.05.31.21.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:29:20 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v3 0/4] clk: qcom: Add RPMCC and GCC support for the
 Qualcomm Shikra SoC
Date: Mon, 01 Jun 2026 09:59:12 +0530
Message-Id: <20260601-shikra-gcc-rpmcc-clks-v3-0-76c455f5d579@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgKHWoC/4XNyw7CIBAF0F9pWEszDn1QV/6HcUEptKQPKijRN
 P13aTduNG5ucie5ZxbilTPKk1OyEKeC8cZOsbBDQmQnplZR08ROELCADCvqO9M7QVspqZvHmHL
 oPUWoMtVorVkNJG5np7R57u7lGntn/N261/4mHLfrPzEcKVDJZFOWec7rUpyt9+ntIQZpxzGNQ
 TY44AfLgf/CMGKcIeO1wAwK+IKt6/oGB3ZhSA4BAAA=
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=fOEJG5ae c=1 sm=1 tr=0 ts=6a1d0aa2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jEWS2u4n0fhbBKcMAsIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: qvAvqtFP3UjXCSsSM4BonUtSAi47Y1P_
X-Proofpoint-GUID: qvAvqtFP3UjXCSsSM4BonUtSAi47Y1P_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA0MiBTYWx0ZWRfX1/NEDzGW0EJi
 yKWZIbGODCNmOFn2LUQ+Q7NJnK9tlNaM7l/7b6d/RLOuKeQVge/PjUjLGklFkExUXSRAMce2opx
 16psbg0p4/fKe7pUHpgwxf+Q4PLLqGb7Wta2B02O/2GlMobo1TLZYAx66626mi0+dKyJuSm/PMn
 CtDUTEC3P2vFgT1m1JfC0o0Vgjwh3xkTiNyvET0o6U39PVu/PBx13ge+Rhr1XOyYor6YHYt8hVc
 cfqbBGlKl8zY43BbGBa6134k7i42YQip8+P9imaj/i1JofOd2CEOCb6NLUVUsE7bSJnqzDVtGz4
 VY3qzYWI4B0fH0plv6Hp/xr7xbLkxZLx2lck4hXeLvd9JFvG0bdxmN3JsKozyaUkakoCpxKw+3s
 2N1obgjSt/vIFT2pG1wDPKZ9cDJSFDpx8kSB0KvRI8KAannjmJ7p1vLaQnt3z0RHnwQ+uVFJiAH
 F5l+7+wx9BccEvoEmew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010042
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293535-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: B6BDE6196A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the Global Clock Controller (GCC) and
RPM-managed clocks on Qualcomm Shikra SoC.

Qualcomm Shikra SoC details:
 - https://lore.kernel.org/all/20260428-shikra-socid-v1-0-6ff16bad5ea2@oss.qualcomm.com/

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v3:
- Squashed GCC USB3 DP PHY reset support changes and picked the R-by tags
  from the following GCC USB reset series.
  - https://lore.kernel.org/all/20260526-shikra-gcc-usb-resets-v1-0-6d9e7fee2998@oss.qualcomm.com/
- Added R-By tag received on v2
- Link to v2: https://lore.kernel.org/r/20260508-shikra-gcc-rpmcc-clks-v2-0-83238ba24060@oss.qualcomm.com

Changes in v2:
- Dropped defconfig patch and enabled driver from Kconfig [Krzysztof]
- Updated GCC bindings and driver patches
- Added R-By tags received on v1
- Link to v1: https://lore.kernel.org/r/20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com

---
Imran Shaik (4):
      dt-bindings: clock: qcom,rpmcc: Add Qualcomm Shikra SoC RPMCC
      dt-bindings: clock: qcom: Add Qualcomm Shikra SoC Global Clock Controller
      clk: qcom: smd-rpm: Add support for RPM clocks on Qualcomm Shikra SoC
      clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC

 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |    2 +
 .../devicetree/bindings/clock/qcom,shikra-gcc.yaml |   70 +
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   39 +
 drivers/clk/qcom/gcc-shikra.c                      | 4429 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,shikra-gcc.h        |  263 ++
 7 files changed, 4814 insertions(+)
---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>


