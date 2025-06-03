Return-Path: <netdev+bounces-194735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C9ACC2FD
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4460C163D1C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658127FD5D;
	Tue,  3 Jun 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T//90NN9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F262C327E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942850; cv=none; b=YLN/t+7cRisvMOrbqKt92vDIcARpDTZqFgWclTnfkuKQgdoy0ceslSXeXhuIP+2it0Mrf38JxctAduzB2OYk94/VVcn3VRs4x4n4o6zzdElc2yTEjUXePzlohB1AE8mBumyRT32SkN9yTOOt92d9Uwyo7ID6zHMKYvX3jVQSQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942850; c=relaxed/simple;
	bh=2hMem/KqDeI9GDbv4TmP7Cw42i8qowh8O7PAaxFouC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEwod0cpRim+fkz7iu5evgbyuzQ3QQe6HnLZEYP7z6y7UxD4P7wcoEc0wIVQ5mLO2zlYQjZFpCx6ZH9OwUYVXBq+fx4zf4PNr5HjIS655zDrbpJ/TSu7rAlIxc1bij/qsarEsLRDP5K2trojEt1w+yvNLsoKMXsXLR0UR8BGqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T//90NN9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748942847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8enqeYQbzg4jaVPoTSHLBVjvDlbQarwlHPEkIaRNBE=;
	b=T//90NN9swERXfOuBsAn9dVOVsclY7hMMyoNDQ1yP4XPF4WkVKnmE3dQq2rOUqboRR6Y2/
	DRP2PbGgcSuzp/ByRyrdoM3YMQOzt06gguoW51R0Nubf9v8Sa3URwFsXzjce4499sAmwQS
	uz5fC3C0o/MUD+2/YVaMvCVfEabqRpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-2CBhuUMnMc68nLZsVztElw-1; Tue, 03 Jun 2025 05:27:26 -0400
X-MC-Unique: 2CBhuUMnMc68nLZsVztElw-1
X-Mimecast-MFC-AGG-ID: 2CBhuUMnMc68nLZsVztElw_1748942845
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4ea7e46dfso1636965f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 02:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942845; x=1749547645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8enqeYQbzg4jaVPoTSHLBVjvDlbQarwlHPEkIaRNBE=;
        b=eyIW7dtLHfrcvsitrPV88rSAKn+cnuTocQ0iqdBQArx6GJ2uG9tTCrqr28beN4/iXk
         qCKazSDNLmdCAFIoaTXSDrM7saDu6IlpCCqiRRwlFkvQ6P+DOHLur7q5uC9DbsP124Kt
         hw+vlBJtDRoVwqzPBpbQbSAguXYbmFedtJlk0cHsxjrLfHWe9sBRAUrCKa5eO0PMrYjs
         5TAiLwAhHW9pfluYJ0OeKopJahbq+J6kXVwhT+Zxi6rgWSjEFUV8GJax5MEFSrOP/oo5
         d8l26wOnCwiFOPmovCPdRXcWdy7ctrTWV/0orcl7mnDSDoFf1BCqJCyfdvVgh0Sqb9hA
         xS4Q==
X-Gm-Message-State: AOJu0YznqKL1GnuzgjdRYJg6jx10UGXDBvJ9ex+HL0h6uPGKyRvj0UNK
	57rYbYGj7jDLbwvrj/IktA4yQAifm7pNrDDy53YyxsyqCsd0HWWJr4BPSgA+kbU+yXLgCyJiAmC
	brgYJpiIxgJY7hihDdaCzWImn6//Gl/5oK1jz3L3mC6al33PjlReSlR15xw==
X-Gm-Gg: ASbGnct2/aXxrva60ajaWWoPBKvsgSFMp0goYrf81WFqdtd3F4A70H/3SFrCzpUnqhE
	1AsP7F79ST7xIRbal/d5yi4onS2+bHeRR+HTn/fZ7CSYfAts8fgt65EfwW2m0y5bjmtYw+qH6r1
	vRgAe3DTyd0qnaNO2k2z8ygjxbGc40bVR7Y/LpUxxWUVwKPau8qqHq/Bz5qwI08C7VywBZlzzpM
	vhacKkAEdXw/Z+7y82SGe+PeNQ4Ijbd/V1ov7jzJs4ccvSViwKJsktkS/jzCqddK7MPxJi5yneu
	JrMjohXEYymhPdhM2n2Y0tz89E53+ujENto8D0F0PUMiM6qpRYRXyvW4
