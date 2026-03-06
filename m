Return-Path: <netdev+bounces-264859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JFaJx74qmlxZAEAu9opvQ
	(envelope-from <netdev+bounces-264859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3A224424
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B5FF305E47C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFEF3ECBE8;
	Fri,  6 Mar 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UTTNVO4C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EPVEa0av"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722373E9F76
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812043; cv=none; b=Qmc/XuqgFjicXE5RKDvcjtzjuzhG2fEIi1AhJiovqPuD7/994ihI6YQ8EuHouEmRUD5jN+GIh/ezQNjDMZxFaSOhS18kLp2BcOthL2QYEQ2z5TokLyaV3YJYKpd5kPvamgG607MI/lKUuOH2nTAaUiTlp+91IHYbuI6UQTZf214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812043; c=relaxed/simple;
	bh=3uOuOeJbdrcS+lJ7aDmnJN+i6CRN23XQXoVBHlpPKpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrPzYqMSCFw3eWnb1ctv6KlxqBhttRLUxoTKvDGpxJTgwZRFIqiIS/B7ht9VX2B7IeZ3c1JSz+ODBuDmVRJy+24z/VUucskLQ2pR/HJlvTr7/FHI2aBcO4scVel0S/crKOdicEvCbZEPnX1Wl79Fqn6m7R15XJLHYTLMtXJNqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UTTNVO4C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EPVEa0av; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FSvTG1369184
	for <netdev@vger.kernel.org>; Fri, 6 Mar 2026 15:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XmLtfnfEU442apLkQZEiJc7Yi7ztievqViAzTb+cZV8=; b=UTTNVO4CaNDJi/JS
	L878uYw4+Pjqakz504j6ghi3XiYjIPgE0YiL7yGzPZUtduxaUoBVJSQOVjfW2Fn4
	Ete0Hww61VIDr5A2UKQkagbqClJowXCX8bzidyoBs7IQQXPg0y+2IVWI5ctvHTla
	zDdYcQkd8G7YrFUCNj4/tbI+MwCZ+ClxYHW/kk6njvmJCcwHbopBTVAYXWlR7LhW
	n5FoCib5dK4p2WxTI0XmVWC+3TW9nMYxT/VgDaKxRXl5iokQBn/4e1Fau4o0Yu+3
	HKLHPKIKoVuZ2RD+NNNUCbHD1b6x6siXLDgdbFDlKusf9M/gaNZ/0F5VCwjacKS3
	5JDvzA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5t1as-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:47:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ed6c849so1984071885a.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772812037; x=1773416837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmLtfnfEU442apLkQZEiJc7Yi7ztievqViAzTb+cZV8=;
        b=EPVEa0avCm4wxn7BlGevgbrPP3AR8EjKKEwthg9UdaEABWi71cU6XZ8kzUoH8iWXp3
         KsTjbLerB8nQgh8bvH/FbsMWgXRNSZRrc/FCC6t+1WWl0XWLCMvUHfgwbttE2wIagUeO
         cxdMxQL00R51JV5N3EP/aqrG774muN5DgZaAZhBrLKV4ECPkGzNMhl9uGv/mKPuK+Rlz
         6T3l23mLBt0SPGQe9P2TibbdqGs6Zd1L70jSlcZRIFRzPOaMFiyZNx+Ztlk/vUoXgAPE
         i0QZ6iT+loAJeHmdEX5G/chHAtEk8HwSzTuQqlapQiQlwbLE52rZPa6LV0vcGnx9TjOj
         9NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812037; x=1773416837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XmLtfnfEU442apLkQZEiJc7Yi7ztievqViAzTb+cZV8=;
        b=v9NW/V00Fu4eShNB6I/Ba/FBx59RplFDdHK/mrk2fqAE3CVbj2NZsq6/JhoTvIn5kN
         xkkitHriG8j50zePSXlYdzPF+qFigMdMAeu7hgWB6re/tX0O8LiNOizzFHLXDKJ9ss8i
         l4dfCNprq0LZKw9Nndbjwksxoes4bKmtFobzKgHZsFFmdsUGxXI5DlBkJ6t5aZ5MHSAp
         USXVy7hsGQA3AwML89HmWVwNLL57Wzh4AIz9gpAjga1heTIMgxGqyXr94Lo5HJBZxmz1
         iZSLUtAd680cgI+NgQRnLr8AK7OdxAk8yXQDca73IXp5tysk33XkUCT4+jJe99CHkskK
         RZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKC237xcjx79W9q/q7f8vcVakBp68BjNtorfERohwyH0Kg6eveGQTlkpQMKqUhMJQh9KUj+50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzumoHnNg5i6SByultHbkuW2jdIU2ox2i1qt7skQ/w0EzmWiuHN
	+y+2ZU4sKVjrHZy37DvX0XX7C4Gj8Q9c94uZ6rPM4VjBXzFFeTS5p1EjBfkoI9BYSNAD4gX98N/
	OdhZKKiPtZtTB438fnGhBtoCyXc7tDuXYKxwdwjtz+wVPSWRBGa/PKP9AFcQ=
X-Gm-Gg: ATEYQzwQlzU8E81K68fPI3mMhZxtuJ5xPRkpNznk7dQPOA/3+eGuE6L8pHGak5aEZVf
	qbCY1eCdXu07ItltGf4quIfmpMp/bm0TXMiZ/v9R4fKGGthnp0xtJOulHdJ8v/2Mw5ca2naQudI
	uSkIA3yfvMYALNIPaAeqFqN9cGqZoC9ILgjDkYnTpulON8gH6wrjrGYou6693NCGRI12W45hePh
	vUGYfhlKqy1CywghK9mKiRtlGsueZtDDHj8y1Aqlb+r0yxMf1BRe00xPPdv3v/nvy0Hm22wJJjd
	ghjjcZTA638K1eIfiRfv4CaM7BE7MU/acrnBL7DU5NnjY/S6+jGA9KrhGyz/qVvoeMaC1Of7Tm/
	lvDw75kAsHn65nOuPuSm1EfRuUZWJg1uvQxb7r7jxzAY9ZCngm1uK
X-Received: by 2002:a05:620a:1a9d:b0:8c6:ff02:d825 with SMTP id af79cd13be357-8cd6d4419a6mr323521885a.48.1772812036908;
        Fri, 06 Mar 2026 07:47:16 -0800 (PST)
X-Received: by 2002:a05:620a:1a9d:b0:8c6:ff02:d825 with SMTP id af79cd13be357-8cd6d4419a6mr323514485a.48.1772812036228;
        Fri, 06 Mar 2026 07:47:16 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6d2b:ebde:c946:11eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae35cf7sm5122767f8f.26.2026.03.06.07.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 07:47:15 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 16:46:41 +0100
Subject: [PATCH net-next v7 3/7] net: stmmac: qcom-ethqos: wrap emac driver
 data in additional structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-qcom-sa8255p-emac-v7-3-d6a3013094b7@oss.qualcomm.com>
References: <20260306-qcom-sa8255p-emac-v7-0-d6a3013094b7@oss.qualcomm.com>
In-Reply-To: <20260306-qcom-sa8255p-emac-v7-0-d6a3013094b7@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Minda Chen <minda.chen@starfivetech.com>,
        Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shuang Liang <liangshuang@eswincomputing.com>,
        Zhi Li <lizhi2@eswincomputing.com>,
        Shangjuan Wei <weishangjuan@eswincomputing.com>,
        "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Swathi K S <swathi.ks@samsung.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5789;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wjuY+nOeBuf7mJQjJak4IPNUsbeUnM9wcneFMYKnYnc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqvbs0hciUhqJotPp9cNlrSb8egHKq2Du+9zv6
 7JyZbENsVOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaar27AAKCRAFnS7L/zaE
 w9OND/9OfvQ3mT6kO2oe78LPFKJXd1gPD9CBX9zYbKWOqGtvyZhcFn5M9wNuCCwZKf4/muZb5LM
 6XrndpRCIqmfqjVkKKzaJd1b7hQ4ndEzuwUuUTajxWki+r2VmRiiWfmoAcDH2ddy2ZyPEaHHmlH
 z3OXaI8elMDsUivSMJ7mbD0sedazpwANeUQsodb1uiY7CJ3LKfMRfYqBbofivgrKDWMRBX7or/J
 hKlBzx/BCt2uxb/qC+wxcjB9iWlq8bo3mFxONcWS0gM2DcfrNJlo8QvaQixQ019WvW+OMJKC+i/
 BMtRKsHA0Zwq3JbRNurH4bl7yHh1hJ8rSunrcZOiIjLCmV3qLv3E3S+JJJF2tBR2ECaaS3VaWS8
 o0cR8ag8AJRjBex4YrD9XYT2BItD7mx6ZYDn0iHhaln0cs8BrJkfm6Lkh9/MxtnZkDgLJfKuzZ+
 YiIAVABIZq8WhFD/pero9PYeqXKpD5+9MLk/eu3WLm8aqfWSLkHmNJocpRJNN9Zx3jT2f1gtSGd
 1zaeNRNiE+Hx4drnVD6LIu7g073v8zNCeJErJlW7pGvhHlisQI9A+IESfzH8aFEjOTmGPLNWl+1
 noOxzcb1BV+olTlJV0PiVuVQq+T5Y6WEplqqhJgNBO1UjGn6a7eKHrc5HlQpFUCzantNeV3pICx
 U/m/FhecQPQ5R5g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 8jhjxKUlBMSPgqD-W8wD-j1nxS8QWayE
X-Proofpoint-GUID: 8jhjxKUlBMSPgqD-W8wD-j1nxS8QWayE
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69aaf706 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=fYgtqwV50X64hY7jBhMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NiBTYWx0ZWRfXxJhXmJMXKuu7
 MVI8smVQaPx6UALPB2+pR/+6snbyBPJydmP99TCWuSJZsdeGYxy48fhAlWjD2T7jx5WNJ/kDXAv
 NVOQIFiQvISU5jdT+k/nUD2CcX9BsTtdEOPYo59Y87Rl275aCkNCV0frVFI6kga8BEJowEvvPEP
 Exptyt5TSKHp/aSpzoV36kwJfFZxAZKOOV0jXM4UIxB7BUq1MvovYwDCPkOq+3Vljq4Mi+h6M2k
 LuLI3DM9Ayygo9evyuP+wbF0t5Fg5Oy/6THLXl7j8P0IVQWygFh+xUmctdwMGH6uPqr/THm/JZf
 GAv6Q5xhimk5BLiyx5afrTbWFREIWod/Kx7AozmxcuUkIn2mCK35Swt1DkRudT+0Bd0aOntyqAE
 AQbncfxoN9jm66H6rT3iyEFhEIgBDht8Kail/cwLya062DHyf4Emo9ZqLag7smI6uPDCxYq4LFf
 WOcjdbMPXUmRq3fMgPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060146
X-Rspamd-Queue-Id: E5E3A224424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,st.com,synopsys.com,sholland.org,altera.com,linaro.org,baylibre.com,googlemail.com,pengutronix.de,oss.nxp.com,nxp.com,bootlin.com,bp.renesas.com,sntech.de,outlook.com,esmil.dk,starfivetech.com,mail.toshiba,glider.be,eswincomputing.com,intel.com,rock-chips.com,samsung.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264859-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[77];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in enabling power domain support in the driver, we'll
split the device match data and runtime data structures into their
general and power-management-specific parts. To allow that: first wrap
the emac driver data in another layer which will later be expanded.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 51 ++++++++++++++++------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 219ea36fe01e6d41299649defe569de034859288..ae7e088b122753fefa24fd2ca715151fd56e6376 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -97,6 +97,10 @@ struct ethqos_emac_driver_data {
 	bool needs_sgmii_loopback;
 };
 
+struct ethqos_emac_match_data {
+	const struct ethqos_emac_driver_data *drv_data;
+};
+
 struct qcom_ethqos {
 	struct platform_device *pdev;
 	void __iomem *rgmii_base;
@@ -224,6 +228,10 @@ static const struct ethqos_emac_driver_data emac_v2_3_0_data = {
 	.has_emac_ge_3 = false,
 };
 
+static const struct ethqos_emac_match_data emac_qcs404_data = {
+	.drv_data = &emac_v2_3_0_data,
+};
+
 static const struct ethqos_emac_por emac_v2_1_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40C01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642C },
@@ -240,6 +248,10 @@ static const struct ethqos_emac_driver_data emac_v2_1_0_data = {
 	.has_emac_ge_3 = false,
 };
 
+static const struct ethqos_emac_match_data emac_sm8150_data = {
+	.drv_data = &emac_v2_1_0_data,
+};
+
 static const struct ethqos_emac_por emac_v3_0_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
@@ -272,6 +284,10 @@ static const struct ethqos_emac_driver_data emac_v3_0_0_data = {
 	},
 };
 
