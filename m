Return-Path: <netdev+bounces-266640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COxvBXFlsWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:52:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D76263E09
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4FA3143387
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D227587D;
	Wed, 11 Mar 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlhq3Zis";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mnirp7Pz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087523507B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233374; cv=none; b=CQkTza7h3ROwL0I3yAyzHCWMmoGPpiwDm78e/3TeCIsBIZg0Q9lLA7WH7Ghu/MHyXXGNxOticVWmPyoQTol3k7ZKOXgtheR/ywwKYTpzGNXKwBXLzIkX+926GnPjwZY5Hz/pyhoLj0AqR6Ud9zbri1jJI+NZpsVRQ65GYB6rza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233374; c=relaxed/simple;
	bh=PtnEg8eyPIDvx9wiapZ8rycgx7JxTg5ghLpipT5JkDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RASapvmrLopwiL5Pq7iC5KPr+b04XFSrEP07IrF3C/7o752L9L1t2Kg3DOZJWAk2JxiyqWxy0C1hCTr44islTgVORhJmjcNTSvIkerVtFxPICnyI1KI91zgPeYJ+q2EJQ7kURNklOkGUfMPs0FsyZ79PaiODb+mEs5ADr+DTFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlhq3Zis; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mnirp7Pz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA5hwL294388
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e4l8Qg2Bxfvv66wI/PrmEdt6OfCXTa4ZaWgbsVNWAkE=; b=nlhq3Zis3wVae1LL
	eEiNeAd8w9MaoPUv6Dyab9BJuRzYrO+MWwWc8VV7mCpZzNCgEZFctbi6m0OHB6wt
	E2acik7HtxBx499XhMDQ6HyWNUhKHg+pxTAte9lVvzuiKFqs2qNHF1npy6IigMUL
	GHW/uW9HO2eFjHO19xBu+2LQ7skqYUNdRwyDoMB28zzbHGL3g2+2zTGeci7c4ZuU
	eqYctASerjM+jXZxWOVkDF8RTebp1EGE/ECXfoYr+chg91OhlUur/kwVkrFQ+F4P
	rnev8RpAOM6QJW5iYbtyBpxsYKtYzZLOPs1xVBcyDy7oOgl52Y4zvqkICvSJCOSG
	gkn38A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6bb8hec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:49:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81be6f05so2086612885a.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773233371; x=1773838171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4l8Qg2Bxfvv66wI/PrmEdt6OfCXTa4ZaWgbsVNWAkE=;
        b=Mnirp7Pzp066gL6FCfF4bMCdiKt5hqIe2taT26nEBtiXdPgvLTf3N6yUxE7OWVACcK
         7f3rgJlYpJIG0rHNPHjgBULOUOx4Y4DpmGlcC3tgjWowlRKHoAP3w52xNw9afznUke4y
         4+GoOKTQpI63c+2vJ/U3Ov2fSWlr1NB7PhVuwoFujs6tGp5u0wAQIRft0cnCf2XeAJDe
         3rKwL5uXWD/EEEs+lOdZEANpYuRqd9FgwauOcy+dubT6RTv62DgTB6+EQFKyd4e7xs5n
         Xlx9vpByxH520dxQxt5Vpy3Izs/NS+nMcKUR7dCad9HNXLDYpI3pxTWFxzMv6t2q+tlV
         ZOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773233371; x=1773838171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4l8Qg2Bxfvv66wI/PrmEdt6OfCXTa4ZaWgbsVNWAkE=;
        b=XKRjSaA8ihy3ia+xtPpQnKhoSnmC6eeTaDWmmvSl1yw8SMoPFGVaj+lF1N+e+rtLo4
         ABdSAyPGwXqBNRK/5eutxV/xZ2mEaxN7f9K4eNkEFUr4OXq1f+hDhKTJIGrsRU8gYv9W
         vQ98qwkOAhGgvTkVSsTculwFp4mPZZQQ5y4zlEtCcFo5v8x+kOZwx11GBioNg0YHGjY3
         1BLUqChWOzNHPeDGpNX87jSHASIecIeMfKOKDyedIabkLk+1Np6Xkbux57cqsq0Cz1oc
         ZCxAar1koY8XhsVpSaLZ+yBQkW4HmqX0s6OH/lrx3rZn8L/qJ2MLfqvodTH2LdWfjbyS
         mN1A==
X-Forwarded-Encrypted: i=1; AJvYcCVYB6PfhajUc4Kzc/ugKd+OI+sV+KeZzC/oZ32/x+sA0++MUo8+pg9eGXyyGBvcePCTZD9yqMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuZdBSwQlvPUha97GK1oJIFhHWavsCxusH2TR6s7Rx3+SPEP6
	fCVUOm3Sv7qblpLGTKBgl4+nplLU2jyyg0DdI44a8O0Nq3CbXQwDhisYcw5uCt1W01kYfwbc8Ht
	aWKWYSXnF+4d321K9cAXLetfhQslnJTNV7D+5Ni4lWEV4HlEm6jDrWBdIIv4=
