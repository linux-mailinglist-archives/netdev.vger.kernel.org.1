Return-Path: <netdev+bounces-297879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L5ckL9UYKmrmigMAu9opvQ
	(envelope-from <netdev+bounces-297879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:09:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0166DBFE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b="j w48wsj";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=GjgacgPX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297879-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297879-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC6730C4D2F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D62923BD06;
	Thu, 11 Jun 2026 02:09:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37C1E7C2E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:09:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143761; cv=none; b=SqlGyrUw0Y5ILC9o1oSJ4x4yLo2sK9zlcW40q45S/gm5JFD3RMEfquKW0l81cqAQe7wuKUP+Bie5MfGn7TFWhoLg2ubQboR4MAbxeAvl3c29W2rMjzB2yw3pIHhJiXQaU3vGk0GxmqvDlYkuR3GgkLwJWAoXU3O0n/f6sNm8hVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143761; c=relaxed/simple;
	bh=HjwsaSVIgi1mxWa2eCGtBPtAXXsl5e8A4VECjR0Fxo0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tBtTyJPA+bpaQHBOP9iz2RXW1xPF3gibIPRwH4VLybqwmsDpE/91w6UYfXQFI85lP3ZU/AwnZjPQwdHLt7UdoXK1RkbvGfekuXsUXrh1L1MJe9E53TKqgk2YoRqy6qkaQZ5E1RQAYvNLVcc7Nt2AeV6pJhH8fjwC4PXIoeuUgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=jw48wsjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjgacgPX; arc=none smtp.client-ip=202.12.124.151
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 16F811D000D7;
	Wed, 10 Jun 2026 22:09:18 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 22:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1781143757; x=
	1781230157; bh=AkI9j62idwEywhhwA3KyRdIT/v5NJuu2Lwj1v459fFQ=; b=j
	w48wsjRHvAeCFEYRYyWRH43rUJhce0xcQkRBK7GIgMUd4Sn+3o/bizbyqbghPM5O
	cvsdjmRhykXj9/TpqRbOUMTnepncepJ0bvofi8ywNWqiarkgjj0fvLYXgjYlZcPp
	He8JcqN+IH/sFX9TC92iwRaUFXbmpewDKZsAOPK7D0AQirp0DdLTRJW53pP3zXz7
	4zj9cwnScHh3uRXZoxJ5BBgB4V4lwPDb6jovzR2GvHB6HJiqYeC2jKKVG2JP//29
	jo6RhS63RUDPfgndVFItD5EtiE2O3j8sVGY/UwNku9aiASifYxMPP7ZCKk9unB2t
	gu4kfA+ZnK5usLwG/I+fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781143757; x=1781230157; bh=AkI9j62idwEywhhwA3KyRdIT/v5NJuu2Lwj
	1v459fFQ=; b=GjgacgPXmfT/W8wNIZu7q0XosM+G5+9C4NXEozgNp50NUPZkV2G
	nAQz9SkGEM5ETAkbqXK6NQ3OqMRcVHAzxculSkd6SktIosgstcQrCOcpBSXktmq4
	X/IhAMUGOz7LM4NfMLQpu0GVvTLCw1rzCN3ey0VK4Da7KWeCxx0d1ExbAv9KUfx/
	n1MTwhuyHLvpn2D2Bvza0q6Kgg8ABZlUi0kuNjByWQEvJkk3O2zS+96hP+7O2ZEY
	EFia7oPF9OmshKi739Whk9N2oLWHxG+q9pfQr3NoFEf+xU+eaPfOOYtBRsYa817y
	t+m71M6v/2+kXL2padTY/cUBLIGhovk/YJg==
X-ME-Sender: <xms:zRgqaossfN9d62Ha60GJrQ5wZzmv4wgYojTyvgexvIvjPC_ZwA7sVg>
    <xme:zRgqagStli37fkB1St22Vb34MlrCiqk2h-UEMAaO_PoYASs_ITNLbfAnTuFNzdj5F
    Z4HlagFgkA08Ur5Gz6t_9NWlILNhuyw-cgrirWnUz5kfbQZuAv_oQ>
X-ME-Proxy-Cause: dmFkZTEAUu29c5jRAhzFjR5dwiB63DtXZmSHXiL33F8LSFZXE1FS7OHDf4LsOZX1EYonxC
    c/UyMHS0btg4eFQ26C8a5MHwYW6Pwljef4xTIeEp1g8y9JxvnOK7PuD6Mj5XzASclVo9WU
    QyXia5ngyixf+HDor4mT7nc2Cat/GJt0kt2tYmVW/Bul0i/FLm+HDHvxMbzRymB6zLFTC4
    WaKQudYE1OjISq5kl/VAKCUnuJEjouyZk+bqkaWc6byiYdQ7uMKxP/8A8PCUVjcbQQ9oAb
    qkvNqosbyhSnAm1qbWAkCz4Kh4tR8QcGCeJ57YrqUbGsdfL+shm3H6LyorSHQqB8uphfa6
    Czmavee8v+ZiFFQjlvX1/5Yz0E148jRVlMq5mRDGtluTgUe03I3Omf0ZAdRUCAQ4FIEi31
    lXH3oZQu1Es22d83B3Bhvrc8TW6RUuIr+oTYnSzdTtzC/srPLaKHU1kQiDHQ501Q9AQzaA
    lHbzMD1+/Cii0Pyred80BeBaDj+4xaWuhEDt4lemMUKvLD17RwqWmx4VjKKxSl34+aqt86
    7loIIN9JxiVpqQoHUvnqmPIJ17xC1cJ1JX7DptwkPMs8hMMz9mnEzRR9fFlg/fE76tnzYT
    ev+Cx8105sUSMTum/ZvvMR0dUhJXT4tsV8oNlUn1bC5qZJzFc8kHdsdYGSgQ
X-ME-Proxy: <xmx:zRgqakrgOYKHs_SPeZtVz8n3BggdzkGl6qqbkUCcAfFaQthJEhDADQ>
    <xmx:zRgqaiZ_KUvLAy-peEAIMgDnvEshwIqeoxKgU4w0OA-znIrLBT57GA>
    <xmx:zRgqasTCUN7mZAR_jmJF1u4teJfl1WqUzWX6qCzchsExW_K_Gj9yJw>
    <xmx:zRgqap6GoMYW37NIzwCes4LZNfZwbP1u5-bIhnbsUqp-j7SokmwZCQ>
    <xmx:zRgqalw4fe4_X87zKDR42KePURtbn5YPz3rYJq1MXzPi6YrHW_zwCgyY>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 591FA2CC0083; Wed, 10 Jun 2026 22:09:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Wed, 10 Jun 2026 22:08:57 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Cong Wang" <cwang@multikernel.io>
Cc: "network dev" <netdev@vger.kernel.org>, "Li Chen" <me@linux.beauty>
Message-Id: <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
In-Reply-To: <aicbyQIC2qEveNd-@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: multipart/mixed;
 boundary=1302d3b8db88dfc7815aa59ce795a5241ec23421
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.55 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[c:text/x-csrc];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-csrc];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297879-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cwang@multikernel.io,m:netdev@vger.kernel.org,m:me@linux.beauty,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4B0166DBFE

