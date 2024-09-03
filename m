Return-Path: <netdev+bounces-124601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6796A229
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93A6B28D22
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5228189F20;
	Tue,  3 Sep 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekLeCHYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE99189915
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376741; cv=none; b=Pa6WlaZRB1cGByNeeIQyfs1k4jxoaTG2ku7XTiwK2Z24MbxzDgimM4i5EmReR54v+aznZusHcgwWThO9cBQuzAfFy8RZ1h/jRFTo7n+KUOA+YQlf0yJOUauQhMZBCUrW3LcttxrDmkp+P1aSEg9+TJ4WUtm2kuuzrUTi3w7+1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376741; c=relaxed/simple;
	bh=ZfbxVl1glz8Vb6LZs4MHn8WObItPWAp5Hu0aYunUFeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO9f66NSvsUgkcdaIf1wD1bBWsK1yDlAsJLnWPPgmxz16bCLAgsvgMbl6MxR1Voo8fLBzTn3ba+5V+BnRj1oOWpSbKq5iU4/zZpxHGhv52ZeoPJR+cAScXPPZXhqXnHH+QtH5F8fmf/k8hD+FlyaJYLifhmsWuIGWYZriZNFrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekLeCHYR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86abbd68ffso907428466b.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725376737; x=1725981537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJsBRI3EdlxNC+/ozkYJ5K4YtqaBU+Qz7tDZo9enfoQ=;
        b=ekLeCHYR3A3kj/Em6cx5+ujichj/rVRJ5AUdg23e1altPG9gVdAsJt1CEe0LOVOoYy
         gHLYPlivZQbXdHITMofbrAm3b9EWT7bjsm/jQw+aNZKIihfLMR7vtUY44dq7MItjielN
         UBmrfW9o672VkkqzxOcMujzq58US6maU09+gFFhAZk5Tp5joslOGvahYbXZABB9B9mcu
         IjvWOdphmwq3y1yYz9nhAKVZzNAcSKZEA4qUUOUI/Xclh1fzCcw/9w7z38y2rt+yMnvl
         6jl0jUN8jJS1dssNSxePvRi/VLgS+pfiHQbXRS9UsC43LuOi7FnZpT1ogDt+2vVNgCMY
         ji9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376737; x=1725981537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJsBRI3EdlxNC+/ozkYJ5K4YtqaBU+Qz7tDZo9enfoQ=;
        b=dqRwh61qaInf3xvB99jPoJG+pZaLRnLmhLrhtd8mf/TISlv8Mr4Eu/CVa0fSlds1sa
         jS331e+rNxPZ2qQ0KV3VfgVj1J683N3J/AoNMrfRZzzR6uh7Qg/F3es9MLHdr3x0n0yS
         6SlrsbO08ZzF69CBEejrk9AjJnSyNsEckH9D1FcrgScXWJMM4bTuDb6m/yo9KfQXfdmK
         LsWg8K0zcMGKWnIgzdqZgm+MlL+sXIe96/feYL+KN0CDIydc6Gy77ngFLuclH2rXu9Yr
         qsz7Fxow6SOnIeEW5itKz5pL5tof850XVAQxn6rZ+rPwPK+4PztGpuAL+rLBJzvobcHp
         CwJw==
X-Forwarded-Encrypted: i=1; AJvYcCVGAhCxZAj/f4DmWGIQt5ZpmjlFaSyTmvg3hwSBfkj4BbxpON1vXtk3XsG+Fc2Ba8xa22CG+eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dTPXQZYGurJCUzmETjJqc7J2fm2g59PVifBZo+LGkLiQYPS0
	KUOPxPKMzajNs6x80ARJemvMirl2b3vZ8u+BawmFkWDs32OjV0s728RsK1mBSGw+aWz7keTqy94
	vKm5hMpsWLfSNBBe76Wdsx9nXR+XB1aS7hq1c
X-Google-Smtp-Source: AGHT+IGJJzBIkDzFW1Sjp3ZP4my3ZSX2A8AzHH2EQ2hAxnP3UhDE2BBhdsJQm6BR5aRg54MNzRlcOiw2WpTTTHJTtnI=
X-Received: by 2002:a17:907:1ca7:b0:a7d:895b:fd with SMTP id
 a640c23a62f3a-a898231fd75mr1775714366b.6.1725376736022; Tue, 03 Sep 2024
 08:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b341bb062136d2d9@google.com> <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
In-Reply-To: <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Sep 2024 17:18:42 +0200
Message-ID: <CANn89i+93oK80FtHijdYJMid=ChsXP+2F1=Dn7K8tuvLy7xNHA@mail.gmail.com>
Subject: Re: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com, davem@davemloft.net, 
	geliang@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:10=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> There are two paths to access mptcp_pm_del_add_timer, result in a race
> condition:
>
>      CPU1                               CPU2
>      =3D=3D=3D=3D                               =3D=3D=3D=3D
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
>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflow=
s
>      tcp_data_queue                     remove_anno_list_by_saddr
>      mptcp_incoming_options             mptcp_pm_del_add_timer
>      mptcp_pm_del_add_timer             kfree(entry)
>
> In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
> zone protected by "pm.lock", the entry will be released, which leads to t=
he
> occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
>
> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df3a31fb909db9b2a5c4d
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/pm_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3e4ad801786f..d28bf0c9ad66 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -336,11 +336,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>         entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
>         if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
>                 entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
> -       spin_unlock_bh(&msk->pm.lock);
>
>         if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
>                 sk_stop_timer_sync(sk, &entry->add_timer);
>
> +       spin_unlock_bh(&msk->pm.lock);


mptcp_pm_add_timer() needs to lock msk->pm.lock

Your patch might add a deadlock, because sk_stop_timer_sync() is
calling del_timer_sync()

What is preventing this ?

