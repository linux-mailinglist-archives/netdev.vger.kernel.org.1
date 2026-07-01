Return-Path: <netdev+bounces-303751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zMYbKvw6RWrK8woAu9opvQ
	(envelope-from <netdev+bounces-303751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:06:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE96EF7E5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HRY1uaTe;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=alhe9P4Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303751-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 294E7307E33A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC064BC003;
	Wed,  1 Jul 2026 16:00:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545234ADDA7
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921656; cv=none; b=lyyYl3BjhmNqXPYDT3zD7V+tJ6aXvAX1hbUFdshQS+rekra/7ddn9I3fJOq7myrRfPrhkkjXi7HmrWAvXTqYzkwd5U3mmWBkkCV6rQFeEWMlRXxV+dFxA7ikYFrYhiJhGNlKRYd+5R8Zf81612R3xLN8083ObYIhpRdZ5v/m7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921656; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmgBvuJvaIlk1wtl0mIcrQ26BHbZdMfvPT5LZXu4j9JyAfS5foxMh4kHScvCckJlR93NhW2KvwmBjcddGAM5YMOuZoeDPMUOb1lYvVqRD5upi9acTmk7owBDpOmJP02u/PuPMKtzn9vybVAwySXy2hOe2qVWbH02z1DgS0xbRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRY1uaTe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alhe9P4Q; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoA3D1469971
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HRY1uaTeGIIRXKEL
	6wsaDKZf2cVplnvu8A7vouedWY/oJZ9OBdObNQEd5NXv59+E12gXEZG2Pue3jodZ
	Bf9nuB74OOOyxq3OY8Jnt8//r1cOb5bzbB87nvHHzfO+zPeP+gIGxBWsXvnSGkOB
	2sC5Leun+VnKFM05qXn0uwb/uc/49eaUxgwfH6B6lFtaXTBwCCWPZQsULNVLy1It
	7+iLF/bWx4bxIcjYIzCL94f3uW4Vsgk9mMqVs2JtjJHf9HuhdLux2WDTPsfCyZ6u
	1cNFycmRWxPCwad87+4Sxcdt48EMG54PciKP0BCWCVCgOYX4Zt3uVLYeRRwTEMPg
	qjISzQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqn3jc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:00:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b4b575561so116399385a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921638; x=1783526438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=alhe9P4Q4tCe33hu4R2/Ad33TZpZRpsVNsQGI2bv1xnNdGeXADKd3cJ/KvgldAUm4l
         oJMZXqWy62vYZVdGBLe0MZaQ2lqWclVX1EVZl8v41Fs9EugRJ8MGWFc8XYDiLkAAuxZR
         2VMPPfxA3uNYl59ghAnvfa2Cc3Cd9aoBvLWEpc9aEus2IL0upwJqKmVxlp++1xJ2hSlN
         urSvESYa4sCsHkokJDzsY2JM37UV3EPwhP3hHbC7keWibOlcXFpLfGWjMbKp+ddCUB7e
         mlkN7LvzPCmlGWHqCCfAyoxCE5IPUlzw8sU2DwOcihGwbAMPaNX3xBPx+r09CvrLV7R0
         Eqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921638; x=1783526438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=e898SGGhW/Cw8YrwpIPj9mP6gzE8EsxPFbFSt4VCahWkEplhF6SpRTWDiyJodHg4t1
         mgpbqYnbt9UbK92szSoezCIlCjwzRGrHAGwiqxkIFRbCRUdCqIJg9tgPdeAiFAkUBL9s
         ok0thnWV4WwPHj4Ugt/zHn52E76wknO+MqrsxEOENnzkWpEiiW/MxfnrSEjLc37hCALn
         TEryujiDhm8q1pEeGbRxhxfOzoHr+OMcjsMtIEoqYfbTQL0+D2dKo0JYdJTVH9oDITX4
         LRLgGUGX/+yVk+rXR68DQ0xPhmFEAwhnF9qMm59sj69byOLZvysKAw3Y2bq6OzgRv3Bp
         Ulbw==
X-Forwarded-Encrypted: i=1; AFNElJ8gYrQY1+/kK/N/q14ZqFWoIdWQGjDIAgl6kB3D+3Rj3Ehbk2gAnfT3NgGiAkR/oXs/7WMPJaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNr0hQ+vC+rmd44bY6csYnpMQ+OEq52I/cXT7xGWncWyi2Cip
	NPzgyFAQnsxhSAuOLxT3vuPs4N6byhINqWRaQJGjN6rJN43t6WgZmmHj40GapROHVi2XLTd6z72
	R4u9N5P5MmeEFe95O6E+bYWZefsCLVpkpGuPq4HPgp0vlWR/VG7WllhqfqaM=
X-Gm-Gg: AfdE7ck9GhmH2JyfIZJE0bIEbBX6Ho7WoLenHA809eLuGSOssRuU3mDNBW8fGuNLFh0
	XGfV6rUke5LJLqskLtVaovsHdwRRWfMaReWaXbfIY8IeJEiSTCl71jskYC8zXdqyGwJPfoaCGWr
	bhD4R2XcCOGORBkbwciE+QQ6pHfVHEPp+vaCb7+NXY/0wnKo7YTxwBtm+O0M0KCfJSPWCMqLoHi
	9jzcjbazh4s4WMY0al4/1xfiufChf35sCmS4qyCMl1tJOSCLFFaEF0KdQMKolnvQ5nzfpkyBBUu
	lMO7eDGJXRhWm07M6BN5dGSY/WiP2ztGk7WznJMrRhWIyJH+9ekgx7i9+21RVOROGRrg8bOBhm8
	8xjq/HKWcl9izuXZaa4VZcrV2GCbaqae7ORt/RKbOlh7YlBJQu1Xi/JJPFF5J6kX/maYvLhcYmT
	nJcVU742VRlFImtSmPff+qTiNolLL/Bl/o1Hb9YU6YJJcs9pRaRNXXX6IyaKyMQ4I=
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914773485a.20.1782921638189;
        Wed, 01 Jul 2026 09:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914758385a.20.1782921637397;
        Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:26 +0200
Subject: [PATCH v7 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-2-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: yRUpPo0hsQos32kgKiEHYd1UI38H1cxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXwYlT1UnPvNJN
 KIPdOrmU5n/7Ue9ZvF03f36HU0b0ORhO1+i86IvHXXxtTPs6XYgvOtroONa9a1M0l7Y59Utwo9N
 /bdDSYxNMXlO+hzLYu0+SOGeojAiwAmrDNx590xSxldg6w3eJa4HMg8v3vP4MySv63PqCqjtEeo
 iwa0kCfryi1GIKmI+2tPvlK3z5dtBKwQPyMBewKhJIPtVYAcuh0uqkIEnJ906Q4BLUsH57kox6F
 IGxdaonscXL8JtsfVPELdsWp5IKXVn74p4P/qLXWL924luaxpZ5XfTH7ClqhD5UKL1QU4LZP6p5
 qH22SaX0kP/NgXXUeZsB6RHYn/BCH5Ek5aeSLdGD227HRCKN9DTr63SWCWFdmjIMKbbmPrFPtf+
 Gh6gSubk3MzsC46+15o4sUBcPouAEtA6XSWIJENcB2hxxggfhJkJWlI8Cm6jhalWB4suT0ddH8i
 qOSDNuiCE6Y5RkGbOgw==
X-Proofpoint-GUID: yRUpPo0hsQos32kgKiEHYd1UI38H1cxR
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a4539a7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX9H/Jp2ZqxRBq
 qlMeNZs+guLAgd/LgwRydWhNguIXSHPi3cgYW04wqWEqv+NdbHLXXjl55UYCYj6nO4etWLI4zYO
 N7qcPg3JT/0ufC+JAHnQHG9B73rx5tU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010169
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@
 kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 49FE96EF7E5

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


