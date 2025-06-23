Return-Path: <netdev+bounces-200298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92717AE472F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452C01884C41
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1855267713;
	Mon, 23 Jun 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zbKEGRVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F11F09B3
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689843; cv=none; b=Q4MQQmTM3JtqjRc4ngI5xF0vL5tXGji0LkRz821tZ9wY0X0zlnkEhvuLVlbnl63pitvGrvE1h2K0cNMGws14Yy6nG0/bx3pg8IPmIy3QltoObhvnq+lfGZy7LfyHmgM5ssGIuUB3AhDWpE3tEJWjx7yAXiE5c3NfuQMMTyFJKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689843; c=relaxed/simple;
	bh=HyZkvZsSwu2dSDjYvYmYz/SKc6tAKtz1I91ASN4nAYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK8dQlmfU/PDhVS8Ym5pIzw4xfWqEpLt8XKiNqm70titOcdf5b9u0/am8p3XAnd3Rv/XCA8siRFmrw/4DWU2xP5OeQ06ZGlplai6FB1fTB7ZetDZl5GXuoqP69zDI4GA9Ir4S4ygKS/hrplqJxZho37jbbSOYVlQeNUuZoF7jUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zbKEGRVk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748fe69a7baso3922646b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750689841; x=1751294641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O41AWdReHMM34MBqQ8YMhBhYk6MWfDgda0J7io6LxtU=;
        b=zbKEGRVkB+URNMEtv5STTZZ/eSdEOxNsCzr0A7gLHZrxYPOx+7iXXnCPNZnxUYHmHf
         WMIdI9qi0QUS+qYZXZXgaiU0XQjagUzsDFpl1OdMbJlqSBXRX6rK7s/4gdtaMF1hsVJL
         rOx4SSnCas7NHFEAGy2S8Kdk27n/kwW6UybHAV+i0pQxwtYRxfP7BAWBZEWd5bu5v1Fl
         35K3xS8LBd6ffrlAfbCHCV0gNI2uAlYibBE3IowNsx1/joGrjPLb7F43J9LW8Xzt/ipP
         ru5D1SM3zGa52BR3ggVdpR5wHDke2FOBuaiQYKKt65YtBqzPmZ7+aI7CZyjjdoznvYkZ
         MRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689841; x=1751294641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O41AWdReHMM34MBqQ8YMhBhYk6MWfDgda0J7io6LxtU=;
        b=XHj7GW4pAfetMrlO4NAK+GtDt6TZyQ2HnXlasq7oQuR9q9FwB3JKXs3L+BbfVdOqlS
         AGulysayBgWxNRUp4e+dH4gGhs7bpvig+BNfE5xDr7fSiKxw+ZFomrveKvmN0PyAmnCv
         mjUBJnRQmHe04ir0Hsg9S4BdihGkXrA/K4TjdqXj4t3aoaQEEuie5s6WIwGf6bJuN7bx
         iYjAhnTksw8V1zhutowxa3RLt+QnzrI5mq73hM4KhVA96owMn7jbGM3dTkcXjm6vAlV0
         kxfrVBQlrsXd4UxxbTWEte74Y1fWbKi8WbsgJ/WAvNyiJ9iq1sbhdX2zcmTC6x6caDho
         el0w==
X-Gm-Message-State: AOJu0YwlHwI4fNXbpFkFbRELr9wsmSqcdS90KzK6PEbGVh/s+GMuQ0aG
	gK9BU6H87b4wQWf/xhdtzXMfzlALmhYgqwrkJhDMTqpL5ReVnCwEM2depENZ/xoUcM5MDluKInE
	IJky6keJiJo/iur89FOG1bWddFXVY3DGqKow/iwU5
X-Gm-Gg: ASbGncvMsHt2GcQ0Oq7oEXLHyuUpamiYUm/R0NUZfS8L92GWJk2v5iS2QZaS26OdHtS
	v0p+lsQnF7/Ot7AK24V5dFj72zIjpFPleopXDUiZpPpVge3utEEH/mpLSyYOm6OjX2iJaNJBL/m
	3t5qcJ8I4seg7wNFIFTBv2AfiQlnj/mXtV4TYUfZES5idS9QOhibLs
X-Google-Smtp-Source: AGHT+IHYZ7DK4OQP1h93MlexGUyY9jZ+1bfcPgHWvAH6K8uA+knMxt7bzRR5joVJz/WsnAt+stVwf+gzzp1ww7526ws=
X-Received: by 2002:a05:6a00:228b:b0:746:227c:a808 with SMTP id
 d2e1a72fcca58-7490d6ea1c3mr21018899b3a.24.1750689840967; Mon, 23 Jun 2025
 07:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
