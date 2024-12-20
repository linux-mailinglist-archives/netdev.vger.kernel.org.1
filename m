Return-Path: <netdev+bounces-153843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C339F9D3B
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 00:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7016C07D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3572288E4;
	Fri, 20 Dec 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ivwfLFKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F332288D1
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738211; cv=none; b=JuXVB23HiD7Ufj/d4yPb/pg7qZ5kmZSfRr0edx6WB35wulScxxAxg5YLmoJAkfepIfTPTwYzC2MOBzyCH5IsYZHQgdeRr9QDKBy1wgUMNuycw7BoMS2n6XHA0OrstznKonHBNHFhPsMSy+j2v6QPpO6a+CqLAR+Qk+7bYXMLG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738211; c=relaxed/simple;
	bh=l80m2eaS25Kl+A/Ifh0gyEmSKCpOg6/LZJbZPjEPF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKFhwhock+MA7mQAJ0NxDP1Ay9IsuccZnlBfkjLgskd0lYvMLzVjsFz5ekrkSLrhc08TLvF5pOwdQiu9ZkEQFyNrMavK5BHQQhRTTaLO5u5DASKMlYE5tBoaoGVZkcdQjIJ/U5FCmH1QFEEofdeRDCm20d22twzLBAcew3FAF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ivwfLFKm; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l80m2eaS25Kl+A/Ifh0gyEmSKCpOg6/LZJbZPjEPF/E=; t=1734738209; x=1735602209; 
	b=ivwfLFKmKcZzb03sOMwiJhgkFUWBZq3fobSEkzOPXd/Nf0LtuTr43NgCriR7+o9naz6pT6dSZvQ
	uHWKJX1zVwAN8wQWhLUp2VUazk3UQOYFGZFf/Imn7Z7dwSuQ3nYYUbiEja+/D4ZgeNV3xAWmYg1lt
	lIWTzUSRtme3FOBCT83y8lrSluMHaQhHlEFvRR0YDe8MVDC2uBEK+p0hEFoNDVKY02xtj/rZoo4KC
	JC2XeraX5KHRLVzc+hNuv3xeKscIp1lE1PbYUUTVwE6MNYt14+Iv06iRk3XZOuQA9+acnciYERLJY
	ixfMVm1uhtWuOjX2IGzOegXAIHjP+QWKuWIA==;
Received: from mail-oi1-f169.google.com ([209.85.167.169]:50598)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tOmeW-0007f7-Cd
	for netdev@vger.kernel.org; Fri, 20 Dec 2024 15:43:29 -0800
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb98b3b63dso598805b6e.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 15:43:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFYMKwMo3f+qvz4de4IxbrsHDMdBlvhR9OLhSIGzMzXzbF2fgfxgqqXUE5Xp94bDDEsp5zGfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9yXLKKbvYgVANPAGljr4WBH2o7FzRTXBN+Vml7yMVOhiZwXw
	loi0Q8BNnlGdww4FMIjZZ6C4InMrcKssnhlV/8BalyNTF+WnP/VUF7hE70aHFiB6tNVJKHvyphd
	6uKajuoa9Eil8k1GZYxRU8PIiNKs=
X-Google-Smtp-Source: AGHT+IHH4I3+cEjLBWVwwdBauQ6AmxEtV1RdA1eUbiBn0Iqm7wAttmLlVdONCbBLMea29EPfwNJI/A55sJX/WUg7X/w=
X-Received: by 2002:a05:6870:468b:b0:29e:55ae:6170 with SMTP id
 586e51a60fabf-2a7fb312f29mr2859431fac.29.1734738207791; Fri, 20 Dec 2024
 15:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-1-ouster@cs.stanford.edu> <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org> <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org> <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
 <20241220113150.26fc7b8f@kernel.org> <f1a91e78-8187-458e-942c-880b8792aa6d@app.fastmail.com>
In-Reply-To: <f1a91e78-8187-458e-942c-880b8792aa6d@app.fastmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Dec 2024 15:42:53 -0800
X-Gmail-Original-Message-ID: <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com>
Message-ID: <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: b6c1f4b091abe5b5a29b37e1ccaa2d85

