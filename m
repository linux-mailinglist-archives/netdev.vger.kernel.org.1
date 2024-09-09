Return-Path: <netdev+bounces-126507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A078F971A54
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E135CB215B8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70D1B86CF;
	Mon,  9 Sep 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ4WSlJF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76C1B81DC
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887249; cv=none; b=XHRzhgHD8er3UH3Ruv5tSOVAsTMJ9gSU/fJZj5p3UjyYN28WvKLk3BajNsN9VgcMuBUunGAwzFA+tGCHrfVyBwiny7ZxCC50fxXVATmb22bZFkfDYW+XD2LK1wdddjTaT2GnnEIIk3mmxG2I01QU9FM3l6zk012h62vkCVpj4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887249; c=relaxed/simple;
	bh=CHbpMMgrI2xFY2pHl/Kg9xkP9E8Jysrml3rFwxJwjB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnBH5z34e0+hy4LtQ0Z3On8cyvffWlC/j2TveoWrI1Rc96yezFzjxdqNVxIwZmLBQizXMWFgI8FN/HG52Q8aU5WNGbxZzJNrysSb2+izKzgsOXj5rKU0NDn+DkTD9oqE54pauUgfQI3G5u82Ci098IprIhqt4u6ULEmC3ONmgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJ4WSlJF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725887247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyZBj0EVD3PSNBPRSECSDTeknIIQ/mA6Gy6EUmKX6vY=;
	b=UJ4WSlJFNEPGTLaF6/+SkEBEonvDmA8bz4cM9XgW94fogoLpfptayrDTK6KhAXOvA9/k/9
	g0Q5K0m2oCnC87wpr+OFTCMEFL1k3Y/4JVsUHdOCs0bXbgsRCI8Rsb0DFqSDn7EJfFyC6A
	iQa5jiaUXXCatqZ5bDpOgkqoeO09Ias=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-7cP6CeSUNeqZswEU1QZ11Q-1; Mon, 09 Sep 2024 09:07:25 -0400
X-MC-Unique: 7cP6CeSUNeqZswEU1QZ11Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f7538dc9d7so25509061fa.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 06:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887244; x=1726492044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyZBj0EVD3PSNBPRSECSDTeknIIQ/mA6Gy6EUmKX6vY=;
        b=C7lM0UIE6h4gFC8zfFJxFmvQr3HDZZ6UAB1iV0w2O6fLmbneJyz/qtonIjp2VozY12
         dzYNUjcrXT9P/an0pnn6WCFo7cZpGcloy0sX3eYZfE34MXe5KBmZXCaU8NswMVSVioTx
         gIStc67IEKSt7Qp6cRFWPOujannEQx3sP0WEgZm4okiGjj/d5tE4vJGifWf/H5H5L8Bw
         7PSyPLwLuSP6sI5HJvVEHdA2YaApyuE0lJByl4OqXlMyWdhp12piMRCY8GRw5/nnFq+z
         5JR6fuY41P7mphwI0fxggrNyTmeHbcf1isUbm+UBk/lUT1Gh9FP+CjLMz+9A2NI3W8Ul
         oR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0Q8EP+uoJyMbeRX64w22BpNCntk94sVyxjFCpwRcVN2U23v2o6JdpYtl0Ksbkx2RwXN5T/ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqr4+ZCm/c39BKp0Sbi9ayyEb9Q9Em7AR3IXEmPx4fDi9OegNf
	j+AnVpbFfpWzHISfayraAWofGIE/ZER0vR6M9Y60m5I8JSp/9zYIdQERUyEvl/ueE20z0rd1AOI
	qDNvH4PwA7/p4BFrUvj2uWE5uxHTsYO8EBGuoU5/Zfa6ljYTtizEPzg==
X-Received: by 2002:a05:6512:3a85:b0:536:55b3:470e with SMTP id 2adb3069b0e04-536587ac230mr7673702e87.19.1725887244040;
        Mon, 09 Sep 2024 06:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrEiK+GlRfgFHvybT+tm+AdL0oMjLeOS3CiaqtMSqNP6YCmiedgWU9dh7LOXLTK74rlvza6Q==
X-Received: by 2002:a05:6512:3a85:b0:536:55b3:470e with SMTP id 2adb3069b0e04-536587ac230mr7673667e87.19.1725887243418;
        Mon, 09 Sep 2024 06:07:23 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21d3asm77098165e9.5.2024.09.09.06.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:07:22 -0700 (PDT)
Message-ID: <4e74f641-a4a0-4668-b77a-94082f0ea6f1@redhat.com>
Date: Mon, 9 Sep 2024 15:07:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
To: Edward Adam Davis <eadavis@qq.com>, matttbe@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
 <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 14:27, Edward Adam Davis wrote:
> There are two paths to access mptcp_pm_del_add_timer, result in a race
> condition:
> 
>       CPU1				CPU2
>       ====                               ====
>       net_rx_action
>       napi_poll                          netlink_sendmsg
>       __napi_poll                        netlink_unicast
>       process_backlog                    netlink_unicast_kernel
>       __netif_receive_skb                genl_rcv
>       __netif_receive_skb_one_core       netlink_rcv_skb
>       NF_HOOK                            genl_rcv_msg
>       ip_local_deliver_finish            genl_family_rcv_msg
>       ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>       tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>       tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>       tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
>       tcp_data_queue                     remove_anno_list_by_saddr
>       mptcp_incoming_options             mptcp_pm_del_add_timer
>       mptcp_pm_del_add_timer             kfree(entry)
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
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   net/mptcp/pm_netlink.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3e4ad801786f..7ddb373cc6ad 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -329,17 +329,21 @@ struct mptcp_pm_add_entry *
>   mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>   		       const struct mptcp_addr_info *addr, bool check_id)
>   {
> -	struct mptcp_pm_add_entry *entry;
>   	struct sock *sk = (struct sock *)msk;
> +	struct timer_list *add_timer = NULL;
> +	struct mptcp_pm_add_entry *entry;
>   
>   	spin_lock_bh(&msk->pm.lock);
>   	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> -	if (entry && (!check_id || entry->addr.id == addr->id))
> +	if (entry && (!check_id || entry->addr.id == addr->id)) {
>   		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
> +		add_timer = &entry->add_timer;
> +	}
>   	spin_unlock_bh(&msk->pm.lock);
>   
> -	if (entry && (!check_id || entry->addr.id == addr->id))
> -		sk_stop_timer_sync(sk, &entry->add_timer);
> +	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
> +	if (add_timer)
> +		sk_stop_timer_sync(sk, add_timer);
>   
>   	return entry;
>   }
> @@ -1430,8 +1434,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>   
>   	entry = mptcp_pm_del_add_timer(msk, addr, false);
>   	if (entry) {
> +		spin_lock_bh(&msk->pm.lock);
>   		list_del(&entry->list);
>   		kfree(entry);
> +		spin_unlock_bh(&msk->pm.lock);

I'm sorry for the late feedback.

I think this is not enough to fix races for good, i.e.

mptcp_nl_remove_subflow_and_signal_addr() -> mptcp_pm_remove_anno_addr()
-> remove_anno_list_by_saddr()

could race with:

mptcp_pm_remove_addrs() -> remove_anno_list_by_saddr()

and both CPUs could see the same 'entry' returned by
mptcp_pm_del_add_timer().

I think the list_del() in remove_anno_list_by_saddr() should moved under
the pm lock protection inside mptcp_pm_del_add_timer(), and no need to 
add spin_lock_bh() around the kfree call.

Thanks,

Paolo


