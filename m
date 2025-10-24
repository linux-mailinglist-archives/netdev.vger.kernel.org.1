Return-Path: <netdev+bounces-232275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D3C03A88
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B158F19C6FB4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC823C8CD;
	Thu, 23 Oct 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h616HwNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3DDF76
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257979; cv=none; b=p30GD/ENWPp8FdLIkdoEBwzQ3Z/pWHXGYyrqtZwN9ctXu3OXtys9zJ7hxHtAnQ5mDgEJovAMQzHW/nNnl+eKuDV0mYjtLuvzvDRCQN18eqmFDUP4TM9cNI91mz/UURIyfjPrmQgVa/+AlBBawC042dZaSj+e24pqoIqOZYPq8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257979; c=relaxed/simple;
	bh=o6kO31iO1MeiLTSWg/CDcHXSzdjLwgTAcjmyoXdmw1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I90r81tBCF46/v9n3Pc94dwwZPXFuzYspBGQ1JulvzMOaC22P5tFiBW/aNDHSZigjKtf4XQ2Czy7S2IhhrH3oCIxUwId21Pf2KVBR+MFhxTGT8D42fqNUADZgoEInKsKVDAtOpmzw1VCrqtOgmAMuwbjP1+sCvzKGjkMPMQhUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h616HwNf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78118e163e5so2388228b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761257977; x=1761862777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9QYKOjsjMU9O2njuKi/FIruj1qCazkMhQz0CXI8mho=;
        b=h616HwNfatfoQ6VrDBmbDOR5uqlICzxzJ5qJi30fxzRYUoo6m1v34yJyZNTKHpvdCS
         A51vslA3ehHpUUQItehC3xUnAI5MddnU3CVSPEMZ4RPIqUp9lIqaBXxszMMHXXVgVMKD
         1VYis19NgU9aTMYcpGt20RGIWouQM8hQuagi1CPYJpBCL7Ct5SwbM49+Fp0DvRAE6hUU
         Kts5FLcLFmS5MctWI/EV8DE9zkVuarr8pw6NO2HbY/IJpa++mwNCvnscCOWK+qOwwQLl
         Ph0CAGIo+RwM1smXqjzEyLmwNvEW/kBmdSLQS5Ie2n8/1hlSOwbExfnyvIODoP+yTNpi
         iUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761257977; x=1761862777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9QYKOjsjMU9O2njuKi/FIruj1qCazkMhQz0CXI8mho=;
        b=jENl/9BQ4qeMjWfUIiY6r1bWRNsqYh2JAzNcmKYh81rETvdxXH7bwWpcbhvoakJuSn
         o/dwSQVDfAd6eYY5dOho0WEsi6iQBsvQG8zT/84tu+W8u4Qp3PUrshvBVaJ4agM1Xc00
         ZqDKQ4+hQuL4goWkJ6ofp1rsU3U5JqllrLV8nP0rRUCaQ9zA+EVnUuXm42NwHMfAywUo
         SOGnjpEgqw+Lf50zIo8ueKRxjyy476F30Imfh8sQAttcebTRfldTAc4w9yUGwyq71ttx
         mwYMDf6lJjcvDTsYvJq37G1cCAAoyZ8Zv68UGqWIMmRiLAuWVNRQ+beh2rcB5N5PteQF
         xSyw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7rWjgCky2+anT9ZgKjXfJRu6TUHYgI3m6xmBTJq54reVNIZDOnghiQ5/kl1lH7C1C8eoXuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtuTRCmuWdB8CqaHI5KzoKS7HXojcsSwct18Dw5kO1A1ZhZVQ
	hdN2BhernMEHRGSORm7+JYvn39qKYhs42Jctc1+AXPX5ogjAFQiJd6rXpT0TNq+B2LQLKX/6Dal
	XlenpwUsg3BzcWDRzmeTe5OiH4moczI8=
X-Gm-Gg: ASbGncvzgDjqskhpdvIJAMaso4hlNsADjWm2hgvnk+PA6UmPhJks+jcBlTFURs1bASM
	BBsIFbV1elmAcVbMngZOtDh5Pj3GNNo64zFYgLVyrofA4gsVxoEJsUg/FeFwG8OGKn0Ol9wVoQb
	O8WqUqpiRUbeCEWWhDDJz1RX+A4dOTrYxD6O6D8EQKDuE2RI+DbSKYegonQ1Qbonhzt30XsRR+2
	oru3mEengVZq01lZ6fBlhMedWg7aKvgd87KEThqi/pXUr6TuinK2CNTVpbPFetIjOL1weA7jyZP
	zAq1UXU8k/QMazb42laFy9Lu8p3OyA==
X-Google-Smtp-Source: AGHT+IEYwPUORQYLckmwE9piPoRoH7sMHEQwOYjUs7b7ui57FvNvUaj+Q+rWi0qVyoJZCx23NL1JxZRU94carfPY640=
X-Received: by 2002:a17:903:19ec:b0:288:5ce8:ea74 with SMTP id
 d9443c01a7336-29489db6d14mr6172795ad.3.1761257977584; Thu, 23 Oct 2025
 15:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023191807.74006-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251023191807.74006-2-stefan.wiehler@nokia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 18:19:25 -0400
X-Gm-Features: AWmQ_bkihr9V_5UXtCJ30BzGeutIa1rjVX-DG7PuxWr9Z-lnQaz4U55R1vUpMuU
Message-ID: <CADvbK_fBbaKXn_N_n0A9ip5fADUn_CZBRKoBwofsyWEbKwn-=g@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:20=E2=80=AFPM Stefan Wiehler <stefan.wiehler@noki=
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
Acked-by: Xin Long <lucien.xin@gmail.com>

