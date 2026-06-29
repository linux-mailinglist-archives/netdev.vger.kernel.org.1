Return-Path: <netdev+bounces-302536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gMfqJJ85QmrO2AkAu9opvQ
	(envelope-from <netdev+bounces-302536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:23:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0606D81B6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:23:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ILn3fVqP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=h1QOO5RU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302536-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302536-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC5C0304AC02
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDAE406813;
	Mon, 29 Jun 2026 09:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E23FC5A4
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724432; cv=none; b=YIA7H7orRIYTSri9pBwwzZzBd3DXjLVOBbgVqFOES7RKW+4RJG+tVkV2UgI26aewrJn34qOlQBelaOgGHThkvjCJg3/sJcRgwoZfRWiLLNwkC7Fb4ecm6KrXqAP9/5tkuknMI5GcQKJfiG+yIB3DYgcu83JWQWrB4LFU/RWlMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724432; c=relaxed/simple;
	bh=Gc7zjQ8K3UGxrQUEA3l/ojyEpHz6CDAO+1N6mZySJcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2k30rR7yrlLn+GHe8Fhw96C2u0GydGYJhhD2BlAqlUv38BnazHcYO0hJyqLztnZMHA2g0DINQ1b++Yn5PloCvHXwB2OaIz925DMoyP3ocnKlN/RAMCRscW38UN+5+m660gapkF4KxoodPDpABff+z0ArMSbe1EA40BxwnlfZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILn3fVqP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h1QOO5RU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8O96U2348342
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WnFQ8s5FzTKwx99wZfiqcLQumGzbQMJ1Gb38TtDDzAY=; b=ILn3fVqPEftBrxbf
	hbNT1B+TKhtWUm4n09Np/mVZdX52QNbGzOkOo+0eCuwdMafnDDhXzksj3f78cul0
	/JY36CRdvCq7DG8+9RI4dY9xyaa0bHXKzOgr+J+EDeDNDbDeGF7ma1rd/EAdl1GD
	OGT7STFj1i6QUYlMe/S3UwMCCFfDRYDPAp9cAOjeTL2/eOng6YUxiYoz3Nj7nZWT
	FPeA7LGVmWsvDV9iwwmLYsN/JCob39gjGui/sLO/5Z7qsiYyIwcjcuDvF1IFzOOH
	DQSH2TmfU1TTjGR7LTzqSp2gGB2K6W+8y1hBWlI7lZl1knIzdIH6EN3AVKScHjPm
	JpOLIA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s07g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e55721a8cso63988585a.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724428; x=1783329228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnFQ8s5FzTKwx99wZfiqcLQumGzbQMJ1Gb38TtDDzAY=;
        b=h1QOO5RU5AcJzNXZV4cbToa7d0wq62PG0PNb5jAvq+Zm55AwUHjGxtppDZok6wHcyK
         hugkBLbx4PVAm/a1HCwm9q4W0bsJi4ynZEFzuMe8wuzjw2rZS92aSd7vFoor50hkE2E2
         YSupMGYZb4fXYezR0B6OLA8XBiXmuAd1Fp0ezOtd2Jnic5MpNvdYyyuLokqLE8Ozrbg8
         OqPo0+rR39hoxQohlAqohhnWuDBEb9eYFXfcbvHNQfFp+eJcMC1n8yIWImEaOWqxdGA/
         vyWDIgOdrb4XeHwpJ+gUC2YhHiO6LtoOtmL6u3PcWoyLOm+zHOuv1ubKxD91Nrdwkpgi
         3C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724428; x=1783329228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WnFQ8s5FzTKwx99wZfiqcLQumGzbQMJ1Gb38TtDDzAY=;
        b=nOoQB4dOCQabRLoGrxfjyKrsE1UiXqTFNS4f0MuTgnDo/1fbt9xkryFyUy0We5xAnp
         TDE7OpWcXJthTCTzeJGE61MaTrcFOqCj4ff51H05L4NT+Owg3DLCQJR125AgpcHmdY/F
         WvpJbrLCchZ10A/Aos/F5oQ83Zw1LU37axHIKck208S4y+/7ZXpSCJe7jXO/MvgB0x8m
         niQC5z6ehg1NOmCF10QUqJ/2S8cYk6Pxb9aZ632u9q9DULwTFkCloQTkXCtkDU/O632Q
         vpZVMyHR1LR9RfM5lehE7s78EHoiXLlaFsSoHV1p8Nj1KBkF84tKcN07JFQ0pDWMeiRW
         E3Cw==
X-Forwarded-Encrypted: i=1; AFNElJ8XDgQgCKdzge3eWQaGNfssIVNj7538bdAeg/ZOvqEixl45ABtV2aHtxX7XaCyZiRXO0Bunq9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFNxH3NY4dTrKjKeyD/zaZcETAPnUPo1Uouccu7qo01lfpuIth
	Qb5MkBiL7hVv5gbuyeZ8F9l+zZBy40+USNMgtAAKKhuhOVhFXD5idqfUXeL7rCI6UkdHfJh5JC+
	iOuUcoZeHqnDxQ1/x+CxgwpvAEp5mJlM6xJtB4s5ytjBDorZFJRA73Mw47fs=
X-Gm-Gg: AfdE7cnNlqOy+6BMqtTYw/cle6WOWjs3OoU3hZ/ZD/i5q3QhF9ZSpdgVUdUBQsciJrI
	l5v9dho0Aaf5NdL6ERclnmtveYH7ylxd4Vj+Q/mBAlkN7m1GC54nVOjk9wZ5rpYHKns2HH70LCi
	J0dzz1SR3uPY/DETQK0loe2tGqHMJZWzFOQ9WYP1mP+P88LoXdy8gllikLOX7GDHPm0KDLquKE5
	9+YEQq1FvExxk5f25vZc6TWCvMN4ob39wOJ4dCrb4+n+kb7bhxELhuUOSYmlu8bnfqxmDggDGU/
	H3zebmUjN0t2jc+5ORYRDq8hG5YeeBDCETWfNQ+xgL7mTUeArm+ECnNQBjW8oJPgrRUem2RePuC
	7wuy7ShcT0NmeT829GvXs8Z2O0lqPbI6fjnHOpl97
X-Received: by 2002:a05:620a:4706:b0:92b:e0de:f193 with SMTP id af79cd13be357-92be0def3bemr1192764285a.67.1782724428171;
        Mon, 29 Jun 2026 02:13:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4706:b0:92b:e0de:f193 with SMTP id af79cd13be357-92be0def3bemr1192756185a.67.1782724427424;
        Mon, 29 Jun 2026 02:13:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:39 +0200
Subject: [PATCH v2 16/19] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-16-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gc7zjQ8K3UGxrQUEA3l/ojyEpHz6CDAO+1N6mZySJcQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcUYFPkmtYlqYBD6pOfruG0HB4agBQdjermW
 D2CaNY48aGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FAAKCRAFnS7L/zaE
 w/FjD/0eAzv7lZsLEu+8uN0Gf3x0hmYmNZU+OfT/4weEInEM7TeSQbiN3pgMmvlj80CdY5Q1REQ
 Ex6iSujlHMMD9tcNl3V1BIGs++Pz9dpmj9n+5Fo6INo9YQJfeP3ZfbkkBda+3M0CX+RGmcKChG8
 npDT3s5jcIu0Be9TRlphsuhpjCXJsDBvuxhc7eqwWardj4eSth/HNLkbKfY+ju7Y4qsoHepyAeA
 p5m2K9399ZE5HTJlwCOfwYlVlQo4sJnEl0Afhqsr7b7DkrqCZrOpi6NGsFj6JDD9aokHMeUDntu
 c/1zSjRLx2hKPgU5Q96bRQysWGped1vtY1grnPhifgdnp/jvqRcbEXVYhxZPj5FACP8Gr1ReNWv
 BpTxLfHoW/M79AyNPhdGX+jVcNrzPaGm5sVhrOGIPEpAo42H+MVA3DDdBup4FrH+i3sUIEPEYps
 GV0P5A9CKpLx5K3dIcWMsBn9ZrBorNi/XqU3JgfGBbpcv9xeJvBGCy38l/PMAS4/9u9zgVTV//y
 yQGP8iFBOxoQxugRDNREkWEdHcUi+LdcjWnXvBgZnXMSiqiK1AwLZjKp8YOnvUwQkbEcuCaAePv
 C4sElo1miGCgWPCtW3XInxjubqn+p2OX/c89FWORM3XSJYRsDCJH3OXSvb1aktZuC3a6q7x0S2z
 I06GT6zphKjJr7A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX67U78b2H9SWz
 +0sGq7x22w3n5LuyGoJVjy66DVlk2drwsao744+jaxczOJlwEhd+7RDmmE1FLSQ1xEiironZFKI
 vWTGthwygy2jNETWtzMn5gFc0fVawYg=
X-Proofpoint-ORIG-GUID: bZTnm6GfGnPQqLv_WljOHrvNo7mTEDxn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX0XTpMrqbmZer
 7QT198kpUttB+D1oTCNCPin62KcaNNp3hTGAATnaL5INJozXL352TZH2E4DZODgubOCM5iDnbDJ
 0DE1sdZ1iH5L96i8F9su3+2weMH5mjQzNgPgwid0szRKGuJpk44TxNh0NNg540e51sP6lHPPuID
 q99LuBWkiVu9G5kT5l6D3/r12E3DJ1aeVy0SQiBJxMDiXMFTiN/qWHI9bRN2yewobDo37zMNXoG
 kB8ZwHrmSGQbMOFz4+WFkzAAYXpZMb3Ye9s007VhmV+RKxYFwlU6+qLFhbX1l6mjRSs3Bh+EYYX
 epZ5Qs1Ek5he9gtx4hRkxOJaNmXWuhjJlLSbtILr62+BAQnKMbcdkPqUdoiQBRYQRlI4kffO+iq
 nts8dGaOgS6zq8uhrgSrXRgxIsVV6tRhbc6es5ZQuy1/U3I+7f+WhXjWSJSNJ8xxoHduo/osiga
 dGp86uvmgyRPbX6wmPA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42374d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: bZTnm6GfGnPQqLv_WljOHrvNo7mTEDxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302536-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:broonie@opensource.wolfsonmicro.com,m:thierry.reding@avionic-design.de,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:vkoul@kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:robh@kernel.org,m:saravanak@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:andi.shyti@kernel.org,m:andriy.shevchenko@linux.intel.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:ulfh@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:peter.chen@kernel.org,m:paul@crapouillou.net,m:b-liu@ti.com,m:p.zabel
 @pengutronix.de,m:luzmaximilian@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:krzk@kernel.org,m:benh@kernel.crashing.org,m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-sound@vger.kernel.org,m:driver-core@lists.linux.dev,m:devicetree@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-i2c@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pm@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:linux-mips@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[66];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D0606D81B6

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 07563be0013f4d28ed6318a0751670ccef01d0a5..7edc512cc37dc24551efe5fca172777a0a4b0766 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -879,7 +879,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3


