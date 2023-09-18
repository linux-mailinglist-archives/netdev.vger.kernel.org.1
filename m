Return-Path: <netdev+bounces-34650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9807A514A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375691C20B99
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5C266AA;
	Mon, 18 Sep 2023 17:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DF1D6B0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:53:00 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB6DDB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:52:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so78314151fa.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695059577; x=1695664377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC1uNk9w3zepefqVOK6WCh4sp6B/DPjRLT5PNZbqd5M=;
        b=Q2uVVfycekupF4HO+4MG3D/KnY+uRLQD9JbtjxluSQV9VllEZPhmCwgdZQ/YVq4gUP
         LV1OTvl01cEirVy7NXDrwZGO69CapKTW3q666gQyGibWDNrGYDfHS2bT10+N6tRTmWpD
         hnL7dKO2z4UO4vSiZKVhQo5XiG6SrdJITF4IKuYJJPvJuaFtl9HRfmgfXjgm6oJ0m+Nw
         cR4GLN1x3vIz1ZROoiBQ0xg5NP7BceCh8zJjP9H86vfC3NqieXDL66kgoc406q/iJx0p
         t9SnTt82hAA3G1rsu+RcNxKwhqhYBjHo6UL+TE0e2wTK3mS+UhPBv2ErL/xPyD8SECye
         r3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059577; x=1695664377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC1uNk9w3zepefqVOK6WCh4sp6B/DPjRLT5PNZbqd5M=;
        b=u+hkzKT26HcNg6TLjfFQ2hyARBB15868iBT7KJoGFCS8B5tgxpVPxbDdjCw6jz3k+G
         qqg35WRIJA94q6xGdQ1z6sQLoWiqMSPpREPoNDLFntaC39m8FnbF4D7vTqu9QGQQ9CKb
         SOCAtHxiZ7hZTxTmcmaBhcRollu6s24u0Z1T9ZmZsJZhH64PdgRLEljB65nM7OmhfYjW
         /8+cYCob7J6clC1UErvhp/RDQWA9N3JJt6btiV68t3VWnlaR2QBcVse/owFYu71YEXWE
         6WdZOrbJtKEF1rdvZnJlOQzWUsbWGia5bITRpFC5LjJY06fOSDdUM/QWeIg0vtrMWNdZ
         nQrQ==
X-Gm-Message-State: AOJu0YxVj+f5+VX7PaeEhVheh7SnDvBKpvfT6AxFurhU2zXDaAQvx7HF
	qJnGRutpJYmPgEKQuS65FvQXKYl9EfQBaHGTiw7Z0g==
X-Google-Smtp-Source: AGHT+IFB+psUI4R25Ne9LsZXUa3z8Hv2FPrQb/1imVSjso2NY5TDpM6tAwL5MEzsTugeaK3FQt1g2mAdkt/z+6vLQoo=
X-Received: by 2002:a2e:bc14:0:b0:2bf:ee57:f18 with SMTP id
 b20-20020a2ebc14000000b002bfee570f18mr7743802ljf.16.1695059576946; Mon, 18
 Sep 2023 10:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-2-jrife@google.com>
 <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com>
In-Reply-To: <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 18 Sep 2023 10:52:44 -0700
Message-ID: <CADKFtnQnOnaq_3_o5OoWpuMvzTgzL2qKcY5oc=AbdZJvONSyKQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> You used this short-hand to avoid having to update all callers to sock_se=
ndmsg to __kernel_sendmsg?

Sorry about that, I misunderstood the intent. I'm fine with
introducing a new function, doing the address copy there, and
replacing all calls to sock_sendmsg with this wrapper. One thought on
the naming though,

To me the "__" prefix seems out of place for a function meant as a
public interface. Some possible alternatives:

1) Rename the current kernel_sendmsg() function to
kernel_sendmsg_kvec() and name  our new function kernel_sendmsg(). To
me this makes some sense, considering the new function is the more
generic of the two, and the existing kernel_sendmsg() specifically
accepts "struct kvec".
2) Same as #1, but drop the old kernel_sendmsg() function instead of
renaming it. Adapt all calls to the old kernel_sendmsg() to fit the
new kernel_sendmsg() (this amounts to adding a
iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size); call in
each spot before kernel_sendmsg() is called.

-Jordan


On Mon, Sep 18, 2023 at 6:09=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sun, Sep 17, 2023 at 10:50=E2=80=AFPM Jordan Rife <jrife@google.com> w=
rote:
> >
> > Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> > space may observe their value of msg_name change in cases where BPF
> > sendmsg hooks rewrite the send address. This has been confirmed to brea=
k
> > NFS mounts running in UDP mode and has the potential to break other
> > systems.
> >
> > This patch:
> >
> > 1) Creates a new function called __sock_sendmsg() with same logic as th=
e
> >    old sock_sendmsg() function.
> > 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
> >    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
> >    as these system calls are already protected.
> > 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
> >    present before passing it down the stack to insulate callers from
> >    changes to the send address.
>
> You used this short-hand to avoid having to update all callers to
> sock_sendmsg to __kernel_sendmsg?
>
> Unless the changes are massively worse than the other two patches, I
> do think using the kernel_.. prefix is preferable, as it documents
> that in-kernel users should use the kernel_.. sockets API rather than
> directly call the sock_.. ones.
>
> It's not clear that sock_sendmsg really is part of the kernel socket API.

