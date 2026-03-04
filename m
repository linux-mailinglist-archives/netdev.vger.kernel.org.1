Return-Path: <netdev+bounces-263676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKGxN+D1p2lFnAAAu9opvQ
	(envelope-from <netdev+bounces-263676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:05:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CC1FD29A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD2DF3047EA3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44D395D9F;
	Wed,  4 Mar 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8hmrAag";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgUprl7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCB3932FF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615007; cv=none; b=NJZxvh9qfWpZIAYAtv9LwK/NcqtGswr82NeMC0+cp2M34M1Zyl5BWpIwcL/8/4BHhGkuQDAL7A5c4ilWHzQGLOu9xQnqwJ9mVv8kiMtiS1NV/27MIYg3kCELr9pxNSEgkuR39IL/7F43sM4889oC1ZSe/OKjNDOyoIPcvzrXlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615007; c=relaxed/simple;
	bh=SNxn4ssJCq61+0YQndlULQe5RINmdH9u0N6CqwGb0P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADlLZWSNp3QrRTy+50yDifUQSbHd+x+ExZKpgtBA0lFkEwhGXLbAVvfWNclcJAIY0E/33jcELDfpe6SwujkNiaYyRjZ4WNH+c4VLbd+/CJEQ1QSOBfTKGlVLyWk0llAwLeebt3/EU4MFdwnnb4IaPYcJpZ3RZZL786jr/Oml0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8hmrAag; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgUprl7Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQLB1677919
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 09:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Uu8Rc5MUkLbcfU9/lpDj1Gzj2w1uJa7a9HrTNNL9qg=; b=O8hmrAag09fqLr3q
	PrQi2quDvT98RuvxEuB1INubex8lFDUvQV6PW6VyT/IOoEWzsMg236hTDPPz36EZ
	oEt0n+qzIOmDr5S/0w55w2tdjibkqrtHd86R2y7ns9opQjaa1FvC3AZoMFoyHnyj
	35m33cs6aTBaSZT4Z3nGKvSYN2W/uO3arTryKVmdJvZ+9Q726sp3k8RpSAjzR/Yo
	qOeaASs+FQymTU7agJd6vuaynSuxh+fEc52MjMHVku3DfJlk8tOUAxKOD4YjcGbP
	+3nVFCkaehAzbFX2PfnTQJ6ynl8S2dgA5aqlw3FZSA/atl3PYOeLuJuWaV/EHIBn
	8tAhng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73ha5ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:03:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c881d0c617so3981555085a.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772615001; x=1773219801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Uu8Rc5MUkLbcfU9/lpDj1Gzj2w1uJa7a9HrTNNL9qg=;
        b=OgUprl7QvPmWJRTzcDaPWDt6I809944cZwRZUkvkDs22d8QG4VrhA7JuT61/ttoNST
         XGw8DRyy5vof6LbJQGcArqbQV/9N7iYPVRUf+uulE9wZkv0s/T/vEPriOH4o9aKz5s7c
         eBBgDyZns+leeQ3x6VpjPnHApWN9ecbg9kt5uSpM2TOwF2qVn420z1hCoX3DPwieA/wE
         3n/1VJMk/SXiIYm0t08cf4RmIZiQWAlUljicbtkDLu9N/vaiakfSthwP5EnHYZVo7T0C
         H2lQrP8g0cRWYkv2OMNyxAvJtnIFuU6TPHBVYhXwOcrmO8vOES45XuBzz7ZGuvOwpsw8
         JaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615001; x=1773219801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Uu8Rc5MUkLbcfU9/lpDj1Gzj2w1uJa7a9HrTNNL9qg=;
        b=Qqc82IddZKnjLLLAxvmpwPtOueSb3lGdBRO2M8/0VFCubk582vjH6XOCpbrv9Bg69K
         i79oAhAfBcek6fhqZVxGbvrfh2EJYUX+a4TAwsByQ0zGe+zKTTftkCKRpB8DMkCQlDx4
         wGHIhDC8wbssBopjGGIK7aVXoJj34jFGrMz9BiL140et0zxqGjiNmyZHq5w5U74lK8OQ
         tIGGaaRJUJ/8Z9o7OHQkPMU9ra6ca6HttD8h3olBX7QtN1Jf4C3tlYkjsf8YkWduXGAZ
         9OlzRjXAXEhCnp1sdmypAzMa50RkXolG7IlsEI5q3yDRk5FsOvNZLzcBIt35eGZNUpEs
         7iiw==
X-Forwarded-Encrypted: i=1; AJvYcCUjrakyYOXWQStmDJGZWcOm6DqR4rvEpJ1I6WiLWCxJvWr+zqXrR010u6DFNeghD9WBW2RAW7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrOBFytZcgsJLrN3JSwH6XyXhCA4C5Yw9atMa+SEGcWKxp2zN
	r7CSC+kljKI5IvsTSKoXaZ4zRUT74HwfnDD61ojNaEcnRQ3lCEdDnwt60yN5SMwd5ERD47Qitpu
	INCsROsBxYzVqzDIHjYbA6XI/rTa43jULgeNmpW1vH51fwWBA3WaH4PlVb4g=
X-Gm-Gg: ATEYQzwJK8B+SEtLbaYe13IeO3fpONWl372ESn+OnXztsQtzZ9Eqy3blcf8vM2g3gn7
	FKnL28/+CDctLCQjXrgr3cr2UK1Q8CldzPP2Ch5iUkNfMwBDdZOC7sAeZ056gyKJg7riDKNM+WB
	28NT7bxpzhT77ZFJ6SZPzrjmaDYjSJAje+R5RFJ1H+U15xwiYwKKCZfrAZ/66lVrwn2Kay/Tkis
	uDc6se4U34ar6qtvbGkAtg2LbsvUXxzy5iZOYP7LQRcuXlY81kTtwPu8vQXpvOBOgbcGgPD2TcD
	EtaczwVgQAFDjTGvD6piYnBcv/FDOXRuwKv7gbOYl3QXuC9bN9pdCm231tkQd2g8XvWuX/Mm4CB
	XOP/D3rXoAEVq/+uYBMhLS0PA2WCqbVow/6FZqlUD93VfC2z4f0vZ
X-Received: by 2002:a05:620a:290d:b0:8cb:4cce:e644 with SMTP id af79cd13be357-8cd5af0bcc9mr150438785a.31.1772615001121;
        Wed, 04 Mar 2026 01:03:21 -0800 (PST)
X-Received: by 2002:a05:620a:290d:b0:8cb:4cce:e644 with SMTP id af79cd13be357-8cd5af0bcc9mr150432985a.31.1772615000567;
        Wed, 04 Mar 2026 01:03:20 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:19 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:28 +0100
Subject: [PATCH 07/14] pinctrl: Kconfig: drop unneeded dependencies on
 OF_GPIO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-7-d597916e79e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5460;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SNxn4ssJCq61+0YQndlULQe5RINmdH9u0N6CqwGb0P8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/UxSO5nc8kZcTUF9RyXKUJmf6Of1AYtIHV0U
 6UACVndydKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1MQAKCRAFnS7L/zaE
 w5i9EACQjyTPxi/a1QXOxfGfBGhdjzZUrgi7jiJL4MvvK8VXQiRQvaR2vGldWmrji0tQeSFZVH3
 Zz51abeGu/KvkaZdo4U/rXM4ZC+Km0Lds2jX1QQ8qCFhWgQ1iebcXeJiHNQWCh0wNnY2/meApzJ
 rvzFAhGZcvzdB8OUYP2lZ8dDAMSX8tKOCXynkJ6egYF7XKdJ/l5I6olmeYb6tcEndTOuE03j8tJ
 QbJLbwucLEN5fE3mu757a9l+JrDgLZA77UbCQXFgeRNsa3CxuBJXg5KLeKBXxI5b8W9dqtDWs+4
 CUvvivch/oaClYS87HV6xVwbsGtHD/qE4Dyg+LcqEDKG+dEa7HC9J7LeZNTVqkJUncN3ZAURtrX
 DcQ1t0Ny2sl8WGcfVA5d9DXSr+yjwdgdKdTyiWQrgS2SGU4SKApVGMT19N+juW/HuIYNN0lMJLe
 6GXfm4DUPPjdB7Z46C5uxrTzxEXdGy36eUclO3LQD5Dj67INf7uSR4VFicumGPkf2TRxY6hZ63v
 HCBjI+tS8cdFiPdkuPoT6+AeScisOZ+nTHhHbx4VHfRRNr23JTlWhlUR1uBeR0mQJwAhXqhUVnH
 I+9SsKxtSrdhRA4F5iojV2RWJCwI/ocUowc3fHpCopIkvmKDYE+51TQ3J7ICqF+6zRQFlRKUiV7
 NWCE+XrDTIp9bxw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 7NpXJYxp2dT7Odjcx8qULm-AXpLFxX3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX9IboqqPIIO0L
 5qzA1yQoQfbkuUqATWqdWCRljFZpmmjFNTN8Hx+X1A20JWgCSP2gxdK1WegcmmHKUQwi+Dm7vqO
 Kb4GyBRf26MwvPzgZzNrC8vxPeuE0b642i9L2UDMo96vxMFsbo0FplaeDAnNiVawoP87Uf+ifI9
 CCjP46hEErlcZli7oosnWBlvLMByYe8h4/2pEggD3tdNCH2sNehEDVbwL9qoMc2QP/MyGpNQBoi
 9JCTCvjRGHsNfa9JS3ZbtGNA4hShz8QUqFjWZVgQIT8VNdeFNdpjkp2KSKE+qq1zn6gN20xQy99
 tqe0kYGXuRU80gfpmUJFw7oEn/wtLTxc27E02jg85OTjX4ICSsntWO2yfECel5y6NQrEZ52ogei
 mVYW77u8dt4BhidaRCaMwtIIgyFOe1bbBfubIdvKixl497FYFj6cnr62cCUEPI7Jx3TWFAvDDuG
 XJvm4jKuc/snbjaYkRw==
X-Proofpoint-ORIG-GUID: 7NpXJYxp2dT7Odjcx8qULm-AXpLFxX3l
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7f55a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=vlgKDOFDcSGwYYau-yIA:9 a=XcN_yYmeaqUB91j7:21 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040067
X-Rspamd-Queue-Id: ED3CC1FD29A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263676-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
 drivers/pinctrl/Kconfig          | 9 ---------
 drivers/pinctrl/bcm/Kconfig      | 4 ++--
 drivers/pinctrl/meson/Kconfig    | 1 -
 drivers/pinctrl/starfive/Kconfig | 2 --
 drivers/pinctrl/sunplus/Kconfig  | 1 -
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 4bafe1dff1951c470fe5a4131d0c06b497a4b575..03f2e3ee065f4268dbd2f94a0ffecbbc4d89df20 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -77,7 +77,6 @@ config PINCTRL_APPLE_GPIO
 	select GPIOLIB_IRQCHIP
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
-	select OF_GPIO
 	help
 	  This is the driver for the GPIO controller found on Apple ARM SoCs,
 	  including M1.
@@ -126,7 +125,6 @@ config PINCTRL_AT91PIO4
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select OF_GPIO
 	help
 	  Say Y here to enable the at91 pinctrl/gpio driver for Atmel PIO4
 	  controller available on sama5d2 SoC.
@@ -293,7 +291,6 @@ config PINCTRL_K210
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	select GPIOLIB
-	select OF_GPIO
 	select REGMAP_MMIO
 	default SOC_CANAAN_K210
 	help
@@ -419,7 +416,6 @@ config PINCTRL_MICROCHIP_SGPIO
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
-	select OF_GPIO
 	help
 	  Support for the serial GPIO interface used on Microsemi and
 	  Microchip SoCs. By using a serial interface, the SIO
@@ -441,7 +437,6 @@ config PINCTRL_OCELOT
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
-	select OF_GPIO
 	select REGMAP_MMIO
 	help
 	  Support for the internal GPIO interfaces on Microsemi Ocelot and
@@ -482,7 +477,6 @@ config PINCTRL_PIC32
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
-	select OF_GPIO
 	help
 	  This is the pin controller and gpio driver for Microchip PIC32
 	  microcontrollers. This option is selected automatically when specific
@@ -499,7 +493,6 @@ config PINCTRL_PISTACHIO
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
-	select OF_GPIO
 	help
 	  This support pinctrl and GPIO driver for IMG Pistachio SoC.
 
@@ -521,7 +514,6 @@ config PINCTRL_ROCKCHIP
 	select GENERIC_PINCONF
 	select GENERIC_IRQ_CHIP
 	select MFD_SYSCON
-	select OF_GPIO
 	default ARCH_ROCKCHIP
 	help
           This support pinctrl and GPIO driver for Rockchip SoCs.
@@ -557,7 +549,6 @@ config PINCTRL_ST
 config PINCTRL_STMFX
 	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
 	depends on I2C
-	depends on OF_GPIO
 	depends on HAS_IOMEM
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
index 096d0778427e274d6532ffa872c87dfc9d155727..206f3f1249cf50c662c44043e6d2d910a5687bf1 100644
--- a/drivers/pinctrl/bcm/Kconfig
+++ b/drivers/pinctrl/bcm/Kconfig
@@ -120,7 +120,7 @@ source "drivers/pinctrl/bcm/Kconfig.stb"
 
 config PINCTRL_IPROC_GPIO
 	bool "Broadcom iProc GPIO (with PINCONF) driver"
-	depends on OF_GPIO && (ARCH_BCM_IPROC || COMPILE_TEST)
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	select GPIOLIB_IRQCHIP
 	select PINCONF
 	select GENERIC_PINCONF
@@ -185,7 +185,7 @@ config PINCTRL_NS
 
 config PINCTRL_NSP_GPIO
 	bool "Broadcom NSP GPIO (with PINCONF) driver"
-	depends on OF_GPIO && (ARCH_BCM_NSP || COMPILE_TEST)
+	depends on ARCH_BCM_NSP || COMPILE_TEST
 	select GPIOLIB_IRQCHIP
 	select PINCONF
 	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index ce6aeec2fc791a067bbc33a0b518d8a15402f7a6..1af4fc320f42bb893ba9f42f4bb0b6d7e034e512 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -8,7 +8,6 @@ menuconfig PINCTRL_MESON
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB
-	select OF_GPIO
 	select REGMAP_MMIO
 
 if PINCTRL_MESON
diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index 8192ac2087fc363900b0018bf9e348c030d7b7da..a9a7cb101684451e5897406c52ff955157639faf 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -9,7 +9,6 @@ config PINCTRL_STARFIVE_JH7100
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select OF_GPIO
 	default SOC_STARFIVE
 	help
 	  Say yes here to support pin control on the StarFive JH7100 SoC.
@@ -24,7 +23,6 @@ config PINCTRL_STARFIVE_JH7110
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select OF_GPIO
 
 config PINCTRL_STARFIVE_JH7110_SYS
 	tristate "System pinctrl and GPIO driver for the StarFive JH7110 SoC"
diff --git a/drivers/pinctrl/sunplus/Kconfig b/drivers/pinctrl/sunplus/Kconfig
index 4b5c47c193d970b2dc1e9517381936253610af28..69f82590f6d245ba42b773758c5a6955063ae606 100644
--- a/drivers/pinctrl/sunplus/Kconfig
+++ b/drivers/pinctrl/sunplus/Kconfig
@@ -13,7 +13,6 @@ config PINCTRL_SPPCTL
 	select PINCONF
 	select PINMUX
 	select GPIOLIB
-	select OF_GPIO
 	help
 	  Say Y here to support Sunplus SP7021 pinmux controller.
 	  This driver requires the pinctrl framework.

-- 
2.47.3


