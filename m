Return-Path: <netdev+bounces-304568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SUlWGM3DR2rGewAAu9opvQ
	(envelope-from <netdev+bounces-304568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB94703519
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BjEwQ7KX;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=H9HW25Mb;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304568-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304568-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEE4531A494B
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F403EB0EA;
	Fri,  3 Jul 2026 13:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29073E5ECF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:45:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086346; cv=none; b=UZirM6ZVrDCoRN0S3cNyzPaCW2thGb7L1NcHIVcbTcnc9rOMTUVnOD2KSQ3gjwaeER1KdsVM0XpTEIQ5M1ZsGB37baoATWCy99c5v5l0zw+m9snHcikVvxtRcKo038gKBfDMrnDltuZLiwGZwI4jaqy1yQ7xBRY6hU2dVVnZ8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086346; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZg/WYk9nrzuYGPdYxHtZMx4Kbwv0lH4IvWrPVy6aqem7hv7EwNDjJxn2rX8USmGuyH0ED8UQidizNSYG5dBCtWAZHejuCjfw/IUgxuob5k8MlQSRfUH4u9tuxRXs3OoQPI+CPMcJT6pK1Zg4pDdvlqL4XySjDSmKnln9jaBLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjEwQ7KX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9HW25Mb; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BITRV3108960
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 13:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=BjEwQ7KXV91y6w5K
	VaQIfEuSxIf16eWd1haiwUtC/PYzRYiVxl1j5dXjqMoCiigcwbu0X+8vL/TExdy4
	ZgaYvX3s/VjRfFmnLJ2HAxVpoT2At/uvdsGENm8WOfnOSljYzXiflbVP57mea2FX
	KnQYVBSaRc+RTVmHc1S5LvgQFioMJfP0+CNEuyaeFSePaW2SyzXcOQyNvMVcGtyj
	FwwWkbyB25zHbrgMA13dzHUKe6tPQz9z0YNucycudgyRDEQ2qG4QyzaE1Utrt5uS
	gNyLrQaSn/7xmzjyveth3rLNCkQC+OEimnMLDr3jt7aY1uQdm/4UCnx8933DfJ1O
	dXR6hw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybaay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 13:45:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e632390d2so104357785a.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086342; x=1783691142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=H9HW25Mb5w4bzpnA8/TdBbTr55d47alBBT2NFDv5GxxOqL2sxUtAhKg5p+5RoGS3Lw
         7DKeZz19g28LAcVhJ3zIp9b9gRzYv4E6CadRmZKC7wtrVQrSHnHPIwDXDjvQEzgrBOOK
         up3mgIXCr/nMXbh7FcPswAUY3UBuEmdD/5HI4R+aSpCA9YoOyUBDCTLp4kPpsrRCaRll
         iNF+6YqfXOItXzrOPcW5WGTIZJVDRHE1piQE+ADMH/G1AdUSR6CTNSxUIc07i41wuu8H
         5DRcUraomGGcwCGvVIdfDM2UFAtDCnOzVrU7v9Bh5ltY0ZDCb6S4PURQaNrh/P2W2dBN
         Beow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086342; x=1783691142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=YiSZUqe74DPaAdmoA7O9afpqbUGUQmu2UvD/9oM1ZGoTgGJfcQXsZvpmaOMhDdLsNy
         NPOTfRmqWrFWECcWbiB4i/bCa+EtevrS/V79VUJQ7ktkMfuPD15+mvBr6HZidZhOJ3zP
         nF+6Qxlkv51yFqwDZXT+31qMrQqKf2RsdeyiBKDzjbUqMEC7/P7wLrNkB35rcB2y0nZb
         gsmcfIVUDYbrEXXgTDX9nmolUGFr0+OJQEKvUELyXn9TzPBGVp1HxgKNHUiPXuNf/s5W
         H+Kg2VAuWXDXUISkvZeC2KgslKgaHt2Zamh3XpmBSuUIAUBsTtp4TJ5RCfo+Q3Sa7ZVL
         OarQ==
X-Forwarded-Encrypted: i=1; AFNElJ98KTfSJL672EIWziBq6LwLXgYJQ+GKEmp3vOS+p039XpbsEklU9Lsh5A0VHz2/Ba1kMvCmNso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvO49bvpXLb5CneCANnPOi4aCkx5NtpRbkxcilKU1SekzVVQQo
	HR0iYrLNrP9Uxu4dryeMpF124m3RqU+napCl6gJbpaZhanejpHTk+y2zTBH0hd4acwkXLzMV3yR
	pPHu6RDXzqFc0Kc26MdYM1q3el1HF6CM1Fj/p6zbB6XuU3zn7h+c1zUnfAGI=
X-Gm-Gg: AfdE7ckgNpsLTrFHURqUCM8ucfPxwR/AvhuXFQWlvgYzrbah4F4O3rwaSwvHw7+hlJG
	Sc0mIIPbi5OnejcS+DHulRb+o0AXOY8bR6GAfpotoZYs5uLyCl525kJYINmAxHgztd/0vOqEqrQ
	tvZywzWUVcjYrSpB03beLi3fgSHC36437DVZYGlwaoGX/L6aUN/8NU0TWVDJfOB4lRnQq6R9MMO
	pPHIVbEHuJzxpypWnF8KtLNa7NRQ1clJ9nO5rVgn1wfDSj8SsRAb8IMb8rEKD/h4SvBoyWeS4h8
	GEsh+1rErqse5KgYLXoFe/bdbHFOVxunIqQpCQnhtP175PnT5OZaY63I0YdqMo+dXeSAody622g
	wm8fd127jk2D0fCMgeqQdKO9ma88P7Eb8qJRwIS8sY+l3A5bL767CroH2kAaYTAPB2VTeOh0SuW
	hF+WgUmA7AdXmMcjnZOXkDYbK94a9NOdxn1CLskd8z2VbVd8UurrccdQd+4+/W3a0=
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223916085a.56.1783086332548;
        Fri, 03 Jul 2026 06:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223818485a.56.1783086327285;
        Fri, 03 Jul 2026 06:45:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:16 +0200
Subject: [PATCH v8 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-3-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX0Yn4nl9Jytfr
 9kVDFG2pAxLbkymH/RYwaF3gLsrCazK/h+2q93tTaAiyVoktPOV/4I2s/WOqVNp4aRiVvWIBLqK
 32JwAtcoQwxCvGvej9TEJcY6C9pWRSK6EBa2LjLvBHvrpW1+S7AxzwVmMFwfnaQzM5Jw1u8p3i1
 TRPKsXGBRPdU/BAEYqnvn6Dxjtundw2jWvpPADOoLwZor/gHMi2/y9iBfBNmjgTZ/iC92Lkc/TY
 LnW137Ie8MvZPKkbrNv8QsQ+5NsCwXwhxt/7Ov0MT+SVLSyGk4Db+fZCJH4Nm2pERk6Wvjd+SfJ
 x0M23Loy6sJuJ4uW9EzPUy68+hsgX8dmg1HtlFM0+bjdkoN+o9M7dPtHAyXGrX35tZgBfmLn6jM
 B2FkDN4XbtcQvFYgFnZ48NH6/+xaYj1LVOjjV6laVk0avkFGN+E25a0sdNzeAjy8/MhDuQyZTOt
 1PTt9JuAUCrhI/ld7AQ==
X-Proofpoint-GUID: MJZ3NPV6VNMNf8fwvv8v8SBRBePmaZ5c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX2O/CvwuzQqy8
 uUIBgBsrk0gKYoOd46IPLTqxqgEBh153P9SBirpZxv336fqgPoYxdX3LBbeGcou5pVZOZJNnIAs
 VFBMmbM2SfnQk00hC/v31iPVE8hVFc8=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bd06 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: MJZ3NPV6VNMNf8fwvv8v8SBRBePmaZ5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
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
	TAGGED_FROM(0.00)[bounces-304568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: AEB94703519

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


