Return-Path: <netdev+bounces-282330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGMqJVXR8Wm3kgEAu9opvQ
	(envelope-from <netdev+bounces-282330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1C492115
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C1F305D734
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6583932C9;
	Wed, 29 Apr 2026 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrFnsG+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VK0pNfsU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD642AD0C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455136; cv=none; b=M6FM9KktJhI9FFYFv7tX88KMMES3gJczZE9Nh2dOcAGq8/5A8tsNHuLqveIdMr8W7MvEP/tsaRbxkwZXh1EJ6ZKDbAVcBWNwm5wqeBfTJ8evCZFq83hmmKb4ouv28QyJcrHsv7aIDzr3JJGp0zNMhjt8uVpqxXSxYc875OkEgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455136; c=relaxed/simple;
	bh=5q81zyT9bNFdWJs9YZZFd/1yiVmz3SfrynLds2/FimI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyNiXpStlSpOMpDA1JDui3TiOh30Oos9tNQE83cxTmUdnu5AAj41L1KRwMFE7A2XZv7jWyMmIIPi2GACTUti7jQxN7SGMHYv3LRZZv6EHmuh+Zi2pw343BsWIBGSVy6BRPbrqSb1kZ7K+2Y1HSxg4BwvAnuYdVehBkpCc8g53Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrFnsG+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VK0pNfsU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q0Za963239
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dpp2pOYs+zgwLnYd8Zpm3wMJtqBgJtWLRZMos+6qw+M=; b=QrFnsG+jG6rGzo9W
	lO0/0zNIpKPh5RzaU880EfRtJvcH9VKGHTso9BTsUoTdKhUk1V+siOywCL8LjgFi
	tsaJ6EiG+/j7Kabmwf9GqvEIuGlyf5V7pT7hOuM4P70FxKSiOaD/tOSHyLtQrefW
	NahBP2Wbc+FIakFEpEPpbyRRGGIXWu6Xi6wR4VZSz7O9gK0wRWBZh+f+km76aphq
	fOOYVZTZ4aExY24etzO0XVpDZqW4GUA9FcGEePBWxgcP3ccKN4YTkAEUhMCMSj6J
	LQanDekJryOGgpc0YHp2feY03k7QMgHdrEByr//wIDqm2f8yuyI9eHD1g6WhHYpm
	GeEgXQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4tr0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:32:14 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-573ac60fcc2so141057e0c.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455134; x=1778059934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dpp2pOYs+zgwLnYd8Zpm3wMJtqBgJtWLRZMos+6qw+M=;
        b=VK0pNfsUNUqEa4lJ9L2erBXv4206Il+blXl2uWvUQw8lnUzT+eGJKmdhX3BbxU5QBW
         5RhQMXFYTj6dJ+95kXBjOx+x44MGIeYvwXQuZdPHn8IML7J2FjREp8Z875QWiv9rajOv
         apGnMyu4i45kqcRi9S94WV9l1V0z9hVVQhhecbzdalNpUjaIqY5ZAtvDr7/IOZjHcbtk
         Nrfrpx473jxWjV1rPAM6+t4EwNELb+0DOa2/Im5Iwh3HHxjz1/Tt23r+5FNuSL18KS+b
         UR0QZ3rZiXRs6Pnn6ZyhD+e2e372mVMTkoSlQqkmTzwaK2C39X/Vf8gFdH+fLilePojj
         aUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455134; x=1778059934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dpp2pOYs+zgwLnYd8Zpm3wMJtqBgJtWLRZMos+6qw+M=;
        b=nC3uUEmd97Vr+HWhXuee2GCeq+7c36H19RSNrSU1z/h5G+PIHxel8D74IZyjZneP8o
         3o4v1TJBbt3ttfy0hpfr0bNbtSKFta4SgModQmAkRTb7bLyyICBFFZ9ZMeizGnnQaPZS
         MLJSch4H3MPZ9c9aGfCyTs2XaiJmxzVDi6CV4VkReWboHND4qPVf3bVQXj5aeLembFUL
         SOpjPZHtrJNVeqE1zXG8OYyEyTQdJf7rUbieFJ3rtCuW3dMIfu00intiAOg9Kfr3COwv
         XrQQCooR0Z2sM8L8npWragMNrB6asrm5CQfuoiY5c/kNgS67WAG4983RKOFuwoDKbusC
         MVSg==
X-Forwarded-Encrypted: i=1; AFNElJ/T+9KLN1HMNjQpZVbcymJ2Qk/e22GuJJ4TeWIwsiChR7dAVtBHVwHD9Lq8s2v9+Blm9pdBIY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Yr5iPaFL9qXgub/WXfkFHH6GCKd9gSHq+X4agzaFaZx/cGri
	O9t9NfQc/TNcMBn9ZJcZ7d8Lgf96cG9RRZQzJWTmz8eQd+A0UEjpNdLjTXaW82UMKAzXFkIR6rO
	bSHGHxXEKrflMb7k07bIXepk83piAKWdnIm1kDV8q5/hDJximnTFSTTxG4gE=
X-Gm-Gg: AeBDieshlVTXF9SkUBONdyDOVEd+RU78thzpoTgUnapXmN3YyuGGn4oOtqgLWZ+seJw
	xcPyWj9C9LgWMa8+OmQlCxoID/rxo3FJR8JPDgYpwUTDJlGAev6W9fGO3hBi1dwFxqiBUDkuPVB
	gOknOccRW/DW9QARFggQ0DXiRFR11DNmZy37gwA12DTnpjfNHEQg/MVUuKnEdN54UBPd1cRQqtc
	iPWV2dmyPuIkF7aig7w+GbrbAyvRhx7AuRknV2tQM2ecmW7UbhbabKqu71iLFIXzFQ3NfDpiveB
	OKLHo2cSUfS0NGRiIXuge8uJZU9z81f9ZpyhuzLzDV4VsI3WYmLkAcDiSwGPNxiaWMioEvYxIEd
	6aJG594G5xV9y0N2O8ATI9ySGxAYMZH9BlDNElrcYL9KS3EHkd3Ziwm3+cMa1WIaHlVO6TVzvfV
	WS7b2NNZvRX0z4zg==
X-Received: by 2002:ac5:ccd9:0:b0:56a:9e65:3e30 with SMTP id 71dfb90a1353d-573a2df9fd3mr1309834e0c.3.1777455133952;
        Wed, 29 Apr 2026 02:32:13 -0700 (PDT)
X-Received: by 2002:ac5:ccd9:0:b0:56a:9e65:3e30 with SMTP id 71dfb90a1353d-573a2df9fd3mr1309824e0c.3.1777455133542;
        Wed, 29 Apr 2026 02:32:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6f2e6sm67596966b.8.2026.04.29.02.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:32:12 -0700 (PDT)
Message-ID: <2390c346-0112-45b2-8d10-d29ca3cc8f88@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:32:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: qcom: arduino-imola: Get Bluetooth BD
 address from NVMEM
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfXyK0RFgVKRePP
 dHimk/cCNopmPaXOtMOHnb6RQABzDJlyURg4MlIhF8pEVLhPfkJNmgR50y2Q2yB4PgV6gOpNyVx
 VYAyxNoUCQ/Y5tMokXQFZnzlvScgMipCxVGXhDlOm/Hb7eV2hGSSV8iahQe4ayf3xunIqZZci98
 Dex/e2SA5rBEdlyf/a6GBnPG21Ech1CF70rTh9pQcIzrzN5IPmLrAg4DJH2OUqlF+5d6d/feDnH
 Asp+n1u2iG+JVKkGZ5oyGvzVMLvS/yB0BduF4n8u2jHxaIdCIN0IqEpII9SGkW0sth6AMxvICAh
 KerZ8tLxdMqbOI9iGSoRRonEgT7TNiV2iqbLga+1xqZyC/vkj3Mrcx50mQBCyRd/+lpOxKNX/Kf
 tR2QYL5D7K1cwzgi20yY8vqoNgpcJIt8kWfWPwC6jREZdJgKRMLdfTA8KMMq9I+CBqEqDKhC/vm
 WhxigjdaZb+tm0BU8xA==
X-Proofpoint-GUID: b799ADAY69X9doAD7QWtuR20oOJoClfn
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1d01e cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: b799ADAY69X9doAD7QWtuR20oOJoClfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290095
X-Rspamd-Queue-Id: 15E1C492115
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
	TAGGED_FROM(0.00)[bounces-282330-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/28/26 4:23 PM, Loic Poulain wrote:
> On Arduino Uno-Q, the Bluetooth Device address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