X-Gm-Gg: ATEYQzwGkOVcQz0ZEERCLS/mnYSnfeQ2J6AAQG1TZ//V3bJ6ANz887AcfdrrBctgbXi
	5hFWug0d0PNWqhuTwCA6ffvnU5dfNpkzkxcWjKICI5F26Z/w+ZOzFCjkFWz64rL4XHkSOwhohuR
	g2f3YGq57JeyC5pkmnpkJUzSsC1FSvTAvIgHZmFSRV6K/TF98aivR5nWtF/cPamTcEri+3T9irx
	xVvjp16X3gqunwhnXnjkEOzJhGf+3QopmOLcJdwzAdveLrXQgs6Dx/1NLpehrAZtsJKXmYtEz/C
	ZFgkcJBw0Hxrd9KriIz7+qxXDhxFEekc00ZI0SiU1xY6xZ5CyaN4T3PbYYrOmIlsNV72TcI0IKC
	sY6NpzPNaSOtxY8vtfi/ZSSCG1Fp8mTwGG72VPpqJ/sOtVsVu
X-Received: by 2002:a05:620a:404f:b0:8c7:f61:fd7b with SMTP id af79cd13be357-8cda1abfd4dmr263192385a.57.1773233371414;
        Wed, 11 Mar 2026 05:49:31 -0700 (PDT)
X-Received: by 2002:a05:620a:404f:b0:8c7:f61:fd7b with SMTP id af79cd13be357-8cda1abfd4dmr263189285a.57.1773233370970;
        Wed, 11 Mar 2026 05:49:30 -0700 (PDT)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b972de4795asm54054466b.18.2026.03.11.05.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 05:49:29 -0700 (PDT)
Message-ID: <07f8f42b-3b38-4288-9a81-83aec3f3cddd@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 12:49:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arm64: dts: qcom: Add Monaco Monza SoM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-3-srinivas.kandagatla@oss.qualcomm.com>
 <63de1d04-adf0-4608-aeee-2d5208c100ae@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <63de1d04-adf0-4608-aeee-2d5208c100ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XFLMtZdwDuOR_Mrin97w4yMNzKwHyZIC
X-Proofpoint-GUID: XFLMtZdwDuOR_Mrin97w4yMNzKwHyZIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwOCBTYWx0ZWRfX8T3yb9Bv78M5
 II4MOjil/7chk+G4aI2g8yC+2/C/sQ963VOvngE2KIF0oVUQayLJZqM1lvnbZwd1UCaKIIAcKhR
 hZKXeLgTdIPP4m06gkBxxipJaMTqs5dD5AY5iuM86mGjqUdI9aZMgItSRE7yXiyEvX8w0t0sKlj
 AsPmSz34bOgwyL7gAOiMXYFEBy9ApLFoW2OkmbOZGqUOWv6ajlbKEpMQXJcWGlW0AoKWTLJprbn
 ya2vHozLJbhyNn+MHFaeIk/qD6jIO4PvGrqXyq3rr40S25ccPPF/J5X2KwUlHlNNOZsEcd5dYxT
 xPF7AVuV1SSldanS+BdScIWshTdgRrt6o2EsKpEBpTLAdYgrHlWyBAbhJnZqAL9f6TVRMYoRxOD
 2XIi4IQTfAgDW/3KC9xizIACQRQRW1ROErozrDgdlB7Oraai56ZSNLWWpyhSo1UYEi6goCrlKu3
 aV1Fe61pwdkeZzqbsmA==
X-Authority-Analysis: v=2.4 cv=CKwnnBrD c=1 sm=1 tr=0 ts=69b164dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KQ5Aj9_w7GlCoQvhwioA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110108
X-Rspamd-Queue-Id: B3D76263E09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	TAGGED_FROM(0.00)[bounces-266640-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Thanks Konrad,
On 3/10/26 10:39 AM, Konrad Dybcio wrote:
> On 3/9/26 4:24 PM, Srinivas Kandagatla wrote:
>> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>
>> The Monaco Monza SoM is a compact computing module that integrates a
>> Monaco/QCS8300 System on Chip (SoC), along with essential components
>> optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> The following components are described:
>> - Fixed S2S 1.8V rail
>> - PMM8654AU RPMh regulators (PMIC A and PMIC C)
>> - Display subsystem/phy supplies (DSI, DP)
>> - Enable GPU, GPI DMA, IRIS
>> - PCIe Gen4 for both controllers and PHY supply hookups
>> - QUPv3 firmware declarations
>> - REFGEN always-on workaround for USB2 HS PHY
>> - Remoteproc firmware names for ADSP, CDSP and GPDSP
>> - Ethernet SERDES supplies
>> - USB HS/SS PHY regulators
>> - On-SoM eMMC
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +/* PCIe0 Gen4 x2 */
>> +&pcie0 {
>> +	iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
>> +		    <0x100 &pcie_smmu 0x0001 0x1>,
>> +		    <0x200 &pcie_smmu 0x0007 0x1>,
>> +		    <0x208 &pcie_smmu 0x0002 0x1>,
>> +		    <0x210 &pcie_smmu 0x0003 0x1>,
>> +		    <0x218 &pcie_smmu 0x0004 0x1>,
>> +		    <0x300 &pcie_smmu 0x0005 0x1>,
>> +		    <0x400 &pcie_smmu 0x0006 0x1>;
>> +	num-lanes = <2>;
> 
> This is already set in monaco.dtsi

All the comments look fine with me, will fix that in next version.

--srini


