Return-Path: <netdev+bounces-258254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMKxBgdZjGm9lQAAu9opvQ
	(envelope-from <netdev+bounces-258254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:25:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF901234AA
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01347301D049
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B7366DB6;
	Wed, 11 Feb 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGY0kZ6h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQBRosrI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28D3570B1
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805508; cv=none; b=X6G3l1S36wtZeXowBdsTCTE8ws0FJx6WnI7k1uIKrQF8h5iPOv4pm4IX1dm0qBav6E4npo0FrDPZlGPxJ/WhGan4LXf5R4qrUkEHi/3wBsjp1vcF5bOERzfPN8qx1OarLwXGlC609sCA3cHLfTMuDnl71b7RrWrEkuNzB8ue77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805508; c=relaxed/simple;
	bh=Cl8ck0GuYNDR48oIXUJNz/BULGIgVDYNWMtl2wLzWKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdNYoxtNGybJ33dzIqQOeFj/VRbPLaHMOFLLkKKnPVXgRG7Rvm0k1rrmTKSUGUn9UDiHTf2ZdJ6zmeQPKiJcF1AsEbfI16V2osUI4nGWyaxdD4j4lZMiRxwcBmGAp6+JhuPMJotHodXgSf8eRTE1blG8vEM4detRHITb8zq3hMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGY0kZ6h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NQBRosrI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B3cT7Q837967
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d/+bh2HNeeTdt5zusNux5prvurN0Yp81hH0VAMMHLrE=; b=ZGY0kZ6hAeLy9bLL
	i/OTmeS5JZkxDjGrH03rq/Ny7F5hqGP9H6QRR2ev6+BiEs6xr0YJTy4FC5hd9qMw
	dnFBreBAqT7bRJA5wNs0FVjCDwi8dStKQ/lbQn1AkWTjktITU3WLvhC8acuc6DeB
	Q/10QprokpGSreAvfP0RgqMZSPR+myA6ND2QfHKnWlnvtJvTgY1nh+WheQkIQtpt
	AaKqMcSacyYzuWFQxZS7BN2UlWU9/BEhZKGodnOu/2w7fFLsVb+bPnoJkzAgF8wK
	mEjWLCYSCpf//XwXlERKcJtyL63NYXH5qIWK+IadIHZ4pL3UByIL229SzztViD2w
	5IDk4g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8j1t969u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:25:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824a02e4d29so173923b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770805506; x=1771410306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/+bh2HNeeTdt5zusNux5prvurN0Yp81hH0VAMMHLrE=;
        b=NQBRosrIru4JvpviM5BpxcE7IITAFVTnXC/+tHE3nKWxtKF9Gg3uBuZJp+nhumGu39
         qoxFFWEnbYbrvHCcsdDOU+pCmlaPcxgsCYKV9r8SpYmpLjeA8FTzcNby7i301prSitwq
         REjmFQPGCu/g5S2DyyqB/Z8EEMqKg0qTD01/B6u+QcbJSoSwujGbmfSRgxQEQFHlQdAP
         lYAs8MZvWm22Wc8dXIasL39TAtypOHkmmp77lmNca7G8oSG5a/+chrxL4U9ZG0l7O3l6
         t89YfCy23qmXiRbX+ZKW21UXm7HCiE9hlJx/cl4We7dW0avOi5/U4Y42T3wgUjwneTdx
         xtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770805506; x=1771410306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/+bh2HNeeTdt5zusNux5prvurN0Yp81hH0VAMMHLrE=;
        b=uVsKoOsBlF/MrTknDeqzF/T+XBhmcJvaWEyY0Sc8kyXMJzQjHRfp3AKb138SpsM9SN
         jA/O/vLduxH+yO7E0JAN8yVLu4Ux+j0bOLtI1m0YwgI0SAbuR4MNPuwAoTbwl8f0yWAy
         499w6Tk6FmzvHMnY7Uo4iQ6BrT1K/oWUKCHUUHi5YbTQuLmpq6UmBBWmFSNtWH945PUp
         P2hr09Botffi/K+94Xiqyy+lh2cYY4956BWdwNLHbRP7G89uAsW0mOwxOzQhQsHtBztg
         4wyFJy2WmB/H5hL9nWqq15vPKWGlyx6tTTczLJQwRTZpfIeLi1VY2nfh6vxn4gVJcZq3
         YslQ==
X-Gm-Message-State: AOJu0YxHn/KrcZTmNHumcA1V9BOvkl3h7oXHYIZTGuqp0vFcTZPCE12w
	sEi39aFktkGEW3UQqowcJMqXjeSt+xH5uyEf9wXBDp07abgvO1cpbz273A3O0yPxaYKPI0TiBz+
	yy3k75MLG1+IbkdO5qDO2RGb5L0uMDe8Htv3vHWH9FIGzZUvzuq4Uy4O1wzI=
X-Gm-Gg: AZuq6aI+x08P53XitfqgbIsK0SyOdpoanv6zBrl5BIsSeTMM2SyBStRs62J20hnoFzH
	NTBMjgiphMvsHvoWG1Ywg+7HqifzwEOSbqE6p1bCw+LX9h7vFhtp096tt/yIj8fMUlvuMFsY/yZ
	Otc2SEebbfY1aM9njkdVSbnyH/cpJapnlxqhX81JQX1F4+t4pqa6RAsCUXhj981GYPxgySxPn7F
	7cMThJQ5gTUGJgAnT1Rk+Cbn2JiDw4Xhij3U6LIEqrpYRzHPDG6cgKyM2sh5Nzrc0lQoq+VSeIw
	opjL8FAW1Lg6g83BPIFqGV6YP5V67DJdl++IqtbD/VvZS9h5AehKfxH1Ugc3lUGnF0CklaFPTA8
	kFFsTYXWu7iyfk+6BPYHoAm9GC/UGPklidB4NNaSuZbDqpl1f4bmmRQEONQ==
X-Received: by 2002:a05:6a00:3407:b0:81f:40e5:34b6 with SMTP id d2e1a72fcca58-8249aea26e9mr1918586b3a.15.1770805505547;
        Wed, 11 Feb 2026 02:25:05 -0800 (PST)
X-Received: by 2002:a05:6a00:3407:b0:81f:40e5:34b6 with SMTP id d2e1a72fcca58-8249aea26e9mr1918573b3a.15.1770805505110;
        Wed, 11 Feb 2026 02:25:05 -0800 (PST)
Received: from [10.217.218.153] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e81976dsm1990933b3a.52.2026.02.11.02.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 02:25:04 -0800 (PST)
Message-ID: <d24a947d-6b6e-4393-b0b6-1e9281f8a0cb@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 15:54:59 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] net: mhi: Enable Ethernet interface support
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vpernami@qti.qualcomm.com>
References: <20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com>
 <20260205-eth_vdev_next-20260204_eth-v7-1-f85645210f81@qti.qualcomm.com>
 <59e7518f-65b2-4d97-ab81-bf64af758d00@redhat.com>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <59e7518f-65b2-4d97-ab81-bf64af758d00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NCBTYWx0ZWRfX4zFkQN935Q0z
 oolSHOWr8QEEUI2Zug1loDnAnJItcfHzMl8AiLzF70Wc4A/pKXanYCRnw1G4XjmveVivSIVx3Rk
 o3wSeEY+Z4ezg/curbODd+LUu03PeeFAilYgP1T1PREdlIIJucEoCPCXfITlVZE815GNy2cuoBl
 20Vj2mL8rV2VUmwrHU6xA8KSuJ/PKXVaHRtP3QuzpsoK68xjgVBTS+riZC5fBuvjTAFXMW4FGN/
 0yu9jKHN8wHjP+6dU0k9LOF3GHLivDsJI1bt1TMQ8OIuD63gNoxPGNl4P9W606a8tfjznzNLLdj
 +c6pO1Om4L41KumQ05w8vg6vtZpN9909F+Eyo//Wx+KyzhR7LspTfPTwocxHN7ZOL+u+X68hLmm
 6d9i4GzSC2aazCe9ABWZi46BSypNxdkzqcY+gsgbZdgTCx7Haeg34k2CmmA3ABF07Zz1vEg4E/1
 Aky/RihfWa3e8d+PN1A==