+static const struct ethqos_emac_match_data emac_sc8280xp_data = {
+	.drv_data = &emac_v3_0_0_data,
+};
+
 static const struct ethqos_emac_por emac_v4_0_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
@@ -307,6 +323,10 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	},
 };
 
+static const struct ethqos_emac_match_data emac_sa8775p_data = {
+	.drv_data = &emac_v4_0_0_data,
+};
+
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 {
 	struct device *dev = &ethqos->pdev->dev;
@@ -730,7 +750,8 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
-	const struct ethqos_emac_driver_data *data;
+	const struct ethqos_emac_driver_data *drv_data;
+	const struct ethqos_emac_match_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
@@ -779,13 +800,15 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 				     "Failed to map rgmii resource\n");
 
 	data = device_get_match_data(dev);
-	ethqos->por = data->por;
-	ethqos->num_por = data->num_por;
-	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
-	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
-	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
+	drv_data = data->drv_data;
+
+	ethqos->por = drv_data->por;
+	ethqos->num_por = drv_data->num_por;
+	ethqos->rgmii_config_loopback_en = drv_data->rgmii_config_loopback_en;
+	ethqos->has_emac_ge_3 = drv_data->has_emac_ge_3;
+	ethqos->needs_sgmii_loopback = drv_data->needs_sgmii_loopback;
 
-	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
+	ethqos->link_clk = devm_clk_get(dev, drv_data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
 		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
 				     "Failed to get link_clk\n");
@@ -813,14 +836,14 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
 	plat_dat->core_type = DWMAC_CORE_GMAC4;
 	if (ethqos->has_emac_ge_3)
-		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
+		plat_dat->dwmac4_addrs = &drv_data->dwmac4_addrs;
 	plat_dat->pmt = 1;
 	if (device_property_present(dev, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	if (device_is_compatible(dev, "qcom,qcs404-ethqos"))
 		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
-	if (data->dma_addr_width)
-		plat_dat->host_dma_width = data->dma_addr_width;
+	if (drv_data->dma_addr_width)
+		plat_dat->host_dma_width = drv_data->dma_addr_width;
 
 	if (ethqos->serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
@@ -835,10 +858,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
-	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
-	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
-	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
-	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
+	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_qcs404_data},
+	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_sa8775p_data},
+	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_sc8280xp_data},
+	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_sm8150_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_ethqos_match);

-- 
2.47.3


