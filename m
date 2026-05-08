Return-Path: <netdev+bounces-285625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCZPBAVs/Wm+dwAAu9opvQ
	(envelope-from <netdev+bounces-285625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:52:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C3A4F1BAF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC4BF3009CC0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43132314B72;
	Fri,  8 May 2026 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm03CQfm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmtIrZnw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201F27B353
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215936; cv=none; b=fVfRIJkOnm+LTc5ha9bCjBJlJK2edF69PCj4KL+sqB9HB0OLM15wRpywrcDaRgFfYZAjndVKksSNvil2yS21rdwcgKqLY/KiS4yyy8n/04Q/5p2ctNcVX6Tqa+507GUWyhJLPBbUJS5nErs9FOEUotMd2PpInhkdKUsr45EkCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215936; c=relaxed/simple;
	bh=P4C8k5K1ErvhgwFkZle4aus/aS+aZ/YlzasAP57cJFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W+fgaqWpVfJXiYLLkjqslbDQMWIBVotssuRjOWZHkrlX7UEuoljxk4Ssu4qCY1erd6WbjQSSOQ+J8SQWYCxfdBv2gfyh4RkbwB6JNXwWq0jzKHphEhQYTz3Bv8N93hwpC5u7M3oiqf+hhLv2VaZzONUz/q65yMNHPwgV+fLgxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm03CQfm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmtIrZnw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647JDAna2183070
	for <netdev@vger.kernel.org>; Fri, 8 May 2026 04:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OBZL99WklIEGKlY5KCm0vX
	ttleoAmTjvHnB0CO2GC8c=; b=pm03CQfmFyOyF+C2ZG6PM84CWcx+VWB1pp3AYl
	DyPUJjNN6cRQLTemQVlWtzGwGpwWXn2zkuXyPJXNJX+WLTFWQgQwIuZU1sgOFFig
	QBZoMxwPJFlsJaGFvWmJfuOw7T/ak4U82JBbXgftnrbK7ESrHPZuPTYjbzwVxGrV
	DYOxUWKbA9PKxxJTMCpmJgmJxfO2YZVlo8nsXVvyQ6qq39vWbpv5TEW3YE/2VeWy
	Y39pQPdGUOI1y1MS4lziEm0ZgJLiwj2sW9Uc8N8NWou09HzUaLqrbu+otuLbfIsW
	ep+4K2odqYfMhMdJXxEfTGq1r1Gq0Ybrt500cURIh5Kv86jQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10py9mgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 08 May 2026 04:52:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3650a4eb60dso1777125a91.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778215933; x=1778820733; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBZL99WklIEGKlY5KCm0vXttleoAmTjvHnB0CO2GC8c=;
        b=WmtIrZnwCImwHREqHuEyoUnHfuAWS3MugfXZ2MJjGKTc7pF31Zag4zDNO6uFNMFWlL
         8v7yiQb4Jp6y80xsX4HbphRSGrhk50nu58XQwsWUcRt6R9mHy1B8RXI9i3iv+DTzUx+Q
         BY9eh9HOVMCqsZFBVbuD1lGNtF8/ozgFg3e/ydDMNWlgRQGi/tN5Rz6jS6fA6LRZSNmm
         dyzdnHkCBGpBA89mo/5PYRBTqPqrC2uvWo0TjI7Oue2CqYEednziyhPigU77PtDInHV+
         z/cP+E5C6tLWD4oYmclQ9VbNPF96Fq1WDTSONfKwhpgHxFawF7j9z49obd9zDKdgqUEg
         pGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778215933; x=1778820733;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBZL99WklIEGKlY5KCm0vXttleoAmTjvHnB0CO2GC8c=;
        b=bCXgVUszz5ZGnHUsOjaD0TkydE6obDmzt0OglAp0+qzAyAjgXVCh0TPl1VyahT4gjA
         Apve8/kSo8rSxgAd7bWlh0IBB/6793hMLpNUno5yrKTePDxw90dJXnLOQIaQkt0VSIn3
         6VNrAlB78T1/lDr9MJn1FMvJ1gvXAayn7V9s1eLyxRxDLM70UNL8jWE6Rb0CzNRXBwgq
         IEAovVsQpIkvW1oJbqh3GMT6A/duNaDJUTEUnt6pe0Qpb3xJxf+7pofbLH4WDDqpj8IM
         QbbsLnxlmIVkkDkUaIoNbdAfVf78AXLx/D1coS+4lksViqMMW83RLD0n4Smy30w+W3pq
         AbwA==
X-Forwarded-Encrypted: i=1; AFNElJ9OSVMRAFNouK9Ev9us9xVcBlRlJLSRpGwLE/TyPPgr6p2aER18Cge4qth7pjeBN9tn1fAcuJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBWNJFyapgovQwRhNiNkFXdAgnX2ruQK3sG++Yx/jvwOA6h+j
	1Wg9J63tUim53WKamAGp1QOuiVl6f7nr+rodDZxpdVQ/FzOLeMLhklqHxszzNOfxMsNUHH8bHH9
	Lx/acEcLMyBjy7hC101bZqyafZjY7yC/5VjO6KN45OIFWRhzYaO+R8ZFld18=
X-Gm-Gg: Acq92OE4475XFyW4klK2JWDdc2SFBj8MTfLFL/5UZr+Lewq4yEoO+v05b+T5vkyo01r
	LLqStB2PGoA0AuJbZXXDKruusvw1mM62QH3ZYrlwdjJwo2ZrfHOqAaw0GitNRfy9f/EAa3yfwCV
	jIHzhm+CfycQASyaA1rTz5pff8WAsnQrijOK3tHZHaPpeJRkKHhUVR42K2/roP7cnIRkI6uR7ll
	G2eKlQGn5ikcnhyfHJMvfPKdDlhtvcgFn2D3yqoe3m6PxP4yU6t4e8VWAwut+s4EUdXH1/jfZPf
	h5KzDGQkkcFoqFFP4dSMLp8+9sOOCOc6TdBaWsxMS3PkCmwIcm3AMFxmfky5nP9BHw1NOB3+kjN
	mL83L57TurNFITpjnnNljcg4s3U0KwGjTMo3MfZfzQEXQI1ojaShi
X-Received: by 2002:a17:90b:2248:b0:35d:ac4d:3cb6 with SMTP id 98e67ed59e1d1-365ab9b8e81mr10834455a91.5.1778215932710;
        Thu, 07 May 2026 21:52:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:35d:ac4d:3cb6 with SMTP id 98e67ed59e1d1-365ab9b8e81mr10834419a91.5.1778215932192;
        Thu, 07 May 2026 21:52:12 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm556076a91.1.2026.05.07.21.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 21:52:11 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v2 0/4] clk: qcom: Add RPMCC and GCC support for the
 Qualcomm Shikra SoC
