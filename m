Return-Path: <netdev+bounces-273730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJCKALcWzGnfOAYAu9opvQ
	(envelope-from <netdev+bounces-273730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5DA3702CA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF0B3069748
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8438F62B;
	Tue, 31 Mar 2026 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CGAKWD/P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvZ3LWQY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83438F64A
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982705; cv=none; b=X/XOuisshVaxhCNKGqcluwN8OjGpIdjIy5gQUKO9uXmhqxE03LdydQsaTJPpIxmA5CSqM7PKQeG8SvqjtLqiNy7oSQ2ZtYc2ptN5kmxLz/nbPlNNayfw1hCY0xdUqo7AVhLJTD08ontFLzekIMgYNwNeGeBHQwD40WjJn0LB1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982705; c=relaxed/simple;
	bh=7/65ePqG4yopQHr94k6g8n5+V5JBH1uc85cIWa4Qvp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3olBlpeDkcVoqJVbRTveXNzoufDXTRtaCjdI2cNh3VSlpLqhMf8RNiQMKfKqMAY2vuafHucGyrfYnPDTRFtj1YVCX3B4wQbft5W/HxoiAJB2LPaIswiGcE5n/bnCmlssQuJkZvc5w35wOomQdA2BN/D0QkdfS4DFRZGTUGzhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CGAKWD/P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GvZ3LWQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VGdj091056471
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ctnIgyI6jogPY+2raF43nSJTPOcHOKf/vME6E39VLU=; b=CGAKWD/Pp1Vf04FB
	PPaW24aOvCgt3zOFzecw02ZkjWXgzW90VjcFgyiy3Z1yL1jp2abfjeRzi4DGBRDr
	E4qnIf5EDh8jxidxq0yqa56ZTaF8S0DQs/Z2oEq/rh//JAiDCmQnwDOhJanhSQ42
	Jhj+hf+aK3iiBvpu6VCnTA+6pYdnHuMfDJeg98OlfFzdKAMvo+0ehwlaqwyrtt5p
	m9Imuv4GNqmUB0OtLDwaO5ysMQ7WrDfSkv/NhqgMsriRgXBJm72eRykzZdgiS/Ff
	vlvqQBm/H/O/Q8JoQEtfD7DmSxu7sRi1bKraw58LXDBfy8BNpezCLglTI1bTELPf
	pFlzXg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hevuvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:45:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ab344e3164so16678385ad.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774982702; x=1775587502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ctnIgyI6jogPY+2raF43nSJTPOcHOKf/vME6E39VLU=;
        b=GvZ3LWQYLsTW495lbP0Myd+NFtr3hxnlMRkP1q1MhyCskOLbgu8hSxQI4LCvpOuyYo
         6yMfOJggMZdgdzPH3HboqQyu+FB3dzmf4zzW9eZHsRFDNFnXTDsGs3ne71a5rqr6xM6r
         8mpHHU82tQtJGwYk2ru25IOFB4IPjLuPTRqSyBevT7Fsr30f2fF8LH64M4Wc6W49Goc+
         aWqgcxZE4MC4aDd3ZFAkQgd/cGY0tzsdJ53RTwhoY96Fjnrhv/eo2tcjYJClFoeUSbYe
         U/MdUrnzQov5Qk7aQGMk/NV1oSWhjlPrJJE/0pOLm7nSWPKDu3Ijt0G4OnjB/M/f5/+i
         jQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982702; x=1775587502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ctnIgyI6jogPY+2raF43nSJTPOcHOKf/vME6E39VLU=;
        b=YSv0WLBaZYAK97Jip7hRf8XpomI9YtoaEjGyL25CaZh1tQX3krmdVg6K+jrWnSWUHl
         wllF+d7ncvchWO978PcOkcsl5eG/XrP78FTp3dYvXr/dra4HP4+njye5oI1dL6viZq2d
         rvlRr2oyL6sL75OxtGO6WC+i2KkPwgh7bZhAvE4LmrG4MB1tw8gvCVMFfP+7E6iLiJ5k
         /8L3CzGY15ZADjOEqnOHsyeGstPRhCeNFWnRlzHywqQN70q24RbGBJyBZGNUy8Gqsucy
         NkAMiOQ4SQCbyyR5of4kY5mAYob1YLFZBSJijs3eKrmBDmxpboY3uBnDqJshMDS2WPHF
         rXKg==
X-Forwarded-Encrypted: i=1; AJvYcCV1PLVMXC29c630XFnioHkEQ9UmhBFigzlU80iZ6f8foKoNfB46LuyIS4MbSkK2JkM7iGhwyMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVDAfszfU2QbEmWeFZSto9fK6bAdGv2Q6wVOelAP0YJ/SMkw6
	hSgniMVW3KuMw5VwKrbjqpv0+4wapOClrcB8jRzy9x45w4G71GS+2aEqEuvSln1gXajBo0K6DgO
	vGLtlxy/u+YsrClO2fOeTt6mdBPH/GzeeMwqJAl3WU7XJH4WoFEvqcECbx6k=
X-Gm-Gg: ATEYQzyo4SlhMdCWbGYsGMlaiChHuju+ZhnJM2+Fgoq8OtoLCbWMDHNINdQYOg4wzvD
	phkUcLlmDYQNCxqQ2SGDd9NfxVT2+wgzvMH+D2fCU/QlM/ONPX5CO8YzvR4Mk27erGMQ6CrXrgT
	Mju/i22w0uhgwB+mj+g3ew23GMX97/fQGK6gw9OwqUPs7n0SJjW9gBieK8lx8e9PnV2YvUUYaP0
	TEi2Z28v56X8ZnM4dEU0DHmUSt2eDKhxIrTihqSzAQULzjVqnniw+YadEzEErAofedzwewDw3KQ
	XEafuAyld3R9zGzG5b5nMEZsWn/t/TXeLLCB+Ig2Y8dR/MGvUrp1u5ClvITqRKQDAAuP8jR+DD5
	nxMIJ5JaJG8JgUZwdHSM86N7Ra4w1rboDR9BBihAXzy5cZSEJCWsX
X-Received: by 2002:a17:902:cec8:b0:2b0:c355:7d56 with SMTP id d9443c01a7336-2b269d42201mr1479945ad.8.1774982702265;
        Tue, 31 Mar 2026 11:45:02 -0700 (PDT)
X-Received: by 2002:a17:902:cec8:b0:2b0:c355:7d56 with SMTP id d9443c01a7336-2b269d42201mr1479775ad.8.1774982701751;
        Tue, 31 Mar 2026 11:45:01 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427af930sm153284635ad.70.2026.03.31.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:45:01 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 00:14:42 +0530
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add monaco-evk-ac support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>
References: <20260401-monaco-evk-ac-sku-v2-0-27b5f702cfba@oss.qualcomm.com>
In-Reply-To: <20260401-monaco-evk-ac-sku-v2-0-27b5f702cfba@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774982693; l=778;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=7/65ePqG4yopQHr94k6g8n5+V5JBH1uc85cIWa4Qvp0=;
 b=B8M6P8m+WrkDYks5hvvAEmHhrEiZmQQsNp6TqbsXUVmyPktPEmcjWqB7fMvcUGGZ4FaFLd3Ud
 qagim8WyvJPAy9aAnN8n1154TdD8fUcCYBFc9kCAR7vk2s+wnNmY/7v
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cc162f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9DcQwTZnXUZXOflEe_wA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: cpdEpDnrMZWcow_3R50-sK8_5isd76-K
X-Proofpoint-ORIG-GUID: cpdEpDnrMZWcow_3R50-sK8_5isd76-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE3OSBTYWx0ZWRfX55Vd7qJUNUA+
 fgUXpOmuD5OJ9HJRJ3ghdUqb4SObxhjFn4af6n9VtptN8BdGp3z5wyRX3b/DXKaqsV1W83Hn9ll
 Dgy82qjd647zTyVt7IYtUo9t07i49FV+fMAyl8IpjBGsoixD9c8TQVddP+ieul4X+QTRAHVwkAu
 6+ZHf2CIPk7S6BzKYFIh/iJCpw7JIRk2zctTK51WtoqCoishMs+h1PO0cLzUeWn2QsxwvwaYTxP
 gqxQSNXVKMRUzadA9keB44HC5EE5zkHsq7JbbmuCC6RtfVOgZ6HAR8covgYbsF+cyNe4fuM3k3B
 B/glYhI+XGAKfAhWz5FQt+C0VtvlqSgt57fAhQqqG6bzKiAAIdhlkh66Y6jLgh26MvWvcg0xOc6
 RdHNpsdUJ0Lo+4MHuINObRnb5CsDOTEeJ9zItakfmcIHNNXJwFdM6FeeyLnvMu49YZ5zU31gUxP
 6bUe/eB8rhdI9Um/xEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310179
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273730-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[umang.chheda@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E5DA3702CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce bindings for the monaco-evk-ac IoT board, which is
based on the monaco-ac (QCS8300-AC) SoC variant.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ca880c105f3b..c76365a89687 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -918,6 +918,7 @@ properties:
           - enum:
               - arduino,monza
               - qcom,monaco-evk
+              - qcom,monaco-evk-ac
               - qcom,qcs8300-ride
           - const: qcom,qcs8300
 

-- 
2.34.1


