Return-Path: <netdev+bounces-303753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t4B9KF48RWo49AoAu9opvQ
	(envelope-from <netdev+bounces-303753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C816EF927
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NbIMQfWk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KA6RrkJn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303753-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303753-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 000D23120434
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE94C0410;
	Wed,  1 Jul 2026 16:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944084B8DE5
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:00:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921660; cv=none; b=lJ5qUq7PmMvJJ95CCV3F00VyXe50Twdevr0/BZiMQHwSSEIuft5Gjkp46Ic9/ZfCc/zBD8rNxKz8SfcVAQLt8uV6Ndt1SqRy0DxFquF454MMZIUYmEQAxmFT4UVuHkSW76m1urtKo4In+AYTPEIFeUWw1FHCq6CYnRsTVuQCDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921660; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttnls4HLxMJG0fOBcOYGbwDosHNZ11VylQ+Bvv7ZUfngjJK3haMS6F73E9DivifNaqY1gWRkGxe+DoKPNyf0V7/73EZR+pnraQIN2nT4LWO81Yza6eOFSiQqd4mTAnLPKEoKAi9ktAEQrSaSlnb2mh6fxA2Xl0G4RzOC96IPObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbIMQfWk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KA6RrkJn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo9C31429034
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=NbIMQfWk/M75Jc/m
	JJcsFsiD2oORCimjwwYEEgLE4CCbKa8/jk6TtZTAo2x1Chq82xjvwdmFs4twAiDE
	VmDSeiTYXtYJ39ntpwwchbR4xciMLf94auLLm5dXenL6roE2PUu4b2pcjDlKN9xr
	Tmqt2K6wYY4XM7zkpb8EEBtYVMordmmk8cH//v311NIYAS4Ewqa30tp56XPJEkxp
	NnUVh1GPoJ9JUr24MaNvUObsxb/pYWhBmwiTgocSru7GcYIPCxOqTEcs6tMXN12J
	Yoiz/RgXGsjpYOtHtjdn03/y2bD6I/b9+OrJm8s54ZTFl7pmFxudXQyCt6fIC9on
	tk9Efg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q08n6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:00:52 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ead32f5c6aso494694a34.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921651; x=1783526451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=KA6RrkJnTyHoHPYI+hfTR7pFERhdOFtuvyTY0lV5JHAoFBmGbJVvRkGMk+pS7SEoeX
         Khl62tzOoTZMIzgGy71XdwKNIymozV+VotQah/SWyOk5wCk47kqRRLXnd/KjNL0myfa4
         1uQNx31JrllaGWaDUebASzpzUug3CA6bcJwcZ23luvVdyMmg8qaWZfgjd42vUpZVT+R+
         aqtmHapyfDk7CEllVTIRpU6hnMH2Yy2moLWviZGLM3iiNbYwfxurxhO5Aeu8dQLiXLlk
         guwkgD8RLbJPRceNQdGA27cT4n4PWUsaWlHdCpz4m4FybNyFN1ESiBxutSqNSrwKuibx
         COog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921651; x=1783526451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=sWFPvUC2jtXgchNTfRKo6it1AcKxHghMGssbNIlkIpAqmDv1tVl3tjFYnknkfGOKls
         nnaUC4lYTrbX+Wi+3srTHSEbzL/JRVzOF3Gh/yq0V4y/HZHdAF8Cb8TM2HmNMaAiJT7M
         /HlOVHFpCIPgPtlVqfTPZIVyhfsBLuVddc1gWvdwHjD28y0CNufquTW9WZ7uhunXUWcM
         mw2YiikHb8ME4zBlFnDHjwMK/JplTgO0tWmetDCoqYM8DvZlhSaW9u6XZdgY8j73aCJo
         aSgHynBi2o3WWK3MM2MOqygYcMrxIshpSs54F8lmH0et9it1Pl/Lb13+djeVmTSMN+xV
         WyBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dXhqnR2idQvogWQwfTbMVBEKStk3Wswq8QEGad1LcjMbefV4zSPpeDlsUc+9Q36NUhebWjBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyepc2H0eKJeos3cbUy1ew6UC6RmNZc2Ti+PPt63FLHSeRuLyy1
	Wcp+A+fkn6jgSYteMeN9sp/i9oXFgu+LMdQ8IEnDOtFA+DGJZDUYlbMkN8+EAWqEtFOJRhqOACl
	Y07hqu7LXq4kx9ZgNvBxZuXNwq/LnPIFbqFDqOzpOmxSbD8yuu1/w5eD18cfzVVsdrCrxxEyV
X-Gm-Gg: AfdE7cmgVmGZv3x/bx9jfbGLQ3wFb1gRtxh2M8mLTRBWnq8wuO5QKdPBkSHb/SdbH0t
	Dx4ejemlXo8iafJECGxuHuFnZBbuOfXMdCwQJlTd5aRReEjPAVp43bzWwT+ZOQtqAYv7aPHfnZs
	NTIE3mvP0IpqQVGfSsfU3NFKwANjttDfPC4DS4ACWN4tshyKn0DZyaUzuI82UQZ66oXmSdPClM0
	RDGQwd4kZlmqWDz4n3CxNcO+jlAURAD+QkwY/ALlB91JsBMqtrtfE8XKbb4UbDFRyxwsHFRX6Hi
	nf93mxxBtH7f/+qrUVVAlObNlrLuBzr62sJhxBT5iFPhKzWqIjFFKaWWwXoxMde9SAAcq5HZlTB
	LEqfwQkICPvBkx+UaL0eHkgtelwL+0TlRD2O/loAm6SPO8FTvHUGZbR+bPZ0Dl6upUZMxOpSEvX
	wa6jirG9Dj/YeJ/qt4zmy5VtZspHHRjCexTHgSPafbn5bur6oNZ1CM2sW8bYB3yNg=
X-Received: by 2002:a05:6820:61c:b0:69e:3c9e:5e82 with SMTP id 006d021491bc7-6a309ae449cmr1112363eaf.42.1782921651415;
        Wed, 01 Jul 2026 09:00:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6f02:b0:915:afa5:725 with SMTP id af79cd13be357-92e78206c88mr299831085a.6.1782921639993;
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:27 +0200
Subject: [PATCH v7 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-3-3fe8205ef0a8@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a4539b4 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: mr8qbqLEwiHZ1Bg-bIMUAcVd02WqkXwr
X-Proofpoint-GUID: mr8qbqLEwiHZ1Bg-bIMUAcVd02WqkXwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX7bc6UboEd1gr
 nOSmeq/7Y/bjTYm7rX/e8AFDYSNw4ywdhMcuMZhl/EmJPyDBgmqPtQ0t5i7mLRQ08hsH26GzSwx
 sceACl76ArxLXPODjBTj0NkM4ELTPpOnxKPb+Fp6AoJgAMjaeHmWrg0cKAIhHCoNXx6mbehxH4H
 6Zd1BAk1z/PQNiugh07VaSUWzk5jTlSHWlfQgybp0TvfbEApv6kIH8tdGV8+93SwJnSpW++0cnE
 X1GEJbKlVxTjznBgFg0/gLrlMNQtfd72p2XMgtYzMVXzm6LDOdQfX7WfCx3g7GVgphx/KFhYePa
 Jk+7Tb7dAJZlFN2tjjOC9JhfVO4Y6jT78hFNeipKfUzXEisLhXc6f5nrbNnmITjfF+HZb7iNptK
 4sJK9v4qEIH6UM9Vk2x82c92vEy8kbfSAA/ERZVqN1/j7PzkFBa4IhOULwdXVeKtf6v2+F0BGJr
 AtTj9ZH1SUG617iRhZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX6luoSkhWhKsd
 KNlitNc4/ONtEUjZmn06/AtiUvT4PGhyQADrCRl1qLBdhYHDF0x8kCaieGasScRxwz09LQywng0
 HSun7ttat05wFG6ZC3uDLLxdw0ayyVQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
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
	TAGGED_FROM(0.00)[bounces-303753-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 43C816EF927

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


