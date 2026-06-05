Return-Path: <netdev+bounces-295787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Dy7CF6yImohcQEAu9opvQ
	(envelope-from <netdev+bounces-295787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:26:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F1647B2D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:26:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="ThW7AMW/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=IEdeIjhF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295787-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF9A30137A2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB54D8DA4;
	Fri,  5 Jun 2026 11:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64A4D2EFD
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 11:19:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658368; cv=none; b=SzuYciqeQ0GhaFcfEYB81Yv9cWrg/JSkvA4W589cnywhAXlNmVzjV0pP4GPddHfCcXYwqLOZLT9KaHAOdP9uqmeK+ejvW4WOv3mt7yZ/TSyvf1RUP/LkwzuZUN17xnxH/rnF5JWIW8a8+/xTfek4hXnC5paRLdKy895vgMLxnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658368; c=relaxed/simple;
	bh=Hno3yiqDgD9bZJJwY7n5fLKWiLMFOXKg1w6K7rsVM88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IxgJ8nPSegGAeqqgndVrmnXWk8j1MpyYLPunJxMxwUhnwcSMx0eh1yf4h8C+7/yxUllX/TpmEYxJJUxMNakJFeX49U7ALjMZKe14Fsfv75IideWCp8XwRRZYaea7UPflrQE90fCOXdFSHzvNAaFt/7qWoa5CQDDHXpe2hfTIejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThW7AMW/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEdeIjhF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65575VSj1501921
	for <netdev@vger.kernel.org>; Fri, 5 Jun 2026 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FQqVQt5Xe7OTDM8AnHOfVt
	1NXuwCB3WyrISJperJfGU=; b=ThW7AMW/iPZ4fmrXI7tfwQs2hv/iXvBblj7btD
	0WHSUVdV5zSd1i0A6d5+IZvomKvdLwwv5dw8qEBsFeb1C+4sYuWSBVRHdchdi7Q5
	8Ura+L5bZjjW4izWSe63gCJOJzYRXxTW56GzIqe1tTZsRJROst4lOT8Yz875UwGY
	WE1DHKjCuRyULZ0xHKlzk5nXzoIRFGWejRg1vhh9+82PwooSIILDX3FDvSMG8+Yw
	od+PHFy1/Hk+kjJ+vXqD5uU5gC2quPI5f8Ui8Ofw+2OwaL6BN7/aoEue/1cwucSc
	xgn6BuKinLsYqQW//o61SwMOE7CLFeu59491WZnoR5QZERug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eksrwry6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:19:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so14894585ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780658365; x=1781263165; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FQqVQt5Xe7OTDM8AnHOfVt1NXuwCB3WyrISJperJfGU=;
        b=IEdeIjhFL9c3LYeF2ZxU6YNlZ9kRP34naCrgLfkxkv6sI+OIFrkScZbauokSs8YhCF
         FQ8ge0PQPQH1VniLx1N7GnSzA1MCC2KSw75bQE8Ur96wvkYrcxJbKHLvWAV6ObwlF1I9
         AGl2XD0jcwrPhThVzd6j37NubRMQLD6N0u6CZEt+NfqZcfPm+ZznhuXFPNfm0BjhVGIx
         3cdkuurXWaIRexuOfqm0UK5f4bkTK64quCcirNQPS9f3ePCwHzIr0Vq3kYVAsGpHW/Oj
         RE3mHgnYQ2xuJuyGGBWTHOqFlEhLcPbcmdXZPyIBLoSTosTZK6LhBA9Z99Qzv93/Somt
         BpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658365; x=1781263165;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQqVQt5Xe7OTDM8AnHOfVt1NXuwCB3WyrISJperJfGU=;
        b=jT6V4v7hO7kyoj6tQvUDo0xkkEYPXqOwekkU5KS8NKqbJZBxQDl68lNx8EM39Cfq0+
         yx2AjrgaH84WJQ7L/70RJW3JP33SmyZQxnhxaEt8bgNhwdvjnlse3sof4wK5e9Z5e+Hh
         oyTwmoffm909we4aF0dTFWSxV9e6hFHdB00NAHwQ3cyDq3jETlODaR+QnWfnyfNZVw3d
         2XnKFEdKTCCJGFO79m2soUx+vFmzZeh4UeKVnUryRHY7S1Zzn7ez8+BZcHhUmVFG6yWN
         JEDt0tcY2dpiQPlXhNEaoLu/N1DaywC/nc6IASsa00Jt9gSjGAFzFKqDoQQrweJKPFCP
         O0tQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wHjHuycY2EjbVivN7/JY2xD4dbw2w3TZCLF+Z4KRjgcY56SMnb398sDZgl2HkiWbfB7AbLWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRq2ebhQjwGc5RniCnjlnX2Q3ktVB6nSrSyMslTL88stakLGz
	z5ILznoRt37QbrkT65lWtWIuhIiqidS6t09o0Xq5d5HujPdnMMz4jH3uA+09RPGJIBMaIzOcwR6
	JUJZKI7ZlC0FPReBf+B5Do1Dk781ier2inqBANAlSs9GWAPqGpuawH5gcasc=
X-Gm-Gg: Acq92OHNKYL3uwqI670e/FWdK3xQTCzkI8NCWlmzYurTBnK9r7OOnDzc2Kkjp20/vvP
	UQ55T63ENlIPFZCmKbalvLsxdUTWI+jZlushLj3TLW6TqXbRUajTNkPhdJDMLpSuzUS5JZ3VZiz
	IR2lNBexDg/dia00uGiJXJSSOfsCPIpx0D03vilbx+MI3ymBK32194Us0sPH4l3/2+tuoFunm78
	9ree1IzwfdaYrgN1TjBGz2/WUA6zl8Yl0cRlsJRvOm9arhp+D9mYnCBftbipDVvD14KwaEHs1XU
	HSOrJyWyj2vNEg2Tq/S0vfZ14kmltHxYcrCKnFblCo5n2DFfzFkCqUkxRU5DurCmZDx8Mcs3RIS
	J6pfdMs9adq4TUL5Zl+XMBMZ9b4RnUT8id7Zz1AWjgBWHbZHbnsOfdi1IqVazj9w=
X-Received: by 2002:a17:903:4b47:b0:2c0:a57c:ebff with SMTP id d9443c01a7336-2c1e79e2110mr32863295ad.2.1780658364706;
        Fri, 05 Jun 2026 04:19:24 -0700 (PDT)
X-Received: by 2002:a17:903:4b47:b0:2c0:a57c:ebff with SMTP id d9443c01a7336-2c1e79e2110mr32862645ad.2.1780658364171;
        Fri, 05 Jun 2026 04:19:24 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm124551665ad.17.2026.06.05.04.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:19:23 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v4 0/4] clk: qcom: Add RPMCC and GCC support for the
 Qualcomm Shikra SoC
