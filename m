Return-Path: <netdev+bounces-113024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C881693C434
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F968B22C2C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CF1993BF;
	Thu, 25 Jul 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/xSlZ81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60213DDB8
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917843; cv=none; b=XbyYh79sMiQEAZWVRMrQZ42fNaGkXQDpltI+7Ufv6OBpv/PS/Ee1XLzK8dVajNflX/T/LHsgYHCCCD5hh8gto6xbMxT9BWiHqaf4YjaMJRfED4ZXTBpouH7BsESRE0jQVfxGFNmIem5feKljuvdjUrQQRqjGunyEwq/T0W3VVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917843; c=relaxed/simple;
	bh=Lg1FHWf1aLoGClu/OyOiRCCyNvZUhpopi17ZPMg2+2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFD4h8vZ9FZFTL2lgDWvCUNw1fr/QE0jnaFuaDyKbahvv3Eo8vp9P1ab4EKlgxJagK77ikxr7bJ1n8RAdCMOP89VtNaHm08GjnItrAB15G4qOO0lYiA4LnpzQNX2OHjUwFYGFAcZ+ggkLzQaIT4+Wd3Yassbcp03HoZUvXR214Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/xSlZ81; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8036ce6631bso8447339f.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721917841; x=1722522641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uStTdLlrGeKjCaIfgYyuhFLt7Bj/JhLBf8bw+a1gOX0=;
        b=b/xSlZ81Pp1vkbgB+YunVuYHLjy0q3Mtq95QdBaTSmnu0vaV3ydwGExe+VoInHr527
         CQ8974joMTcGRpMNjDiyKNqjDPrws9dEgOxhAyRROAgpDnGktIyfH9X0yvOup44TIu2x
         rtbIDiG4KY3MfHLCgK4JDQFtuP4twgR1x1ReWICzoCFhriTwUqrtG4x8B2uOEBMekVZL
         TOlS6LfIdCFrQPaHF/d1+kcTN2DxRrwOCfO1DdmP/Zr/JBUf2+Iogty0YRTsQHNkBn0T
         5gqj1RRa41HW0jy4CuDMIBlGUgNHNP/5UIJ1Fj8SlzV5IsjffFls5pXr6+wo3/bymHs9
         QoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917841; x=1722522641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uStTdLlrGeKjCaIfgYyuhFLt7Bj/JhLBf8bw+a1gOX0=;
        b=bu+3qS/Wc9w8HyDr5WFvxaRXJ2jIGhkCgK45s2ra84ARx3aRhPW2OjFpOH0WQobNC7
         06KE29e3DcqIopYQAkQCAGAr31GxUx7QjxfXrIKqvcK/lO1EJLbpPZPILIn407bWW3L7
         Jd6dj1nw6npcyo3VgZipxaLTLzTbNKmpdiJALl8sI47JcAb6u7nuSJBsySRLIZIG52Cq
         aTH66XoWghCQANzktYMOObMWw+Rv+PedbGtBODUcB3nkQ3nsWeEn6JnRJCXq+Kh/rlfc
         P0J/p/aGc1TSkziSES7/9rr9nPcSjDbJtVl9RHYczWg/dsipA9kOGKgBLsj42PgB6c4W
         dBDA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7UhOcEE5DUFc3iRcRcF7MYrsoyYZRF7XcE9ieVJmXUQ/VunLBTHbDHN1DfjWB3uydaPo5lC64KWGDABg2nuevT/xTEw4
X-Gm-Message-State: AOJu0Yw8ZaI/UdNdk1PQq40E0kp3Svt+3Gsgpnjkr4hCRiSplpTKcmU9
	pcr4WA7woAeowbVdj4KQMojmLs47pena7gynNjGz1DwAv31XB8He1lAls2OF5hDjMEcuy0+IWKX
	Rmupi9SPALgZ6YsJiaENtPGc2sIE=
X-Google-Smtp-Source: AGHT+IFqBFQbRzuELBBkecHjn5yZLQ7dLFt+oM7b2N8hWNaN1pD0VwJREkNlO1tPPTBY0RIremSGEBvxpj27lw38l/Y=
X-Received: by 2002:a05:6e02:219b:b0:376:4aa0:1a99 with SMTP id
 e9e14a558f8ab-39a217f5f6dmr31681215ab.8.1721917840708; Thu, 25 Jul 2024
 07:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725092745.1760161-1-edumazet@google.com>
In-Reply-To: <20240725092745.1760161-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 25 Jul 2024 10:30:29 -0400
Message-ID: <CADvbK_eFe==9fLGDQ8HC3CffQqMx7FMiC3CcN=jb1MQrJJPx8A@mail.gmail.com>
Subject: Re: [PATCH net] sched: act_ct: take care of padding in struct zones_ht_key
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Blamed commit increased lookup key size from 2 bytes to 16 bytes,
> because zones_ht_key got a struct net pointer.
>
> Make sure rhashtable_lookup() is not using the padding bytes
> which are not initialized.
>
>  BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [=
inline]
>  BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable=
.h:607 [inline]
>  BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h=
:646 [inline]
>  BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashta=
ble.h:672 [inline]
>  BUG: KMSAN: uninit-value in tcf_ct_flow_table_get+0x611/0x2260 net/sched=
/act_ct.c:329
>   rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>   __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>   rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>   rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>   tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
>   tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
>   tcf_action_init_1+0x6cc/0xb30 net/sched/act_api.c:1425
>   tcf_action_init+0x458/0xf00 net/sched/act_api.c:1488
>   tcf_action_add net/sched/act_api.c:2061 [inline]
>   tc_ctl_action+0x4be/0x19d0 net/sched/act_api.c:2118
>   rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6647
>   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
>   rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6665
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2597
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2651
>   __sys_sendmsg net/socket.c:2680 [inline]
>   __do_sys_sendmsg net/socket.c:2689 [inline]
>   __se_sys_sendmsg net/socket.c:2687 [inline]
>   __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2687
>   x64_sys_call+0x2dd6/0x3c10 arch/x86/include/generated/asm/syscalls_64.h=
:47
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Local variable key created at:
>   tcf_ct_flow_table_get+0x4a/0x2260 net/sched/act_ct.c:324
>   tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
>
> Fixes: 88c67aeb1407 ("sched: act_ct: add netns into the key of tcf_ct_flo=
w_table")
> Reported-by: syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Xin Long <lucien.xin@gmail.com>

Thanks, didn't know this doesn't get padding bytes initialized:

struct zones_ht_key key =3D { .net =3D net, .zone =3D params->zone };

