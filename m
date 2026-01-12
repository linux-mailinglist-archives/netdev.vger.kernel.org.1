Return-Path: <netdev+bounces-249143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0CD14C98
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D04430056CB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065D35F8A1;
	Mon, 12 Jan 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAk0dl6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924761E89C
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243124; cv=none; b=shneBWNMyL1Z/5LUGqO438XtTC2Iy2O91gzEWr6LC3+HV644YCJ81e8v62gjvm8T3zQseYyZMU7AW8xsdKdd4Peeqn3K6F/XL5Qz9ihAKo4+aoMgY799NszZ2WfhLdpbEc4viHU/yyN922B9l/4rbtBDmG3gvBJPAhX9GgMtw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243124; c=relaxed/simple;
	bh=f6eHXRqUl4hlgF2g8mTlNVLAeksKLyMGl5ixPzWkFx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yj9KFL4lhMumvWLN12Fg0nAx1luQnICQJ8r8au6MY6SMGcKSS93YZfulsw7Nqkh42NeO2SVVdKl/Uevoilw5IPWsqilIcXdWr8RPFWDBAR2r+ngoUtTB4N9B2DSlZKzHD2bZib5WOPCBdyxpjbbeSZr1RZVHbB6alqYm2Ja9zKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAk0dl6B; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee257e56aaso61895151cf.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768243121; x=1768847921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz9dx4EcZM+jLAHwp/GzIfIUT8yIpbLQzxgkcrFQcu4=;
        b=DAk0dl6BrW0jTQRGAa/QzFTv9Sei4Zg2ingtJs7Ui+DDrZy6Pq8jl6ASWshZ2xjpjZ
         DElC8M5GFCBXcSGClH7af4nUar+nfjZvIBd78wbE23XSr8t0pdPWeE/2Dee3abO+x3mB
         3pls/emR4Ny9yyLrZWl+Eitf1cnUMAoBLOqtAfY7FrTPvgr6QY5xIe9i5okVEm28kyAG
         S4XvzUZTiXgJf4mqC5qbEt+bI0TlBVzr+T/j3nR8QSAuxwfsIHdCoTdIkTXIa1hhgqtu
         1Q/XJiclc7cwDbTOnKJbeNM7Fza0xT0U7gRI9f1Mjp5OumVaE1ITfktYSgs8tYGVKnU7
         /GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768243121; x=1768847921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xz9dx4EcZM+jLAHwp/GzIfIUT8yIpbLQzxgkcrFQcu4=;
        b=Mj1iBrYTr+qAH1PkLKxVxlHEYA7Mpmb+Avc/WDpKh9khbcEz38OeFr/FCWB/2nwQmy
         Ia3skVHLXUdclNDcjdpGfVTJvcfaUOWDlQaiStAFCP827BbP0tfetrKMZYPElemTPUs1
         PbKrqaWdmyLL19KA4TBoLeZQTO3skfssCZ2sI00pPQXxdR7kF2Nlgl9SHClKUQvfEI9q
         5jO7GOimOOlkIZ4xwnnEQYwBgcfNN6jZR3u87gCtpCAg5YMCFjKhge92my6bI/WNmipY
         wqEusq5FLEpSwvquBGD0HpO2BemdZqULYZAOwVwu792L7mA1tHndrcw3RXBiF2JTPTTn
         fIkw==
X-Forwarded-Encrypted: i=1; AJvYcCXBKDfZ7kFVz+rW0mxK51HzKUgc7WC+it43CYZfHwDr+/Z3bu8bGx7kt7p+0dO/HELD7u+wIfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza88q5b7W9ERCyZrPfNrq7CfMjCgKpPow3NFc4ZxLgBBWG/GPv
	vjSxyDN+rq5MQ+Ydbs7XnqVqD6TFL24XhYW6N6icZkJtHVFukO07mxXppB5hqvI2YqoDnY3/jnw
	TRRJncCbTUm3BImoGs5ZnTF7uDgmQDI1kvemYO7SX
X-Gm-Gg: AY/fxX6EHU+A5F2RmyN5ytzRfVg84DnBsE6qv8s2Gd3zhcCP1e2fLTPfQUF1kQTKL/V
	yixeUrjz9OUkPAzI6AsTy5UeL11ncIcw0lwxf0AIu+pqf/Mc8kbNwANDTtg/9wMfiPL3VPRKagB
	cxBEIIv6Kgd2LxAg7vSd/Kgg9a+RSCaqV4mdHYb0of7sPOVIwDXInNLyupff1k7aghvKHRwuIdu
	Ocv0lzl4EV1mRGZ88Z2j7Ia9SVeLNzFl0kAJ2wfXwU2JiR8s7WXbcH4zX52ai9Hy+Va6oY=
X-Google-Smtp-Source: AGHT+IFvwhzkXqT4yol8X15zwBeV9Z+JFnOkPHW7oX8n0cd0pN4PMSOl3LGSz0dcyS7ECTfZOS/fRxBz64fzGjcUm7M=
X-Received: by 2002:a05:622a:24a:b0:4ff:b0f4:c307 with SMTP id
 d75a77b69052e-50139784cf2mr5861871cf.24.1768243121188; Mon, 12 Jan 2026
 10:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112175656.17605-1-edumazet@google.com> <CAM0EoMkg5W0hGyZo7TMxj61mGDtdZDcTWjJQ1ZMx9oAxM4+=_g@mail.gmail.com>
In-Reply-To: <CAM0EoMkg5W0hGyZo7TMxj61mGDtdZDcTWjJQ1ZMx9oAxM4+=_g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Jan 2026 19:38:30 +0100
X-Gm-Features: AZwV_Qhsicr3w14Ae8pLD9Ij_djvS-wHdbnMoPn-FVRm9L0kVzSIPStEqQPBukI
Message-ID: <CANn89i+AMSr3oHahFkmDoYDC4DeYyuXVkCTszTe9TQFxh6DLdQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_qfq: do not free existing class in qfq_change_class()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:27=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Jan 12, 2026 at 12:56=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > Fixes qfq_change_class() error case.
> >
> > cl->qdisc and cl should only be freed if a new class and qdisc
> > were allocated, or we risk various UAF.
> >
> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR=
 cost")
> > Reported-by: syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6965351d.050a0220.eaf7.00c5.GAE@=
google.com/T/#u
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Eric,
> The patch looks correct.  Initially i was scratching my head trying to
> see how you knew it was the same issue. I gues on a UAF even without a
> repro syzbot can tell you exactly where the UAF happened?

Without a repro, I was still able to root-cause the issue to the
unexpected kfree().

syzbot report was sent as-is on the mailing list, I had no more information=
.

Thanks.

>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> cheers,
> jamal
>
> >  net/sched/sch_qfq.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> > index f4013b547438ffe1bdc8ba519971a1681df4700b..9d59090bbe934ad56ab08a5=
9708aab375aa77cf0 100644
> > --- a/net/sched/sch_qfq.c
> > +++ b/net/sched/sch_qfq.c
> > @@ -529,8 +529,10 @@ static int qfq_change_class(struct Qdisc *sch, u32=
 classid, u32 parentid,
> >         return 0;
> >
> >  destroy_class:
> > -       qdisc_put(cl->qdisc);
> > -       kfree(cl);
> > +       if (!existing) {
> > +               qdisc_put(cl->qdisc);
> > +               kfree(cl);
> > +       }
> >         return err;
> >  }
> >
> > --
> > 2.52.0.457.g6b5491de43-goog
> >

