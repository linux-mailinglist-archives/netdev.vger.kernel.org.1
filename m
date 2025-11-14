Return-Path: <netdev+bounces-238722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D8C5E4AD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67F34F9979
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1822BCF41;
	Fri, 14 Nov 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w42HgApM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D720CCDC
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137081; cv=none; b=kvLLMHyWeJkhscGw+1CFeM7pmbnGBshbTTckiPrD660eLiUx94hJQ8wPC5QRh+e39tU43I4jp4VFTApW0E2N3iaDqKQj2mNkOLDiYaa+4AL98wyX2uHaDBHYCm4VM7N3kzL+ejyPMlMWfakLM/KvM9vKlphlgnWLNpEy/R814LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137081; c=relaxed/simple;
	bh=c+OES7UQNaSHBEi1uEJ/RHRuvht5zjTVKhnEHGRjofU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0bTJsbroQheslQk80lfWNL+69+23lWBZukPFk0dLzVUgHyIQNJdMXYrDAxv3XQ4z7pAtmYiScQW8z41I5stkKgkE2RLA8wHB2daUtv0mM5Up4QAf7CqSwdgm0tdmjiWls/s0hUK4JPW0Vh59XtvhIsI8kHSqPKCAiTiTCWUN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w42HgApM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edf1be4434so10995551cf.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763137079; x=1763741879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+OES7UQNaSHBEi1uEJ/RHRuvht5zjTVKhnEHGRjofU=;
        b=w42HgApMyseOsEmgfE0TCbBvibsqYIAWA57VtpybHMxOuFUtraVLzlS4NEe+JNPyXb
         TX/CURKKyJJOc22uoy1V8clGqCHsRonxufNTdrqF6nOSC+pg4AMzjge0g5o/UvMXwTPG
         Tc9K0ueUlXAODcvDsF+om+MINWfvQChcw/5ttTQ2nNj8RE7gZnZzKcFunTs0j5T7kOwt
         M1L4ZmYuTXAwUP8+VVndwfEOxVMHAfpdEA40MYe22as5VP5h+0c6K2OgJ5wiDnmvMU4i
         WifYNHfRxywXf0/jcUznHdC7VRFpA9TAkz2eHF0wEMdvsu8JH+04mDYDSLoY0S9C0Nqc
         hwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137079; x=1763741879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+OES7UQNaSHBEi1uEJ/RHRuvht5zjTVKhnEHGRjofU=;
        b=Oyuj0IBAnlpwAdqMErZa3wgkReG5XrCo2La5BuOmCIJ8gp+8t7fdrE3SXidJm0yYZ4
         4Vn9ZWGlP7mwUT2+NZfysdBD2AVN4eW0Pc0LAyEd311TO17iJLh+tp5q6+JJ7+zPzMzZ
         7cqhe5IG8lgKHtu2qGq93ce3aFKlccZ8cAF4IWYtxwGV7YS2IQ4VTMuZhIru+yA9tcfW
         2KUFgS21rzUU9uGZzxbMTt9W3CNKWiHdy3yHaBnZrn+acW8q2HhZgyKHrmjSUYCZS9wr
         JMNwm/dT906kcJtAGHsVRjgDy7R8qzJYkI5nP0ZEuuOKrEbAO05bViBxwEW/QftUFLc5
         MmSA==
X-Forwarded-Encrypted: i=1; AJvYcCXV/qFFMMuzL8d4ZLQkWlX2UjWp9AycKGNx9DgFwRLX1ZFJslWnbS+Oygpimc6zUQe4SW45YL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmdcauSD5Cjj/iYNRPsZIMowKKfRoOBF2WB9NeqwPRdnUD/qM
	hky+bgNVTPGQ+Js/dTduaPW+357V82g8yoRKMnhrmPCDCJdrPQtmz02ktj85hV0EI4sszOwcnkq
	GR0/qvmEnb3Dcl8eb7ABPgfKxiNBomY/Um9GZNc4d
X-Gm-Gg: ASbGncvz7cO8EsRR/Jw0AToH7oq48Wpwgh97UnbV9GkG+2I8b93CSLZwMKdah1iMedl
	tWnwt+FekdUrnDkaKv39CYf4bjtXOzg5bgxXXeuLjMgMOA6W8S8ZmSOVqVCL7qghFJf2BOuDMta
	quoqF943ivi6Tgk7pbCCPLccKzGKRBIUisd8QonxOThhazmZLgWWVvNmpfsYdRji+g+PytMm98C
	9CnhloTADZBYfU7LIdP5YObMbOCJM0obosiocpG5EsZV+FqJA/ncIXHtryAbG9EHuhGcJGIBKkC
	l7FcAdaYIXOR9A6Fz/0l143qAiSS3ZF1tg/GvvVm
X-Google-Smtp-Source: AGHT+IHT8jfNW/MLJylow8w9ueLWTwMLhdk8IkJBv7MjPgw3BzF9Wb6Q5q4FtoeMgegcbk1TOW+jiJEVDU3AWjbGcY0=
X-Received: by 2002:a05:622a:1647:b0:4ec:fb4d:105e with SMTP id
 d75a77b69052e-4edf212a426mr53102261cf.69.1763137078559; Fri, 14 Nov 2025
 08:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114135141.3810964-1-edumazet@google.com> <CANn89iLp_7voEq8SryQXUFhDDTPaRosryNtHersRD6RM49Kh0g@mail.gmail.com>
 <20251114080305.6c275a7d@kernel.org>
In-Reply-To: <20251114080305.6c275a7d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 08:17:47 -0800
X-Gm-Features: AWmQ_bkaDeE3KEP9Rlziz1zYkxFwhbWz_srtM0ACcdZR8LcwUB_2MYYDS4s7RmA
Message-ID: <CANn89iJr4R4dgFmqCPtSWqgvPiY5YB4svD_4D7tO1BoZr=Y1-Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10 usec
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Nov 2025 06:08:58 -0800 Eric Dumazet wrote:
> > On Fri, Nov 14, 2025 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > net.ipv4.tcp_comp_sack_slack_ns current default value is too high.
> > >
> > > When a flow has many drops (1 % or more), and small RTT, adding 100 u=
sec
> > > before sending SACK stalls the sender relying on getting SACK
> > > fast enough to keep the pipe busy.
> > >
> > > Decrease the default to 10 usec.
> > >
> > > This is orthogonal to Congestion Control heuristics to determine
> > > if drops are caused by congestion or not.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > This was meant for net-next, but applying this to net tree should be
> > fine as well.
> >
> > No need for backports though.
>
> Sorry to piggy back on a random post but looks like the changes from
> a ~week ago made ncdevmem flaky:
>
> https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-fbnic-qemu&t=
est=3Ddevmem-py
>
> Specifically it says:
>
> using ifindex=3D3
> using queues 2..3
> got tx dmabuf id=3D5
> Connect to 2001:db8:1::2 37943 (via enp1s0)
> sendmsg_ret=3D6
> ncdevmem: did not receive tx completion
>
> This is what was in the branch that made the test fail:
>
> [+] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
> [+] net: increase skb_defer_max default to 128
> [+] net: fix napi_consume_skb() with alien skbs
> [+] net: allow skb_release_head_state() to be called multiple times
>
> https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-hw-2025-=
11-08--00-00.html
>
> I'm guessing we need to take care of the uarg if we defer freeing
> of Tx skbs..

Makes sense, or expedite/force the IPI if these skbs are 'deferred'

I did not complete the series to call skb_data_unref() from
skb_attempt_defer_free().
I hope to finish this soon.

Thanks.

