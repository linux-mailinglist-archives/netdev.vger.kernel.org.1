Return-Path: <netdev+bounces-34801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957567A54C0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AE1C212CB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0127ECF;
	Mon, 18 Sep 2023 20:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B91D69E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:49:07 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1989111
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:49:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf3f59905so659809166b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695070144; x=1695674944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGBQgeHrDxH9X1Tg1lbMFYg4GJ5kJmZT4UQiZI5LYbo=;
        b=fLEDW77IJgWcd+Z7uHJRbgFjSPIn0Z5a/gvpzUwqU0dYX613zel1y6kax7QrFc87GN
         EkhhVvwm+8BuzU9PEVR8eqSkaUvwSoFKRAlhbICiiO0KzsbY9QWNjDHBb6zoUr/tf5Q2
         a9g9tNA/Hq9JOEorOre8WNXCGoA+CGgmjZciV8Hvi572jdDpPxsVZ6o9hT09KyeMzDLc
         +dZone19P2Q21bA60E6qqor+fZaGMomwJnAlv0apfYJuvcx+JUdDc14xfSvJSV7e5mUJ
         2SHdoBqyHi8OGLRio182UySDpBo5jHz4q0Ea3OHCdWm27yGl7StEWG5+FtfVeIqfyb+3
         qiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070144; x=1695674944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGBQgeHrDxH9X1Tg1lbMFYg4GJ5kJmZT4UQiZI5LYbo=;
        b=KvoKOhP+QnQD/dqQWExLL5/jku+1ywIwyVY9r3IQP8oreEEvYGT7qw2VkrG6iyr/Nu
         2Pi7XWyit5yKVffnlFl1Y/8tQYXyGoY+poyCvq73TEsL3gEcwZWXD8jOXmktz/XKKaJm
         8cBouJ3y6cY9Uj4atarKnqqyP9oqAQzbi+bWjsM/VBZyN9FzTKPmxvAjBTp/Wa3sGCbJ
         S7L3IcZLFt5qJeEWj8gr2jJPjqWJBJGPIIHRY7Jy6vjAhLXGewl2NGf/x1qH5u0FX8Lu
         cMmzv0Rutg5qpQxPOiRsybZJ4W82nDCDj4QSuaX5uu1lJINxslJQ1ohX7IWOPJsUjOTt
         1sXg==
X-Gm-Message-State: AOJu0YxAaEJmh7tJd0Mh7/CyK+fjEGwNJ6Jojq/L+rdovWgMGmcrT4ag
	6t6wD0bfEKLSTmdQdJ2aWI3LR6Bb4AA/IqIMgFBbPg==
X-Google-Smtp-Source: AGHT+IHHDCQ7DLksnsJI/MzVZ95Jb9E3g0OC9YPirB61baunrwsXci1fuxFvrwvffGp5HKJId+y6S23I0y177D8vrzQ=
X-Received: by 2002:a17:907:2c54:b0:9ad:e955:414d with SMTP id
 hf20-20020a1709072c5400b009ade955414dmr6037187ejc.17.1695070144212; Mon, 18
 Sep 2023 13:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-2-jrife@google.com>
 <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com>
 <CADKFtnQnOnaq_3_o5OoWpuMvzTgzL2qKcY5oc=AbdZJvONSyKQ@mail.gmail.com>
 <CAF=yD-+DmargLvi=i-YJ6JCJov8xYEbyQf8+KhQ00UTYry_9UQ@mail.gmail.com> <CADKFtnSoB+_RjEJZsvkM9TpEm6xmmATnBL0jj7n-JbFAxbBc-A@mail.gmail.com>
In-Reply-To: <CADKFtnSoB+_RjEJZsvkM9TpEm6xmmATnBL0jj7n-JbFAxbBc-A@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 18 Sep 2023 13:48:52 -0700
Message-ID: <CADKFtnR5WANzLqA=WE_2Stii8aDPGy7Hi2tUReF1BtWe5FqOMw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Just a heads up, there are also kernel_recvmsg/sock_recvmsg functions
that mirror the kernel_sendmsg/sock_sendmsg. If we are are doing this

> 1) Rename the current kernel_sendmsg() function to
> kernel_sendmsg_kvec() and name  our new function kernel_sendmsg(). To
> me this makes some sense, considering the new function is the more
> generic of the two, and the existing kernel_sendmsg() specifically
> accepts "struct kvec".

it creates an asymmetry between *sendmsg and *recvmsg function names.
If we wanted these to be similar then it means a rename to these
functions (e.g. kern_recvmsg becomes kern_recvmsg_kvec, rename
sock_recvmsg to kern_recvmsg).

-Jordan

On Mon, Sep 18, 2023 at 11:02=E2=80=AFAM Jordan Rife <jrife@google.com> wro=
te:
>
> Sounds like a plan.
>
> On Mon, Sep 18, 2023 at 10:55=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 1:52=E2=80=AFPM Jordan Rife <jrife@google.com> =
wrote:
> > >
> > > > You used this short-hand to avoid having to update all callers to s=
ock_sendmsg to __kernel_sendmsg?
> > >
> > > Sorry about that, I misunderstood the intent. I'm fine with
> > > introducing a new function, doing the address copy there, and
> > > replacing all calls to sock_sendmsg with this wrapper. One thought on
> > > the naming though,
> > >
> > > To me the "__" prefix seems out of place for a function meant as a
> > > public interface. Some possible alternatives:
> > >
> > > 1) Rename the current kernel_sendmsg() function to
> > > kernel_sendmsg_kvec() and name  our new function kernel_sendmsg(). To
> > > me this makes some sense, considering the new function is the more
> > > generic of the two, and the existing kernel_sendmsg() specifically
> > > accepts "struct kvec".
> > > 2) Same as #1, but drop the old kernel_sendmsg() function instead of
> > > renaming it. Adapt all calls to the old kernel_sendmsg() to fit the
> > > new kernel_sendmsg() (this amounts to adding a
> > > iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size); call in
> > > each spot before kernel_sendmsg() is called.
> >
> > Thanks. Fair points.
> >
> > Of the two proposals, I think the first is preferable, as it avoids
> > some non-trivial open coding in multiple callers.

