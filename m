Return-Path: <netdev+bounces-179378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D0A7C317
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24883189967B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5062144DC;
	Fri,  4 Apr 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XutMckpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C95207E03
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790391; cv=none; b=rGG6bMkOKr226yrD1s/PIp8piHXjMtve4FaTqdMweklupfp/FUGAv/tVwJgCudsHFTGHupQn4FhKQx2tsUU04AKcdrNpCHFQpl7xzT2fdtd7RDMcYY0Ygzf6OkjwvWRaI3nPEcRq/n3T8CSkVYFL482psUgphSeY+b5zFip5r6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790391; c=relaxed/simple;
	bh=jvLFkmcF+UWRdcko5n6Ibt6uNx/djCRbhMUSFcaoSBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooKoKXAD9oM3uyMXAf4j+9wB88ZCc8ZntOa+IbbOtlkbWCyY9PSZyZwdRae7xPdhCO82Tv2CfbaPPqE08aRTuafF5heVAbPC5AIrTquN4rl9CQpOSJXoXXoOSFJPADone53VzL6TADVZ3veKMvrh666/iIvqx6UsTgaSenkzu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XutMckpm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769b16d4fbso12879801cf.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743790389; x=1744395189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNZHnO9azwdmk8ZVPakWgyvrwcECvxnPeBR2pzgJtZI=;
        b=XutMckpmVStySbOO2ZxDZZNtMlZVaDSKkehXaxMBUyqZiclO/JbrbUAo/FXqB2yOMk
         wQyHhd5uYPJ6y1YII6iA4AM2TBOWNNKvjA6C0OZoCVnlzLNNflHekuLNr3v+s597nOee
         P9Iaa84KVQ89Bvm8v3sAt6PydDRWQOe0NxHOpwLa5sBZ5KSBxokizJD1xLtaD5ezKp9Z
         WVZSQhplccAUyAI8Yu36Izs4afKUxKyeDoA43j9ByJ1ROjVstYVLYkCbHdmyWSvlQaUd
         BZtM7/DvUC0Jw7/NjqT/Gps8NCxu9fMbSBMDAAGNx+8Hp2WZQK2nV/twzovDHElZ4k3H
         ElWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790389; x=1744395189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNZHnO9azwdmk8ZVPakWgyvrwcECvxnPeBR2pzgJtZI=;
        b=rWFaqn96+j5vYVBa6eGYJsdArQtMfmKM/M/ZjQ1F4xUfy1eDXP30JukKVie1+nx89Z
         021MBmBQX9oomADFiqjYO68no3UgzLq0hWXiSHLgYimlrM+nrX7kg/ehm/uiCOjRuoGO
         tVzs7nzTjyoDWyyoHvqA7JQwALF+t3ImYgyKyVXi9yWIHDQt+vPphtGeNW5AQzvE3Io5
         gzovDJND/HQu/Vtp20hA/jiA2pV8z1qdcbfiaemHzgHFhdqIHm5NE2LCUMz7jDoB5pXj
         +A+VnrDXS8SES1YUnjXgu9G/hd63qBlL/Z5XYWWj4iARllW+tkRVUpOlgWM9rUINxfJp
         +zSg==
X-Forwarded-Encrypted: i=1; AJvYcCU9o3TAnyy4iSz5gDS0FXe2ALPgXfUhtDqOdyOjTftMSYYFdMe+SMuJFC0RCnDJM4SRGBKrCh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyql81KUjmOebw6J33cVKfIkjfBhLajdMWjF1ViVf+VbDzTDK3T
	NxdNvMdJNLEjyNyzYJMDFRdFCk1XmXwFpraWieIPtEmueOTY710RFrju6nex6MwI0wC88Qm9V78
	+78ow4OalbqnaoOg+ezFlcbd30cQNOH8Ev+G3
X-Gm-Gg: ASbGncvXU6SiLh/QsRIkUpZJMsHhsgJj/+J/jTDdC/kkTpGjRSh4XVd4+fYHVPzNMXb
	Vu9GHonhgv+BCW2nnVgDcF/YfJYM9fruoj9F03pHHFtP3szuNGh64/4klgYZgPrDoO/OrpcsuNu
	3/eBmaRbDJlq6fuzPTYiLfnvBRVF8=
X-Google-Smtp-Source: AGHT+IHRNIoP+uM76kPY/WP6ajnpgwoc2J2uO2qtrTDuTr9vc1VFQ29YMER3UekpU+HYTl3jr4CwX2LfHHX8rElldxk=
X-Received: by 2002:a05:622a:164d:b0:476:a895:7e82 with SMTP id
 d75a77b69052e-47925a737b6mr65362141cf.50.1743790388720; Fri, 04 Apr 2025
 11:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404180334.3224206-1-kuba@kernel.org>
In-Reply-To: <20250404180334.3224206-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Apr 2025 20:12:57 +0200
X-Gm-Features: AQ5f1JrOecq0sWQc_ZCBzMu1sQvGNYTS0n6SUYVZFp7AxLo6cxzPRdzxlKkih9s
Message-ID: <CANn89i+pgjE_zNSnnUAvC3NKyV1cvfz8=aG8KOW7W-jk-MPv1g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, sd@queasysnail.net, 
	syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 8:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> syzbot discovered that it can disconnect a TLS socket and then
> run into all sort of unexpected corner cases. I have a vague
> recollection of Eric pointing this out to us a long time ago.
> Supporting disconnect is really hard, for one thing if offload
> is enabled we'd need to wait for all packets to be _acked_.
> Disconnect is not commonly used, disallow it.

Indeed.

We have sk->sk_disconnects for protocols that have/want to support disconne=
ct.

Anyone interested would have to look at commit 419ce133ab928ab5 ("tcp:
allow again tcp_disconnect() when threads are waiting")

>
> The immediate problem syzbot run into is the warning in the strp,
> but that's just the easiest bug to trigger:
>
>   WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0=
x72e/0xa80 net/tls/tls_strp.c:486
>   RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>   Call Trace:
>    <TASK>
>    tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
>    tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
>    inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
>    sock_recvmsg_nosec net/socket.c:1023 [inline]
>    sock_recvmsg+0x109/0x280 net/socket.c:1045
>    __sys_recvfrom+0x202/0x380 net/socket.c:2237
>
> Fixes: 3c4d7559159b ("tls: kernel TLS support")
> Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

