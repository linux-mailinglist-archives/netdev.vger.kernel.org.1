Return-Path: <netdev+bounces-300105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2oYsEkpsMmrkzgUAu9opvQ
	(envelope-from <netdev+bounces-300105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9557698046
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:43:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="GX/i+kn6";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MtVzLl6W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300105-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300105-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECAFC305EDE0
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AAE3BB13C;
	Wed, 17 Jun 2026 09:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0E3BB130
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689384; cv=none; b=IbPTXY7Dgos9nZlJGWkx9LqY0kabrAAU72cM8fu3tMNHs0xcyOi4gs1w316FhSL+RQZTn4W9iD33eYvPzw847jRwSJfeKZWRymBLctWmYDFTXJhVXKwJplyJNsbHtcuDh5khgz+nDHX8EEpg5mO1XkRSLvB76ra1ZbK8JUvTAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689384; c=relaxed/simple;
	bh=EZr0nMvAPIMzIkfRESwH2m1KRPNc91oLSbNsVSniRXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSCmdEMz2JCVxjRCYOSkxt6u9nH3ABpFsZDXR8UFmjblztCqWQb9R/MVXW0Yox/m0WwVxmjOvGfJox80MWpmLhWWtTBAAUagP7GifFxjD9ooh6Ao3fgcnSrDHy77AKe+tT/whn1oyHxLwrAIxHV6Jo382fNW6k7VgK+zxBm9jMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GX/i+kn6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MtVzLl6W; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UsiA2025330
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0PFZ3dXkaCLzVPbD6H+hniaJto+R8rtLevzujc1O/Q=; b=GX/i+kn6Y6I3oDWo
	aKZ3q+/3afC6clikdCrc1fjsFR5e2YYq18MqmjNtGJHnszSyPl6hwpd830Ak7uek
	bi25KgGDgRZSeh+nmw4Obz/Njq1fFljmEQOmJtBNmi8wdgg036Ni/adGyzEsrQxp
	WQq6yOWPI3MIHxn0YKWWwQR/Pu6uVowDZSgkjEgP/SBXKHpagFDFUY/5EhtHygzc
	qcH8nqgKzEOoiboJZJkdYWUW7AQiGGJKa8rIpUKjcOJN7ThxhMMziDXPuAgLtjFq
	3e1oxGiP35MSTBItCrgq7JVVvSNUV1k1lKVvIHRuaU32O2ZK+qVLUx5NInTVqnUC
	uGPRhA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euees2g6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:43:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517bdeceb54so13149331cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781689381; x=1782294181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0PFZ3dXkaCLzVPbD6H+hniaJto+R8rtLevzujc1O/Q=;
        b=MtVzLl6WzjjLFX4cu2TG8tunwLM1hb45RqXQdyb0fp0jW7Rt2k/XyWjeLILa0rQfzl
         VNLgF30o5oVw/BkV+EZwIC7BWD2FK2cagiBVqEwPYHe3xCwM2P/4LRItlxTClAB+V9B7
         YBUTy4H+gFl/+p/QjJEXyRnj6d9+Nwwj9pnjIF6yq12CkDHtYctOzkVYhstlqQ0tbc2O
         p7AcpqdnTrhdvLu5M1vcPIeinLV+d85pIORCAPGcdMH35/O9z28PC4wzv21nGMeW6HB2
         cAjI6TWvpgReWnx3x6CIV5bg8KWpYnNhhkZ0MZ2GPIgLpgiOr0MQ/rOi2ilP5Z96PaxI
         JOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689381; x=1782294181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0PFZ3dXkaCLzVPbD6H+hniaJto+R8rtLevzujc1O/Q=;
        b=RHDsu2HG0v/hHdneAHYc4WgHuqb916rifOxlJNEY0To3p1abAwMgOn6DAhBhyYmLRQ
         XbPEMOZRoFYCVeLzuuh6sLN6UR6xW4qePjAZfWccE2DMvaemZbueQ6eEg8g49LKyZF0T
         SVM0CyKF9OiYdAaAZIfz73PYmU9u9DchV4cL+kkjhTXhlAFhsfpQX+bZ5N8yZE24YeTD
         zdjLUToHLNt3SiB5RiUrRInzP9449WlnLuTy1xT4YsNq/uQil05EEJv4rZa5misudpds
         V0IgJsPB3rUMmpj1tfNPEOHvu7Qv4tSwV4XbjEe9hHgOwMpY3p0/hPBL7/V1dipwoogh
         V5xQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QCt2QBjJFaoXSbG9K/+R94BipDDgF3MAz8byAaBrZMxHgAGWZfExfNUV7sDrQ+SdJ1P6FFCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxza3oj+pEzX3K82LL9RYAyyFT4HmWUI4PTW8uXfoFE3YJgneDn
	vfGZdetr1ZlQLvbiq4NsIYXtS/IUrILISFSSA4MQrSwK9gpWvtMnfUZiJNgniAInQP7IE/3WLHn
	N3h0BPHXlFiolMF0EovV+C0OrdblgOvXzM/Q80zrpd5DumnzRx2k3fU99Ikk=
X-Gm-Gg: Acq92OGlKvCFnQmdXKui72S5z9FjGJ2rzG0uFFZyj+LeXUHvBi6/rETIGe0kzdwn/H+
	09UEoNh6Fgq8dtlOlG+qj3eiuq7Cr24ULN+oobsJneLHznG79P7QaWiSCFIrohEWq96UHcNe4Um
	go1dQm15S6+QtqPvto/C4mA7nE7/3T52a8pe4neDaAMHNyScEzXIA8AZldVXAud+NGoqJ8nX2pa
	N80ZfnwFNQKFcxpnmPK3a47fas+flIV1KyicSJordWP3nmDRwrBOYkClXfKMpsMbDUB16DUCdwG
	Aps6OeMHpObo0tBxPjF+dtVxgwCKCwMvP2IpePTNY4tKL3dEYVT2MwlwEipkkDmUrC05Ejchd9u
	bwMiXteDhS1MR1spWqet4CmZ8SCG/ZNOqY9c=
X-Received: by 2002:a05:620a:1727:b0:915:6433:2599 with SMTP id af79cd13be357-91db94877e5mr256353385a.1.1781689381494;
        Wed, 17 Jun 2026 02:43:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1727:b0:915:6433:2599 with SMTP id af79cd13be357-91db94877e5mr256350885a.1.1781689381048;
        Wed, 17 Jun 2026 02:43:01 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919b458sm6374523a12.5.2026.06.17.02.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:43:00 -0700 (PDT)
Message-ID: <4f3c6bee-3ccb-467e-a466-89fece0e6a7f@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 11:42:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 8/9] arm64: dts: qcom: shikra-cqs-evk: Enable
 ethernet0
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-8-f0f4a1d19929@oss.qualcomm.com>
 <2cb658f3-f564-4396-884d-d025eaa674a1@oss.qualcomm.com>
 <ajF+xlipLuZtf4HL@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ajF+xlipLuZtf4HL@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9osc8pAubXA95ZJkiykSR4QN8Y-wMWJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MCBTYWx0ZWRfX60GNhQJodv8i
 DQt6Y88+MoLSGnj3S0YLGAbMi+QCxMEcJLjs7BDzgkqtC9HulsFnSI7Kn/mVI//vVjVvwhGLLNZ
 TDicHRKQuUaMVwEZid6ymrWTsE+JLPzdwj6npJXRR9eIBOtQTPUBwODp34JqbUCGJ8Lo4/wY2Mn
 YeAa44Ho4ZcQFj7Q67ziGf9oCbF6kOeevRbnUKtZcIAStc8OeXIfbTV+9Xg8hXpDgl5ZpbvUpHw
 23KM6QpXa7FaI+yo/BmpKeaIgQuN0DeWvn+6tfi2oizO7dA0pop8i2sUjmhwGNkP1o1OxPp5GYW
 te9q3jVNQIA9ClR//MS3nvy3d9Lyw0NsMPAtBecb+UCLg3f/6DCeNEdUXF3AWxYJ0rGcFwLzePQ
 wyC34gO3HjfBne4ax0AkQXiXeOQBvrFEdGBM/j1wG3/Zwjn4btBBkEBzOv7SPC88LqU1I3yNCZx
 MfP/pmWEgcHDMQteNrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MCBTYWx0ZWRfX8asVpQMPJ2C6
 QpbHWuYIFRzTA6KVw3gj3ny/72Pnu4T47P9RzUgoRvhV+gLqTMRVSGqzOGZTvHOmt8viPDJtFLM
 EfjcJ9g8SKXW82WoKFMNnRtO20OHmeU=
