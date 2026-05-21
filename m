Return-Path: <netdev+bounces-290282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMv7OcXFDmqzCAYAu9opvQ
	(envelope-from <netdev+bounces-290282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B3C5A1514
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6797230CFC96
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599B363C55;
	Thu, 21 May 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6wMyh9G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/1J1mnM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820473A4F3E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352637; cv=none; b=BgY+S2WeuNryXvbyPH17WkExYA3/XcI6U+ZZ/X/Q2wR68jPPYmYXHrAamfAUZiOMnYOS/TCNP1tC3yuUmRG+aDaVcOBKBG7m6051+tmQnLJh/6x8LvCcQEKnET087JYKOBuWrnWARKNaxLQuoXs9ECa54r8dCqbYnNw3dcGxWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352637; c=relaxed/simple;
	bh=Vq0LogXtRhRUgP5LIHiwXCljDYw8Y78nK8IIxKqwPs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg61FS+E4Z+iUv6GKejRnwtJO/BLnbiwHYKK+OX7O6pv6BLz0eYuPAkmJhvzaMhQ/4tMvNCVYimDismkMJJN28eeg7+F29zZ63xzo+z/YEIyE+GrqLQrGf8ts2iVfOqUBAcgSHiP0KoF2kN35y5OqJKRDIg2N1FaBLvfNUGkJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6wMyh9G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/1J1mnM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L62Qpj119071
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=; b=D6wMyh9GV2fJQ0Zx
	f4KBiA4rm8ahVwft1szX4Pu9Nvj+9vf727ddYumyeLD0bzMfrAE0KZ6oHgtfqiSc
	R/Z06LkiMRARLiTkVZikUVyqsKOmr9dYD61LxYNfvUzMQJF4/TSfkh+8Anc6UMkV
	HLqDvBgreugoJt7iZIgoc+bYNdvsOfM7F0O7wQra+ECBQo6ps2B/n9dILSJaBJqW
	p9EhZ5DCZ3JyhQ3ALihI8Wq49SQxDUpWP43KWy0dtQQSSDgN6tWae6KgXXih3U31
	TgBtZjBrQOT4elKE4UaqnfddJYpqylEtpJQzRFXRHCI4S6eoz2u+MlPmc7GZCH+M
	ehUt7w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c16p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so167916051cf.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352633; x=1779957433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=;
        b=O/1J1mnMmvTk2Mx1H9Uogr4rgM21EiM54w1AToZXKNQaV+8SlFIoqiRBtN7vxJWe+A
         ZMCOhiT+OB/Rco9kS1Er6nlyD+eLpWvTxq8pEk91u0woybwSoTZMIHoRhjLfCnILbKUz
         2JJhK/t8kBdQTNRNjnXmM29gt/d6gXXjCtLuX6lhqVWj/I3huc+jR6j49K7dlUBU4zhs
         aXftcrsSwSI9z6Cz+2GWDar/0lQ8jPLuqftOVFoRL2j4NGGin7OJ/Zzyd8bt6jH953q2
         6AGuiYwjUmnjd7PSnUcH+VpKQcnIgeB4zvr/I5yoVmXUoEjCrEMQPBxpJdtQEW7TTuAP
         /4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352633; x=1779957433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=;
        b=G9+bfA65j7h/R4qdWpx0U5D6U+DQT5Hqa15H28cLTYSAl54BftCG8ytbvjzkufPRqu
         yA0tRNmAWO6Jfd1RY7+ZRamT8WOwDOjbS984a8EE8/DRi2njAI3lT9sBiFIC3zU5thxS
         ZyV8CqVoIpFDGeBebsv3UZZLZrtbLtS6P6JlFlIHY3fgtgUpIOfDPpph7R1xUwkpYqdS
         tDzfi1C6wlSH1Iif0K2hwygQD6PuKVc7d58MOmoJzqeF9UkUPginJ8oZgnvUOBSL1QV+
         Ic6SBB/bp7xLKRHsFVNoiVlaBnAAlxXIt8hAEG74PelNKM43l7Zqrf4pochIMQBVct/o
         X4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ/ODhkl534Nj8UYWy6VzQe1CwUiNBXDmy13NNC3q8AJ+nIMdIRVticFKrg23Ipps9Tls56ykRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNJKFSP+M+khAIxQ9CIYL6Eny88X/Ez0XalT36W2rXxPdjSfp
	jtaZNV3bcUdb4OHBCH0nBEPEFIZMAxIiKhCunflXFqLgKKBB9dKowj5BOJ2kVWFvpVyfz5wH//1
	JFybxWs9VPoU8Xt2QPtOUiDFTt5DTNguwpdyf0FSV50wKYQzU3Zqu1bbIoL8=
X-Gm-Gg: Acq92OHhmhsITDJ7voeGrTyndUk93Fcgsd+FxWJpHn77VWqKxKY+25kAOdZ98zoZaoj
	5VrTyn//1Y0fQA4zMNeRf/bL2b8nfl2DRTGjmOf6/p5Lw/RnTIDulMAfghjbNUqjglpHF6q03Lw
	HUfhwH+djqoTke/lNRxEJfchHozEvXrQqW0/Ajprb1l4OIOLwPy3cFU7vxwYj8gUUmVacRJk0Xb
	CfYYXhqJ1PK5cMiLbHvvpSlWiB4+ey1sdkX8dOkCsny0FJPmJJmHSfTmmob4k8wdHku10m34M9s
	xstgYHa573hOjQu5oi7GaUb3BxVBfK3GsRzcWaH3RubA2YUDEPBBdNei0pOe2a7y6N84sJANQDt
	OmOsNPSDqSZYmaYSsky6MZcn5CFd7EznFzOc1SLc3xK9JVR3FUMk=
X-Received: by 2002:a05:622a:342:b0:50f:c65f:a4fc with SMTP id d75a77b69052e-516c544afb5mr24559001cf.10.1779352633439;
        Thu, 21 May 2026 01:37:13 -0700 (PDT)
X-Received: by 2002:a05:622a:342:b0:50f:c65f:a4fc with SMTP id d75a77b69052e-516c544afb5mr24558211cf.10.1779352632852;
        Thu, 21 May 2026 01:37:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:25 +0200
Subject: [PATCH 02/23] net: mv643xx: fix OF node refcount
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-2-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vq0LogXtRhRUgP5LIHiwXCljDYw8Y78nK8IIxKqwPs0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQeyipWeVwe1gZ+CShmDvyxkCw/2ac+wigtc
 yDfWrx9B7OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EHgAKCRAFnS7L/zaE
 wyD4D/96Sc4XMe6BqcGdeU5XMrq255mM+2Q9i1CnFxUGJYNsHRGALjwq4agMpWWID3Xz0IFWadP
 f9cYo4zSx5YrZJ3NC8aBSnDFEgSpaoPv3vd9dR2i8safu4aQx7wG82O3RVcGqAtL3shTrfG+ziV
 24wzbVP4UKjc4kcw0m4sVpF7kpzz7f5uypJ40k4tC22VMdLsN48F2nNloAOonMA1CRtVwaegwPS
 +LUzSr8fUVE+Cxwfhm9M9QMbPPQV+Xz+9D2lIV7JibUmMSyMlUkkC6W1WGY+EE+y164ZvEPQUQ8
 pTOt0/CtDCCs881XvieaOneXcOv3CZKeJfbv1pyGp4onPZPod1ja8YYi3oKqQoKx/gipqSIa+KZ
 Q/NIA268QzWCrxR8+M+BFyghvPzKE3QrjxrAPc3rcoL21lH4E0UT10PFSpkt6UoABVUDQdVTK8R
 RrccYHir46M0LNRd0CQvLxeHCuup/uV62AYyq1es4haCqR+Sd8PD0hE4YjipqixdOX1d7vlbeSE
 rgk90YNfpnJQ3q+VJCtHjTCKFzSuzfumxnfLZNPUSMSvUO20eJ4PT3Lo1yq4VTiixwQqm6Ev6wg
 dUzkMbEHmGi4j5dxcRVozkGO2hBgM1870hwtdEda5YSqgm33yqUq5FDx8pa0vrhMYxaI4X/Iwcc
 +Nh8Ur4nvc/+Ing==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: JQ33j3ZAeGFJm90cIJeoaIU2Ko9U6RoC
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec43a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2glh-Q7MoEu8omcI7JcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXznEe2g09avK6
 W/VQLb+0zZzhk1JjL9rbWBd3LJzGDIhaDLAGfhVbbtQe07DhinFEMaFWjO+UBlJ7G3HeRKijzO4
 uTLi6cam0KpeAZAVJjNu2qD4oLg5O4KrXnTQrObq6Ey2Fb4A7cfevk9WU/0YCla0BGw5EJzYlPl
 KwNK4ahkC2V8eo1E+29Tnb9QN2uKom53AH1XBaTpUo5rPt6VYce5dwcW0ySmsbac4csaRSrxh7j
 XZehOWCvNu01PEb2xgnC239KyaTYHcnHinHG8+FOVKfSbbbPV3OVtiz4qqHDrbUaBoFt0BDHCW7
 6Z9RGZT5zRJxCg+SfuH+DtBwQgk+wmfCSwzYymaDjAJyWcvxyb9CjpHCt1h6B16Zg5dOkp+9dL0
 RuhgAqSvTRuVIzVHVWsdw1Wp82R1DHpk/AOi1NN2YOHHdAxtCLGLE3cbWhgRv1z+0ZAVB6YipOz
 iQDeQ1dj8X9480+zAgA==
X-Proofpoint-GUID: JQ33j3ZAeGFJm90cIJeoaIU2Ko9U6RoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290282-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[67];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82B3C5A1514
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f9055b3d6fb102ebc695dce9c6c8321889a78dfa..1881583be5ce2e972fceb14c2b8348280c49ad1d 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = pnp;
+	ppdev->dev.of_node = of_node_get(pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


