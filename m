Return-Path: <netdev+bounces-155258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B42CA01883
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 09:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2111882E7C
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0438FA3;
	Sun,  5 Jan 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/nq3b3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC01DA21
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736065970; cv=none; b=cXho/OWT7e3U7ECse/0J24yuDcmYAsfvFmFOtIeWG8vxn5AFT2k7Si6t72Bv63S/38IAWP1g5wouQuM9NrYErMKDwuZEIt5RuRc56hdsNC4dVlUOqM4EQXFsHNpOd1shLrkX/URI4sbFTAJBpBvi0iEVStLcevmgoUZY8c2zwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736065970; c=relaxed/simple;
	bh=FKhLkLaZUareZFduZSPJ/xQrSRZu2qocVNeIWlOCBy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsmU9WCSSQCUv3tEWqRWQdcy/SoG3aOOKSJKh7iddVQ5I1nhn66J/TqhainIVoR0RoPdhnNFQ/WrKkaVBOMxEcKAid41cJQRL1m4KC6oNKD9+cKNK+rO/XU0DRq/Z6x8TFJrBi/mmTt1Pip3jPFG5rg/coa5uLrJ8OZB/EwYfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/nq3b3d; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso22646381a12.3
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736065967; x=1736670767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feky3fOQIBZBCqyXt7+3X9e4oX7Q5OHhgwGJckV1gq0=;
        b=h/nq3b3dfZLNaEZg2Qkk/RBWRx93En5cBs92fyI4dmtdz1OsJxxQ2K9BhfaNbjEvZQ
         axXEH0tAbM//nK3CX9NLbk1dNWZ69E8DtgYs6F93I/GnneOitAwNsfc+yJXBod3Z4Uxk
         DZwlsdTFIlK9xiocj5pKdgUX1kuy3O4y4pw02NAUzxlo6PhjPxwkFsj5R2xzvc6rco3i
         2K8E/qFUc2amUOuLh9AoxBNNpuDCPyMey3r+/J1r0/ci0vZZYd9IV25QIsqifC1zYFZy
         BfT/C5NHXou3OD9PK+1ErxD7LBhy2CWq5e6PsDCg1UU9iDjLcGgFQJTJO8qJbMY0eGkf
         ovNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736065967; x=1736670767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feky3fOQIBZBCqyXt7+3X9e4oX7Q5OHhgwGJckV1gq0=;
        b=sbueFSVkf9hNlv802Shi0ZoYkHvE1B7R20P3mWcBV7R5xgT6ODwNsFtlWL4tzKtDqo
         B/+4+n3x2PHU1QzgIzNdSdMk/AX9yaclNc9M1w/xxCrPCChJ/FxNFVYBlcY2KDgtmpWD
         HQUcygl4QaoMgr9NgaKOj9C3roBehLUrkHzo+cct8Y9MjIbK2s7RWVnED5mU1GMMgPTi
         zCSKuau6mag+AnsJW3DXvzKxpFRUnuOeqBLvHHs48zux0MAz2MHOGX8aHcSi5lKBFpzE
         fHelGmYjrystcGT9ZJ7+zl3RbVxEIFu5h3txyWhqUeJUO1t6/qEA1DHE/wkduqBHIBnf
         19BA==
X-Forwarded-Encrypted: i=1; AJvYcCW8tXpxsayChy33gWJfLeza+yUQV/vAyWM2CB3NFyyTZooSdkWviJRiwlwfWyqsxBQZuJ4FBn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTF8xIpGQqNqHDiwo8vqrgFFVsI/rd6KePbdm1V/zWMq/hAr+4
	p9kNTxaOPuLcitXNr46XBUB42QCi2Xahnl34bw7bzatkhgbaJphN4PdmMJcZDv3ft7d3uu9wSdI
	Dic3TNVl511qX2QpHve1iYIx1CsyJpl+ICKQ2IlIwAttfuqN3JxUy
X-Gm-Gg: ASbGncuyhUbSGpfUmvRvH7hZ3C78U7QrHCeuKmwxkn7qe29act/MRuRkKARU7FwWFHT
	1DhULKLPeGB4hgChCNXL0zSweXThEUinn2ciufwQ=
X-Google-Smtp-Source: AGHT+IGxTAgQM1VW1kke0fyltXylhZqkT4C5ZvsfUhJY238xnt5+cxsJ2MB3kfttHW/OBdAMBhnYzQL89o/Vv7ojjkw=
X-Received: by 2002:a05:6402:5245:b0:5d3:ba42:e9fa with SMTP id
 4fb4d7f45d1cf-5d81ddc01a0mr133299931a12.16.1736065966986; Sun, 05 Jan 2025
 00:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com> <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org> <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV> <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV>
In-Reply-To: <20250104202126.GH1977892@ZenIV>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jan 2025 09:32:36 +0100
Message-ID: <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sat, Jan 04, 2025 at 08:11:49PM +0100, Matthieu Baerts wrote:
> > >> +       if (S_ISREG(file_inode(file)->i_mode))
>                 ^^^^^^^^^
> > >> +               return;
> > >
> > > ... won't help, since the file in question *is* a regular file.  IOW,=
 it's
> > > a wrong predicate here.
> >
> > On my side, it looks like I'm not able to reproduce the issue with this
> > patch. Without it, it is very easy to reproduce it. (But I don't know i=
f
> > there are other consequences that would avoid the issue to happen: when
> > looking at the logs, with the patch, I don't have heaps of "Process
> > accounting resumed" messages that I had before.)
>
> Unsurprisingly so, since it rejects all regular files due to a typo;
> fix that and you'll see that the oops is still there.
>
> The real issue (and the one that affects more than just this scenario) is
> the use of current->nsproxy->net to get to the damn thing.

According to grep, we have many other places directly reading
current->nsproxy->net_ns
For instance in net/sctp/sysctl.c
Should we change them all ?

Perhaps an alternative would be to add a generic check in
proc_sys_call_handler()

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 27a283d85a6e7df1a7edbfb513ce75832363e2e6..84968b10ce86e7fd88c6e3c43f5=
2b601394b056f
100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -576,6 +576,8 @@ static ssize_t proc_sys_call_handler(struct kiocb
*iocb, struct iov_iter *iter,
        error =3D -EINVAL;
        if (!table->proc_handler)
                goto out;
+       if (unlikely(current->flags & PF_EXITING))
+               goto out;

        /* don't even try if the size is too large */
        error =3D -ENOMEM;


Thanks.

