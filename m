Return-Path: <netdev+bounces-305032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O32iMe6sS2ppYQEAu9opvQ
	(envelope-from <netdev+bounces-305032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C887113CA
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:26:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JGdIn+mS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QIbHbbqZ;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305032-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305032-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4A2F302736C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF641A778;
	Mon,  6 Jul 2026 13:20:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1E41612E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:20:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344047; cv=none; b=TV3TBt/FfSLUKa92Ic7/xYEHBuxfNyT7CQ9AmX8VP9oDl2AdbliqaADZEXY3EekyzAboHnBxahHfL7LlqJUHJQChyblZkMzcSKvcdiIMAIDfHw07/z6BsI66Z2DfLuVAXOvjkML2z2kPnFS+t9MRADaTroezM6rVZJ94rsBLXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344047; c=relaxed/simple;
	bh=r4nzs6Q+Vb/dz3RA3Qk8xYysKrUAYteRCb53IwmKpR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gLvnCkOdbkvYMSqu6rUGgArz5EcX2wB5gL0Wv4WvHSsQ8Attd22BAJ8H5yW3KNbbqHhKiVipj/EvE7WfjMLtZ59JjxGjNvqfWcQXjn7ipw/pXqeLILv15sWiJIA3aEoecBn961y9cbOqbdYle7rpkkFP5Y23ZheYL0o9HJr4Nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JGdIn+mS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QIbHbbqZ; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxPhf317026
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 13:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=S+/dKj/4QSkaC6Y1b0yb4O
	abzlICyIBStrbgJ+vgezg=; b=JGdIn+mSzwbuvFvd3FIrakLHr6yq9g3AK3u3t4
	dt5ddD9yRCYCF9fvCcetIJpc0+BbCncAkFqjHqJedvaabYzHnHWzhnafFUOPEYZJ
	l9JOi6zOiwdjZklD1fWP9n3QVrpSaVWOtq/DWZwGEmcDKM3fRriQAsRM66axz2Gg
	TqdD72zv7R+ApRwvcix0LJKjCQF3pNXNWYQ9o1XXJJVDTOYb74r5Gvp55l9HJxI8
	fSCRmc6iRWhM3f+halyEgjR6bTMRjs3tfZYyDtaGOaZdgo4bnqSLil3Omx+iVMeO
	YuMkcCqUC7+2DGmCoaMHWDfps1AMhD/Zhk3iprmmJr6+Sy8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7he29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 13:20:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e73fc29bfso434086785a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783344038; x=1783948838; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+/dKj/4QSkaC6Y1b0yb4OabzlICyIBStrbgJ+vgezg=;
        b=QIbHbbqZ0poQqUQALTAZSRZ3j2eAM9MUfsPS6P2ig/ZEEtosCk3RMPaRQLzltNDRB2
         GJ1OpTRy7tvXE64U4YJ59HDOXZJPPBCHCk1MgUrAs9BJ0jTbmxfQOBvpnyFZ39wVxZZQ
         zQn+5MzvNbbUV4CWmGM1LKqhebk6HujIV9QU4GTwg6AiMewma/0FChLrcxMM58iDefBr
         eQaEOJY6lMk0dvPLXJKLlXokZO/FFgd8D00w2ZCFt5Te87SUdbfL19sfJt7koh9jK6+j
         PFUMmZ3sgkLqaSUMOW2PHTFJye0Jo39rixJg/i/WKQBqq7Ch8JuUPEH5faEvHgXWvSq+
         J9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344038; x=1783948838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+/dKj/4QSkaC6Y1b0yb4OabzlICyIBStrbgJ+vgezg=;
        b=qcfJG7PD6P0bfZZQge6E4styxPBoROnkw65frWDwXXesbH8bBrMaHW+ACRWlT2ZT07
         WZNlCrBgPcglfPbXRoeA9EsM+qyrQ9k9NNAUmr7Cz09kj70ffOOORrUhanEsSy05XJMU
         ThxM4/q08tgtt8DrSA+wCYbGWn01s9n/TmciLOJJBEdwFg0nmO+Km5t836cXxe1TBVQi
         Q9M6GHtycKyLTalxGqjvP0KHCagKSn1Az6EtKRymFpyRNoLq+m3Ptcs+EvkEf0mqHXVi
         tmu5GBqF9230f3EJDJJovWnZNXe5Wf5Z680EO99BuLah9PAQLi4oLH8G28WDQ4vJM2f+
         JoNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqcw0r7Lr0ddDiz5/u4Yhj4cFCD9mv+q3KGioJicR48xAGNeapOaiKDGvFN/onxxRwbhNpB6iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboH55vr0V3GwcEzvdwv12gRQAPpgqZTedJlrZHE+85UdVjqIl
	rmcsKGKaxGDoENtajHNt7PM69ROOnQ9pOkdVW8mW+Xwp8NOt6JyE7JS7JAxm9J13Vij+cRQXMi1
	6Uh/O7/IpJ6nKaD8Hbs30R4yZGN6EYJCd5gNzWWqSgFqG+6+Jmg2es+YwLCc=
X-Gm-Gg: AfdE7ckZKU5A4ldCnlViRkGy1pFf0uQBqS1n4bC3Y/ZCXxz74SwP0/tHM3RrxjTIFim
	MF6YQngBFw5p5aCrgStX+XsX7R+ccntLV9yNLikqC5o9hRC35Jcpas/m8mrx9R2+6eA1fwKD/ht
	nyHy7zyPlTX2epababXUFVKjv0WlXzQGLPlt6Ip8SzjPCkAOzilJFUzv1MGdhoO8SgfyQHvwx4r
	N9wokYZPHggiv/Z6goXPJRyhwhm6BWv6g0wge2h38HfqT26pBqGCd1Td0fYY62gX+ffRnUhnkCx
	oMORPKJIOx+B1DjWdE2oSCYEnRWqTagU0TGFxAN24sYtKt/j3NzPmp/cHx9f3x4EdOE6a0TjufA
	lBUJ9bGggvgVYp3QuvBmWnpBIsNCEIScq2vyEOY5C
X-Received: by 2002:a05:620a:84c2:b0:92e:51ee:7944 with SMTP id af79cd13be357-92ebb55e04amr64070685a.34.1783344038201;
        Mon, 06 Jul 2026 06:20:38 -0700 (PDT)
X-Received: by 2002:a05:620a:84c2:b0:92e:51ee:7944 with SMTP id af79cd13be357-92ebb55e04amr64060785a.34.1783344037495;
        Mon, 06 Jul 2026 06:20:37 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm25910584f8f.37.2026.07.06.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:20:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH net-next v12 0/7] net: stmmac: qcom-ethqos: add support for
 SCMI power domains