X-Proofpoint-ORIG-GUID: kPn5YCOHZ37JgIA4EO49pQDHV5o9iA9e
X-Authority-Analysis: v=2.4 cv=cabfb3DM c=1 sm=1 tr=0 ts=698c5902 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=yHe4pzvUYGwmH7u3AtQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kPn5YCOHZ37JgIA4EO49pQDHV5o9iA9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258254-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6CF901234AA
X-Rspamd-Action: no action



On 2/10/2026 4:13 PM, Paolo Abeni wrote:
> On 2/5/26 11:34 AM, Vivek Pernamitta wrote:
>> @@ -4,6 +4,7 @@
>>    * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
>>    */
>>   
>> +#include <linux/etherdevice.h>
>>   #include <linux/if_arp.h>
>>   #include <linux/mhi.h>
>>   #include <linux/mod_devicetable.h>
>> @@ -38,10 +39,12 @@ struct mhi_net_dev {
>>   	u32 rx_queue_sz;
>>   	int msg_enable;
>>   	unsigned int mru;
>> +	bool ethernet_if;
> 
> This is not needed, instead you could check !!dev->header_ops
> 
> /P
> 

As this driver supports only Ethernet and IP net interface types.
Will remove the ethernet_if member from the mhi_net_dev structure
and use net_device->header_ops for interface-type checks

