Return-Path: <netdev+bounces-216660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C0B34D9A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1420844D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAD728D8D9;
	Mon, 25 Aug 2025 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMWsAYs7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C59275AFC
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156074; cv=none; b=bU1MWZcaycIraoMV8gYXfeiUBc2JF7ADanONJ4acdiwjGo1w4RhuMcb4dFV0jmyVFju00rFNAmQ7KuOVta57xRCF5X03H6K9ps9CiYSOriO1uP98Jb4mEhnH1DUcltZ3MHogn8Y92nDA6MhgpM6E84Cg4mX8zuqNhrIoNZeSM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156074; c=relaxed/simple;
	bh=rsgQsADbJK9QUmMKxUDa/Fk0IhymXtnj4qX8ecK2uC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv9smeXqyjWhjWYaEzxxgF4MXd4o+SqQvH9mEk93VflQAreQFkKLumyw9cyv/mgxW3BxkV6MAkhC8F8a59g7R5F3WpqOD9pcKrgvm+4DBPTcaJ+GRmhbm7yu4Fsy/kt6P/d7Mwkuecn9UzozA444nWfIl4/Pi7a6l7RGmtWQ4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMWsAYs7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445806e03cso56758815ad.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156072; x=1756760872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsgQsADbJK9QUmMKxUDa/Fk0IhymXtnj4qX8ecK2uC8=;
        b=BMWsAYs7JLJw+2eVfaxp1YRFEQb2JUWOmhzQhuMbM/wS6rTkF4QM6Vb1djkCpeLSD/
         E1aq7w47bDstEuTGP3YEGkuIfIoJXwZJ2tJlU57MZaR83wX797SCCvNRbepXohmCbbYJ
         LfJY6I37vlTSDbtJVyPFPcqNe1+uHREyg1tzeJhefOInOH0M5jdbJnwUloky77D6mrB9
         TXyUERKbXvOzo6cQFhOZ/WsWuGVBhwyEQE++bZwMKcEyTYrikSetPIniLD4KxdWr7gjB
         48hwmqfy1oQS+tnC9/YkEu3X6BHZsOlNjOPeYVPbrTJ/GA5bF3Ll2l8cnJF/1MMYdfj9
         kXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156072; x=1756760872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsgQsADbJK9QUmMKxUDa/Fk0IhymXtnj4qX8ecK2uC8=;
        b=Uud/ASOB2Hwg9jUTB/aNobIfK+lR6NWRKJZ2ACeToEgHYXE2FbHxlRhU+xAS2/FbOj
         ajZmab3DchIaWprPaHe6ftsdnCp3tck9JXfdfiPSsg5fFZzybp8AOI4ayD8m4gRB6eed
         d+20F/PhqSSxb5puv4TbB2JcnGLEo89ACvHnWuqj5RbmUSII8XCKSPl7YDLjGyMo3PYg
         t1Ly+sw9uwudw4jh8DQGx+OuYo2BiGJ6+yUJrJy6a5v9S9YsuKu3ljwO3VtbUIPtGq/Z
         BXiS/C6j2uF2ho6mYMhF4CPq/Q1AAjeRithSeJFrPidpmkeTVvvecDJLn4uFRbbsxYGk
         Q/+w==
X-Forwarded-Encrypted: i=1; AJvYcCVLPnIKXgl64NfsqKAvTeOh0jilS72qh1v7unVTvs33/rbAaiKPgu7xoC8ON4bJRu78TLWOQAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAA8loXDI6KSLodKEVYosQZeBYfE0XtV28PjyuTB7cejtnMzW
	JwMQJu5GClrZMvWqrOq4gaE7R0fvgg/E2J2HRYQFlqjU/VHJSI9U4OUv9tqGcnYHWWzIPP0a5lK
	GuBupYhfzvr2QKn6+iEXxnIB26W6U0aNviwu+yCEr
X-Gm-Gg: ASbGncvAIzlhACq9NWdVCX4gPt2h9IiqQr+sBbsJZG+ip587epBuR1dHWcDwM+3DyUk
	lxkaNy+YcDBoycCPmtkwOjPcKRC4NWBVa822C3dmDbmnXwoPQW0RzRnd1lrWbJlyIKhZ2qcCd49
	Xe+UN8soH7AAZ4w1aGQPiq/ooL4dCRNDzrL5flkwA0yx/I1KuWf0C1F5tmT3Ey0HJPheRXy9YOQ
	CL0/N1BUKPYrmt9m+OSMIzUyEgmLGjsS0WpqqPkstagN8uoGqI6TipfC+1q3WRNeCG9RCBa/kyL
	fKLgPQnQ2A==
X-Google-Smtp-Source: AGHT+IFG5RTfX6ud7JlnRAPMerHJf0Gbw2YzpqBK05FqAlo9zIJQqUl848H3iGoxvhe6mgAQlaJdiUZU7L2rrRtCD00=
X-Received: by 2002:a17:903:41cc:b0:246:b351:36a3 with SMTP id
 d9443c01a7336-246b3513841mr70712685ad.48.1756156072000; Mon, 25 Aug 2025
 14:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com> <20250825204158.2414402-3-kuniyu@google.com>
 <aKzMxKViOGjxFhiW@mini-arch>
In-Reply-To: <aKzMxKViOGjxFhiW@mini-arch>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 14:07:39 -0700
X-Gm-Features: Ac12FXw0Dtr1s8EQjHWjs5pMcjrpJOHq1fQzaS4zTIwkTNJhoX312mfmLMXMCzs
Message-ID: <CAAVpQUBzWzVgvohLKOTS0U4ay9D29otB619T6O786m9W0YSWtg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:51=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 08/25, Kuniyuki Iwashima wrote:
> > We will store a flag in sk->sk_memcg by bpf_setsockopt().
> >
> > For a new child socket, memcg is not allocated until accept(),
> > and the child's sk_memcg is not always the parent's one.
> >
> > For details, see commit e876ecc67db8 ("cgroup: memcg: net: do not
> > associate sock with unrelated cgroup") and commit d752a4986532
> > ("net: memcg: late association of sock to memcg").
> >
> > Let's add a new hook for BPF_PROG_TYPE_CGROUP_SOCK in
> > __inet_accept().
> >
> > This hook does not fail by not supporting bpf_set_retval().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> And similarly to [0], doing it in sock_ops's BPF_SOCK_OPS_PASSIVE_ESTABLI=
SHED_CB
> is not an option because you want to run in the process context instead
> of softirq?

Yes, I considered the hook but ended up adding a new one
in accept(), only when we know sk_memcg is the intended one.


>
> 0: https://lore.kernel.org/netdev/daa73a77-3366-45b4-a770-fde87d4f50d8@li=
nux.dev/

