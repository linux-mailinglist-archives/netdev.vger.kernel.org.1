Return-Path: <netdev+bounces-191172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFDABA4FC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1608A2114E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3C22F750;
	Fri, 16 May 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/u7jvS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B322D4C1
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429775; cv=none; b=bI7GItAoioSX9JPaScYadt1wmUtf4VzhT+5I/Hk4OPYAuArl9Iv04QF21EfWquvOBijQOQyymPThQF76YeDKryaK7i055AGJhctQPen7qY4YiVCfzjOuLZ6qos7myK3t+xu9QK8B4yWc6FokKNebHfk63SplSUnPxgtA1oyx2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429775; c=relaxed/simple;
	bh=NiLoYacHBGmyN0Ec2QaaU+8mlcJvH8TMjLfjMYPQtuo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aDYAwCM7joo2BEeBAgWskJiv7+TnkJsL/Vaey3K2Og3m6tgy4/sRUEolD+ati9UWH47PMFmoD1WBOHOCtsF9nlbwq2whZXSQbaPj5VX5rei6PT/F5fMElxqd7Oua1MfcgzQWhnvz/8Eo6ciwglljRFuua7X6amg4HRWZqfKFCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/u7jvS9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7cadd46eb07so264465285a.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747429772; x=1748034572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCvqVkrXjIHsoGmwPNs07n+o43Zva/Oj/snq0aJSr24=;
        b=Z/u7jvS9px1CBiQ1/894h0Ca9jW2G0+8AgmecZzsplatPLzTpRBwyB0XKAL0FKnxtp
         V0+txUOdpdM2qH9jx94l5v1OHspm7B3se12OuGehEGQzNpAIAc74UEwtFtL/A+37EZN0
         oCBvHwAVWKBI5PuWMX/WM1xfpDFdD72P4AutEjY6lj/gDSVwZY9i8yo6rR8ZrQ2kj8YC
         8ASG/PgLhewX8banx7Z4c4zPw4aMizdwKHmje74/KU5myxlmWAeV6chExBKAXxiFexlv
         EefMrrrIDRoQrWxnp93ZN8sz7J+XFPFyK28/FoSM/Sw8aChKxM0NWdGPmtCFIBEhanYy
         HmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747429772; x=1748034572;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eCvqVkrXjIHsoGmwPNs07n+o43Zva/Oj/snq0aJSr24=;
        b=wyc/MbnF4efFo+lce9FAn+axIvarPmd18J+dFex09RY/7C13nJNrDvMAtR3ak3LAgK
         MZHe2XwhnWb1Olf8aAMFoZooAOdhgfij1LWZUjCLnuWVS12fSTqgzyfIuKRtpHnvs8/A
         NDkA2D0Y0+q/yt8KblXhzqjfQ1/Y7X4Emn+yhbBAcejNJgRPbwaPNBSMbZ++i1ULJs4j
         WQVjoiiO6uF6taYax+81fXpYUlqrfzwNqh4y0eFmtkPJXNVbIZat5wrL2NcmnIvHktUM
         c3fI/iL+sGFMTv2ApLE2uWeBq0LvRIKWK8bw58hqp4a2mllpap8wXm2M1d3TBFTsj/je
         f5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXbcwB5R2G4U7D2mUQkCP2jDNQohGRtisP+bsbHAnKspdSf8a0ocWbP2afflScSDUfKHOKJm9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBmrzHPQE0jhaMxA25cFR7KZy+47NDI1cS0nHaLndQ0M7ICq6
	rmKmKQXhU6wXW1bybHH/JlwYfl81/SsYweRSLtys1tL1sbQWPInsTJAEyXXNJg==
X-Gm-Gg: ASbGnct7WRhzcSlKFGi83PurEu6NZnMlH1banuHjqGmq/h4zyKGFnAElD19cLslF7Fx
	RsV4479HthqQLjrnuhGwP/D1FsDzJFW48aM0aTy8LN+zrQnA43ajSDAf5Ny6Wna260Nf/O6pUeG
	gkIQK0V/gY1Drhj9vrTGL4MpOK0RaVQWbDwieMg3pElX3XMtSIWfqPHmMfFDIlTI8N6XUoFq+cd
	Y9v27m1MyDijKT+w7+cykUvUfsOkfNmUmkc+Hme1PUROJFaDXXMH1z6ITH9wbB5qL3fr9iU3ZF1
	VXCSWd1qkP5bdX5Sy1nb7eSJBvcDSzM5pezNvhpHRaDdirMRJQM9hHNDhXbanGGAyZuCfHthxAP
	4V1gOW0ehIaXNZi5RqnqSWEY=
