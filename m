Return-Path: <netdev+bounces-267309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIXNElm6s2lXaQAAu9opvQ
	(envelope-from <netdev+bounces-267309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:18:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0827EB89
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C936308A403
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62D36B06A;
	Fri, 13 Mar 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYOta4Hp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L26W6IOq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663536AB4C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386184; cv=none; b=rv7HCUU4CFHP8hNAdYP9qDfoxpcPIkKx47ECjJteV0FcM/2fY8WWr+RXE7+1qtHCHwke5yZNcU/ezkxsyu6PHWfc8xcX+67lOsEg0UNhdlwinioQnYnAG8kNcrOuAeP5hUzErTiyMaAY7i+vUDLQRY51+2CXhDXZtU3frrkFvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386184; c=relaxed/simple;
	bh=SFwI+Jq/KJmOfA7abaLf8IREH4YS2mFFsWRr7zhWaVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5FIbxF+tatXKuaGISXagStDjJXe/G255wfS38DwuaQMLzb8dysNVp9gXQMoOgSjuylT3S3Chc2mtHh1kC77g3T7KnmbDC2CvNgb6TQWRK4Ilern9wOvsXj7B2+TnIN9E24+O6hBKmUTEVry99xsV2SyvhrMExNRVzonRz9TP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYOta4Hp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L26W6IOq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5thVr070734
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i2IlKIi4brx2n2555N+kXUhgIRruRM2KVO7+XTSNjAw=; b=kYOta4Hp6PVm9IEo
	z0kzYQ7SouURAyJ6rUTTvPIoClsZXCgEpgm9eIegOOHN5QFlkHFjyubBt7hd7hyE
	cbOMlzo76yJn1yxqMtA+ZqwPGfS3bCV34TogNZSJ5/VCPWu5j49ux1+sRj+B651n
	QGMQiDz/iJd05KRzSFJVg/BFBYj4+WjCDwsdxWkF38g0A75m5ktyIstd2V8SbjET
	zdzuNBkA1Zws7sfX9UWbOnpwy2H1OrCtQuJG/DgGhjZ0x0G+e++0ROoTnPyA5xE8
	L1G9gTSRqrfL0RXA+uVzBkq+8GWOL5dpt1EhWOIeq/L6JCiZfHVex8W+W5phkdJb
	rpJ2HA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4ymy3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:16:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4af66f40so21098805ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773386177; x=1773990977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2IlKIi4brx2n2555N+kXUhgIRruRM2KVO7+XTSNjAw=;
        b=L26W6IOq3DoGxMkcjOM63FCCvWwjaQXV68rrx/Zs+ynuApdtW16hKcHLZwM1GuAIOq
         Y5ULnumJFkIvMJBl8hgJGk3ZANh2TFQ+56T4CpuqyhAJrtl1vCEjFLutzKRCE+mY+LMm
         +y5nkjdtoz6z9cACJX8RL78GGhRNS6lLkrZGwU1HhnVKXTx1loHNKHBbd7mAsgDORV8Z
         3WZwXJWzmK+cnewSo8kTBrUcMCX3HSVr0Jq3ndXqzDeXEBs+HPuPZtpfAn6QKpvfp1YA
         XPjLhUb3VRPNGbKg4JB2BhsndzRJZ6pwoNEFo+63VtMcmZ3UvBvXmWp6mWLzg8ZkM8Nl
         zJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773386177; x=1773990977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2IlKIi4brx2n2555N+kXUhgIRruRM2KVO7+XTSNjAw=;
        b=L8HN7u/e1Gmf5j3bC84w3oPt6NjEuk3hU8GHGx36fcH4v3fDqAWCGe5B60VJNEzjbd
         GL/W91JBhokpAE9nOQUxrqngX1L6ISQYDo81JaQciRcXPo2KbJRqyXx5TC5sgGglPXBz
         V9MaHYHhSt+/yr7pypPpMH8jNSYflHfuVswvvKAGBPiKX575BYvBxyUw3UvDNjkzNLVN
         HCCn9G55mNY6Mt+c4t/xpR53Tv2MfSF9SsQmOYofTlgD+Gt4ODJMKR3vTwm3x5ElJKn1
         9j0VHFeUzsHxYyQR6T9xr6GBJBhaqTWRaszQKJpqZl/TnfIGaQN9ftr9QSPRM6jWtLut
         1qvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvnOP/1TnBiysJgBJzkQcppye5GE8hKa3PkpM0vTE+RsGsm4ezrAsfkzTgyox/9G4WNE1znms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdJ2pMtShYSVvtK619j+dS0TlhZArA1h8oE1vE3aI+pwsSMRi
	iqVDlPHBsVkFaWpxzmIJHtfQF0Kx4mSv2JL9OGqtrEs/fO6vXgxo5HFxzwyXGrjqqWMsdNUiVoV
	9a6THxiKcMRFE7VD4uTn//z67Mx3f3uvFPPflMRK/TEcP65z298WfBYtaqDyqBypmS2s=
X-Gm-Gg: ATEYQzw7OiZXxvO/P40q5vUguBrrrDtQcfVSnmSFlSs24r314woCjnU4l/MRSed9rRe
	nrMrjop6CeASAUuHUjXo+4OEVxi/ekf9U75dkYSEp1voIhZumFRlDLca4fvlNvN0J02l5Uq8EVM
	LCf+qGTscQppZmcgAroPGGQuj0/OYehn1bAHCbW4IMRfQIJl/qtMFnxrWlYXTs5K5U27vaIjFYz
	YgYq62lQVZaebKpSBuSLu2m3PCoQ7B2evuzQNZj+Ga3BIYzdSOt7LZnTgznyg7lesg461SIQK+v
	VmBmq4Eks9YPp2cSjE0FkGUbC+gVdHjYtpfV2gMoi5GAH3XHE0WHOWr5FRS5nt6lk1CgAwjcLs7
	Obk6SSo3jiePZ6WRSfTOWAl88T5Fnf1RbjcBcUqulsTj62TiiC2/rUw==
X-Received: by 2002:a17:903:390d:b0:2ae:3cf0:3aa1 with SMTP id d9443c01a7336-2aecaa3bfe2mr25528695ad.37.1773386176725;
        Fri, 13 Mar 2026 00:16:16 -0700 (PDT)
X-Received: by 2002:a17:903:390d:b0:2ae:3cf0:3aa1 with SMTP id d9443c01a7336-2aecaa3bfe2mr25528405ad.37.1773386176268;
        Fri, 13 Mar 2026 00:16:16 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c733sm16610105ad.35.2026.03.13.00.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 00:16:15 -0700 (PDT)
Message-ID: <a17e4c07-1f00-4b0d-90e3-2eeb1e71a248@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:46:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: mhi_net: Implement runtime PM support
To: Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        netdev@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
References: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
 <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>
 <nj4ovttt4i7hsqfdv5zhdotxrx3upxfq4ozuligwuheubnsmkd@e6bwzgkn55kl>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <nj4ovttt4i7hsqfdv5zhdotxrx3upxfq4ozuligwuheubnsmkd@e6bwzgkn55kl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NyBTYWx0ZWRfX8jcdo7jq2ZfU
 u+wDNceiAhVWmF2+LgLbg2irfS1OMjqwPL4qX/j4x0qzDRBWQ4JuTb+xGR2hP3YubIt4iAsBiZa
 JsCfhMA61qKREG2Titl0Gn23Ed3L+kTyRGu6feWAIlCoY0eojQvDqqF44/6CUvtHGuRfkA5E4rX
 dudwZYj4fVQgllm64+rTujIU6Ta879diFjmLfPPS0H/fx1lTbYs+FXdGPPiH1AsELEpgSULsXhY
 5a2cCzVA4avwmAvzibmbp6FnJXEFt9Mq+IxD9S3lXkKc/RgPZ7X+HyrzmclavjUdzoUIyR46M8g
 JXywyuUbGPMJWSRKb8i4RsziESOZT0+YZ6NTjAP3uDIiqIGj2oxZxH+wZ73uR6IVPo/kgEXV13R
 S8n1/p7mIDBrhQNg7G61mc7Tgy1+DqqJAjqxm6Vovl9+txSeLZFk6NzZJvlGQbD5SW4Zp/PDPf/
 +pLE2nqmTIrDndfNUdA==
X-Proofpoint-ORIG-GUID: zoTQkv-LGeF6oHbxZuzjZN_21eyn5EH5
X-Authority-Analysis: v=2.4 cv=C+7kCAP+ c=1 sm=1 tr=0 ts=69b3b9c1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=8pif782wAAAA:8 a=EUspDBNiAAAA:8 a=BRVcir-zca08BhkZB6AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: zoTQkv-LGeF6oHbxZuzjZN_21eyn5EH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130057
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267309-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,wikipedia.org:url,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0C0827EB89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 12/3/2025 3:07 AM, Bjorn Andersson wrote:
> On Mon, Dec 01, 2025 at 06:13:19PM +0530, Krishna Chaitanya Chundru wrote:
>> Add runtime power management support to the mhi_net driver to align with
>> the updated MHI framework, which expects runtime PM to be enabled by client
>> drivers. This ensures the controller remains active during data transfers
>> and can autosuspend when idle.
> This last sentence hints at there being an actual problem with the
> current code. Perhaps we do this because it's the right thing to do,
> perhaps we're making this change because devices are crashing and
> burning?
we are doing because its right thing to do, with current code we are not 
seeing
any issues.
> Start your commit message with making the reason for your change clear.
>
> Ask yourself https://en.wikipedia.org/wiki/Five_whys when you come up
> with your problem description.
ack.
>> The driver now uses pm_runtime_get() and pm_runtime_put() around
>> transmit, receive, and buffer refill operations. Runtime PM is initialized
>> during probe with autosuspend enabled and a 100ms delay. The device is
>> marked with pm_runtime_no_callbacks() to notify PM framework that there
>> are no callbacks for this driver.
> This looks like an AI prompt, does it add value to the commit message?
>
> It can mostly be summarized as "Implement pm_runtime in the driver". The
> only part that's not obvious is the 100ms autosuspend delay, but you
> skipped explaining why you did choose this number.
100ms taken from pci port bus driver reference, I will add the reason 
for 100ms
in next patch.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/net/mhi_net.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index ae169929a9d8e449b5a427993abf68e8d032fae2..c5c697f29e69e9bc874b6cfff4699de12a4af114 100644
>> --- a/drivers/net/mhi_net.c
>> +++ b/drivers/net/mhi_net.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/skbuff.h>
>>   #include <linux/u64_stats_sync.h>
>>   
>> @@ -76,6 +77,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	struct mhi_device *mdev = mhi_netdev->mdev;
>>   	int err;
>>   
>> +	pm_runtime_get(&mdev->dev);
> What happened to your error handling?
ack I will add error handling.

- Krishna Chaitanya.
>
> Regards,
> Bjorn
>
>>   	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
>>   	if (unlikely(err)) {
>>   		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
>> @@ -94,6 +96,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	u64_stats_inc(&mhi_netdev->stats.tx_dropped);
>>   	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>>   
>> +	pm_runtime_put_autosuspend(&mdev->dev);
>>   	return NETDEV_TX_OK;
>>   }
>>   
>> @@ -261,6 +264,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
>>   	}
>>   	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>>   
>> +	pm_runtime_put_autosuspend(&mdev->dev);
>>   	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
>>   		netif_wake_queue(ndev);
>>   }
>> @@ -277,6 +281,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>>   
>>   	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
>>   
>> +	pm_runtime_get_sync(&mdev->dev);
>>   	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
>>   		skb = netdev_alloc_skb(ndev, size);
>>   		if (unlikely(!skb))
>> @@ -296,6 +301,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>>   		cond_resched();
>>   	}
>>   
>> +	pm_runtime_put_autosuspend(&mdev->dev);
>>   	/* If we're still starved of rx buffers, reschedule later */
>>   	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
>>   		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
>> @@ -362,12 +368,19 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>>   
>>   	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>>   
>> +	pm_runtime_no_callbacks(&mhi_dev->dev);
>> +	devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
>> +	pm_runtime_set_autosuspend_delay(&mhi_dev->dev, 100);
>> +	pm_runtime_use_autosuspend(&mhi_dev->dev);
>> +	pm_runtime_get(&mhi_dev->dev);
>>   	err = mhi_net_newlink(mhi_dev, ndev);
>>   	if (err) {
>>   		free_netdev(ndev);
>> +		pm_runtime_put_autosuspend(&mhi_dev->dev);
>>   		return err;
>>   	}
>>   
>> +	pm_runtime_put_autosuspend(&mhi_dev->dev);
>>   	return 0;
>>   }
>>   
>>
>> -- 
>> 2.34.1
>>
>>