On Fri, Dec 20, 2024 at 1:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Dec 20, 2024, at 20:31, Jakub Kicinski wrote:
> > On Fri, 20 Dec 2024 09:59:53 -0800 John Ousterhout wrote:
> >> > > I see that "void *" is used in the declaration for struct msghdr
> >> > > (along with some other pointer types as well) and struct msghdr is
> >> > > part of several uAPI interfaces, no?
> >> >
> >> > Off the top off my head this use is a source of major pain, grep aro=
und
> >> > for compat_msghdr.
> >>
> >> How should I go about confirming that this __aligned_u64 is indeed the
> >> expected convention (sounds like you aren't certain)?
> >
> > Let me add Arnd Bergmann to the CC list, he will correct me if
> > I'm wrong. Otherwise you can trust my intuition :)
>
> You are right that for the purposes of the user API, structures
> should use __u64 or __aligned_u64 in place of pointers, there are
> some more details on this in Documentation/driver-api/ioctl.rst.

I have now changed the type from void * to __u64.

> What worries me more in this particular case is the way that
> this pointer is passed through setsockopt(), which really doesn't
> take any pointers in other protocols.
>
> I have not fully understood what is behind the pointer, but
> it looks like this gets stored in the kernel in a per-socket
> structure that is annotated as a kernel pointer, not a user
> pointer, which may cause additional problems.

It is actually a user pointer; I had forgotten the __user annotation.
I have fixed this now as well.

> I don't know if the same pointer ever points to a kernel
> structure, but if it does, that needs to be fixed first.

It doesn't.

> Assuming this is actually meant as a persistent __user
> pointer, I'm still unsure what this means if the socket is
> available to more than one process, e.g. through a fork()
> or explicit file descriptor passing, or if the original
> process dies while there is still a transfer in progress.
> I realize that there is a lot of information already out
> there that I haven't all read, so this is probably explained
> somewhere, but it would be nice to point to that documentation
> somewhere near the code to clarify the corner cases.

I hadn't considered this, but the buffering mechanism prevents the
same socket from being shared across processes. I'm okay with that:
I'm not sure that sharing between processes adds much value for Homa,
and the performance benefit from the buffer mechanism is quite large.
I will document this. Is there a way to prevent a socket from being
shared across processes (e.g. can I set close-on-exec from within the
kernel?) I don't think there is any risk to kernel integrity if the
socket does end up shared; the worst that will happen is that the
memory of one of the processes will get trashed because Homa will
write to memory that isn't actually buffer space in that process.

> That probably also explains what type of memory the
> __user buffer can point to, but I would like to make
> sure that this has well-defined behavior e.g. if that
> buffer is an mmap()ed file on NFS that was itself
> mounted over a homa socket. Is there any guarantee that
> this is either prohibited or is free of deadlocks and
> recursion?

Given the API incompatibilities between Homa and TCP, I don't think it
is possible to have NFS mounted over a Homa socket. But you raise the
issue of whether some kinds of addresses might not be suitable for
Homa's buffer use this way. I don't know enough about the various
possible kinds of memory to know what kinds of problems could occur.
My assumption is that the buffer area will be a simple mmap()ed
region. The only use Homa makes of the buffer address is to call
import_ubuf with addresses in the buffer region, followed by
skb_copy_datagram_iter with the resulting iov_iter.

Is there some way I can check the "kind" of memory behind the buffer
pointer, so Homa could reject anything other than the simple case?
However, even if Homa checks when it sets up the buffer region, the
application could always rearrange its memory later, so I'm not sure
this would be effective. Also, if there is some sort of weird memory
that would cause problems for Homa, couldn't an application pass this
same memory into a call to recvmsg on a normal socket? Given that
Homa's use of the address is similar to what already happens in other
sockets, I don't think that the fact that Homa keeps the address
around in the kernel for a long time should cause additional problems,
no?

-John-

