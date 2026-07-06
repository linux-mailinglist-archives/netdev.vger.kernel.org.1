Return-Path: <netdev+bounces-305027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WPvgB6arS2oZYQEAu9opvQ
	(envelope-from <netdev+bounces-305027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFCA7112C5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:20:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JFClRWJO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=PXFBkacT;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305027-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305027-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB517309CE60
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EED3FE67A;
	Mon,  6 Jul 2026 13:08:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1535AC24
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:08:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343332; cv=none; b=Bhy3ahKbHcgWoR3T5No/cIEyJs5jYefPqwP2tvNhFGP1WX8BT5o5F3Bg6TV2XbrEN9F5i63GQHet3Fr2zCcp/TuwbKRy7Hu6MUkauAWzlt77ctJzvA8w7bZpLfGOiAxrJYEEGhz/E64Fj/vD85fRf2EDYKsD/Jb5m4/eTHW/6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343332; c=relaxed/simple;
	bh=HEn5owEzeJIUYkdvn4DQSoUKQdn9M8eLHqPgfVbyGMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBY/nvyq0geUN50+DssoHkBZF/bS72cYcB25vqVi2GLvS2L3r0t/qFfi8//Veeb6/Wcew4IUF+iPLoU4+15J2pEtgScmrLprxtmqDDjH/Wkvynv3Pxmf5z+S2ShiRU+Y42zZyHbpRqfm40G/NC5SiFLvmTvUJ2UsfuSW0iO2AXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFClRWJO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PXFBkacT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxCOf238119
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 12:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=; b=JFClRWJO/YlvKXxt
	EPTan7Bb2wCcvP3ljtvtZjzTtxn9X/oJo2TEJ/HAmb+pQSKwSEV/Z0gNUsAg+HGp
	w6HgyrZUxnRD3q+7IWfDH5X62RGexHSNLTGzOUeq2dL2LoPSNk6QlXIjpQSF+Md5
	flrFBt6s2fKpQdszOkYGsCYuJQ5ovRF9aZdMY9Ly4KS9iJsfekBq0woUOh8k3cMV
	/RkmkqR4WcSAqZVtsYNjEqAk0a4iS4q0boV4t8SF1Q5kKlnTaNhLXh+6stEhQhqA
	eEHt6s2fdNhYEpAikHChcGddJF0Bgf8WoJVvm1/XIKUhDGVcw0Vt2kksgIYSgQFG
	fOJZIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8903x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 12:45:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e663c29f2so310160085a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341949; x=1783946749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
        b=PXFBkacTwJceTFqhqJBSsf6ltplsVyF1mILnkAstswFcAGVzvy+5iRhvrqDo7t6DSc
         VUAIi2Fzqg9C5mj9oMmj6QuvFoQo/OZzYSyMJLDcui4rggaeKj2et0Y1H1rc7tZQnItW
         8MLxm8E3L9l+BDZJftq95pYPk0m7WmIdGNLyIEUvB9RiXdVXeVYnrg5FsrrEzzWTb6WX
         y2872wXk73LWJswhGJ4AiIwLLvgFc9zzX4EQOjQTfBrRFoFFyTbVUzDnLQK0I9S1JZpT
         EJ61RZOpVUp2lLSgn5rZv8Qenn0p7sX0idUWZnUTuHNOu/c6ANAkH6aDAvMOUAICiWoF
         e+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341949; x=1783946749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
        b=YnetKHrtwRpP3DpbTgkdtmDny/3GFUJNPWdT5qBi2TbhWiRXJ15M3dNkBT4A0FF7+I
         sUp0oBFcYnx5tciPRQPQHMwHQH653MKaEyR24gM0Xl/ImufvWKmeDHEmc9o9D4LJbnX/
         QHkCgOdvN6T4oRmfl9Dpk6FKkE67H1yf0Afg/vFH3c+macgL1VIV2I0qyxUPSat0KPrn
         6ZYkfhSudY3Iogdc6nlh0BX+W6rYClr/R8bUwscPXj9rvCkp/dJLF/9GDvn+uXqthJFq
         8aoBjktXtWmx0WmZ8R3QSCTK2Maq7EWxW+8fR98eS395kbICfG6wMgKODm2pTV4z7Fod
         SVlA==
X-Forwarded-Encrypted: i=1; AHgh+RrfFK8Yc7/igVSkxTakW41Fh9MxgchoO5URvwrgegFFnOkQRv0FqKOZwKY4NC2ktMZNLuYfvZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxard17v4vFjG+pJxodPMkaJj0YRU/eFIWtfuQRq9qpFHLRFWeU
	YioeIrEaODgHB2T4+4519E/Esg3S/X4fbl+a9ILjN5ZFxK8iAXN0hbQ4wZBuEjct5JADBabEQA9
	QMdvokwPVuV4MFfbhvdtt6i9vfLFL9JgnKgAFaiw+pVuYCBNG+Ris3uGWQ+E=
X-Gm-Gg: AfdE7cnnPDZbU1J6IphD6Pn6jjwND4MlbMRnG0zEok7pfi1fVe+mMVNbOeP6WTToAgU
	dGqUT6GWYEHUQJZT7snKCHy21YFGC2tuHGHCpRLyc12DPLS02eNFTiAWriO30n+GgroN88ab4pE
	eV+nSYSJWpQvvHRop3khQB/5ExDHs7SrnAtPlygDpJrPq+I3OPCl9EVpC6h6dODu6jQbq7AMMWM
	sKAF+WRhli1IcQkaOHquycFE5NATO5LdFyvu3ijde3HRd1yiW//ds52Vu+pbi8R8n40taWKEveg
	79doaZ+g8MLqHs5vUgOXnjm00MI3fHV/iQxVE18jfZHphkGih4iOqXb0M4h6YoYLIvsNgU4utSI
	wnb0OIqVPUgWgl0kUw3JYavxEFSQBpDMi0q076Vov
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id af79cd13be357-92e8b25f4aemr1773306785a.1.1783341947869;
        Mon, 06 Jul 2026 05:45:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id af79cd13be357-92e8b25f4aemr1773301685a.1.1783341947497;
        Mon, 06 Jul 2026 05:45:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:31 +0200
Subject: [PATCH v3 19/20] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-19-1ff028e33779@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HEn5owEzeJIUYkdvn4DQSoUKQdn9M8eLHqPgfVbyGMo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M9kHSk63/qP+xgNz2Y9PQyDSmFph3tQ8AC4
 5AtD4YK+kuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujPQAKCRAFnS7L/zaE
 w8S6D/wMyo30+5v8CLZilNJ79Z7wMDPBUG9sj14/UZP5eZoRp91qLsVzwolPCsq5U/qTKR3y/WF
 pZFakCrbpsJGqVqsKttIhxt2XpF4S1KfN1qC8pASBve+FNz8ZyKWhKOa9yoA01qpm32vrU5UPS/
 6u2lJxL4o4/rLQx8CT4xqgdtrSqHYMAonkNf5DACLGhTdz4ZNLZuCIo8GsF2zwWIH+cAxzjYd3E
 qqZHOI8wr8R2KnXC7H+MD0fJGcu5uQ+1j45nmYvg5cX3ElUN9riw6pLBLgO57aJVoCo/ucH6xOK
 GI4rJ/08Hr3PNBYdbcQEJMNE9yYMkjxiudHvOq8R4g0BwEVtdO1A8jbTcho0IUz53pA59iFnjyM
 ttMlMjXQhKSGu1dFNK6/elGJLMXC6E4nbUKvbby/LEHyHwLU0algPpHe9UPUYh3l/DrQAUt0udl
 +zNN2SMUOdAze/pIW2+l5sftft9+laItqGcD5M5bJTp7tPjVFcDskDf/PioUl0vtokzCPuP1F3s
 zP1G38H9ILdgjRhYpMdqqolRWhSDfehH//GwZSZfc6zSynuMNLzcAlJbgXUXpTthmlBlksAjYqr
 pTM9O9ZbxdBxzavLzPTTt8/695EpXxnwsMZ87oi6uApZGTqb0upieRcXVikiyju4bpSHudD6VYO
 /G0MaTqKJntCfNg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXwBneJrcotFXe
 kJLA2v2JOTlhvYc8P9yFhDAVnkGbfu3hY76SD/VP8Lujax33N2HIsCCmu9AhKwEbs2Eq0cPtjkJ
 SFzPqqh/Xjn3XqLga0lUulQPGXuHOTU=
X-Proofpoint-GUID: WqlobZzNLXeDtEBQOrXwzdIW9TbbplZ1
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4ba37d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: WqlobZzNLXeDtEBQOrXwzdIW9TbbplZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX/vVtnTP0hqYj
 bE4wxCzO8tY/Nbaw585rqbSpLs0MtWd3a9obR3uO+RlMRRxEiBn7TFNPTNOVl+nx2u7IDHTVkiM
 Bnr/dj9glMScV9W7PQEpUJqt3xUUl+gRMgJnbNfkzFKT9iPVGe3gtFIL7WsMOG5Hv6jrlaDNXQa
 ezmKegLrHpUJ+YExjUknmBtqJ3mQ5DMLMak2B+O5inxG7Ea6SKUlIl98skAwNk+eL9do/NMA8mq
 LMh4uPMRqDWTRnjcWT81idIlLM9SPlRN7kd0skO+8RZlvyFtzoQUjsNB84aGP9OPeRdfgejbtGo
 MJdAwMjlATWmU1/OR8aOXB7ATyqg/qtCShb8Yv1jralN+i9mYCe3ISpK7HOshex+RvYCdt7KCfx
 Nk9LDYqGzPMF5FcI89RF9oSxvr7mG9q+T0ok6buoSJ/uuSgyOlzBXWdQCrdR/jdBrElnNs66OKV
 /hlleKB9QWuBMDzwIOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305027-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:broonie@opensource.wolfsonmicro.com,m:thierry.reding@avionic-design.de,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:vkoul@kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:robh@kernel.org,m:saravanak@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:andi.shyti@kernel.org,m:andriy.shevchenko@linux.intel.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:ulfh@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:peter.chen@kernel.org,m:paul@crapouillou.net,m:b-liu@ti.com,m:p.zabel
 @pengutronix.de,m:luzmaximilian@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:krzk@kernel.org,m:benh@kernel.crashing.org,m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-sound@vger.kernel.org,m:driver-core@lists.linux.dev,m:devicetree@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-i2c@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pm@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:linux-mips@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:mfd@lists.linux.dev,m:bartosz.golaszewski@oss.qualcomm.com,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[67];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BFCA7112C5

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index fd75d9601a3bfde7b7e3f6db287ec8c5c45a20ab..f003b360629c90bb37ed0ade7a675b5b0f28fa7e 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -249,7 +249,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
-	device_set_of_node_from_dev(&vdev->dev, dev);
+	platform_device_set_of_node_from_dev(vdev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;

-- 
2.47.3


