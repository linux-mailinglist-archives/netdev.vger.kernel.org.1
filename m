Return-Path: <netdev+bounces-259308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K4nFFqwlWkvTwIAu9opvQ
	(envelope-from <netdev+bounces-259308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B9E156581
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB7F3048552
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA14313526;
	Wed, 18 Feb 2026 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jDv7SzTQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G06nDPY6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A85314D06
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417616; cv=none; b=Wo0yraHAwysADHok/fdQtwZm7qkVqnttOZHx0w+COxBJ2RlOzSnXv8fvIHP3Wu3lH4Wlgy0EqGdTzWB9ns1DuiKj3+67pJVMaAMiIjOEDZS+VktxSS7o5DSxrvZ/AMX+vug9hSr6HgtFFwEpQyNDT1uLHd6L9R1/XiU36spuJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417616; c=relaxed/simple;
	bh=uC8ZyDe/LuGv6Mt93cbqkkyOIcYNCMWY7QkgNlR36jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNFQKXeFZPotjNt/QqBkwXhp3K4KNcyTSkY1eAvBF3dE83Yykf5mwj7BMiV4YDNpLxfJmMtkLdy2RCrKuXbeKiUCuhMxvRqA69GlPOT3o0DzLKIrcDtGTQWsB6AWXfCD6/HIefuamS3Sk4ZqZEvWDF8VI/c/ZB3G39jDqy/Or64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jDv7SzTQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G06nDPY6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I5O52Z4024346
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8AvmMDOctmFUulH9Soh+ofHw2N0VUD0a2q83TPW2ifo=; b=jDv7SzTQydadV0Le
	wPPWq+yO6kOn1xJewaIDEy52r2DDLv5lMZRmYyBjM8LZX3Bi983VLI7zQV04BK8I
	/oQ3NKwfj5isUv6TX27O9IPPxeLEGNz2kJpR47wHsKAuisZIu7owjD824JmpVVdd
	6flwvRGmmbZmAX9INfdfcbufkg9Vb6P7fXLf6O6FQ/QQk7R3Sz/qAI2YzLLIc5wq
	Ws3yVU3L6+9AUEnJpmUufkuhqZtnTRIPWAY7Bf02DQzhNO2kDZYclRx/uT+rsE+J
	kyv81+7O0PTlT8ee0GyWwB0sVqDFRmr24XTXWCRIgYRKveFALb7T4U0xBZ52Zg+V
	kKuoNg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd78c10xy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:26:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70c91c8b0so430192385a.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771417614; x=1772022414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AvmMDOctmFUulH9Soh+ofHw2N0VUD0a2q83TPW2ifo=;
        b=G06nDPY6TEDk3CI2Qp5oDouVqPTwip/piFdHTkbtvlhhp8+oGohyKLw2iFF8lpAD1G
         O6eFR+0FtVxdc2OOabLoxCnatiIhzrj+n61qqWf2CGkb9M9mN0YPFoYV8KknjTQVlRay
         xezVJlVdskeZ9KgHGEw269S0de5D9u5UuAwdvEz5oHmEhPyGM9S4W9LEO2Xm5VTuWcjJ
         9bNFsLB8BY3Q1KDnLrpRIL7qfGToCX89G7g+Z905p6RZ59Q7jvY6aMtxF4cxyjUDl/D/
         VPWgM9q4Mw59F+WsZFT+3t18mh8furBqWq+hdac2iaruJiqXd5xZpHScchmfijUDFVc9
         X3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417614; x=1772022414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AvmMDOctmFUulH9Soh+ofHw2N0VUD0a2q83TPW2ifo=;
        b=e5VPPnDzji7eR36XfYZVq7rUiWH8UfrLFH8P9frbeQpV/uw2qH09zVOBIl8uhss8g/
         8PMiNHETMF9yEKF3eHZXGBki6V2cNTADXMIG9Z00tGE9ePCwO2nOklV7/BE5ExCM0eB0
         tgn7uMBKVZ4AmX5YkGKsa9VqMfcL+lS7CoeBKyT4Xu1a3mi7nEcyo8hnqEydzZmB3Z1X
         srzo1n8RwyljeEsajB6tCFOCuDmeCvpq3pC2Q4qAOdmsrNAsjDVVnfrDlcGE6cAVK05Y
         mzexptgsaYDyEm4oQ5TbCyXtL4pLMXOLQfERj88WNZ5Ql3yzVZPpT1fOgrQN6aJv9+Gg
         iypw==
X-Forwarded-Encrypted: i=1; AJvYcCWBB0woZIGtglkarcJNOpYnnoR6ue8nXYmbF/gH/H6LjpH4ESVVU16PvnCZdDNUBPPLezc+TFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobXIhamOJDz+Yd4PW0q7idGhiPQoz4D0CCWEPfUyqaULbYWi9
	gdWX17+cTccUl6FvWNSs1VoO0MUmF5fRIcNrXZGTmiQ+W2fVjX0xchNkk1bt5S0TzO77j60X2ui
	eiV/ruD3Ug0gtRALLm8cxLYu+zwAiTuIG0zr9l9JoVOqoqKP6wgvdY/XtDBQ=
X-Gm-Gg: AZuq6aI59B8veTFsFQTWsKJ63Ew2hDbWBURYdzoGJ4vS55TGuWnxu2Ut+sQFEc878z9
	J+gxmtXwoDdHdWx6tDpzWIUoQ2vzppm1jobybbGq7T2gGIAhxbosTTRY1Z3KwmAx1aqGCx74JE6
	MVDc7KnxlEo+vvPewwDUXfk9KNP7Hhx/0X0Fj4zCqVFv4Ye6V4FjrGuHZKxovFogjG/BaBS3Vbk
	uT2rPTqaDub0RjIgsIzrNKKC+IXY4MHyTUQ4BO3YU74kA4nwBDeGU8rB7wRPb3zkIZgexPekCkT
	/H5nzcOwVQOz1Mya6T8L/+N6gG+XLTAHJciPQoxN7I/DcDVXlWjq3qTBbFv1Pr/HXOazm2Tue7/
	rTn9VpFCCgVR3uXwquj3NXeIjQifapEgABj3iexVMwKXEeeol/+Q/7dd9DdLwv/yN16ZFij3x6a
	qDp7T68EB4H7vIhQ==
X-Received: by 2002:a05:620a:472b:b0:8ca:4545:aee4 with SMTP id af79cd13be357-8cb40807ca3mr1739410885a.1.1771417613764;
        Wed, 18 Feb 2026 04:26:53 -0800 (PST)
X-Received: by 2002:a05:620a:472b:b0:8ca:4545:aee4 with SMTP id af79cd13be357-8cb40807ca3mr1739409285a.1.1771417613263;
        Wed, 18 Feb 2026 04:26:53 -0800 (PST)
Received: from [192.168.0.242] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e587sm440840766b.2.2026.02.18.04.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 04:26:52 -0800 (PST)
Message-ID: <193d236b-864b-45bd-b0a9-6efbdccf6db9@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 13:26:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables subnode
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        Marijn Suijten
 <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260217-topic-ipa_imem-v3-0-d6d8ed1dfb67@oss.qualcomm.com>
 <20260217-topic-ipa_imem-v3-1-d6d8ed1dfb67@oss.qualcomm.com>
 <20260217-godlike-silent-owl-0a8487@quoll>
 <36f0a71c-a8b7-4aaa-81c3-1945b268c57f@oss.qualcomm.com>
 <0bfcb292-4e49-4047-b631-dd3029b43f1c@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0bfcb292-4e49-4047-b631-dd3029b43f1c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BPkbbhW2_mlfkYX3TvTnXguTVepj1tE3
X-Proofpoint-ORIG-GUID: BPkbbhW2_mlfkYX3TvTnXguTVepj1tE3
X-Authority-Analysis: v=2.4 cv=P5k3RyAu c=1 sm=1 tr=0 ts=6995b00e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=RnnwUKbM9eazD08LpS8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEwOSBTYWx0ZWRfX897pHH1HUTDO
 Ia+r00WqQmykdJxFTfvU0jXpKC3ABX4ajZWU6KomYNC7iaGGSOim3zNtbCVvh1zGwcXDQtVCYCY
 8oDwc5/dK0rY9uKCO7mXPH9lJnGQE1z9cvPBXBQGH60Ydl+r+kiW/Gg6wCKOCdzJAMfPVRS9mpa
 qtNUROfHQzAzJgJRUyR1JoAifly//6EEAaG4REYg+ZurfLcupESEledr8v1mQvXeCXwlg2zToFw
 EoT4q1KadTIMJBb/cUbiPzR9PE4XPbecTZ4p92gQURjj4tavB0LRZ5SfqKJ6KFXXIA8GJ0pz+et
 25Jlyapl2tI52K1I3gdPPYS5+MIobOQgqSu109EGorIor4j830ndxfIuk6kmThLGQ0CpTEdMqwp
 xn3SEmwxFjCeXxtQcNC2fYfDATwVPzJKr+W6njjFzNOITEtOlhMrHbzDgUWsWl8ZPEZaD5e/f/T
 Zzs1zFATv2wTVkK5Ndg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259308-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.4.210:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5B9E156581
X-Rspamd-Action: no action



On 18-Feb-26 12:56, Krzysztof Kozlowski wrote:
> On 18/02/2026 12:05, Konrad Dybcio wrote:
>> On 2/17/26 9:25 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Feb 17, 2026 at 02:30:31PM +0100, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> The IP Accelerator hardware/firmware owns a sizeable region within the
>>>> IMEM, named 'modem-tables', containing various packet processing
>>>> configuration data.
>>>>
>>>> It's not actually accessed by the OS, although we have to IOMMU-map it
>>>> with the IPA device, so that presumably the firmware can act upon it.
>>>>
>>>> Allow it as a subnode of IMEM.
>>>
>>> You do not have compatible, so rely on the node name as ABI, which is
>>> fine in general but... I do not see usage of it in the driver. Why do
>>> you need to define modem-tables child then?
>>
>> I don't really *need* the node name to be an ABI. However, the current
>> binding for IMEM only allows a named "pil-reloc@.." subnode (which is
>> consumed via of_find_compatible_node() in the remoteproc subsystem) so I
>> figured the intention was to keep the list of allowed subnodes strictly
>> moderated
>>
>> If you'd prefer a blanket pattern declaration with say '^[a-z]@[0-9a-z]+$'
>> with just a reg requirement inside, I'm fine with that too
> 
> No, the problem is that you do not use the ABI here at all. Neither
> would you use the blanket pattern, so my question stays: why adding ABI
> which is not used?

The subnode I'm trying to introduce is going to be consumed (via a
phandle reference) from the IPA node, as done by the remaining 2
patches in this series.

I would much prefer not to touch this binding file, but there's an
additionalProperties: false and just adding it as-is results in a:

arch/arm64/boot/dts/qcom/sc7280-idp.dtb: sram@146a5000: 'modem-tables@1234' does not match any of the regexes: '^pil-reloc@[0-9a-f]+$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/sram/qcom,imem.yaml#

Konrad

> 
> The pil-reloc is being used, as you pointed out.
> 
> Best regards,
> Krzysztof

