Return-Path: <netdev+bounces-304329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4LQbAes6R2qDUgAAu9opvQ
	(envelope-from <netdev+bounces-304329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 06:30:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF9A6FE6E6
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 06:30:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NhEgygR6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="MLLTQR/R";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304329-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304329-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6732C30488DD
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 04:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17931ED8B;
	Fri,  3 Jul 2026 04:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1ED31F993
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 04:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053031; cv=none; b=jp79N5HIPl1P/MtLVXUPtpSU/WPjsuQz76YITgTip84Iqktn6TxKdBvPAAfFLBh+rpJjU2jmDvuKPSNRjMqlPlB1V2W9nEBzJVCJ1gOd7JSvvxaNRaFOzaOTTJwzwtRqFU7ByvEksjS1JUUAgJlAIk5/2E+EyaywZJWvefInmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053031; c=relaxed/simple;
	bh=nvJK/KTbntGuy0BYZL1hNDwOlR+oX1X16iRtb9Eq4ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkN7yyZbna7rf7DAPg36Js8v5gRfn1pDuUK/T1g46aFjqT5s3xMU2m4CCJQC4f8h110kNDvBfYHgrvoarvR163hpky8f8yVKx+8sB6RhVpQtSIIitA+biNFekI8qvmIFGIj7PYOJUG4njQWLftVRHbyA5FNBvJDDmpPm82U9U3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NhEgygR6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLLTQR/R; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342lCp2655000
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 04:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A18Z48GLxT5LW9XCfkBo5cci2Vmn0dPJsWkS1+qliUM=; b=NhEgygR6+nRceuKi
	93lA6e1+cmZCZg3xqu2kWKLLkr2bWKvZqfnFvxDgwFBfBCUW7siQr1+l0C8lG7cZ
	5AFqveouuc0Qogsh3kdeF3iTMPxiTFYumWWWbfinrtVxgmPJI9Tb/47BilvgZiij
	/KvsTgFDQ6G1PVYmILrXm7bWf/5Dw0HLmRI8JI5xcG73+bGI01/dtBXbqZlYVHYo
	rrgsxRpMNJpibOD912zcFGSzMXEfjXDhCnAqu7xSXLLEXRsEirKN1CTBZievC+4k
	g10DbQyXegiTte5y8jS+AVJoQrIXW+5p19Nh0OiwsMJGBlxk3hfEcxIy4D5Or7HQ
	EB9Log==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5nprc0mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 04:30:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fb9d7b524so265525a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 21:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783053015; x=1783657815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A18Z48GLxT5LW9XCfkBo5cci2Vmn0dPJsWkS1+qliUM=;
        b=MLLTQR/R/vnvyRSS+xpGMXy5OGThlUUg2wdV1o4bKA/mHv7WKP7Top3nn1uHQ7JwcA
         Sz76iCnlKHCQaV0/vrXOm2BVt8JEJ65h/V2GzKEppM4oswnyFl90aWo9+whiboX+l60i
         iMprNeRsiZT/2nqCifAqBP+yfrUCaGM8NejIknDx1277uLkiR/UhJUlyWiU7LUTYCr1w
         9YUi5P9LFZkUVQyQaUjQkBLc21jnv+B2/MkTZ4ZMXaEK3a8z8m+fNp+7fLkNjuBB0oKY
         YCg2AR2XSMEHf5hOqA4sZ6Jacv2pOruLXVmYd7fiKvXOeiAd8OYBAZ7Si98eJQrZvTYW
         cOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783053015; x=1783657815;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A18Z48GLxT5LW9XCfkBo5cci2Vmn0dPJsWkS1+qliUM=;
        b=DRWhxhdj/8ngXDGXmG8rYA1uAtoXBO1CiN+bWEw/CP5luQ0m0QHMpRZR3ko+oRVGYu
         T671btez2E04JRWHe6xsBRhvEZds0b2Z4FYshTXWBN3Prjitt8RkidE2h87Id2IcTA1U
         RN+E/q+6dlXDLMFF78286ZO9slM02p2HNnh0a66rB8D3paZMdAAcqX4qSgGkFTs8xCVl
         Enf6kYiHQKexw8nM2+YZ2CxjxwkunL65JNjtcToIYjC1I6Gig53cAyWt9abOrgNnCTtO
         vFJHo0Cs8xnDJCkZBiKy11RHs89MtZ7lFtLoasp4P3p9U28SxSmwE9A4Y/lP0PUzJ8nH
         lkTg==
X-Forwarded-Encrypted: i=1; AHgh+Rrcf9p++SABnCzny9jOc1bTBs26UJP5ozbNxaIik50DP6zn5+dExInmDxnyIi+VPNXqxNjZ2DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6E2mm5hrvwl+bE8ZHw3pMPhCTmPLjpalkkqhZpyG2YgXaS+mG
	xvjczZ6dJELKR7XyypZO1qAthaLa0eMoOO5D7Tuv3EPJb/BdTx+//ua4E4h2oiSHcpEUlClZ1gz
	kh+eSwrmTbkxCDGjDpfWBcLOhhw1ocQM4W9zP232CitWMVfLHIT9WG8pncpooMnz9EE4=
X-Gm-Gg: AfdE7cm2RzpPuKhkqwBeoEiXRxq7HcVgYDcavShXkfpVgmaT57g3hhMY3y+kXZYjqDS
	Ro3VoVt7LmvYcUfnfxEvFdbAJFSrGGE3a6KJ/iTJ8Vl+ojk4CkCf+FOFt7uk8ghD4U57kiX13kB
	LE8Sl50O5LlSvqHKr8uJXLoggIg59CeAYXnH6G+PjMImKBVZ1e4wI7lPHwiemWPygIr7S49LOSd
	RwXFDE7gg1/KwjUmrCpvnrZ12j+MVqo52uWOUUQ/TsNLYjUBQZA5l1Lm1f88aBhx9VT9LRzwXrV
	FUMY0cArLKbqnD9nMPh5uNTvXALEgSKhWy+OGjwQSOIxry1tXO92Sb9IaKvw9Wroi2uWbsGryY8
	LuLM2YKoxTR3hSCa3N1CASXi+HNqvLvlMwDt84PNj6eE=
X-Received: by 2002:a17:90b:28cc:b0:37f:9ce1:7360 with SMTP id 98e67ed59e1d1-380ba961e32mr7862286a91.33.1783053014789;
        Thu, 02 Jul 2026 21:30:14 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:37f:9ce1:7360 with SMTP id 98e67ed59e1d1-380ba961e32mr7862261a91.33.1783053014202;
        Thu, 02 Jul 2026 21:30:14 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm26079276eec.9.2026.07.02.21.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 21:30:13 -0700 (PDT)
Message-ID: <c53fe666-7cca-4d25-8ee0-a787e5d1bbce@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:00:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] bus: mhi: pci_generic: fix Rolling Wireless RW151
 MBIM channel ring size
