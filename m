Return-Path: <netdev+bounces-238476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5003C595F6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BA2D4E7916
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12E26ED57;
	Thu, 13 Nov 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZPu7Q5C8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CA35CBA9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056518; cv=none; b=TYvcWe4noMwK/AuKHYAfEL2IutLHD1Ck6Cfwz9D+WIqOjxiXV4PQYuXwhX8u/frAyF3+ILmzfRSx+Z+71RDx2NnF7KKfyu8FUvD970+19jRvmU/p0nuk9H+mkcJ3d3AMQVAF7wmlMmSxjnsjLY6IFSmf5JEgoF5YdC73ABonrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056518; c=relaxed/simple;
	bh=QrP8WSrwxZSwzK10kjIjU69RxuAe7USLzcJZIRglKPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orijokWeTgNYQs5Ao56l39AJi/CQgky6uZ6RiTAUUl1P7kHXNC70CMqi2gtZTWRLupVS9aqkJqrEaIPsGFqkqmccayTQjFTIf3IZjnMIeu7B6XMGECRrdAc9rRV90KywegR6aHqzmYG1dX8rdf4awnNqLo6OWw8dn9+L3kSmFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZPu7Q5C8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343ea89896eso1142656a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763056516; x=1763661316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrP8WSrwxZSwzK10kjIjU69RxuAe7USLzcJZIRglKPs=;
        b=ZPu7Q5C81+7huyDqUOL3tFRjPqqF+yFYfRII+oo3dlzszuEO/bXZtdrrkK8dUB4Qgs
         HqxbuqUW9zLcyjVVWfBkBmCwcqd+orzvGJneUnGwETHRSRPKqsYOXJ9OlpjGpk02SWjf
         w7wFHa7tqfGRb/f811tYXUJ9Memtg/e0TQJHU0H3jzcVCIhrh4Vz97uxZuUg3SMsU9Fr
         e+loG8hmo0AszQqov0j7w73J23ByX82Q1BZaU00PUpcNM3E7BJnR+TaBwOh8Cy0Mn9Qp
         FPofDZ0P8ggOppaDLxpFw1GwA69G7bB/ikG41bY45woZB6i8ollR49ZCikfQNKbzd6l+
         WjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056516; x=1763661316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrP8WSrwxZSwzK10kjIjU69RxuAe7USLzcJZIRglKPs=;
        b=bbnEF0unxUio/bds1ZZ9n+PUVd3JrnBUnU2JTmDSGSPNLyiDI/LprEd1nT3zHqhQTk
         i0I99S9LvNsysVu1xA6Q6L6hZ0kpHOwKvwpvTa+U9FYdTbNDfko83Upys9j4hPQzSAnH
         kADOBJgPeOwZ1Y4ES9kQPv12LBcNSkns3f2sXKZUCGG+3Osg4XjGYiLGFfdh842lF5Jm
         DvxMx6F/H9l7BBkYW2ClVB9CW/VvtoUP5ynKJZBBU+z7hOUmoSzNvORYJRAgs6yslhhz
         xZGvl3MJXEIhe1VXtvgWGMu9vqdDdNxXwcbkf+Ugy90DpCtnlNfr01XXASflBXugeMEA
         83Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXLIgzxWQKPlt2rnvs55r4zXeT7woVpzjQsMtjGrCRZ/omrHpi20NGAQp/vVSK+/eBuvax8wQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYlqAagMvB99I9AXLOGvp2akonYtGmic+YEue2yN5FIrkKNO1
	MWETsf46jtxqRztBhW9LBIb1yzleI/RciOPfSKSs+PNPH5UxqwdsicuxnnCq1ZEI7++HGTGuNoX
	WVOvuqlBLB5NwrKv49Lvl6wFy3/X/4i5fqja5P43K
X-Gm-Gg: ASbGncs5fyi8VpwevhC3NXIvnJFuFMEv8OoQMQ1COD+9Ae5aVKsl4yrx0522hxNi4fj
	sRPclLcEhngNUU9nIsnKFfzAMo4qPe8DRr4lbS3wrj4B1x8YoXczj3ONkhaeKgwWLb+RnPeL8hX
	946Mb3akYMh4aacHgk/+4X1AcVcNyIMSgmJAUxUTzdhoCZ4kPVsZrKeA1RmbIT9E5sv+WRKfDcE
	UZpwGVCtNf7y2YTlblA46z6/+ki6OuiDGSFdyMgNGg/ZkysrdG3q0ly3ZBcNG+46auIH6Uwu4xk
	m+0=
X-Google-Smtp-Source: AGHT+IE/XO9J/WSX65NFV6ujW2giz3dJ1z7yatj+3YhBvSRx3o+rJltA7da1/5+EbarsW/DKSSLnOVc/DP63PEfFhW8=
X-Received: by 2002:a17:90b:3c89:b0:339:cece:a99 with SMTP id
 98e67ed59e1d1-343f9eb3128mr150252a91.13.1763056516417; Thu, 13 Nov 2025
 09:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112125516.1563021-1-edumazet@google.com> <CA+NMeC9WciDGe0hfNTSZsjbHDbO_SyFG3+cO0hHEc5dUyw5tTw@mail.gmail.com>
In-Reply-To: <CA+NMeC9WciDGe0hfNTSZsjbHDbO_SyFG3+cO0hHEc5dUyw5tTw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Nov 2025 12:55:05 -0500
X-Gm-Features: AWmQ_bkH0ZjS_y9MVuYFVLZY4kYzawlEIzY6Roh5Sj879PFCOzb59qsiXNd707Q
Message-ID: <CAM0EoMnFaBkC6Hi8nJMGnAJYp_My7JJTsSpJkwLT86rOMdX1SQ@mail.gmail.com>
Subject: Re: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
To: Victor Nogueira <victor@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Paul Blakey <paulb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:18=E2=80=AFAM Victor Nogueira <victor@mojatatu.c=
om> wrote:
>
> On Wed, Nov 12, 2025 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > syzbot found that cls_bpf_classify() is able to change
> > tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop(=
).
> >
> > WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_dro=
p net/core/skbuff.c:1189 [inline]
> > WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+=
0x76/0x170 net/core/skbuff.c:1214
> >
> > struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
> > Extend qdisc control block with tc control block"), which added a wrong
> > interaction with db58ba459202 ("bpf: wire in data and data_end for
> > cls_act_bpf").
> >
> > drop_reason was added later.
> >
> > Add bpf_prog_run_data_pointers() helper to save/restore the net_sched
> > storage colliding with BPF data_meta/data_end.
> >
> > Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc con=
trol block")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Closes: https://lore.kernel.org/netdev/6913437c.a70a0220.22f260.013b.GA=
E@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Paul Blakey <paulb@nvidia.com>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

