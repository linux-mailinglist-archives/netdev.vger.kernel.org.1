Return-Path: <netdev+bounces-296525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8GwUHNi2JmrCbgIAu9opvQ
	(envelope-from <netdev+bounces-296525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:34:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC273656360
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cTqr6O8s;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EIRnrTDY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296525-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296525-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5218530D9768
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DC379C46;
	Mon,  8 Jun 2026 12:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3737B3FE
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:23:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921404; cv=none; b=ljQtDqXiWj9rFbKFzshxLakcStUkOldxu4hXGbUrqLQMJe+ETuhDifb6MozMUwwPThdbnIULiqeELzYEBfaLZEREdu/SGFutN8FCjfPrJFFSuK1UD8oLQ3u4GAKvwFdLSykm78ZEWdZhe97IXqLDLljhXfh4TS6c1m+mlG7asOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921404; c=relaxed/simple;
	bh=vQxUV7jYWXzMq5Bmu/8yTnsosmkeyas+t1t65WaotR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKt3JnDsLiuRL1djpp48cAFZnQwjP+GKkfwstom1M6eu0oogaLn5HuHvCCa8deSU9sThRRflYjzGTOHGg3bTkgbD3xTDk7xLmwFyotAKx4HtLeDbKuDq1ZyvW6xY5XYzhJU+YZMo4GNPcGo2MBL5Bmoe93xwlIMmvxd9cyQtxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTqr6O8s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIRnrTDY; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBsrT3459770
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 12:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	izYmYod060ZWJNtBK45Vny8T/m2n8qzGVzVsdM8Pb+Q=; b=cTqr6O8sjUmf7Aj8
	y/nyPXfBJ6Kqe70RfG8sV/37JQXJAhBz3va98kFnr5tB2PazEa8y4DvP1V+De6Mo
	zKqhqfA029EhXLYhhPL5mMU3ZeYyVKi6SO/xoxDoA2bpljurw3IJ8NId775ue/dd
	VA49gXhoRSrjaeTO3v1dEJIzGjUkezG92QvepFfPzMHypTpOFNiFQkBSG5es6rJs
	0K7BbqqbCQBRviRYlH3uuHUTEzNokNCOZJ9d6DpELV8/nBejJGiEAlUIxHQFzxap
	1euMUzZakbEubNxuHYpbUFWLdA/syshJ4RgxGUGIklvXe+Vf0dcGkjlcbrAQ5Zjs
	3r+ZLg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8gjwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 12:23:22 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7e25a5f1057so81633147b3.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780921402; x=1781526202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izYmYod060ZWJNtBK45Vny8T/m2n8qzGVzVsdM8Pb+Q=;
        b=EIRnrTDYC/3Bl5aGZo2DTFruj+6oMsXIveX9ZAci0P28pb4f1X+//abSCz3mFZxBCX
         0wxVu+dexTOoFbxrd+88AWW64jM+sv2DgNeFEzmot5N1dPlgK2Ykh8Zf1S6r7kBIKU4z
         Kc3Zw4kO99cxmC05trpklZl7Mh+VTCcOriOA+m/lZTZQ4reGhUYBHrysZmeg+3X12seQ
         5PksPVxDh0VsU4l7f0sGvce/ZTzFBkMoEIiax0quEw/BShUDYlE9tzhOBR83U7DwmfV8
         gLcNuEvKYoOsAP1NnznVxNuhDZtiPjkbiBZQIuZsvt0pN5N1M7eYK7VXFUkhVWQk2hTC
         aMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921402; x=1781526202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izYmYod060ZWJNtBK45Vny8T/m2n8qzGVzVsdM8Pb+Q=;
        b=HivY6xvGF6Ij6+q1xidHedfGHlDldBAcWlFBX3URhE7uL5irm4ewtPPVJnS7lW1ydT
         b2+1DxBg4wnSVBv3b44RqpPhhARhunYcMDMoHfgccsdAp/CeLa+pSHVy52EraMXLv7Lw
         lLE6hcuuUZJ0J/u4XSdQNVh9ybIlSOs11gFRp0t4Wc44aoDiTg25YrNSBZT0u94tT3W4
         0IArPBcEYpaIaM2J4jMnDn3T6McSAwP/Ypy/JzQLJB0ySxrj/tLIFxvgdbBhI083KetX
         boDZaNlyD27ZLUI27L2Mi+J7rdLkCm+72mAv4VliNwMvV6xE8a1YbrWnKbwAhS62ms9B
         M3FA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ip3FFzj0mDkbOFdqLdc/s9HCZVM9oaiWKswVK3UVQi3lEC76nHyWme/zPD6EJGZMbjug9zao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7d/nrUjCQ/IxEIL1t0C6TuA0dNL+IhDqwOcIRlGavtPjo6oK
	3Ew7hPMmah1fRcQYaUwM/B4nw5yiSqUtQOSNgC6wG5ODsFZOEGKo79TRlKG/wSOFLLU34POL7fj
	OLCIN1vgfvLrT7d6V2TPCN7WTXGyWRpAAbBe3/X2Obu1XZ/E3lLshM4jFrr4=
X-Gm-Gg: Acq92OFo3yDf3u0zlr98aNyevR/tOwI/SSILyMaob+zOp9UErzaZTX5dLpjiZTYl7Iq
	RyfxfTcMdnr9aTeO+5Z6YVapqZmu9AGSRGXC2uLmOMJLo1okETsH+iti6YXv+CQAX0lujp4GmQ8
	I5+ZK58qarD4cfsWZ6q5XBnKu9U7QLgM3Y/eZD3NWnLEREjvpzL4ufQp1IGjSdmHzKPho79TSjm
	HmIvqwB9jlCqkVjmgqqLqy7f1hvmxoJCg25/q89J5MalpXjD4+6jbMy8k+nU4K3tf3uRaav21w7
	qDfDzGIIMat5a29ut+1T5DmPr86RZAS7k/JwiNPRl4VivwyQ7qUYWwEdV8+v/5bBMcsZRtz6iP8
	HX5z13IwqFdeOe+FyI3+IAUrwyn1OLK8oqOlGSSAHIdx+bU3+kArQcwkH+Df9Las=
X-Received: by 2002:a05:690c:6389:b0:7e2:28ba:28e8 with SMTP id 00721157ae682-7ed0ba6363fmr140918987b3.21.1780921402208;
        Mon, 08 Jun 2026 05:23:22 -0700 (PDT)
X-Received: by 2002:a05:690c:6389:b0:7e2:28ba:28e8 with SMTP id 00721157ae682-7ed0ba6363fmr140918707b3.21.1780921401820;
        Mon, 08 Jun 2026 05:23:21 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8186sm84076257b3.4.2026.06.08.05.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:23:21 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 17:51:51 +0530
Subject: [PATCH v5 3/4] clk: qcom: smd-rpm: Add missing RF_CLK1/RF_CLK2
 clocks support on Agatti
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExNyBTYWx0ZWRfXwKM5E2mbswUV
 QVZopNz6wcn3Vc7a8oyQ9at1R4LiWtLiIhVMQYxcMuibMfBLPbP9Al/KOaP1zYRV1CGAAizU1nY
 0nUIjBqjvCZPTc67i2EILWONXUxVwXyHrXOuHu9umKc81dysLOtSQ4wn4VJmSrD713fGwNSFAbj
 UVovuPy4gVIY5WprcVRolOzQx8wHS15D9uA82Ns6Cw6Cg9roFjveOCePzmbBUIj6iykSJchnxuE
 NUTHTqlk/Yg+9zf4GV2dzNLUJV53rkYihCz6GC3/F00ibvsvosxpTH2ARLHGwN6zjj57XGX82kU
 w5rR1a5s9ZPaht0T521wGPy9JylFONUcCd2tjL1uIHiLLBpCkegMyHbrZHKihncue2k0QCJKjXs
 1UudD/q+Pchy51nNGjU5CUFSsWnyWp8ViOEJ3NIfnfnfNDMOqUnvu8xde0FHadn4mby0jLpWTTY
 fvOgZsOy+kFM8iuDoAg==
X-Proofpoint-ORIG-GUID: BnkzB2iJkz4NkH_SQDr_jIUwJ_mwrS9j
X-Proofpoint-GUID: BnkzB2iJkz4NkH_SQDr_jIUwJ_mwrS9j
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a26b43a cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=j4Xy8Qu2vJQzfQ2CmTYA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:imran.shaik@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: CC273656360

Add support for missing RF_CLK1/RF_CLK2 clocks on Qualcomm Agatti (QCM2290)
SoC.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-smd-rpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 103db984a40b950bd33fba668a292be46af6326e..0b624ed4715c75042b92ec49c073b281533cace4 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -495,6 +495,7 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(rf_clk2, 5, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(rf_clk3, 6, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(ln_bb_clk, 8, 19200000);
 
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PREFIX(38m4_, rf_clk2, 5, 38400000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PREFIX(38m4_, rf_clk3, 6, 38400000);
 
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(cxo_d0, 1, 19200000);
@@ -1262,6 +1263,10 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
 	[RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
 	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
+	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
+	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
+	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_38m4_rf_clk2,
+	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_38m4_rf_clk2_a,
 	[RPM_SMD_RF_CLK3] = &clk_smd_rpm_38m4_rf_clk3,
 	[RPM_SMD_RF_CLK3_A] = &clk_smd_rpm_38m4_rf_clk3_a,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,

-- 
2.34.1


