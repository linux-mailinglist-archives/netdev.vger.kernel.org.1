Return-Path: <netdev+bounces-128122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B3978183
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10C3B20A20
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212041DB52A;
	Fri, 13 Sep 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KF1nvcdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767E1D9326
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235474; cv=none; b=UDEO2GAodkERf6IFTMcclE32JDLib+74LhD99uv58NsUx5G6S/x/AOl1UOJ8RsW1nw76z7j+ejFO5CjISkbiPZcY4PtbpKWOR8d09yAQPvHGHl8HSJGQHlzcXT3rxzXKINm6bOANhNLePe+vNIZlsSmolB8q8jMtxEqV4SS00MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235474; c=relaxed/simple;
	bh=waOnIjeTmScoMEheJRY5cbM5B5rvXKyGUG8sIRJTLyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sto3ddb0eh0R/uM6Op17iLGv+y22d2zVEW48i0JQ0LNwRaVwGU0MDIRtpCpz9kNouhD7TslGgGdK09Uw1tNXP7dUBjqySi2kerdY1zF9LzSXTDn+rrNlSP3bHJzQd2aoeyDH89UGifh+g1MWGGH9p38UnFConVdTedbLD+OAu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KF1nvcdz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so277401066b.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726235471; x=1726840271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waOnIjeTmScoMEheJRY5cbM5B5rvXKyGUG8sIRJTLyI=;
        b=KF1nvcdz1z/SZbDIubjytMDtCZQ1Ig8EOB3vghRwLqJYSl5Hi6q6a0PZN9fIK0iysf
         0LdEb0UW0LW93KIa6loaJwFzvce3+buvgmdMf0vv1hWOwmybfAS2VEmoW+8ssmeA/stD
         tsbaA+XaQFlZ4W097di+WtmE7CoG8b3wQ5ScRa3TCACIL62PZHsidwQRW0IQVhPuiNC/
         8RrrQJo18wP6Riow5prXq6hSvNcyyUfJbB/DQgQT4LbbjBXry0G6RXegtCjXhnPXqROv
         +smMzzH9mO6yyAXCkQpeKoJIeRFrbAdB7/vXnIbz+V+p932jb0A1RPay+PkjgvQw21Bm
         64RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235471; x=1726840271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waOnIjeTmScoMEheJRY5cbM5B5rvXKyGUG8sIRJTLyI=;
        b=oV5lyARlilmTDIX/pepCpSfojBWfB1vMvblLtLlODgyglxChe1f1xhWwOzYpte9kPP
         yTkJ69YG5W1+rpynyjWCJqjcZi4FSMk51tLB4k+qdBx1Wi3RWGLx2YXqgHhi/eCXKdta
         HMpq3Ckxyto96r9fL9fmb+HNUv2EiVdJ1e3DUC8g/wH27zHhxDBLOLnCIP0Svjop+ieo
         MHOHNcQRc05oCKKjIa3T74n8BKALSF0D3VEs5n1MCxsYHmBBQa3QJ++GEx+s5Kb0TQpg
         itOziTecEG7RC3opcMCXNw3ZgKlRkn5dOp5NL77EF5hlRGGuplFg46agZFrGomxwCooe
         +q5A==
X-Forwarded-Encrypted: i=1; AJvYcCVQQIUIfB0/Z4VABK0pOS9l5ZLZC/9EDELQLGKUOtSLIF9fxFP2y8MWYuFKadCbjXdoePjdPOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo35n6Bu8vmtxoadYwu6Rf+iBgPQqp4VgklpUiy83oNxiC9KQG
	4FXl1WOtQTsljPIJCb5ZTS5F9TO3jUzS7fBX3KWbRkmVM/ys0lEIaq80t4C1mzx7eQES8Zt1SVs
	JrV06tEDPUEIScqc3ivQqBx+OGBUQKQC50PhU
