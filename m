Return-Path: <netdev+bounces-230131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B7BE4405
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C97C506E8E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCB34BA50;
	Thu, 16 Oct 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kosmx.dev header.i=@kosmx.dev header.b="l8O1INcr";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VCVsSmbs"
X-Original-To: netdev@vger.kernel.org
Received: from b224-2.smtp-out.eu-central-1.amazonses.com (b224-2.smtp-out.eu-central-1.amazonses.com [69.169.224.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30A346A1B;
	Thu, 16 Oct 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628668; cv=none; b=c37EieMN6doT7zLCHAMixtV396ZOIQX0Rq7U16/T778bRvjttz1696ctFs/BHuVJpkuKvtTTWrzLtDK4RIcuIhtec+BQIbhxEae6B3uONO+JMnxeElXusBmC38NHK8g5rfaKiSXXnV0Awk+HQMcPxF43dxNdzxNgQ5ElxK7+5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628668; c=relaxed/simple;
	bh=4V+eiDbJeS2/Lkmw7GXs1heP2kr5DjpdCX+SmScCzco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb4BgKm5z2SZDDTFglg9uMFPUbqSFCpYJ0WgUgMLEgQvxgkcenz+GL1a/bU1+5hQdW1EF/43l9Kah3FPLdKd57PQzZ68Lo9gNpUiBRJMUo2s03WfPtzRckeYg/IgK8mObCGx3iBMZ6AtlIcST8X63wM3djwvLLGLGr1ZuJmG2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kosmx.dev; spf=pass smtp.mailfrom=eu-central-1.amazonses.com; dkim=pass (2048-bit key) header.d=kosmx.dev header.i=@kosmx.dev header.b=l8O1INcr; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=VCVsSmbs; arc=none smtp.client-ip=69.169.224.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kosmx.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-central-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=2d6evbf27r2lzynqz2duzea56jayutws; d=kosmx.dev; t=1760628662;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4V+eiDbJeS2/Lkmw7GXs1heP2kr5DjpdCX+SmScCzco=;
	b=l8O1INcrEZVAyTskRDCz1jSdZjAI7LQJEswDzEqxHAXzfc+6sxq6en6VV1Efo6X7
	KXkhePqB+3Fsg+wwMUdZCea5BeTltdQaAFODFc6TRcObGsf6TChdbbmQ5eR5C+6LR1O
	zzB68saGPWBBNhB4Tr6EAE6Xg0ePKAhXc/fJOap0c9myOiFoHphSsfCL0JWlb4497Zq
	5l8Z8YL4hQRKRM/VZ4pg8C6wMjabCETMbhn+yUC/HMwjeyffnb31cA6/kd1+U92C2LP
	CyrahYfh5khic7qS13gL+srSOoys0v999JjbLECNXnAogv+in0Nxwspi1XUHTqpzkgc
	aWUPGT2a9Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sokbgaaqhfgd6qjht2wmdajpuuanpimv; d=amazonses.com; t=1760628662;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=4V+eiDbJeS2/Lkmw7GXs1heP2kr5DjpdCX+SmScCzco=;
	b=VCVsSmbsXZJ2WUv4RWow/8JmxdP0JC5Kh1ftrvf909tFqIh9lm9ttMAvyE4CSzOy
	TRiVlzAsi99aUXynnjo2gAIJgGbbO+3xYinvqEohI0qZUuy5r3dVXYGI/z61Br//z46
	dzK3ZDfmSNyi80uuEB6zxJ1E8JllfLZcG/Ez0eA4=
Message-ID: <01070199eda55d65-1e43d600-4eb4-4caf-98f0-4414b449cb07-000000@eu-central-1.amazonses.com>
Date: Thu, 16 Oct 2025 15:31:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sysfs: check visibility before changing group attribute
 ownership
To: Greg KH <gregkh@linuxfoundation.org>, 
	Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	rafael@kernel.org, dakr@kernel.org, christian.brauner@ubuntu.com, 
	edumazet@google.com, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
References: <20251016101456.4087-1-fmancera@suse.de>
 <2025101604-filing-plenty-ec86@gregkh>
Content-Language: en-US
From: Cynthia <cynthia@kosmx.dev>
In-Reply-To: <2025101604-filing-plenty-ec86@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-central-1.7BiZt5Lnf19vB746CR+JKfpU6eIRDUAYyv2UoOsIVTE=:AmazonSES
X-SES-Outgoing: 2025.10.16-69.169.224.2


On 10/16/25 16:46, Greg KH wrote:
> On Thu, Oct 16, 2025 at 12:14:56PM +0200, Fernando Fernandez Mancera wrote:
>> Since commit 0c17270f9b92 ("net: sysfs: Implement is_visible for
>> phys_(port_id, port_name, switch_id)"), __dev_change_net_namespace() can
>> hit WARN_ON() when trying to change owner of a file that isn't visible.
>> See the trace below:
>>
>>   WARNING: CPU: 6 PID: 2938 at net/core/dev.c:12410 __dev_change_net_namespace+0xb89/0xc30
>>   CPU: 6 UID: 0 PID: 2938 Comm: incusd Not tainted 6.17.1-1-mainline #1 PREEMPT(full)  4b783b4a638669fb644857f484487d17cb45ed1f
>>   Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, BIOS 03.07 02/19/2025
>>   RIP: 0010:__dev_change_net_namespace+0xb89/0xc30
>>   [...]
>>   Call Trace:
>>    <TASK>
>>    ? if6_seq_show+0x30/0x50
>>    do_setlink.isra.0+0xc7/0x1270
>>    ? __nla_validate_parse+0x5c/0xcc0
>>    ? security_capable+0x94/0x1a0
>>    rtnl_newlink+0x858/0xc20
>>    ? update_curr+0x8e/0x1c0
>>    ? update_entity_lag+0x71/0x80
>>    ? sched_balance_newidle+0x358/0x450
>>    ? psi_task_switch+0x113/0x2a0
>>    ? __pfx_rtnl_newlink+0x10/0x10
>>    rtnetlink_rcv_msg+0x346/0x3e0
>>    ? sched_clock+0x10/0x30
>>    ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>>    netlink_rcv_skb+0x59/0x110
>>    netlink_unicast+0x285/0x3c0
>>    ? __alloc_skb+0xdb/0x1a0
>>    netlink_sendmsg+0x20d/0x430
>>    ____sys_sendmsg+0x39f/0x3d0
>>    ? import_iovec+0x2f/0x40
>>    ___sys_sendmsg+0x99/0xe0
>>    __sys_sendmsg+0x8a/0xf0
>>    do_syscall_64+0x81/0x970
>>    ? __sys_bind+0xe3/0x110
>>    ? syscall_exit_work+0x143/0x1b0
>>    ? do_syscall_64+0x244/0x970
>>    ? sock_alloc_file+0x63/0xc0
>>    ? syscall_exit_work+0x143/0x1b0
>>    ? do_syscall_64+0x244/0x970
>>    ? alloc_fd+0x12e/0x190
>>    ? put_unused_fd+0x2a/0x70
>>    ? do_sys_openat2+0xa2/0xe0
>>    ? syscall_exit_work+0x143/0x1b0
>>    ? do_syscall_64+0x244/0x970
>>    ? exc_page_fault+0x7e/0x1a0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   [...]
>>    </TASK>
>>
>> Fix this by checking is_visible() before trying to touch the attribute.
>>
>> Fixes: 303a42769c4c ("sysfs: add sysfs_group{s}_change_owner()")
>> Reported-by: Cynthia <cynthia@kosmx.dev>
>> Closes: https://lore.kernel.org/netdev/01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   fs/sysfs/group.c | 26 +++++++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 5 deletions(-)
> Nice, thanks!  This has been tested, right?
>
> thanks,
>
> greg k-h

I did a quick test just now, it works in the VM (no warn and the 
container is running).

kosmx


