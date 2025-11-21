Return-Path: <netdev+bounces-240760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE8C79158
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 644BC34DA55
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C42EF66A;
	Fri, 21 Nov 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hA39lGQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1830FC3D
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729573; cv=none; b=om+WQuZqTqBbfaZFVqKY0U78k1Hp2mVu7yL8NaQ+9ZHuYWoFVdF9Fn1g5T4pB50Ds1/5PN/JShgMcdBqnannzFCfFGgN6hSMJHikf83zyYDn8FC3IVwHz/wat2z9+8szpBSekI5/hWGgmN9qjPt81HYh4v8MFFR2ik1vgGLRATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729573; c=relaxed/simple;
	bh=ThsLqDlAAAYRAKGq6q7x/6TsZ6YoAcZ0Sp1TPgdRQ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVFSf5e4hOooWRVCrFd4yOzVNjHUadRAd3mMH9PEa2a0/u7cEQYrerBlguBJtG1Xedq3f1OhiO3YU8wuZhQ3NV3+GNe/4Pr3w4BB2dQA5axeCpILq7rxow9tvAi7IJzfvh07EapCgzvKWtdv0U/4fAcTQSGZnnTmNTVr81JVTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hA39lGQ4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34361025290so1594438a91.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763729571; x=1764334371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/Smfn8BMg5LBaYNNaK59fIMDlmz7HWAj6/3susT2VI=;
        b=hA39lGQ4qatcsY1WNe9mBQQ4+j2vYZFPeTb82kPGYEhNdOaA1mMfbJMKao4u7VTxch
         na6aqDN9/Sa4FGN/iSnsp8CLtQfpzRZE/iuozLMlTF4D9uSARMvglhODbNhNAkRXWQbW
         Rqb3zu3fRfR89ZvuLugs3ipy2QgsvLlG9uBtaUNxCCwpJAIi3OUtYE4q0kOcIhn8r33A
         MiDw1RzmNR/a+1auB3Rsl8uJPu/F+CmqIHcFLOqwnZJPgVPsb3HMe+EC7vC1gRoDPT3h
         0AVhv15T+vkd8Yo+LPLWsfXO/ME6OqwnJddIxLbgNooIM5hXh7p+fnx1xLqqEfBfdAKC
         uw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729571; x=1764334371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/Smfn8BMg5LBaYNNaK59fIMDlmz7HWAj6/3susT2VI=;
        b=kUIfn6c5Nw6W8t7One22brApLY26x0Y8sjzBtpNjXBV7t5UmQU7xycKo0v32f3R+4Y
         Oi9JqkG0i9xvohLNEj2mZlMTHjOs97Zh5LJeqYFPQn1uXXIvSmLF+kflpslQ54Qdbf9Z
         Z1ae0UUtkaWyFUC0oHa5UwB3oziUu6OoF7XNGUTeuZ3lH9Zpb0oFwFx7+NyPXVOxXgqu
         TA169c7P8S8jcup+jjLEeYcALT0pFgqdYyApFKIEjyYa5xMLdAdkzA9xB3GebXNXjywS
         4zWSYoAKlvBqVf9a83x4JnvqS9QZ1NKq9w1iBqn9agqMPuUcpawUC+H1bglyUxewb0TS
         HeEA==
X-Forwarded-Encrypted: i=1; AJvYcCXA+CbtOLW6KCw3XIcnAblAX4EDnRyOx298b7rY6qS7R7Y3UCocle1bH5azxbukOz3bYJzdzYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHs8xS/be2LzFJNoTk9s+oYnmRTqei0nmtyLSRWcc/fyp7Gv5
	dyOehGjg5ptBWQOX9k0OiyqEh3RcT1R7GPT3+sStfV1UY00uJjk4rpfWmuyma0rPz7gJv6xjH0O
	2y2Upw/qcalaAT+aX4Suv31pjPEOjlTGa6zybSpFf
X-Gm-Gg: ASbGnctLTVrqf5EyP5Sr4+S9degaLGz5QyQ89njTqyqnJItb0f454M21CNbTUTfYWo9
	Y1VtYI9SqzNsItrIWZLepOMuGKSIeno/53zUBX8iiTKLlfBhZl5GV7sHTakLZkT+usd3SGlaINn
	q7NsGdl+Cd1cs41PNDtCVhvF/gPJ3m7UfGZq4EPx5wJRbM3VpeuV4gLmMxos86swlgPqJtpbSts
	A7a6eamnQiC+wJHKeFYFN/csAf1xjAi/tkC
X-Google-Smtp-Source: AGHT+IH5QsqhXo0su/M15Q4Vw6U/1wMuY1h/WFUhaTOPJmvnYajPnHPwIF/OAGSCRk1eyQDaqiHhSyJGCSzRVG90RRY=
X-Received: by 2002:a17:90b:4ccd:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-34733f54386mr2772521a91.37.1763729568685; Fri, 21 Nov 2025
 04:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain>
