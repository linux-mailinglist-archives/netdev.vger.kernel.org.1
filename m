Return-Path: <netdev+bounces-220769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563BB488D3
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B6E1B25027
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CF2FCBF9;
	Mon,  8 Sep 2025 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SaDEU85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3B2FC01B
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324440; cv=none; b=X40X4WtC73d1aUSY7mAAILbqv9D0pwENfmOFslXP/qjwbVfC2UkjX2PxzRHyxKxh3do5WD4F+2w/Ys8ozDDXz/q1dpXEOS6HZmwAUO+brDVu3vyuQAO1l45dF8GA1iSUm6i/I+VqICCNtrfHxSRp0zVBGY84Adjq1SD9V9VeJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324440; c=relaxed/simple;
	bh=t+aVCYfXA+p0hAUl+r/idM6sMNdxYBy4dFyRlU1jIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgNk6Yi5r2igGMcOQvXA6mJBemVfTLrgsTAE0iy3UjuPTH0XOgqRC7yXs/l0zMj3NNNki5ezgGZVuIvyAraOaP53uhuosQKzbL3OVYrX9uSMC56abLjnd+v3w6prNIW48PBrenztnwDQuI1t+DBlppVlOhxIufdP4R60oPEOf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SaDEU85; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b340966720so27354981cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757324437; x=1757929237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erhcBr1kcJ+JmJqrcMGs+dfvelpre/iMdOwMlOMIkIk=;
        b=0SaDEU85s4q88aFrdyk2G7gKEwzF9948jYYxxgyIKKE9GSlPhNWeup05qYWMMektm1
         BXo+OQ8XUBPGfCIGNSyLyWbVMrIwDoODXrxxYciGJb96L7dtnrdrZ8iDOfNgu/qfK49x
         KC7tM7pJkO2sHy1N9iKI80DsneDHLFcfrTc7blgncLWXMwgSgSEeZvdgTdm9nFT7WysX
         ur8nxcDKp7PH/lBzaxF/hXyZ5N0ItYxLfmILqVlecB0qwYlbU9OLccMogDJk4uSK8X0b
         yQrCjApPLOgFkZuegLSbBKq+QZwwccFUG+dyZdtlV+b3LBFkWdJYnCL1YxbpLWGy8LXa
         4b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324437; x=1757929237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erhcBr1kcJ+JmJqrcMGs+dfvelpre/iMdOwMlOMIkIk=;
        b=sKMzQGEFbc8/UqUgVcvwUGeiF67FwzngMauygANbYAgVP1rbF4hxBIczhir0CTDMDl
         cyBk6qRT07DUJPelrrqkO3UTliq1eY3bbyOkuNfHSmtjn709lt1WyXKQriBbLFPsGcso
         zhG+LoiTRsILYQDlzkKziqzph0la9JPT9jzEuK4DQ0IL6JO77akTFNrs3R9Ovp3m0FYe
         n4bZr/WotZLxCxFV1RtL1yL/l1csQWMLclWaxH3+4jSSPMpfVPXdmuff7qNQmBCNfwN9
         JABY4tp1+Erwx/bj5nwHxJpfIIVGFQKgsrHOF4Ykk9EVICXy8sMX/pyHozyxxkFlCd0O
         iqRg==
X-Forwarded-Encrypted: i=1; AJvYcCUlkQp9M1AVgV4UwMXimQH2JGSNHdWyv6OMfYOAq2inHZcx7WAJb8HRkLCfeAxQR1YdhY/zI5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZFZhv437Kl9ggiMgjHJ5Y/kNGjfvBoTbYnoLOUEx52z3dKRZ
	OQwBn4lPIR6g5kIIZp6A3TOwk2jse59uD+rTyaHyznFxpaHz6kYLVl0XjZxT/C1x7ATi04dpKaG
	403W3Qe6jDkpKSi/M1SSXRFtCGS0wtJiuO+1FLlHx
X-Gm-Gg: ASbGncumA1tQUW59thj5xdOChD19JxPE8sLEVYjORqyPtxS3DT7Mxyj/KvE25ZKQeKu
	AfwGCpZ7ORhdFY43ll4fPHwR5k2IXMPTZiyxzPV+oIZSK6wnxYceNH3o/YgbBFdwyA/yx0z4XjV
	iYU5RcjpdcqN4EBgbKwkrhi3HDvzSvMt5bX/knJL0Tw3uvTvq+Yr4rrEpP/3Zooi/nlYQecU45I
	jEQXGGNn0a44Nli94T8UQ1l
X-Google-Smtp-Source: AGHT+IH1qcux165XgeTJOKRdM2g9mlniLhsoO7eTSJyAbSGCi4jHXwjx9GOnwgxGTG5T20bMMEWW7o7k2xMBN/Lj20k=
X-Received: by 2002:ac8:7dd1:0:b0:4b3:96a:fda8 with SMTP id
 d75a77b69052e-4b5f834cff6mr66658841cf.17.1757324437178; Mon, 08 Sep 2025
 02:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
 <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com> <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
 <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
In-Reply-To: <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 02:40:25 -0700
X-Gm-Features: Ac12FXwc26OpvX9zU43reFsjsweUwJNkA8yDt2oGLAvJhUo4PxXaORks-CcUgHI
Message-ID: <CANn89iLhNzYUdtuaz9+ZHvwpbsK6gGfbCWmoic+ACQBVJafBXA@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, davem@davemloft.net, 
	dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2025/09/08 17:07, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Sep 8, 2025 at 1:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2025/09/06 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>>
> >>>> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> >>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Note to NBD maintainers : I held about  20 syzbot reports all pointin=
g
> >>> to NBD accepting various sockets, I  can release them if needed, if y=
ou prefer
> >>> to triage them.
> >>>
> >> I'm not NBD maintainer, just trying to understand the deadlock first.
> >>
> >> Is this deadlock only possible for some sepecific socket types? Take
> >> a look at the report here:
> >>
> >> Usually issue IO will require the order:
> >>
> >> q_usage_counter -> cmd lock -> tx lock -> sk lock
> >>
> >
> > I have not seen the deadlock being reported with normal TCP sockets.
> >
> > NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
> > from __sock_xmit(), and TCP seems to respect this.
> > .
> >
>
> What aboud iscsi and nvme-tcp? and probably other drivers, where
> sk_allocation is GFP_ATOMIC, do they have similar problem?
>

AFAIK after this fix, iscsi was fine.

commit f4f82c52a0ead5ab363d207d06f81b967d09ffb8
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 15 17:11:11 2023 +0000

    scsi: iscsi_tcp: restrict to TCP sockets

    Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
    pointing to non TCP socket (af_unix for example).

    Return -EINVAL if this is attempted, instead of crashing the kernel.

    Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator:
Initiator code")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Lee Duncan <lduncan@suse.com>
    Cc: Chris Leech <cleech@redhat.com>
    Cc: Mike Christie <michael.christie@oracle.com>
    Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
    Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
    Cc: open-iscsi@googlegroups.com
    Cc: linux-scsi@vger.kernel.org
    Reviewed-by: Mike Christie <michael.christie@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

