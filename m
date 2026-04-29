Return-Path: <netdev+bounces-282328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKfjI+DQ8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E962492022
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4741A3098BBC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393D392828;
	Wed, 29 Apr 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9VWA6S3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4Wf0eoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708B38A72C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455051; cv=none; b=mZqA/NcJI5Jxuss3Jj1EZL0pLPFaNxg4S83wcJDaWMtcuB+iH+ON/pOl3/tkgVfD5sfQ5FV1E/yAZzQ7ihGvycp/qgaFSWCeabL5jsPY05Lkj7/TKzf5XOZIV5MIHmca1EHbr2fxgR0QEvy8m/0cblZp/3dNtLIYdTRtnY/1up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455051; c=relaxed/simple;
	bh=wC9jrPQBmpCZbW2mnXn6p/4PAelbyjfeh2Yka1RlPpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBzGLZhSnJ6e9LYY6Y89xXPMNc3pccWv8LhHL8klIS9bQht5xiMw7YN8vjYXzIQzhVrJmoVJFQ9ka2hPhb6ZKcYIovQnJ5if7aJBE72Fwm33oevn6usbKK1CflYYLMXsKdi8/PvABsa/aIYwKbjXhzDd66anryY/1IAbs4ph6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9VWA6S3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4Wf0eoQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pxOZ963223
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=; b=W9VWA6S3iqRyvA7f
	IQsLcQMaUAo6MrX9KGt2ltCHppKvhII5yVDzVpDzHK2kuP0AaZslI8qh0v3tmdex
	IHtPapbJQePeiqdCjlTAhAHyEtwfT+4h6Zf8mY9rL59hDCZTT0mB7QUXD6jK/LEX
	YPlvGlHt/g2oCFgtmk6x9RRZqHkzt+idAJZfRqmiEEqUOF9drtciI0/PpY5w+sH2
	wGojjqWxaAsCUJXiE3JP1jCqQkACKt3T6EDFIM1KBOrrB9G53FbimPaNVhoSbKrh
	h3vOEeWBL3aHeQUyDP5coXfAtAd1BplIgxkVknbEbhHroHuyOjpgWPgJcKcqpcyx
	cjXoQg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4tqqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f71af9dddso903394e0c.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455048; x=1778059848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=V4Wf0eoQAMEva3tDdlrX9/Zl9AZ1bYSngQg/oYmbri4DFawPnSwKNq3piwSd9kYUpE
         wJMOp9YezrpOeC69LdgSX/znAt2WaolwaiJKh1MceLb025yYmwEvSmSta/Jcq35nK+WP
         wBjGkelpYxRvdJkqEWpA+vLyGKMxCRc06xoyTg6Erw8FT1e+87RjsjHtDXshS6VNG2Kt
         Vfw6sTmLtrIWtP/Jrl+IbgfcTIJU+GcNoDXYWEx8Bj3C7x33mRyb6OzLQHgUhwZUN3ui
         dNa9CIjrWBJ9N0vDukQG8M/ieGF6fxPlbBSG3TD1Wc1A6l9DWi40S3VcUuWjfYoECdMb
         W28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455048; x=1778059848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=c+G4WUtDWIL+KDA2OJ1bs98m2M8TyIQVTAmisUV4s8bwo/gtRSQ5fp0/NXAVC4zdWk
         k84q6J7I0uBCsCeINsFjI5bd4J51jvpQzbcTEsR2dr/vbenEUAPWKIiZJ61wLSjGLR7h
         ZRx3oZi8DsruotvSodV8hQPTQo3Uonx/xNpxOseP3uaUe2D/ekK6i5pWbVO3LxKIFzvn
         ysNEFEWMYbbci8Kj92wUrWN9Cl5OTNMZAaD7tX1my/TUofP0T1lkKcUytTvWoYsNYgtM
         2f51sqjVcJMhoAtkPe18BDDWDjEugSD9JER6Q+LNLUtjDlqkoYvewLLdk80gld1blpxv
         5RrA==
X-Forwarded-Encrypted: i=1; AFNElJ8IuJNgMWqcZx+cAwLJTP5sYR51CUzFLhhvuN5/WU1Pppegsl+O34aoiT0bqMK3ytD7v1KOUos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tzcMygLKGxFuUqKDBnmD5Cf7ZNPAjtIiD+fuYqVMZDs/uvtf
	xJEUIyn7/te81NzzzRukBx+p46y2sCYeaF9YvHE3AMmJrDfeMN77vLd8vWFByPIvQpxiqtImc0s
	IyswzfX2aoD66ZSooTx5sXDRyoM4aBHhzIP4RHWgle64ihyHxetdMd/GE4jk=
X-Gm-Gg: AeBDies92v8GqRgtZdGkJTBsXAkxf0Tb91n2iLqm3n6+2rWTVh7MxlAjmqhRK+tMz3w
	KxuYjZggpJzMwIu9yiVQvVEYh/E0028ERhpXlaSWTit7k9FM7/vlSZDKChNUPhznVcyXW+NaHUL
	Y/GbVYBmYcUJvtOQxe5nsOnvWyezfB/2Ql7Ery5B0lDFHxDdYNZCP+SFRqvHh47rnY036cu38XG
	DPjsn0C1gC36bo/8mzncPQJEy7qm9o46PUNOOFHy35nh/e8t6+31il+m2XaumSRFAUl3+P3jZ3h
	S9W463IYHklbQewwkApxOh/jHlGsmVq0fBVMzIgtxUJ1TffOcdD/k8NmxCMqys8lqJq/MifENBP
	SgQelF2dPRvSWj3jiPeD/iaeHVl/FJhSICeaw0J1Oma/PVxqW5zUm238RMSpTlLMPK0x5EVWx/G
	8XCd837/YGZIZa7A==
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234277e0c.0.1777455048475;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234254e0c.0.1777455048034;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb985e1b108sm65753866b.50.2026.04.29.02.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:30:47 -0700 (PDT)
Message-ID: <aadfa862-a99e-4214-b19f-6854672dc8d4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
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
 <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX/kG5HZbhm5tu
 H+Olj3wvlxHmMqHD9C6SCCg0AJKTQvWXorgcWnAWX6ky99beqww/n0485YOpGfYhciaZllQEO15
 lFaHoNH0hJn5RJBI3R4g0xNmqnTio77Ipq3rzPGKFQnm7M40vXe63zpdGW/cmy82sh9tkv5VJPR
 OdYL2W/mkWbLbym84eiN7EOISMvMPIbdm+RL8SWOpSGF4r8Rf2iMy8vSQVg06FIe88yA91W6lbp
 YbY/7rzW6HUelNUGn/2Us80ei2ZGUoxfNznuwgRoPe9lg7vMKji4pbdI+LCe2PqjRS/vcpbbIwA
 KT7PqxzerqBtFN21ZbZm5DbkLsrJ1BGmwaQJXhL/vKGZXMO6ofwQKCNa0wd1owO0blzgnfvZTw/
 qncLgMagCGox2cx99JHLlUzY0AVzkhS4F8i+2CpTpUqhWR5NgoKXU3QUBVHfnCT52d3Ou+4S3va
 BcQYbP/8Izz9pzxkt2Q==
X-Proofpoint-GUID: NVUfGqn3Tr3MaHvgxFhg4-KLU7Aa6z3w
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1cfc9 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: NVUfGqn3Tr3MaHvgxFhg4-KLU7Aa6z3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290095
X-Rspamd-Queue-Id: 1E962492022
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
	TAGGED_FROM(0.00)[bounces-282328-lists,netdev=lfdr.de];
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
> On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to
> retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

