Return-Path: <netdev+bounces-285626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DKPIiVs/Wm+dwAAu9opvQ
	(envelope-from <netdev+bounces-285626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825A4F1BDD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 638BF300C3B5
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88E3328FD;
	Fri,  8 May 2026 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFJWA3Up";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hFnq/31o"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741183148DA
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215941; cv=none; b=Ki+Hnw+/sj9uQxsFcjkBnGN8NzIMDUpT59qt57R4PCkMyH+MBKWsy8EAqaVE5/xODhUvLi01JZ/G8Y/+x2dHFb+bZsL6uHvuvlusaiXA8STH3oe4LHGvxsP0blYoRGmigBea0SimT9oC2ghhERNJqUS/zmnCGHjq+4ajZZazfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215941; c=relaxed/simple;
	bh=Qt2kstaKGrB1yY49mZjobtR/4AMzw9aIfR3UkFARmBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwHrSrNxPZ1CTX44LFuzjRmlm9oMKjbkDGulb0rd8f58dvn0HkOfsFxqcVSh68vJfy0V38QXyntXVmErlzYTZVIpujN5z4O4YpLcodukv5HAqRdSyoU1dMRpQR8t5LnB1bVil+ti/lh//UBkYQDVpGdn9xLXedqO0g7k4v7zuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFJWA3Up; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hFnq/31o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64824A1V2384187
	for <netdev@vger.kernel.org>; Fri, 8 May 2026 04:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqRYynkSRgvqP9sDhmtCs8Xxd+0USAewY/2Or+/Dk4Q=; b=eFJWA3UpOLFMPxJ4
	Ir8qOLBkORFa/zuVlFVa3FbokTkmRKb5qv1IlGANc5z93pBG5snwJH/a7hr24Wlh
	6E1obx3RrPmkbSDhejKuGrga01HV80AtCtFhCAGv+Phu+L0hkjuOlOANNce8oWqR
	rWbRlb0YZ7c5AeRqRe9INLOyrKActikLz8xGVofebTjXrOJkWQFcCQ3Dj+LMH+0v
	kNK/pSF5bOWBygHVAF7uK3gD7H7Pl9eo9I2+WZESaZYrmf9fqisKdl2s6+lY46OG
	7DDItYB85CB8yeah9sW3+66wJ+vZs+kCbzZKlMA2X9hIRq3sQ83anYQv4E+h+oU7
	0ufEZA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0wwujcgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 08 May 2026 04:52:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-364c0e269e5so1900947a91.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 21:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778215938; x=1778820738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqRYynkSRgvqP9sDhmtCs8Xxd+0USAewY/2Or+/Dk4Q=;
        b=hFnq/31ocPVInswoBBoHTBT1/6107Tdb5+9T9vcX1eUlM/nolJcNBBENRysg1jWXwG
         mZyi1bfz8LEEUZGDQxWLQumasR2MUR70Xp7soHZ90lXNCAjSgDVYBLDrPIlPMP0yjBsQ
         HiTXb0Z4qj+eUQmnPmjfybyZXS2FCuOtvk3gZ5MWf8JSoa/ZWgPNNdkiEOt/I5Fu0Kwv
         kVQQ2+PX2sIReylV7WPScRU2XVDWoTYOVOBalzIhg6hGR9y1kHPoldLhWD8TFpQNPbwJ
         L/5+cUyTKSjK4z8XlFOvXj77CTZC7gh6+w03NKitscnYj/QKhQunpzUYqvqJUtx1rhQk
         AW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778215938; x=1778820738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqRYynkSRgvqP9sDhmtCs8Xxd+0USAewY/2Or+/Dk4Q=;
        b=H8Vcp2AXa7A69M8w/7/ofWSVNZ8AlxDVeE9xKrf79CLUkKiKZ+AHDywBzQPGCa6qKs
         Sc6d6ggClHhTraejpMtzifOyCrXTps273qFdDXvojZKlhp+3bodbkdiIf7O+NjcjNmx+
         KIxFgnpOISz7o1Y3mDQeE5jQL/gFPNf8dVtbqsSFzNxO4Xys1GBNynu44pq8cRQOQDUh
         e/FcyblmZDRcAcHhn6Md8PqEaZFD1CltbdnMwKFdUmZt/0oGE9smyfPk4/FUN1iw8WID
         vZMZjhCyv7pwHrol3Ep30S0o+VkYyl9Pagv7oFsbGfB4WCgshkyxaLLZpQlm3Ci+2VVF
         rqUw==
X-Forwarded-Encrypted: i=1; AFNElJ8jS6spMYVY42vNDX6GLVtot60ICLh+7psVXRABi+wSHzrirIbHo+VwEtzFsabdWsWJLVdZrw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVuuidLZCDxMaVIv5EIkS8yYv5pMYSIB9arld4lBzDgTZ5CEk
	X20gAk6gKSsxRBP7sx3vCZwgVPfYPBuUiJWEOSux63EwuDwXhJtXBvb1mCa2NVPTsXXxBFiDcDt
	QZsK8ELdUJWqcSTNwlNfUhdgVxkA1sS16kvZdvsJcizBDPrrvwF0inJ0y6eE+AQAwA+M=
X-Gm-Gg: Acq92OEELvCwkvwJOloxAsbO8qVb+wcR0VthkbjkMUy2EuWFQVXhZ5w9hRdEMwhlaPx
	T199jwutgb+Jv3mnuuhaAnhnthh1BKmaGgatNAPgg63XEyAHFXvz9Kk/4RVEDdFA3cR2Z1B9lH4
	W2UXxvC3KwFdjHMn5Rq2gQjVLjPUyaIudrk1jTO1f/7sh2IN/bFqg1yS9RHTzGV6BdVLnayKWps
	uXvvJk5abjreEeYlcggrTRdP3YKwL9pSa80fAJF6rqoSIWgEREU5ohb8cX2pZLY02Zyo1OH/Bbw
	IFcjEtMxOzRAumlfHwBzKESKRhWXkgRVkhZ0LiTJrOuIOoxOQQCl0rJpcs0fFnMi9tjvAJ2/Wxy
	uaFvM8MOG9jCpu9t9eHHNiXXFLf+1RcRM8oPGLNLCk2w4B4jKQNYJ
X-Received: by 2002:a17:90a:d004:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-365acb88347mr11126706a91.25.1778215938266;
        Thu, 07 May 2026 21:52:18 -0700 (PDT)
X-Received: by 2002:a17:90a:d004:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-365acb88347mr11126674a91.25.1778215937779;
        Thu, 07 May 2026 21:52:17 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm556076a91.1.2026.05.07.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 21:52:17 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Fri, 08 May 2026 10:21:50 +0530
Subject: [PATCH v2 1/4] dt-bindings: clock: qcom,rpmcc: Add Qualcomm Shikra
 SoC RPMCC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-shikra-gcc-rpmcc-clks-v2-1-83238ba24060@oss.qualcomm.com>
References: <20260508-shikra-gcc-rpmcc-clks-v2-0-83238ba24060@oss.qualcomm.com>
In-Reply-To: <20260508-shikra-gcc-rpmcc-clks-v2-0-83238ba24060@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: TmGuDtw9LJGlvwb6KIYWTkJXSoR0ZP2u
X-Authority-Analysis: v=2.4 cv=Nd/WEWD4 c=1 sm=1 tr=0 ts=69fd6c03 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5MG6tTDo7b5tcJehnegA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA0NSBTYWx0ZWRfX5xFbSPw7BkdO
 UFSfgiLCPdBD8w57foh1uvf6iODIurrX4+jAaTukJBo8OR+rx/oUB4433PaIFJyyxwUusLmMb+8
 wyfE5zNeWGjiYUEX+EK3ZO+K1hw7pKwP6DXExJq0Ljv4q9oo7bUE1UPnZM4DQ0rGuZ7fdFtXrVZ
 RuAQHpMOyd267tSzBjdsTqKTsSEiJnWMK8kSdbIYkkGqCM3kN3EFFUDCfgRalUi0OMY3QLEGRy0
 7SVkoGhuv/r0r6uI4jzTb6ACoBb6z2QEBfqmavnum8b2XTeKDkaH+3QHC7B1YPLIAQVhkek3eXb
 ROszvIxT3TvDkjj9ekprxeKAiyx4MFQ5v/D0Egme4lmLMS/246uIfgn+oSb4B3pXBFDam1UwwGP
 y47I6Q6sfx5CNHWn6LQcjpNvP4EgZcetSlaPJqzpYfY8KWTfBl7KIIrV/9hxd4jL63TshVeiSVW
 lXBifh69B8rEEamSllA==
X-Proofpoint-GUID: TmGuDtw9LJGlvwb6KIYWTkJXSoR0ZP2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080045
X-Rspamd-Queue-Id: 8825A4F1BDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285626-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


