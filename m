Return-Path: <netdev+bounces-275070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGTBIFvMz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D47683951AE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C5630AEC24
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F13C454B;
	Fri,  3 Apr 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EcyAPVel";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cFcK0k+V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164813C3BF6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225482; cv=none; b=YztEokaE2D5bC2IDhusPAuyptjosXdIisshpl0MmDRnw5NwISTZr+N22hfHnXR5UUeLcikoBQK35Kh8vMVOtINdMJ0/7obimri4iCDarJBAhme3fzEE358HUdwYTAUZvqsXedFyzGFNUnOLpO8X8MyKvBQmEgwgW1ICtQ5Mg+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225482; c=relaxed/simple;
	bh=L1Pg2DImq+7vjEK2v2ttUsGwFkHZDAv0iSDem33OKRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ilr/lzMaSHtYB5IVX3BHunjLlGSFNtoMV84+8RTN7wSCuRh+VMcsRes217KOkh3jyD8uVMGpq8BlWHrw691Fv3SCNLymP5lX5jwRWgVikd4InPOi3KdbazJL/vnncXZo4qGrMWFMdBUdosws8B+c3wjEN13kLCE898zFs+8j2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EcyAPVel; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cFcK0k+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6337GXa72707221
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 14:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WsllSCq6C84HtAi0olm1ZV7KgvkWp5Ncx0XiKo5lP7E=; b=EcyAPVelvaa5q0Ae
	Cd03BKFaJdKDuiErQ5Z8e2QsKjw0/HtWQuA+v2LV//QepPWXC01dJIWWGUIn1thB
	sFQlk7YM1HSIlKUGGuY+wV3NteMXk1dsKCi3Mfy3yInlJ0rLL22jqTQOv7u+ABFF
	IOt0scZyMnRHwyfzboPCdn+yuWe+Jb+b2zXpqRmzd6YWH37iV67pZWQXNOoQ+Esy
	a7oziANpEuULfNwbiwo2cfh4QrjaianVDrDkzSG7sMQ+OfJ4YMJpDj7QI8jbYSiL
	SoFonZi69c5atCImW1USQ3olcMz3yx2nJ62+te5em9QTHZouTiACaeZZfIEMQBZq
	YEhhLg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjjp6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:11:19 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94e4b6c8cd5so668833241.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775225479; x=1775830279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsllSCq6C84HtAi0olm1ZV7KgvkWp5Ncx0XiKo5lP7E=;
        b=cFcK0k+VSFXJYOx0PXYFp269qraLc7yPmLo9nph4NETADjLgNwXYqZ8OGWCfNYcp9z
         i0QOmCOPdzY/iO+5/GpdqKDD8S1uIOD4YbCgRtRS4Pa94uZIDb2uWRYKai4ZGmCR1bs4
         o9bmgamv9fExYugcFopwp0XHNSF2qII0mDCeZEy+pyDQJi1tRFbFnM9eFpBk/5CRn1Xx
         v0lu2ApIrt7PXFMCWI941ctR3DA6vbhcYXj+leX8CyorJubwTzll/qp4qEdtpZIWbe/b
         UBbjbaUB40uj0WifUvE1dCkPQhx2Os/tCI8cqtUq8enrJ0IPJdwZjP9NrbBsjABcMcMT
         s35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225479; x=1775830279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WsllSCq6C84HtAi0olm1ZV7KgvkWp5Ncx0XiKo5lP7E=;
        b=Out5bGsOFiwE2Qv3vERq8z/XndaO3o6fLS26ZjszCrAjUaahDkdxoA/+1ZNxyOHb3J
         0tFRYgz7xSvEj205ED5NG1sQS99ZxWgvvlTutlD3r6jymOibwadhG0ArLvUiPj1cv3t9
         i1wwmGQZMqQkB8vKfW5+InndMcRW/lwv6QNxJrmQnQlniRAsJaqDo5d8CPYMwU58aiLo
         5+yAlGE/8FbdgczHW9dQo4I3m7M0TJvfbXAujBm0UFYDZJQks9L29uXQPHBgY61On1Ue
         YTTswQSil5o2olAvGWOPb4MiubFj6nALESD9mxkOm3Tc0FTev/AD4TisIy/YpIm9ynUg
         M3bw==