X-Google-Smtp-Source: AGHT+IGH5qcyRhf1VsMBk2mCFY2vLfAGHhmvzCRmvlHtWOy7jO9Q0IfLXFuT7kdL6NxO7b4D0kGOoQ==
X-Received: by 2002:a05:620a:44cf:b0:7c5:5585:6c8b with SMTP id af79cd13be357-7cd467acf1bmr808750085a.50.1747429761672;
        Fri, 16 May 2025 14:09:21 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0966098sm16518556d6.82.2025.05.16.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:09:21 -0700 (PDT)
Date: Fri, 16 May 2025 17:09:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <6827a980d82c4_2d2d1f294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250516205430.93517-1-kuniyu@amazon.com>
References: <682791b4dd9a1_2cca52294bd@willemb.c.googlers.com.notmuch>
 <20250516205430.93517-1-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 7/9] af_unix: Inherit sk_flags at connect().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Fri, 16 May 2025 15:27:48 -0400
> > Kuniyuki Iwashima wrote:
> > > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Date: Fri, 16 May 2025 12:47:13 -0400
> > > > Kuniyuki Iwashima wrote:
> > > > > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > > > > are inherited from the parent listen()ing socket.
> > > > > 
> > > > > Currently, this inheritance happens at accept(), because these
> > > > > attributes were stored in sk->sk_socket->flags and the struct socket
> > > > > is not allocated until accept().
> > > > > 
> > > > > This leads to unintentional behaviour.
> > > > > 
> > > > > When a peer sends data to an embryo socket in the accept() queue,
> > > > > unix_maybe_add_creds() embeds credentials into the skb, even if
> > > > > neither the peer nor the listener has enabled these options.
> > > > > 
> > > > > If the option is enabled, the embryo socket receives the ancillary
> > > > > data after accept().  If not, the data is silently discarded.
> > > > > 
> > > > > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> > > > > would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> > > > > descriptor was sent, it'd be game over.
> > > > 
> > > > Code LGTM, hence my Reviewed-by.
> > > > 
> > > > Just curious: could this case be handled in a way that does not
> > > > require receivers explicitly disabling a dangerous default mode?
> > > > 
> > > > IIUC the issue is the receiver taking a file reference using fget_raw
> > > > in scm_fp_copy from __scm_send, and if that is the last ref, it now
> > > > will hang the receiver process waiting to close this last ref?
> > > > 
> > > > If so, could the unwelcome ref be detected at accept, and taken from
> > > > the responsibility of this process? Worst case, assigned to some
> > > > zombie process.
> > > 
> > > I had the same idea and I think it's doable but complicated.
> > > 
> > > We can't detect such a hung fd until we actually do close() it (*), so
> > > the workaround at recvmsg() would be always call an extra fget_raw()
> > > and queue the fd to another task (kthread or workqueue?).
> > > 
> > > The task can't release the ref until it can ensure that the receiver
> > > of fd has close()d it, so the task will need to check ref == 1
> > > preodically.
> > > 
> > > But, once the task gets stuck, we need to add another task, or all
> > > fds will be leaked for a while.
> > > 
> > > 
> > > (*) With bpf lsm, we will be able to inspect such fd at sendmsg() but
> > > still can't know if it will really hang at close() especially if it's of
> > > NFS.
> > > https://github.com/q2ven/linux/commit/a9f03f88430242d231682bfe7c19623b7584505a
> > 
> > Thanks. Yeah, I had not thought it through as much, but this is
> > definitely complex. Not sure even what the is_hung condition would be
> > exactly.
> > 
> > Given that not wanting to receive untrusted FDs from untrusted peers
> > is quite common, perhaps a likely eventual follow-on to this series is
> > a per-netns sysctl to change the default.
> 
> Makes sense, I'll add a follow-up patch in the LSM series.

Only if you think it is useful, of course. I don't mean to ask you to
do extra work, let alone add APIs unless there are real users.

