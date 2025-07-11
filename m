Return-Path: <netdev+bounces-206255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F1CB024A4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15CE1CA5EFF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C402F199D;
	Fri, 11 Jul 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW+1RGew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBA2EF655;
	Fri, 11 Jul 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262416; cv=none; b=HHEgx3SD2Z9fI7f8ueizQpvpEzXmi+EZYzIwLtFCiHnPyXyXU3SQzd5wuN73JzAAlwvmma0ZdSS4yNvhFoI6thArT+s1B1HBLlk6hRmM/ZEeJr0LcRIV7wvP+ZXWFCX8by8Ec0k3Yl2f4du9ecdTx0TNrxPCZvwhRNOWBQgbyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262416; c=relaxed/simple;
	bh=HqVVzddUWtwAzEJxp6f2T1dyAY+ESFrt70EqEcYIXTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=imG7cAQGY9UPJ1F1Rqp1M3FOrv8XCPN+ms/8gtC7TIOjj0uOtJKdWnHEQKdHzkS+m9S58GDMQxegUGw4GI2JnltyR6DJyz7uE5tO5asy5a0tchrTVEvQJKgkJyBG5pFI40yJownHQmNOm2Ry+eYoy/JcEguaaxR2lBVFNo3J06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW+1RGew; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81826d5b72so2222229276.3;
        Fri, 11 Jul 2025 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752262413; x=1752867213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbWyoWiU5vFDucZZ/gUFfjXZSzaDgjtkrOgdfR/Rv8E=;
        b=VW+1RGewZWguKF7QVnjuEOoAlo05H1My0n+++qv/VGXvEqbT9YLbs51oOcA4a15w8p
         SGvyTEmpvIyNEGyyPdDiRcgE/64c3iwJpLlhEeNBIfr/BQ8AbC+GIpwbo5ZIpXRkuVV1
         pG4B4LSajHn4R7wk2Owtw7PV+2qBpcppdakgjVGaeFWsjVFF7Cy6azBajkvMhly0clB5
         xLkeUrZTiZMuMVi4ov8SjUkRlXXaYdsipZhPwfVP/5cHA+gbOaJnx7DXeyHpY3KLIeQ2
         jEfbhHrFtsf2wxx7NddgolWiWCXkltm8R+LCbbqIaUExbFefb2VkgdV2YrICNkNMwu9k
         sY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262413; x=1752867213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PbWyoWiU5vFDucZZ/gUFfjXZSzaDgjtkrOgdfR/Rv8E=;
        b=ViD9kH4lOenV/cHNyx1NDSOibHzg7lIQ9UNeDYAFOqq5TI0ozWQWO3vlgHbTUfJMlk
         5qSDAlajeHoRbWTHRYWZNKGhsts0wt2jeI+fPzfL98/Q1LS9CnR4hE6F+5odVxhehn+2
         7lofd/j13gnWAQY061Z7LFMhn4DJZpeF7nHS+UGB1UnRkkUph+6L43Y4DVPDS9YerZv2
         BdgtBtcbnhRLXq3CsLhhJnzuogjYm9lndz/qhkV7nPOA9GRr7PTKfhUQqy79IKdOE/HR
         vvrqJRlISoIQgcKACOurPF/VDvn0wXBdm9upM55W8S2GLBmOb05VM7axXpfXnQ9UJF6d
         MeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8adD5jq+cTBUIXcB5Nug/BLbEatWb+zbV9RkdwSMyLoUjXKnKb7r9RaWt3LwxA15cCpU19vSZ6BKv7Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZypDMKDktzalKvPFGSOgnGEP05w7V4dP8YeYAarmEbIpndNBM
	azHKqapEsxU0Ye+QiJee1JFDruJt4owYOJDgkd6e7goKRAkrrOorXGxK
X-Gm-Gg: ASbGnctCMOkhwKzXvywZcTWQMyludhPuQFglAxpIxN2tOCSO6D3sVieCbjp+u7uGjMp
	XF1Ym8HJGLKlW5xfbRM+NgPvC8DTqAUb/as0W8shH8ba21+xFctG0QaCUNzpIKaVbC6EpjgQnkF
	0kHP+E+JTkJ+ywlzvrobO1mPw5FnfeY42cvar7ZuBoJuVX+VvwILXk03TMN9QUstVev1o/nSey3
	T6IJjj9hMzQJSOpEX2c2UfWcYSLaVkizbaHcL2cgdrqGPAP5ZfXNmMcaybZs68bIpUoykWV1ow2
	Sf1OLah08pj1qF5hZYW2lQrsijTL8dz8/A4Jjg6BC3j+Df0yi2VazsB5gmsFTbE3VsoaPKaHrx2
	FyhfgsKM9WuQZUbOAzG/7Icc/ekRjuGteHX5sQdIwirG8bG53p1OuWPeNcpO2JocY0KbngeWWpC
	M=
X-Google-Smtp-Source: AGHT+IHnRo+DEvjyP5XmUCwUyxgjN9C9vo8EC9owxgidK1B/gzAaiuQmbztk7lNj65Rd5ftKXCXzug==
X-Received: by 2002:a05:690c:3403:b0:70d:f237:6a60 with SMTP id 00721157ae682-717d5b76eb9mr70160887b3.7.1752262413507;
        Fri, 11 Jul 2025 12:33:33 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717d33e81ecsm6265557b3.112.2025.07.11.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:33:32 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:33:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: luyun <luyun_611@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6871670c9f9a5_168265294c9@willemb.c.googlers.com.notmuch>
