Return-Path: <netdev+bounces-296522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GMUzAqW1JmpubgIAu9opvQ
	(envelope-from <netdev+bounces-296522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591AC6562B7
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:29:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ijMABQTa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CxI+Ko1u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296522-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296522-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A96308E04B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5203379C48;
	Mon,  8 Jun 2026 12:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6872618
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:23:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921384; cv=none; b=YBqXCIcfc3pY8tNa1XTZzjFF5iJbF5vcRHA10YRoAHSaWSa3RURHMxlIqDWX8oVpLGK4L88F478b0haCZybf0hGmi+FIRgOPkRUteSD7HZ6HoRdiraKDJvGJTHOBLCbQDbNB271IVN3+b8RX+bVQdIIOHAI2uLWKFPC42xAVQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921384; c=relaxed/simple;
	bh=4F7gY46dZri99qm2y2Zpu2VG+g8+kLFHTgK5fDVba4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WUq0TN9pPm5PGnaF7UWkRZe9CvQ2meb3UX6O76d1GdkzsqwbkZP0KtNG3CXE0FdT4RarU6mbF95Bwon6srsCqOa4geRjgvB/0u6nJuxkuU6Go2ZjyCyP7EW71Ng5G5n87ShoOwF3bSHQLdthH2MVXnRNtNsLytS2fcTqeX7b2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ijMABQTa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxI+Ko1u; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9KEO2992933
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 12:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X69rCPirG+wBx93FbgpUBH
	+X44jjs27nxgLICDNALu8=; b=ijMABQTaxlkG5CoaiFIbilzWulZfKOFKJ3edg7
	T7fiEOcJ5FkuUNbA0EpTyExj130oK4sOtEHyNKGV5oy3kLffUs7VoE2VZXrWOnJ6
	Rs8PXmS48Th0JojL394nNYpUWQnhuEt4NLpbTAU+fLQgt6ozTxnkbkOHxqZLTb/u
	NAGID/003G1SmxJCkGYENBEqoRC2Zo9aHxmndf2x+mTdprItuIBsK2cUt8mNxwbY
	Sy67X2VyaWUIaZKB0VoPfzkz1QPGVAcLv7nNUSq+dUA7qIx8Ha9YPjyN4t4bL3yy
	LwnbYFzI4uvTrYbV/lhoSqYHmQ1gFs/GHSz5ftMtCLasnOUQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuna8jfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 12:23:02 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7e9c004b182so85433447b3.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780921381; x=1781526181; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X69rCPirG+wBx93FbgpUBH+X44jjs27nxgLICDNALu8=;
        b=CxI+Ko1uBfG6kX1hjG4FNmvMUPX4DHgRepfQn/12rbI+xellNQ4cNfIaBvtuT8iSc+
         8cYchYTdiMaQ3/GlKL8P6ul4RBwzLyovoramP+B1GCeBHM+yTw4r6ZuI7dCn7VXHY3z0
         ao9rhiDFQ8pswlD5zpXtEa+7XCUIuy44yplf3F5/1FQCkrcm/GvjhNRBKOEaylJQnqv+
         BwA+CAGnBQQLXlX2pb03B4FGzKp57MTm7Id4dqhJNlwXCunkTh972AI9ChBs82Vgp4dE
         LXjhvP4s9SA+U3nWX6LjRQcEZvAS+gQBwFYHqwefmpLY1zTnOlHKCTatEA2v/7nBnDHX
         snkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921381; x=1781526181;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X69rCPirG+wBx93FbgpUBH+X44jjs27nxgLICDNALu8=;
        b=ORquQjOFCOC8vxqE4gIN+Wi+YPp6udN2daMrLA1xYegh5a9LuCBTk0nB/hBNft7T6L
         n1g9fGU4yiCukA2HHyjxgcnve/zRoLksFJCmM2NNG5wXP62xzNTf9HuGg+kxHsiQoj6q
         BRWcvdRHDzC+o6iROnOmXmLvE1u/YGEjj4qNsFfm0KpYGeLTd/Preyh55VT+dd920V7U
         ODA1G7Ve55K69W23KxzHutNfJyqcnFhoNzDylwIvQSvTyywc64xOx84N62RmzzAGyELp
         5CGpqtoGv+rRoXKd+Z1nKrtc7eBY0uR+ev4PGGrAAh3l9NaWSQ9ZrzodTvJtgjQNmyCW
         8y/w==
X-Forwarded-Encrypted: i=1; AFNElJ/F/lnIxOuv5/kN0qi9QVAXSZ9cj10G0eqLW7VftEn0d2m9qbScBRkydFQIJqu/xPWgYD2ErQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gp3DSimYYEHzoqDgZXVUVE9/93X3NLtkAlo4apDpAX+lcJ02
	nHgrZWIPISkSkoSLLPOg9HMSkhqNHr9e8NH3xyxz8oOZpqUWuTZoeHi6YIfBkUV4wtLxCSQ8BKD
	eOR6dWnVotkWFBXY5W0GoW8ggBZZMp/2rzvLF5DGY770Uhqntznr+U4PZCaU=
X-Gm-Gg: Acq92OGXNHCWmuwKOQDzT6+bbuzVn9us7fgQJEV33twhAcbGWrBswtMWKhvgyLYdszN
	9WC+eDLQz5JXB0Kf8f0Lbdo7dmKvWVca3CPq93cnYaz6whvrYu7f+bZZWAA/KJ3KLiAPcQyYvV1
	6K+x1QA6wHO52QAKytuR+MU/5C/DtkrvTzbusF51XGxJp2nJvHsainq1dQDt3VwN+9w7zDUydq2
	qtiKrjmwGPTiD6yK3SaN9xbglcldSyQRWZ+zvT71VNrPImTGqlv8YzN9iWzQmn5vtcReQqktRkj
	ubFtV9RPf6i/GlZ61cBX8ReUF7FgCx6l9bKABCP5VUzTHA6yv6yD/NzGEA3ksQTaJ1tKWJ6sDNU
	WQhng4IQsL1NMcisk7dJQPDrFt+sO9OIO1Rd5NOu9U25r5ofCaepJtnSd0JvuJoU=
X-Received: by 2002:a05:690c:b15:b0:7d1:cd93:c8f1 with SMTP id 00721157ae682-7ed0c22f784mr142914907b3.21.1780921381064;
        Mon, 08 Jun 2026 05:23:01 -0700 (PDT)
X-Received: by 2002:a05:690c:b15:b0:7d1:cd93:c8f1 with SMTP id 00721157ae682-7ed0c22f784mr142914587b3.21.1780921380568;
        Mon, 08 Jun 2026 05:23:00 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8186sm84076257b3.4.2026.06.08.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:23:00 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v5 0/4] clk: qcom: Add RPMCC and GCC support for the
 Qualcomm Shikra SoC
