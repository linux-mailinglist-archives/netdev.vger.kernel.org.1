Return-Path: <netdev+bounces-302531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gtMsAEU4QmpN2AkAu9opvQ
	(envelope-from <netdev+bounces-302531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 979596D8031
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nNOiOP5A;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VybVuWS8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302531-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302531-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE3930277AE
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A19403AF8;
	Mon, 29 Jun 2026 09:13:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341340314E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724416; cv=none; b=r4VXqsrITYfaNZ3rDgsAj0IFnsFnF5mDTNp7s/qXJcC4Ls8aHpxO+SAs5f6Ssdoya1VMhQztGE3GhkW5KzlhPtAzIFCDRTq7f8Kkyas7WJkYyGcKDCsMY2vJAZBVJx4sSTeYgJ0WxoUtRjx+dshbtuyjINzWkboM+Y4gaR5vJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724416; c=relaxed/simple;
	bh=YiZHp0QI3Ng/8lAx//2O4lFffX7ntR6tJ9zCtpgXyiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ka9lARfB0eBCJiHugYoi+vrNn52cxM81wQCwXwdVouUF+DL180wP02juQG/5eyQQS5wpvwXN1Ig6niKcMHCBlf0stMr2lOc7HM3WgteQpS0dMACxIdJ5Q/wAsyPEsN83nbKb6TdUFl/LTZYRC78qTl7cQ/e45+yTmS0MBl4trWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNOiOP5A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VybVuWS8; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8waTJ2391294
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=; b=nNOiOP5Atvc+atun
	45mZNhDx7q6EkdNaRDhn5LjMh6TLUjFzUhycSyCa3Z0uv5nBqXMOPxV+uSAke4Ku
	T7lMTA/09AOUgNWuRqRQ+d/zJTddMeOluwU0/40N70wtzyAnneMDXch6BBr7w998
	tDB8wNA5lT2pZlrzedKaDM5b64ztVvjDf0Gbs/SGiB48jRd7ISE1fLOXWLc5zYf9
	Xd4Qzg/SINHf5XYSXSgrtlAjVF/y2vohT5Kc9Yr7j3UtRtPUff6ADT0Wcj9A2m/t
	dgOrs/9D7nyS3eyWoxlNwgPKeCQ+C9ENwgsQy65LkO4wRNDRrDi8kxXeT5Vapuqa
	11H4bg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw825d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4aeea5c3so110843585a.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724413; x=1783329213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
        b=VybVuWS8NXVG9NLLEoO00QWfoUdILwapymJaMPWm0Z+AOJFZdfjULoeE7BiJcGT1xA
         kli9Y9NDpV4u8F6NisnRm2qCoIo6LFh2u1zBjhi5w6ngH24WdCt9b3yfTl8o4zSj/Rmo
         Eh/4xnDbHBeen3vhQxcXADtsMTEfEZqE26Prl5NMSpv04GP6RegIsWG+5+O7huV6RDtN
         pH7UcmyKi3lEaRHD7hL7E0paxI438xx9yKM8qof6GEnagwkRqphcc57dPsz2ykeOV2ui
         uSe6uOvcTIHOI1Xpa5xwVEmtMxLUpv24qQo9opVxD06Yd85vEX9Jhk4j6UiQNCJlGnAG
         jTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724413; x=1783329213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
        b=sFrCHfUg5VDekarEYJKhrUDs3ClzJAPylXv1SIo9Qtd6oUAeTBQtSjs4+6iKZw+Z2Q
         IgvjgVmxEi5lzHrVDXCKlPtEiGI5U9cN+zUfAWc+R22HKjhtAhr7NyMAE6Nvv8t0Kn43
         hUDQVD3p4sgnMi1U0jRM8dRORF0sDLhEmzleL8qNfEEXFTrkthV2lWUz3Zjbh9VLIXZg
         Kici0QjpqzDd0rLEeHwfpn1YS3t8Z/Ol4bKoppq5MWN7JuB24uqVIpzAKJXNzNS6Jv6Y
         rFduPVfW1FzRWsj9DPCPXUGld8iKbVVNY+bqRPCzQYYEkwmFm2PH1cZ0r5PcArmcKdJn
         XMNg==
X-Forwarded-Encrypted: i=1; AFNElJ9LGW3Ypj6FhcMZ0ikHr8IywHHfDDJsVBSuMvNpd379kpun2RTZXhQjhP0g9czUve7cFzLqGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRG7emqPbxPhmeuPVd/9IcHwQcTtIf1b4IuB9VCV/XoapAsKIi
	j+jFsxCeH98zmseiCp8Efe/fEc/wZi4cUwwvjjJmPzAtYhaKouDQeaaMuAmyFhIZNnpYS/pusQ1
	LTf+U0jzBGQPYQc5vDBLMklWWyhGs6SjnGR0gVEFN9sHO4KcCge4mVuPv3b8=
X-Gm-Gg: AfdE7clvnxPZiRy8cXcuV3Ut7E7d+hUtuvhp9llhJBiDZf0dU9+5zUyM+ZqxirVuy9B
	KTDOEUFncHmnm9BNML3Z0QzLZ1Nr5jG7JTdwEEXMQLhWf/82973WqZE31Fvnl6XZm+z5zf0pzyt
	nzGYiy/I97LToQPmQlMbIAxaEOGzolKoCoMC1Sh25ElPs4CPVcHnlhjgr34gPjwfkHVNqEermAE
	kV/KXRGvFLIPpB6yZSqLeakPfWOWJUBe5atPywvB5CPgB1sA7z5t962fewBmGw1GqYTEywz85nc
	ht6hqzD8adZy0q30DoYNAiZbl4lrLNEifUO9QUa8/o0yZV+bokf4tdLiWW5nIwxempnbcUSSoZH
	IW4Ur8gn+mXh4BNFYqsXvt5CZQYPGpSACzeamjrzP
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr3581736885a.39.1782724412951;
        Mon, 29 Jun 2026 02:13:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr3581733185a.39.1782724412420;
        Mon, 29 Jun 2026 02:13:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:34 +0200
Subject: [PATCH v2 11/19] mfd: tps6586: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-11-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YiZHp0QI3Ng/8lAx//2O4lFffX7ntR6tJ9zCtpgXyiE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcRLZEV4wuAyM1XFVhA7zrIOgiuiY2Lgzwoy
 WvXthoR70uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EQAKCRAFnS7L/zaE
 w1cGD/9752d9n7/+/8T9TqF9iQ7G9zlOuyfPubcVf3N8oYfxQ+0pZy96O9R+C0vx5H1PXXRmjn6
 1MaB3Vt39w1WVmSUyqDJ4n8WB24AjpfYGTwAbI0o1lZERogpod5E3M9QPnnVwD9wPPhllmUPty7
 xj30SvOca8pUgImOxyER+gR75EsHqUPeWQasNVopAFx4mS1lo2/u1kqscnDBeqg6Y87buduJX0V
 uOUtSHuQ7w2vlhQ7NqgZHurmNliUGIpxzWfiGSSX3BK9D3AkZSWvLW8zctTGAHCPG+qBFzRVpQ6
 0FqFad0z86W86hiNnldftd2a9NL8dP7GfTyhmmggP/mzqh8x5/bDltnbVjzYzBrVM31qSvqxNUS
 YPD8Ey0CB/ZX/lcEsaoLCOsAHRQsJE+Pt7xReohmz/oBquTOGfSFv1jtm5jIY03sh44Qnqc35QD
 CAnMCCHblZZB9eCTh3y+FCKJXfxLvwMdtbMKOLf4azEE/0LB+S0PZrFvyocZSoMtKLtoR4aExim
 DnBupTzpN+mh2vq64tVXBcwg38pkExWqxEX1LAQUM/UmS1ByltvukbJRxqlHs8WD1UJ+3oTsxSJ
 w/mPtguXJ2fFOtqgczI61HeMKF4E2nHfhBqpM+JhFX/aZ3O/llYHjqsfXoVg6qzpOOoGiwcLxSI
 BcmB/XQ48OIAacQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXzbmaj/8n4AEn
 u01RIWx9vIgwVATNFxotpGfNFuw+c8bxbhHOmxSxLoIKb4+hqBa8wXV5K/ltASXTkKlLedzvLZb
 PNDXi/XikQ7vF0w2dkbYXzmX3atY5/k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXw+1ABYk6l5wa
 Z91MVqZIxzlNcOeV70ocMHcUnz7J6pS3RYnaRaztP19mHX1CS+oZLsRwI7sytmxeiAZPliZm58l
 eoviEMLHnSdTX9w9nT5XF3d9wYCOSTs9HobzlmU+gaGt5AqgQIRQ8V1a9xCRTU120sPn8z3poX9
 TSqoAja/vY7ESeEDHCj//lx53t78dvwUspZwNj7RQZkKKNsCHTQ6yPcFesLqoGOasdMRKeMsNwK
 dkAhOykjjfNqtcp9y+bHd0wH6dFvr6H8DToHGkHInw5No4ngkhGx12ZTzJyMGgMV2dqAQTwIpmW
 2gXlpNTisYDyfAJuySzTmr/YjpQ0KaFY8tbu++D94F8QFWXay1bnD6SvgEUudpRhmeZGhKFUPu1
 02dxqIHwlY/m2mDM90B601mVWPXsEedjDW75qV3TaMZ3LeM3KwcP4QEaW9x5RiuQ3gtThzTVq98
 1e2J48HwoxgWO63ZZHQ==
X-Proofpoint-GUID: CbUy9_AQrnmBmQgsJA7T-WVb9vHztNNf
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a42373e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ESSmVKC5p6WdXJfq0SwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: CbUy9_AQrnmBmQgsJA7T-WVb9vHztNNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302531-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:broonie@opensource.wolfsonmicro.com,m:thierry.reding@avionic-design.de,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:vkoul@kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:robh@kernel.org,m:saravanak@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:andi.shyti@kernel.org,m:andriy.shevchenko@linux.intel.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:ulfh@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:peter.chen@kernel.org,m:paul@crapouillou.net,m:b-liu@ti.com,m:p.zabel
 @pengutronix.de,m:luzmaximilian@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:krzk@kernel.org,m:benh@kernel.crashing.org,m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-sound@vger.kernel.org,m:driver-core@lists.linux.dev,m:devicetree@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-i2c@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pm@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:linux-mips@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[66];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 979596D8031

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index f5f805446603315ba76ce1fc501c908f1cec0d16..3cfd2f02b62f3cc370e0d970ec2643b638fd0fec 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = of_node_get(subdev->of_node);
+		platform_device_set_of_node(pdev, subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3


