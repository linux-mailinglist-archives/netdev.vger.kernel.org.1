Return-Path: <netdev+bounces-64651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6E8362C8
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 13:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC39D289434
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295A3B790;
	Mon, 22 Jan 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Con4/fbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E13B2BF
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925123; cv=none; b=TcjZxbinA3XRtSuWrvUge3CB7gOxypvpKORQAVstZXPW8Ez+/6HqzoKI0cUnNUx6PFm8gIisVgJigmAtntD2f8yvnt9jPM/X7C82LCpQjMim4wv60ekwdW2Jc449fLDJEatrytRvRyoBF4lMOwt2ZnLGH69/hT1BJ2gtrdRd3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925123; c=relaxed/simple;
	bh=u7S/jdB1Dy2pQ9IW3NQ2ljJCJKWpQ/bKhhsYIE+ira0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlEbyUDdzubhI3tHV7Kej/yMpUpr8flIQp4g8QptzRIh4IVtOfUqNvtfC7II3Gx/C8uSUJl//jT6VEv2/GHhlmwAYlK6wDdM8im7psUlwb99HqjZn32Ym+LnmGCeN53B99bJEk9XTpN3AEkZqWurAu6s2R/UhLjDFPDqyVDp5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Con4/fbV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so6532a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 04:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705925119; x=1706529919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuNTWGZcfjM1YzSznjjfGHQINmpVyE/XllmWFq9KKMc=;
        b=Con4/fbVzc8MsnCtQZPP+tpNDNdT9ORHazActkahh4HNv1utbkMNnrM5CbFr7tdjHv
         U7lSNa9YMrdtU+gFol/ujk+c39eBnEl8O+dzkoC6L/lteDfhg4VZGbvn3BtGP0XEUBL8
         hB5M8XeIJTLspCubvMb0qpbBjxSw8YLqGAnzCN2Rd8Tv1qWw18hgT9ZJV3BbShOvQ59P
         XhvmNaow362XaXPmZrxf2BXXFC7XQDu0jWRpip1AQGTtDlAEfnJW/v4sYIxm1n64cOXk
         4Qfyq2VfIRh61B+JcjNG2qOXgetwJnh7VuXLlOvXJx2+mtPLawhd04b8tjCPmr6atDVZ
         No/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705925119; x=1706529919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuNTWGZcfjM1YzSznjjfGHQINmpVyE/XllmWFq9KKMc=;
        b=n2WHbLavTmukevb5RziZpeFKbhcsYXAKqsMP90ptKwlrPNci8orqMmvmc07YPIwyn4
         3PTTLzMwpk3imB33su9C2oHCiARNrrx1drWrUmPPYkXVO2TnFawBeMjb/QRbTEcfKSDx
         DcjN1adm2U9z71eulObRpHno8+2mm8kfejn01ey5o93Ba5BsiKWK2GehSsDeZPWoFxGB
         u/t4zQlQiN4GN/kmoBhDVAfHLhC87xdvD0Ebum6/+WZFJ7D3V7GLVdH5YcdOd7KfPX7U
         5KiRmaW9R4qpCb2iDyhvDSz+aklCXxI2PQx0InVu9WIIobkabNPvsGxYE2j4Di6+dad7
         SwVw==
X-Gm-Message-State: AOJu0YxfMEtnR1yWVUgH4n8vqUt4H/hw6lfgqqZ3fKnjV7pDY1iICeo8
	JsuXBcVeGGSOySeXepKbx0VuuHTPZiJsQxH7qPnwJshLRdBPhpRn9hFaI99gyA==
X-Google-Smtp-Source: AGHT+IFdpwG/XCMDcD9Hegj6Cwm2OsVbTQIBWlyjxWMM1b1eIeGFfCQyjb0++UTCQjGKiumcFIj76NCu6+ySocas9lY=
X-Received: by 2002:a05:6402:17dc:b0:55c:6a45:d6de with SMTP id
 s28-20020a05640217dc00b0055c6a45d6demr2262edy.0.1705925119224; Mon, 22 Jan
 2024 04:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102001.2851701-1-shaozhengchao@huawei.com>
In-Reply-To: <20240122102001.2851701-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 13:05:08 +0100
Message-ID: <CANn89iKSkpWWBWUXj37LS11O=42S9sm5o0Dj0SQeESG_V9U2rQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: init the accept_queue's spinlocks in inet6_create
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:10=E2=80=AFAM Zhengchao Shao
<shaozhengchao@huawei.com> wrote:
>
> In commit 198bc90e0e73("tcp: make sure init the accept_queue's spinlocks
> once"), the spinlocks of accept_queue are initialized only when socket is
> created in the inet4 scenario. The locks are not initialized when socket
> is created in the inet6 scenario. The kernel reports the following error:
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Call Trace:
> <TASK>
>         dump_stack_lvl (lib/dump_stack.c:107)
>         register_lock_class (kernel/locking/lockdep.c:1289)
>         __lock_acquire (kernel/locking/lockdep.c:5015)
>         lock_acquire.part.0 (kernel/locking/lockdep.c:5756)
>         _raw_spin_lock_bh (kernel/locking/spinlock.c:178)
>         inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1386)
>         tcp_disconnect (net/ipv4/tcp.c:2981)
>         inet_shutdown (net/ipv4/af_inet.c:935)
>         __sys_shutdown (./include/linux/file.h:32 net/socket.c:2438)
>         __x64_sys_shutdown (net/socket.c:2445)
>         do_syscall_64 (arch/x86/entry/common.c:52)
>         entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> RIP: 0033:0x7f52ecd05a3d
> Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
> RSP: 002b:00007f52ecf5dde8 EFLAGS: 00000293 ORIG_RAX: 0000000000000030
> RAX: ffffffffffffffda RBX: 00007f52ecf5e640 RCX: 00007f52ecd05a3d
> RDX: 00007f52ecc8b188 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f52ecf5de20 R08: 00007ffdae45c69f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f52ecf5e640
> R13: 0000000000000000 R14: 00007f52ecc8b060 R15: 00007ffdae45c6e0
>
> Fixes: 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks on=
ce")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

