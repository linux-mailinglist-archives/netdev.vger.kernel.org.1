Return-Path: <netdev+bounces-126041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F8996FB85
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF291C21CB8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9B3FB8B;
	Fri,  6 Sep 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA2ke1Ye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E51B85C8;
	Fri,  6 Sep 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648925; cv=none; b=X8Jq459I4lMjIXYqD5QYg6ad7fntxREgu+8HsOBME8Fv29h7iy1LQbu8Xa9zHSyWKrhknr9V4oVFivsRCGMEKQVO/sgZx49ShHXI6QvoVQHJCPWrYUMGK9/TUFr0bsD/+6DPHMXdDMtonooMVxqcktkWFCRHdDr4hWj0jeaFtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648925; c=relaxed/simple;
	bh=xydqzXCNhgZuKdjblfs4ftwwAuG4PcoLJ3PLFKz70bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp4HOOqlkfzg9FeeCKvYzn8TaKRLLupo4f+ugWTFu3HfskLnZybazHn5LBnKAGTq1Xxa/pGMrBE7cSWZ/3IskxGcjTaiIusfnU3H66K7Sq9JsqVEoYfs+fA2ehpr2+UlMFhOqAAi6GSO6qgkyNkSIr90WrgU3QGYMDlkYhiNqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA2ke1Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD06C4CEC4;
	Fri,  6 Sep 2024 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648924;
	bh=xydqzXCNhgZuKdjblfs4ftwwAuG4PcoLJ3PLFKz70bA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kA2ke1YehGFwS//3BnM1GozEFoxeWSjMBllDGEyKTYJUnGmSb23ARANM1Nhqu6TgE
	 tf9vMXIylhysogsF9IKDcV11voj7dNmN7NQ6M/bG902rjWRLbpCvoOKnxDt41Qx24P
	 0SJ8mM+0TWJtTPuzp7zjh4lJBHvPR1Q9t3iBYTKX2m+7/ZluKz3j46ey0a10jUOweu
	 362mGKMmRO8ogDx/6xOSpM55QEdPm/MwATihALSv5fZ4bFkR5p4Yd5ZVIr9PJabZRW
	 6lf37Fj8o9nIbodNoHg1qbvc1QZGmGdR3gBMC3R+zEDF56oerXtgW7AcdDlN8eBfU6
	 ahIoO1ORPJCGA==
Message-ID: <b2272b72-d207-4393-9245-31ad7628be09@kernel.org>
Date: Fri, 6 Sep 2024 20:55:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
Content-Language: en-GB
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
 <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Edward,

On 05/09/2024 14:27, Edward Adam Davis wrote:
> There are two paths to access mptcp_pm_del_add_timer, result in a race
> condition:
> 
>      CPU1				CPU2
>      ====                               ====
>      net_rx_action
>      napi_poll                          netlink_sendmsg
>      __napi_poll                        netlink_unicast
>      process_backlog                    netlink_unicast_kernel
>      __netif_receive_skb                genl_rcv
>      __netif_receive_skb_one_core       netlink_rcv_skb
>      NF_HOOK                            genl_rcv_msg
>      ip_local_deliver_finish            genl_family_rcv_msg
>      ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>      tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>      tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
>      tcp_data_queue                     remove_anno_list_by_saddr
>      mptcp_incoming_options             mptcp_pm_del_add_timer
>      mptcp_pm_del_add_timer             kfree(entry)
> 
> In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
> zone protected by "pm.lock", the entry will be released, which leads to the
> occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
> 
> Keeping a reference to add_timer inside the lock, and calling
> sk_stop_timer_sync() with this reference, instead of "entry->add_timer".
> 
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

According to the doc [1], a 'Co-dev' tag is supposed to be added before
this SoB:

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

But I'm sure that's fine without it.

[1]
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by


This v3 now looks good to me. I don't know if it needs to be reviewed by
someone else as I'm now listed as co-developed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