In-Reply-To: <aR/qwlyEWm/pFAfM@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Nov 2025 07:52:37 -0500
X-Gm-Features: AWmQ_bn1DnQbCEif4gIv-PsIXRSrvxRsaRExpNKkYA9uQQrswjFI0V8U7AeZIGs
Message-ID: <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, will@willsroot.io, jschung2@proton.me, 
	savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:29=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
>
> Hi Will, Jamal and Jakub,
>
> I already warned you many times before you applied it. Now we have users
> complaining, please let me know if you still respect users.
>
> Also, Jamal, if I remember correctly, you said you will work on a long
> term solution, now after 4 months, please let us know what your plan is.
>
> Regards,
> Cong
>
>
> On Mon, Nov 10, 2025 at 12:38:07PM -0800, Stephen Hemminger wrote:
> > Regression caused by:
> >
> > commit ec8e0e3d7adef940cdf9475e2352c0680189d14e
> > Author: William Liu <will@willsroot.io>
> > Date:   Tue Jul 8 16:43:26 2025 +0000
> >
> >     net/sched: Restrict conditions for adding duplicating netems to qdi=
sc tree
> >
> >     netem_enqueue's duplication prevention logic breaks when a netem
> >     resides in a qdisc tree with other netems - this can lead to a
> >     soft lockup and OOM loop in netem_dequeue, as seen in [1].
> >     Ensure that a duplicating netem cannot exist in a tree with other
> >     netems.
> >
> >     Previous approaches suggested in discussions in chronological order=
:
> >
> >     1) Track duplication status or ttl in the sk_buff struct. Considere=
d
> >     too specific a use case to extend such a struct, though this would
> >     be a resilient fix and address other previous and potential future
> >     DOS bugs like the one described in loopy fun [2].
> >
> >     2) Restrict netem_enqueue recursion depth like in act_mirred with a
> >     per cpu variable. However, netem_dequeue can call enqueue on its
> >     child, and the depth restriction could be bypassed if the child is =
a
> >     netem.
> >
> >     3) Use the same approach as in 2, but add metadata in netem_skb_cb
> >     to handle the netem_dequeue case and track a packet's involvement
> >     in duplication. This is an overly complex approach, and Jamal
> >     notes that the skb cb can be overwritten to circumvent this
> >     safeguard.
> >
> >     4) Prevent the addition of a netem to a qdisc tree if its ancestral
> >     path contains a netem. However, filters and actions can cause a
> >     packet to change paths when re-enqueued to the root from netem
> >     duplication, leading us to the current solution: prevent a
> >     duplicating netem from inhabiting the same tree as other netems.
> >
> >     [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DH=
Jc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=
=3D@willsroot.io/
> >     [2] https://lwn.net/Articles/719297/
> >
> >     Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication"=
)
> >     Reported-by: William Liu <will@willsroot.io>
> >     Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> >     Signed-off-by: William Liu <will@willsroot.io>
> >     Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
> >     Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >     Link: https://patch.msgid.link/20250708164141.875402-1-will@willsro=
ot.io
> >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >
> >
> > Begin forwarded message:
> >
> > Date: Mon, 10 Nov 2025 19:13:57 +0000
> > From: bugzilla-daemon@kernel.org
> > To: stephen@networkplumber.org
> > Subject: [Bug 220774] New: netem is broken in 6.18
> >
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> >
> >             Bug ID: 220774
> >            Summary: netem is broken in 6.18
> >            Product: Networking
> >            Version: 2.5
> >           Hardware: All
> >                 OS: Linux
> >             Status: NEW
> >           Severity: high
> >           Priority: P3
> >          Component: Other
> >           Assignee: stephen@networkplumber.org
> >           Reporter: jschung2@proton.me
> >         Regression: No
> >
> > [jschung@localhost ~]$ cat test.sh
> > #!/bin/bash
> >
> > DEV=3D"eth0"
> > NUM_QUEUES=3D32
> > DUPLICATE_PERCENT=3D"5%"
> >
> > tc qdisc del dev $DEV root > /dev/null 2>&1
> > tc qdisc add dev $DEV root handle 1: mq
> >
> > for i in $(seq 1 $NUM_QUEUES); do
> >     HANDLE_ID=3D$((i * 10))
> >     PARENT_ID=3D"1:$i"
> >     tc qdisc add dev $DEV parent $PARENT_ID handle ${HANDLE_ID}: netem
> > duplicate $DUPLICATE_PERCENT
> > done
> >

jschung2@proton.me: Can you please provide more details about what you
are trying to do so we can see if a different approach can be
prescribed?

cheers,
jamal

> > [jschung@localhost ~]$ sudo ./test.sh
> > [  2976.073299] netem: change failed
> > Error: netem: cannot mix duplicating netems with other netems in tree.
> >
> > [jschung@localhost ~]$ uname -r
> > 6.18.0-rc4
> >
> > --
> > You may reply to this email to add a comment.
> >
> > You are receiving this mail because:
> > You are the assignee for the bug.