To: zwq2226404116@163.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
        Wanquan Zhong <wanquan.zhong@fibocom.com>
References: <20260702100013.545593-1-zwq2226404116@163.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260702100013.545593-1-zwq2226404116@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: T8VvesGBPUx5CO3KccmZjvjE52XTJRlC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzOCBTYWx0ZWRfX8eGYnRJVvWAc
 g8IaTOP19iile3BLzv+tLGiEZVcRYpAT1GWB+fhRCtne3znxPtFa7VGCQF9vLfsdAFgPvZPmSOd
 NKA1gNP3D57y+y64EFlPsCa8ZM74HlA=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a473ad7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Byx-y9mGAAAA:8 a=6GUwiT5CAAAA:8 a=jCkg8xpmUld7mFY_8ykA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=tp1klI1xYmtLYojU9LVd:22
X-Proofpoint-GUID: T8VvesGBPUx5CO3KccmZjvjE52XTJRlC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzOCBTYWx0ZWRfX0DQQit6VcUOp
 PFqAwhYeUsQsxrP2PHas8Uxdys1gEwiDYqApsV78cnSlqqyvJ2X6itN5SlG6MFxvUgk0DM3lJpy
 wR7VWu00JXx4FyelZXpGx6bx08XbpJOUb8YYrKDb3KOlr5oEMf76UH2a4ILHOYr1R7KnUnK9shO
 R5CYacF9Y/+vZami95H/WZ+vqabGz6oGeV8Qsm3C8iCbPWngF3Ud7vS1+LsXQ3ZLGC4vcIl9ZdT
 T0SlvjhnC0AVmCB1A8XCbKuvjbDI6FYhJwHTW/gbElvWAXeUf9k+eMn1G+0d1odNfFsfMpxsyMi
 6F1fYeepEZbQNOesS1h4C0u2Nblb5OqqE4b+q/g+txUVKPCSckk42pjsBnfMzGhLePqVW6zudJG
 PfYM6NSRLBy+sjdlMg2yfUb2d8Zka6SUhbkA/XGVCMTdAW5Y4Zs2l8V8o62zGgtY+2q1bMAMCTU
 UJepFDhwq4UAXipuumA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmail.com,lunn.ch,davemloft.net,fibocom.com];
	TAGGED_FROM(0.00)[bounces-304329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zwq2226404116@163.com,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:mani@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:wanquan.zhong@fibocom.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,lists.linux.dev,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CF9A6FE6E6



On 7/2/2026 3:30 PM, zwq2226404116@163.com wrote:
> From: Wanquan Zhong <wanquan.zhong@fibocom.com>
>
> bus: mhi: pci_generic: fix Rolling Wireless RW151 MBIM channel ring size
>
> Increase RW151 MBIM channel ring size from 4 to 32 to match the device
> firmware channel configuration.
can you include what is the side affect if we don't have this change, like what is
functional issue, low throughput etc.

- Krishna Chaitanya.
>
> Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
>
> ---
> v3 -> v4: Drop no_m3 quirk per review; keep RW151 MBIM ring size fix only
>  drivers/bus/mhi/host/pci_generic.c | 2 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index d598bb3b3981..d686aef6e158 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -949,8 +949,8 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
>  static const struct mhi_channel_config mhi_rolling_rw151_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>  	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> -	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
> -	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
> +	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>
> --
> 2.50.0
>
>


