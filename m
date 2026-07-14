Return-Path: <netdev+bounces-307517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qiOfMjBaVmpl3wAAu9opvQ
	(envelope-from <netdev+bounces-307517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:48:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429A756971
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:48:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SpmBG1uL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AG1IrD6c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307517-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307517-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981F8304A666
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0F48123D;
	Tue, 14 Jul 2026 15:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D84963A0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:47:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044072; cv=none; b=K6iIrjOF1uSHG4ozCuH3tmt1xrk7kJmxJlj7dJg21seOJtEv+pbTLUcqyUZno262x77NeqA9Gx7gW/V5vQR7pH3Ddss6nBOUKHKyoA/E9SdKy0MCQk0ay9AAalFk2ubHU/ixgyNcgjUUIdhbZeNW/lNLQeP5HGRoTJJQ9236Ols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044072; c=relaxed/simple;
	bh=UI8L3jXrZB+lzWZFyrflCCgxBDCTbAE23u842wAsS+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbkg3LWct/9MMgAUiZdFWJCxucoF+cgUbEqaaX7c1AQ8uHJPPkprY+Xzmy62fLEbNZMWCDYhRcD01IXNdGIh1FQUGiYfnhTWsQXWzwsgTx7OYHa3xRtHZK0MPFY4+lu9mP1wzkCC2FYM/JL9Lnv0h/c7192JRihvyWeOwZjAk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpmBG1uL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AG1IrD6c; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EEcVma800335
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UI8L3jXrZB+lzWZFyrflCCgxBDCTbAE23u842wAsS+U=; b=SpmBG1uLM3jPrS2Y
	rF5VeXmIvrCcz1zJhsUKFYaokICHjyy2q5iiKCWnhuOLGQkuwSgPJa7UE+q1c9pL
	6eO1+PgmNTsttc8O6RW14lOueTnB1cgSN5HpLSODq9uj6WtE5HD14/he3j7ZJ0AU
	UdbuJzN2nj804VCS3JaFucnmYtaSMLB/rcBTemL1NTNLSg3B/2pncNmMCZJHrOeN
	U56pnf4nOnBkWmwnyhxNQmjgNtZnt2wq36oH+JvJH/5Tgs2Lo+yPuKJV6Ng/HpG9
	011nJBUpTyMMoIdgtfA82ZiT/bQ82kW85F8+0YG1GM39YAQ9CFvXv2dIY3Ynekii
	fWTKFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr0q6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:47:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811279d51aso2190574a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784044066; x=1784648866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UI8L3jXrZB+lzWZFyrflCCgxBDCTbAE23u842wAsS+U=;
        b=AG1IrD6cw4iZnarjVNKDpmq+cSgI9bK+EPITZPNzKX5ZvNKWwgF/PQyy9utoO4tSZq
         6A4WSKLbkkDd5KM1MDSVmY6LBjWalkUjagvqjCMUov9pWmKwE1bAadavdEb/Aaz55MaR
         k5SKKb7wdy79Z780oT2HX62W0RG6BPMAVAFehQzKR5JS3EqfwST8nLkiYCOs0ZEyGV9E
         3yR7kpLSaxChp3E208N/KjGO511bS4dXCxtlrG/ITmESF0sT3fl9aps/W5dWYmzs5OZf
         bwUE3HCLKs034ckMaY/O6tonyL4UUJXBa0GLA3NiZCFywwz7DDIzo0ezI6hiGBoTKX7W
         IKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784044066; x=1784648866;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UI8L3jXrZB+lzWZFyrflCCgxBDCTbAE23u842wAsS+U=;
        b=FNtk1VaqTeBZM9mMi1c1IQjAmCVRagaUp5SdGJJ72/BkXtjNRDeFmlwIyymldGRFgl
         HNStImTtRc5148M3ScIGroWwJ9bxupOTsnXWOvzJwVe8LzBlMcjAeRnwGtErKgYKYcvD
         ka+AN/BF4uRG/bBaaGpj1VRdPC1qvdKUje6f2CRBtyQQxuE9GryFeptBfQ+IPUEGrBP6
         9msrtYvXZwSzMajl5GKhtsW+0jJyBdCDp1K+Ma5LKPW8B80jiTqpHTlDc9IUZXoJDMdK
         p1p5adHsI5ygVPQvmV3NyWRnfF+RH4vRN8QmaYCowrSBgnzKD+VdD0NoVWz+8fqNajJE
         tQog==
X-Forwarded-Encrypted: i=1; AHgh+RotIOuyeDt8ZVUa/xUiX83BE3wIl33vKStgacPPFsX/tO4oF4nQ8PU2Q903upGDxpxmWw3aHzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5roB8UPNY/9iDj6Q2sNiZbGGe8UG9l/TaoQ94TXhlmkL0GkQR
	2GzRctUlMN4HC3Nr+BdTxt1yi/fdWHYOQ6IJlh0mpGgUltrld/J1JjWSKqIRwdJdDG0G6aIqh+3
	WnVwrg+K9QhBS1up5YBzUZCVhuZfSEWBSuUrR/2PI0LDOc7qm1VUegFwVQqY=
X-Gm-Gg: AfdE7cm+6PKjGtFpKUZ9GU/YjRvIw5hOBK/hz+dy7KTL7+diVHy+upszS/E7ox9hARF
	kWUe0c+Mdk+WQL3qVko8FNjbB2pJiqSqAu7VFG1AIh9bf3WyBvRO/n0HvRw7e4/T7Tx4e3GOlVr
	wTzg8yicDgFei6QcqnPpQUFn56QfNlrk0bcOIXqp3YhuAfzVlGQsQJlc0l7PAkW/yrzW6Xkku8Z
	8BkeH9MRlfe8B0AFomDDJY7/h+UoRr0/r2lNibSK497Oq2XtR6XACPahnCtVc6JEVJnD89c2wdp
	aTeYEBCosIWoBdQHur3a15oUSdYkfINzXpEVDk5HLlqdkrAgZTd5gESPjoRYNkWEWu8+oZJKpYU
	zk5ycsTW9b6vrhcSZZvrINMqXtKoj27DujVd7gf28Srfqkhw=
X-Received: by 2002:a17:90b:38c8:b0:38d:dbc7:5178 with SMTP id 98e67ed59e1d1-38ddbc75254mr11115628a91.22.1784044065762;
        Tue, 14 Jul 2026 08:47:45 -0700 (PDT)
X-Received: by 2002:a17:90b:38c8:b0:38d:dbc7:5178 with SMTP id 98e67ed59e1d1-38ddbc75254mr11115587a91.22.1784044065298;
        Tue, 14 Jul 2026 08:47:45 -0700 (PDT)
Received: from [192.168.0.116] ([124.123.151.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm84444133eec.30.2026.07.14.08.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:47:44 -0700 (PDT)
Message-ID: <582d12f5-bb73-4702-9e10-234d46b3fc93@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 21:17:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a
 single coherent block
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
 <alXm0rp3NK62G3-3@linaro.org>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <alXm0rp3NK62G3-3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfXykRgH8N2UaY4
 topeERmq7vCUh7JD8lJK8Uy3Z2WZplK20Y7CM1fqStbwHobOlh6RCne6/PL8ynqPJ9BHDXyFtny
 a+hkdgajBWENVszzxZ8Zjcx7lIJyheg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX8Jop+OcS0DPF
 9CNoXqRRCDf1Tmsh5IP7U/X9JaEeDGtn0g1emgnerwpLklwYRxBZL4amO1lpTVYSQExalHVlO5e
 l9LQJz5wTir1MuukTgKjx9RSmD+val7cYvQdT36yVQfzkpvyt78vN/79xE5t/2hyDbvKa2L7sWY
 rZOmTAn3dljien8NeSSLblyGGZJeTPbqCDEToinVGmZb3qSkFR+Z2ql8PFD46ZnHgpgnNkdRJQC
 5tgs9t/hTH9Mh7oxegfFcpKUWe86xQw5f+bkfWFcQjmYfykekD2HWWXpvtQ5RLhFTVnJCGdBZq2
 Rs9kfpZngOzqVt9l1ZXWnyd58qtwTxoH6Dw5p0nT2AnTzoA/EW6R5x28V7sPjVeiYkpQhCJatJD
 3N+uCB/Rd4OcKAFOPkRBWoIW8tIzYjovY3S3TZCp00SPuhgzdJEYEc3FQ3vS5rqrVGQbV5YBLom
 q6e8Z0It2lHlYF/uXxw==
X-Proofpoint-ORIG-GUID: eEEa_HPzOxH8QegI4dTjBVgSb_2_BiMh
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a565a22 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ziBI+Y3eO/H+UwYWWny9Hg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2eDN7aXksB4whfXZn5AA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: eEEa_HPzOxH8QegI4dTjBVgSb_2_BiMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140164
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-307517-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephan.gerhold@linaro.org,m:stephan@gerhold.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gerhold.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 8429A756971


On 14-07-2026 01:05 pm, Stephan Gerhold wrote:
> On Tue, Jul 14, 2026 at 11:02:32AM +0530, Vishnu Santhosh wrote:
>> On Qualcomm SoCs where the modem (e.g. the mDSP on Shikra, VMID 43 /
>> NAV) is the AXI master for BAM-DMUX RX transfers and the XPU enforces
>> per-region access control, each individually DMA-mapped RX buffer
>> requires its own XPU resource group (RG). With ~16 RGs available, the
>> 32 per-buffer dma_map_single() calls exhaust the table and the first
>> inbound transfer faults with an XPU violation.
>>
>> BAM-DMUX is a singleton (exactly one instance per SoC), so the
>> destination VMID does not need to be a DT property; it is looked up
>> from the compatible string's match data instead. Add struct
>> bam_dmux_data with a single vmid field, and a shikra_data instance
>> hardcoding QCOM_SCM_VMID_NAV for qcom,shikra-bam-dmux.
>>
>> When match data is present, allocate all BAM_DMUX_NUM_SKB RX buffers as
>> a single contiguous dma_alloc_coherent() block and SCM-assign that
>> block to HLOS plus the VMID once at probe. This reduces RG consumption
>> from 32 to 1. The block is never reclaimed across a modem power cycle
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
> So how do you handle TX buffers? Right now, they are just passed on from
> the net subsystem. There can be up to 32 TX buffers in progress as well.
>
> Overall, I have mixed feelings about this patch. It looks reasonably
> simple, but fundamentally I don't understand why we need to go back to
> the old days of implementing protection using a highly limited MPU (in
> your case: the xPU).
>
> Why does the setup of BAM-DMUX differ e.g. from the setup for the crypto
> engine? Crypto is also using bam-dma, but it avoids this inflexibility
> by making use of the &apps_smmu. Is BAM-DMUX not covered by the SMMU? Or
> did you just decide to bypass the SMMU in this case? (If so: Why?)
>
> If you had BAM-DMUX mapped using the SMMU you would get all of this for
> free. No changes would be needed in the BAM-DMUX driver ...
>
> Thanks,
> Stephan

Thanks for pointing out. We were seeing XPU violations on descriptor
FIFO accesses in the RX path. This series resolves the RX-side faults,
which is why we posted it. It appears that the TX path requires equivalent
handling, and we'll include the necessary TX changes in v2 of this series.

Currently, the SMMU does not cover this A2 BAM instance on Shikra, which
is why we opted for the SCM-assign approach. I'll check with the hardware
team to better understand why BAM-DMUX is not behind the SMMU, gather the
relevant details, and get back.

Thanks,
Vishnu


