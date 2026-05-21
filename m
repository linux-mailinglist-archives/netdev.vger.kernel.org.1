Return-Path: <netdev+bounces-290292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKWXJL/LDmpoCQYAu9opvQ
	(envelope-from <netdev+bounces-290292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B65A1EEA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF59C316C5E2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905A3C5845;
	Thu, 21 May 2026 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YalB4pHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5mz6nff"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B23C1995
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352679; cv=none; b=tkK0VuFR2H8N/phjuof6f+WAmfdyyzuOH19iFp9m5PAN/W0+eo4DmfKwjQyLEiBwVlmdVS1JFlfqp1LO8fCIrMIUz7CF+khEXTEpduOKes8uJ39W82ij26Ga5tIKhvL+1xvcKU2mXtYVbEyvWIGBczNSJ8fonJplZJEk6NeD7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352679; c=relaxed/simple;
	bh=/a+MERyMSqDcoSUK0YpUrISA2FCHwIZDi0YPUao6yb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETMh2lB5Af0GyEFO8ltWmmVg5Ioax/Dx/EOAJ76d4FOkl1GmCmNQm0QTuaiQg2jhyg0tTCGixN9FbBheaAWFrJkSI7TPfD/Z0j/C79kcylVI+7VWKtIl8LwTcTsEHOypiE/ouNsQUnyaOT/LHNj5VzZklPjRVnt2rXR2A/4MtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YalB4pHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f5mz6nff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6Umwt2157481
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9A2tU7W24wHfGN4B/qiO8RCtMLc7lIw3uVlzGKe1klw=; b=YalB4pHJpzpglVnr
	oLK/FB8peejpgKNYZsuGUsLbEL1xet26NbmiQzQ3XGxYG3KZSEiPToDswLtDVh7L
	dqIL2nKHwSLQL1lI0DVaSn9+ydVafD6rhYBH85aCJ/mp35B7n2X/TU5IwkBpyX3/
	KvGBx9+m/E0c0+whgpeKAEQRUbtIx0bML1oVyUKC2K6cFQNlaXI/re5f75V4TLFC
	ZByXbME/5ecAxlTTbmJ2I1IXdf4eYWJuPTnIVogCarJLERm6Tab5cakGkdDHrDHs
	Ux/dePNZWMSBr95PyUVOSVSuUITkrs8nfXVqsH6t806tbVlX0YHFAHtVM2EkSyPc
	vcikaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma428yn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514d2b22e7fso81675981cf.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352665; x=1779957465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A2tU7W24wHfGN4B/qiO8RCtMLc7lIw3uVlzGKe1klw=;
        b=f5mz6nffa6JMdZssn+h1/smUZAEqmg6V9XgsUWJOqm7WE9Yts//q4PisVUkCkARNEr
         9K/3qYq2lu4sLCDMxvdvP6nzyf4QSw5VQnEPKDj1Ku6cwPBbe+I4jbsjw1j78ZsPonF1
         YSH8QkOf2R1Hh3Qt/SFyKulEIbrMAB0NqoE275CmwjjBjw2ZCuc4kCqnHDStmkSJ2l26
         dNtmawUKHdmQb07izAVbPfHKUigGLNI9GpUMKL5M5NKhL8NAFMY8cSLQc41bMRzOBHia
         LB9sOsjAh4lhihedWjs5StE5svsyr8rCEsRYe/cNSLBkiy+v28mnfY5PO1XGWLTb40HR
         SVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352665; x=1779957465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9A2tU7W24wHfGN4B/qiO8RCtMLc7lIw3uVlzGKe1klw=;
        b=br73xDuvwMOw0mfJgiDI3+D4ObuJUrIHQK1kHOcJ9eB1Uejk160U/v8GmElkr42YU2
         6UuCA352lJOKHWZVzkMs8TZArISmItNwzTSeOfUrzqn3Syn2Jnabl9c5rnkeP8oNwxvS
         8Hl3T0ccM9VCDCKn6eBhgdhvGRi8kTdt+OK19Y9xsQlIizGjDTbZv7H5TEcRUvX+YHek
         8TiOtbIyYuP+7pfYU3tbpNlcafkuL5VZJdo+zjf6r+HD6ZaoWi8op++B93oiItUY85Hu
         6VTfGcnUlrFkkrmSQwg+khRbm0lXwofR9IsvBEP9/J500mm55OW7kfYTRR9zqMMjV6Gh
         jD8A==
X-Forwarded-Encrypted: i=1; AFNElJ9V3z390j2CWPkYusRxkS9N/4Cgan4roB4WWDCPHfwf197BPlxFmw95EjfioQaBNF56n8M/cKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckyimJGkWp5VDPH8ueYwBmYjf12p0b1VTQ4N02oHEQ/OVlALm
	xzYu+RrYMriK04nPH6lpsCd1XfgDIRs4AEECKIZNMRcPLXMiisUd4B9sXmjkLem5rrbCtkF8erX
	8Gk6ULh5dEfD98RSDv9mmbfZn4QO/CGdI19BsrLMfj26yWoVszSSyngI0RPA=
X-Gm-Gg: Acq92OESCoPW7P00DHNk7pb5oRGeoAI6gn6yezmwJkDply1i8D0UV/LYG2gcjX8dn/L
	zSVobFZaM1DaEcC7QPmMrjT8lxH+4GAaxxq3yi5ohlP4dWZ2dWa0ZF2qRHiwQGm2z6s2AHV7RN0
	9XSlI0MmsZ1eVXnJ06FhBqFLigAzYanr2cts/84sMdmWvxr4Z5aP7ITtVSa/BzqIwkQosjxgp/X
	FV29a0IqFlA+yab+PBqAg6LgGHJhVAnlcY6tXQBYa4BA3lZkZ+7pzw4kNGVH8K0xqDOFgrS8HIa
	31NHz+AYt/l1aXXIjrc027C6rLD6L/IP3gGtw79VMjtijSvXkTq/4ux2/MmMnvrJoAz+rZoxzsd
	kYu34S+mg3JJR8uAK58jNt+S34GKXqvSGPhK4rNI/tSKZshjYBIA=
X-Received: by 2002:a05:622a:4247:b0:50e:6183:beea with SMTP id d75a77b69052e-516c5541ae1mr24110941cf.23.1779352665394;
        Thu, 21 May 2026 01:37:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4247:b0:50e:6183:beea with SMTP id d75a77b69052e-516c5541ae1mr24109441cf.23.1779352663505;
        Thu, 21 May 2026 01:37:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:35 +0200
Subject: [PATCH 12/23] iommu/fsl: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-12-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/a+MERyMSqDcoSUK0YpUrISA2FCHwIZDi0YPUao6yb8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQotZe8en0K64gdcDUDXtpmS6GOzkP9zhLUG
 wQiRdRvUuaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKAAKCRAFnS7L/zaE
 wzJ0D/9ki6yMyfxj5IPA4WZXhvSRCjYfEyyzohJM1lkxI7225RU8N7R6I5vmcI0nALd2JoVBrQN
 dHQk38PS2J9r6YDUA0tfaqeE/XdOejp83w/mESILl91sCQ+Y2/ym4ncSQjVS1DKHZuHnT6P6iXZ
 ngP3JB4d3UEL+S9YdiXguejpCjLrxQsTwHwn56GS1T7T0E7Xdns4Y3LjqruF1DGdNXeXBnVhQic
 GkSLBbtCLNlnUMra+NfdQWune2cIBiRRhyajsiCetgjQh14UcVIkPcU2z4+4AQ/WJni0G2eKV0V
 8HxvZyJD2whJttOY1Nl9QcLB2z9x6HP8vHf1nq70L6FjX65o2V2l6upCy+ec8TamrRkKgieELkz
 EvNScrepAodJqwPZUTI/aFC4S63UkYyLS1CNtTzUcUFoK5RmT/Pls9eTFXp4FmOrkqOcQoTIhHy
 8tP9ZXTyJNRwr8yug/J1oB6n8a6D0xiOWEuiQhmCOSJRuBdlNMd/1KJ9yeSy08IaJYTF3DgCCOT
 Ql/Y9OBEipMJ9mdR35+DyMyacdNCH3ebjNi2LLXJKBvC7ZMIBN6mNrq+QJnTcmxshM7BmJ+Es8+
 XPoBDTV+KR0B8MFgJBV+Fl+7yZjHHn1yUlWKnChu6berFk+8LBbqEc4im1ktnXzJxODw+7QkWJN
 it2vrdcf7zOeI7g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec45a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=lY9XkqB3srsPruLtBu8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: cS7dkDVsKOldJZSYnHwGtHJe0a5eqdzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX15kpYlD8RubX
 RqjmiDm9RVm1ZY4eVEf/TOCSf6fkVvzFklKz8ymA41dztWb6lr94wTGLB/d7czxCc9yrsy2BYSs
 mGjuZ4HIjafGYprz4LLXBGpGIe3aQVQo2+b6Paz12AYnfNJCWvAQyvQk+y/1Ka9dFe6x2+pkjp8
 uyeUDj1CX0YkQ0VPRAxZQls/3tJnNm12tOQo6MZZnyqvVwawUWKNFGfAfzOUPJBY5R3ODDHxUqo
 bRZmSOobtgE7vTCIy38pWr4nVof55evio5ROc4zLno2VH0GFRrFV+2cLH6kilUUwYMPKvultmnZ
 a/He72VDtsgK72I2yAGE9eqcyKEcWKe46AWO/tdHJK8zAmo/o7zHbfVX6vxHHX/9r5911POerDX
 T9y3ZX6/6pzxBJ3rnYjXSK5dt/e2d9WiVDGlK2SIxTCWTxImqDna3XIjHMA8XNwM4wifmtB9/RA
 5rEQxdx1WZx+NulWEfg==
X-Proofpoint-ORIG-GUID: cS7dkDVsKOldJZSYnHwGtHJe0a5eqdzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
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
	TAGGED_FROM(0.00)[bounces-290292-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[66];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED4B65A1EEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/iommu/fsl_pamu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 25aa477a95a95cb4fa4e132727cde0a936750ee2..012839fa0d8a27cafc6a441373f4f6da794388c1 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -973,7 +973,8 @@ static __init int fsl_pamu_init(void)
 		ret = -ENOMEM;
 		goto error_device_alloc;
 	}
-	pdev->dev.of_node = of_node_get(np);
+
+	platform_device_set_of_node(pdev, np);
 
 	ret = pamu_domain_init();
 	if (ret)
@@ -985,12 +986,10 @@ static __init int fsl_pamu_init(void)
 		goto error_device_add;
 	}
 
+	of_node_put(np);
 	return 0;
 
 error_device_add:
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = NULL;
-
 	platform_device_put(pdev);
 
 error_device_alloc:

-- 
2.47.3


