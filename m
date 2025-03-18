Return-Path: <netdev+bounces-175774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B5EA67728
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A239316B04A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDD20E32B;
	Tue, 18 Mar 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm7fQJFs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0F20E034;
	Tue, 18 Mar 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310159; cv=none; b=YoB7FfxoYTKfsZ0zTsui8Ty/bWJuVcKdGA7Cr9k7JxEfduCJsl4C3SKQHFrR8lKWCDie6sPYivVJNYEgEtdmKqkZ21BSTDHa7cTP1v6PolffjL1dSle/Qk2kGtZA+tNo22oW5qZLLS38xVyxA2SMFevAbHXsZ04yWU3SUXKOFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310159; c=relaxed/simple;
	bh=ZbdWLia4awlzBoHhYnAGT34AyyoQVUvRPjT/kLhTMRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTZufBTvyxtKiX6lu+gxFSg9NPp8H1iEMvaMFyeCbSt3jEIxtLT2uh+kqQjImqjK0jScqWNkTUebpEcYkwy1TvtO/+FCsj3dfVSC8blnFu2/lqs8XmJ7VN/kd182XwIGJFATz6LhpThAz+YpSOKLfiGnz01XxugRquz5iN/ZZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm7fQJFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40165C4CEE3;
	Tue, 18 Mar 2025 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310158;
	bh=ZbdWLia4awlzBoHhYnAGT34AyyoQVUvRPjT/kLhTMRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xm7fQJFsQCh5TF7hjz7qkC6etZ5L29XyppyVS39/rIayVwtyxBXF54tzn/TmCLY+V
	 ULGzrBX2nKLBK+RwpcggBmzHS2N52fMRAF7VLqV/SR7dsgu2h0DDfodBRUf/2A4UGa
	 mv7nGbVsqCsJ+kPG09YKOP4sJsqgaHma2rEzcZXa9fK/COFlKP3iesB4EgU7LKEQMx
	 pAZtCBbcQJCBKA9PPQMVGqudZ7W11a46tzpkLBrX0LOfeudUqDZit7Z9pMUkqXo6T2
	 pqAq8tKQfiGDyg/G52gv+adDLvc492pphXqtnNoz666pBjR0gPoo3k1/uHzcPEqIH/
	 cY906BpeP9LdA==
Message-ID: <e8da7ce4-c76c-488e-80cb-dff95bf00fe0@kernel.org>
Date: Tue, 18 Mar 2025 09:02:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix NULL pointer dereference in l3mdev_l3_rcv
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fw@strlen.de, daniel@iogearbox.net,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313012713.748006-1-wangliang74@huawei.com>
 <20250318143800.GA688833@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250318143800.GA688833@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 3:38 PM, Simon Horman wrote:
> On Thu, Mar 13, 2025 at 09:27:13AM +0800, Wang Liang wrote:
>> When delete l3s ipvlan:
>>
>>     ip link del link eth0 ipvlan1 type ipvlan mode l3s
>>
>> This may cause a null pointer dereference:
>>
>>     Call trace:
>>      ip_rcv_finish+0x48/0xd0
>>      ip_rcv+0x5c/0x100
>>      __netif_receive_skb_one_core+0x64/0xb0
>>      __netif_receive_skb+0x20/0x80
>>      process_backlog+0xb4/0x204
>>      napi_poll+0xe8/0x294
>>      net_rx_action+0xd8/0x22c
>>      __do_softirq+0x12c/0x354
>>
>> This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
>> ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
>> like this:
>>
>>     (CPU1)                     | (CPU2)
>>     l3mdev_l3_rcv()            |
>>       check dev->priv_flags:   |
>>         master = skb->dev;     |
>>                                |
>>                                | ipvlan_l3s_unregister()
>>                                |   set dev->priv_flags
>>                                |   dev->l3mdev_ops = NULL;
>>                                |
>>       visit master->l3mdev_ops |
>>
>> Add lock for dev->priv_flags and dev->l3mdev_ops is too expensive. Resolve
>> this issue by add check for master->l3mdev_ops.
> 
> Hi Wang Liang,
> 
> It seems to me that checking master->l3mdev_ops like this is racy.

vrf device leaves the l3mdev ops set; that is probably the better way to go.

