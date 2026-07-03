Return-Path: <netdev+bounces-304562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id puWGKAnAR2rTegAAu9opvQ
	(envelope-from <netdev+bounces-304562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:58:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A39877032CC
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:58:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hQrtxPOD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TOKtYeMr;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304562-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F72D30314F0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E93DA7E4;
	Fri,  3 Jul 2026 13:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B773D954F
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:45:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086326; cv=none; b=dsneRMx9q26jlfWJVeqJP6Ywh5jBaw246Fuv5YOp/wtYBnqO78n52H3u8AmFA+keoK/mUaulfccEJy6ezkKmpYc+Jl6kA1PxNc3JBY2bzSzcS3ugIKYopo44va8T9lZo2M7e0AEe1RJOcCST890UVAMDmefCMkEoyuKmd/7PeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086326; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMIjK3Zu8fPxYYMnMKvlvePgAoUA6YFvZeC5j4DmsRCe8IVufrppWgW2V3li1pi1JKhlUtPLxOxU9dxXRkJOtKpacfP1ljD1i3/GATIIJSabCk6Q1QUhRSUsJGR3x+pxoC535ifHW4eCBXRx/7+tNQ26VKs8dcet9n/AFevhYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQrtxPOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOKtYeMr; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BIlBl3136392
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 13:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=hQrtxPODMLsXzsMY
	Ky5XzFZLaa3/GdOLddqzgIsN/xncfImwxbfBYVyirfLaRanQ7XhsJPPXlbI+INlN
	tIDpj0PFEJTAwEnsgD8ry+vvE1MsWu/JQlvFKtOOFdjREWPhWKp6uc7ZrS9utKIS
	7fn7sgSTRM2nIzTbg7YN29v8K+NEHXAR5FoZL9HUF6CJeU09thBjQ0lONiFfmqJz
	blcbppHE9CUzXBTG9v9d/fCpNnbQIjj2NYW2W96h3qHVRRi9xqb2BixqfPpbHKy1
	SL4hS6mK1tnDjr6FwfQV1/cUBhOQScj8Ym1n8gI5fDPIbpCo4QQQCvpgIOZX3CTD
	3jcTJg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5ak3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 13:45:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8e97889ac8aso7290276d6.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086322; x=1783691122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=TOKtYeMr5Ig6yhlGAE8TelGEDNL/Q+zYAbzjVFVhO2h7zIiG81Wvkd5psLgjklAOKa
         yYA14KtUGQ9r36jFOfdlDulaMh472LHcfqzmyGfMox2KA2n/SLiRSerg4g9BiY5pyZ4g
         KdAHXJTeO7Zb5t0L8+rP7PbhYSysjLxcqvQJMENNi1dGyKdJRHxC5i3M20P9W1ywRcne
         qR/RF11HTRIynDKfUAgTcaqRPYUWacfzzSK/vYJI8VVW7em9GYjVkxfnQUiFNa5WZQAN
         53LhvZUm9okUpaGMukm3vBqylpNyfX3MT5/DuO9lxXVbVZFY8S0LV+jzzBbp/yUYX7p2
         beIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086322; x=1783691122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=tNjdzli3sOf1t9+4j1VrkmQOvJs+HrH7cSpluVogXid97QBvLZtUsWOwE9VbjbDaXK
         PwzeuCCL7sJv/x8tBcPJwIunqOXZs8Hpj35/PslaEt5CssMSkOnqT+Wtpehdbj1saZel
         eOaek0DKS7u3Xwsalr6W3bSyQcjdTmMgK8Bn9nIQ/IW1H8zjfWGeRHCEAtto4ZOH1JAz
         YQjNhwsKLOXM3jyTDH4bxLn8oqBiP4WkoKn2+4fCMYniDXkyl/zZdctlg67iRffjSlwx
         2SG+VAcq6CS6RoT12nAQYHj28Tm2DNzH+Ifziu9XoJVBv9rKHsYNe370zWemKR9YnTIV
         XSqA==
X-Forwarded-Encrypted: i=1; AFNElJ+bKpZ/1+LaWgDBqBPQ+c4P2AjZdBdrEMj6usw5eUkHBd2900vgFQlC1u6pkY4sidrZm2Lh2QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RuBhJTXq1l7+sVmDp08UFV8vCA8N2nWjCLVxv66MZkQQiuiw
	8AgK6mWIRdiUYomsjTCUEvE8Dg0kbjy1Ixslq9CRL1UlIROmqgM7Q1qH7nlLJB2Lp/xaE/SHJeR
	3REeVemQ4eQQ7Ltn34MF6j3CEIt82j2GbaAUV+FTy/qgX1zW7hAoQwnptfJ4=
X-Gm-Gg: AfdE7cnZeSAW9kDoq5y9/eIZrC6GjNpIwkMngTQJkOCR6ah4uFP/y0s+58Jkx8Xfh+6
	cG0VwQ/ntvbkmx/EWQ0F4eBH+EFovCJldYjx4ZtqYAP6w3lFQJsueGQkyyDG06R5y54eGMJr5ze
	3rbHNgt9FEozBIwX/j4hg0gSKC9VwfRkWxQjEDIpAcYPYCh1HWhUjp8GBWeJ4+OMcspqNdvhAtm
	imf/eoW5qeQePdC5F0uttKaT5z0F/KtMTUF0F116puwg9HShPCmJhoIXAYzQj/w1z0oO3pEbMLn
	+BUOYLiEip1KvZ24WyOkbSn3lBIS0ZKxZOlq6eBbfQ+6YJBwKsT8w9ebi3iEmjeOz2RKx5mHShM
	62w6tXZEeflwxBmqkn3AJzRvl+RtSa/QAgpElaXjI8jqP7dYSlFQKdb2C5QFPz07T40yujtW2kn
	vBY1ptbcOg1ZL3JLV8kYP/k/3E15Cxq99dxG8V85Mb/ZouB4I4Q1KI/5Y1niRlLAk=
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr1486707885a.9.1783086321485;
        Fri, 03 Jul 2026 06:45:21 -0700 (PDT)
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr1486692485a.9.1783086320737;
        Fri, 03 Jul 2026 06:45:20 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:19 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:14 +0200
Subject: [PATCH v8 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX6Oi5FKQ4aN6S
 2hlEWcVoyLMg1O9jnBtCwtFhPmyxVxMgkJebEGVPQ/PluxjtaqXtmSN7IVOzz4vN5MVrVQtTpyA
 UKc2K2Zwq973y5dxwbOzwtDmPdq0BMk=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47bcf2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: errT-Iv4lG_7rmo_PS66KgBQj-YFOuU5
X-Proofpoint-GUID: errT-Iv4lG_7rmo_PS66KgBQj-YFOuU5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXzlapac+Esl0e
 aeDhnxgPy8qTJ2B2dwoMw3Eo1UjGX8wT6A4jA/O7W4bC/jCQfmkto6muN+QEHC+V1dIp09C3dHx
 SPTn8rv3DXwxhDnE+ZtZx2imhMGJUwZ6PjeNiZjLHMCYZAjiHAYAVxw2sXmjpixLhQYkrx4PADE
 9yIOfwYOem5E3nSpuDpYwqIShw7vicMrxxuPGv44KWcgXYCwnic7cXhVdw8UyN0Fqu8+O1VAZJH
 6oNfIeT5M5GVKYYda5Vmb61tZVyYFp42g4w0N1r/DSsVo6+Lt9M6HToE0kuHXal6Ty7AnP1b4vt
 BwjGiTWJEQrZha7T3eyZ4eWxdHjv6/hAoKL3ZFaBN0AP71IyiW0H1qwsAMX02WxypDMTMgyVH2D
 1IjvgHzwjgaSKi8IwyI4lEdu33ZQIyy7cvyqc2OZg7QDHgCvS3ujPHm07jaBKCYDUPc0RAOlePS
 yx3cMQrX8uVwv1pukCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: A39877032CC

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1


