Return-Path: <netdev+bounces-234747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFAC26BB9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4ED463523EE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635F034D902;
	Fri, 31 Oct 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8hVTjqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA434A3B2
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938906; cv=none; b=ga67Pf+j+APEJF2fjCOwmvbTbDJgSToCeshkq/BK/c0xKpYeBT+zcKuvw4NwHLtvcBqP7SpGoK+/ZX3ew4JPHFig9N5MrVxbvTAdqOJYgqOtDEiI0bCxG9tnhuB6sUKX8rnFpU6UZEmTXBdvtrlQu+bFNNyMuTQb7TafjqkPYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938906; c=relaxed/simple;
	bh=mUJznE05kUPl0IhO/e5znFzRpuOXnTth9Kcu9imUesY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqY0bqxv1mEqyOLGsu6FbjKD+qvmY9HWcXbaF3RccKzDfps28eKdZ50TKA9Ej3D7QM11lEkAREn57NXaFchbtNHFmZSptrq9+bBkyfIUZmaBQJUT9P2vVOexwKw3fFP2sR7Urwp38swQIDPlFQnkiQt6dcyotIHFzmaVCGqDChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8hVTjqu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d3540a43fso27524245ad.3
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938904; x=1762543704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDwjr1ZOLq8cLo3fTSn/h/+rtzM3FDrXyupCisosREA=;
        b=m8hVTjqudFney8nxFZYvBqMxQKej6AwYCS2apItgNKy/k2kVj9wcesr9yTwmpqGdA9
         P69WApwnDpcMgqsBjOu0PbAq46ewJZVHWJDNCeJovvs3G27dHe7c/bLwmcGQ/GY4kidH
         6LMFhz4ALpX2oKhPzimcDzeet5llptAyJskMEgA7guUigV5W7ltoCI0x4jiY0uBnM8+Q
         qMAQ+BAqy1Mg3N+v76c/LNDFD0CcKRb/8AOf6JtPdO6aWNVNLntc97P5SceH3WXhK6gO
         mbgbF2ndxALECRsLY9IWJolTZyvphF0xXx5GZ8qmcJH6/impAvfmdCqHN8WVu9wzyL/e
         LbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938904; x=1762543704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDwjr1ZOLq8cLo3fTSn/h/+rtzM3FDrXyupCisosREA=;
        b=pHJG2rsMr9Ea0vCzGodNnlRcawX8UN2Osa2OZACrICOOV9LYcItxG9sWmnA8j8ARdr
         iw8ViA6SVp9B+woX4xcgrx/D1+F0fUA5ahNk/prS1bN6CNrp7Wocm3YNKPNS6UhxoXqH
         XGOWJTIGoxWCYdDslnQXp/Nf5jk3ReXqDKL5QhRSE4pR/raqOmZwlq5Co30WBSOBY9bl
         pgP8wHSzLOrlcbu3LM5esZD6yf1x/f+9fLMDx7WchY66QIPzflxS4jC0cfjlmh0B8uyH
         2fSK9GKGyrO7JcbIpfKspVLguEmRkXS3yiM20YohfFaJpd5/0KQGEnNg8n66Px+xKyO7
         UWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy5IW5SsPIffIsLUVMO78e6yzK4QP9QaLnFFtbRzZpnmraCUwjdKSkEQqbUSCEDvpAWHBqacc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPDcGVqVlyihw/2aphTSitcviQofyVwAEFs404DowM+BFqjQ4I
	NC40A4NrGXY/OXeZEDhfnEoUK5Ioex8H2mdYSsPGm8tkWtJbtxClU6cjJg/gIuyOFH5Ra2uC7f0
	ZcqsgetONgKpVLjCeQ6TltzHW1wzWch+bHzNLQNqa95GR8yLk2s0UkVLK
X-Gm-Gg: ASbGncvQvZ5m7tu5kc/p071NVtqX1d/1/A2g/b9MbcIPb6oqsf02sIWRQEeFLgH4vk7
	pUVHIXiy38LCElpUFcxRopDhaQCwExZaNAG37YkHiXIsd8yb+ZjCoP+PHmZczsckhYQboZiWf5r
	N0rouj0iMAXopKhroYqcvKA2+Vm2jfEQNacG4llCw/TB5jYssezjmfiGY+m0/+Etn8QWLW8OOHn
	SSapdQTCoHZ47BgAurkG4VZrn6qGHPwAM+10tzlFXig27/fqjEcgnqMOatxj7nB6IPSsSCa+JlD
	jpIW0sTpVoz9dO3DAQ==
X-Google-Smtp-Source: AGHT+IFigqOtFBCYUqwCmY3qziL8qVWGu/nRTorElbmyiYpFccuK+2gunWWZPScjAXWItngFYakwtYJJBQr3HV87VJ8=
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id
 d9443c01a7336-2951a4976f9mr68144065ad.23.1761938903604; Fri, 31 Oct 2025
 12:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com> <20251028161506.3294376-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-2-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:28:10 -0700
X-Gm-Features: AWmQ_blgcBeSUdxPtx55HtoAsZERyYHkYCJ5aCAKAIqjn5k5KTf1zjWOPzbN5ao
Message-ID: <CAAVpQUBk7CnezW6bOK-5GF3-kQwJZBwz0hLS4TTEiPYTkov+HQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/3] sctp: Hold RCU read lock while iterating over
 address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:15=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> With CONFIG_PROVE_RCU_LIST=3Dy and by executing
>
>   $ netcat -l --sctp &
>   $ netcat --sctp localhost &
>   $ ss --sctp
>
> one can trigger the following Lockdep-RCU splat(s):
>
>   WARNING: suspicious RCU usage
>   6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
>   -----------------------------
>   net/sctp/diag.c:76 RCU-list traversed in non-reader section!!
>
>   other info that might help us debug this:
>
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   2 locks held by ss/215:
>    #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netli=
nk_dump_start+0x84/0x2b0
>    #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dum=
p+0x38/0x200
>
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e=
9a6 #5 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-=
0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x90
>    lockdep_rcu_suspicious.cold+0x4e/0xa3
>    inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
>    sctp_sock_dump+0x131/0x200
>    sctp_transport_traverse_process+0x170/0x1b0
>    ? __pfx_sctp_sock_filter+0x10/0x10
>    ? __pfx_sctp_sock_dump+0x10/0x10
>    sctp_diag_dump+0x103/0x140
>    __inet_diag_dump+0x70/0xb0
>    netlink_dump+0x148/0x490
>    __netlink_dump_start+0x1f3/0x2b0
>    inet_diag_handler_cmd+0xcd/0x100
>    ? __pfx_inet_diag_dump_start+0x10/0x10
>    ? __pfx_inet_diag_dump+0x10/0x10
>    ? __pfx_inet_diag_dump_done+0x10/0x10
>    sock_diag_rcv_msg+0x18e/0x320
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x4d/0x100
>    netlink_unicast+0x1d7/0x2b0
>    netlink_sendmsg+0x203/0x450
>    ____sys_sendmsg+0x30c/0x340
>    ___sys_sendmsg+0x94/0xf0
>    __sys_sendmsg+0x83/0xf0
>    do_syscall_64+0xbb/0x390
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