--1302d3b8db88dfc7815aa59ce795a5241ec23421
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Cong,

On Mon, Jun 8, 2026, at 3:45 PM, Cong Wang wrote:
> Hi John,
>
> [...]
>
> Thanks for bringing this up.

Sure, thanks for replying to me!

> I have no doubt connectat()/bindat() helps closing TOCTOU for Unix
> sockets. However, it would be nicer to describe your use case here,
> especially what the problems are without it. This would help more to
> jusify your proposal here than just getting aligned with openat() or
> BSD.
>
> Hope this helps.
>
> Regards,
> Cong

Yeah, happy to talk about that. Hope this is not too long a reply!

First, for some background context, I am a developer of the Nix package
manager. And this, plus my own personal taste, always has me thinking
about ways we can run processes with fewer privileges. The
no-ambient-authority capsicum/cloudabi/wasi/whatever dream has lived in
my head rent-free for many years :). Now these days, with LLMs, it feels
like these nice-to-have yak shaves of mine are finally worth dusting off
and striking off the bucket list.

Also in recent months, we Nix developers have been putting a bunch of
work into using more `openat2` and friends, and I have no doubt that we
will continue down this path (even on Windows!). We aim to be an
exemplar program for following the "always work relative to a file
descriptor" discipline. It's good for security, but also makes for code
that --- I believe --- is just more elegant and nicer to read.

----

Nearer term use case: slightly less ugly long path socket opening in
Nix:

