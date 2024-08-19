Return-Path: <netdev+bounces-119776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C3956EE2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1201F21621
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDD60DCF;
	Mon, 19 Aug 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWl5+o72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89E335BA
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081792; cv=none; b=JoDe6Q2P+7GzkT1p2kK/uFCBoQUrdImIqtKZaKX1ntHLXfSpm7z6RnUmAupEul3KFz1GhmTk8iID+Sa8fPtf5Agzfd1hDgJ1m33LfFtnncjk4Sa0QGhlT1Xqj9QheR5LgSWMGghopU6/LTGjy/Bb+TZxM4Lcxc7DxBc86U/TsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081792; c=relaxed/simple;
	bh=sVcb4gFTrxfhSE3Zi4Cmm79kGkPdOFGHsac6QPwI4xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ic5hxKz8+VB1uLcUNGTqxUsqsC1wVU7M4KLL6JLQIFy50RoJ0Qgp8oBEeRmDXHtg6iTgjw3sh+3ZM0VNG4hvUt1TUG3C4G1PkHJY5ioQ9683lpCFzZQVDi1e6mj/W3aF4ZKQf/id/zJmDI8KIlMaZIgBIytep0gafoF8C3YD2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWl5+o72; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f921c40f2so152021839f.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724081790; x=1724686590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ttIameS1GJIY3GSZZTnVAo7vhg3xyFOyK3Yz9e8pgU=;
        b=OWl5+o72YsXxevin/5mSEnVlOT5mBTfmjEC1G0kfmMzx2hX/D8MPZNXbVsI+7caopt
         kusbQGXSFTyx++RxU94sZmzyfzLHEczQPVRRoRkdId/bTkatVpL/b7l4xDZ6neNnY1+2
         CEnRTiRnIUHMl1VnlaUPLJyOBqu52VUA9QZvaG7B1gs4+HbJqsQG69bKDhhj4dq2nc54
         tAodYkaqTLiSjvPrYBkKTaBQFpAJWxM2L+rdkKKnXHMtfTRDGydjbV1fNsMEBuEZaS0Z
         mVPYw0/FJTrtfoe92Gqzlz3Lri49NVmrV9OXMoCU9aSvS/lOkxMzGpllumJBXFxWjWfb
         i8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724081790; x=1724686590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ttIameS1GJIY3GSZZTnVAo7vhg3xyFOyK3Yz9e8pgU=;
        b=EbVmNVIDF1Hu8kBBhnng872hFC7lLPUMSaHWcJiO9gjoweNXH0QIKIr6GE1z/UkpkY
         EyWMe+/fbdTKA/cNjSS04fSARfQH/tdEoObloHD+tIBC6AVTpJyHik5m2o8VqbD+gKIj
         yPjIV4v1iPP/+JQZFz1y2XlWBnQkN294bO5TgjKvm99SXRL3PkmbW4RMBfA43JSZeh9a
         nGTebhljnSBG8B0cZB/mgroB70QuzFbuVD0DC8qGec8p+1ddl5GA2y3ldGNT1BCWBitR
         qwaSwpOh2AWW1AYIkj/z1GgdqPgSrggVefNjbg57Z0+kaCDpz4rQlbqIZYODBTibkuaC
         m/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6uoxPimFMwTkYWfibSXjU8tg7YFgcR+fNbwjZ4xf+kljle9tRmecFDmp7MuejdcRdLSU81grioqLNv3Y3OCJ6x02pyol
X-Gm-Message-State: AOJu0Yyn9uWe3SKlKct3JMImU5qH6iNO1/X+E2ja6gEYW5AGF/F1K0R3
	X2kjcxw++LnNQdVLNwufUammWTo5iNdQAD3UVfwTOj5boYr2+KgNDypmpdn66SvGp/W2meVf81V
	9Ic3BY3qdpLWN8zNBhQSaRI57T0dPO/GbWzxn
X-Google-Smtp-Source: AGHT+IHAGodmxQacVkFktdmp0sKvtp7K2ZdwczqTh+Bn2v3ro3tbQguxfNb/WGR3q36CItKwCJUWiIWU+1mzIKJQAuY=
X-Received: by 2002:a05:6602:15d2:b0:824:e864:569 with SMTP id
 ca18e2360f4ac-824f26e9354mr1370007539f.11.1724081790064; Mon, 19 Aug 2024
 08:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812200039.69366-1-kuniyu@amazon.com> <20240812222857.29837-1-fw@strlen.de>
 <170606da-5d5d-40f5-a67c-9c8624a5e913@redhat.com>
In-Reply-To: <170606da-5d5d-40f5-a67c-9c8624a5e913@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 17:36:17 +0200
Message-ID: <CANn89i+aZHCc-uGyjqxsuio-6JsUJ3wk7gLrTZK=XgpgfMKoFg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: prevent concurrent execution of tcp_sk_exit_batch
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/13/24 00:28, Florian Westphal wrote:
> > Its possible that two threads call tcp_sk_exit_batch() concurrently,
> > once from the cleanup_net workqueue, once from a task that failed to cl=
one
> > a new netns.  In the latter case, error unwinding calls the exit handle=
rs
> > in reverse order for the 'failed' netns.
> >
> > tcp_sk_exit_batch() calls tcp_twsk_purge().
> > Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"=
),
> > this function picks up twsk in any dying netns, not just the one passed
> > in via exit_batch list.
> >
> > This means that the error unwind of setup_net() can "steal" and destroy
> > timewait sockets belonging to the exiting netns.
> >
> > This allows the netns exit worker to proceed to call
> >
> > WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcoun=
t));
> >
> > without the expected 1 -> 0 transition, which then splats.
> >
> > At same time, error unwind path that is also running inet_twsk_purge()
> > will splat as well:
> >
> > WARNING: .. at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210
> > ...
> >   refcount_dec include/linux/refcount.h:351 [inline]
> >   inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
> >   inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221
> >   inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
> >   tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
> >   ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
> >   setup_net+0x714/0xb40 net/core/net_namespace.c:375
> >   copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
> >   create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> >
> > ... because refcount_dec() of tw_refcount unexpectedly dropped to 0.
> >
> > This doesn't seem like an actual bug (no tw sockets got lost and I don'=
t
> > see a use-after-free) but as erroneous trigger of debug check.
> >
> > Add a mutex to force strict ordering: the task that calls tcp_twsk_purg=
e()
> > blocks other task from doing final _dec_and_test before mutex-owner has
> > removed all tw sockets of dying netns.
> >
> > Fixes: e9bd0cca09d1 ("tcp: Don't allocate tcp_death_row outside of stru=
ct netns_ipv4.")
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Jason Xing <kerneljasonxing@gmail.com>
> > Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/0000000000003a5292061f5e4e19@goo=
gle.com/
> > Link: https://lore.kernel.org/netdev/20240812140104.GA21559@breakpoint.=
cc/
> > Signed-off-by: Florian Westphal <fw@strlen.de>
>
> The fixes LGTM, but I prefer to keep the patch in PW a little longer to
> allow Eric having a look here.

Excellent patch, thanks a lot Florian !

I had this syzbot report in my queue for a while, but I presumed this
was caused by RDS,
thus waiting for more signal.

Reviewed-by: Eric Dumazet <edumazet@google.com>

