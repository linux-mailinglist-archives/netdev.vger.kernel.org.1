Return-Path: <netdev+bounces-271502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C7rHIjJw2lKuAQAu9opvQ
	(envelope-from <netdev+bounces-271502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:39:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8432408E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D346304C68F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24923CF031;
	Wed, 25 Mar 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8h8iA06";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KrPWfT6q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899503C944C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438749; cv=none; b=Y6oRha5NqQnwOnpkdkXlwkhDSh2WGJLrCmAAXKNTFmLkvc1RKDEnbhKM2DCs+lEGmm4RzUPdbKwhv5ea0VnteuENiUigdQqdSjhj4mSRLzOqVuicA6HvhDMGfvLN6MpGW5sOVDPzgZ1evltaG48kCxMYHXnQCt7Q2TZIz9HuFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438749; c=relaxed/simple;
	bh=HwbldYifOI1syh9jQF57vFS6uLXgc2AWeYBYJY+QJuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJedNWo77fHkiDCEp2QDaSkvHCsEsrUVoF30wJLah2Z78C9XJHzJWbvaVwhJa4uyD16J2oh7auWiIQaNPAEXnut3scOlQa103/mlxGRchgINX6PhRZbukuo5zZY5hojsmK1+fzxNQM7fkjtQP851iVsrV2ib+40NhmGEp6/YX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8h8iA06; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KrPWfT6q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBGHQN2197470
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyh2jN87d1AnYPhYLtYyuJ4FRff0TEodHiQjZx3eW/w=; b=P8h8iA06d7Emd6TZ
	jaZbGOSeTprb8l7ZI4vBahVvzjyOWeP5c+QTb3BuD2+7VDhVWLlDMlvBrBaOYUPi
	UgU/WRY/OsW8uiAZB5AnlE3rEtF4jhpoFQ6O8wo4pdhC/rhKVdS9UCg6YknxyqBc
	lwBExw4g6Jcy+pV+C7rsuZ57cYkh/YQbMdzVxXZwCkm2cUvUY4jXBfuAGl9AGaig
	kPtnZJ8E4T+62TdK5yGPiwbON0LAtuCcYKkKJWEWaWRfOLDvsnSSqL5nFOGaDopj
	5DCsJoywmHFk60K1o2hzadprWg2xJxQ+FQjSNznt5C1aPOhcv2tbLESa1WH10Rdr
	yN9vCg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d48599ksd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:39:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5073ed1ec6fso56447581cf.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774438747; x=1775043547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyh2jN87d1AnYPhYLtYyuJ4FRff0TEodHiQjZx3eW/w=;
        b=KrPWfT6qaFVBKUfAWxutkzbEYdllU8U+rquAJXazgXjj0bzfAprTd21q3QuJfipi/f
         N780OZ2GRWAB7vGOx9WkDv61kS7V58XFLJ5dsI9vxRor701gU2tx3aielJYtrDaWvUge
         6bBPFNG8KAMAFOhC41YK/YfbKyUR+NAowE/Jm0+pnpA1M7UZ8c3WPW4sMeIbtwA04gaG
         lSsbCXkPtMfbw+ROIrhc/n6CVSxYimib/Al1hDr+qmzfI0Aa89/7LPd/pxHIYPIR+cou
         Ofwl3Accu8GGgku9cmGQmXpvZfCLafT7vYSW/RwlFyqLu8DsVn7t6vWgM3Lr+EKKuhqZ
         xfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774438747; x=1775043547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyh2jN87d1AnYPhYLtYyuJ4FRff0TEodHiQjZx3eW/w=;
        b=EhQ2Va2+Gjvp/CP+UxoS8NX+0UsBuW9w0jZKmVGV7gtgO0OSd8ZXem3PAu1lsPUW5Z
         siJdd0p9njbxvHOMcMjhqN0+d67c5bZkWprCoBr1F6v1n/5sXS/VflxJrDValySlJUfn
         mX1ZU8L0YjYQrmeeP4CNucFlp3bVNDu7s53ioIn1/bq8WOuVP0EJcHx5zsLHXAUorNCf
         tJf8VtGY/LlCFxFFBP0wZUHZUItvZkzamUl9VfaVXPxXypNTnQu0bnnO1RYKlkaegHDz
         O0MRXtc44Wjdmkl/Bwb6vuT3oP2N92ob2sFAeMs+PiEObMqeAk13vfb55AjOeK69vwqm
         /DPA==
X-Forwarded-Encrypted: i=1; AJvYcCUZReBwYNsr7X0Gv1uGaJ3JmDmzUhS3FsdeY5vjyQAI2IctgNLD69bIqQwoyU9pBevkvJ/grBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8ZPvSBQ4F2pVdoBG06rsOAPckZHihyz2Gx0N9eIJFRaU9yhb
	1eoyF20n2lPZiYisYUAZpdWqZfFNZGNRmGT9SXrubnQlgGVF6iJk1rirH8AWpNi7GHjqYDr3WsY
	/hqU3cJ2F0elrDcVU2kwKNA97IPrn8eohDKyW9gk+7Q1pJYiGcKmt8B+ldss=
X-Gm-Gg: ATEYQzyK8BFlVDQrUVWR3RvMCxMVFPNilk6R1gBRqD8/88FMXHOSpNxzxo01QCF5NtS
	TqNQaS4CWb1EP3qDtMsVnzkAhEQt7wkF2egs1WJBgLeKCqX//xJYh2JTAzMPO7SbCKFxdhohxtG
	WfRxyfX0WYY0HlBs0b5JCco7RKeYSDBw2nvhPl+qkLZkbzD8UEzUyHX14fvDldlMijqBs4zYhRw
	3tqAvvUGptGknAu8wnBe5pMOiX/KddKS71gU841SjhobwotoWqAye3+FzwGcRmLsfHJvuP57sF1
	s1VAI+H0xgQpbA8oKilhoHELkq5jwewGskyy8dc7VcBvvo0Xp2x3e/36xdqTWfjxUBHkfd5qIKQ
	v3GJ2FASMkZIQD4tp7WRmL361CCG915y79pMdHlotV2Ri4XXoh0l3AP8Eb5O8jXamaD+YaRB0GQ
	6EGzU=
X-Received: by 2002:a05:622a:4086:b0:509:39b1:d4be with SMTP id d75a77b69052e-50b80e802e3mr33657611cf.5.1774438746753;
        Wed, 25 Mar 2026 04:39:06 -0700 (PDT)
X-Received: by 2002:a05:622a:4086:b0:509:39b1:d4be with SMTP id d75a77b69052e-50b80e802e3mr33657271cf.5.1774438746210;
        Wed, 25 Mar 2026 04:39:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983387103asm779356066b.57.2026.03.25.04.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 04:39:05 -0700 (PDT)
Message-ID: <39da1661-bad5-47a0-b50a-52678e1766f9@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 12:39:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845-shift-axolotl: Enable NFC
To: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shift.eco>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
        biemster <l.j.beemster@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        oe-linux-nfc@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20260324-oneplus-nfc-v2-0-3eef052c9bc6@ixit.cz>
 <20260324-oneplus-nfc-v2-2-3eef052c9bc6@ixit.cz>
 <9d9ec994-c954-445d-97b2-772614d66f35@oss.qualcomm.com>
 <041766dd-422e-40e1-9e5d-c220580871f5@ixit.cz>
 <a0da2236-27b3-4491-862a-457a03cb4c5e@oss.qualcomm.com>
 <c607e5e9-2e2c-450d-9ca2-5727ba99578c@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c607e5e9-2e2c-450d-9ca2-5727ba99578c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4MiBTYWx0ZWRfX+jXSZjKa829a
 0fRGNNpgesJ8WGI1EbAHGPDD810Nr4/mN5+nr2Ntxnx8sCRogBfQQoXng9rjCw+ACMzWVTmEWU0
 rAiTztOJEGmivIRFwul4sdWUfWHpfaNve+Do9t92d+yz1YmkZqqpiDSb8CUbK4kC9/2QZ/w+SsH
 x4QXHsVMYHVM7CrYlW5Ah5GWSPgiFBX7S2sRJx+A2W3Ljjx4OO6X5m33hz79WQ4gQH5Fb5mvJ+S
 xQ2gCnSD+FFYQPBRalQAgU8/NESRUEQWaS2mfO5aK3lU7Cyqok3v7yngsCu8xakL0UVQQw4lj91
 e+1P1Z9bzjCoVvp4qZ7oulekZ18uRlV/jqgqTltmnhWS+OOA83vcZEq7Ym6a6XzbgsbaKDyZOej
 6Mlh52KTrAGAxwkBf/Xg48MGyhuW4KUo0sxj5wi55oyxiKuIClCsaZziRWEfcPxPsbKsQBaA02C
 CxzaR2YlhB9k17IOaSQ==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c3c95b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=nP0QM_pW1fVPP_CoLIUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9kuEanSciugOk1Gcojpjq6tU8juwJWMd
X-Proofpoint-ORIG-GUID: 9kuEanSciugOk1Gcojpjq6tU8juwJWMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250082
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,gmail.com,vger.kernel.org,kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-271502-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1DC8432408E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 12:31 PM, Krzysztof Kozlowski wrote:
> On 25/03/2026 12:20, Konrad Dybcio wrote:
>>>
>>>>
>>>> FWIW TLMM subnodes are best sorted by pin index (although the file
>>>> currently doesn't really do that) as per dts coding style
>>>
>>> I assume when I group the -pins into -state it doesn't apply anymore? As I don't feel having pins relevant to one device / subsystem all over the place is extra clean.
>>
> 
> 	nfc_int_default: nfc-int-default-state {
> 		pins = "gpio63";
> 	};
> 
> 	nfc_enable_default: nfc-enable-default-state {
> 		pins = "gpio12", "gpio62";
> 	};
> 
>  	sde_dsi_active: sde-dsi-active-state {
>  		pins = "gpio6", "gpio11";
> 	}
> 
> Let's imagine future possible implementation of DTS coding style
> linter/checkpatch. How it would sort the nodes? Either by node name or
> the first value in "pins", this this would be:
> 
>  	sde_dsi_active: sde-dsi-active-state {
>  		pins = "gpio6", "gpio11";
> 	}
> 
> 	nfc_enable_default: nfc-enable-default-state {
> 		pins = "gpio12", "gpio62";
> 	};
> 
> 	nfc_int_default: nfc-int-default-state {
> 		pins = "gpio63";
> 	};
> 
> So that's how you code. Less work for future linter/checkpatch.
> 
> The trouble is that "pins" property sorting can result in nodes being
> spread all over, imagine:
> 
> 	nfc_enable_default: nfc-enable-default-state {
> 		pins = "gpio5", "gpio62";
> 			// ^^^^^ DIFFERENCE!
> 	};
> 
>  	sde_dsi_active: sde-dsi-active-state {
>  		pins = "gpio6", "gpio11";
> 	}
> 
> 	nfc_int_default: nfc-int-default-state {
> 		pins = "gpio63";
> 	};
> 
> That's why I would propose to keep everything sorted by node name, but I
> am fine with both choices. Qualcomm maintainers decide about such
> detailed style they want to impose.

At LPC we agreed that the last sentence should not be the case ;)

I think I'm fine with "children by name" then..

Konrad

