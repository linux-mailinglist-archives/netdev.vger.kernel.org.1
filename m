Return-Path: <netdev+bounces-191051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9060AB9E92
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B85B4E61FD
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7D18D649;
	Fri, 16 May 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hhc/9xcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DB16F8E9
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405615; cv=none; b=ULeQT5lk39J3MmdsNwYUZP4fjkDpOtzt2MK7pRknXPK9CeHH6J08nTm3xf1NLEmcFha9LIiGsuARPcsLSH7pEljHGSnVXKJdaI6McoHdu1Unw/kHjapSrS1JnP5EpHMR4i3gOV/OfU10QS/yNUXRxTwY6ZmeQBUavCM1VrW9V/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405615; c=relaxed/simple;
	bh=Eh5c2xr0pu/hCxt33C2EDeEgENtBc+GEy++6jWlMI28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhuLhBjgtJk8boJ24BdXNfl4R+KJ4NlxWkYHl4tDNVP4Pb9x18xVPzK5e7J/x4PNI0ToNkUeWrVCQ6EMnXMuErSg6IvL8Ab0OOkglWQfIqTml9o4vcCioErY1dAEHEatgJY0gvSs4fPuvISot0Gwhs3InfPaK7t0U4p0BgXODyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hhc/9xcx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso11634a12.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747405612; x=1748010412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TW2usedpCNxwKQj9PAnce7ll5JLOZm+QyDbRJAliss=;
        b=Hhc/9xcxSSbx3GDgNc9dneOmlYSkIg8xeF6VxNQYbe/3Dseg1+DICB+/K+6LbroeYN
         Jwlxe2TiiAjauMAotU4ATWTbeRB27dPzYRU7hrgrwcNGKfYLSk2v/2AqiOP0wlgQLH1l
         isblp4E8GcaIKn6v3EphrefmrrAfzSvNE9H42rS9M+MhBINpP6oqlQ5V0AUsLi6oeg+5
         ia9HuO4luTBX6ePpDywjK/rlW34g5+c6lPLS2BoDtrUqqfDjmrBFfFC77g1sV5K6M7qK
         YRmuCqOkpjxGDvLFe+YKDDK2ZBslRhhOi2QhIGt0xNWAcBrkbDpSjjIvRv9LjmNThhtE
         QIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747405612; x=1748010412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TW2usedpCNxwKQj9PAnce7ll5JLOZm+QyDbRJAliss=;
        b=d5Vjj8kIyHLAr11SExv/mqwkncivJxdP1XfKUbOuvuHJJDtvBVAxcJyqMNC1mlin0L
         /1z1Yksg9Ftm3knNjzsdxjPoGuKcfdMriF7LUeI0H6AK8bvMEc7UoJVx8Vy/egn1WH5O
         gpHWwPAJgv9vMG4m/qIJ5UchwEVtkSHVX1IXZ8Do3TpFMmTbmM2aTgpk7UTTOI9oYhRO
         ExLQGCujXDKo/RudGko5GWyB7tsObaHozMm63kyGR7aRDzr9bol2rdQTf4SQClCUHyoC
         10bzRgGhymnbHJX/9koKI7LcV+hu0GQWi24biMb+/cCbop2DnRaT8ryQmc3ZhhGZ8Trg
         MfVw==
X-Forwarded-Encrypted: i=1; AJvYcCU/gAvY5syuou+qmBP7/GlX5qqNl+RcsEPl3f8RMbGlqG/UR9BC+LV1FVXjqY6chiOHgnx5xjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGyAEJkl9nHPhB07iscRuWZaG+7VDOL2KSOVr9nDUx7PoPJ7Z
	3hRy2XhFItRKQpi+1wWT7R7LjKgFHdX/fTlJ8wpT+v4P4wFLVkYZqnAaRO23K8aWoh/+56MckgS
	P9fd4Q/Qzucjb0qfgd2QApMz9pTS1XzD0SA4K4EE6
X-Gm-Gg: ASbGnctgLI1BNhAfbG3DbT1/txL5OguK3KS+aWuc2JMjff88NEMR3b8hlwIZQqSgjSy
	s/3GucmXjJZ2sPBVCpRYQ7GUdEuaF1gOmw/n3pEEQME/hRc7ep62wm+wTLicuyMsBXNMc8tLYtk
	Z4lFFXGA9vJ8nwBaOn3Vo6h2WevKHgaYqLExXTRE193RrZW9D1c+OOp5VDYyVBPeNP4cMDRkc=
X-Google-Smtp-Source: AGHT+IEoixv1nvj/joKDjJhlioT6X26vzlEa04kXEcwn2gFbmDxDKWuYmqehfw7+lEN8BOykH+BXZgwX0xoGd6DK8jM=
X-Received: by 2002:a50:fa8e:0:b0:600:77b:5a5a with SMTP id
 4fb4d7f45d1cf-600077b6b0dmr174931a12.1.1747405611676; Fri, 16 May 2025
 07:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
 <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com> <20250516-anfliegen-mausklick-adf097dad304@brauner>
In-Reply-To: <20250516-anfliegen-mausklick-adf097dad304@brauner>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:26:15 +0200
X-Gm-Features: AX0GCFuYL6R9fj9izViFlrORHz9TS4NOydZZFRJC1vcmieDqi7P8IRY8nJotD-E
Message-ID: <CAG48ez3i-QGb_b_Mo50rN-kROPh1vrZhr06sGkb1BYzmRDvffw@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:34=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, May 15, 2025 at 10:56:26PM +0200, Jann Horn wrote:
> > Why can we safely put the pidfs reference now but couldn't do it
> > before the kernel_connect()? Does the kernel_connect() look up this
> > pidfs entry by calling something like pidfs_alloc_file()? Or does that
> > only happen later on, when the peer does getsockopt(SO_PEERPIDFD)?
>
> AF_UNIX sockets support SO_PEERPIDFD as you know. Users such as dbus or
> systemd want to be able to retrieve a pidfd for the peer even if the
> peer has already been reaped. To support this AF_UNIX ensures that when
> the peer credentials are set up (connect(), listen()) the corresponding
> @pid will also be registered in pidfs. This ensures that exit
> information is stored in the inode if we hand out a pidfd for a reaped
> task. IOW, we only hand out pidfds for reaped task if at the time of
> reaping a pidfs entry existed for it.
>
> Since we're setting coredump information on the pidfd here we're calling
> pidfs_register_pid() even before connect() sets up the peer credentials
> so we're sure that the coredump information is stored in the inode.
>
> Then we delay our pidfs_put_pid() call until the connect() took it's own
> reference and thus continues pinning the inode. IOW, connect() will also
> call pidfs_register_pid() but it will ofc just increment the reference
> count ensuring that our pidfs_put_pid() doesn't drop the inode.

Aah, so the call graph looks like this:

unix_stream_connect
  prepare_peercred
    pidfs_register_pid
      [pidfs reference taken]
  [point of no return]
  init_peercred
    [copies creds to socket, moving ref ownership]
  copy_peercred
    [copies creds from socket to peer socket, taking refs]

Thanks for explaining!