Date: Fri, 05 Jun 2026 16:49:10 +0530
Message-Id: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6wImoC/4XNyQ6CMBQF0F8hXVvy6EDBlf9hXJQO0CCDrRIN4
 d8tbNhI3NzkvuSeN6NgvDMBnZMZeTO54IY+FnZKkGpkXxvsdOyIAMmBkRKHxrVe4lop7Mcuprq
 3ARMomdHWWloBitvRG+vem3u9xd648Bz8Z3szZev1nzhlGLCiSgvBeVEJeRlCSB8veVdD16Ux0
 ApPZMc4FEcYiVhBCS0qSRjkcIDRHcshO8JoxESuGOeWay7KH9iyLF9pdHWRWwEAAA==
X-Change-ID: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>
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
X-Authority-Analysis: v=2.4 cv=L5ktheT8 c=1 sm=1 tr=0 ts=6a22b0bd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vqexoKkBG-sCeqS34qIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDExMCBTYWx0ZWRfX4FTWytdtVXU9
 krI0wpM8tJadp65tbshkmeDOPTyLcHJJ1XX0SfQQEQBRFgE4QNEeQzaiqCimcyTzX5SijXLifOt
 egs0TePHniuXLtsQj2B2Ommyu3ZnhJ3EpUieCSbpJeZv/yr9OmANkbdcAuHztLWTjQEMWUs39HN
 0VH2TozXURPMUYOrYth4WyPtxtVBcZeDqcQ3La37hD2fKMpj6z88dDS8rGINoeDtUYldXkjuWuN
 h/AXp1LwZ7p4M3Hjfhc5dfWt2nVsZOgaZxfpcjNXxJKekyWR8BgoECqXS+gMIaXCN7W2uLZeWlF
 bI1CcMlEIRtQ4N551oQQT3CCZ9wPyN7h1YWVpIoj9dcxi+66WIEfZce0vKEFMHdtv5eY46opmg6
 Qlv924ruoKjPcRgKjPuNBkTuuI4EurYNs9zenaVIk7SzJQ4HtkAC8Yv1hGZHMgMNfla1/7oX93Y
 KvBLgjbwwhhsHTMru3w==
X-Proofpoint-ORIG-GUID: 0VyzW1bWRc8CLsGw7FkaxPQEpXMvZOFD
X-Proofpoint-GUID: 0VyzW1bWRc8CLsGw7FkaxPQEpXMvZOFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:imran.shaik@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D6F1647B2D

This series adds support for the Global Clock Controller (GCC) and
RPM-managed clocks on Qualcomm Shikra SoC.

Qualcomm Shikra SoC details:
 - https://lore.kernel.org/all/20260428-shikra-socid-v1-0-6ff16bad5ea2@oss.qualcomm.com/

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v4:
- Updated GCC critical cbcrs list to add GCC LPASS clocks which are
  required for Audiocorecc register access.
- Link to v3: https://lore.kernel.org/r/20260601-shikra-gcc-rpmcc-clks-v3-0-76c455f5d579@oss.qualcomm.com

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
 drivers/clk/qcom/gcc-shikra.c                      | 4431 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,shikra-gcc.h        |  263 ++
 7 files changed, 4816 insertions(+)
---
base-commit: b99ae45861eccff1e1d8c7b05a13650be805d437
change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>