Date: Fri, 08 May 2026 10:21:49 +0530
Message-Id: <20260508-shikra-gcc-rpmcc-clks-v2-0-83238ba24060@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVr/WkC/4WNTQ6CMBCFr0Jm7ZBSQMSV9zAsytBCw0+xo0RDe
 ncrF3Dzku8l73s7sPZWM1yTHbzeLFu3RJCnBGhQS6/RdpFBCnkWhayRBzt6hT0R+nWOSdPIKEV
 d6M4Yk7cC4nb12tj34b03kQfLT+c/x82W/dp/xi1DgZRTV1VleWkrdXPM6eOlJnLznMaAJoTwB
 ezOFjbBAAAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=DZUnbPtW c=1 sm=1 tr=0 ts=69fd6bfd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OWuwaAbB12Tzs4-beUkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Rm3bPUjlF7QyfsqeKAnOq3jTNZlmG-eA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA0NSBTYWx0ZWRfX/qy0IEW2C711
 +eeI9qNNM+D4BL2oa4mECyxWu+FDzp28swW5jrjfDRXR0xz75Ct6kneFWACZXlrorWLZnak6MGI
 jGlviSMUBYpvxtKeFkCboi+zA6PYye/NGjgRxbNgpb7nFNcCTg/Hf/DW3m0VGXsbl5jBnAZ/2jT
 1mfqrkTM83Yl8HULwEFz39vvbz7kLNeT/1tMJ0Fg1RpzxSKmXotTSxNQkNBTFeW9nnyT1KLEwuA
 nLncf1/ELiYQGPCp7Dr1XD57V/tGd5F2Klu5S8uATfWwONzIuwdjCJ2QwVmuFp0bkHOlZYlVMNR
 SAEmBb17I8CUxzvPUCaR7yhK4DEnsAd28wuiD2TRbybGGV3zGBohCRo0YkQOYCoRVjKX9OfnWd6
 Z6tbzOTjy8YxqIDOvDfV0LZei8yIORf7hRuwji7bW2ioZip2wj9E3kXoRSe9otaPqg0L/z7JCXG
 sB4f7ER45BiKWmA1c6w==
X-Proofpoint-ORIG-GUID: Rm3bPUjlF7QyfsqeKAnOq3jTNZlmG-eA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080045
X-Rspamd-Queue-Id: 95C3A4F1BAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285625-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Action: no action

This series adds support for the Global Clock Controller (GCC) and
RPM-managed clocks on Qualcomm Shikra SoC.

Qualcomm Shikra SoC details:
 - https://lore.kernel.org/all/20260428-shikra-socid-v1-0-6ff16bad5ea2@oss.qualcomm.com/

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
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
 drivers/clk/qcom/gcc-shikra.c                      | 4428 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,shikra-gcc.h        |  262 ++
 7 files changed, 4812 insertions(+)
---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>


