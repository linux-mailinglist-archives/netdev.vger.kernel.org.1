Return-Path: <netdev+bounces-188377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96BAAC8E9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A53B1276
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF41283C9C;
	Tue,  6 May 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b2bQIJ1i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF802836AF
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543440; cv=none; b=M0zuASH0Xv/yWyXUQstKwEqr3c/eK532YlH8g8nLzPv+qBF5QX43uZzO8ByEE5+5Sb99bL/TwfoGkNHnuXU1lhOpPwMSFQk5nxClNQC/po6o8h7IXWKu0UioeRIsO17/r0saleO7rxBwHUIRJ1cnoTuPMdnVwSNTw3wyf+XuTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543440; c=relaxed/simple;
	bh=YplBmVb1Delb5mL7pEaZiodrLvZ2IOKYjJp7SEdrmfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu9XYp9RKwcmZWcIY5WjYwYigVilr2J8TpxfMJA5K4ybsAAjoWBtDM7z8R2AAbapm9ojWtk8f17t4mDduzm1YdvNpDfMsozOlU8W1PEnRocc9aYgLFqk6Pp/xwDjahbFV0U1YrWkE00IA2BnFD5+lX4dH4yhVHGE7IV+gIbUnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b2bQIJ1i; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-707d3c12574so46589197b3.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746543437; x=1747148237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLs31GAnh8meNVNPFC4TC/kBV0263rRQzZRQGkUn8Pg=;
        b=b2bQIJ1i/6RT4w5NB75jWAYY0pv/gZyPMltOhgawg8yI43HVENnU48ZKzorNXENPAE
         qeo2wOneaOrHxn0e8AY+nzLSpA8T/jqEwAVMvIo86QHC2nhxkMd9SLI0hvtUTRC522U/
         p1dQMPhhMQUQz3KBt+u7Crzr2C1BQyb/O0nNR/BDA5DzEX2f2BK536n3cKKhT3bqiFwT
         j1IZ0avNvCqrNyByyk/j0EwbQJxi20j8PQgfdXetpSbbJX42xpb0J3azYgM1VqbLvg9N
         704wEZMKLaS2CGS8Hbk0rj1Lfmq8q2RgorzrEucdpzoMyE9K6Qhx/UNJofrqLlHpn14G
         0Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543437; x=1747148237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLs31GAnh8meNVNPFC4TC/kBV0263rRQzZRQGkUn8Pg=;
        b=ZwAWsRGNaoU8hQQDnZQaNUS9yJJmQUcD+EBJ0+7QFRPLwAa4+PGBfVpSdC/qJ1+b8j
         MyS8JeCz3q62zs0T+d2DAknw5XeQyYFwGi2CF/qKMUfISFRzg6dpY2UAjXp1sCvnlEQ4
         dQAqJVoaU0Aahs0lQmvaN6mhgvH3KaO/9lrs4oPmmv7pGqBT5BY6ACBbdGE/Tr2a54LG
         GWtou+wjUKewZR91UY3rURxVsSRzaYHxafRo6rvawEYlorsFpoK64GMhGTGncH0zubq/
         U+GHhCflxMH4wRYdlZs8FIiMYMlosP7tbQaWrZnPcxP4UxmPSsM27x5A/8GXaQZh0za/
         G5lA==
X-Forwarded-Encrypted: i=1; AJvYcCVrAd/4daMMTrF46fJerl1EtLjtbB8tixH+OaPrgwBvt0rJysz82JwE1kUmHwAfRkj2sLxZ8BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoU0IsxCn2wC9q6PfWq1OLYIGamGmpN3pxc+cJgxy0tiRhqfa
	5aOvjD6jbeyfIovWldmiLx8bqqQk2hZd/Jg5KsSw8bJYLPjWDM2u2z0ID6CxFr6wNPpVVig6caH
	4kFCy8Ox4PRegoeB9y8vMfHD9sItJsmLsS/v8