Date: Mon, 06 Jul 2026 15:20:15 +0200
Message-Id: <20260706-qcom-sa8255p-emac-v12-0-e3ab1ecf2901@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCrS2oC/3XSwW7DIAwA0F+pOC+VbcDATv2PaQdIoI20Jm3SR
 Z2q/vtopK2RSi5IYHjY4JsY49DGUbxvbmKIUzu2fZcnSG8bUR98t49V2+QFQUAaDKjqXPfHavS
 WtD5V8ejryioGktrXGknkc6chpvY6ox+ii5eqi9eL+MyRQzte+uFnvm3COT67DqHgTlhBJckbV
 yeMzHb31XZ+6Lf9sJ+5Sf4TCGRKhMyE0YZNcCTBhxdCPQksVjepTCTDzADW1NG/EHpJFLPQmQB
 sZJTeJ2lfC+EnQehKBGdCWZMQLCnGuOvHcXv+9l9563Gbh8fLZ4ABkdYAy142KpBvrHwF5kzMX
 yYMErgEmQw1GQKU4FQwK5BdQIglyGZIWyIT8v8C2hXILaFiRi5DtbZOqmg4JVqBEBYSyWLHwaN
 fnAQKJK1HXqPwSTEVPwwf3YvBpOB00Jhcgbrf778j1CUzggMAAA==
