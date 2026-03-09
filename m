Return-Path: <netdev+bounces-265447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKtiGhiYrmmBGgIAu9opvQ
	(envelope-from <netdev+bounces-265447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:51:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E72368B8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 502793004C3D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53B37A4AA;
	Mon,  9 Mar 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lhq0/5i+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L97SyvNf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3F37B03C
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049803; cv=none; b=BalyCSv3uptqGi+jSp3TSETlRI+D7QcQUJgEnfLKdoX3CXK1e9zGonYNt3hA42gO985w3SpJCz8lCR9ZVLGGLDiO/GzSy4fUervRsea9XxDfy6//ZaR66xi4N74Mylu8tpirn9y9sGXWp+7fzVr9/7R8w1Ep9RHkK1kzZLgCmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049803; c=relaxed/simple;
	bh=uOtCARhSePA3YS0iVPprhrCJJMKvZLLOo9ES2BD8tNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWSnK6g2N8Igq1g7P8TlSbw0stJHimD5qwfk+LqWmWWsv6WrllMKWOktjU1grNEGpHYMo9qCQpMQk7+vkuvWF1ReIVOj0xZ6KtPWJIlCzsRylqWuNLpTZ+S/lyNVwhvgAG2uC5FgJp6MIp9+9vXjnE6l6hA4MmLkC1xeoX7FPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lhq0/5i+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L97SyvNf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6294fDxN1588111
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 09:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZY1KMDG5mEhmybM9QUi64JQp3OjXLAuIqQxIS+L8bEE=; b=lhq0/5i+W9qNegQH
	4iZ2TDv+OYhkmoRgfhmxvPmWSlkpXEIuh5MZQgwo4AM3Ynv3hoJj/umUgQuspVVD
	tJNZB5kVcAKcswPNFCXiLK/XNzXJ6OQ01jnzIGffo+5jm0FuBezCFMl7vQ1REBci
	vtUsoJox3RcSzTnlFKMvPzBjnQX0elu+qzW3D0n+D/pjoeym9h1ZpLfUHM2r4mIc
	RgFO1UtlTnMC8hAPCyX8DNvS3m9eHukz0wUSD1RjkW6kWOUoS2dFLAPpsgq0xU9O
	biw8oZyeI+PGjkxkYiVbuyegRStV5PXmlXJIL/f7rskHcht0q+m+s4i4TrCa+wfe
	fPZ+4w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcy903u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 09:50:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81be6f05so720625185a.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773049800; x=1773654600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY1KMDG5mEhmybM9QUi64JQp3OjXLAuIqQxIS+L8bEE=;
        b=L97SyvNfNZSYCAOoPG71q1XgalNtDwOcogrnNDU22psWfsfLw6oD/zea3v5p6879MS
         aOaLxYtH8avfH1RU0K/04ILedDoMod+0ixNj3RgE3JQchayRgmfH5dZckB1IedO10TRa
         JCMhve807eX5lJirUsY4g5MFIPSjP0//c0WBSqKACwoDM1dZoFwLdYoJkILmvK9HnfRQ
         f4a2U5vFK/2yrLBXnnQD3Rzl+BvBqISsmT/gxhcX7lQtWyXZ/VQVPMrHuaYII0QejhDf
         LOXMjyOy2lsWhh2Q7GTaV16nS+IEzNAK+XcYr/02NZ4uRSXBebpkR8Ck9TNw3kRyIWWO
         ZQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773049800; x=1773654600;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY1KMDG5mEhmybM9QUi64JQp3OjXLAuIqQxIS+L8bEE=;
        b=QNArH2DDNcYOQisfYhKgPQmdsK+pQvTJLlHaO0p09OxKKJOLPsfZKojRZeWd4//EZ2
         +aMGupLcObgDCY/jvQb/TqtwoByhjtdmR7KZ7OgmXuV88aBTajnhpZt4q+cRbYrc9rtj
         /puXjys2Y2qcHUVM7xa0539jMYrQWgH5sTeRGmuBKtk80lHV5OE15ACpXGUkjrLt/2T4
         ZN3CJcMXJzEIx3d0kV8EXKAi5qAYWIGnVwu3uAz2E5pEvpRyLr0OnGoHHQcbSVwTZpx1
         E36wK5aUlbyZVjx42lTd+FODzSekuyQqvZX6jj8IOu6Z19gBcrD42DXV2N33ngfosgje
         TR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/tf1KERfsA4ivevxtRN0zl5gw+pw3akoUZe+9l5AEL/cMopCruHqqN9HVK38v0s7SNs9Sso=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVTzuhTbVeFZR8JB2Zs2PxvcktYpuClZywDL0toTIK90ze+i1
	e3zTMpkzOfqkV1wb6vev6HRkDDAtDhIDl4lIt90psbyw7ngoqeXeqmwZyiSGmqv/wFwFsSQaduJ
	ESkKK8SIHtBi7weE/R7445Bbghp9BnG/MJs8oFjs6JZMKIHsEMHR7cl/885Q=
X-Gm-Gg: ATEYQzzTRae0L2KLD73htqlbHewxmUPH6Bg6EVcG0GPZM7MPkaTEoHUmYwx9zUIngH8
	OzdRArkogJ4nQeeCA4aCAlsW1HL4ZRxnlwHDXEPrNEKjK6dkIeUGjBvW22JQIL+i+2PnE7guvcW
	1BODrNFYcBmdCPtzbtUK9Nz645BdQr2v8LBKrFQ+XC7sy1ItCebqFndUwS4nI/PYnxws3jlCJn0
	NKQMKeZQWzOBJlYSRbPnW13Qjexcwhb51sNMGqZAZdcK1Ujy3DjWSn4kAHTAGy0EyOjPzQzUsDU
	yBFqIn+XEHh1yTIp96cwrIHM+DAnwIvUHpIWu/KWormt5Ks41djtJ5jkE0qerpSpGdcQU85P2cF
	rx50l9QlS1xz9gddqSMBJi+Vyjpj33Yeqg8mgRaV4JlI8tf/X
X-Received: by 2002:a05:620a:470d:b0:8ca:d5cb:6841 with SMTP id af79cd13be357-8cd6d4a51a7mr1312879485a.49.1773049799882;
        Mon, 09 Mar 2026 02:49:59 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:8ca:d5cb:6841 with SMTP id af79cd13be357-8cd6d4a51a7mr1312873785a.49.1773049799331;
        Mon, 09 Mar 2026 02:49:59 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852f1964edsm58099595e9.13.2026.03.09.02.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 02:49:58 -0700 (PDT)
Message-ID: <3d78694a-6a20-4197-95bb-717ec74c0433@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 10:49:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/7] dt-bindings: net: qcom: document the
 ethqos device for SCMI-based systems
