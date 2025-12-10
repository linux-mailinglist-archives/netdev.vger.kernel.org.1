Return-Path: <netdev+bounces-244183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8788ECB1C16
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 03:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361AD300768B
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0FC224AF9;
	Wed, 10 Dec 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="b7s3reex"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABA1F5834;
	Wed, 10 Dec 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765335077; cv=none; b=rGslagdeuJSZYSsGoWaUcgdhGstjOWYc5tdddgLc9pihfmM8b2PnxvMMAl0r4pVcoN8H/Hz+1u1buq3hYZ0v7yinIKm29JdkdqVYRquQdgPHsIVEODuw2oTJgr6E87pmalzokPlPm7cIWpY7RrJCmIkn8PvxkGBwNnsNnFP775s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765335077; c=relaxed/simple;
	bh=7BFKKARd40imlyNwDlIXyi3Er26XMY84I58PtlrzrGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MI8chQCd2MBTHLKInsKhtxMgQXOdwMF1AW5Z+XWXNVh2oF1q5kkdxSYgscpjOvmZXFIyx2YO/vTOFivjg/O6ctfA9pEJL5DQx4jNp0S1gB/2UcBPDQ2BtYNp/lv1S/KSC8jd9sN1HyLFFeFBy1LMTMXvdblQE3S7bEnlmSu0cUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=b7s3reex; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TjRZnlfDIYUED2pEeefYUgZ5sYiaZ3c/W/77ZGjss7Y=;
	b=b7s3reexsblE7q740k0U11VxT+rR2797XwcXpBk3PmIHIEyzNGLx2dVn3nbzd34/X18K/JN/u
	bZnH8Bhxy3wyyx51rYKAq9qJiJuvs/V4GW5e0gPLa4SYzaoRybfvJA5jk+n0hsRilF71EcT4weP
	QQJjkJu9pEPyDVwwplluwMg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dR0Xl0pKPz12LKh;
	Wed, 10 Dec 2025 10:48:55 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 093EB1402CF;
	Wed, 10 Dec 2025 10:51:13 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Dec 2025 10:51:11 +0800
Message-ID: <5d5a0cf3-e085-4921-b340-b84446526985@huawei.com>
Date: Wed, 10 Dec 2025 10:51:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/handshake: Fix null-ptr-deref in
 handshake_complete()
To: Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>
CC: <chuck.lever@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <brauner@kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20251209115852.3827876-1-wangliang74@huawei.com>
 <aThlNuc-kjPqd9kh@horms.kernel.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aThlNuc-kjPqd9kh@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/12/10 2:06, Simon Horman 写道:
> On Tue, Dec 09, 2025 at 07:58:52PM +0800, Wang Liang wrote:
>> A null pointer dereference in handshake_complete() was observed [1].
>>
>> When handshake_req_next() return NULL in handshake_nl_accept_doit(),
>> function handshake_complete() will be called unexpectedly which triggers
>> this crash. Fix it by goto out_status when req is NULL.
>>
>> [1]
>> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
>> RIP: 0010:handshake_complete+0x36/0x2b0 net/handshake/request.c:288
>> Call Trace:
>>   <TASK>
>>   handshake_nl_accept_doit+0x32d/0x7e0 net/handshake/netlink.c:129
>>   genl_family_rcv_msg_doit+0x204/0x300 net/netlink/genetlink.c:1115
>>   genl_family_rcv_msg+0x436/0x670 net/netlink/genetlink.c:1195
>>   genl_rcv_msg+0xcc/0x170 net/netlink/genetlink.c:1210
>>   netlink_rcv_skb+0x14c/0x430 net/netlink/af_netlink.c:2550
>>   genl_rcv+0x2d/0x40 net/netlink/genetlink.c:1219
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>>   netlink_unicast+0x878/0xb20 net/netlink/af_netlink.c:1344
>>   netlink_sendmsg+0x897/0xd70 net/netlink/af_netlink.c:1894
>>   sock_sendmsg_nosec net/socket.c:727 [inline]
>>   __sock_sendmsg net/socket.c:742 [inline]
>>   ____sys_sendmsg+0xa39/0xbf0 net/socket.c:2592
>>   ___sys_sendmsg+0x121/0x1c0 net/socket.c:2646
>>   __sys_sendmsg+0x155/0x200 net/socket.c:2678
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0x5f/0x350 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   </TASK>
>>
>> Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   net/handshake/netlink.c | 35 ++++++++++++++++++-----------------
>>   1 file changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
>> index 1d33a4675a48..cdaea8b8d004 100644
>> --- a/net/handshake/netlink.c
>> +++ b/net/handshake/netlink.c
>> @@ -106,25 +106,26 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>>   
>>   	err = -EAGAIN;
>>   	req = handshake_req_next(hn, class);
>> -	if (req) {
>> -		sock = req->hr_sk->sk_socket;
>> -
>> -		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>> -		if (fdf.err) {
>> -			err = fdf.err;
>> -			goto out_complete;
>> -		}
>> -
>> -		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
>> -		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
>> -		if (err)
>> -			goto out_complete; /* Automatic cleanup handles fput */
>> -
>> -		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
>> -		fd_publish(fdf);
>> -		return 0;
>> +	if (!req)
>> +		goto out_status;
>> +
>> +	sock = req->hr_sk->sk_socket;
>> +
>> +	FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>> +	if (fdf.err) {
>> +		err = fdf.err;
>> +		goto out_complete;
>>   	}
>>   
>> +	get_file(sock->file); /* FD_PREPARE() consumes a reference. */
>> +	err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
>> +	if (err)
>> +		goto out_complete; /* Automatic cleanup handles fput */
>> +
>> +	trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
>> +	fd_publish(fdf);
>> +	return 0;
>> +
>>   out_complete:
>>   	handshake_complete(req, -EIO, NULL);
>>   out_status:
> Hi,
>
> Clang 21.1.7 W=1 builds are rather unhappy about this:
>
>    net/handshake/netlink.c:110:3: error: cannot jump from this goto statement to its label
>      110 |                 goto out_status;
>          |                 ^
>    net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>          |                    ^
>    net/handshake/netlink.c:104:3: error: cannot jump from this goto statement to its label
>      104 |                 goto out_status;
>          |                 ^
>    net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>          |                    ^
>    net/handshake/netlink.c:100:3: error: cannot jump from this goto statement to its label
>      100 |                 goto out_status;
>          |                 ^
>    net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>          |                    ^
>
> My undersatnding of the problem is as follows:
>
> FD_PREPARE uses __cleanup to call class_fd_prepare_destructor when
> resources when fdf goes out of scope.
>
> Prior to this patch this was when the if (req) block was existed.
> Either via return or a goto due to an error.
>
> Now it is when handshake_nl_accept_doit() itself is exited.
> Again via a return or a goto due to error.
>
> But, importantly, such a goto can now occur before fdf is initialised.
> Boom!


Thanks for your analysis, you are right!

How about adding a null check before calling handshake_complete()?

Like:

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1d33a4675a48..b989456fc4c5 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -126,7 +126,8 @@ int handshake_nl_accept_doit(struct sk_buff *skb, 
struct genl_info *info)
         }

  out_complete:
-       handshake_complete(req, -EIO, NULL);
+       if (req)
+               handshake_complete(req, -EIO, NULL);
  out_status:
         trace_handshake_cmd_accept_err(net, req, NULL, err);
         return err;

------
Best regards
Wang Liang


