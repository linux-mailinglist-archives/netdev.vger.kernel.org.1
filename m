Return-Path: <netdev+bounces-290283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEoZLOjFDmqzCAYAu9opvQ
	(envelope-from <netdev+bounces-290283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609E5A1529
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8876930F878D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE353A83B1;
	Thu, 21 May 2026 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/eaP3Me";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LoYoy+Rc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4403A6B9F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352640; cv=none; b=g25dBe7vshoCrPU5Uwcx5MkiTAK5aIOKgNRjMDadNAa1CKIgWAXCQB+tDM252FzQW0SNMCjf+ndqLFfe0AwCmcsV1vmaL+MtJfIunvUSHIRcnizDhfHb3oskmhVLIn/LI0SA+tlZF33WYVCrzh5MwvSXLlSr2gsc0GQbV9sUpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352640; c=relaxed/simple;
	bh=kTQKbm6eRN9ag0Un2nZCXzTW7BV3akk7azahbn/UzJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFg8h6JQHltXfw4tDFOKUZNsn8//E6q3QOa09om+5Xs9uYK9r934P8IT0GG+QSZQqepAMz3DjZUJXjhGHniDsZgNXgXZ2+aedMoNtOQbM1moeT+2IOqGEHCHVQ1jK9nbLtFFykvZc+S/xxUs9Hlb8/nl3EPrLm3n2kWsjD5GFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/eaP3Me; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LoYoy+Rc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L7PXPH119026
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GQi/2Sa2Ao4Qw8qIIsWmCidg4bHYCZ9URvi5VDdy2s0=; b=L/eaP3MeOWaUpNy6
	L81FH4QqV7eTsVlLcALgYeu3AEzESKyGvBjdCNPdLjd1PyF2SZVs3J5kZTQA76LG
	QAa47beiYQc9Iaw6z68RT6nfHwSlw1VWGCNvodnNl5e5mx98F/WQXUOooyAvfe41
	b3H9PAmUsIdKxVaoqWwTX+LLGAOwmbUEcGTU99iXRSUjA6qlWiUdnfQgGXUXA0/H
	Vwt3MFFN9p8ZoaDcqYEwJO0s1wJqUyu79HJCUM/WGg2ypLhk/ox6shunIfuY3U7q
	oQa3n9rDYxnEdqImbmWMSdsWdtVcy9xeO8cS+TWKP0DDwYt/liF/85jDISbCqOhP
	bmenKw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c17f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50da529ff48so163883991cf.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352636; x=1779957436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQi/2Sa2Ao4Qw8qIIsWmCidg4bHYCZ9URvi5VDdy2s0=;
        b=LoYoy+RcHnuCuRGf4FjPJcP2Hbe/MFLqBz8fzuUBq3hAFi6ZAA26WnWeNjYsqCcAJf
         y4z/D8tM1lbVn/W6TJuPZp1egz2ULdr2BiyEPQDgpzJUakPkV2+jpPUQEgfZhsXQd6Qx
         i1yuZ1zHzGgsXNaNdd9N7ggcWbft1Q5P7/MmcBM/UQCpUcBZhWTjeP4OGcKMt8SxaxR/
         BnKpDvtEJm4u1FbY+cKGy1Rr44KMjfiEpKyOHO9GpLIy1OGLazAYXSZ6ohxYLKooChYU
         e9MCXBsBu92vgGO5EtKwdBxQjQtp+/iGwgGmoeJVvYpmd8NifAvGPxQtzpkh09BPJbb1
         kDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352636; x=1779957436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQi/2Sa2Ao4Qw8qIIsWmCidg4bHYCZ9URvi5VDdy2s0=;
        b=ZstyXel9QqyUE/lDsvECG+Wx/Zhagzt359t2xJfLkahQvrPRJWon3msglbsvBADIcR
         J/gwq91z4rbV9d56Yqjtg3kSnWKRkaE8FAZTpI8zyY5lz0xrd5NAFMmGfKPcbcLMoht5
         csiUfc56vw5kRdz915HxjNK+l8PWpcgCoKSXKNTepKlnP0jKsqmTgGRPCjc8ILJADxqY
         W1ckmU4WkJiQXvIBpsn77NG/yjRJ4/ioI34B3L9RkfY/4U8cD3mLMi0NEqjRbRVICyn4
         rKylDp9q8Xz0+0zM+pobwMa7/KDr4NEG19L8Jl6PBVIUmUoxeV0QAkqvZKdyaTESfE5T
         dGHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GxKvH3MMYyI6hw3oUD9SYx5KhTYlk/59fbob9ItxnG0Uk1/MpNpsGuXw+AO2JBNaGmtXCcLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1Vv3DB4dT5gxZNQzQXnI7CLCSbyY5kxHkAJ8dVTd1C291wFR
	Q4dyGf2nA/s4KvS49fxiUKSkyRv+p2jA8jXbjz9sGr+lnWerd7Z4R4POkIPgys2YBtFWd2vIPBU
	8uijdL1EHFeeYcY9HPQsGnlWwGOlbu+5vjwEoZ+iYYbYKxSRdyNJ/cMGBJXM=
X-Gm-Gg: Acq92OEM1qNq1dWieR9K8n7wfLn2tNz1YCLTFryyLZPr4dm1BPX29i1Syh1VCqDsy9t
	vpu/lNQgw+wTygidOhFA3nHLfIfR40GyQ/VZwrOdK/vEOiaPAsl40Fq58IZd/Thh0J9cjvfD00V
	NpiSzJ14824PaHScSAkvuM4siJ6sEXE/S036s/q/Gug4UFNZmgJAVOc7J/MzHV+ugoM2QAGJouF
	6TEblACnDVM+7Fyjt9c8UEwBoD418XzFIC8HTefqsU5caglfIs3C6LTQVXfJGNEB/8px7eePn7R
	wb6WKDcnJtm1epRqm5oCgX5RqeUtTPRXHguz09nEPvyfDcrZRIIFUqbMjRlGM8lLi0V7YUDV2oV
	mFqY2FDLpBNJTUlCcIZ1VIkQ0KxtJOUfqmhcV1F0Z8E9JBx7x5ss=
X-Received: by 2002:a05:622a:130c:b0:50f:c109:b78 with SMTP id d75a77b69052e-516c56114c7mr25055831cf.60.1779352636315;
        Thu, 21 May 2026 01:37:16 -0700 (PDT)
X-Received: by 2002:a05:622a:130c:b0:50f:c109:b78 with SMTP id d75a77b69052e-516c56114c7mr25055161cf.60.1779352635782;
        Thu, 21 May 2026 01:37:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:26 +0200
Subject: [PATCH 03/23] slimbus: qcom-ngd-ctrl: fix OF node refcount
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-3-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=kTQKbm6eRN9ag0Un2nZCXzTW7BV3akk7azahbn/UzJ4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQgIMxfR+Vbirqz0SdcKiFdhrIvHLFQpLiZ1
 CS8+oZRD2CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIAAKCRAFnS7L/zaE
 w+/+D/0bfM9BBNs3PkNDjV3H97Mjk+BxEtuO3ngB9aYBqCWAj5QNlt01IhjpA6JnwDFP8fqCIyv
 vjkgxJM6sX4hv38HQ37w3/3e9w9nT1pEO8Z+vJO4ioacKerKf2Q0pDqYaIvMKRt/6v7PZ5F/8Qk
 F0oK3T58PSr3/oja0fGdyamleQyFBi3nxqx0i5pFUhtKOPDLB2JFMiF/Bc8z1Ao7b5/iH3mCRqw
 t4xceOWbqkCGcjrQwrwQuaQSwOFDgpuuNyxmj1LqEJaU/nDLivdr0K2cDU/9sLO5YhX1oEhG2nW
 XOO37zyMEA5NZH4QY0XDY91U+LIW+AczElBXOp5HW0hZ93FukF2Jykzc3pqr+4YnbKGcomK+0Yf
 q9nt12I/oL8N6u17VckldD5ZK4oqD6w1sf2nwZHj8W0dw1+L7YHzf9FRkrLonMvjMF8CzU8u+sy
 Jy0nFN5sFXOEVUkaOM7w5NUOXxfk7efn4VYU+BlGan6tS+++PJdEI8/oFCt6Y92Le98zlLOeLaN
 4okZNZe0VbOfsGZ7C8aYV/L5BdKwVRPIyxpJ3u3CgaMyWDH4U+OfUQIYpUzUcMflrUDECYMZMEr
 P5YYEoi2xgk/wmO4H3kPlxxCpOwXpXqfE9cRHoxk6WbFV0NB/WCqRqm8xGakOeDDaQ4wKiLTEBG
 Ah+8HIb4q9OvlZQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: _PNsRFQX8ynZjq-9e4FPrv-UeS6eUKKl
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec43d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXwNGCxSCWiikF
 vbfjlBjDbNDNcrADJBqhlBZDn3p07dUpZVS+0WU6+Fjrxjh91JTND5GqiwU6z/fgfOl/dAvvKb0
 g7TJMiSAl5SCfEDHFduJTR+cLji6UluF2bDPITCPlTvVOFlftMmpNqVd1GpySzoWOZQtfj/23xx
 Oa8TMBuPagk/7gHkYXiM3QejHVmZ5+1AaBCMGvhRr6fr1O0h0zCxj6SwrdI1ieQj8l9iDA9b7Qh
 S5kyVwBcv4Ko40lAHcvJqxYhhaFMEIil720ae7aXkgueB0R+boq51+KsSWDd28TMl8iRTw/pWe9
 qrGP/2OtAXe1SWOgvDAH/ux0rbbHD5Rc+eg8gbAqSqU4nUDZGiRm0LbStvSJ+SZDImUlowM78ng
 2h0SYgXSRbkB4SP/MdDdQScSS5QnAyLrzHzOfv3Ev5eNQar05ywU6DcC/y6j526uGwz0Ia/z93e
 AANgAKuj1c/UC9RH7Ww==
X-Proofpoint-GUID: _PNsRFQX8ynZjq-9e4FPrv-UeS6eUKKl
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290283-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[67];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1609E5A1529
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
Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1ed6be6e85d2cfc0a2b65a5ae24f666de922c89d..428266949fdd07ac13c5553bded891225c6e1a16 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = node;
+		ngd->pdev->dev.of_node = of_node_get(node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


