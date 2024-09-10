Return-Path: <netdev+bounces-126956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB8973630
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A13A1F26255
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63318E776;
	Tue, 10 Sep 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSuu6Tpk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA018DF97
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967638; cv=none; b=kTcLS78v82QELspi7VlLnyICRELNjNpI0m2qSIFEr2wYWm+NeYlgF68J5sqggsyC8qDu5f/swilLkV+iPuPDBPvWyGk72FpvD4+ybZsw+uIB1pG2q4zJ42KpFaQaHJ2yCbHCG3U2TIjAMFy3Y3BmgI9knBND9ktlnzKb+D4xeGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967638; c=relaxed/simple;
	bh=qctE5YfZSHy94HtnMI7ZJHq/A1Fl5gIdQZv5mKbHhfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKHRtcYHrjxHoj8YmKyPGFAlYerJnDex+EO+tJsIP/hVCuq5OQLcsRcuHzV8OSBE5RQl5MGxCODrYxfRV6Fx9IOpjDCsYivC1F5mZkAYwjq4X3HRXUWjGNZ/bu5AZm2uJly+0zXoyTHRBzVvQ9eAyhuVJgICdWCNAlhrj3JpotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSuu6Tpk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725967635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5rZhkMkam2M4KyWPSOYt5c6AGQl28M6Q/aZzK4Hqro=;
	b=NSuu6TpknPA9Bs5il0AujjaxzUu20VkLe06xCTAiiRyNFHUrtOCtfUgLYMRJb2IQkIEZmu
	Mok7BJxbdgmWG2f7FbHSu/aetHmonhJRijRTqKqdREJ3GE4iVd7TXPSHDLGhqmVrA9AMO6
	6c6ZezHzpoP4Z9ThlEKr6usnmyWIfeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-r63VWnc8OqO3NAVDjWP8zQ-1; Tue, 10 Sep 2024 07:27:14 -0400
X-MC-Unique: r63VWnc8OqO3NAVDjWP8zQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb0ed9072so25778655e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 04:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725967633; x=1726572433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5rZhkMkam2M4KyWPSOYt5c6AGQl28M6Q/aZzK4Hqro=;
        b=kqOYO3rCZFZ94gG2hSaFWPcs2Q2j3JsD+FsZ1RDptvc9BDpPC4x8TiFGTMTanbBFGQ
         maxBp2SuMtVZg629ZDV6eBH9yzXCG9rwArA8QgI08kEB5ZV2pWa/gDadOotQi4ehsMQk
         654+bCAF5BhKlDUrdGZwvgItWuB5+rNg3zeD8I7VPwL000iyuardSrmsd6KDoULphxmg
         RjbzTPkUVnxsS86fmiPJ0TzBgHNOqh0Lk0+T7zM+HlXzFjyE7Jekqw+tdlRWMOrEu00V
         zsjCVfRDKAgMVqtEHY/7fc9KfHB/jkVxdfnKoelfNxTUyY1V0asXZEtZaHaJKSBY5nNr
         LfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxDF/8R84ACFmPFy3N5OYww+46kVmkbilUb947FdK8dUhmrZ0vXNyccTBWJVJxlm8zVNGIRQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrX2zJmiVnAZmZqKZQsCiq0kn12mJr/nAM6GHRA1QP0CYHsbZn
	liZ6yVGHRjZ8fNokLA4q5+1l1AfVvc1ynZfoiip/Wz8fMIEPu8I6ZHOKdtau4L6xq3nAnKOhRDD
	3SHxNQtgXC6oz0PrxUI2kYFU7QLYQNUThj1V9sYTp1D2lQo4rpTKCYw==
X-Received: by 2002:a05:600c:1e22:b0:42c:b187:bdd5 with SMTP id 5b1f17b1804b1-42cb187c012mr84563655e9.22.1725967632972;
        Tue, 10 Sep 2024 04:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFytwom/JrfOKRUuR+Dc7w8yMY8uhViCPwr/NKw/WZ2IrNQQpvBuOZXJSnixPmZuE4H3jpHiQ==
X-Received: by 2002:a05:600c:1e22:b0:42c:b187:bdd5 with SMTP id 5b1f17b1804b1-42cb187c012mr84563325e9.22.1725967632438;
        Tue, 10 Sep 2024 04:27:12 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32678sm108194315e9.16.2024.09.10.04.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 04:27:12 -0700 (PDT)
Message-ID: <1cd88b74-5329-4aeb-8917-e291be104ea0@redhat.com>
Date: Tue, 10 Sep 2024 13:27:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V4] mptcp: pm: Fix uaf in __timer_delete_sync
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <tencent_272542BA3FBB37337F9EE91B384BB21BF008@qq.com>
 <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 11:58, Edward Adam Davis wrote:
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
> Move list_del(&entry->list) to mptcp_pm_del_add_timer and inside the pm lock,
> do not directly access any members of the entry outside the pm lock, which
> can avoid similar "entry->x" uaf.
> 
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


