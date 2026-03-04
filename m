Return-Path: <netdev+bounces-263672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMebEu/1p2lFnAAAu9opvQ
	(envelope-from <netdev+bounces-263672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:05:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C91FD2B7
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913FB311CC5E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527639479F;
	Wed,  4 Mar 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iUxvvGa6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKbydxEP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F16394791
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614985; cv=none; b=ENs2e28ZUymd99CmL+44K52Nrykc8uJC8sHyLWr7aHWXLzPOj/0jGjt76jLZhquZu7ftJgodjVi90cqP2LulZePyB9zAV2ZWBmxO6K1Ht3QrS8Qv05m6D2GTAU1raJU1XKLy+WDQKmVAdmfWOJz6jBfUG69whvoPR0hZd9PMjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614985; c=relaxed/simple;
	bh=25/jbEOYGOkc8yufidh5ln2EbH1f7N7ePyjlT7NMpnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWbIj3Blm8OgU/Y47/ZLcIKsVktzCcQWPwpkF5+MzR/qGYd4s1xjVqA3CvIxsuqgIaQacEKNcck5pRmAggm420g+8v6n4OJEq/a2Wvav0XpCKWhzxcfV6Mlc9iuE28u7tRI6J16Qypv6r4tVRhxJneYl/A6y1bmJBFcKg84dwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iUxvvGa6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SKbydxEP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245Sh231678164
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 09:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G2M3XV9YCtC+hAJ0aUiWtgAH4zxDrUJHdwUvvL8ju9A=; b=iUxvvGa6AHVsf1CE
	cIAp40KFRSxzaMK6tRo/Ot89r0FLdjshWY1bHp4UoR+oLQgLfgevmBmFzcrZzI+S
	MAYwCgG+1Kw6HklcYcmTPb9wnio6Mmmu+KNfOxWWI68ssxjEMOiht3K6oHazTm7d
	k59m+ycliFGezRAiNrZa5IQD9eNfQm1ux5umtdteTjH4P1BmPua270CY7X2LVHSz
	ducmX6SqIi+BprB0v5a7ITYi8Y+CLpwkBXlolQnD8pkrTK7mL8+KtWu1BOV5TSZh
	hxYUisIwzg/oCq9VRTY5RUf7H0eHiPu9dmGYvMaD78EeNmc+IFNqqelijKxcWMdf
	yxzJWQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73ha5cv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:03:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506bac14430so10123641cf.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614982; x=1773219782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2M3XV9YCtC+hAJ0aUiWtgAH4zxDrUJHdwUvvL8ju9A=;
        b=SKbydxEP8lK1kJIBgwwgvYgEb1Dm/d8x09sLUH6T4Y1LQmE6pXFl9txcGGHH4Jo9+8
         X1twcCJGcAXJ3l86Z7dxqlWxOkh6+pdRE+VwA8ypDzTO45diRomiakUp3aBWZWXHwFcV
         eB5OUT9bd0aSBT3eS152g0g9WWf9Vxd7sJQB2fjY0HUQdl24q4U65tjFF9ZU1xJu54ZA
         eJrDWWcaNpVDUPQSh9Bc3KfQoGZLdXVDjUR6cKm4Tm5jb7uYulBoTB7DARqKKCRqFDL6
         3FATrM2xF7VskD+6gD82vZnIQK4G9BQ674Z+NQ7JOHQSZdy4rbA/Jm/tztFL8kGEg+De
         nPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614982; x=1773219782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G2M3XV9YCtC+hAJ0aUiWtgAH4zxDrUJHdwUvvL8ju9A=;
        b=BPtcsojVOJlZtY0vZq3nV1b250ybsozBTTQiJ0+huOERW3Uaz1fVfPW7ZmvVupnKQB
         CShoCwS3u/8KizcyDDqY10j5wmawejDefS/GITO9prM8E3Hmc+wHYpey8XxYCQyCtBgO
         uqpNHFXNxH3x4gb5b2NN/hxLzfp+fP5LJDC/RfVg+c8B25TCfCxR0IYHfvgEiEqY+alS
         5QaJQ6mvh9FR+3OhWFBKUeh50OGTu9q2hUvsbn566+3mMHgUHhs/0RXOfi4nE+UEPHdn
         HKGWEbJxGPN5VV/fam10EZT6DNWYpTdGr64vCu8pgc9s1oAcGk0HmS395EQT0OljdraO
         tGZw==
X-Forwarded-Encrypted: i=1; AJvYcCXUcBnYBsOHV44OuXFPPs+2oiELEvnRE7lqPImdfpeZtyFJiqn+80NIbF6f6+BR2/a/1ZnTEIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHIpvg9MYxi/xvvWPJ9yT2/a4GTGmJsOgjUvWSY2dURF6EHer
	1XrexSLmXMp/w4AVb6N4TNSWa/U/NZ3HvzKDq56tdr4kmpjWig1ZuBkkfZ/gQ3t0jXNoNY6UuRm
	N8DMAhW0qeW1Nyu0FLZTZrKr2mwuYtn6LDDvM2rbotxBxlTfx72NQSrw8swo=
X-Gm-Gg: ATEYQzztMnl/nER7yICEmlNzJbdGAzNf7jKtDRs6cFwmCduzE8X7V9wMp+r1sOPbUvw
	KzLqg7pdATGCUifC02uERnpuXxt/F7VYOAO+igYmH9lwtmThCSenU424IHNzR2MKTzUoLmtYzT6
	4HTLb2YkPfRyRtIV9YoAI3PX/rq4cCAVHXk0JLfSDEl7vnYUDaIHVdswE+ZYHOTZw1OjYLvtgE6
	hMzM0dDXSDIvM2m82jaAgEOsHOyyCX+cJSK3YFZKKZmUocvZfAF9jBKm1dO4tpwtx7Apzlz35iV
	tcyn3PvKzAyqqVf7NzbJGZxS8bfDbmlhTdPx/nfnL1GGUag8saSY+jmIEHZWWmwtogqWHDOWZ6I
	IfaonZfJWWaWE8Pfa1448EOih6vuIdLvcnI2rQ2o+MSzHB8VRZYbm
X-Received: by 2002:a05:620a:199c:b0:8c9:fac8:c256 with SMTP id af79cd13be357-8cd5afcc900mr147426085a.77.1772614982522;
        Wed, 04 Mar 2026 01:03:02 -0800 (PST)
X-Received: by 2002:a05:620a:199c:b0:8c9:fac8:c256 with SMTP id af79cd13be357-8cd5afcc900mr147419085a.77.1772614982041;
        Wed, 04 Mar 2026 01:03:02 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:00 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:24 +0100
Subject: [PATCH 03/14] powerpc: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-3-d597916e79e7@oss.qualcomm.com>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
In-Reply-To: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pm@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=787;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=25/jbEOYGOkc8yufidh5ln2EbH1f7N7ePyjlT7NMpnI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/UsS6j20gNdLUQ+uz+/FXiej3C67iz8F70QU
 ojaj9vQK0mJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1LAAKCRAFnS7L/zaE
 ww6REACusP6I8XHqjA+3Yae7NeDqnzXpc6CQ+RTZzkcMq6aAfUEFS6xnlAen19ugyDgZQXHMarL
 2otsWD2rzmrQb2HB224/i2HmhrzTdbDRtBcATi1drYJWZXJq8Tc0tiILUbI8u+PUscTUJo6hOqo
 LLNyADlnO6/+12tJR0Kqga/FIARCLH72kRa+lJ1ioUe6rOG9rJjhYXcRbw6pZs5hNB9ccVw1gJg
 ok+/f5EYeeaHxbcGOMdXBmfgCELp6K4Z4GXyJ7+kWaJsxpvsG68R8kFZf/sUqZ6bysAp9KoUwES
 vstNFoLcRpgQGqBTPhi1BiKUEIAyfSWeh1Sts9nhRiXhe8GMSiRexRJ7xdDe+5eNhsNZ9iiBB+y
 9A3PzpJxACN6XNe3ieW4gmP9KV9xqdeOkCJOI41SgiYsrsjVvwXpx/RIzZTINJ3VOp6NYNRhqZZ
 5i/EvVw6gA7ozjKWgwOJeoa7c4FA6O5eGpg16Of9PXIHsU+p22FJhpa1uJxjQPCRoNW407R+LlN
 BwA/WM+f6L/iejzY7jy6mKzM0GzafixchYkMgywGkJzyPW4BXrvxclKdjdkMWqydECbBSpDUGdh
 7kP659V3emuNeEifz+/sDkqbSwB5RFmpXCadYNNP/SCDu5RVP6K2Z4UIdcTMXSlT6UB4HYSuush
 EJBC5HRypdQ+c/g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: D7JiTp5RQcpxNw5u4dzUukvAT6A1C6xv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX8vrrnLoy7809
 V3dKfEfvzskqKUs1afnXudbCmm6LUDJTyvShqwwNw+zBay9tnYQq8DFs3IHUvQ3u5sEznHrYTbJ
 dOVMjCtikxbUNfCKdV3wNc8w5OhI/yunFVZg/I7WjxFpweFiQLmp2nRTVm5pWNgLOjI8hMILFJa
 k6+t5JlF708zfLj/z7S+hrfA/H4+P13nltjdW2dfhXZO9gaDE7YVLtmAaaRJPln+IYTEAzYsera
 7yPba70jhKx+/8U/WJEZAQhzVfNIaqXNfnuOi0S8DloOUtvhm8ib0dZyowU+hInQ8h/U8NlhjBE
 mREwzAorwTAHETbNdHk+42WfdRQgHX8+5O/Klr8BKs9tbLd6K9gXel7YnqAo5sH+qnLvaOCMwGr
 l2WNp+OoYYIq8Gs69MJt/nuacX6f931CPon0UnTwejEyGr4wkB9OtUL/3nkHtxHCzm0pTTNPAaT
 J7Aue56coAs8CYDCS5w==
X-Proofpoint-ORIG-GUID: D7JiTp5RQcpxNw5u4dzUukvAT6A1C6xv
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7f547 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=CZix5RWMGGMvBx25UzsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040067
X-Rspamd-Queue-Id: C33C91FD2B7
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
	TAGGED_FROM(0.00)[bounces-263672-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

OF_GPIO is automatically enabled on all OF systems. There's no need to
select it explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/85xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 604c1b4b6d45c11dc3149ee8b9adabe593882c8e..6805c19ac8a915dae1bd24b13010a56cf1948ad4 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -217,7 +217,6 @@ config GE_IMP3A
 config SGY_CTS1000
 	tristate "Servergy CTS-1000 support"
 	select GPIOLIB
-	select OF_GPIO
 	depends on CORENET_GENERIC
 	help
 	  Enable this to support functionality in Servergy's CTS-1000 systems.

-- 
2.47.3


