Return-Path: <netdev+bounces-283791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B94Osh5+GmgvgIAu9opvQ
	(envelope-from <netdev+bounces-283791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8194BBFC6
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9591A300B074
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BFF3A5E97;
	Mon,  4 May 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H/ddTn+W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FB6HewFx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7037DE85
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891734; cv=none; b=FF9ohYKj0kVqdJ+9Cb5n6AKULv0/Npr4RnGBVMyA4aNLAb2VHledgdthjPx6X7+THbFf+8dFMNhnV5QIYn4ZdqYQb9lL4d3A6Ou4G0dhfF1Kdu/3WWJGkg24+3WsQzy/c9mJyKKhuSpsCxj1s/s4kvvXWFNFmpE41JOfio1YyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891734; c=relaxed/simple;
	bh=uTlUQACvmbDEV9HCwCQjfQKmIVqC4d7G2qr1KVpX1w4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rLcIe4Wwg60numqV2DGJwPFPcwxQsuCd9+DIt39sl/pDp9Y218c6RH0Vwb08POcZQtJGFahCTyH7uhql+NYFwga+su8St08bR+z3wLCqMb4TmwN79OCQR/DonLWZmucZGVRxKmCgUKWGTrNehboGri+8YsAaKbXmNCFFtdGh1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H/ddTn+W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FB6HewFx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644A4ov21023656
	for <netdev@vger.kernel.org>; Mon, 4 May 2026 10:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OHF49pHPHlCswJGS2RotCL
	4VQnSkkpNWBztrFc8PQfQ=; b=H/ddTn+WfUAfK1jZ2JAhJAmv9YxiXwqdcq5SRX
	5jVhnWTrJ1ss8H6TgttsLRvhcPQItq/kOdWz1vgqwGeKHmjWVeF6dwtV6qX0SYal
	1DPqPdD4HStZujeV3wNnEi7/nJFjhi7KnjEjLLkTdisvk7ZlwpkHIt09wa4vZ8nK
	8Nui8q6x20pZ5hpYCm5PA4+xYRSPOAotG1w5z8Lw032GjqLRqlU/aJC2jgWcAdFh
	NHi7DmgJU09SwHzLOdN55hb+CbUmoDtVhzLO3/n1/6tXQ/soV4GqpVksJtpxBKk2
	TO1dMasVfYIEo5fe9zn2M+1nbrdKDb5F0UkHYPnW28obW5dQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscy8435-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:48:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365290bc580so560166a91.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777891732; x=1778496532; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHF49pHPHlCswJGS2RotCL4VQnSkkpNWBztrFc8PQfQ=;
        b=FB6HewFxioFrgafRl33vyV/1EV84NxWLSbLTLPS8iIsJG5ZjC3KboqYmj7JHFOAgtV
         fjj35YdtxXPAQvQhb/s6306fCHUgTG04uAexEtEWW24wBrrHDJ8JQklUmbGL9lw/cY5t
         TZnzO2g8ZZU+x6PmNsyHtCd+DturkaEFLRBrVNNbNUyym/PQL3iY3A8lYcQVfVYjdH5u
         gQ7uUSJFhn7EcLYcM7fvTVT8mVeDVLHi5XnSFK0qqkdCk8j/IHJ+pA+juLudI30p0bBE
         jRu58Rjh+laffECFxIV/6D32HfY4+VAo63oiMilc9LrVYs5t5wyBzZw+g+aFaBTIdQqc
         8CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777891732; x=1778496532;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHF49pHPHlCswJGS2RotCL4VQnSkkpNWBztrFc8PQfQ=;
        b=eC/hrjO3K2Oihrg8/v5NjwZP3+ihZy6S0ONAFGWFPpKQo6oyVlCTml9GP2GAwH+DCB
         fPrcdyI8XhPg7yKHclc6nsW/O/kU7smWc8+1qVF44RxwHnfDjWBYgWIysUYQo43vzi8k
         bDWBpXCKdnwzK+CdtdX0ry5BrG+AvWPFinDDhcq7NQSaidw9NzB2tvn4TzuGrrEuRnMi
         GlpTvp4yCbF1LG6pWpFQ4tQzGps8zuPWdlD0cEMrQiTfkpWIXDmG0YD755ska3C2ZkIW
         r5LYQI1/+tJWWTGeLUB5E2XIIzHVlIPjVhL9lHBSbOe6sTgvkdeKTtmaMdkwk6rkTYid
         ADRA==
X-Forwarded-Encrypted: i=1; AFNElJ+6H/ewdL1FYHWLB3PK2xcL6MKoz5dqO5apXXL4OKs5ZlerTFkS8p/pprViyqOt5WvqAPr8LCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqHB1bJ60EIoDZaUOIuaYGZmRZxIYfmbGpKL0H7YGGHaNW1Zq
	76WDGj6mJDTCf6zGJWKvzDmyujQIAJISPn5/VXycIEDZu6rQePsurqEGIyDSrDe4r2Mr6wKmQT9
	QpejVyhXLj36HFG0Lo7684300gvogYh/IzjZrOZNOrocG/YdQ+HM6E8hYn5s=
X-Gm-Gg: AeBDieua2pnDCAk8O8dAnONyvWbbz9bb1AOHQUpBj3BJ+rwK0eqj2zpwTSCEhRlucIl
	dpX6Nr5Hr9KbYBy45o09KkIrTVcrJov95j2KnrSh5caJ7gjZCX91tO2NdGti63s5WWfqyW1Bnj8
	ZdGvD9vHb+twJOSjyScwcDWThkcUqr3snVG5v+E7vfWwoZllICc+8uMXKgMWNEg8eS3RRjgqPUz
	ilLb6L+gy2tRZRIOa3yzFV+dHWMG+iLE+T9jMyK95X4+Faj6rqUQ3UsWVfVZzyaG0SO7uaEky35
	cGYLRVMhzp39z0Ms+RAJi3R53Lhj+32rCRagnt37KXl5iRr2SsoZUnKd2mKj9xblUCw1k1fEzhu
	16gKbWMiufVrz5yu0CVimmtYVYX8rTXSNec6xa0KXeYaRDAo=
X-Received: by 2002:a17:90b:3c0d:b0:35e:5ae3:299d with SMTP id 98e67ed59e1d1-3650cd4a7fcmr9184408a91.11.1777891732129;
        Mon, 04 May 2026 03:48:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0d:b0:35e:5ae3:299d with SMTP id 98e67ed59e1d1-3650cd4a7fcmr9184388a91.11.1777891731702;
        Mon, 04 May 2026 03:48:51 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae68443sm96799365ad.81.2026.05.04.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:48:51 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v2 0/2] pinctrl: qcom: Add support for Qualcomm Shikra SoC