X-Change-ID: 20250704-qcom-sa8255p-emac-8460235ac512
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Radu Rendec <rrendec@redhat.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6033;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=r4nzs6Q+Vb/dz3RA3Qk8xYysKrUAYteRCb53IwmKpR0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6uWhtNuvAg/7TbC2mCPqok9Ose0SbrE4DJGN
 YmzDZncOMmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakurlgAKCRAFnS7L/zaE
 w4uZD/492fkF9KRUF+LhghAa5/B6yl9bIZPy2zmr+NuB1+uJHaG8Hm7kMRTPkhlNyJSB/uNjOyJ
 3rx9WO2dctD2xiQZk2pvLGnQin3nhR8o8cdlI6jzfZU5Nty5YuxTWH+WSqDy8q4YHPLJkW5WrJ/
 cEg8EZ8ZXm91TLT5VPIbq6iUtnTH8sySH/S6i/SB7TOlIeHUkUd7ksKug0gi8UQkmTFR+dNjdUS
 hlMEDyDza6mI51NADNs779EiBIhvvCDTHiOufvj/I3R+f+aswn7ia8ZmBCt6fu8VNVS8VpiMc8O
 qtLik7F9rCndGqr15FPOyH52xLeub9y0ctVr0AA8S4jaKxSIQA3F7tp1jcoLdRLAOck6IOnLm6u
 nOGOFVyHF8GIacisPRWGV4C/tRFDWrkD3EjexAq7l9PfRjz55yyQ1R6w+h5v/syxebW4+llB1ET
 c2IzGDiX1vjnqUp772AHLsVpKfAlm7xlZQMfsCyDi0qwXa0Zs94ts7Mvrpz39Zns98kZSC2b6jm
 Alitu/+XYQnjlosxKtc7ZVaV89r0cMYnPF9lHDa+QOIF4s7cSiSQXFjbz10LFMsDgJWQUO1FSsw
 D/AHRgWBdv6SFHNx1NhhkX6Btid9yv9yzDw3OQraxBv4lnjW+ta7AYdKNXZKGbmmaC734+7tNNO
 xGyF3acpcNwjnag==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfXxXLfQQKZsSOc
 LwLmyZGX8VOEKQv/odmEq7VP0jQZQ1CE+UaUn33AeTJr34IxgYIMDQdj8VHvDBgShppx+qSNNIc
 nUEb4kQgNbh02SbbjQyykFewRs4rTqoPOqzepDkYSnOC6VXTp2HjvUh9JpqeL6QhLk3q8z8c52q
 mRLOVRhsjaVj7EedhiMQ5GhzjvW8tElC8AoUh/PDr0cL21uRd6pB/7+2E6MyD0WTApNTKo+WMPE
 uYTho4BxECNi5Obuo3vpKwkwo2XPDfaQ3R1DPTnTkefcRz8/Fbckea6trLhunxdvtkbcMgn3qXE
 gLnGXBb59/FIUd2+YlWn9E45361LKVcPYR9J9GHiWYU+U0JgkrqYx8ZHzXsjxIp41DyWr8DUxPG
 Zrfm6LcvhvuQNrmV5yDCJ7uGrv+hOgemqAd/dWw9X7/oNLrbSA8ZYT5cs6L4VZY2wGMTQCtuji5
 zykaYtI5T7yMCYYE5ew==
X-Proofpoint-ORIG-GUID: Bcb7iR7kFMUC0thp6yXFgmbnGu6l8eFT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX15RcUamrfziA
 PrPltWZzeTJuXf1OBQTWUmQTPhZkHGDlH1Mk5IMfMElSqZ8ZCXKX4Gdb6oY+mNefrElcQ4FXE77
 qEYA5u1Z2HVCX9dDBWB1dnXRDuxVqiY=
X-Proofpoint-GUID: Bcb7iR7kFMUC0thp6yXFgmbnGu6l8eFT
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4baba7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=PHq6YzTAAAAA:8
 a=h8s98YD0dNPsP74th3cA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,tenstorrent.com,lists.linux.dev,kernel.org,linaro.org,oss.qualcomm.com,googlemail.com,bp.renesas.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305032-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,st.com,linaro.org,baylibre.com,oss.nxp.com,nxp.com,oss.qualcomm.com,bootlin.com,glider.be];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:vkoul@kernel.org,m:peppe.cavallaro@st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:shawnguo@kernel.org,m:festevam@gmail.com,m:jan.petrous@oss.nxp.com,m:s32@nxp.com,m:mohd.anwar@oss.qualcomm.com,m:romain.gantois@bootlin.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mripard@kernel.org,m:christophe.roullier@foss.st.com,m:brgl@kernel.org,m:rrendec@redhat.com,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:dfustini@tenstorrent.com,m:linux-sunxi@lists.linu
 x.dev,m:linux-amlogic@lists.infradead.org,m:linux-mips@vger.kernel.org,m:imx@lists.linux.dev,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:martin.blumenstingl@googlemail.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:jernejskrabec@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66C887113CA

Add support for the firmware-managed variant of the DesignWare MAC on
the sa8255p platform. This series contains new DT bindings and driver
changes required to support the MAC in the STMMAC driver.

It also reorganizes the ethqos code quite a bit to make the introduction
of power domains into the driver a bit easier on the eye.

The DTS changes will go in separately.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v12:
- Drop the power-domain-names from the SGMII PHY DT bindings
- Add missing Kconfig dependency on PM for the new SGMII PHY driver
- Link to v11: https://patch.msgid.link/20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com

