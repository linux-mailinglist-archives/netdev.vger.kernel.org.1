Return-Path: <netdev+bounces-295788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lb3zMOGwImrGcAEAu9opvQ
	(envelope-from <netdev+bounces-295788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F49647AAF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:20:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="On/QpE1s";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=T+mLT8wm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295788-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0C7A3029733
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251884D90A0;
	Fri,  5 Jun 2026 11:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FC4D8DA3
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 11:19:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658374; cv=none; b=aS1AwP0IeHdW2YxoVkZ/0Tzgqo66Ar3VV58/z2eGW0v/EJjwHW8RxTSGRXcjG7e4BdBjSbsB5/vjOz78P4X29z45sd2ScYVRCjT+mqeHOnuF2xoDPURixcGhG0L7XkixtpZe77qqE8SqHnXmt/yFNe7UJ75tydiWUo4Cr9Sjb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658374; c=relaxed/simple;
	bh=Qt2kstaKGrB1yY49mZjobtR/4AMzw9aIfR3UkFARmBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEiGDoOLWTZW0bkajW1EhthYhB/6ZvuE2uEzu6EN5SgPXC0SfIlB3VJzPpYahgr9wkOxJFeZ6npqRDH1FIsIyetAzVK09qvZvQEL2/DTSiPmNO/qSfCBYDaepNuAI507cnIwEdtwIFGtG4C3ti/ttIfTOis3jTS5+Oqy6YVIQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=On/QpE1s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T+mLT8wm; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6555q8RY2427824
	for <netdev@vger.kernel.org>; Fri, 5 Jun 2026 11:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqRYynkSRgvqP9sDhmtCs8Xxd+0USAewY/2Or+/Dk4Q=; b=On/QpE1srplp2xgB
	wG+v/aGlx/kEuX7FIrhxrksDYhgE6MCUi0xWqqsPiyXHdOuoZWbdGkmpDNphfTOe
	Ty79pkqLQGcdwbr7yBA4gpCNAzmoimJfn+xkSUem7BUhjUaTKH+zT2nwlyg5S2J8
	1tVTMJIi4lNZA0eqb1yCNfY0ItDncf8UJj0k/qqiv1zJmQnwlnHV9RHBYpjM6vyS
	ro2X7T562Jkjr1PgPZevB92mGzX6ILAHRRJHQtX6hn7K/U4fUF3/RJucYYuw2xOn
	+rhWCXx248wi/xpU0oUY5eqq3+q+8g+/2EFsefZjXbbt32QvIfBJEkiJwkmwcxu+
	caY2Ig==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekrphh8h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:19:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf335549b8so27089785ad.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780658370; x=1781263170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqRYynkSRgvqP9sDhmtCs8Xxd+0USAewY/2Or+/Dk4Q=;
        b=T+mLT8wmwI/+L+xLhtSUKAmi7B2jwTuXAvEa5LwWEzNryy4m3vH9/N3NNuoqhLS9gN
         Sd+lkO8vx6er3BXRdTLjtOd4v/U3z40SNLP0tWYAgmGxHuNl8SFADcaYicZKNz2M8jgB
         TNcW5OS1p68QSQa1EPLynR4sV2Goetwv2OX76f2F21C9Az9L8/LphD3kLTvdoUIYKILb
         76DjwtqJOVNvKTRooYF52x2B6amOxkNtR6ZW2ERN66Mkw4Pqp8XZuJR8PyngE/9YQI59
         SLOXJmt0+kUAKPw+KHvteU+un/qcooIEwgybVo8sIN8LS2Q6W7jyBXUonoFllzHvTpFN
         zNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658370; x=1781263170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqRYynkSRgvqP9sDhmtCs8Xxd+0USAewY/2Or+/Dk4Q=;
        b=nZUFKFMd/Q6rj0Lz9pIlpBLgNC1wysqkcw5tcD0umibLhP72aqh/nzVjDvUoX3nLqu
         BIsllpLGHh57wHL3HLx9j2FyJ+bthWk+dB44BY7hhs9ILJCSEFH6y4JB4xJKObuMKIAS
         jhL1HeOZkVnlnJ1pdSIfZfREx0AInC5qmN0Em+iWsGeshU5DHSEM270Li7EortBtrc5c
         m21oUXNP/eRVPaJQmzC+jvZzT99/j4K5A0Su8VWlG5SQYiwLOX1AAby9Y2quP7PZpWAN
         GC2NEt6K2HHkTZF9y52EHccdm2gSBnL1VhkBmOYD2kdregNwxeKaCpFLHf2iVuLl8lpB
         HJeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xo/z2MPKP3Y4VWtqLjJ31UTmHQ56SRwLeaA6t9DJquxuuj0fxWQqMWwFXYSipsc0u/Y6vvv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUd8P543u9aM/Hv7NzDbchhxAeV4Ox0bMYmiTcoofmo0a5yMRs
	4obrhMQnQnRRf1LpS9qMi0HqOW9trI7swuCYlUffPTV+ZBnG1e6x3IWXnEI7KkAGVsJlllMCjfV
	PxGY/jO40RTS8ETuk3u3L+h69iEzLaPLbA5x3sR7lkRphI8foUSsl2pgMbcE=
X-Gm-Gg: Acq92OGWZDZYuta9qeOSLz2n1MzdZW+AZMlOTg5QrlFoWpFurSUL5P3xvV53yq+bXWf
	Un/1Q8CN/NKXKtcOn+wybfGxURnARHMInfc2QCKCcR2f/0fm0oz8v9e1Pg2WkBdZqUCfnNCd17R
	cvr1oIGhgWahsBfc1Y+4whjhW9j9ASprrU/t50DqIGYb9CA66bVMDWdHIuft1O7DoruKhOSEKVk
	tm1/QBnW+fZh22fBuAH/fYAYmzKcikJEjBnTvp1futufrt2WktOwODiKie8KeGlhfwBwfN8EdOq
	5a+xtH3jU1VhlEc+B5tL0rqdkNwO/innIIoI1PgHo3l22zTS9KEhpoH1FygU2S2J5fTGD/9pB0s
	Sfchh/HWOINzA06yyu8wJE7EEjQ/Su1ZIPUVjVha0ByU/ftRz6kF3BrcCmN57YQ8=
X-Received: by 2002:a17:902:f78d:b0:2bf:175a:db61 with SMTP id d9443c01a7336-2c1e7b35b28mr32635835ad.7.1780658370427;
        Fri, 05 Jun 2026 04:19:30 -0700 (PDT)
X-Received: by 2002:a17:902:f78d:b0:2bf:175a:db61 with SMTP id d9443c01a7336-2c1e7b35b28mr32635415ad.7.1780658370002;
        Fri, 05 Jun 2026 04:19:30 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm124551665ad.17.2026.06.05.04.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:19:29 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 16:49:11 +0530
Subject: [PATCH v4 1/4] dt-bindings: clock: qcom,rpmcc: Add Qualcomm Shikra
 SoC RPMCC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-gcc-rpmcc-clks-v4-1-a0a7bfb44455@oss.qualcomm.com>
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Obf6XVlzHoZjqdazmEkoQ6WYLzNldkSy
X-Proofpoint-GUID: Obf6XVlzHoZjqdazmEkoQ6WYLzNldkSy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDExMCBTYWx0ZWRfX9u/tsDNCwqDc
 px+YiBvim/FbrSGDhi+WGTXRuTBwOq8goPl/fIQKDNgxFP1HJRaVO6SK47QFhRXnNFOgkRSTTM/
 T7JJWI5C/EK8KpRSdiAHjy++lBtgYak/LvyBZU7AoB4GbX210z9O/2EFDTuAwE2p4fr4bXD65he
 WoShtqnl+VLDro0BvIP9vdWDhgQs1B340GXucj8VY95Zglv5pSgJR096v0avF9/RJYslldHpqsL
 Y2/GHx/cJdhKluvMkxXot3aailqKB0pz82DH2uHgYi3pnzSDsmze35AUQyTDxPS65PXEfk8abmK
 wddi7HZnNXzGdUuzRfuFQql5H5EVKBfTaRhO+GKcrCivKdDOpHJ0YdTTZ9uRd/skJuDBE/n+Q1A
 UjC2Ft2IWkSD8cbQmzSZbQrc9UshdCzRsAbwnRp+pTnX5wdLgFa5YTe+70zkuf7S939rDZJA43T
 vVU/NveMG81Z4yK3FqQ==
X-Authority-Analysis: v=2.4 cv=T9a8ifKQ c=1 sm=1 tr=0 ts=6a22b0c3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5MG6tTDo7b5tcJehnegA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:imran.shaik@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 61F49647AAF

Add bindings documentation for RPM clock controller on Qualcomm Shikra SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index ab97d4b7dba8bc8d38903b399d2bd4bda087db8a..b8aea98b00bc22c4ab6da1e6235ad676f200b44e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -46,6 +46,7 @@ properties:
           - qcom,rpmcc-qcs404
           - qcom,rpmcc-sdm429
           - qcom,rpmcc-sdm660
+          - qcom,rpmcc-shikra
           - qcom,rpmcc-sm6115
           - qcom,rpmcc-sm6125
           - qcom,rpmcc-sm6375
@@ -126,6 +127,7 @@ allOf:
               - qcom,rpmcc-qcs404
               - qcom,rpmcc-sdm429
               - qcom,rpmcc-sdm660
+              - qcom,rpmcc-shikra
               - qcom,rpmcc-sm6115
               - qcom,rpmcc-sm6125
 

-- 
2.34.1