If you look at [1] you can see a PR I've asked my coworker to draft to
improve binding and connecting code to cope with longer file paths,
something which does come up in practice when we are running multiple
tests with multiple daemons in parallel.

Now, I think it is safe to say that this code was already quite complex,
and in this patch only gets *more* complex. The current interfaces make
supporting longer paths quite annoying. (Though, once we remove the
`open` and switch to an `*at`-style interface in the wrapper (if macOS
lets us), it will get less bad.)

So the first use case would be getting something nicer than the
`/proc/self/fd/<N>` dance the linked code falls back to. It is good that
`/proc/self/fd/<N>` exists for legacy code, but it is an unergonomic way
to do file-descriptor-relative paths, and should be a fallback, never
the first choice. A real fd parameter along with a regular path pointer
would buy two concrete wins:

1. A clean, separate file descriptor parameter, the way `openat` has one
   --- rather than assembling a `/proc` path by hand.

2. Normal `PATH_MAX` room for the real pathname, rather than cramming
   `/proc/self/fd/<N>` (plus any residual path after it) into the small
   `sun_path` field of `struct sockaddr_un`.

----

Longer term use case: anonymous listening sockets, avoiding advertising
sockets to potential clients using ambient authority mechanisms
altogether:

Some more background: I think this whole business of listening
unix sockets necessarily living in the file system is a bit silly, since
there is nothing to put on disk --- it's just a mechanism to communicate
to clients where they should connect. Now ostensibly, Linux agrees ---
that is why Linux's *abstract* Unix domain sockets were created. But I
really don't like this because we have just replaced one ambient
authority contraption (the root filesystem) with another (the abstract
socket name space in the network namespace). The problems with ambient
authority remain all the same (and indeed, our experience with Nix has
been that network namespace unsharing when you do want to do some
outside world network access is much more work than filesystem namespace
unsharing).

What I would really like to do is go further than what I proposed, and
separate the binding of a unix socket from the placing in the file
system.

Today, with only existing UAPIs, the closest you can get is a scratch
path you pin with `O_PATH` and immediately unlink:

    /* server */
    int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    struct sockaddr_un a = { .sun_family = AF_UNIX };
    strcpy(a.sun_path, "/tmp/scratchXXXXXX");
    bind(lfd, (struct sockaddr *)&a, sizeof a);
    int addrfd = open(a.sun_path, O_PATH | O_CLOEXEC); /* pin the socket inode */
    unlink(a.sun_path);                                /* nameless now */
    listen(lfd, 64);

    /* client, handed `addrfd` -- but still has to *name* it, via /proc magic */
    struct sockaddr_un c = { .sun_family = AF_UNIX };
    sprintf(c.sun_path, "/proc/self/fd/%d", addrfd);
    connect(cfd, (struct sockaddr *)&c, sizeof c);

So even though I hold the socket by descriptor, I still route a pathname
(`/proc/self/fd/...`) to reach it, and I have to deal with the
`/tmp/scratchXXXXXX` proper temp file usage.

What I'd actually want is to sidestep all those nuisances entirely.

The important piece is a `bind` variation: like binding an abstract unix
socket, except that it publishes no abstract socket name, so the *only*
way to connect to the socket is to be given an fd referring to it.

A matching `connect` variation is more of a nice-to-have: it lets a
client connect straight through that fd, rather than having to name it
via `/proc/self/fd` as above.

Put together:

    /* server */
    int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    int addrfd = bind_anon(lfd, /*flags, for the future*/0);  /* proposed: no filesystem or abstract name */
    listen(lfd, 64);

    /* client, handed `addrfd` -- connect straight to the descriptor */
    connectat(addrfd, cfd, NULL, 0, AT_EMPTY_PATH);   /* proposed */

I would use this *a lot*! First of all, in our testing code, I would use
this, and not even bother (on Linux at least) putting the test daemon
socket on a (probably quite long) path; I would just rig up the test
harness to pass the fd to the client process with an environment
variable (local not global naming!) indicating to the process which file
descriptor it should connect to.

If that sounds vaguely like systemd socket activation, yes it should.
Socket activating *servers*, as we do today, is great, but I would also
modify my init system to pass these listening sockets to *client*
services. At that point, servers should ditch any sort of `getsockopt`
authentication (which they are likely to implement incorrectly or in an
ad-hoc manner), and instead rely on the init system to make sure only
services/users which are authorized to connect to a given server have
been given its listening socket file descriptor.