X-Forwarded-Encrypted: i=1; AJvYcCX9W5JjnD34dbjCM9NnkUa/1DXgYdH6fRmKmzJT7Sq+BfC5vbvePS1exq7AtSghlgJUs95tfwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjObagfsaRwn4qVJqs6blu0rZRJCdTq9yvhOSs+AgUP0N42Ywf
	TesovP+C/ZJToJ58VAYbNWvkaVtrveh/7YNCUkGchJgqBxENJQcugS0mqZfmb49adp/vUjFOb7M
	5aRXkSycwh7gokcDZkwJTAKn1ZaoGzmuJR9D/2OkLZau5KQ3XlMwekSUdNlQ=
X-Gm-Gg: AeBDievkqR5aGkzejmD2LL8KPyINH+oO11HOY7m5frU9QcC9/LQ5NYJfdWqMEqU4WjS
	+6vPw2XaP9Zqk93R/FU+CDF7o3mboX+F687bt/CAT0LYYovTFWoUUHMqK7U+gz2M7lX5QkNfIBG
	lpdTJsstAtdAYhciBDXJIPmOjFidY/ctRG3MCsQUVfFPQgMqqBE1CKKn03zhu5OaU1JfAiyqYym
	TANUgSqdQzzyw/yGPmxAz94ldSFDBLbp2UCwJujTC9YX5NKX/kUAnueg62J6T2icvy9JRrihcSu
	y//q0UYQRuYdKRMFr0HoY3lgv7NVHoEDPJGA3nVPJXHzB9nvomjk9MFRPWgnlNltl9JOgr0CuQy
	uvg8meUAOb8RjyHnp4EQcovKPszm+pX11XtZF9R1UsogrIGuqiO4=
X-Received: by 2002:a05:6102:b14:b0:605:26eb:cc1a with SMTP id ada2fe7eead31-605a512c49dmr1023755137.29.1775225479149;
        Fri, 03 Apr 2026 07:11:19 -0700 (PDT)
X-Received: by 2002:a05:6102:b14:b0:605:26eb:cc1a with SMTP id ada2fe7eead31-605a512c49dmr1023693137.29.1775225478720;
        Fri, 03 Apr 2026 07:11:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:129d:59e8:f7c9:47ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b19esm30127315e9.6.2026.04.03.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:11:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 03 Apr 2026 16:10:49 +0200
Subject: [PATCH 1/7] dt-bindings: clock: qcom: Document the Nord SoC TCSR
 Clock Controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-nord-clks-v1-1-018af14979fd@oss.qualcomm.com>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
In-Reply-To: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2692;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AyAcliCUWAjW4ermeATIw1vRy5W7EApnIO59761YyJ4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpz8p61WK7iqwgWTqIT3d25ee38kUXCXkqpyJ6r
 FgZKPVKeRKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac/KegAKCRAFnS7L/zaE
 w3SiEACncAOXhvb/hs6HH1RnCDpjmnKuFWxxLWGVxpOA3RwOaIsHNb1QcDJr9TVuGJI8wILaBjT
 qFhM8dvMNEX4DGuPtBJ1Glex71WHMZispIkBrW1yjewa2h0v5Ml/8CfpIi3Nk3yIHAlLetFf/L6
 zu67cZuBFDGZplvVw4ujwBbHjCSQXMxKjJVK7WDo4rcR8ugHLJz+foKk0hFOBmBz2LPoWXVEvN2
 hZPb0BKBCM/pr3TvbahEzfXlWQBLJUGFfogABxUmC8XKrX7TLJcqoC0HI3RWJ1M2Q8AEs8w+d+v
 mvjaWwm3c5H5WTHnfDMtI7oZGRtipyl7Z2YSNeDoyaPEnsdjqZ3Zm6D3+NpAaRdpN3YW3Ep4Y2r
 Zmird7FcbmaLM4vS7TX0SOQhFDJ3z6hls0on+bEkrc2kqB0J+aA3Gm45ojIR2EXegZtKdhnGxVs
 +j+erGv7NB6yHtKw8tRKzGtHCSz4Pa2ZrPA464X98b4+w5svKG3zDsvQ5dJlY65nEcZzvh9vzN/
 CiRdS+9I7gpBMI2rup9aJKleIxf8vcDcwr6Jzpj4pB7wZ315aQLEIroiZ6OYsQpMYReVT6dJylc
 Xs/fDMcdlkEI+8Vwcj5mKfhrf4CyHMz4tp/riexu9rZw2bNXcGymgiZ3eprvSky4inqqrS7HQOC
 zmQXyIIrGNk3OTQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: LnsXqB4pXKgUk8Q5iwVUNTo21FfhO2RJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyNiBTYWx0ZWRfX7+/Q8gaUa9IS
 edF4O7k4ANRi4mvZKaNN92eyLf0FIZVltu0DowuBr/dMvxvzB2cuiWXDKUWzh+1vs/u2yVj0PhH
 4GOFtbQt/n2YQNCwgA5NGEGpOeg1LDffYs60gTC4ER3vFYzNtGnRZAFfjKbehrB0YYcDJjBh5Px
 cm+di2du2/t/SUbNe7Xh1lRv6E9JucO9ypIhD/fVNlm+uwQr3XiPAcgnYINpNRv6DP9HqPk0M0W
 xw/GYLedHpTcKX2OmEe5AtV1H3M92zgGVH3r601ivb3fTa5RqmUofHUR6rkliahIp1zhuGCXbJi
 sj3S7uLXa4il+A6odpEO3Pyx3uGClqyUu19uP3KqRginaiWJ1GrkAtiVbOtprRHHurXFYZNc9LI
 CEMGf2dmdn9Hte4fLaApxam/QufvfYOtD936IR9gqhgMbKSX8Pj9ZxStVRw3kpDSwbiQJu6nGCT
 8x9CSTOPvS6G1g5AWHw==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cfca87 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=yi_j7UWu5214FLn0tX0A:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: LnsXqB4pXKgUk8Q5iwVUNTo21FfhO2RJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030126
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275070-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D47683951AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Taniya Das <taniya.das@oss.qualcomm.com>

