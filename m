Return-Path: <netdev+bounces-54128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2168060CD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5F1C2102E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0846E5B8;
	Tue,  5 Dec 2023 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="COJCdoI6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4C2721
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:31:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so238863276.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811891; x=1702416691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCWlUj7m/TUVBxbveuACbE3ZhjXxRgHmisPs0nAyjOE=;
        b=COJCdoI6jSTFYAszq36g6D2WpqboTfn5ALcUwpywY94chncEGF4Zhx8pf75MmxLPzo
         ZwCp7Z6/2G09OF+WeisyAseTTjKgb6rMMbNsXExQH2qH5BOBXDRrV+myWLK1CABNV4UC
         zb2804oXsAVU6bMac6FJ1q0ZTYodqdRm5j30uvzHFvYd3Oe5P0wOFMt2lYaPnCeDHgAi
         zRpb32eUWK+6FGukiXm1UTv7k0qooljNRjMizZRL41dgLZ69N764xB5Auh/PBMqpCNQj
         APZK3V3E899zYfZbl9pNMQbGUfdZDOz2ivTkzRWuhoc+MvyBkpUkv//AeLJ5JisCWEJJ
         u7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811891; x=1702416691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCWlUj7m/TUVBxbveuACbE3ZhjXxRgHmisPs0nAyjOE=;
        b=uksmAw8iHfGnI0h63kiOsGudvfIt7fh0JsE8kr/EIJtXCX16WM9wVcTdAkjAoi+ymL
         VzyTjqkf6SxhOYaFNQFIad4J3hNXnIBFG9v5wdSQRpa1hkCtiwd0iMDXqUWFXYVUecuF
         qG3myFV/xe7BQkNhrw4QZLa3EisqlLde3khw0/Qwpk/AVe4IdjfaqWHeaNVINktmoqGR
         c930lvKDEH4F0iksa5I6XPv12mROct9XDkb+4ZTGrCHr58c/QApxx7tBLJNMudSBDBIt
         zR70k1t9ZrmwsqHYA5lJ8+g1HnWwyLvjAuT20SYvVyj55+Jt3gfs4GpvvzfQUHH0RHND
         vOig==
X-Gm-Message-State: AOJu0Yyo7DKTWTrO1GmBvJxrPhIK30IEDH67HuqdwR2Eo2kN5GNE9nk/
	tyu5pZT8hRpAQeayF+Kg3Pflu0W7ncrLZa2Q/DTD
X-Google-Smtp-Source: AGHT+IHwOBCUJ7VoDCxkP/0bmnjLbDc1iTH7bsrP/zrgAjrf91uJBTPKrWd6z8h4v3WgDEBA+xmeV8A5C/Hd1wf57zg=
X-Received: by 2002:a25:f445:0:b0:db7:dacf:6f4 with SMTP id
 p5-20020a25f445000000b00db7dacf06f4mr1296574ybe.56.1701811891206; Tue, 05 Dec
 2023 13:31:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru> <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Dec 2023 16:31:20 -0500
Message-ID: <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in netlbl_calipso_add_pass()
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 9:47=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Nov 23, 2023 at 4:25=E2=80=AFAM Gavrilov Ilia <Ilia.Gavrilov@info=
tecs.ru> wrote:
> >
> > If IPv6 support is disabled at boot (ipv6.disable=3D1),
> > the calipso_init() -> netlbl_calipso_ops_register() function isn't call=
ed,
> > and the netlbl_calipso_ops_get() function always returns NULL.
> > In this case, the netlbl_calipso_add_pass() function allocates memory
> > for the doi_def variable but doesn't free it with the calipso_doi_free(=
).
> >
> > BUG: memory leak
> > unreferenced object 0xffff888011d68180 (size 64):
> >   comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000730d8770>] kmalloc include/linux/slab.h:552 [inline]
> >     [<00000000730d8770>] netlbl_calipso_add_pass net/netlabel/netlabel_=
calipso.c:76 [inline]
> >     [<00000000730d8770>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/ne=
tlabel_calipso.c:111
> >     [<0000000002e662c0>] genl_family_rcv_msg_doit+0x22f/0x330 net/netli=
nk/genetlink.c:739
> >     [<00000000a08d6d74>] genl_family_rcv_msg net/netlink/genetlink.c:78=
3 [inline]
> >     [<00000000a08d6d74>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink=
.c:800
> >     [<0000000098399a97>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_net=
link.c:2515
> >     [<00000000ff7db83b>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
> >     [<000000000cf53b8c>] netlink_unicast_kernel net/netlink/af_netlink.=
c:1313 [inline]
> >     [<000000000cf53b8c>] netlink_unicast+0x54b/0x800 net/netlink/af_net=
link.c:1339
> >     [<00000000d78cd38b>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_net=
link.c:1934
> >     [<000000008328a57f>] sock_sendmsg_nosec net/socket.c:651 [inline]
> >     [<000000008328a57f>] sock_sendmsg+0x157/0x190 net/socket.c:671
> >     [<000000007b65a1b5>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
> >     [<0000000083da800e>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
> >     [<000000004a9b827f>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
> >     [<0000000061b64d3a>] do_syscall_64+0x30/0x40 arch/x86/entry/common.=
c:46
> >     [<00000000a1265347>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > Found by InfoTeCS on behalf of Linux Verification Center
> > (linuxtesting.org) with Syzkaller
> >
> > Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink=
 protocol.")
> > Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> > ---
> > v2:
> >   - return the error code in netlbl_calipso_add() if the variable calip=
so_hops is NULL
> > v1: https://lore.kernel.org/all/20231122135242.2779058-1-Ilia.Gavrilov@=
infotecs.ru/
> >
> >  net/netlabel/netlabel_calipso.c | 49 +++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 23 deletions(-)
>
> This looks good to me, thanks!
>
> Acked-by: Paul Moore <paul@paul-moore.com>

A quick follow-up to see if this patch was picked up by the networking
folks?  I didn't get a patchwork notification, and I don't see it in
Linus' tree, but perhaps I missed something?

--=20
paul-moore.com

