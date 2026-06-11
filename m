Return-Path: <netdev+bounces-298287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Af7qA1ABK2py1AMAu9opvQ
	(envelope-from <netdev+bounces-298287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:41:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFB67487A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:41:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=MUO8Nask;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UjyLPbRr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298287-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF94133A4A8E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FED4D2EEE;
	Thu, 11 Jun 2026 18:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7994CA289
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203064; cv=none; b=P0LI8pZaiG3w/qubp+UgNY3+imdXCyMtsX4rFdc115oI5ULifIssdaaWq671XcVu8SxGD4dEw3/5EneINj0OwegTtaKkscQBGt9127rP9SvntCL+tOPN+g8esExysWPfD6GY/6yuKWHzHzsmIBKC7dJmC4SQUWkXfNntw9zUEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203064; c=relaxed/simple;
	bh=ZmBtT5CKOpRmxcc7v3W7uVY7c9Er9mvwK+eDsLT5JgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw+sPR1yIIs/oEnnrWAHLd2fKYqeoEAHRxcT3uskTTY4zBGvkEA+aerBKLjjE0GvyANqhS6w7KAgfkMz8hNEr8U38xQxLyovzJqd+uZbgdg7abpCcNCoW0780NZ7bl4nCLgbpvAviEQmqjQZARdu1S+rHZeppVEyRH714MYvwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUO8Nask; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjyLPbRr; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BIRuAY1349902
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/v4X6+xp1eqpt5xDCt7e2HETdMjp4dbWkZLG+SeJDac=; b=MUO8NaskBty+GQfn
	grcHqROxQkF2kAJTeL7/02vjr7Om122IM0OxpiKBgVuC1yhFBwQwzqAXNoK+Bap2
	pCyjGAQ4vPTsaeX28NlguttVcG90Dlu1zeWkGURiMS9JvsbpqQQVCmgRxfIw0fdV
	pUsFjSeUWZvM6Jhj56BI4glbnUbmbxM92ll7HdCqJ93dEs0NjtCOarWtkymEWjrY
	mJHy2Y8zYdlTzQPuYX4IWGGU38CiktMGdA2s0sr73R1lys1CuDnoajtKfyP2r0oA
	mO0FREmCkDR8Pti0cLAxIRKydcif5MTDrYNLvRnMBqxEEp+wu+MqZjLML8+z2Yls
	MrwdHg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcg5xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:37:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b9d265308so137202a91.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781203060; x=1781807860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v4X6+xp1eqpt5xDCt7e2HETdMjp4dbWkZLG+SeJDac=;
        b=UjyLPbRrjz+CyGvcAqsGthBSjk0WsMQzmauRAgBqz6W6kXeULogjANeF5ztp4AIn5S
         XVoiQzyZFANtm9EKJSyKFZhfvyqW2wRzu/DRIji1rqdFYpS+QRdkZeTJBCxPEs+6f6YY
         MwKmwlCmuLljCye6dmphEJ+mMoa507AnpJfxmCXID1uOQHxFtAWKxYNq8VXer3dte7Vd
         cM+UqXlcQ18GwOstd87psdckx2oTgbyoHfJYv2GEZ9R66NDCGcEUnpaQ5xd/Vo9j7NCN
         43K2ACpQG7iQW6CIUjVAKJIxn6N3k/jm/8kC2CBtsvAE09Pu+nu2bahsa0UBCLRdSWKy
         4ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203060; x=1781807860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/v4X6+xp1eqpt5xDCt7e2HETdMjp4dbWkZLG+SeJDac=;
        b=LgG0h79JZDjl+HIbFQNrKkAI6CZ01VUGAJPiQQ1O7W6gtAHHiBPEKByCRdUoSG/cRg
         kJlgRT72f/4Rj/r8r3M5jDMjqZ3T7RM09peZ7UOhUPCfXY+7ZBlUfkLjlBL/N9vWbN66
         IwIAiXWeb1OCD8Cv+fseKFhlzQxovz1R3f0+lXRR7gP/wSKR4aba3NOrDGZGDyWmZxjI
         Lpxvd3jkXOignShgevXyHimAWC+dC1AfiAWCkS60SoaKsWCYtylHhW0k+iVpXAQGOUBF
         qKUcmD8E64PbIXax0DDq2U6H5lbHU4MdnYVU6OwZ4Dgzf8mwvm36VfXra9CINpPK580q
         Yakw==
X-Forwarded-Encrypted: i=1; AFNElJ8whxEjCg0SPc2X9Ecyh7cjb8y9f6jFlIioRnfrHNk01sfutQAjIMdyzBg7HgdPqG4BUKmVSW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5jBXGyB6E80JrW2ovunpgR/Snb6cXpcDuq1sj6LtRexhZOLO
	48aTidPoj3x5lt0r1N4xp4KGPMkAaEtLAjIQXvWZWrhGkhOLQoOXFejL9py2JnlpWnLbIuegTB4
	5Fc3fumlkiKxIi0ckeJRApXfUL0ZnCBxcnwfQWFAOM87EoHvheQ/xV9PDzDs=
X-Gm-Gg: Acq92OEcPqrEgDxP20jMl21M1/vYqq+GIM49umpzS+4CS5ek6//o07jUazNbRAkCJGn
	h2mdnJ5DOjpRmShL0qQPhGpuuvoZ7uY6o0/lo8NytsOwVBKHzVyIhkK+VVlqAtbExhaOr/hTmDz
	nFuJwukBnhRf16kSK5RiqfOYupJuRZiNj+TYwZl5YiVs5d3J6PiGe0sQ3uxjCWLoGZKZI0S4aCW
	SMlJUXcxqyckQGoQkLQF3HLkK+IHJ3mVF+SFKmLfl9dle4gZNO//2KUgQiwRYkTs30IFyc5S7Ek
	oQIbWcrjkXparKgg1FAsaiaHa2ggFIkqy1sjdnIhcipE2TylUh3N2PT0hgDfqkLibxQvOoKcnrL
	7t4gB8tIwXSC/4tjdFj9uXNLQVhKf60s0KKDbq265ZjAh4+xWzxw=
X-Received: by 2002:a17:90b:2690:b0:36d:ae6a:22fe with SMTP id 98e67ed59e1d1-377a4ca0e30mr4643611a91.16.1781203060316;
        Thu, 11 Jun 2026 11:37:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2690:b0:36d:ae6a:22fe with SMTP id 98e67ed59e1d1-377a4ca0e30mr4643571a91.16.1781203059802;
        Thu, 11 Jun 2026 11:37:39 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bbbfacsm2555666b3a.20.2026.06.11.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:37:39 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 00:07:00 +0530
Subject: [PATCH RFC 4/9] net: stmmac: qcom-ethqos: add per-platform NOC
 clock voting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra_ethernet-v1-4-f0f4a1d19929@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
In-Reply-To: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781203027; l=4681;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=ZmBtT5CKOpRmxcc7v3W7uVY7c9Er9mvwK+eDsLT5JgE=;
 b=bCe8anHiaYQQwnOm3jo4Hsfoo/mKrJW/Wl8EEkqNTPeb4F7OP3gQPxML+Va5VRquQ4ea3SbeS
 NSdDKQSUdd8CSPtEDIX1z/IMfhBJE0waxtMBBKSSF5s2NDKd8mzvSC7
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfX8y9whTYWl5fm
 84AllB3vk+g/iXR6ZfFNNYzAytHqw75gZjAJPmrYD9oIAfUjKYIFLVWdmsQMNfaRB8U+QH2OssD
 1ACDOme8vinO0A77VJKTtWGHxDwO/viFRz/4SotBEdeKNXEtdWOQ4PnKUGr3Pc/BHixdVPJ0k7q
 tE1TUfaHSVNBZn+FV8gy83KAsY0CXnQcY3j3oaB/LDYfMG5lsESQIggBsXDl9CCW30l9TCWBEi8
 ZHiAG8I83l5u6o6bt5O76fle+cqzNW3WbNpx/8Cuy5UwZxU1jOWJtySvr/rT15qYD6TSrs3V0lv
 lKCfyOuTn1tksU6wetlcfc/xg87Q10OgMCpRU22Gc2/zuZOe6kzdutaLYEEU53CDKCXrhdlAzl1
 vgbYU2WW3JCFEqut9UCrcHMux5DOfP5sHMLUaj6ba+L+g/S3INb38m51LN3iSa+rrT4sj0WUO8G
 OSRcffk3PDOFrYM2dAQ==
X-Proofpoint-GUID: bP9iLF5fMgrHpBbQ18kGCM-6nBAKxj9g
X-Proofpoint-ORIG-GUID: bP9iLF5fMgrHpBbQ18kGCM-6nBAKxj9g
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2b0075 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=upsBg6xUXwFThmIlPvgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfX46YJzANKFk2H
 7l47C/1SxEp7HyIl5N3K7Nks7EcZRA353oPCX+T49mIw8feBb1VEC9zLWpveiW7ivMR40m9c59g
 ULlvoZaLWDUH4S2Vzx5FboWp8gD0CEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:mohd.anwar@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58DFB67487A

Some SoCs gate the EMAC's path to the System NOC behind dedicated clocks
that must be enabled before the DMA can reach memory.  Add
ethqos_noc_clk_cfg and the corresponding fields in the driver-data and
runtime structs so each compatible can declare its own set with per-clock
rates.  The clocks are acquired during probe and enabled/disabled
alongside the existing link clock in ethqos_clks_config().

No functional change for existing compatibles. This will help us when
we add support for Shikra.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index bec08f1eb8cb41484ba3c91c77393e163e7fd071..f4d4b419a76277cc6c56f03bb10d883cd4dff424 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -84,11 +84,18 @@
 
 #define SGMII_10M_RX_CLK_DVDR			0x31
 
+#define ETHQOS_MAX_NOC_CLKS			3
+
 struct ethqos_emac_por {
 	unsigned int offset;
 	unsigned int value;
 };
 
+struct ethqos_noc_clk_cfg {
+	const char *id;
+	unsigned long rate;
+};
+
 struct ethqos_emac_driver_data {
 	const struct ethqos_emac_por *rgmii_por;
 	unsigned int num_rgmii_por;
@@ -98,6 +105,8 @@ struct ethqos_emac_driver_data {
 	const char *link_clk_name;
 	struct dwmac4_addrs dwmac4_addrs;
 	bool needs_sgmii_loopback;
+	const struct ethqos_noc_clk_cfg *noc_clk_cfg;
+	unsigned int num_noc_clks;
 };
 
 struct qcom_ethqos {
@@ -112,6 +121,9 @@ struct qcom_ethqos {
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
 	bool needs_sgmii_loopback;
+
+	struct clk_bulk_data noc_clks[ETHQOS_MAX_NOC_CLKS];
+	int num_noc_clks;
 };
 
 static u32 rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -696,6 +708,17 @@ static int ethqos_clks_config(void *priv, bool enabled)
 			return ret;
 		}
 
+		if (ethqos->num_noc_clks) {
+			ret = clk_bulk_prepare_enable(ethqos->num_noc_clks,
+						      ethqos->noc_clks);
+			if (ret) {
+				dev_err(&ethqos->pdev->dev,
+					"NOC clocks enable failed: %d\n", ret);
+				clk_disable_unprepare(ethqos->link_clk);
+				return ret;
+			}
+		}
+
 		/* Enable functional clock to prevent DMA reset to timeout due
 		 * to lacking PHY clock after the hardware block has been power
 		 * cycled. The actual configuration will be adjusted once
@@ -704,6 +727,9 @@ static int ethqos_clks_config(void *priv, bool enabled)
 		qcom_ethqos_set_sgmii_loopback(ethqos, true);
 		ethqos_set_func_clk_en(ethqos);
 	} else {
+		if (ethqos->num_noc_clks)
+			clk_bulk_disable_unprepare(ethqos->num_noc_clks,
+						   ethqos->noc_clks);
 		clk_disable_unprepare(ethqos->link_clk);
 	}
 
@@ -732,6 +758,37 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
 }
 
+/*
+ * Some SoCs gate interconnect access to the System NOC behind dedicated
+ * clocks.  Acquire them, set their required rates, and store the result in
+ * ethqos so ethqos_clks_config() can enable/disable them at runtime.
+ */
+static int qcom_ethqos_init_noc_clks(struct qcom_ethqos *ethqos,
+				     const struct ethqos_emac_driver_data *data)
+{
+	struct device *dev = &ethqos->pdev->dev;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < data->num_noc_clks; i++)
+		ethqos->noc_clks[i].id = data->noc_clk_cfg[i].id;
+	ethqos->num_noc_clks = data->num_noc_clks;
+
+	ret = devm_clk_bulk_get(dev, ethqos->num_noc_clks, ethqos->noc_clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get NOC clocks\n");
+
+	for (i = 0; i < data->num_noc_clks; i++) {
+		ret = clk_set_rate(ethqos->noc_clks[i].clk,
+				   data->noc_clk_cfg[i].rate);
+		if (ret)
+			dev_warn(dev, "Failed to set %s rate: %d\n",
+				 data->noc_clk_cfg[i].id, ret);
+	}
+
+	return 0;
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -791,6 +848,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
 	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
 
+	if (data->num_noc_clks) {
+		ret = qcom_ethqos_init_noc_clks(ethqos, data);
+		if (ret)
+			return ret;
+	}
+
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
 		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),

-- 
2.34.1


