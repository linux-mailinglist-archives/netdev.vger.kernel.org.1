Return-Path: <netdev+bounces-307524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21sENJpkVmrT4gAAu9opvQ
	(envelope-from <netdev+bounces-307524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:32:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF44756F43
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:32:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=B7wcckxx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=f52Pex7l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307524-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307524-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F2D30C225F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265F4D8D98;
	Tue, 14 Jul 2026 16:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3232DB79F
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 16:31:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046674; cv=none; b=mUMX4NZKqFzBhbB++r3rnZ1dGnL47auyTa65S4yhwwvf1zS+vT8ooHaigCkIW2l6SNDVkyMUKD3MJ6uV/fFyvGjpe+PRzTfwbBxxvJ6nGCuPWjsQ+0umicdGJE9Ah8vqmfCe6YPRQKu3z/2woxBS2aJWjCm8hujO/O3Pz81asdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046674; c=relaxed/simple;
	bh=phj52z4wpccKiuztsidCL8DXuFynPynckFr8PJQtUsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrcTe6TY1JrcE/SoxyzJxCD+xJNKHBe8UmfNQn97BdmsHeaXw6behPrafuS5qHkICPiSLQmXptA6HfCa9FaQJS96rpA9lQvOkyBU/Zf/ncT1VosNg8ZOUZUVfxHJbA4fng/W8lxulfZ6ejJM3S43HwYL6pahi8hpNLxoJV1Sf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B7wcckxx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f52Pex7l; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6usa1056258
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 16:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lS4E5Vh06vzDyuN0fk7GhUAnbYypO97BD81NJJo9qKM=; b=B7wcckxxH9czTldM
	FdrnSW+9zNa81NxNJBLXvQUQi+F0Dq0msBYx6Oir6b22inoMMcfCkXJk+BKLLmzh
	PxwiNOTqd7KvHKFEdNNyedo14sPpJ2iON5cabcFnGpReiBZXYialCEDNCVrvRVCx
	usVQ3JF3FB8aAUzBOMuwo9kDfjm1RQ5r5/HOPXmdeAdAr2u+sDAN+Fh/h25P9Xge
	jE3oG+yGA8V1ooLJw7xEOuKiNyZQejjffLEo/BY6meusn0b3WcdJbM27CoF7A2oo
	toIP6NzUfw8J1GFKgLbkfYeIEXmYeHophT0LvqiPKg33NY/yBkWvws4ahzFrA3aO
	397F+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdeu4jp5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 16:31:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dc4401dc7so1318620a91.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784046669; x=1784651469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lS4E5Vh06vzDyuN0fk7GhUAnbYypO97BD81NJJo9qKM=;
        b=f52Pex7lamwCjt5A6npPCOlWw0rIcYW8qjGm3D6xE9vQ41eVr4ORzQbf9kKWN/Uki2
         aFgxj4b1qFVMNZkQ2vRR0Q/uwnj+LMJ7+/tnQfDsGX2oIsHtvdhL/Yl54yfKepbBhDCH
         GeDbAZBXBnVvGRlbch8EmnDMCzGmvpYFfLW46Z+A87ufx7siG5XNjwBqZxsjINZRxpqI
         W3yFTBi4BnjZgq97hewBLsE995bUg5SBkcKblNF6/Eccv5peCfHuGpDUZXi2RV8qFe4p
         Am6+He8Zf6VgvhU5MfRU/M6AphJIXHW1763Iyq7mEbPGjhRt9Rn7CSxab5P7fFs1PLuJ
         iJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784046669; x=1784651469;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lS4E5Vh06vzDyuN0fk7GhUAnbYypO97BD81NJJo9qKM=;
        b=lyMBtDu8HLvK63JiML78kIjg6q4NSqV5wW9Gmlk75+q0+I34KuUrP2lVk+1ACKYC/h
         kJVg+HqwsDPkCdKILRUGQ3SBkgt/b22EuvUOR6re0rLmhnYwZ9fTnYs8eu0GcNAfMC2j
         6DlyBLDhA3Vd9YZVRErJPMBXiIcaB+NJh/WchhSE4FwbsnEkZGqDZazqO1ClNBBVJwlb
         gtZnNweflo/XL0MJGi4u663yjtWCIeld1zdBOAyZ/vx2NHkF/cHxRkaSfx8uoHtOf+4a
         y4MGxbhLQd1jqUB+45rEKM5kK8XJKiKH43NQCaQfXpDGRFZLvxrGWuOPn8U0uumfwMkC
         fQ/w==
X-Forwarded-Encrypted: i=1; AHgh+Ro/1RgX+0WRTutvlgTMl4OO1fLkcUbTrvzeuwLjEUd4MBge5Y9itvi6g8C2D6q7ssq0cNtH1VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGcBwt+CKMa3v+oQitPCK/WsPCjoMPuOCXM/7BLY7FSVBD+c8
	Qt8Yhx1lzuVeqfDSnUQarjQXScLaVfblTLQZTqpjrC7HtTaYLvTN1tV8oqjwRqrtZvmyC9kfxNz
	W3zKT+9frUvbA3gjbSp3bfutcoeo4Jmif+9zqorSf1vHLIpwXKaLmPksDjnw=
X-Gm-Gg: AfdE7ckNvz45A2ikKHPTU1ux8aWDMZHjr4cnKLSQp8nKpAwPdHBP572sr7+fei3UcKr
	6BTetJReGQuSiPQMrnJyRu0OFq4cvsnc7IoK7mk4Tkd/UP29565uLG/icsrA570U4OG6vtHYNZK
	5AJ6YRhOn8MN03AGIlTkQ02Fn7gAAPHCHmgV6iY4Q3lpIRwPT0YUzCLQwTPGkEhM000dj8eyKjC
	F1RJolR4S0/0jnY502FpL1A7bwcZtCHtiafA526vwWDGP2WIIXel8DMI7hwq3BW88ESKIdWKua0
	1YmXvAq3DnudAbgxulKiIgE+mwQ5jRGX0eqMOduu25PKsQAVNlWHyCoOxgib1GmEYD7a5G0dpED
	oppUdaTMls8K7NdLrXOFSBOjHJ3LNML4fklibSDJYxlU4FzI=
X-Received: by 2002:a17:90a:d2cf:b0:38e:5e0:74ed with SMTP id 98e67ed59e1d1-38e05e07585mr6779625a91.35.1784046668925;
        Tue, 14 Jul 2026 09:31:08 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:38e:5e0:74ed with SMTP id 98e67ed59e1d1-38e05e07585mr6779563a91.35.1784046668148;
        Tue, 14 Jul 2026 09:31:08 -0700 (PDT)
Received: from [192.168.0.116] ([124.123.151.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm83798621eec.11.2026.07.14.09.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 09:31:07 -0700 (PDT)
Message-ID: <52a19437-227e-48b4-9cba-d47d1469a0ea@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:01:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a
 single coherent block
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chris.lew@oss.qualcomm.com" <chris.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
 <PH0PR11MB59022A1E06830365E6D224B4F0F92@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <PH0PR11MB59022A1E06830365E6D224B4F0F92@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8NnrLSjhIjkhFvUkQeaaKfDT1grNzLG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3MSBTYWx0ZWRfX6qV0lhirDerR
 EjiCaRglfBT0Ribq315LIfSXosjR0ZLLcEu0tLlniUta9xzlSXx161gMObkNbhW84vGwIBrjxyA
 w5YAxgmy5OJ+ReUvHBMdsZsEih2Jir41ykE9mv5QSsLe3IYNwOOZo/m9Ieqi8NuFP38b8XAfgQU
 eqyCrWqaV1dDqFurVDPHcC58cBMZ4YLmkmCfIgOfMnZ+O/4ZIk8qYa0AjISOGrGQMSo0zO59Z+V
 Flrnkd1vU7pUfTvC35HMRxg6Qk0D9/O5qwK7GzVGFR6kD33ugyiYsM1T6mP5PtAD2ONKDPiyunk
 f3PzJLjQv5/27ANHjvYGIij5WsdpzvBojOtZWamOyGyI+i+tdTB6dWutc37D7jms6j437/n0fbd
 dZqMir+2MREo+aiDTgrSHr9/1GXhjTpC+b7w2aUvISXpTiWa5KVw152oI0lL1yAEyn6HrkzcrSs
 a1rNa8Tp5n3UOl+HMAQ==
X-Proofpoint-GUID: 8NnrLSjhIjkhFvUkQeaaKfDT1grNzLG1
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a56644d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ziBI+Y3eO/H+UwYWWny9Hg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6SzVS5f5-TyJiIsxWV8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3MSBTYWx0ZWRfXzDJem2IU9QzM
 QCYMF0K22XFanZn9ZWf5IobmlXstPM54SHZmE6CTqWfwkwB1fpKWtvdd4g+vw3rxBs2s+W4psXA
 oDmrhnwHm4+NRmt+TrGPpsoAD0d4whQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140171
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307524-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:stephan@gerhold.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[intel.com,gerhold.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BF44756F43


On 14-07-2026 01:25 pm, Jagielski, Jedrzej wrote:
> From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Sent: Tuesday, July 14, 2026 7:33 AM
>
>> On Qualcomm SoCs where the modem (e.g. the mDSP on Shikra, VMID 43 /
>> NAV) is the AXI master for BAM-DMUX RX transfers and the XPU enforces
>> per-region access control, each individually DMA-mapped RX buffer
>> requires its own XPU resource group (RG). With ~16 RGs available, the
>> 32 per-buffer dma_map_single() calls exhaust the table and the first
>> inbound transfer faults with an XPU violation.
>>
>> BAM-DMUX is a singleton (exactly one instance per SoC), so the
>> destination VMID does not need to be a DT property; it is looked up
> >from the compatible string's match data instead. Add struct
>> bam_dmux_data with a single vmid field, and a shikra_data instance
>> hardcoding QCOM_SCM_VMID_NAV for qcom,shikra-bam-dmux.
>>
>> When match data is present, allocate all BAM_DMUX_NUM_SKB RX buffers as
>> a single contiguous dma_alloc_coherent() block and SCM-assign that
>> block to HLOS plus the VMID once at probe. This reduces RG consumption
> >from 32 to 1. The block is never reclaimed across a modem power cycle
>> (bam_dmux_power_off() does not touch it), so the probe-time assignment
>> covers every subsequent restart without re-assigning or reclaiming. It
>> is reclaimed to HLOS only once, at remove or on a probe error, and if
>> that reclaim fails it is leaked rather than returned to the page
>> allocator.
>>
>> Each rx_skbs[] slot is pre-assigned its virtual and DMA address from
>> the block, so no per-buffer mapping is needed at power-on. Because the
>> coherent block is not page-backed, received payload is copied into a
>> regular netdev skb before handoff to the network stack; this is an
>> unavoidable extra copy on the XPU-enforced RX path.
>>
>> Platforms without match data are unaffected: rx_virt stays NULL, no
>> coherent memory is allocated, and the per-buffer dma_map_single() path
>> is unchanged.
>>
>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> ---
>> drivers/net/wwan/Kconfig         |   1 +
>> drivers/net/wwan/qcom_bam_dmux.c | 134 ++++++++++++++++++++++++++++++++++++---
>> 2 files changed, 125 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
>> index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c56231615269698140187ca3141dfe48dbf 100644
>> --- a/drivers/net/wwan/Kconfig
>> +++ b/drivers/net/wwan/Kconfig
>> @@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
>> config QCOM_BAM_DMUX
>> 	tristate "Qualcomm BAM-DMUX WWAN network driver"
>> 	depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_TEST
>> +	select QCOM_SCM
>> 	help
>> 	  The BAM Data Multiplexer provides access to the network data channels
>> 	  of modems integrated into many older Qualcomm SoCs, e.g. Qualcomm
>> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
>> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..247230b720e6011876d5c429badbb5a1f34fc576 100644
>> --- a/drivers/net/wwan/qcom_bam_dmux.c
>> +++ b/drivers/net/wwan/qcom_bam_dmux.c
>> @@ -9,10 +9,12 @@
>> #include <linux/completion.h>
>> #include <linux/dma-mapping.h>
>> #include <linux/dmaengine.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> #include <linux/if_arp.h>
>> #include <linux/interrupt.h>
>> #include <linux/module.h>
>> #include <linux/netdevice.h>
>> +#include <linux/of.h>
>> #include <linux/platform_device.h>
>> #include <linux/pm_runtime.h>
>> #include <linux/soc/qcom/smem_state.h>
>> @@ -62,6 +64,7 @@ struct bam_dmux_skb_dma {
>> 	struct bam_dmux *dmux;
>> 	struct sk_buff *skb;
>> 	dma_addr_t addr;
>> +	void *rx_virt; /* non-NULL: slot in the coherent RX block */
>> };
>>
>> struct bam_dmux {
>> @@ -75,6 +78,10 @@ struct bam_dmux {
>> 	struct completion pc_ack_completion;
>>
>> 	struct dma_chan *rx, *tx;
>> +	/* Single coherent block backing all RX buffers, NULL if unused */
>> +	void *rx_buf;
>> +	dma_addr_t rx_buf_dma;
>> +	u64 rx_buf_perms; /* SCM source-VMID bitmask of rx_buf */
>> 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
>> 	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
>> 	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
>> @@ -92,6 +99,10 @@ struct bam_dmux_netdev {
>> 	u8 ch;
>> };
>>
>> +struct bam_dmux_data {
>> +	u32 vmid;
>> +};
>> +
> do we need to introduce dedicated struct just to cover u32?

This is currently tied up in the open discussion on
whether the VMID should come from match data or an optional
qcom,vmid DT property instead. If match data stays, I agree
a bare u32 value works without a dedicated struct and I'll simplify
it that way.

>
>> static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
>> {
>> 	reinit_completion(&dmux->pc_ack_completion);
>> @@ -111,6 +122,9 @@ static bool bam_dmux_skb_dma_map(struct bam_dmux_skb_dma *skb_dma,
>> {
>> 	struct device *dev = skb_dma->dmux->dev;
>>
>> +	if (skb_dma->rx_virt) /* coherent RX slot: addr pre-assigned */
>> +		return true;
>> +
>> 	skb_dma->addr = dma_map_single(dev, skb_dma->skb->data, skb_dma->skb->len, dir);
>> 	if (dma_mapping_error(dev, skb_dma->addr)) {
>> 		dev_err(dev, "Failed to DMA map buffer\n");
>> @@ -124,6 +138,9 @@ static bool bam_dmux_skb_dma_map(struct bam_dmux_skb_dma *skb_dma,
>> static void bam_dmux_skb_dma_unmap(struct bam_dmux_skb_dma *skb_dma,
>> 				   enum dma_data_direction dir)
>> {
>> +	if (skb_dma->rx_virt) /* coherent RX slot: nothing to unmap */
>> +		return;
>> +
>> 	dma_unmap_single(skb_dma->dmux->dev, skb_dma->addr, skb_dma->skb->len, dir);
>> 	skb_dma->addr = 0;
>> }
>> @@ -468,9 +485,10 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
>> {
>> 	struct bam_dmux *dmux = skb_dma->dmux;
>> 	struct dma_async_tx_descriptor *desc;
>> +	size_t len = skb_dma->rx_virt ? BAM_DMUX_BUFFER_SIZE : skb_dma->skb->len;
> please stick to RCT
> please fix it here and for the following where RCT is violated

I will fix all the declaration ordering in v2.

>
>> 	desc = dmaengine_prep_slave_single(dmux->rx, skb_dma->addr,
>> -					   skb_dma->skb->len, DMA_DEV_TO_MEM,
>> +					   len, DMA_DEV_TO_MEM,
>> 					   DMA_PREP_INTERRUPT);
>> 	if (!desc) {
>> 		dev_err(dmux->dev, "Failed to prepare RX DMA buffer\n");
>> @@ -485,6 +503,10 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
>>
>> static bool bam_dmux_skb_dma_queue_rx(struct bam_dmux_skb_dma *skb_dma, gfp_t gfp)
>> {
>> +	/* Coherent RX slots have rx_virt and addr pre-assigned at probe. */
>> +	if (skb_dma->rx_virt)
>> +		return bam_dmux_skb_dma_submit_rx(skb_dma);
>> +
>> 	if (!skb_dma->skb) {
>> 		skb_dma->skb = __netdev_alloc_skb(NULL, BAM_DMUX_BUFFER_SIZE, gfp);
>> 		if (!skb_dma->skb)
>> @@ -499,9 +521,10 @@ static bool bam_dmux_skb_dma_queue_rx(struct bam_dmux_skb_dma *skb_dma, gfp_t gf
>> static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
>> {
>> 	struct bam_dmux *dmux = skb_dma->dmux;
>> -	struct sk_buff *skb = skb_dma->skb;
>> -	struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
>> +	struct bam_dmux_hdr *hdr = skb_dma->rx_virt ? skb_dma->rx_virt :
>> +				   (struct bam_dmux_hdr *)skb_dma->skb->data;
>> 	struct net_device *netdev = dmux->netdevs[hdr->ch];
>> +	struct sk_buff *skb;
>>
>> 	if (!netdev || !netif_running(netdev)) {
>> 		dev_warn(dmux->dev, "Data for inactive channel %u\n", hdr->ch);
>> @@ -514,10 +537,18 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
>> 		return;
>> 	}
>>
>> -	skb_dma->skb = NULL; /* Hand over to network stack */
>> -
>> -	skb_pull(skb, sizeof(*hdr));
>> -	skb_trim(skb, hdr->len);
>> +	if (skb_dma->rx_virt) {
>> +		/* Coherent block is not page-backed: copy out to a real skb */
>> +		skb = netdev_alloc_skb(netdev, hdr->len);
>> +		if (!skb)
>> +			return;
>> +		skb_put_data(skb, (u8 *)skb_dma->rx_virt + sizeof(*hdr), hdr->len);
>> +	} else {
>> +		skb = skb_dma->skb;
>> +		skb_dma->skb = NULL; /* Hand over to network stack */
>> +		skb_pull(skb, sizeof(*hdr));
>> +		skb_trim(skb, hdr->len);
>> +	}
>> 	skb->dev = netdev;
>>
>> 	/* Only Raw-IP/QMAP is supported by this driver */
>> @@ -574,10 +605,14 @@ static void bam_dmux_rx_callback(void *data)
>> {
>> 	struct bam_dmux_skb_dma *skb_dma = data;
>> 	struct bam_dmux *dmux = skb_dma->dmux;
>> -	struct sk_buff *skb = skb_dma->skb;
>> -	struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
>> +	struct bam_dmux_hdr *hdr;
>>
>> -	bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
>> +	if (skb_dma->rx_virt) {
>> +		hdr = skb_dma->rx_virt; /* coherent RX: no skb to unmap */
>> +	} else {
>> +		bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
>> +		hdr = (struct bam_dmux_hdr *)skb_dma->skb->data;
>> +	}
>>
>> 	if (hdr->magic != BAM_DMUX_HDR_MAGIC) {
>> 		dev_err(dmux->dev, "Invalid magic in header: %#x\n", hdr->magic);
>> @@ -644,6 +679,9 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
>> 	for (i = 0; i < BAM_DMUX_NUM_SKB; i++) {
>> 		struct bam_dmux_skb_dma *skb_dma = &skbs[i];
>>
>> +		if (skb_dma->rx_virt) /* coherent block freed at remove */
>> +			continue;
>> +
>> 		if (skb_dma->addr)
>> 			bam_dmux_skb_dma_unmap(skb_dma, dir);
>> 		if (skb_dma->skb) {
>> @@ -762,6 +800,71 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>> 	return 0;
>> }
>>
>> +static int bam_dmux_alloc_coherent_rx(struct bam_dmux *dmux)
>> +{
>> +	struct device *dev = dmux->dev;
>> +	const struct bam_dmux_data *data = of_device_get_match_data(dev);
>> +	size_t size = BAM_DMUX_NUM_SKB * BAM_DMUX_BUFFER_SIZE;
>> +	u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);
>> +	struct qcom_scm_vmperm dst[2];
>> +	int i, ret;
>> +
>> +	if (!data)
>> +		return 0;
> is there actually any chance to really trigger that check?
> or just theoretical case?

Yes, it's reachable. The generic "qcom,bam-dmux" entry in
bam_dmux_of_match[] has no .data, so any platform probing via
that fallback compatible (i.e. every existing non-Shikra board
using this driver today) gets NULL here and takes the unmodified
per-buffer dma_map_single() path.

This is the intended gate that keeps the new coherent-block
allocation opt-in to Shikra only.

>
>> +
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>> +	dst[0].vmid = QCOM_SCM_VMID_HLOS;
>> +	dst[0].perm = QCOM_SCM_PERM_RW;
>> +	dst[1].vmid = data->vmid;
>> +	dst[1].perm = QCOM_SCM_PERM_RW;
>> +
>> +	dmux->rx_buf = dma_alloc_coherent(dev, size, &dmux->rx_buf_dma, GFP_KERNEL);
>> +	if (!dmux->rx_buf)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < BAM_DMUX_NUM_SKB; i++) {
>> +		dmux->rx_skbs[i].rx_virt = dmux->rx_buf + i * BAM_DMUX_BUFFER_SIZE;
>> +		dmux->rx_skbs[i].addr = dmux->rx_buf_dma + i * BAM_DMUX_BUFFER_SIZE;
>> +	}
>> +
>> +	ret = qcom_scm_assign_mem(dmux->rx_buf_dma, size, &src, dst, ARRAY_SIZE(dst));
>> +	if (ret) {
>> +		dev_err(dev, "SCM assign RX block failed: %d\n", ret);
>> +		dma_free_coherent(dev, size, dmux->rx_buf, dmux->rx_buf_dma);
>> +		dmux->rx_buf = NULL;
>> +		return ret;
>> +	}
>> +	dmux->rx_buf_perms = src;
>> +
>> +	return 0;
>> +}
>> +
>> +static void bam_dmux_free_coherent_rx(struct bam_dmux *dmux)
>> +{
>> +	struct qcom_scm_vmperm hlos = {
>> +		.vmid = QCOM_SCM_VMID_HLOS,
>> +		.perm = QCOM_SCM_PERM_RW,
>> +	};
>> +	size_t size = BAM_DMUX_NUM_SKB * BAM_DMUX_BUFFER_SIZE;
>> +
>> +	if (!dmux->rx_buf)
>> +		return;
>> +
>> +	if (dmux->rx_buf_perms) {
>> +		if (qcom_scm_assign_mem(dmux->rx_buf_dma, size, &dmux->rx_buf_perms,
>> +					&hlos, 1)) {
>> +			dev_err(dmux->dev, "SCM reclaim RX block failed; leaking\n");
>> +			return;
>> +		}
>> +		dmux->rx_buf_perms = 0;
>> +	}
>> +
>> +	dma_free_coherent(dmux->dev, size, dmux->rx_buf, dmux->rx_buf_dma);
>> +	dmux->rx_buf = NULL;
>> +}
>> +
>> static int bam_dmux_probe(struct platform_device *pdev)
>> {
>> 	struct device *dev = &pdev->dev;
>> @@ -809,6 +912,10 @@ static int bam_dmux_probe(struct platform_device *pdev)
>> 		dmux->tx_skbs[i].dmux = dmux;
>> 	}
>>
>> +	ret = bam_dmux_alloc_coherent_rx(dmux);
>> +	if (ret)
>> +		return ret;
>> +
>> 	/* Runtime PM manages our own power vote.
>> 	 * Note that the RX path may be active even if we are runtime suspended,
>> 	 * since it is controlled by the remote side.
>> @@ -845,6 +952,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
>> err_disable_pm:
>> 	pm_runtime_disable(dev);
>> 	pm_runtime_dont_use_autosuspend(dev);
>> +	bam_dmux_free_coherent_rx(dmux);
>> 	return ret;
>> }
>>
>> @@ -879,13 +987,19 @@ static void bam_dmux_remove(struct platform_device *pdev)
>> 	disable_irq(dmux->pc_irq);
>> 	bam_dmux_power_off(dmux);
>> 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
>> +	bam_dmux_free_coherent_rx(dmux);
>> }
>>
>> static const struct dev_pm_ops bam_dmux_pm_ops = {
>> 	SET_RUNTIME_PM_OPS(bam_dmux_runtime_suspend, bam_dmux_runtime_resume, NULL)
>> };
>>
>> +static const struct bam_dmux_data shikra_data = {
>> +	.vmid = QCOM_SCM_VMID_NAV,
>> +};
>> +
>> static const struct of_device_id bam_dmux_of_match[] = {
>> +	{ .compatible = "qcom,shikra-bam-dmux", .data = &shikra_data },
>> 	{ .compatible = "qcom,bam-dmux" },
>> 	{ /* sentinel */ }
>> };
>>
>> -- 
>> 2.34.1
>

