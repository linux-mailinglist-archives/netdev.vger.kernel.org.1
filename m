Return-Path: <netdev+bounces-263678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKejG2X2p2mtmwAAu9opvQ
	(envelope-from <netdev+bounces-263678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:07:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46D1FD379
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F175F30D8798
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0E394784;
	Wed,  4 Mar 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8DhNi6i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D99vRzAs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D253976A4
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615011; cv=none; b=IAUq3WRCfvkMzoYlt6qR1s5alv4JPLlFwb33WZfAOMuBwg7ibveimbPclTmo8B4prFEWjwdPX7ALCa5I6ANkW5KlBgZ4+dSIUbZ2hcNJyTkLEPrSVA/zkLCKccgmkKKlYuqooAIV1eu+7RncC+pypr1zvxvUYN+v3y9clnrhV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615011; c=relaxed/simple;
	bh=BZ0gBX6ApkbfQGAvIdrTK0HNC5TATefci/BtaAEAScU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyjNcQ9izjNv1qMfZIZdh+o/q4ggdh2Dujtuvdv5PbjGSCwlDQCk1+mIILLtvGEHrMTIUpzGAui5f1f1O36g41jZOt5qGdXqKblpgQlg1Xy/x7TK37WjoC2SRP7+ZfywHu0ZT+JNZFgTzc2gs2xkks8YXj3zhKgNm1iVEIfOtwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8DhNi6i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D99vRzAs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SP9p631866
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 09:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XxApZrj5x0d+xFAjK72RyeZ+8kWAT47gmD209wuddiM=; b=O8DhNi6iiQ0wr6Qm
	XLgu0rlhFSuVWEQJkPbXZmZ9JD0AwZqTH8m46nANsRAK5ZixwpLI4VIEw8Za8BCw
	d4WiUqgPneaIhP+Ubju+TIK3gQ2rtr/xMZVAsMGU44w6cZ+kxjd4e/FlWaQiPO1H
	BR2NcuGvK08bm6aCDi8fbg9vt4ty/wRRgG3R3lMHBoVhwBQLmvzkLaw1B5gLozE9
	l58MB+oJBlSMflR1Uzzsa7vjJiRM7ipJrU/Bd9Wa0PWEfNFOuppvZiDZQZ43xps8
	qIS/mrDUT0yrBclJLPfzLA3bR++4OOCwfWGHZ+RjwPOufd0zashYK1qlwHOJ3UqD
	3ux1Vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtuccgx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:03:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4d191ef1so828639685a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772615008; x=1773219808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxApZrj5x0d+xFAjK72RyeZ+8kWAT47gmD209wuddiM=;
        b=D99vRzAs4NLH4y70bMmcoZIkK75BYKAn+h3wmrHGAxCGUkfbiN04qqzjsHpONdz71m
         dAxMp8DbbcwvZ7ukJvWRjpeQk9F92b5CvrrDF8+82SKW7mMDOd+v5gXPdkWhJFp90Xv6
         uaY8PTEMo629T19RSw8aeCnXE3JOtLZCjRpD1rfCvlcUpmNkZn85vNAAN7YtubRTusiI
         GWiVCxpEeQRGL0GPobsvCkHYhxzQmhu780DYwDEgb/6Y13emWHrpuhaaO+1bfVgfBI4I
         x++zE98pWjXfXICPNgOTyubYaFuwMi41f0HOiXqj27SjWImhZaNnQjo+VpTQfKF6El82
         /LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615008; x=1773219808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxApZrj5x0d+xFAjK72RyeZ+8kWAT47gmD209wuddiM=;
        b=u1iZDBCzJ6FAMbENvMPWhwaUVJlLuOBO4kgoIjCNJLkY1FaX+Ivf2IKqY/fnLfo69b
         VpwYk/5lW6UurW9IN+SD63LGyPoaae0S6nImJvAieICQ81gzZMbvoTYub175Ur4QsPvL
         53/W+pS2km4GP3AJU4BQpixtinllrrhL3QWsNuyrrClJuus0YKoqMux5nauYKVcDfLK4
         OfA7a/4harp5MbGBl/iSaE6pKX5fsnS3S5Ct3Pz0e8teOXzPCYJTQVTp14+sJyYPVbEJ
         W5cHma8PJFUuWejKBf/Vdt8nznHE3nN/Z7DPCPK9NncFosMQE2y2KoGRsgSl90ospWiF
         6CTw==
X-Forwarded-Encrypted: i=1; AJvYcCVFHh57pcfff4Ts0v1Z5IKPXYAPWsMwjYvfMUgdklAke/hJwjQFA4cEUpbC3q0CcUSiUYE1b1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2e8tWqkk+MN6XjKJY0N3c50zKES3pTjXRw5hUPgdGj6QLG7X
	nxSP0rVVE2nCAht6Xa6pBtIznn1qjOd7h6NQFPkI7fYaP+kB+pNyfuYeHWU+Gpg66cgJd8TVI92
	IRyARt+bMVbanYqve3vo+hjB38ojGvEDHA2ZbuTWXodA2IWqzUEf/y5eCokE=
X-Gm-Gg: ATEYQzxsiAdWknDEYkrgwgG9kS4UIjIUmCSlxBletf52kI1RAnywBpzPjmXC0ovzmcK
	0t5CuamqSE0+qa7SBh152gk5MnH8n9pVXEHYYRcFlWmVpc+7oD7nDJiBeAWB5l33AVeYyM0RTLY
	wcl/9Nv3LXJjK6ZapNQrSgcS4SnlB+NJG/tIvCYNnkYv+0ZVOarom+9wFKOzrajjkEe3rF4FSGV
	OjFnN1BwMcILWAkrxjviM2ExM5UiH7HLgWytJzJFFrDUmQnzhjB5htSS9MQRhkkE8F1UavKf0Kb
	uLJKMwa1L33gXrkQZAwLtvIkLD94TYVij+7gf7SPiZEdK1HryLhhy4KKhcNy8v9mNx7MQSArloP
	2XhGPxJ15T4k4Gm7C0dvxrThT7yYIMjC/UD9L+Qi4ThS8V9GL1pDE
X-Received: by 2002:a05:620a:1714:b0:8b2:9fab:d7d4 with SMTP id af79cd13be357-8cd5af843f8mr148865485a.38.1772615008147;
        Wed, 04 Mar 2026 01:03:28 -0800 (PST)
X-Received: by 2002:a05:620a:1714:b0:8b2:9fab:d7d4 with SMTP id af79cd13be357-8cd5af843f8mr148858285a.38.1772615007620;
        Wed, 04 Mar 2026 01:03:27 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:26 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:30 +0100
Subject: [PATCH 09/14] hwmon: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-9-d597916e79e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=BZ0gBX6ApkbfQGAvIdrTK0HNC5TATefci/BtaAEAScU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/Uz6yqxw+9I2xsnrbiXWkb1Q6qa6KwlYI8TK
 d9JejBIMTWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1MwAKCRAFnS7L/zaE
 w/3aEACwVZCfqTwZVPWkHYhO8Qy3o0ruCZnb285a+Ylf7yiCsvgYQn0a+sJ2Arc7KxxU/aPIXGv
 0aCZMBstfCGSxehuCnwhBer6o8ip4bb7kyIIkx0dm62T4QqKQ5L5QA5G4ciTBJ8EuvjtnSMeGuJ
 95epXjl8sR026uh4KZEYZYxbOgIWvV2Ug4vquTWPnO7T7/frpn7ujJB7EUgTMG+EHBSM2FIE+0v
 HWjaX7Q/qKobdkdnrFIva7tNsWe8WCAiSmYSvQGlWmDU15f/4yihAn90zQLK14jwUIIvbqKCRxW
 bhf7+1haXr3TsZRioTZ5+sP9XAFSH7Urm6a1oEoHKB06fJnOPAEawTfp9MNx1DfqPO3gvgmONrV
 yrSwl3IpJ3ld2yUQuOFT9i2nmkedupRNvQtalNFEPOpJtbP0bakZqh+KnXuyhvNKScPwT4MVgHu
 Lr4cvrNkmt//CI9a0nV0Wx85nantYCCTBfgiWEr5WrWOVDtQIL0JTuP/KYxN6KWjgf2fXehFdib
 dWGeFHTIp/lY4HrTk+4tQ6oetpUDkdppOiusjNeG9zYX5WjnV48wsSXaXvsw9gkjpeLyJAf1lNV
 3dZw5ihRTGrkMUJYU/0S567LpMEIQZfQetG+3NuIzQOs4p3djYvv1xGRysT8SVHkZVcA3vjwKfu
 YphKNug3FwuWLkQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Xun_7b6t47Eg00rlcP4DtRUbgIkYqMy6
X-Proofpoint-ORIG-GUID: Xun_7b6t47Eg00rlcP4DtRUbgIkYqMy6
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a7f560 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=DLk2I_icXWleI3Wn6BIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfXwBCyxZt2kkdz
 kN6YqnXwg9haDQUycTSWEdPaAZd/iC3STWLatMGSiSG9omsVqkPKapUsO0hqlu2+CQGjif6KPcg
 au1T2CA2XyGxR1MggV2gzBHjhrEm/AfhvRBK5L4frmYguRGndlo/6RzIyCpJFsKg16jLD5bic0Y
 ZNNPxhtlzVZaNmJCvA5i7/qjDXaum8v0F8ppPtSmo3iPHZELq7YqBfpJ9mBSDqOX+ogvxBIFZ+C
 Euzg0z/ROWl7izCTtu+EqHMHA70FCTH1A5H5s9gYw7eo82IlxufbNJ5fXtcqkRdqljYCkKihbJQ
 BDWxV+IwpdB6fE+R0Jg0KHKEbcWIPuWpIFxfXPe16EvwlBGxQ+/8w8kdCmBMoqHCH90ThZiO+kI
 iP4cU31LPv6foPoF3fEUoY62nT0yzkuu58KnaYITpczujsxU2tJRfuvGU8udnQ2WxFTiv8GASSS
 N/17pYBhouf87NFr8kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067
X-Rspamd-Queue-Id: DC46D1FD379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263678-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/hwmon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8f7ce66ae3a258ebd439ed97441bb087dc01c76c..fb77baeeba27b9ec51142040beccc953df0a1e3e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -775,7 +775,6 @@ config SENSORS_G762
 
 config SENSORS_GPIO_FAN
 	tristate "GPIO fan"
-	depends on OF_GPIO
 	depends on GPIOLIB || COMPILE_TEST
 	depends on THERMAL || THERMAL=n
 	help

-- 
2.47.3


