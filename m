Return-Path: <netdev+bounces-104999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492B90F6AA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CE5B24C0B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681115886B;
	Wed, 19 Jun 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJR23Yxz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58569157E82
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823909; cv=none; b=PdlZ8ByudjQS7HonLAi7iyiIkAyDNfGW3l63O4I1SR1nfqnYyUvB8vUKD5dAW7XGh1tQBUrnAglxiQ84Z+M4cV9DMk1ti7a4kghNd3hcuQFx2EqL1TosBqMMvFtFH83Hd8y/x0zZfDqw7sdzt75jhp2mFjbqxhyP9eYc/uJjGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823909; c=relaxed/simple;
	bh=HsYG3u4BQt6CoTRVpqG4TEiDfmw8LWNDnatTsKEzkb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BCHvUCzkXMv4lPRgMM2mOLDZXmisuGbN0rGBHIPvB4sTrBT1d6WBf3fT4P+0bX2aUAeFdUXdEOgdsuraSmzG1ypGU4ueayjn14ctINYFlEs4A46/p7DqP1CVTxHsL5gdPdfBw94OP14pPhuW4p3nVDMRuSLaO2cOttUCsA7KD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJR23Yxz; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-57c82112f15so9614a12.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718823907; x=1719428707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cBZWGbah1lE3Ejb3luq7CWnw8Aj0HxoLRS/D6N+3r0=;
        b=SJR23YxzaYyvW889BAghG+CvSfV2szgHsex7117rRvLYhbedINvbUeXSLHENS/+L2K
         CXz3iARAOH90Rx6N4c+C6p+Rs1V6CuAdqcs4/BnJaYUMpgolamWwtBN48ETE4nUCjadF
         6Jo8a60Q1ICIIYpoVrB+93zCyFjXMrq41JIaKGos3QGBJ5bMDUUAnGIVh+qaUcsIfMOF
         h5x10boO4sdlWbfy89DrYsUcu9obMjPESsnxwhDJMk5i89pjG4JzyT0adn0iRlnXxtmW
         E1DcFui3UJTpuJBFLArrkwSGRA82rTxO0aOq9EJI/FkewsqCud2C+RjPHog2jFm6fwNl
         kZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823907; x=1719428707;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5cBZWGbah1lE3Ejb3luq7CWnw8Aj0HxoLRS/D6N+3r0=;
        b=gr8H8+7Z51pcyxUqhuZgiMCYbh+VFqMwXsrXMr6yN/d9/uMirFR0RpDuB9orMWbwjU
         EZSesy8s0tonAFNmzk0I0JYDqLXX0+BMlw29fpQQfY4iczE8ON62y12hIsilPbstK2H7
         5SlXRrojGy+K4+tmy0nN8XjE5TLZA2gsYyVHBm0RDQmb+s5BemC+u0AwYrwd2vPR1yRa
         nuWzCPOsEmEzDfvQN3LkrhUrvS4/Nku/W+5xyUBJYJOuOMBwbV8oHs6NjYVVz1wyq1NN
         4Eed+x0/orA3fx2gBYSBU0+I+t1s+JsK+xVAwhcxUR/aSoth/Vav4TernpUFtAxhYx4s
         xiXg==
X-Forwarded-Encrypted: i=1; AJvYcCU/M4oLDkc/45UOGq4unN/ZAi6oj/1I4ZmX4ovF7xM+rH5+7PO2aqPoH9ke/j5o+YYDG5nnZN8Gdib+S+t7PKf4TMj/jjnI
X-Gm-Message-State: AOJu0Yzohb7ahvn9LekDHOZjAND/7FW16xIgOqS+ZLUzq+4UYPqJmkem
	KZauPjp1Ov7EAcgZr0KBAICUY9KAAY/aL3zkgXqIuhlf9xX+iEsHq763VKrvd98hZaImwd7ksDd
	acA==
X-Google-Smtp-Source: AGHT+IH6ezgKV5I5dqSOcFIAzwyP5l78NkMHv7BZHgz0EUfSDl2F76DIwt6VZIICzod9Kw3Y9KPHF1bf3Jc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:1608:b0:57c:7cda:6757 with SMTP id
 4fb4d7f45d1cf-57d07edca18mr2461a12.6.1718823906227; Wed, 19 Jun 2024 12:05:06
 -0700 (PDT)