To: Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
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
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini
 <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20260306-qcom-sa8255p-emac-v7-0-d6a3013094b7@oss.qualcomm.com>
 <20260306-qcom-sa8255p-emac-v7-1-d6a3013094b7@oss.qualcomm.com>
 <20260307-boisterous-tuscan-rat-1eb9bb@quoll>
 <CAMRc=MeeHP_ZjhOHu5NNLCU6Cg59EAWQAS0JngEHDQkmcDH3HQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAMRc=MeeHP_ZjhOHu5NNLCU6Cg59EAWQAS0JngEHDQkmcDH3HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA5MCBTYWx0ZWRfX64hjog6Rrr8E
 iW9T4NVtmRw4uPgm6l/vF/mSKThtJayS67y1WUYXBpk/Sg1t9BXy23FHlkTDtrUJCTmHmP1+YQY
 bBbPBm7AUTJYBJKMXWbblHj9Iw4/X9k6v5DOptxT4Fo62ajnX1kyB49eMRJFXsm1SlF9/4+tTLo
 iHD5EQ1AOLpjrllIdwz5M2LIl8bSlQWGB3MAyYiTTxzC9iWOCc4qaTLLBmUoS8AMhUvS9XEJymJ
 sf4vUGSsWKzi6YQS34ndVDV9T+NmbVEKC+LNeOMlgbqvvVNaCpGj2wSt5sQQGYn9SEvAXLFVueW
 v4ZbKfri2d3SUENuINNnM9+rzRO5kRy1opiyLAcUQgaW9sjgKuPu3N8a/e/9tN2J0gQ/ZSFQtur
 CtX7VQg/pexiSDbUPPWDrzOBsovtEzeSzol7YqWMUMQLOsaP9WKrSJ1VFcB5P0IS8/dNBhpJstT
 Z75FL4jDFx0bv+gJewg==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69ae97c8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=P-IC7800AAAA:8 a=hmWrw1lzc97rlj7zVzYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: nae10NAaKAuR0DFRMdm7ZQP1LRzPhWsp
X-Proofpoint-GUID: nae10NAaKAuR0DFRMdm7ZQP1LRzPhWsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090090
X-Rspamd-Queue-Id: D97E72368B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,st.com,synopsys.com,sholland.org,altera.com,linaro.org,baylibre.com,googlemail.com,pengutronix.de,oss.nxp.com,nxp.com,bootlin.com,bp.renesas.com,sntech.de,outlook.com,esmil.dk,starfivetech.com,mail.toshiba,glider.be,eswincomputing.com,intel.com,rock-chips.com,samsung.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,tenstorrent.com,lists.linux.dev];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-265447-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,bootlin.com:email,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[76];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 09/03/2026 09:39, Bartosz Golaszewski wrote:
> On Sat, Mar 7, 2026 at 11:25 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Fri, Mar 06, 2026 at 04:46:39PM +0100, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Describe the firmware-managed variant of the QCom DesignWare MAC. As the
>>> properties here differ a lot from the HLOS-managed variant, lets put it
>>> in a separate file. Since we need to update the maximum number of power
>>> domains, let's update existing bindings referencing the top-level
>>> snps,dwmac.yaml and limit their maxItems for power-domains to 1.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com> # For RZ/N1
>>
>> Can we drop half-baked reviews? Reviewing only that piece is not even
>> possible, because it makes no sense outside of main change context. IOW,
>> it's pointless review of nothing, if you do not actually review the main
>> change impacting RZ/N1.
>>
> 
> This is the first time I'm hearing we can't review individual parts of
> changesets? I see your point about this particular patch and the fact

Of course you can review. And that will be Ack, not reviewer's statement
of oversight.

> it only makes sense as a whole but is this the official policy for
> parts of larger DTS patches?


"Acked-by.... user may not have carried out a technical review of the
patch,yet they may be satisfied ..."

"Reviewed-by:, instead, indicates that the patch has been reviewed and
found acceptable according to the Reviewer's Statement:"

Above important: "THE PATCH"

It is not "the patch or its parts"

Further:

"I state that:
(a) I have carried out a technical review of *this* patch to evaluate
its appropriateness and readiness for inclusion into  the mainline kernel."

And further:

"A Reviewed-by tag is a statement of opinion that *the patch* is an"

And really, really reviewing only Renesas part in this patch is NOT a
review. It caries zero meaning whether this patch is correct. It caries
only acknowledgment that Renesas part seems fine, but if main binding is
wrong by mistake (because it was unreviewed), then Renesas part is not
fine either.

IOW, I believe, you cannot give a correct, *meaningful* review of this
binding patch without reviewing the referenced schema.

That's not a official position, that's my interpretation of submitting
patches document and my feeling of logic behind performing any review.

Best regards,
Krzysztof

