Return-Path: <netdev+bounces-294272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lxZoLKT3Hmp/awAAu9opvQ
	(envelope-from <netdev+bounces-294272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC562FCB4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:32:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=R190SuZQ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hJpMVine;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294272-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19AB730BFC08
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9013EDE67;
	Tue,  2 Jun 2026 15:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62B3EEACD
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:22:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413755; cv=none; b=Wgy0twzkv3i/Ug2U4aAf+RrHEKti1qKNP/y7EwYQTcgys3K5wBBIU3oRkTU5+BWMzXX/XTyL9I0g2gZ+NphhupDUjZY8Ghx5TH1nMQ6lUKDJXk5/hwCKzdxKTaP6T5qaUoyjCoUH4wTYYfTEvPyXxfJnPdhRajzao7/vKBjZpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413755; c=relaxed/simple;
	bh=kcsFlQ0y8ffq2yUPH+MjrZDKbFx8blbaS/9oyuSRv98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fl3ExRrEceahIftJ+1NigP5V4vIQ8tF9Uu8hdXJbgKVM2NMEMIDRppFvVlYLcItwF8CXAMuJ+zK7dpXkKXem5+XOZ3/HuNxBVKacKpst9O/5oj7oFLvRdxBBjGys1090ud7kQ5oC/h8RqReZume6xZWS9DVl+LCvwV72biNq2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R190SuZQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hJpMVine; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652F1Rnq3430318
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 15:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N30aZi9cDCAXsNhZr7OUSQcHTSPHi+a7WxoDVPotoJY=; b=R190SuZQhVT+dzXF
	9n1X/qUT5Gha/CpxR+ho3DyaHp5Uk/w+4E7VFPajGN2JJmDUnszQQcnHyCNHDV3Z
	/bYAA4OIf7grvPFb/t54Fb71JVzBd2X8ry9Mt69RmMGoHzIP4Otpr04JpKH3Q22D
	dNwRj/I2ze98RRNrGh+nKTwgoNV7e8KGUWRBbgpZMaY7YDPNOpghDG2ac4aX46ax
	sowX0BM2RVDHiPatNWU/w3yZjhv1utSn6eyOD9EaPVfZVPowxbPyKWVFNj4J7U9E
	WxKrN6C1lxAn65IHdX5eLFPEsePHW5bLl4dAnGWIxtKVt3A9U8jDhprfJ1ohbH14
	ScAAMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mk6u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 15:22:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c36f4b76so27459325ad.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780413753; x=1781018553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N30aZi9cDCAXsNhZr7OUSQcHTSPHi+a7WxoDVPotoJY=;
        b=hJpMVine9h0mR4k//Bp8261+2RM5v+SwuN3dfzacCa6+SCQHRfyWFl1cO3u/1M4xDB
         Zt55aawXdFM6MsNLZfA81rPhbMI/QMAA3SKEgSQpuTK1pdej01VoozbueRfLDH5kzmcF
         Mt1IvBULNmgGRCG7Y+VzNck5zz3rjNEwGEoz4WVT7cRetV/zpKYp49c/NRHYqQEn9Aln
         alpTFWT+cpK+ci7GbouoBem8Z+BljxOgKnuF3XbMAVyq9OUq9KybkmYVGpQtgPtWWI7Z
         tYeTgqYUOmoL8Xilna+fTHEaB+uF9+GqpknSrqz9N64X40H49WkCzSXui399QK+/o+mF
         jO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413753; x=1781018553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N30aZi9cDCAXsNhZr7OUSQcHTSPHi+a7WxoDVPotoJY=;
        b=dKW+atTP9EsRR0+RZ0fNpkzmgptKpZxjfYc3ogC/JGS/VAYijRAl1WiQvteIxLS++r
         aAL+wh7kF49T67HSFwkkmDIG2E5fgpW6gXMo1bIEHfjmNgTWx8lV1pm9Aa/tENB808IO
         ANClbdeEQ/b6XujBTvQ4srnCBH+mGVlNk0lal7h9rMrJLGEFifgfCEYEIF9oLebbW1S/
         V907SjNHi1xl/GYYv0KeEXf3ri++DTAIqEbG4ylee+nn6ZXESJGrBsjbitLHSUTU0+0C
         BmjySOM2W3H97WQccFfPwSnpa2Ug5dfQqJJQEeByc4goYoKXBpJOVskRB5whTZIL+d+E
         iNAQ==
X-Forwarded-Encrypted: i=1; AFNElJ97UMs+scWpojGzxFXQtqspA0MVrFkURTKmo/inDYIKbdboM6iiM2flRPqv9Mm24ElAT+RXWHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFXPwNW7LATYjnWSNLkrvWncKaYrpY1HTjuxNQ4u1mEM7fgkt
	BQWEZ3VBEcVqBiFBkDkMQFYJI1qKsgkHMie1zjo21+b6E6iERHfwB/6YyMhq16hsHw1MWBoJl8S
	UWBSFQ8JuXAtX9CJRlzyDOrNSL8/JDZsdURo3iSd+Yv0MGsS6Q83DdkNyWZs=
X-Gm-Gg: Acq92OGLaPwB4vph98UC8PMhYyYpm5sLlEyeGAaa081XkPYvl7Em43FAFdX+PBmBSqr
	g3TS9VMBJyOJeEN5+WBPIJ3SmkhyBKueJV5tU85D9f7IAS13n6sHrEKeYfgbnffKL2VK2Lg5sgI
	yTcAhygwqIYqUt3YOfa5GoYIfBGuXGFs8V5iWIA/8vml+o0SM4Obdub2qc7AyfXgcqP4IShxwym
	qqUB7eUSlzLQ59TN6zI2kkBCbOVPCf64I6ozKmRUBMkWOaxiO6+dwGBWrPsrrSJU+PaCidxXBqQ
	6/tmdgLS1tOk1XafuM26+WEDJeC8YRpe4pym4/wqhDBF/JGcBcTiOxrSSWG7n07/qSJH26UU14r
	6DSMfuibnnvG2R3e6BUjDGhvnohKdC1PvVoY2rLuz0vAP3DZAqo9bksyg
X-Received: by 2002:a17:903:986:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2bf367950ffmr166701675ad.8.1780413752731;
        Tue, 02 Jun 2026 08:22:32 -0700 (PDT)
X-Received: by 2002:a17:903:986:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2bf367950ffmr166701405ad.8.1780413752237;
        Tue, 02 Jun 2026 08:22:32 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e71cbsm135136465ad.15.2026.06.02.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:22:31 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 20:51:53 +0530
Subject: [PATCH 5/5] arm64: dts: qcom: Add GP M/N clock controller node for
 SA8775P and QCS8300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pdm_clk_gp_mnd_v1-v1-5-1522662b6c53@oss.qualcomm.com>
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
In-Reply-To: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE0OCBTYWx0ZWRfX7qr85ByV2SXl
 xvgVChvQ4MZPeWeSuwFfyz9TvyAfyTN2YRzamL+NVzrfN1tZCm4kr8Jng+D6CehAaLc1pMUKJfQ
 iTV6BqNYJXqccd93iLXV60pKShJ01EzJpi5JSkLTFSz8e0mrCyEzZOtoHWomU3wojLXEE94fHej
 2SrKkkjGY8+vkVnt1Z4/Se91Z1duNgemkDlRhHEYmCpO2jWumnAFF37NktPR47ZGhLBSHtM1jif
 msvICGNw5SKBdWc3uWoUq7XqJtIMj72JZisYFDxZhra+JPdR7ZHMb8ZKd23c2VOTXzQ1FSDMWxE
 pR2P352lV7Ir1D+TN8NKSchfz/uLG2c3znpw1Abzkk58ZEIWBPcCuspsNsn8AJjavXq7qERLcAM
 +7F4GZ4zGD7VS1ISlJEcXdjDaCjWmqOjj63OSsBNEoIlc0gc9F5N63cmemrovhlKcysHPIIzFL4
 VqAsUVUMQbflzTHgoqA==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1ef539 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xYDh6zYGlObRgEhEGzgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: V7TE7ebkFKN9m3sD2hmawKTLt5VcQ7pJ
X-Proofpoint-GUID: V7TE7ebkFKN9m3sD2hmawKTLt5VcQ7pJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:taniya.das@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[taniya.das@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[taniya.das@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 1ACC562FCB4

Add the GP M/N divider clock controller node at 0x088d3000 to the
SA8775P (kodiak, lemans) and QCS8300 (monaco) SoC device trees.

The node uses the qcom,clk-gp-mnd compatible, is clocked by the PDM
XO4 and AHB clocks from GCC, and exposes a single clock output
(gp_mn_clk) on the dedicated gp_mn pin mux function. The XO4 clock
is pre-assigned to 4.8 MHz (XO/4).

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi | 14 ++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 1ff9e1598d00429c03b2bcae41fa370ab2c892bd..cbc13ac37f8aeb0b1071ad0609ec11e829d2c798 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4412,6 +4412,20 @@ usb2_role_switch: endpoint {
 			};
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,clk-gp-mnd";
+			reg = <0x0 0x088d3000 0x0 0xc>;
+			clocks = <&gcc GCC_PDM_XO4_CLK>,
+				 <&gcc GCC_PDM_AHB_CLK>;
+			clock-names = "pdm_clk", "ahb_clk";
+			clock-output-names = "gp_mn_clk";
+			#clock-cells = <0>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&gp_mn_active>;
+			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
+			assigned-clock-rates = <4800000>;
+		};
+
 		qspi: spi@88dc000 {
 			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 19f8cf4e15482947f6049188050c370340afaead..d192f92a896bb13017abdf82062e8305aab3e5d5 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4353,6 +4353,20 @@ opp-384000000 {
 			};
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,clk-gp-mnd";
+			reg = <0x0 0x088d3000 0x0 0xc>;
+			clocks = <&gcc GCC_PDM_XO4_CLK>,
+				 <&gcc GCC_PDM_AHB_CLK>;
+			clock-names = "pdm_clk", "ahb_clk";
+			clock-output-names = "gp_mn_clk";
+			#clock-cells = <0>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&gp_mn_active>;
+			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
+			assigned-clock-rates = <4800000>;
+		};
+
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index ebe5889daa5300efa7857314e9170d7d2fc33ef7..f6c5ec38c7491b7a16ebfb853f8af88bdf1f0db3 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -4867,6 +4867,20 @@ opp-384000000 {
 			};
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,clk-gp-mnd";
+			reg = <0x0 0x088d3000 0x0 0xc>;
+			clocks = <&gcc GCC_PDM_XO4_CLK>,
+				 <&gcc GCC_PDM_AHB_CLK>;
+			clock-names = "pdm_clk", "ahb_clk";
+			clock-output-names = "gp_mn_clk";
+			#clock-cells = <0>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&gp_mn_active>;
+			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
+			assigned-clock-rates = <4800000>;
+		};
+
 		usb_1_hsphy: phy@8904000 {
 			compatible = "qcom,qcs8300-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";

-- 
2.34.1


