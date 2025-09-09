Return-Path: <netdev+bounces-221152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1620B4A84A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8E8188B345
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7042BEFE3;
	Tue,  9 Sep 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0R5XqjH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148F288522
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410314; cv=none; b=NNba/ji9Q+zxnCxcsst7+r9wwIZ8tWOM6gz08k87JwiViMgh8qiDplKp12QsRPDHzPw4pIWWDTXr2v4NBHvUh/KPKTw1nC9iz0XIJOtIMNEKahBhDRWYWQyhjh/+oVLMJjpsPjcApd1pr3m0FPxww7zgGGOP+kvAI9XLN6y6st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410314; c=relaxed/simple;
	bh=dzkf5fR/hvvNUnmVBjMoYB//K61hJfG4uP/NmeNQaT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnCCBkkJ/hsZ4kg3sSPqxbsIXZgYITsp/rm3bgi+3ykv1XTtgkYrl+O5D3vgAm5AQeV/6HHfOgR/pErWmmntZSmVa+F9gKOD+rT2c3Sb4aBifQODZUcu2mwdMa6K79pG05q9iBgZN5jM2AJ/yioYc5soYdsCrSozbvGnFIoucvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0R5XqjH8; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b60481d4baso27694531cf.2
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757410312; x=1758015112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=065ckeLezrt6iV9YdKS4ln9vvI7mJj+bBB8ieI7yb/A=;
        b=0R5XqjH8awl+QUY7sfhl6FnC2vMdXb3rc7Zz3H3YCJMkL7MZhUvicrnnruw3KTz5Ep
         Jen1Yi3oLoczd900HXEX40B07W3xEB+K20oxgehLp+8eVNlyyQANnU4+SRbVY3HbKSXN
         qJ/7Xgmp/zZwkOOmxMYMSW662VTa1GPm7nTYr/xwcG2uDSEGPK+6NplsKEPMC53mWeh0
         oK1g92pFzLEiOcfk699/K9GfJH91zREhKTpSgQuDw8ZMN/slTRXFZ4M9dSA5klxceOMV
         8pFGVQQvfsgFg/N+fLn3GRxcfJfYThkiLsr0R01t7JZVbI28a+xYmH7BnqNBlegta0xw
         VR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410312; x=1758015112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=065ckeLezrt6iV9YdKS4ln9vvI7mJj+bBB8ieI7yb/A=;
        b=D+F5G3X8qeOvShDRbkxFqpIXun6UW9lVxgNXc31QtR9Xx7s/g23btiTIgHEofbOa39
         6HFJeb9KGq0M+n1nY6+pZ1PJFGS5lnA+HmGuHrmzMVt67W0Hy4sP/+ltd2AC/mjCSmFr
         DX9XgtFq1uQ/vlG4krTKp/czQupiR3LWg+fjxVXK+uRiJ+xt8HmN5btLOL7GC8Un7UuW
         pZrCKEJ3ieQ+HUQ8XtF/DUPTMcJJn2UG+vYH6oOZIDLI6f9VBaYg+Z/Sl6kqLaOxo3+3
         sjpjprYix3PrlAryky/+09ut4e0UABV/diX106xiF4rf2dqVOdjcmyFTs6basuLXvhig
         s5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUavFatlr5Hm9vT3zWtIlHiu8gUU3ric4Msq3Ta1YbvgiEQXkSBZ71vmARsBX7ZCXjnB88MV9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHL+VYVq73kg2pb5c9DnD9B9ub0P/o87+iQxE6GNueWDHjLOLd
	BzLNJBy+8JAkAiKUF8QOBaPO2DaIHbWZmDqgzAO/k3fbx2t2FgUTP7R5MjAmRWyz2Ehwl1GC70S
	Kwu+tK6QwFkpWLXbrAO7euRMSfHJVyY93+ChVDFNM