----

Misc notes:

[Note 1]: I didn't specify what `bind_anon` should do for `getpeername`
but frankly, I don't really care. `getpeername` already doesn't identify
unix sockets uniquely, since one can bind using relative paths.

[Note 2]: Insofar as we are designing new interfaces, we might ask
whether the division of labor across 3 system calls --- `socket`,
`bind`/`bind_anon`, and `listen` --- is really carrying its weight, but
this is orthogonal tech debt.

[Note 3]: As a bonus, `bind_anon` subsumes the traditional pathname
`bind`, with a nice separation of concerns: bind first, name later (if
ever).

    /* server, bonus before listening */
    linkat(addrfd, "", AT_FDCWD, "/run/myservice.sock", AT_EMPTY_PATH);

This needs `bind_anon` to create the socket `O_TMPFILE`-style --- `nlink
== 0` but materializable by `linkat`, reusing the existing
`may_linkat()` carve-out. (I checked: today you *can* `linkat` a bound
socket that still has a name, but not once it has been unlinked to
namelessness --- which is exactly the anonymous case --- so this really
does need the new bind.)

[Note 4]: If you look at [2] (another example of one of my old dreams
perhaps finally coming true, this time better process spawning), you
will see I mention that I would like null namespaces to ratchet down
process privileges even further than we can today, and also have a nicer
default state for a new process creation UAPI. In the case of a null
mount namespace / null root fs, `/proc/self/fd/<M>` would no longer
work, but explicit file-descriptor-relative APIs would.

Finally, I've attached a little test program I used to double-check some
of my points, in case that is useful to anyone.

[1]: https://github.com/NixOS/nix/pull/15867

[2]: https://lore.kernel.org/all/48594f3a-2ae9-4e1c-a575-ae54a6e1536d@app.fastmail.com/