Date: Mon, 08 Jun 2026 17:51:48 +0530
Message-Id: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2zJmoC/4XNwa7CIBAF0F8xrMVMgSmtq/cfLy6AgiXaVuG9R
 mP6745udCFxc5M7yT1zY9mn6DPbrm4s+TnmOI1UcL1irjfj3vPYUWcCRA1KtDz38ZAM3zvH02m
 gdMdD5gJa5bsQgrTAaHtKPsTL0/3dUe9j/pvS9flmrh7Xb+JcceBOuk5rxMZq8zPlvDn/m6Obh
 mFDwR7wLF4YQlPCBGGNFLKxRiiooYDJF1ZDVcIkYbp2CjFgh7otYOodwxKmCDNgtA1WKSI/YMu
 y3AFGD3NjqAEAAA==
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExNyBTYWx0ZWRfXzIY0+iKJqpkE
 saI0brJvUEriW7b02/DM6pSvjNASazkLAc9btZEhqlIMCQQnN+wHKppx7qsv7xPYJKAkvrRo0gs
 qKdgCp/hD6AJBdZly0VlJqoFn1E32lHPFS0fnNUmFPei5aEY32ewjxq3o55NsC5qexrvJiUXgg3
 CefIgMYYp+aTIy/GKizMvfXOF4W042FcJD+4vwFpVSI55UiMLQEFjFRu66em5ET1JI6iW+V6d5x
 j5n+L35jc6XlXmGLYfL8VcuIlEV/CbBmIjv7IvIJncYxw5ATKOHqs+2XDaA81cZpmk3cjZLAb0i
 EoptlhIOIrgVwioWCAvI4L54LP3OM2XhPhXU4/Ji/R4j1JYEExmwj3pugj3jwVsRIFmNrmCQnmw
 LKkSQ1z5cS8ptMUFKIZWrJHO2pjROmsYByIdSXDXW9Ocd3OS8DRXJwM3H6/NAAGThDJtgD8+ZMU
 VdtVlp5Rk1J+9wtmCxg==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a26b426 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=byt2Oo71_RUV7fr4z6gA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: E_W4JQCor909nT4UJiBPkPXSS6I3lVJ-
X-Proofpoint-GUID: E_W4JQCor909nT4UJiBPkPXSS6I3lVJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:imran.shaik@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 591AC6562B7

This series adds support for the Global Clock Controller (GCC) and
RPM-managed clocks on Qualcomm Shikra SoC.

Qualcomm Shikra SoC details:
 - https://lore.kernel.org/all/20260428-shikra-socid-v1-0-6ff16bad5ea2@oss.qualcomm.com/

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v5:
- Added missing RF_CLK1/RF_CLK2 clocks support for Agatti [Dmitry],
- Fixed RF_CLK2 rate to 38.4MHz, applicable for both Agatti and Shikra.
- Dropped Shikra RPMCC driver patch.
- Updated Shikra RPMCC bindings to use Agatti RPMCC fallback compatible,
  as Agatti and Shikra has same RPMCC clocks with above changes.
- Link to v4: https://lore.kernel.org/r/20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com

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
      clk: qcom: smd-rpm: Add missing RF_CLK1/RF_CLK2 clocks support on Agatti
      clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC

 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |   65 +-
 .../devicetree/bindings/clock/qcom,shikra-gcc.yaml |   70 +
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-smd-rpm.c                     |    5 +
 drivers/clk/qcom/gcc-shikra.c                      | 4431 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,shikra-gcc.h        |  263 ++
 7 files changed, 4816 insertions(+), 29 deletions(-)
---
base-commit: b99ae45861eccff1e1d8c7b05a13650be805d437
change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>


