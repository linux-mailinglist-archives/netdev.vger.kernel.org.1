Return-Path: <netdev+bounces-95970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6748C3EEB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B060E1C2296C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20514A4E1;
	Mon, 13 May 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNYHiGz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8C146A9F
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596190; cv=none; b=ZkbU/BfjgsSjCak5zD5cLD1qBfqEBsTXdWhdB+r/JND9veXMe16fzmhhSuImtX05zyRxow/kz0WEN/IF2bUgkoq5xQBHB/U66i+olvxqowoI2OogQl5XZSkrblqLW+aLXFBaxwmuajap+9n/AKGLmzupozKhYQlonwZRZVmDayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596190; c=relaxed/simple;
	bh=ELDJqxAzJ4IsOugEBklmmdbamTzlHA10VqljSi0F99E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtPl7f0BnnKGrLHmzuU2VI0e4I7feI2kF0YR/TZU9UYCJrvTaO6v9iBgbfJPZnEzMsudOvs1UBAL+p7wbvInFL0Wek6lu++o3fdArRVN0Oq0jbLC+4AE9mc1I0cK1LMAEucvloWomik/glEtUGYuLebMEiTsG4CBTynQvdbd9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNYHiGz1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso14556a12.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715596187; x=1716200987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91fLmMenZGa/EUK3165TVqOeowS+ObiicrnTyUlJ0p0=;
        b=fNYHiGz1IQEuWNwb1uz9n7F+8cRcdxEO84zz+kbRxK99OHRB966WeHhOVedeUpr6mn
         2LbA3u1lNzRE//HHowNZS2n0yQmJBUTFyZI5SkGa9J7/zj4WqIT8jsNNtoIEvKQj63Ow
         2MgiYLVLBQkecuY/8u8elJtLU0bAD0OeihjLh1RE3MOSLzfdPxZapSZm3oaB7ceGIaog
         mQad1Ss5yII4MB+k5Nz/ACDPrfi9hMYO1WQUb3R041hnxxlJ64/0G2hIM/wGPUMuVpdv
         IrwIPsEBOlk+URodTsn38v1JN3cCzUJw7nQ+8Hxs1Z1oib2r1+etcV2GJBsxW8W2ASze
         zasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715596187; x=1716200987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91fLmMenZGa/EUK3165TVqOeowS+ObiicrnTyUlJ0p0=;
        b=foqJKXMw1R+a10Bmy7Vtfb4ZLyDcgHAbBjyg1pXaXD7p/tLYFZN5JbIwdQk8mjjF0I
         KPu1tm8E4j4glg5bTrDg55xiuaq9qCXlhEjMFRg5hWuxk3LsGYnF8emkUabr1HqPP15a
         QvZyRAAl/rhO/f21v8UscinFvoK5ouZZlaQ54mp/pMK6dWCb2k4Tt6A9HGaRuVKm9qdS
         HfQdJu9B/rWzsWqu7iQM54dbrR59Ok6jOQ9OWGGen1O0mHzzPgSTsObz9MyMHhgLHKuJ
         td2sDkZHysel4h6TJcgBCHWmvO+DW15HR5I+WKfZwbirQ4nwA7b6uGL2gz5fvQFU+gcf
         guvQ==
X-Gm-Message-State: AOJu0YwybfFor1zch8kOgOeaPK3lqW6UOzjId9jnD97xi7DrJihx/vcy
	9e0pJX13Zg8298pc0Kx9akaqa21ltMHkxBXDk0AqUDofPuAsXihk1Pep1UjQH2M0iCoGiZVmxNq
	l7qmqVDlE4k4XUcEMTE7lTGUtG2U1NI5C+Ywt
X-Google-Smtp-Source: AGHT+IFKNESuBaBLqS6EzP5WMxarR6LTmeB16ltlblCHxuNR6rizP524KenUkjqny1k/9GhdHS4NpH6g8RdTZBM49vs=
X-Received: by 2002:a50:cac7:0:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-57443d4db9amr256831a12.4.1715596186981; Mon, 13 May 2024
 03:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513100246.85173-1-jianbol@nvidia.com>
In-Reply-To: <20240513100246.85173-1-jianbol@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 May 2024 12:29:32 +0200
Message-ID: <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
To: Jianbo Liu <jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:04=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> wr=
ote:
>
> In commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists"), skb can be queued on remote cpu list for deferral
> free.
>
> The remote cpu is kicked if the queue reaches half capacity. As
> mentioned in the patch, this seems very unlikely to trigger
> NET_RX_SOFTIRQ on the remote CPU in this way. But that seems not true,
> we actually saw something that indicates this: skb is not freed
> immediately, or even kept for a long time. And the possibility is
> increased if there are more cpu cores.
>
> As skb is not freed, its extension is not freed as well. An error
> occurred while unloading the driver after running TCP traffic with
> IPsec, where both crypto and packet were offloaded. However, in the
> case of crypto offload, this failure was rare and significantly more
> challenging to replicate.
>
>  unregister_netdevice: waiting for eth2 to become free. Usage count =3D 2
>  ref_tracker: eth%d@000000007421424b has 1/1 users at
>       xfrm_dev_state_add+0xe5/0x4d0
>       xfrm_add_sa+0xc5c/0x11e0
>       xfrm_user_rcv_msg+0xfa/0x240
>       netlink_rcv_skb+0x54/0x100
>       xfrm_netlink_rcv+0x31/0x40
>       netlink_unicast+0x1fc/0x2c0
>       netlink_sendmsg+0x232/0x4a0
>       __sock_sendmsg+0x38/0x60
>       ____sys_sendmsg+0x1e3/0x200
>       ___sys_sendmsg+0x80/0xc0
>       __sys_sendmsg+0x51/0x90
>       do_syscall_64+0x40/0xe0
>       entry_SYSCALL_64_after_hwframe+0x46/0x4e
>
> The ref_tracker shows the netdev is hold when the offloading xfrm
> state is first added to hardware. When receiving packet, the secpath
> extension, which saves xfrm state, is added to skb by ipsec offload,
> and the xfrm state is hence hold by the received skb. It can't be
> flushed till skb is dequeued from the defer list, then skb and its
> extension are really freed. Also, the netdev can't be unregistered
> because it still referred by xfrm state.
>
> To fix this issue, drop this extension before skb is queued to the
> defer list, so xfrm state destruction is not blocked.
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---


This attribution and patch seem wrong. Also you should CC XFRM maintainers.

Before being freed from tcp_recvmsg() path, packets can sit in TCP
receive queues for arbitrary amounts of time.

secpath_reset() should be called much earlier than in the code you
tried to change.

If XFRM state can stick to packets stored in protocol queues, we have
a much bigger problem.

I suspect all callers of nf_reset_ct() need a fix of some kind.