The Nord SoC TCSR block provides CLKREF clocks for DP, PCIe, UFS, SGMII
and USB.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
[Shawn: Use compatible qcom,nord-tcsrcc rather than qcom,nord-tcsr]
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |  2 ++
 include/dt-bindings/clock/qcom,nord-tcsrcc.h       | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index ae9aef0e54e8b8b85bc70e6096d524447091f39e..1ccdf4b0f5dd390417821494cdb97d8f4ed26c58 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -17,6 +17,7 @@ description: |
   See also:
   - include/dt-bindings/clock/qcom,eliza-tcsr.h
   - include/dt-bindings/clock/qcom,glymur-tcsr.h
+  - include/dt-bindings/clock/qcom,nord-tcsrcc.h
   - include/dt-bindings/clock/qcom,sm8550-tcsr.h
   - include/dt-bindings/clock/qcom,sm8650-tcsr.h
   - include/dt-bindings/clock/qcom,sm8750-tcsr.h
@@ -29,6 +30,7 @@ properties:
           - qcom,glymur-tcsr
           - qcom,kaanapali-tcsr
           - qcom,milos-tcsr
+          - qcom,nord-tcsrcc
           - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
diff --git a/include/dt-bindings/clock/qcom,nord-tcsrcc.h b/include/dt-bindings/clock/qcom,nord-tcsrcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..3f0e2ff7acc72c10d00488c48ec17af8ea6de06e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,nord-tcsrcc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_NORD_H
+#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_NORD_H
+
+/* TCSR_CC clocks */
+#define TCSR_DP_RX_0_CLKREF_EN					0
+#define TCSR_DP_RX_1_CLKREF_EN					1
+#define TCSR_DP_TX_0_CLKREF_EN					2
+#define TCSR_DP_TX_1_CLKREF_EN					3
+#define TCSR_DP_TX_2_CLKREF_EN					4
+#define TCSR_DP_TX_3_CLKREF_EN					5
+#define TCSR_PCIE_CLKREF_EN					6
+#define TCSR_UFS_CLKREF_EN					7
+#define TCSR_USB2_0_CLKREF_EN					8
+#define TCSR_USB2_1_CLKREF_EN					9
+#define TCSR_USB2_2_CLKREF_EN					10
+#define TCSR_USB3_0_CLKREF_EN					11
+#define TCSR_USB3_1_CLKREF_EN					12
+#define TCSR_UX_SGMII_0_CLKREF_EN				13
+#define TCSR_UX_SGMII_1_CLKREF_EN				14
+
+#endif

-- 
2.47.3


