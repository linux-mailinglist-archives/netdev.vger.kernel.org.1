Return-Path: <netdev+bounces-124770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5969496AD7E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708E31C23AFD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4597E6;
	Wed,  4 Sep 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xED9GSa6"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A975228;
	Wed,  4 Sep 2024 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411153; cv=none; b=Y6idzH0O31KiFg4G5Ym23mx0kSB+ZDJbOX2t9KCVMbkHz+MSzRDezgufyyUPseboQkjnVr/r//ABEQpjFkDCNdh4jDuJ8FOnZYrUPHLdzGTyHI/o09tNqRhcnSIgcvf9LqvhUwKSBWcC5APlTimsKjZleZD4f2Rq4VWuln4Y0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411153; c=relaxed/simple;
	bh=wS44eKjROLyrNyCwdb3ChF22PoKCUzMqRJHJOb0e91I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpT2cQNoLbvIckSLB5UWIwlDinT4B77JK8xMm3OSxO8SMDjCfWx5w6OGuZ6xtM6XCRHt60QlP7fciwkTA+g+4pBK1D8R1vJlo5fHt66z6FuZE3Wu6rlybi51R5YUrVK2TmXZ8ti46LQdtu4ke6l8IX3YS9vuUoh7novh1KLOMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xED9GSa6; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725411147; bh=FmBx03Jk7fYdr507CwNO/tgnyEwzvtVETwaQDfGeKAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xED9GSa6NEZ1p8qnQ4InTk/+l+ReZzei5JHfXOhbOoQ9bhJqHVZLGFJKb9EIcFUJ/
	 urT20xzd5PKjhU2h8tXaQNAY3wFCsr+tM4gm3/bF1P1rTY/0NhS1VnPrjJQE6JHOpt
	 zSilvIl1uw0dUGRZrB08IHlH3zlTfSZTYsy7JYag=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id D1702074; Wed, 04 Sep 2024 08:52:23 +0800
X-QQ-mid: xmsmtpt1725411143td8mxr5u3
Message-ID: <tencent_EECBD37DC379497A63A1C455B773377AC605@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiemLhHaQrYOE0dp61XO1j8hrZ6A/geSS4oPsVNAA4c39ictKjTo/
	 Go8eg+R8IIxjg9r7dPK8H5H6XtxY6Rce+V7LoFIqWqYIrpoQZ7jXlTFZWPHfulRAJxGoXmEdHNfv
	 aeOmsuQxP0p7GhCAYS7OJcLUJ5BEy2VJu8DuyE+LSI6pqpCjU6t6QN27jMg3+JSHylm2RykbN+5t
	 gEwaTT42S/QBrHl7gFxLMFxraMQRwOTi6N1QzXvCAvQm5bon/Ei0d7WZ+FK91sjSbGGUygpuol0A
	 AzXJavoeve3KLXEbxTrxscXZUaFL/s9+3O4RNGDcRFT8iEiWPSJgcot+DoybcOEg69LVEfovOWpu
	 4ScwQtrXu4ppF9OdK3VdBDvyfL+Y0QZIYTRa5llBqW8YoHaByfnt4uUtnWTucxPxiQwZ7QRsrGu0
	 hyOIClb0HdT1TARfXDC6sy18tIYjsHz889dHG461dSSkhIv8QjMXoO7XhElJmW1nXwcvZbryzth8
	 JCkLXpI5CRk+ykCqNyneZujoHKqrlSAgSklaqIOvlv2K5DylbS1FeUIr0ZsNIgDTYHqMNu7k0358
	 pObsHVicp/7OlZzWk0At60FI2PBkf5+kTOCsG2QOuR4AmmABP3/3wPkxXIVREk1hLWsMVsxmPpKD
	 5z8nTBDkL/LPRwV8lhjtLcn7RqxEKrZeKDLC8hVCSiWUVRpGCLJ4Bv2ROIcz1nb/Hw0m6cCQwTAk
	 TbowVCGfCabEET7o7aa2qZi71bgBDNgeXRCT/P1ioR63rh1ST04bjiD5rYVMe9fa6mn2a0SoOevO
	 KLHH/b4TmfNLOZlbXGdxWvLlEf8ZQAL1jV48nufeX4E2NNFlrYu0y35hWUfgYeZCST1vwIm50QfQ
	 BE4mvybSZ2nFTwmmyO4mKxMVMW3P3MYYAB6EDEusrfJIlh39nBI58RPlbY3TylOXc7FPV326ZyMF
	 Ef55WovRWFlKCXYCXTbw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	geliang@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Wed,  4 Sep 2024 08:52:19 +0800
X-OQ-MSGID: <20240904005222.3438071-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CANn89i+93oK80FtHijdYJMid=ChsXP+2F1=Dn7K8tuvLy7xNHA@mail.gmail.com>
References: <CANn89i+93oK80FtHijdYJMid=ChsXP+2F1=Dn7K8tuvLy7xNHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 3 Sep 2024 17:18:42 +0200, Eric Dumazet <edumazet@google.com> wrote:
>On Tue, Sep 3, 2024 at 5:10 PM Edward Adam Davis <eadavis@qq.com> wrote:
>>
>> There are two paths to access mptcp_pm_del_add_timer, result in a race
>> condition:
>>
>>      CPU1                               CPU2
>>      ====                               ====
>>      net_rx_action
>>      napi_poll                          netlink_sendmsg
>>      __napi_poll                        netlink_unicast
>>      process_backlog                    netlink_unicast_kernel
>>      __netif_receive_skb                genl_rcv
>>      __netif_receive_skb_one_core       netlink_rcv_skb
>>      NF_HOOK                            genl_rcv_msg
>>      ip_local_deliver_finish            genl_family_rcv_msg
>>      ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>>      tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>>      tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
>>      tcp_data_queue                     remove_anno_list_by_saddr
>>      mptcp_incoming_options             mptcp_pm_del_add_timer
>>      mptcp_pm_del_add_timer             kfree(entry)
>>
>> In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
>> zone protected by "pm.lock", the entry will be released, which leads to the
>> occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
>>
>> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>  net/mptcp/pm_netlink.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 3e4ad801786f..d28bf0c9ad66 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -336,11 +336,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>>         entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
>>         if (entry && (!check_id || entry->addr.id == addr->id))
>>                 entry->retrans_times = ADD_ADDR_RETRANS_MAX;
>> -       spin_unlock_bh(&msk->pm.lock);
>>
>>         if (entry && (!check_id || entry->addr.id == addr->id))
>>                 sk_stop_timer_sync(sk, &entry->add_timer);
>>
>> +       spin_unlock_bh(&msk->pm.lock);
>
>
>mptcp_pm_add_timer() needs to lock msk->pm.lock
>
>Your patch might add a deadlock, because sk_stop_timer_sync() is
Got it. MPTCP CI reported it.
>calling del_timer_sync()
>
>What is preventing this ?
I will change the strategy for protecting entry and use pm.lock to
synchronize when it is released in remove_anno_list_by_saddr.

Link: https://syzkaller.appspot.com/text?tag=Patch&x=124282ab980000

BR,
Edward