Date: Mon, 04 May 2026 16:18:41 +0530
Message-Id: <20260504-shikra-pinctrl-v2-0-14e9dcc2d685@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIl5+GkC/3XPQW7DIBAF0KtYrEuEgRrsVe9RZTHAUI+amAQcK
 1HkuxfHqrrqBukjzfszT1YwExY2NE+WcaFCaapBvjXMjzB9IadQM5NCdkLLnpeRvjPwC01+zic
 eg2nBdehDF1kdumSMdH+Bn8c9Z7zeqjvvn39sbdlR+4uW5ClwkAZQWe8MqmFpN9VBQe7T+Uzz0
 KjeCB2FiEYbcKBaXYneGuHeY7DgpRLQA0S29Y9U5pQfr/uqtS3w3ylLywVvnXZOOgU2dB+plMP
 1Bqet+VAfdlzX9QdiDpX0MwEAAA==
X-Change-ID: 20260429-shikra-pinctrl-fd71ab6ecd6f
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777891727; l=1347;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=uTlUQACvmbDEV9HCwCQjfQKmIVqC4d7G2qr1KVpX1w4=;
 b=JQtArEYM/rET8ZvsBIjX0wfnaGqo3JPcs6y3wh5xN/AEqOOXiIySmvEPXIHmMy8VMpDxsmXnh
 rf9TuD3UQDDBJuiWSjZHEHR22q6hmw1aRF9cWxQ4SbzO8ZsAdQXL47O
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDExMiBTYWx0ZWRfXyzcHrY8dsUrt
 KTZQpHYVik6FI5aMPygR6WRqVEhUxKd3bMpBYwuR/lxmDqQFZ1IrIVnaG0f5FRKngIUDXsZ7ZH1
 /CKsWoIvWr5RP86/nPjHqrw2K4FJ7uXX9KPAIoEINN90IHdkHM9DkzI3b9MU1iFiBoMcYfgxoSF
 Z3hZLjLufUJKpJ/rzqEwTgLPlzQ8ChDklxdgatTPkTksYY9BXOa1FvNwozLtqYHRb62Rt7CH8fX
 kEah8uBTzpg8mlrprPTDISzi9ptz6KfAZ90ezGXP6fzNSHVJxovr19rvl3cCyQs8u2JHf5luKQT
 5rGsDKih7vjDG0imP7npwZQo7YzdTEZQnSxBc+/nd20THdDXAnlPdzrAyp1jsu7KKC2SCsoavEc
 4vrhCq7oOW4TylamXVZGW5F6wkv7KHsct0E9g0ny1R9Q7NFkkMjzy/vjPL+abOGymtRnimzy1Z1
 fmdJHsZ1NmPgLZ6d/9w==
X-Proofpoint-ORIG-GUID: 0xkDutpN_pwcMxnEb47B0Z4qNMpyk-yx
X-Proofpoint-GUID: 0xkDutpN_pwcMxnEb47B0Z4qNMpyk-yx
X-Authority-Analysis: v=2.4 cv=C47ZDwP+ c=1 sm=1 tr=0 ts=69f87995 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F7K3iWs-JhacpI5SHW8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040112
X-Rspamd-Queue-Id: 4C8194BBFC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283791-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add the pinctrl driver, document the bindings and enable the
driver in defconfig as default.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Changes in v2:
- Fix Kconfig description to drop "Technologies Inc" (Linus Walleij)
- Remove unused UFS_RESET macro (Maulik Shah)
- Add spaces inside braces in shikra_mpm_map (Maulik Shah)
- Fix gpio-line-names maxItems: 165 -> 166 (Krzysztof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com

---
Komal Bajaj (2):
      dt-bindings: pinctrl: qcom: Document Shikra Top Level Mode Multiplexer
      pinctrl: qcom: Add Shikra pinctrl driver

 .../bindings/pinctrl/qcom,shikra-tlmm.yaml         |  123 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |   11 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c              | 1256 ++++++++++++++++++++
 4 files changed, 1391 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260429-shikra-pinctrl-fd71ab6ecd6f
prerequisite-change-id: 20260428-shikra-socid-a27ae38cb7e3:v1
prerequisite-patch-id: 843f28095c0d42d0d60ab7000095c64dcb2e90ca
prerequisite-patch-id: 1069d6880c3ff91c230c20fcd876738001c6d35d

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>