X-Gm-Gg: ASbGncuk3x8oDmtONfIqh8FtDNA5MPd2KvsXNpl39xlt0I8BjyH6YCUffwA/F31c39E
	XI/U9S6fjvcYwYDKzaEcP5Zooi1OAuKQ+Lbg8yrPeResiEHIDERQxQXhdhs7X3shOCkr4SWY1wo
	4D3NhesOELN0PS0gejDU2IYF9TAe18OwliAheIb+c2PsQoZWu2+0R9gUmAycuBR5ZiiHk3l18DQ
	kVhbHibKMFWjUBIW7YDathvoAeYSgSNOmensM0KH42KJwb5
X-Google-Smtp-Source: AGHT+IHO0nxuDmuQlk8jsSNewdRctWbQh5UkckZOg0pWh2QPu5oPN94aevA/mzvoj6fwDE3RRjLzjIsWEZJKIPrBaB4=
X-Received: by 2002:a05:622a:1301:b0:4b4:921b:acdb with SMTP id
 d75a77b69052e-4b5f8393bc1mr110123651cf.17.1757410311187; Tue, 09 Sep 2025
 02:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
 <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com> <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
 <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com> <CANn89iLhNzYUdtuaz9+ZHvwpbsK6gGfbCWmoic+ACQBVJafBXA@mail.gmail.com>
 <5b3daf68-7657-a96c-9322-43e5ed917174@huaweicloud.com>
In-Reply-To: <5b3daf68-7657-a96c-9322-43e5ed917174@huaweicloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 02:31:40 -0700
X-Gm-Features: Ac12FXwGXdNomizYAg_aOwA1ioJ91JbOj7QL8eZUWHIftw5BxTpd1mRjh-8KDoU
Message-ID: <CANn89iJ+76eE3A_8S_zTpSyW5hvPRn6V57458hCZGY5hbH_bFA@mail.gmail.com>
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

On Tue, Sep 9, 2025 at 2:16=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2025/09/08 17:40, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Sep 8, 2025 at 2:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2025/09/08 17:07, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Mon, Sep 8, 2025 at 1:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2025/09/06 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> >>>>> On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> >>>>>>
> >>>>>> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> >>>>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
> >>>>>
> >>>>> Note to NBD maintainers : I held about  20 syzbot reports all point=
ing
> >>>>> to NBD accepting various sockets, I  can release them if needed, if=
 you prefer
> >>>>> to triage them.
> >>>>>
> >>>> I'm not NBD maintainer, just trying to understand the deadlock first=
.
> >>>>
> >>>> Is this deadlock only possible for some sepecific socket types? Take
> >>>> a look at the report here:
> >>>>
> >>>> Usually issue IO will require the order:
> >>>>
> >>>> q_usage_counter -> cmd lock -> tx lock -> sk lock
> >>>>
> >>>
> >>> I have not seen the deadlock being reported with normal TCP sockets.
> >>>
> >>> NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
> >>> from __sock_xmit(), and TCP seems to respect this.
> >>> .
> >>>
> >>
> >> What aboud iscsi and nvme-tcp? and probably other drivers, where
> >> sk_allocation is GFP_ATOMIC, do they have similar problem?
> >>
> >
> > AFAIK after this fix, iscsi was fine.
> >
> > commit f4f82c52a0ead5ab363d207d06f81b967d09ffb8
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Fri Sep 15 17:11:11 2023 +0000
> >
> >      scsi: iscsi_tcp: restrict to TCP sockets
> >
> >      Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descript=
or
> >      pointing to non TCP socket (af_unix for example).
> >
> >      Return -EINVAL if this is attempted, instead of crashing the kerne=
l.
> >
> >      Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator:
> > Initiator code")
> >      Signed-off-by: Eric Dumazet <edumazet@google.com>
> >      Cc: Lee Duncan <lduncan@suse.com>
> >      Cc: Chris Leech <cleech@redhat.com>
> >      Cc: Mike Christie <michael.christie@oracle.com>
> >      Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> >      Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> >      Cc: open-iscsi@googlegroups.com
> >      Cc: linux-scsi@vger.kernel.org
> >      Reviewed-by: Mike Christie <michael.christie@oracle.com>
> >      Signed-off-by: David S. Miller <davem@davemloft.net>
> > .
> >
>
> Yes, now I also agree similiar fix in nbd make sense. Perhaps can you
> cook a patch?

Sure I will send it ASAP.