X-Received: by 2002:a5d:4e85:0:b0:3a4:f911:8d93 with SMTP id ffacd0b85a97d-3a4f9118ed0mr9886362f8f.31.1748942845464;
        Tue, 03 Jun 2025 02:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3E8LnB/PqSELpQDG+6H33vKSzf9Q13hS9eE9fktyrONE+k1arXEMdhNoJ6Q9Zr/vUTIyhyw==
X-Received: by 2002:a5d:4e85:0:b0:3a4:f911:8d93 with SMTP id ffacd0b85a97d-3a4f9118ed0mr9886338f8f.31.1748942845062;
        Tue, 03 Jun 2025 02:27:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972aasm17987538f8f.66.2025.06.03.02.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:27:24 -0700 (PDT)
Message-ID: <6440a277-536e-402f-a47e-43ee182b22c7@redhat.com>
Date: Tue, 3 Jun 2025 11:27:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] vmxnet3: correctly report gso type for UDP tunnels
To: Simon Horman <horms@kernel.org>, Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, Guolin Yang <guolin.yang@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250530152701.70354-1-ronak.doshi@broadcom.com>
 <20250603072308.GW1484967@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603072308.GW1484967@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 9:23 AM, Simon Horman wrote:
> On Fri, May 30, 2025 at 03:27:00PM +0000, Ronak Doshi wrote:
>> Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
>> in a tunnel") added checks in linux stack to not accept non-tunnel
>> GRO packets landing in a tunnel. This exposed an issue in vmxnet3
>> which was not correctly reporting GRO packets for tunnel packets.
>>
>> This patch fixes this issue by setting correct GSO type for the
>> tunnel packets.
>>
>> Currently, vmxnet3 does not support reporting inner fields for LRO
>> tunnel packets. The issue is not seen for egress drivers that do not
>> use skb inner fields. The workaround is to enable tnl-segmentation
>> offload on the egress interfaces if the driver supports it. This
>> problem pre-exists this patch fix and can be addressed as a separate
>> future patch.
>>
>> Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload support")
>> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
>> Acked-by: Guolin Yang <guolin.yang@broadcom.com>
>>
>> Changes v1-->v2:
>>   Do not set encapsulation bit as inner fields are not updated
>> Changes v2-->v3:
>>   Update the commit message explaining the next steps to address
>>   segmentation issues that pre-exists this patch fix.
>> Changes v3->v4:
>>   Update the commit message to clarify the workaround.
>> ---
>>  drivers/net/vmxnet3/vmxnet3_drv.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
>> index c676979c7ab9..287b7c20c0d6 100644
>> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
>> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
>> @@ -1568,6 +1568,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
>>  	return (hlen + (hdr.tcp->doff << 2));
>>  }
>>  
>> +static void
>> +vmxnet3_lro_tunnel(struct sk_buff *skb, __be16 ip_proto)
>> +{
>> +	struct udphdr *uh = NULL;
>> +
>> +	if (ip_proto == htons(ETH_P_IP)) {
>> +		struct iphdr *iph = (struct iphdr *)skb->data;
>> +
>> +		if (iph->protocol == IPPROTO_UDP)
>> +			uh = (struct udphdr *)(iph + 1);
>> +	} else {
>> +		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
>> +
>> +		if (iph->nexthdr == IPPROTO_UDP)
>> +			uh = (struct udphdr *)(iph + 1);
>> +	}
> 
> Hi Ronak,
> 
> Possibly a naive question, but does skb->data always contain an iphdr
> or ipv6hdr? Or perhaps more to the point, is it safe to assume IPv6
> is ip_proto is not ETH_P_IP?

I think it's safe, or at least the guest can assume that. Otherwise
there is a bug in the hypervisor cooking the descriptor, and the guest
can do little to nothing is such scenario.

/P