Changes in v11:
- Take a new approach: add a dedicated driver for the firmware-managed
  SGMII PHY and simplify changes made to the MAC driver
- Link to v10: https://patch.msgid.link/20260323-qcom-sa8255p-emac-v10-0-79302b238a16@oss.qualcomm.com

Changes in v10:
- Fix unit address in DT example
- Link to v9: https://patch.msgid.link/20260316-qcom-sa8255p-emac-v9-0-c58934e76ff2@oss.qualcomm.com

Changes in v9:
- Rebase on top of current linux-next again
- Link to v8: https://patch.msgid.link/20260311-qcom-sa8255p-emac-v8-0-58227bcf1018@oss.qualcomm.com

Changes in v8:
- Rebase on top of recent changes in linux-next which required an
  extensive rework
- Drop partial R-b tags
- Link to v7: https://patch.msgid.link/20260306-qcom-sa8255p-emac-v7-0-d6a3013094b7@oss.qualcomm.com

Changes in v7:
- Restored the correct authorship after learning git uses .mailmap for
  the --author switch
- Rebased on top of changes from Russell
- Fixed resource management issues in error paths
- Link to v6: https://lore.kernel.org/r/20260112-qcom-sa8255p-emac-v6-0-86a3d4b2ad83@oss.qualcomm.com

Changes in v6:
- Fix $id value in the bindings
- Drop patch 3/8 from the series
- Update init/exit callback signatures
- Link to v5: https://lore.kernel.org/r/20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org
- Link to v6: https://lore.kernel.org/r/20251219-qcom-sa8255p-emac-v6-0-487f1082461e@oss.qualcomm.com

Changes in v5:
- Name the DT binding document after the new compatbile
- Add missing space
- Make the power-domains limits stricter
- Link to v4: https://lore.kernel.org/r/20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org

Changes in v4:
- Remove the phys property from the SCMI bindings
- Mark the power-domain-names property as required
- Set maxItems for power-domains to 1 for all existing bindings to
  maintain the current requirements after modifying the value in the
  top-level document
- Link to v3: https://lore.kernel.org/r/20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org

Changes in v3:
- Drop 'power' and 'perf' prefixes from power domain names
- Rebase on top of Russell's changes to dwmac
- Rebase on top of even more changes from Russell that are not yet
  in next (E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk)
- Link to v2: https://lore.kernel.org/all/20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org/

Changes in v2:
- Fix the power-domains property in DT bindings
- Rework the DT bindings example
- Drop the DTS patch, it will go upstream separately
- Link to v1: https://lore.kernel.org/r/20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org

---
Bartosz Golaszewski (7):
      dt-bindings: phy: document the serdes PHY on sa8255p
      phy: qcom: add the SGMII SerDes PHY driver for SCMI systems
      dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
      net: stmmac: qcom-ethqos: set serdes mode before powerup
      net: stmmac: qcom-ethqos: reuse the address of ethqos_emac_driver_data
      net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function
      net: stmmac: qcom-ethqos: add support for sa8255p

 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |   3 +
 .../bindings/net/altr,socfpga-stmmac.yaml          |   3 +
 .../bindings/net/amlogic,meson-dwmac.yaml          |   3 +
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |   3 +
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   3 +
 .../bindings/net/loongson,ls1b-gmac.yaml           |   3 +
 .../bindings/net/loongson,ls1c-emac.yaml           |   3 +
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   3 +
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.yaml |   3 +
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |   3 +
 .../devicetree/bindings/net/qcom,ethqos.yaml       |   3 +
 .../bindings/net/qcom,sa8255p-ethqos.yaml          | 107 ++++++++++
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |   3 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |   3 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |   3 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   5 +-
 .../bindings/net/sophgo,cv1800b-dwmac.yaml         |   3 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |   3 +
 .../bindings/net/starfive,jh7110-dwmac.yaml        |   3 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   3 +
 .../devicetree/bindings/net/tesla,fsd-ethqos.yaml  |   3 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |   3 +
 .../bindings/net/toshiba,visconti-dwmac.yaml       |   3 +
 .../bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml |  50 +++++
 MAINTAINERS                                        |   1 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 230 ++++++++++++++++-----
 drivers/phy/qualcomm/Kconfig                       |  11 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c     | 161 +++++++++++++++
 29 files changed, 573 insertions(+), 56 deletions(-)
---
base-commit: ca70e9a43a66435fda3a9d37f90c9c3b7bf211f6
change-id: 20250704-qcom-sa8255p-emac-8460235ac512

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


