Return-Path: <netdev+bounces-305021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oFWDJVGnS2rgXwEAu9opvQ
	(envelope-from <netdev+bounces-305021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2EA710F63
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:02:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PEZWyDId;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CavNfPnI;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305021-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305021-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303F03697F23
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0741A76C;
	Mon,  6 Jul 2026 12:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C44D90DE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 12:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341968; cv=none; b=b0I8Laa+oYG8deoyOsLyr59MDDiExF5vnb62R9EH7mEqKjcDwt/i06MO3yDNphW+02oVg56c5/bs6GNOEEi+qu9KwCKBUWtwpmMBd7L071qT6UHD80fnshEBNVI2a+RpMQ0WfqiC+Zolnpk04nP2Sv1hDtnrZ7wUzNaS+wZLAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341968; c=relaxed/simple;
	bh=myAnAqwQCy13zr91xzLXDTsphXD+fJJQlPI5uzrj/NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKwZqOVYkTzUu4jFvOVJwhaiWH6iGkHA14cdkqPnKR7VOwJSnO2zYtdRkHV1xVVJt9bQvGoP77D0+1ua2Kaz6etB9TD5qP4dfdjL8g+R0eyhFPU7LyBfeVUSU0t/qeHkQ7hGV1yG9FeObNzlfr5wIGdJegFmDNqIUw8se9IuQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PEZWyDId; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CavNfPnI; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxEqr395314
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 12:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=; b=PEZWyDIdayoRJtJf
	Gm4yCbdBU/Kg4fCwmLvwa54Sk0sJfN3hNtb89B8sTjEQLLb7/NQP1FY2m0eE9nGh
	LdIH/gTsiQ+Wzh8wjGQ2vHc6+RNH3gineRvsHArNGv6/67/yH3ZhWSQLygU2RVUT
	al+kCmSgvmGNhPOOJjv+KVucWx0X4EB21idu1fTE9R/CSLy28ScyY72eHbaYuWhC
	OXDuIkhJVtUuTbzjXakzMsNOMrKY+8+Fw06v1ma+AuvP7I8BiqHsyiSSRZ6WD8YC
	NTN026qYSv+N5mknEhi/Fn7IR2T8k4UjxvMEa3K6XaNFaf2HCmxgQwNVgUCgNKtO
	dPmBYg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpgqqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 12:45:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e62e3459fso253043585a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341930; x=1783946730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
        b=CavNfPnIoKbqE/yoq4MizRXdju+uVi3d7Jh5gNK68F8BmjfPyHDuXZKf6VFPmQhOUa
         R7Gv4+b6Nzb9di63HljJi7nCeru0E5Y1t6yrznpa6tHt1FuIqqAInwjQadwrW9p8u5lD
         r8qnxkvGInGT8hDsTMzg1FwT1JIoPyo8T6dvYRlsSRk+jYv3IS5lgva2sFel1gJyyQl1
         PMWApf1IPfa04oInZxCergspW4nzq2V0KLqt4XCKoyzjnQJHWnZ6dgR0z01+NLTU8BSc
         OA3o5Rr4RATpRUI96sScKHApHKgIA6eelFiF/6uycOhoqwq3KQQ4iX4MTsBwS9o0lLSe
         nXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341930; x=1783946730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
        b=f+eov9gGw0FYB7O9VwGJIjlbp1eHOHmJLo0BXT6oWa/Tnayg921Mf96SsVdcjYAF1f
         YNnl1bN4123xSvqmXpJhc62z8OtIp1/4spnUH2oOqc3k8XJkDpz2OdZsM/05abuUK40u
         PAzx2SAcAOWPIyDcpgKhabaa7IhMSwrEy6Ars/dB5xAHjI5BN4z1+MuSHfLBESHpdmVl
         D6tY+lJU/tPfNF8qlikNsMwPBfe7mITxtBu7Isc0ZDMx1PCIT7nD8pXOt+dDWDAl6d6v
         dnQQcf5dy37705M2sEWF/+9x0LhprkWZEWPU9pyEIIPFxCPJ5inwLgf1WuJYEkV2nPle
         buRw==
X-Forwarded-Encrypted: i=1; AHgh+RpwzruAN0J+OI3ISbJVCRCXqy91SkZPlFRyEeFbs1dkbcJVWhxs6Gt49jtppT79pFTDkUtG5mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyu/R87JMa4CiI9t8ms8BdwsT7K+yeiV1YiNB6VlVruqkvPYv
	fNraE6gRM4VOyqrk1DdBLQsKFHvnq7QvJwmefjtU2cV49XTxEEyfHxzBSQ3crRYck/Bkfo/WbRd
	AUuDPgh0Ug0e//P4cmeVzcrmEecWcxKY/v9XZhSuGZnOKID5Ggyb2fVhUBzY=
X-Gm-Gg: AfdE7cngunKHmPVjl7T0e2UCejXaVyFDt2VYy18oXMNeCoIBCkSG+FNes1uDC60rS9O
	pSre5yPPVFz/75Wf34IE2tO380boyFD0/MaZmk81JOq6WyvG7FehQgAnGstsqtjANZvB4na80/U
	Y/zuITlNH0/g/bC1AD+wLID2xUVkq3f9POo88n/DDoPyi04peQUden5ajbdBB/rhRX0GZiT/7Zb
	39vbwlQnlqLXg+VAZcIy6gVKeILUibrpw5jh3RMtGCzl41McYuOmyRc16tG5jY48HAvcmdwb2or
	Ridc81gp2HlKcbxxCGqO9v6woOY4+5aiaRk3zgzjaqLACRBFJSZ6HNxo1g9gGBgB91lGwLMWBr+
	nGP5eb8nJztwsVZZSkE+fEKm+DBemsgIhcR7jt6tV
X-Received: by 2002:a05:620a:268a:b0:92e:755:d962 with SMTP id af79cd13be357-92ebb5d4187mr48765785a.38.1783341930425;
        Mon, 06 Jul 2026 05:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:268a:b0:92e:755:d962 with SMTP id af79cd13be357-92ebb5d4187mr48755485a.38.1783341929743;
        Mon, 06 Jul 2026 05:45:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:25 +0200
Subject: [PATCH v3 13/20] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-13-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=myAnAqwQCy13zr91xzLXDTsphXD+fJJQlPI5uzrj/NA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M5z0Ug8HOo/mkHEdX5hdHAVCCSCQf4Zf3oX
 n3oOYxuHpOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOQAKCRAFnS7L/zaE
 w3iPEACZdFohB8aZuD4IW+KDeK1lug9YxM4fLxuZ9O6Yfb33xfInCQVl2ApM5yjOlYR1aCd0+Qa
 AbVaSInI3iaPi+SncEH9JMf7ZTeRmER/WgArjBmflL+CIM7gxLSQU6xLWGauYhQcgoT1sTgEB9Y
 dpaBCfKeYebINsFU5fXn3qZlFgPcwdZmhf/B5Xaqrzgev8Nia3f6SMW97i5ZEbJ1h28CZk9ZgJP
 9RrwhDRTVnaeug7Ijoymji1apZrmeLx7lOhjnkCGfWU1TaiNKmD9k02kNyDV87OE3sfgIldLUYg
 q3QORtezKqe3rjZ4tcZuK3SWxhXWnH+8XsmALd9gO/Z1sKlu2aNRuw+1VB6RyeiYwpzdpW/DBLA
 49Bb3wFrM1kV8E0mDSJwkFGZxFntMCoOMzdNpwfy1pgqN0F1w9EeBAITB0EpppPvfmP1oXDxj9Y
 rc1Fjv7Ynb3T9JjeP27MuOV/9qSxIf+yRFC10bWS5y9uwjhG65wQxbKen0HeyfOX0EWaFySASEl
 dU2UpVJHwYe1sFJzHyEsuYDOzfI2jkOt1+X6qHmvI0pROFoHdTZqwqdKNc5nrfE5rqfAKcyBojj
 cXlCgI+BzXTtkebexgsr97tfEB9ov7RHoUHR+zYPli7W0sLhdqgM3IOYnY+jcAaRHOC6xkOGXTj
 WJkCB4LVwH2aUgg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4ba36b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=NrPIdse2iluhyRvnZrkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: FrRRxGX0EZFnFFsSO01vB11v5O1r-dYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX0H04zwL5XQ70
 7RMy+JVL5NpZJjE3USF9QzH3XkHvyQX24w8OazOyXwO4qyANqj3elq3r/xAWsN5jJO/d+WtyuMm
 l8dlZT7TQUeKqu0AAOFA0T/IzBkGvUAXdZIg3YESAZbqh6+iH3TE2HSpjRPRLal3j988eZ/COiz
 ODEJS/5JTq+vg5iGedtOYLGKBiQ0J1C6A4QBwdGE96Aa8x146ZDyclkUPlrEDqK8870eZFtfmxu
 kS7rCXOPWIUUOeggLkP3Ce9ThusXvP3dMxRD5PutM3Q05TRm4UtQUWTgG+RTSD3fUsWaVI70hZB
 3M7e+jCy4wjlh1J5G5fItjsN16uiEn0GxX5XJcoackhb66lnHO2Hokc0KjPJdbfeAJn0Jycy3Vl
 KedX4FSuYJ7oxn5ovMUWCSyrWVB+I57ohVMwQPEAtYHL57frEXkYzZXAKUQx5xOiufHbIk3+qB8
 7/F3Lzno+egFwGe60Zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3OfVEUL9oC6P
 jltxLz9GDyZua0Nuq70XIHd6qMw+0O0ZTM0HqTs0cJgPPitckEXFs7y9QrLGxug69eZg/RZL2Ie
 2OjJxYyy13vnz/T5JmAxAr/q60GlYLo=
X-Proofpoint-GUID: FrRRxGX0EZFnFFsSO01vB11v5O1r-dYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305021-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:broonie@opensource.wolfsonmicro.com,m:thierry.reding@avionic-design.de,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:vkoul@kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:robh@kernel.org,m:saravanak@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:andi.shyti@kernel.org,m:andriy.shevchenko@linux.intel.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:ulfh@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:peter.chen@kernel.org,m:paul@crapouillou.net,m:b-liu@ti.com,m:p.zabel
 @pengutronix.de,m:luzmaximilian@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:krzk@kernel.org,m:benh@kernel.crashing.org,m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-sound@vger.kernel.org,m:driver-core@lists.linux.dev,m:devicetree@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-i2c@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pm@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:linux-mips@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:mfd@lists.linux.dev,m:bartosz.golaszewski@oss.qualcomm.com,m:konradybcio@kernel.org,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,intel.com:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[68];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC2EA710F63

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d03beaaae2321e858c564b512c22e820e..6e89415712ce1a7a7781af6bd0eaf0d6879da52b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