In-Reply-To: <515fc9c6-a4a2-4fdf-8d91-396e42c95767@163.com>
References: <20250710102639.280932-1-luyun_611@163.com>
 <20250710102639.280932-3-luyun_611@163.com>
 <686fc5051bdb8_fd38829485@willemb.c.googlers.com.notmuch>
 <515fc9c6-a4a2-4fdf-8d91-396e42c95767@163.com>
Subject: Re: [PATCH v4 2/3] af_packet: fix soft lockup issue caused by
 tpacket_snd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

luyun wrote:
> =

> =E5=9C=A8 2025/7/10 21:49, Willem de Bruijn =E5=86=99=E9=81=93:
> > Yun Lu wrote:
> >> From: Yun Lu <luyun@kylinos.cn>
> >>
> >> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait fo=
r
> >> pending_refcnt to decrement to zero before returning. The pending_re=
fcnt
> >> is decremented by 1 when the skb->destructor function is called,
> >> indicating that the skb has been successfully sent and needs to be
> >> destroyed.
> >>
> >> If an error occurs during this process, the tpacket_snd() function w=
ill
> >> exit and return error, but pending_refcnt may not yet have decrement=
ed to
> >> zero. Assuming the next send operation is executed immediately, but =
there
> >> are no available frames to be sent in tx_ring (i.e., packet_current_=
frame
> >> returns NULL), and skb is also NULL, the function will not execute
> >> wait_for_completion_interruptible_timeout() to yield the CPU. Instea=
d, it
> >> will enter a do-while loop, waiting for pending_refcnt to be zero. E=
ven
> >> if the previous skb has completed transmission, the skb->destructor
> >> function can only be invoked in the ksoftirqd thread (assuming NAPI
> >> threading is enabled). When both the ksoftirqd thread and the tpacke=
t_snd
> >> operation happen to run on the same CPU, and the CPU trapped in the
> >> do-while loop without yielding, the ksoftirqd thread will not get
> >> scheduled to run. As a result, pending_refcnt will never be reduced =
to
> >> zero, and the do-while loop cannot exit, eventually leading to a CPU=
 soft
> >> lockup issue.
> >>
> >> In fact, skb is true for all but the first iterations of that loop, =
and
> >> as long as pending_refcnt is not zero, even if incremented by a prev=
ious
> >> call, wait_for_completion_interruptible_timeout() should be executed=
 to
> >> yield the CPU, allowing the ksoftirqd thread to be scheduled. Theref=
ore,
> >> the execution condition of this function should be modified to check=
 if
> >> pending_refcnt is not zero, instead of check skb.
> >>
> >> As a result, packet_read_pending() may be called twice in the loop. =
This
> >> will be optimized in the following patch.
> >>
> >> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting fo=
r transmit to complete in AF_PACKET")
> >> Cc: stable@kernel.org
> >> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> >> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> >>
> >> ---
> >> Changes in v4:
> >> - Split to the fix alone. Thanks: Willem de Bruijn.
> >> - Link to v3: https://lore.kernel.org/all/20250709095653.62469-3-luy=
un_611@163.com/
> >>
> >> Changes in v3:
> >> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
> >> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luy=
un_611@163.com/
> >>
> >> Changes in v2:
> >> - Add a Fixes tag.
> >> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luy=
un_611@163.com/
> >> ---
> >> ---
> >>   net/packet/af_packet.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> >> index 7089b8c2a655..581a96ec8e1a 100644
> >> --- a/net/packet/af_packet.c
> >> +++ b/net/packet/af_packet.c
> >> @@ -2846,7 +2846,7 @@ static int tpacket_snd(struct packet_sock *po,=
 struct msghdr *msg)
> >>   		ph =3D packet_current_frame(po, &po->tx_ring,
> >>   					  TP_STATUS_SEND_REQUEST);
> >>   		if (unlikely(ph =3D=3D NULL)) {
> >> -			if (need_wait && skb) {
> >> +			if (need_wait && packet_read_pending(&po->tx_ring)) {
> > Unfortunately I did not immediately fully appreciate Eric's
> > suggestion.
> >
> > My comments was
> >
> >      If [..] the extra packet_read_pending() is already present, not
> >      newly introduced with the fix
> >
> > But of course that expensive call is newly introduced, so my
> > suggestion was invalid.
> >
> > It's btw also not possible to mix net and net-next patches in a singl=
e
> > series like this (see Documentation/process/maintainer-netdev.rst).
> =

> Sorry, I misunderstood your comments. In the next version, I will =

> combine the second and third patches together.

My original suggestion was just wrong, sorry. Thanks for revising again.
 =

> >
> > But, instead of going back entirely to v2, perhaps we can make the
> > logic a bit more obvious by just having a while (1) at the end to sho=
w
> > that the only way to exit the loop (except errors) is in the ph =3D=3D=
 NULL
> > branch. And break in that loop directly.
> >
> > There are two other ways to reach that while statement. A continue
> > on PACKET_SOCK_TP_LOSS, or by regular control flow. In both cases, ph=

> > is non-zero, so the condition is true anyway.
> =

> Following your suggestion, I tried modifying the code (as shown below),=
=C2=A0 =

> now the loop condition is still the same as origin, but the logic is no=
w =

> clearer and more obvious.

