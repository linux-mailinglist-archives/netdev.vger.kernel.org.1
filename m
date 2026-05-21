Return-Path: <netdev+bounces-290289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNttLGbLDmovCQYAu9opvQ
	(envelope-from <netdev+bounces-290289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:07:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114855A1E72
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501EE306354B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990EE3A4F4A;
	Thu, 21 May 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpJqCKOQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btjCBeSp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292B3B4432
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352664; cv=none; b=d/fEHEMNOy4KrKELqRR8moRFqEmCTvmgHjA7fK+MekSLBjqE9qdMJNfRlFNyXzC0O17xGAOgIsNpEbZIA9rdrl2HX48KsVIQdMA+4Ce+Sn0zvu4nPP5iroi/ctgUtfBM7dunSLv86rA4/biFSAEYIadbV54Y6gQ+cLH4xRRw+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352664; c=relaxed/simple;
	bh=CP8cW3hVyUyBk6KqxcfnwpcDkHgTyD0WEhhuAHWbRgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BteF+g/aGEFTVIdkRMmpme2O4kOVV2CDm9ta6ZF29T+soRoP+l1jDtOSeMDnQxT1XL6puM/j/e95dQRF2Ubx51oycEldlbCe2ZPoxI7CluVVFfBmOu2WUEoUzn5prk0c93r1vOXNK/2gyxp1dbIM7OPW80N1c9kS9VKPp2FA+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpJqCKOQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=btjCBeSp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8Jli5748564
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=; b=RpJqCKOQq9IjMBeI
	NaUmV8pVneazD/ahQBrqvfJzEXvEdnfk8sRv5HiBPsutGW3ZWL1eakO5x5DWui/v
	nDTFgHBIYNg1ZOVvxjY/t09M8Z8r2UjxxOA7sjm6bgVjc+pfmITt6G4UsKYy//mp
	lCf05vqPVt/Emmfa3MMfL+XgpjD3OcXU2irG3Lp+Qedki4jY0DXfvMUanelej4o2
	D6YVAnumiEwn+Jfi8/gQT4auodm2JP4r9kFQ4Wgl0iA9Q2aJXgolbKGmPB819LgP
	15yOzw+iJgu1B6SIhaEjisDGvhNaxO7AznpJmlWjOK1tlp6YkaJtyWHuhYZ7BgSE
	57ENaA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kj7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d6bf346adso130055001cf.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352653; x=1779957453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=;
        b=btjCBeSpOiSomizHc1GLscjTzUi9FwoyC1v4XiNMGtE9QFBY2wnBmkpVP/KDfAI8EP
         YVh9ihGWz0R+5AjJ7iUFvFzgyN0LhSZEiPabjCyGYDY4IQk9YH8PFQagB/0XQvtQfhW3
         Odv1q7CZuAs2KgROv2t16SgsxC1UKJ879Cy7i3+IZm7tOumnWK2OWXJ0b+jiHHUATpTj
         hGc7dIoiWJ2eJJGmEuXyucyfKWsaWnmMQCDaZ38rtQ7bTKrSLm9hNcOrqqMt1IkcKgq2
         GCPKUgCS3kWe9GLKPhai/mU7VdaeXAWvAHcZtkdrMZXB01BMMgRDVW8ynEiRZr4m2rfr
         KGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352653; x=1779957453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=;
        b=ATeSLJjusivpP7af6aDeSI1Rp9SbKpEOWjDlsCHkQvxQOBBtdsaL62JfoZfGMy3aNV
         9SuJvk7xgpSAV/YXDWRANXeLmmAj0hm7rpuy39hD00WK1w52J92L4a9/N1rPBYgrIBgW
         QGUXoXaCjtMG+EJMTSJu00itsyeZQD9hRIAoY4usfdIs43SQAOZ/c4U7JuL98dSaymCc
         MQ3AnAwV+lAi0y/1YVgEHjA6b0Vv1no94Is+i0QE/TpWsjnvYF2PCUwVBDfD3hL0jWpj
         zoeK+qdo1y4UHLr7O6z5UhCM4oFZ2A+uElruvmWtm9qp8KDyAcx8AXsFgOmITY5KavBA
         ZhMw==
X-Forwarded-Encrypted: i=1; AFNElJ8TUt7q5bHRB37FJO1ZVfW7YKS7SQAkbDfgW409VU6PjJXW31JYcNbchZ/n8CFEEj0/mF8toPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJ7+1ZXkq0lag5U5m+bU9GD67LpErkIVv4MrOD1+rfz2JgPLr
	zpS0xxR55AWDqhc47eFD2tgD5wjpAOdhLroGC3mnqA/IEcUG+fS0IDAUQLiMp6ucUDDzkvj4WEC
	7Dp3Qy3PcPcxUaqHlgsmmXAT50pLKJgpjof65Sc/+Atj73uPmdHSXp/5UA7E=
X-Gm-Gg: Acq92OFhHpvn3fpOwcBjHZDgeUvaywicfWGrjYU3SpQiA9EMXkh5FMgkze2NE8QZKGp
	MzpIHb2lFm2JPrCb1WJziZxfa3+7evzXQmVN8qQTj3s/VmOgCN3VN/WKakatuoaDoHy0t9rHa1L
	9VrBAmuFhgjf7+EdesoKAEeto61FLXAf6XCFLgadQ4VRT9YtynrdmHkODVJyTquIOKzZgy4PeCc
	uJFCcMEvNnWiaiAX3kAlV2XeSbmt0OQbHQHdVP6akw96J790pLSzpMO7TFCExKiZX6QYOgwm8si
	PvaGj3vQNFQ/jWC2XmVMAkmQn+flj7efmDpt5b85IGBT+YOyradMbBZU9vB5yxI9M+tzTUXvZyC
	I8jtDvp5FnpOejRlUDu85Fc8xeqVdAOfFy0M/f2ombUkvQIwfvxI=
X-Received: by 2002:a05:622a:1f0f:b0:50d:8903:ae6e with SMTP id d75a77b69052e-516c541246emr26414341cf.5.1779352652777;
        Thu, 21 May 2026 01:37:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1f0f:b0:50d:8903:ae6e with SMTP id d75a77b69052e-516c541246emr26412971cf.5.1779352651284;
        Thu, 21 May 2026 01:37:31 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:31 +0200
Subject: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CP8cW3hVyUyBk6KqxcfnwpcDkHgTyD0WEhhuAHWbRgw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQmR59ng9ZNR5OHp6pe9/iBiLI17IMmOUyhJ
 8EAIIWC2ruJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJgAKCRAFnS7L/zaE
 w7UhEACvBFXwsGANI1Ib/eMS7OLOYiNJGoi0+qsSwHeOOk3USSuovHrB6FXSsC4LAGC+GAA5NWb
 aCNZGLDNdaeLPQjG4T601JVMjYXjB9oekRjFpJj3nwrDY/nE0scU2xXlcxl5l6VDKfdKWzZuQJh
 GGuAPfluMMoOs4pPXOw9rAa/Vi1i1LnUS1QpoCeZdRYuWKo678shNQFWgEh9NsMVaHSpp6nONzq
 4DClQ1B3iJiZBQecmFxAyFAgjvfR5PCYSICb7XdS55GHrYkSMvwI93sLAurc1363iPl8OO2DIHy
 XGjow1moTi/Mxu8z5AbQ2YMuxVz7EgumVVA9+1IgK5jrXg8uaQc4c3URjsHh22NNTOUusK80ECM
 VxfuM2ll3rkpLGR8oBfjX8F/6tfH9OHdWYeIITbC1oAXnmf6xeGpsvSFe8EhHNmvSWLaIzEgO0/
 txbBXyDsW5QErzNf7RVV9nI+XRK9Vvori7LTikzq8JHQOAluFRjM3uuzcMZBx12p4Xh0uuEvN/V
 VE1un3bx3mhk2gtkHann2FK2nFlYoaljscYVs0D2diCC9ran/CLdiBYQ3HQkzN3st8vLX+KkH8R
 ERIe2jcuu8qftX0Pj5PDLKrW0xg8HbbxQlW0J3jMT1NWs9nDmkZ+gm65hiSPfOqUQOZY7aED7My
 7hqzdDwbnU6qmLw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec44d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=nFtAjRmdzOROD1nQPfEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: kU0WsZYJds0Gl-uZ_bbbvRAEFjOPpyk4
X-Proofpoint-GUID: kU0WsZYJds0Gl-uZ_bbbvRAEFjOPpyk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5j9vbEfU/Ffy
 8NeCVWqIqTpAZ8VSBESNgr3JyqAfIf/gllRsvP4SUcYEbCyhrbvUS2XDcTCTrGA+4tpQq0Waj7n
 jqzCEVMZiEWUUJJ06sIqE96Zmkj1h8vb36JEACLPi7Zoj/QcaC9PTmW/hp+zd8uCEqVoLqfTo+6
 MvtJURueckjn9yA7pPAuJywXZ7/LvLWg7mxdsXoeC5GWvxGEazXLxf4mAxWBo7aEzpE+hd+JAbm
 SVvNf3iXYxMYYzvpu/+Xb2tzJZhgkfVTH4UnnWmBparYGEDMvBWnD4/jijfT9DSmVRsrl3HhdSs
 DWmRJoW8rMaAQMilUQzclsZu0EPOEsfZUh1UYp5PMf9iUytEbqSQlfI6z8UtJZ/kNKp8nRNTFC5
 sk2ib44t5ScYXk31WoNe5lGc4f+fXG6B7UTmkr6ubArAaxAtAhkdCKXOI3Eb88kQdwxyae/XhY9
 hemoyqf7JafPxN8TNLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[66];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 114855A1E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Provide a platform-specific variant of device_set_of_node_from_dev(). In
addition to bumping the reference count of the OF node being assigned,
it also assigns the fwnode of the platform device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 16 ++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 449914e657c9c58cbf030208e60583dde728d6c0..b14f707f077bcc535fff9484d1ec904616d0a1d1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -730,6 +730,22 @@ void platform_device_set_fwnode(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
+/**
+ * platform_device_set_of_node_from_dev - reuse OF node of another device
+ * @pdev: platform device to set the node for
+ * @dev2: device whose OF node to reuse
+ *
+ * Reuses the OF node of another device in this platform device while
+ * internally keeping track of reference counting.
+ */
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2)
+{
+	device_set_of_node_from_dev(&pdev->dev, dev2);
+	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node_from_dev);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index a915a6f2da71284b60a6595dfeb013ca0dba542e..e5ca686f23998a3182a9573a7d1e84c6a6fcdafb 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -268,6 +268,8 @@ void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode);
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


