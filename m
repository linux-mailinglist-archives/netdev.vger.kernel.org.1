Return-Path: <netdev+bounces-270939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA3fBVZTwmnNbgQAu9opvQ
	(envelope-from <netdev+bounces-270939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:03:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8D305394
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D08CC302CD2C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62F3D9043;
	Tue, 24 Mar 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pmSoveqK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BSmvWg+X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEE36493B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342266; cv=none; b=Ml3bHfgHDCCof4JCpW4ku0Q9wgnbgfApOFjvJrucsS5ufPpticuChAkl8nBPALkNxSV8V4upDpCnkyoybS3hjog6eoMyJHo2Jg41QRN+X3baGgLcKK8Tqd1X0WA5sBq2wSf8imzGCnv2UdGIOD2EefJlaK5+KJcsOiiWVykSojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342266; c=relaxed/simple;
	bh=BP5xFVNnKfX2m9xCmdZElzXaGLxGrOE9UsIMD7cdVa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqVW8xkh4EQfNLyikDaX7O+A5bYuJpBCGmIS2cs6trdsxNusg6Pg5fGe6zbM4i4gfheTzGXI0BQU1kFHwMH2Nv0wA5Sp5WFVNmk5d8/YJJwadKXRGPZsY82G43JFl3hH2pyRBgRnIXeMSHp5T8MUCixB6I/Es1PZQuq5C+e+yMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pmSoveqK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BSmvWg+X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O430ZX3170664
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YkiOxI+HHv75B1gNQVjhEMF2BsDrdOpMpI/IECrj0mk=; b=pmSoveqK/7gCqVq5
	7PyzUZ3lOZPEyCWLcbtOC3CmTPqklWnLNJdPy7cepY9z5pC2atn3YZ+XBkO99i/r
	TftOI8llRocGqC3t8WnTMp6vBk0fCAGNrvOJR0mnK9kJPcf/DT9Iwa+UN1HRAp8o
	HYF1RIRpf6uXPa6r113y8CVCcxZS56fGwd5ArtdW6XmvWneQUNI9CMSU96OiY8pF
	kzoj8U77UuVy/lrsA8kibifksrrJsjFthe17Gx9xQWOFvlg9WjdH4Ym+47ygXhif
	ppQnt6V4ZIu0bkP3R0MrDDws1ZwREMb8zwhUpI+W3i5NJFslyonFmJM6OuyKs8YB
	II/zgg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r23v5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:51:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aeb90532f6so23341365ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774342263; x=1774947063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkiOxI+HHv75B1gNQVjhEMF2BsDrdOpMpI/IECrj0mk=;
        b=BSmvWg+XY6EpJeGiGJ49My7IFX71KemsLb5zRUVas7YVb1GBlq8A8mGmGhvVF3IU7+
         HIFk9SkrEdReQPU8gWBmUyUzj1eVXtkBtFWio1EDN1jxHMSUNt2Wwuhbm1vYShVoKvq8
         CwvaqgshSo1SwBPQxTAoxpopsmYiu5g7l9+zecLybHyvoIdBREv3NwDG4KsVwJ5FIYhY
         qSn44pTB+t0WyIra7YiGBM8V0ebP9qi4scyhRHz24QH4qRyODn4K2GrQC8/wWIok7zNS
         UrhiRNXnCgmwySPOHoodNVgfYXUZdfXtkONvM7qGp9hSuPPfBECDcpk8jDr7rYEgfxfa
         SETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342263; x=1774947063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YkiOxI+HHv75B1gNQVjhEMF2BsDrdOpMpI/IECrj0mk=;
        b=YuWBrp/RDlQ4b1UbUizKMSeR0RSZ70LhC1EU73t6ifpwDEgY07FvuMRsgswQfBeCXc
         ZyYBZXXGMYpCQURmQ+2oP7ArNOpP/7Z0MuxDUyILnDLjx0CxX1KSJGdHsr47pSQvu2XG
         SXqVTntwYjtFYQTE4IGxuBp4zkEAneAy8fX3sW8MFp0Xi32JQwvitwakfA+goWnAGBn4
         kOE8GrrumLPgeQ5JY81JOVJayxSjPoomZW31J/eniYLLWaNCWtv01HTRk+F3geAnmb+2
         XvLUaDUK4+cTyFutGkzz3EW7iWRCNyYeze/9F0MI3+TAd3fZw2lvSoyx6z0qBoFWZGYM
         m+1w==
X-Gm-Message-State: AOJu0Yym+aEQV28ZhQZw/XR3h2UyPbPZooXFX7QD5ihovwbU7D1DHBlQ
	JwQN7Zd8YnhkJZPaXsT/SCvSanYlRwThFiZ//zap/EEbUCN+h+f5VXDrdv5K9HKxklOhOrdg+5R
	OyAJC4tm6g8lSeFoZV6+Q8yhkS2QPanT+irMt20K8E+1KIIp6kpM3KGLsRUg=
X-Gm-Gg: ATEYQzxuj8ctd2a/qzeZZoUbIC5mYr0bgA62KbHPdbSWmHGSgKMARRwieBMr18j2OXr
	xKj7/vsVOZN4xjhmirML0NQDOhA4oLD00eYZIg6gQCjVydItUwDdT5x4mvs4v54SWWf2bBt1qe9
	oGih7CbhaDfpa7gakb1pzPXdijGV/sWx4XRWsBoVYdo428EArxNpVnZ5WcVVVVTGfn/Iv8uppCK
	/GjdRcxXzl9/dGJqhHFfPbJUCSiye4scG8eKO/eq7+4hCKNjBw2dHIIHfJq/NbjtFOgEA64OTeR
	mTYmF0eDmLYXVMMrcNTHx32uH5yC9xF1yP9eL7oiWkF/evvy/2MKLOTTNAZ2vR7Atq2HgzysWyI
	vIQ2m7JMnDTPjk8Ie9ZLXyqY7UYN8rLW5cCrnkDkQJcEeuhtGIKrdgNB5SY8=
X-Received: by 2002:a17:902:ce8b:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2b08271a388mr144310955ad.12.1774342263197;
        Tue, 24 Mar 2026 01:51:03 -0700 (PDT)
X-Received: by 2002:a17:902:ce8b:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2b08271a388mr144310555ad.12.1774342262653;
        Tue, 24 Mar 2026 01:51:02 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c4f1sm135752265ad.59.2026.03.24.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:51:01 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 14:20:49 +0530
Subject: [PATCH v9 2/2] net: mhi: Add IP_SW1 interface for M-plane support
 over MHI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-vdev_eth_next-20260323-v9-2-da6e4e486437@oss.qualcomm.com>
References: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
In-Reply-To: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774342251; l=1328;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=BP5xFVNnKfX2m9xCmdZElzXaGLxGrOE9UsIMD7cdVa8=;
 b=AOeaB1qZgeKf9F+laUUWfz+G0SYZ6U0kryISrayJS7D00Y7rgICwY36KKQ1oUdxrg/+oC80nS
 Hxwf7lZhr+TBnTNj5rZLQV6D/1If6Z2jMQfAa0yKrvM1VG0lTPGWWVs
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c25078 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HGtN7mBKGNpjqoInwjYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: JCP-FFXo_bl--o-P6WAFCYWmsfGdkQ9a
X-Proofpoint-ORIG-GUID: JCP-FFXo_bl--o-P6WAFCYWmsfGdkQ9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3MCBTYWx0ZWRfX52diakWppova
 SXpjaEjkYRY5mI6MMDEZNsdW6P9BqhWu9yHz+c34C42Xbl1FL4V5K0UrlM443lgtL2mqUAnZRjP
 2Epoy2Fj7nkW/vlnTrEvhZhELOru+CMQcnIaC/uX+tvBZEA++HuzK89bnRAdk4zyuus45NdFRQz
 kzyUv82E+i7hPPCqmWCD0XIeph8L+n65IsVnHwyAbfp5D7BZNxgkuSl8NgEMoaBX1TJyt+tooUw
 d77tE41/78hC41C8UBDn/GtLybPsIl4UALoTryKUaGLnTYWf1hoEgydL5rIstrVm3prMuo3Qq6q
 cSYVLyq4tE8P2WPnHT8S6tRK8Wv/82PTIr//L+0IJ4LhXpDULsimTJ/PNULYHzbH+KPrmPsKT84
 hHjg82r05zAdsysIEHZhjCD1aI0en/pLZYp86shsDeLmsV9UqJefT7897CiyJT4jQBzB/RLRYHD
 7F1BFke331ok7l6eANA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240070
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270939-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74E8D305394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce the IP_SW1 channel to represent the network interface
exposed by the MHI device for M-plane communication. The driver
creates a corresponding netdev, allowing the host to access the
device network interface over MHI.

This interface enables support for O-RAN M-plane management
between O-DU and O-RU, including capability exchange, configuration
management, performance monitoring, and fault management using
NETCONF/YANG, as defined by O-RAN WG4 M-plane specifications.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index 87d8c61fab983005eaea99603d74a557d1483b6e..b53ad126ee1f048748971abc4eb19e2636ae7cc8 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -430,6 +430,7 @@ static const struct mhi_device_id mhi_net_id_table[] = {
 	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
 	/* Software data PATH (to modem CPU) */
 	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_SW1", .driver_data = (kernel_ulong_t)&mhi_swip0 },
 	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{}

-- 
2.34.1