In-Reply-To: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 23 Jun 2025 10:43:47 -0400
X-Gm-Features: AX0GCFv-w3yOKk6lIgvZES1u3JwVWM3yf4BoCGjQWMNLMdFb7PtZKS4HllxySOs
Message-ID: <CAM0EoMnxaMCmbKfgQ_=rQ2HcbmPBBqdMiOkjTe2ShbOKow0K1g@mail.gmail.com>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 23, 2025 at 6:41=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> Hello,
>
> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
> incomplete:
>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gma=
il.com/
>
> This patch also included a test which landed:
>     selftests/tc-testing: Add an HFSC qlen accounting test
>
> Basically running the included test case on a sanitizer kernel or with
> slub_debug=3DP will directly reveal the UAF:
>
>     # this is from the test case:
>     ip link set dev lo up
>     tc qdisc add dev lo root handle 1: drr
>     tc filter add dev lo parent 1: basic classid 1:1
>     tc class add dev lo parent 1: classid 1:1 drr
>     tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
>     tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
>     tc qdisc add dev lo parent 2:1 handle 3: netem
>     tc qdisc add dev lo parent 3:1 handle 4: blackhole
>
>     # .. and slightly modified to show UAF:
>     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
>     tc class delete dev lo classid 1:1
>     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
>
>
> [ ... ]
> [   11.405423] general protection fault, probably for non-canonical addre=
ss 0x6b6b6b6b6b6b6b83: 0000 [#1] PREEMPT SMP NOPTI
> [   11.407511] CPU: 5 PID: 456 Comm: socat Not tainted 6.6.93 #1
> [   11.408496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.3-4.fc42 04/01/2014
> [   11.410008] RIP: 0010:drr_dequeue+0x30/0x230
> [   11.410690] Code: 55 41 54 4c 8d a7 80 01 00 00 55 48 89 fd 53 48 8b 8=
7 80 01 00 00 49 39 c4 0f 84 84 00 00 00 48 8b 9d 80 01 00 00 48 8b 7b 10 <=
48> 8b 47 18 48 8b 40 38 ff d0 0f 1f 00 48 85 c0 74 57 8b 50 28 8b
> [   11.414042] RSP: 0018:ffffc90000dff920 EFLAGS: 00010287
> [   11.415081] RAX: ffff888104097950 RBX: ffff888104097950 RCX: ffff88810=
6af3300
> [   11.416878] RDX: 0000000000000001 RSI: ffff888103adb200 RDI: 6b6b6b6b6=
b6b6b6b
> [   11.418429] RBP: ffff888103bbb000 R08: 0000000000000000 R09: ffffc9000=
0dff9b8
> [   11.419933] R10: ffffc90000dffaa0 R11: ffffc90000dffa30 R12: ffff88810=
3bbb180
> [   11.421333] R13: 0000000000000000 R14: ffff888103bbb0ac R15: ffff88810=
3bbb000
> [   11.422698] FS:  000078f12f836740(0000) GS:ffff88813bd40000(0000) knlG=
S:0000000000000000
> [   11.424250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.425292] CR2: 00005a9725d64000 CR3: 000000010418c004 CR4: 000000000=
0770ee0
> [   11.426584] PKRU: 55555554
> [   11.427056] Call Trace:
> [   11.427506]  <TASK>
> [   11.427901]  __qdisc_run+0x85/0x610
> [   11.428497]  __dev_queue_xmit+0x5f9/0xde0
> [   11.429195]  ? nf_hook_slow+0x3e/0xc0
> [   11.429873]  ip_finish_output2+0x2b7/0x550
> [   11.430560]  ip_send_skb+0x82/0x90
> [   11.431195]  udp_send_skb+0x15c/0x380
> [   11.431880]  udp_sendmsg+0xb91/0xfa0
> [   11.432524]  ? __pfx_ip_generic_getfrag+0x10/0x10
> [   11.433434]  ? __sys_sendto+0x1e0/0x210
> [   11.434216]  __sys_sendto+0x1e0/0x210
> [   11.434984]  __x64_sys_sendto+0x20/0x30
> [   11.435868]  do_syscall_64+0x5e/0x90
> [   11.436631]  ? apparmor_file_permission+0x82/0x180
> [   11.437637]  ? vfs_read+0x2fc/0x340
> [   11.438520]  ? exit_to_user_mode_prepare+0x1a/0x150
> [   11.440008]  ? syscall_exit_to_user_mode+0x27/0x40
> [   11.440917]  ? do_syscall_64+0x6a/0x90
> [   11.441617]  ? do_user_addr_fault+0x319/0x650
> [   11.442524]  ? exit_to_user_mode_prepare+0x1a/0x150
> [   11.443499]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
>
>
> To be completely honest I do not quite understand the rationale behind th=
e
> original patch. The problem is that the backlog corruption propagates to
> the parent _before_ parent is even expecting any backlog updates.
> Looking at f.e. DRR: Child is only made active _after_ the enqueue comple=
tes.
> Because HFSC is messing with the backlog before the enqueue completed,
> DRR will simply make the class active even though it should have already
> removed the class from the active list due to qdisc_tree_backlog_flush.
> This leaves the stale class in the active list and causes the UAF.
>
> Looking at other qdiscs the way DRR handles child enqueues seems to resem=
ble
> the common case. HFSC calling dequeue in the enqueue handler violates
> expectations. In order to fix this either HFSC has to stop using dequeue =
or
> all classful qdiscs have to be updated to catch this corner case where
> child qlen was zero even though the enqueue succeeded. Alternatively HFSC
> could signal enqueue failure if it sees child dequeue dropping packets to
> zero? I am not sure how this all plays out with the re-entrant case of
> netem though.
>
> If I can provide more help, please let me know.
>

My suggestion is we go back to a proposal i made a few moons back (was
this in a discussion with you? i dont remember): create a mechanism to
disallow certain hierarchies of qdiscs based on certain attributes,
example in this case disallow hfsc from being the ancestor of "qdiscs that =
may
drop during peek" (such as netem). Then we can just keep adding more
"disallowed configs" that will be rejected via netlink. Similar idea
is being added to netem to disallow double duplication, see:
https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroot.io/

cheers,
jamal