X-Google-Smtp-Source: AGHT+IFsvw1OZoYw8aYPkzNLtQGVBrl2QmmW1oz1u96SRZI1zK8l6qsV9EUfaHcN4+qhaNfgAMvf7AUI6mtJT83pjGw=
X-Received: by 2002:a17:907:e2cf:b0:a8c:d6a3:d03a with SMTP id
 a640c23a62f3a-a902947d3f4mr610279366b.21.1726235469432; Fri, 13 Sep 2024
 06:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
In-Reply-To: <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 15:50:56 +0200
Message-ID: <CANn89iJ==5rnYa1CrtP113C_4JYQeuT6wdcJ58aa6jm-V1uqLw@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 3:45=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> Hi Jakub,
> Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> trigger the pmtu_ipv6_ipv6_exception sub-case, which only takes a
> second to run on my machines, so you shouldn't need to run the
> entirety of pmtu.sh to trigger the bug. It won't trigger on attempt
> #1, but in my experience, when I do it in that while loop, it will
> trigger in under a minute reliably.
>
> > Somewhat tangentially but if you'd be willing I wouldn't mind if you
> > were to send patches to break this test up upstream, too. It takes
> > 1h23m to run with various debug kernel options enabled. If we split
> > it into multiple smaller tests each running 10min or 20min we can
> > then spawn multiple VMs and get the results faster.
>
> This logical division of tests already exists in pmtu.sh if you pass a
> sub-test name in as the first parameter like above, but if you think
> there would be value in separating them out further or into different
> files not all in pmtu.sh, I would be happy to help with that. Just let
> me know.
>
> Regardless, I will go ahead and work on a new regression test that
> executes just our quick reproducer for this specific bug and will send
> it to this list.
>
> Thanks,
> Mitchell Augustin
>
> On Thu, Sep 12, 2024 at 9:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 11 Sep 2024 17:20:29 -0500 Mitchell Augustin wrote:
> > > We recently identified a bug still impacting upstream, triggered
> > > occasionally by one of the kernel selftests (net/pmtu.sh) that
> > > sometimes causes the following behavior:
> > > * One of this tests's namespaced network devices does not get properl=
y
> > > cleaned up when the namespace is destroyed, evidenced by
> > > `unregister_netdevice: waiting for veth_A-R1 to become free. Usage
> > > count =3D 5` appearing in the dmesg output repeatedly
> > > * Once we start to see the above `unregister_netdevice` message, an
> > > un-cancelable hang will occur on subsequent attempts to run `modprobe
> > > ip6_vti` or `rmmod ip6_vti`
> >
> > Thanks for the report! We have seen it in our CI as well, it happens
> > maybe once a day. But as you say on x86 is quite hard to reproduce,
> > and nothing obvious stood out as a culprit.
> >
> > > However, I can easily reproduce the issue on an Nvidia Grace/Hopper
> > > machine (and other platforms with modern CPUs) with the performance
> > > governor set by doing the following:
> > > * Install/boot any affected kernel
> > > * Clone the kernel tree just to get an older version of the test case=
s
> > > without subtle timing changes that mask the issue (such as
> > > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/no=
ble/tree/?h=3DUbuntu-6.8.0-39.39)
> > > * cd tools/testing/selftests/net
> > > * while true; do sudo ./pmtu.sh pmtu_ipv6_ipv6_exception; done
> >
> > That's exciting! Would you be able to try to cut down the test itself
> > (is quite long and has a ton of sub-cases). Figure out which sub-cases
> > trigger this? And maybe with an even quicker repro we'll bisect or
> > someone will correctly guess the fix?
> >
> > Somewhat tangentially but if you'd be willing I wouldn't mind if you
> > were to send patches to break this test up upstream, too. It takes
> > 1h23m to run with various debug kernel options enabled. If we split
> > it into multiple smaller tests each running 10min or 20min we can
> > then spawn multiple VMs and get the results faster.
>

Note that this issue has been discussed already with Paolo Abeni.

The problem lies in dst_cache infrastructure.

