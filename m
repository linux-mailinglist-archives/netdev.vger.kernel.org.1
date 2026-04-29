Return-Path: <netdev+bounces-282348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEO3CALj8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E03493309
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7181C304B111
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566D3EF661;
	Wed, 29 Apr 2026 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5ZipRlX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cG4e4vzn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD53E1D1B
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459936; cv=none; b=DYKzVlU+t0l4FbWb+gZUTSNZjB9ST6tN5LKR6pP9nQOBwV/rEsrI5yNTfsNWH5dKq0IEtkaE9bPPWxNE0yP9arpw4pRHgUFhfJI3TGzIvifhJ31fQY+6O5cSspOvvl+RySsDapCtO9wCG4TkyPCBXq/zvbccrk96Ysa8vpg9MjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459936; c=relaxed/simple;
	bh=oc0BUGs7hxS62BzdR38BKFZMTtbi6X5LksJcvy7Q96Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAcRKFDWwpPwoGDVJrqHkCdQ6VtvS4lZ8VkJWfmuySpgFmBJv9ncNhfdOFvY80FLCaL5C2G2gVI/qyifSSL0r7deWVy5YVRvKdz7Wp4MzoSwpv/71+E8P0A7l94UYowum6/lQSPEG6+7Z9v/rh1kj8FMGjK6HbYh2Cuq0UuuTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5ZipRlX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cG4e4vzn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qcng870130
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U7L4L1oR9Ld6c0Aq902NuNggR2GtSSCW13PbHPuvGbI=; b=o5ZipRlX27n56NGC
	DVsDVd6fOKpSkNvWWuJ7eHNaCFX34RFJhjGjYCqRMReuBnGo1CPC9H2MF0KBN/aZ
	JaIeuSLvhmmXlkOTenPBcPHmSJknxFQmGpyoupI1bK8lwEuPCLV+TNBga4u/pieG
	S56BUHGfS7DE2xhUKfPdvN18vnByQX/XovjsYcyY3Yx4RC3ga9bBDwvOYKQ6qyNf
	VoSy+7mosFI6ZrmdBJ2mcYPcD8T/WvxMpghgAAIKCY7HzwnymeDwzSqK3a9I3dkg
	OD6kiHY1vTpVoQX+O/Ocm9NoeDGyJVntjVFd54keW6lzmthEd7Lt9AN+YseP7xLT
	Srezfg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0u1uhwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:52:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b7a77b8ec9so27397655ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777459930; x=1778064730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7L4L1oR9Ld6c0Aq902NuNggR2GtSSCW13PbHPuvGbI=;
        b=cG4e4vzniMcrxjx4N6f5owOAqodrvehembO/4JHjIjmsguG12hEhrQHxdxO9xWud4D
         Yz7in4UeY1sO/9896Z4YVYlrMGd86KIjYWPoUl9h3CfuU+S40LoldcsDB/5eCU4uo1zn
         y+egCyGaJyKfFDspD6BJHCGBRxT4i8cqUPvsw2uH7BXy79ZxZdzFf46hPzSMCDaNBB3o
         mj09zbSVAuRA9eTaigv4dfGK6MhFyjcL3YGGSHDmSwV+Po25Q/Ru+XVxHEqqRe/i1Dgw
         47c+fKokR1JNKT+WVrGHyi4dTpiOEtyIAyz3978S9GkNbwGTRuOObW4U/keMYQza0GFh
         c21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459930; x=1778064730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7L4L1oR9Ld6c0Aq902NuNggR2GtSSCW13PbHPuvGbI=;
        b=phwN3ldnY78nIQ42cl9SlF7wA6dsREtaOSltx/MezNCcRJpAlqu1TDMaDupx8JquKB
         ISafxVKEXcl4pKd8NwVR9WTHmYcqvhdPTZUPUYLGlbnNa5NRjPG4+TsXSf+Cl3Ertpyi
         nHxd0r4FpClpVshK7Cdnr+EcZRlIEH3c5lHwiwPs0+1MTnvg83tW5Ag0pBwe/dKc5nEU
         70nIJHlD6BQfbFJ4YYbHF8ZJWQoLdRs6JcXXhMHI6Q8ph9j9HX7t4KtTw0vsba2EPyq8
         wGzj4GG+JjALTaw/IUhFU0b1B0QdKMRBxxQpGNz887JUwwaFlOJagcT7x6DupZie/n0y
         NLHw==