--1302d3b8db88dfc7815aa59ce795a5241ec23421
Content-Disposition: attachment; filename="sockfdtest.c"
Content-Type: text/x-csrc; name="sockfdtest.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8
ZmNudGwuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy91bi5oPgoK
c3RhdGljIGludCBtYWtlX2xpc3RlbmVyKGNvbnN0IGNoYXIgKnBhdGgpCnsKCWludCBsZmQg
PSBzb2NrZXQoQUZfVU5JWCwgU09DS19TVFJFQU0gfCBTT0NLX0NMT0VYRUMsIDApOwoJaWYg
KGxmZCA8IDApIHsgcGVycm9yKCJzb2NrZXQgbGZkIik7IHJldHVybiAtMTsgfQoJc3RydWN0
IHNvY2thZGRyX3VuIGEgPSB7IC5zdW5fZmFtaWx5ID0gQUZfVU5JWCB9OwoJc25wcmludGYo
YS5zdW5fcGF0aCwgc2l6ZW9mIGEuc3VuX3BhdGgsICIlcyIsIHBhdGgpOwoJdW5saW5rKHBh
dGgpOwoJaWYgKGJpbmQobGZkLCAoc3RydWN0IHNvY2thZGRyICopJmEsIHNpemVvZiBhKSA8
IDApIHsgcGVycm9yKCJiaW5kIik7IHJldHVybiAtMTsgfQoJaWYgKGxpc3RlbihsZmQsIDY0
KSA8IDApIHsgcGVycm9yKCJsaXN0ZW4iKTsgcmV0dXJuIC0xOyB9CglyZXR1cm4gbGZkOwp9
CgovKiBjb25uZWN0IHRvIGEgdW5peCBzb2NrZXQgYnkgcGF0aG5hbWU7IHJldHVybnMgMCBv
biBzdWNjZXNzICovCnN0YXRpYyBpbnQgY29ubmVjdF9wYXRoKGNvbnN0IGNoYXIgKnBhdGgp
CnsKCWludCBjZmQgPSBzb2NrZXQoQUZfVU5JWCwgU09DS19TVFJFQU0gfCBTT0NLX0NMT0VY
RUMsIDApOwoJc3RydWN0IHNvY2thZGRyX3VuIGMgPSB7IC5zdW5fZmFtaWx5ID0gQUZfVU5J
WCB9OwoJc25wcmludGYoYy5zdW5fcGF0aCwgc2l6ZW9mIGMuc3VuX3BhdGgsICIlcyIsIHBh
dGgpOwoJaW50IHIgPSBjb25uZWN0KGNmZCwgKHN0cnVjdCBzb2NrYWRkciAqKSZjLCBzaXpl
b2YgYyk7CgljbG9zZShjZmQpOwoJcmV0dXJuIHI7Cn0KCnN0YXRpYyB2b2lkIHRyeV9jb25u
ZWN0KGNvbnN0IGNoYXIgKmxhYmVsLCBpbnQgdGFyZ2V0ZmQsIGludCBsZmQpCnsKCWNoYXIg
cFs2NF07CglzbnByaW50ZihwLCBzaXplb2YgcCwgIi9wcm9jL3NlbGYvZmQvJWQiLCB0YXJn
ZXRmZCk7CglpZiAoY29ubmVjdF9wYXRoKHApIDwgMCkgewoJCXByaW50ZigiJS0zMHMgdmlh
ICUtMThzIC0+IEZBSUxFRDogJXNcbiIsIGxhYmVsLCBwLCBzdHJlcnJvcihlcnJubykpOwoJ
fSBlbHNlIHsKCQlpbnQgcyA9IGFjY2VwdChsZmQsIE5VTEwsIE5VTEwpOwoJCXByaW50Zigi
JS0zMHMgdmlhICUtMThzIC0+IFNVQ0NFRURFRCAoYWNjZXB0ICVzKVxuIiwKCQkgICAgICAg
bGFiZWwsIHAsIHMgPj0gMCA/ICJvayIgOiAiRkFJTEVEIik7CgkJaWYgKHMgPj0gMCkgY2xv
c2Uocyk7Cgl9Cn0KCi8qIGxpbmthdCB0aGUgc29ja2V0IHJlZmVycmVkIHRvIGJ5IChvbGRk
aXJmZCwgb2xkcGF0aCwgZmxhZ3MpIHRvIG5ld3BhdGgsCiAqIHRoZW4gcHJvdmUgaXQgYnkg
Y29ubmVjdGluZyB0aHJvdWdoIG5ld3BhdGguICovCnN0YXRpYyB2b2lkIHRyeV9saW5rKGNv
bnN0IGNoYXIgKmxhYmVsLCBpbnQgb2xkZGlyZmQsIGNvbnN0IGNoYXIgKm9sZHBhdGgsCgkJ
ICAgICBpbnQgZmxhZ3MsIGNvbnN0IGNoYXIgKm5ld3BhdGgpCnsKCXVubGluayhuZXdwYXRo
KTsKCWlmIChsaW5rYXQob2xkZGlyZmQsIG9sZHBhdGgsIEFUX0ZEQ1dELCBuZXdwYXRoLCBm
bGFncykgPCAwKSB7CgkJcHJpbnRmKCIlLTMwcyAtPiBsaW5rYXQgRkFJTEVEOiAlc1xuIiwg
bGFiZWwsIHN0cmVycm9yKGVycm5vKSk7CgkJcmV0dXJuOwoJfQoJaWYgKGNvbm5lY3RfcGF0
aChuZXdwYXRoKSA8IDApCgkJcHJpbnRmKCIlLTMwcyAtPiBsaW5rZWQsIGJ1dCBjb25uZWN0
IEZBSUxFRDogJXNcbiIsIGxhYmVsLCBzdHJlcnJvcihlcnJubykpOwoJZWxzZQoJCXByaW50
ZigiJS0zMHMgLT4gbGlua2VkIEFORCBjb25uZWN0YWJsZVxuIiwgbGFiZWwpOwoJdW5saW5r
KG5ld3BhdGgpOwp9CgppbnQgbWFpbih2b2lkKQp7CgljaGFyIHBhWzY0XSwgcGJbNjRdLCBw
Y1s2NF0sIHBsWzgwXTsKCXNucHJpbnRmKHBhLCBzaXplb2YgcGEsICIvdG1wL3NvY2tmZHRl
c3QuYS4lZCIsIGdldHBpZCgpKTsKCXNucHJpbnRmKHBiLCBzaXplb2YgcGIsICIvdG1wL3Nv
Y2tmZHRlc3QuYi4lZCIsIGdldHBpZCgpKTsKCXNucHJpbnRmKHBjLCBzaXplb2YgcGMsICIv
dG1wL3NvY2tmZHRlc3QuYy4lZCIsIGdldHBpZCgpKTsKCXNucHJpbnRmKHBsLCBzaXplb2Yg
cGwsICIvdG1wL3NvY2tmZHRlc3QubGluay4lZCIsIGdldHBpZCgpKTsKCgkvKiBBOiBwaW4g
dGhlIGJpbmQgcGF0aCdzIGlub2RlIHdpdGggT19QQVRILCB1bmxpbmssIGNvbm5lY3Qgdmlh
IHRoZSBwaW4gZmQgKi8KCWludCBsZmRfYSA9IG1ha2VfbGlzdGVuZXIocGEpOwoJaW50IHBp
biA9IG9wZW4ocGEsIE9fUEFUSCB8IE9fQ0xPRVhFQyk7CglpZiAocGluIDwgMCkgcGVycm9y
KCJvcGVuIE9fUEFUSCIpOwoJdW5saW5rKHBhKTsKCXRyeV9jb25uZWN0KCJBOiBPX1BBVEgg
cGluIiwgcGluLCBsZmRfYSk7CgoJLyogQjogc2tpcCB0aGUgcGluIC0tIGNvbm5lY3Qgdmlh
IHRoZSBsaXN0ZW5pbmcgc29ja2V0IGZkIGl0c2VsZiAqLwoJaW50IGxmZF9iID0gbWFrZV9s
aXN0ZW5lcihwYik7CgkvKiBpbnQgcGluX2IgPSBvcGVuKHBiLCBPX1BBVEggfCBPX0NMT0VY
RUMpOyAqLyAgIC8qIDwtLSBza2lwcGVkIG9uIHB1cnBvc2UgKi8KCXRyeV9jb25uZWN0KCJC
OiBsaXN0ZW4gZmQgZGlyZWN0IiwgbGZkX2IsIGxmZF9iKTsKCXVubGluayhwYik7CgoJLyog
Qy4uRTogY2FuIHdlICptYXRlcmlhbGl6ZSogYSBib3VuZCBzb2NrZXQgaW50byB0aGUgZnMg
dmlhIGxpbmsvbGlua2F0PyAqLwoJaW50IGxmZF9jID0gbWFrZV9saXN0ZW5lcihwYyk7ICAg
ICAgICAgICAgLyogcGM6IGJvdW5kIHNvY2tldCBmaWxlLCBubGluaz0xICovCglpbnQgcGlu
X2MgPSBvcGVuKHBjLCBPX1BBVEggfCBPX0NMT0VYRUMpOyAvKiBmZCB0byB0aGF0IGlub2Rl
ICovCgkodm9pZClsZmRfYzsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBrZXB0
IG9wZW4gdG8ga2VlcCB0aGUgbGlzdGVuZXIgYWxpdmUgKi8KCgkvKiBDOiBwbGFpbiBoYXJk
bGluayBvZiB0aGUgc29ja2V0ICpwYXRobmFtZSogKG5saW5rIDEgLT4gMikgKi8KCXRyeV9s
aW5rKCJDOiBsaW5rKHBhdGgpIGhhcmRsaW5rIiwgQVRfRkRDV0QsIHBjLCAwLCBwbCk7CgoJ
LyogRDogbGlua2F0IHRoZSAqZmQqIHZpYSBBVF9FTVBUWV9QQVRILCBpbm9kZSBzdGlsbCBo
YXMgYSBuYW1lIChubGluaz0xKSAqLwoJdHJ5X2xpbmsoIkQ6IGxpbmthdCBmZCBBVF9FTVBU
WV9QQVRIIiwgcGluX2MsICIiLCBBVF9FTVBUWV9QQVRILCBwbCk7CgoJLyogRTogbm93IG1h
a2UgaXQgbmFtZWxlc3MgKG5saW5rPTAsIHNvY2sgc3RpbGwgYm91bmQpLCB0aGVuIGxpbmth
dCB0aGUgZmQKCSAqICAgIC0tIHRoaXMgaXMgdGhlIE9fVE1QRklMRS1zdHlsZSAibmFtZSBh
biBhbm9ueW1vdXMgaW5vZGUiIG1vdmUuICovCgl1bmxpbmsocGMpOwoJdHJ5X2xpbmsoIkU6
IGxpbmthdCBmZCwgbmxpbms9PTAiLCBwaW5fYywgIiIsIEFUX0VNUFRZX1BBVEgsIHBsKTsK
CglyZXR1cm4gMDsKfQo=

--1302d3b8db88dfc7815aa59ce795a5241ec23421--