X-Authority-Analysis: v=2.4 cv=KeTidwYD c=1 sm=1 tr=0 ts=6a326c26 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=zlF0UblE2nBlcRgU2acA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9osc8pAubXA95ZJkiykSR4QN8Y-wMWJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-300105-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mohd.anwar@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: D9557698046

On 6/16/26 6:50 PM, Mohd Ayaan Anwar wrote:
> On Tue, Jun 16, 2026 at 11:50:26AM +0200, Konrad Dybcio wrote:
>> On 6/11/26 8:37 PM, Mohd Ayaan Anwar wrote:
>>
>>> +&tlmm {
>>> +	ethernet0_defaults: ethernet0-defaults-state {
>>
>> s/defaults/default
>>
>> Please move this definition to shikra.dtsi
>>
> 
> The CQM and CQS variants have identical GPIO mapping but the IQS is
> different. So should I keep this in shikra.dtsi and overwrite for IQS in
> shikra-iqs-evk.dts?
> 
> 
>>> +
>>> +	emac0_phy_en_hog: emac0-phy-en-hog {
>>> +		gpio-hog;
>>> +		gpios = <149 GPIO_ACTIVE_HIGH>;
>>> +		output-high;
>>> +		line-name = "emac0-phy-en";
>>> +	};
>>
>> This looks like a hack - what does this pin actually do?
>>
> 
> The power supply to both PHYs on Shikra is gated by a GPIO pin. I am
> unsure whether they should be modelled as a fixed, enable-on-boot
> regulator or just like this. They need to be powered on early so that
> MDIO can detect them.

If it's a regulator, then it should be described as a regulator. There
was some discussion regarding the power resources of PHYs over here:

https://lore.kernel.org/linux-arm-msm/SN7PR19MB67369F7DD02F702437C0F1919D1B2@SN7PR19MB6736.namprd19.prod.outlook.com/

Konrad

