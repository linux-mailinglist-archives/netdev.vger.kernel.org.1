Return-Path: <netdev+bounces-230758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C7BEEBE1
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 21:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBE404992
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C821ABD7;
	Sun, 19 Oct 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFJEHeHl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D433595D
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760902941; cv=none; b=Nksq9BiyQO3JKwl6B1uUub/j5aIKO8HjcyrfpTbHEbEE7m+92nwAATBwGRchPBWKq2Z6qGj3dfxcJoM3gE0FYO0JGDRiLatP9D/n3SGmkR+PIWYMe5MEjp1G+/qtkD27UAx6I9F1wnV73TP++zGhasUSvWQWSBvYGbnhua0Y5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760902941; c=relaxed/simple;
	bh=XSB/Z5eMPXsH0SnkZti9KICAACRaezDaY0MGRELcZIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6M17sufDKhmuQ0FEaEutUq9MXMWrJwSyo18pEHpV208wRDA7FsHnue/XDZnQKpciZ6cz0/wFOqGIOqk43C6zgKaVBfVsOhNhtAhP7IY7vRh/bZN7lZSpsoaioXz+HS14ftiHEzRaNndwGv51mmsEr4TfYrR6s/KA2FpJ7jPy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFJEHeHl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eceb38eb1so38179485ad.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760902939; x=1761507739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKn1ker1ac53g0AVdlOqM6FCcxaRvdrQ6DT66/wwyz8=;
        b=XFJEHeHlBmVDV/fCz7nqFElvwdGbXxxL9pZEwmqw7Hxkk2EfugvhKguG6koEBF3Xbm
         G4MCc3OnHCeaMH4paiyEsBCfoNKVq9RbBAewQzAYsfjgizGlkmGNgiYy8JcaJTfQCv6s
         /pugv4lL6tyiuDU15FqXeGqimAg54Ujcdz+UmrXjOZ238+UzQreFQfNHuVdJ62qIXV9d
         sLsUu5n5hRygiqluTywqxystXWHUomdiJrK9PKRKYqiCULUPlmIczqyv0Bb5/nB3tHav
         kh7Yv8FmSRYXezSqFhZ53G1On5bfQN58tcEYA+CKPzGLYU4gFMHRpIAKm4zDbldE1/kV
         hwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760902939; x=1761507739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKn1ker1ac53g0AVdlOqM6FCcxaRvdrQ6DT66/wwyz8=;
        b=g6j6kZ02IyFIjpxYejklJY8cweoAfSqJIs4TFgqHvCddBrnE5JS9jxyPWnMqqadrIJ
         dz+3l8T0i0ByFyl+gyqJI0deJtfNviZPC9LsIFn03DMdSLZf4mAVgjqdJhVmPj7/Am0B
         sB/C1lP60f5vi/OEa8bCAlmtwOiNdtYB7PDkfz3g6myrhlP4KfCnNNoEkFevGzgI860w
         I7c5xeU/GT5hZlS2l9ZjWDyCgCWNQ4LKZtY9dubbsQ3bRvXPLlMyBkXxsrxl2GTptXVV
         hHT9upJKm5KzuJzVDWQD0ISkVB+dAADR3W7fXrvzzIR+m1N4A1GmJCQuScr3lL4bLHOS
         tbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVulnsF1MheoLNoweMVYoG+R0i2ThcMqAmyln26ta5xBsrRle7kOnyIw5nf4RGMDtgtFzakids=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tFk9ock7FPTtAt0lUHmLaj69+71jvAOUL5WXVH/LbCCmjxrI
	72XlnW7CZRs2L7Nz3wiqN4OlGhDHHjIrQBX7CpllfTM2Acs0PKUTkbD010IwmViBM5mH0yPb6Cm
	W4bnlCR3XVivXiXQIlw8QeCtMC62d8nn5yu1ZYsmm
X-Gm-Gg: ASbGncvKPmqqibMik/Ule6H8BNgiKDxOlOmQG1IfQNvkROGTE887RhVP+bUliGjDrrZ
	UmK18az5FlPs/s0ZywvT3c78TzjSDE1b1bI6g5Sw1XM7zcArT3285LrXNhhElDAUyJRJefOFHD+
	iOk8y/MgU/+xo2xd+e5+Iu2nwoZFrVoaqt8yxmA8flaWoUu7qZMCVogvKe2MhQwHvy3iFuossWh
	JQi8tXjgc2Wb4R5v/Bdhxp+SSWudSMW2+EVOToywb69lkxynxOxio6AOS4Km6KZ49L87u1fXF3a
	MU/5XZ2T2rv3nEv82a/JTuGTdzd5
X-Google-Smtp-Source: AGHT+IFFQYL2jmMNJWTB/zLjNozbzczgm4QuuJQJzpUYE2TaqkxQ/GMIxfJ9t1vRVlBPGmbDLmE0FCLRLeEuEtkwgAY=
X-Received: by 2002:a17:903:4b30:b0:27e:e55f:c6c3 with SMTP id
 d9443c01a7336-290ccaca5cemr133517685ad.55.1760902939128; Sun, 19 Oct 2025
 12:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145334.3016097-1-edumazet@google.com>
In-Reply-To: <20251017145334.3016097-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 19 Oct 2025 12:42:08 -0700
X-Gm-Features: AS18NWAtPfg6gAHs0PS90Aium-0mW59RwK6a1eKdz0dm9iuaUY7_-JDQ-X7VqH8
Message-ID: <CAAVpQUD7LsivFAkuRAFsXGOUygQMJ_+PFQcYv1weKwwQtdv9Nw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add a fast path in __netif_schedule()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Cpus serving NIC interrupts and specifically TX completions are often
> trapped in also restarting a busy qdisc (because qdisc was stopped by BQL
> or the driver's own flow control).
>
> When they call netdev_tx_completed_queue() or netif_tx_wake_queue(),
> they call __netif_schedule() so that the queue can be run
> later from net_tx_action() (involving NET_TX_SOFTIRQ)
>
> Quite often, by the time the cpu reaches net_tx_action(), another cpu
> grabbed the qdisc spinlock from __dev_xmit_skb(), and we spend too much
> time spinning on this lock.
>
> We can detect in __netif_schedule() if a cpu is already at a specific
> point in __dev_xmit_skb() where we have the guarantee the queue will
> be run.
>
> This patch gives a 13 % increase of throughput on an IDPF NIC (200Gbit),
> 32 TX qeues, sending UDP packets of 120 bytes.
>
> This also helps __qdisc_run() to not force a NET_TX_SOFTIRQ
> if another thread is waiting in __dev_xmit_skb()
>
> Before:
>
> sar -n DEV 5 5|grep eth1|grep Average
> Average:         eth1   1496.44 52191462.56    210.00 13369396.90      0.=
00      0.00      0.00     54.76
>
> After:
>
> sar -n DEV 5 5|grep eth1|grep Average
> Average:         eth1   1457.88 59363099.96    205.08 15206384.35      0.=
00      0.00      0.00     62.29
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