X-Gm-Gg: ASbGncvs2SRVaTQvYoesDYLzBGOkuuik5dyOdEQ1qIdchw7afKtBZsvs4oTPTEOFlKt
	GAwMDgrI6NnyY/W4oTADywQKgDdaNj5SQ3Ooz6TNsdQxKDyxsZ/JsBLbHnMrus2+EzebcAaCU6Z
	yAWM597uzfM1qQH8QH2gTZKw==
X-Google-Smtp-Source: AGHT+IG6xFvMic0ADEs29IQoHHk8yx7S2z5OPPSGG9x1jnr6FqkiMMaTePQc4L33m2RS4aoEj/y9I9lZh5J1KZwGRg8=
X-Received: by 2002:a05:690c:74c8:b0:6fb:9474:7b4f with SMTP id
 00721157ae682-70a1c9d951emr1476887b3.6.1746543437066; Tue, 06 May 2025
 07:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSWS2L3qwu_r_1Fr3eLp-9KRz3_20EPwy=FFu7_eSiN7g@mail.gmail.com>
 <20250506003514.66821-1-kuniyu@amazon.com>
In-Reply-To: <20250506003514.66821-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 May 2025 10:57:06 -0400
X-Gm-Features: ATxdqUE9hUHlsLlxH60gL-ZM58XVaHc4ms5YTdwWD4KTgo3dCqcbQ5j61SIFQWQ
Message-ID: <CAHC9VhRhW=QT9O6qLaVfJd9XMV1se6EooVmYKb76+iATyG2vAA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	casey@schaufler-ca.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	gnoack@google.com, haoluo@google.com, jmorris@namei.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuni1840@gmail.com, linux-security-module@vger.kernel.org, 
	martin.lau@linux.dev, mic@digikod.net, netdev@vger.kernel.org, 
	omosnace@redhat.com, sdf@fomichev.me, selinux@vger.kernel.org, 
	serge@hallyn.com, song@kernel.org, stephen.smalley.work@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Mon, 5 May 2025 19:21:25 -0400
> > On Mon, May 5, 2025 at 5:58=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> > > possible to avoid receiving file descriptors via SCM_RIGHTS.
> > >
> > > This behaviour has occasionally been flagged as problematic.
> > >
> > > For instance, as noted on the uAPI Group page [0], an untrusted peer
> > > could send a file descriptor pointing to a hung NFS mount and then
> > > close it.  Once the receiver calls recvmsg() with msg_control, the
> > > descriptor is automatically installed, and then the responsibility
> > > for the final close() now falls on the receiver, which may result
> > > in blocking the process for a long time.
> > >
> > > systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> > > unwanted file descriptors sent via SCM_RIGHTS.
> > >
> > > However, this cannot work around the issue because the last fput()
> > > could occur on the receiver side once sendmsg() with SCM_RIGHTS
> > > succeeds.  Also, even filtering by LSM at recvmsg() does not work
> > > for the same reason.
> > >
> > > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> > >
> > > This series allows BPF LSM to inspect skb at sendmsg() and scrub
> > > SCM_RIGHTS fds by kfunc.
> >
> > I'll take a closer look later this week, but generally speaking LSM
> > hooks are intended for observability and access control, not data
> > modification, which means what you are trying to accomplish may not be
> > a good fit for a LSM hook.  Have you considered simply inspecting the
> > skb at sendmsg() and rejecting the send in the LSM hook if a
> > SCM_RIGHTS cmsg is present that doesn't fit within the security policy
> > implemented in your BPF program?
>
> I think the simple inspection (accept all or deny) does not cover
> a real use case and is not that helpful.
>
> I don't like to add another hook point in AF_UNIX code just because
> of it and rather want to reuse the exisiting hook as we have a nice
> place.

Reading quickly through the other replies, I'm guessing you are going
to be moving away from the LSM scrubbing proposed here (which I
believe is a good idea), so I won't bother you with more feedback
here.  However, if for some reason you still decide that you want to
pursue the LSM scrubbing approach please let me know so we can discuss
this further (on-list).

> Also, passing skb makes it possible to build much more flexible
> policy as it allows bpf prog to inspect the skb payload with
> existing bpf helpers.

--=20
paul-moore.com