X-Forwarded-Encrypted: i=1; AFNElJ/o4zRNJOgl/R/DM6+fVHYc3x0qWHTvG7Q/BA9oQwLnHtPNflU9jp/18TBwtabBW9g9NajKwZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrtRu3Y2ZSlgHe02+fTHjmp6gjUPKmZqDchZk80jKvdVzFOAD
	yYPWcyx3Eii06dEQXJ7u5DekWEP6A8V8NsZFPGi2m8n83lx0SDuCS1B65g5s8BAQ69+Re0wJauZ
	Ol69DTZnGsbBaflbyYuDawCNCS9BrVoHOU3N4KfRsIeTSCCcFD6jkoPCcZNo=
X-Gm-Gg: AeBDieuhEkw/hZ9ttmC94XRM4JaWd2wY15NLtvOTTxTG4NSHbhEJqEsr0iVE5KDs0QQ
	OXzUv5t0VmLQ/nPjxgwGCgtYyC+q4R2ayHPCV1h5IBthFyP0+QVS7KbQjXggx+1J4kvz4nEbmRn
	S8tALnIEjwagWLCGWrp/HtAPoSC5euEfXUfMNkAUdBy/v9vStMpl5If6VSsyNOnkgkxWlwrLfdR
	wBatpySJ0MquOgNKB9JZdq1WbqgpJvyjlMywXMEt2QHV9oBOurSC4YXUUDunv3dDSbk9sqw1TKR
	vGpvXHCNRdgJVoncN8u2KC1nPtvDRxBGt8Mbk3Q/kJwaHAZL925ouObKqqkTsbuKFhLXrTJAuJM
	FWAgPxCBQOGBbh6h6UhBDjjThCC+r9ijQge4vxzX+7t69XVNalVIRmyJKHfBJVj4=
X-Received: by 2002:a17:902:7b8e:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2b98730cb97mr21791955ad.2.1777459930293;
        Wed, 29 Apr 2026 03:52:10 -0700 (PDT)
X-Received: by 2002:a17:902:7b8e:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2b98730cb97mr21791725ad.2.1777459929820;
        Wed, 29 Apr 2026 03:52:09 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e9csm18316715ad.9.2026.04.29.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:52:09 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:21:49 +0530
Subject: [PATCH 1/5] dt-bindings: clock: qcom,rpmcc: Add Qualcomm Shikra
 SoC RPMCC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-shikra-gcc-rpmcc-clks-v1-1-c3cd77558b7a@oss.qualcomm.com>
References: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
In-Reply-To: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: TN1TPsVeLwOFRyOEFRtmOQyC5cjvQPX3
X-Proofpoint-ORIG-GUID: TN1TPsVeLwOFRyOEFRtmOQyC5cjvQPX3
X-Authority-Analysis: v=2.4 cv=aPPAb79m c=1 sm=1 tr=0 ts=69f1e2da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5MG6tTDo7b5tcJehnegA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwOSBTYWx0ZWRfXxk15wrI4eW2z
 KZAvbQRYGE8UGDq1I0qRXZkwC7h5O8CsPpgpKVyKN3s/zJpaZBz2fbrK59eZVzqEWQM0Fy1wXuU
 NSHOvyA6ic2JIxVOFxT1j9iX27BRyW+d1IkNx73gfJ2ck02nWU6X80gdO5bqpnqVnQu2XE/4+ua
 jJDIbumrZAxVCXhfCJdneCg8Yf0IpUbz7zVRRm+S4+SjcsgYI3Dk7MVviEtuhd0/Av8GvlhaaCf
 NpmWn1X5PTbpMtCDD6jFy55+jRxJyjMY6y3zRLVWlJ8HiRZ7O+FLGJH1tgwTjqyxKL/jHwuBARh
 q7atnbcejBElf94fISSKvKg9lIDoCnVa1KIIq8OWMcvv0YTOvpmtl/JrdzdKk/x+E6zdQ4Np/jE
 eQBz/zYbOmKThsb0xvJN1akkPrzF0aNy2WZ/v4UeEwIkljZLEsP5n9RPzyGA086JaY9ALy4sAFn
 0b//VauB2g61jHYjJzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290109
X-Rspamd-Queue-Id: 87E03493309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282348-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

Add bindings documentation for RPM clock controller on Qualcomm Shikra SoC.

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


