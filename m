Return-Path: <netdev+bounces-302152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aB/HEtVkPmrpFAkAu9opvQ
	(envelope-from <netdev+bounces-302152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2B6CC8F2
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:39:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=W47d+RMw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=U+NHnjqS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302152-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302152-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF6030F09F1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF153F44E4;
	Fri, 26 Jun 2026 11:30:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4C3F44D1
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:30:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473420; cv=none; b=EBtSoSNdionrhREN/cAXlDueB11Zw3lYHi9kkEN/kd4CFmtze44NEaRUCFC6pMEHy/GdxiOVNK0eP09BdyoiJzy+e3pd28b5Z05+EOt7n1xPoAhEMVN0GyuEnK+HvmRjgeUxSXnrHt1ukHW6Zjf4div9EHhwdEVqs6qoY2kcn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473420; c=relaxed/simple;
	bh=xgMVoshPZPknzHZ+9CuinjN4yQSdGGJbwz7w1W7rtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZVy08R9u6r6d/9AZ9kDrxkRZ+thvMgqLSq+FdCnCoKl8mxghM6/VWfSOH36v44f9cC3K5LlkOqaFgpD7pJTnywGbzzAn+vHh/ZrTNWooTHIU2LC1tO0VQSDK5dSchA8ULqX5czu99PEwvB5Mou+VMlB9z1gnU0qktaJd8DYqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W47d+RMw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+NHnjqS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAcn4t881539
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=; b=W47d+RMwTjTeZNM7
	xMtbtiXinzbPJz87HGvheabfsgn3iVn94I2ENTawJkdofoNGG8fc4ivtY19cieHG
	aPhRmH1F3YsHIfFuvzxwXQkPPyDiNGN8W2jG35fI9XP3rT1pIeUGG2px0zMXPSC2
	th9sHWIccMnG6MinJeG0xRFQZMlrM1GNOz/g+WJXmVurl1MnrUBxgO3zXlmwd+9v
	beu6+tllmi1dq77WYXqQqTJGs5ho8iQipCRjFcEUSURA0nMftySN8DhPJmluIFa3
	NH3Qu4TVsKkljVBBKIvwwbWTgr80/uUr4k2vyMwBCuCggR4iXVAJJZU52CZd8ibd
	BSa3mg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eeqaf7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-73580bf7bacso18712137.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782473417; x=1783078217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=U+NHnjqSWHSnWqSm6a+nrpFTXYjjijBenODKlghspEZOvzHb8ip+vBaLQmgKWckQIe
         aU66QLA/STnYPqEr5qqAhb1KeCmBIEFCf4UdVPO0/tM5DbB6n4wk23dUNQCZpzjzpNr5
         p/p8EmpYELMJkvS+ZELmouq4WmH2bU12LnvNZwvYj6qKp56wFrsx0HvEEAnQFOsymnct
         Wo28H9ZEmTCFujdfBLOGjHeg7edeMZsw082Ka6K1nn4W2kkRufNBfsLFs8BNLSpgvA1K
         b2q2bmNlaT/RoWOLmT734G/uDJGIFdssOsIyWqLsks33VmCyGL8n3yQp9ZYLY5rJ386S
         WQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473417; x=1783078217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=lBDWufiK3SG+fn1RsOmfYQed7xPDE2ZxHhiMjn/Bu1LR6wArtu9grI2e0gHeM7bdV2
         whrNwM4PhJn5uexr5eO7BAJWvSO7npvycg6wSQezmWvZL5ZutebGXOYfzsEDHICrI1q4
         Bevhyko+rlBYeVs93+ETWcIs41SN9nOAGasOhIW3lVKkAdWbuhuyKVYMEKXoNABa93Lh
         xYckLMpVCnO1Wfvel/bUKtN22lfzif/xQSJfRWIHuxnPXaIPr010WvdYRFcqs2FqqTrK
         ouvhhZHlHJi56he6R9gvCyYiUvMLlyQPBbNhjbTslokBpJ7pMzNTjPqdG2TEYz1AMWBw
         0Crw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+DBdfNvdOcM2sZn6i3gkbxCeDPPIA1Qhlh7/rZpvYbEm1W6CXmVHEmak7q3gp2JVTj5n8IbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziiA+b0N6rMDJsXv9lFiKusd3+0c7/kGHeIt1TrRqYVsHDJPST
	2hxBPaOlgabq2DwQKD74+wJlDD1Tvb9yY38+t/AutcEKR+H7l6vtt8D5D/5VFP5fsgTC32oJ7o4
	MIcIvoH4GH30wgT2EKacLbZlPusiba984ZXuaxpS2sT7CJudd8/7ZJ+kM4cc=
X-Gm-Gg: AfdE7clTvBb2Le3Fb+O/L/+wc1+e9Y8P2EII8YJlmcdyjVy8zka4ise5FoHmG7SN9gB
	lrZNrQ5Azag0Gr3zNcb0V7uwnmunaul7lVICOpS6OnqAyEJz6eZS3sZE+9PusrRpwwS06Eny57s
	nemv8qKepboTA7BoXnzkTstwAn0NNK3UKF0CNdRLH7WLVpOY7YaFi3RWerYzwusnM75gCvqcD80
	J0f3Hl3mTBlgqEVCjBEwD/sV0CTj5TleqwxiFttsU6VI83XRDF6dbKNFQH6v2i4uDA1RLvO3ewy
	4JEPvanepef9pyd4WYwSk+854lpLjmqpoBg4Sxa8S5SvUBdgbIWPkiFKsvbdECvh2hxVchgHEYX
	KpE5LTjXk79J/PwjjXr0qXDpUkM9RyEV0iRs=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074138137.1.1782473417317;
        Fri, 26 Jun 2026 04:30:17 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074124137.1.1782473416719;
        Fri, 26 Jun 2026 04:30:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm2774228a12.3.2026.06.26.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:30:15 -0700 (PDT)
Message-ID: <0e0fb3af-968f-46d2-be6c-18b76c7d2a1a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 13:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: George Moussalem <george.moussalem@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
 <20260626-discerning-light-swan-6b599c@quoll>
 <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfX7h6f4OfGaLVm
 pa3nHZsT/DB8oRz3whTvD6Or+nG0Oa33K/gjOtwQXC/vvIuW4UbLd9cif7zjyH3pSxXXgTfEnYD
 WZ70YTtlUz8RciOv6cbft6W14+K7M+juwQw12WIoLJfO6XHTqfrIStbJTbtkGmUDsU3TSW004qX
 X0fD7Vj821iJv5rAIsYEkCOB/KdtBz05UUy3s7ObfH9hk/hXO5tYboRxyBag3UykGelTQ67E96/
 bxd6gxvtEC1mn34LE21f4z/BfWF/qEbi1J7HC+YMydkPanb9qYO4tdymFY07mEkp7EhF3fRkM4d
 eEj+y9xnUgliFMt0y83e4znKibJVnQG4enaIi8RT59O2FfOxvlEEW2SW+U8mkqG8r1JW2dk1RiA
 Yoh7CzD4AHZAK8lDx+FfPUJkHJwuEslly0aZVgy1YaejJPM56ez+OGCB/1OWOiFZX1eX61vEhny
 gCCmlU2OFo7Pkl+ZchQ==
X-Proofpoint-ORIG-GUID: lzNvYvDdj3muXBFBYH5XUEN_8v-IpSho
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfX619WZjw5fT3E
 04hPVg6wOmFJs8p/G8Jl6scJ1lqlW4eGUAe4X09MrOprHBiZMusWmX6WYbzIa90WvnEiDQZ4so2
 5Od2H2qZvloN18eBWUyhxwpjJM2TIJc=
X-Proofpoint-GUID: lzNvYvDdj3muXBFBYH5XUEN_8v-IpSho
X-Authority-Analysis: v=2.4 cv=MLpQXsZl c=1 sm=1 tr=0 ts=6a3e62ca cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=UqCG9HQmAAAA:8 a=Q5Orqy1XeLiTHnkJztkA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260093
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
	TAGGED_FROM(0.00)[bounces-302152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:krzk@kernel.org,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3E2B6CC8F2

On 6/26/26 1:20 PM, George Moussalem wrote:
> On 6/26/26 14:53, Krzysztof Kozlowski wrote:
>> On Thu, Jun 25, 2026 at 06:10:08PM +0400, George Moussalem wrote:
>>> Document the Qualcomm IPQ5018 Bluetooth controller.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---

[...]

>>> +      compatible = "qcom,ipq5018-bt";
>>> +
>>> +      qcom,ipc = <&apcs_glb 8 23>;
>>> +      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
>>
>> No firmware to load?
> 
> firmware is loaded by the remoteproc in patch 1
> 
>>
>> It feels like remoteproc node split is fake. The property qcom,rproc is
>> even more supporting that case. Shouldn't this be simply one device -
>> bluetooth? What sort of two devices do you have exactly? How can I
>> identify them in the hardware?
> 
> I wasn't sure how to represent the HW. Should I make this bluetooth node
> a childnode of the rproc? Essentially, this is the transport layer
> (using shared memory space and IPC/interrupt).
> 
> Most QCA BT controllers are also childnodes of a serdev/uart node as
> they use serdev for transport.
> 
> From what I understand, it's simply BT firmware running on this
> dedicated M0 core in the SoC itself connected to an RF.

Seems like this rhymes with the WPSS remoteproc +ATH1xK_AHB situation
- the Q6 core power sequences and manages the wireless controller,
while Linux gets to drive the device as it would if it were connected
over PCIe/ UART respectively, just with MMIO writes instead.

Konrad