Date: Wed, 19 Jun 2024 21:05:03 +0200
In-Reply-To: <a18333c0-4efc-dcf4-a219-ec46480352b1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408094747.1761850-1-ivanov.mikhail1@huawei-partners.com>
 <20240408094747.1761850-2-ivanov.mikhail1@huawei-partners.com>
 <20240425.Soot5eNeexol@digikod.net> <a18333c0-4efc-dcf4-a219-ec46480352b1@huawei-partners.com>
Message-ID: <ZnMr30kSCGME16rO@google.com>
Subject: Re: [PATCH 1/2] landlock: Add hook on socket_listen()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I agree with Micka=C3=ABl's comment: this seems like an important fix.

Mostly for completeness: I played with the "socket type" patch set in a "TC=
P
server" example, where *all* possible operations are restricted with Landlo=
ck,
including the ones from the "socket type" patch set V2 with the little fix =
we
discussed.

 - socket()
 - bind()
 - enforce a landlock ruleset restricting:
   - file system access
   - all TCP bind and connect
   - socket creation
 - listen()
 - accept()

From the connection handler (which would be the place where an attacker can
usually provide input), it is now still possible to bind a socket due to th=
is
problem.  The steps are:

  1) connect() on client_fd with AF_UNSPEC to disassociate the client FD
  2) listen() on the client_fd

This succeeds and it listens on an ephemeral port.

The code is at [1], if you are interested.

[1] https://github.com/gnoack/landlock-examples/blob/main/tcpserver.c


On Mon, May 13, 2024 at 03:15:50PM +0300, Ivanov Mikhail wrote:
> 4/30/2024 4:36 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Mon, Apr 08, 2024 at 05:47:46PM +0800, Ivanov Mikhail wrote:
> > > Make hook for socket_listen(). It will check that the socket protocol=
 is
> > > TCP, and if the socket's local port number is 0 (which means,
> > > that listen(2) was called without any previous bind(2) call),
> > > then listen(2) call will be legitimate only if there is a rule for bi=
nd(2)
> > > allowing binding to port 0 (or if LANDLOCK_ACCESS_NET_BIND_TCP is not
> > > supported by the sandbox).
> >=20
> > Thanks for this patch and sorry for the late full review.  The code is
> > good overall.
> >=20
> > We should either consider this patch as a fix or add a new flag/access
> > right to Landlock syscalls for compatibility reason.  I think this
> > should be a fix.  Calling listen(2) without a previous call to bind(2)
> > is a corner case that we should properly handle.  The commit message
> > should make that explicit and highlight the goal of the patch: first
> > explain why, and then how.
>=20
> Yeap, this is fix-patch. I have covered motivation and proposed solution
> in cover letter. Do you have any suggestions on how i can improve this?

Without wanting to turn around the direction of this code review now, I am =
still
slightly concerned about the assymetry of this special case being implement=
ed
for listen() but not for connect().

The reason is this: My colleague Mr. B. recently pointed out to me that you=
 can
also do a bind() on a socket before a connect(!). The steps are:

* create socket with socket()
* bind() to a local port 9090
* connect() to a remote port 8080

This gives you a connection between ports 9090 and 8080.

A regular connect() without an explicit bind() is of course the more usual
scenario.  In that case, we are also using up ("implicitly binding") one of=
 the
ephemeral ports.

It seems that, with respect to the port binding, listen() and connect() wor=
k
quite similarly then?  This being considered, maybe it *is* the listen()
operation on a port which we should be restricting, and not bind()?

With some luck, that would then also free us from having to implement the
check_tcp_socket_can_listen() logic, which is seemingly emulating logic fro=
m
elsewhere in the kernel?

(I am by far not an expert in Linux networking, so I'll put this out for
consideration and will happily stand corrected if I am misunderstanding
something.  Maybe someone with more networking background can chime in?)


> > > +		/* Socket is alredy binded to some port. */
> >=20
> > This kind of spelling issue can be found by scripts/checkpatch.pl
>=20
> will be fixed

P.S. there are two typos here, the obvious one in "alredy",
but also the passive of "to bind" is "bound", not "binded".
(That is also mis-spelled in a few more places I think.)

=E2=80=94G=C3=BCnther

