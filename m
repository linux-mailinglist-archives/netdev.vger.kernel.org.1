Return-Path: <netdev+bounces-217529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB9B38FBC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6103A160AA6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5C157E99;
	Thu, 28 Aug 2025 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUvc3an0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319AB665
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340768; cv=none; b=O5Hu+EpEOr4U9k2GX6XNgH4exfpH7oxKSJN4f2wA3UmmnxHMJHjnt+1C5N3ZKNPqXlUd1uEf9tUGJMVEhHnRgEzifnUWZZPxY8cc4jyTO4DpWvB6vwoGcdVdoO/i3x1hGa0cmIzCOAst182KdP3YZGN64rex3bGa8ETjEfJ8ZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340768; c=relaxed/simple;
	bh=fYriN/eS/BJvu5nAuooQ51vzV9rumoWWO8rvVfFGc/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1ZeEEmbWHkaDEe61MVxR56kIAtGwXxpenC+qAVdNydaLkZ2UZSKRlbaLnzutsjc96iOGQuJaOGN75J9ErgUmD0orvqh0yN7aLAYQnFNhgsjGX8GEl9LvKSMArfAMIU8zptD7P/++t9qEkZ/pCkdeyBH7eUaT7egGPFd6i9YfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUvc3an0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244580523a0so4028955ad.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340767; x=1756945567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u20ZRFzbGoAnlWu6SqOAzaVBCg+i0tR6sdtsICKHTkY=;
        b=cUvc3an0dfy9PNjkCcK2Xb2S96SI5qNqjbPRuU050Lp7HJSQgnA299mFtOEOsSUNjC
         XC7/hoL6CYqvNRmkzzNxv5g3WP+G3KytlaZVvzmE65OzyVGucrANTKY2dlcAAZkhpRxG
         uTYG7yzzoa799j6JVcTyJhv4xi3XQINstIbCE/+lSQSs85Bs9QEhD65hXISOk5ogUjG3
         0qYNtm4UqwQJg/zxkgsBZ+vTNL4T3eg/m5pA3Bw3TarBtast/zBTZCk/wOZrRym7Q4JU
         JKFf3vzhO37py9BqeQzf9E9V7ofMO027e1XxSbsVNx57JL64hYvhr+GQ2OTTp9WS8qfN
         YcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340767; x=1756945567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u20ZRFzbGoAnlWu6SqOAzaVBCg+i0tR6sdtsICKHTkY=;
        b=GRTjFOZRjryHKX+qZvdL2INWbMRMG0UYBzpjWfglA5nLeZNiHhmUGCeJltGkQtikUO
         2GTqL3Xgei5a7N9HdOEWmuAz2rirkEbfljfs6fMUEnlKycDkj6XJ2cbHB3EoIq3mSVYE
         WmG9uw3EBL+kqQQe3TvsMtwMGA9RRD/QeKqPyvFY5+Yn2xXfoBud6it6NrP6m3bt4Xe6
         JyuvCvm+FeaeTPUFMnnv4H/12jh9SPgWCpL6Fid7eK6ZheKzadTLqPCEmJmTafaDlw1Z
         M1b3D8+txHt+WDhiFlh28uncaoe2To9I0RzCFSrG/+EpGjw37xEki19BZpLQ9ZngcQji
         e4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ94PzK4gWns3LUlw9COdja/JPVmqrMB8RK02phfZNpjBNQ3Sv55ppzLy1Ke0X8pDfr7N8tr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJg3GL/ZGwZzhLYO/KYct3fDmFMY0DB3mKbS9/d88jjInnFvmI
	m6VWxNuqyLcu+CQPst62apBwv8WJWXCWrhiqQ2YURonBYLcwwXNZLPDJlBTbJSMF4SkiFH9yywD
	mMw65tw/iqkOPI2p+ftz1e3G40BF/rb+qCvgs/ERhQBTHrKrv1/ZMygW5
X-Gm-Gg: ASbGncvGGRsQOoC1x4cVqlGXwvXCKmIj4ZSjQQByNmAzQCguOe2zpAwInQFt4hTe7ub
	Z8r6hu0fBpvAdkNcB2yzOzABir7eYI6qR+Hojha68d7ZcYy4efPnDXUKKWGgE6eHwGOQsHW+fS8
	Z0mQZ4sN+raFPU4xuSB8sosAoS6IdWE8BhHqS2HZHp/1g2juSwJyW61+zuysC4Hvaw7r/j4ZSwf
	2WvCfrIPRgtKPV0nzMebCQR766yYtnT+GsY5mBRJeDS7HqNcXO0BlA0o2NAlTvk9U0tlrJl4Y56
	0drW4gFiNdCdaA==
X-Google-Smtp-Source: AGHT+IFvFyq9wJjV0E4vHzXrSBBTGOb3f5sWbfYRnIfXeaWI7huFj1R36mzc+ccaW7Be4EzbQHxY2eBWkT4E9d+3MBw=
X-Received: by 2002:a17:902:e786:b0:246:80b1:8c87 with SMTP id
 d9443c01a7336-24680b190famr210695215ad.43.1756340766628; Wed, 27 Aug 2025
 17:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-6-kuniyu@google.com>
 <ab07a893-d27d-447e-931a-6014f55132d2@linux.dev>
In-Reply-To: <ab07a893-d27d-447e-931a-6014f55132d2@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 17:25:53 -0700
X-Gm-Features: Ac12FXzHYDoUPkUg-gwnLJeJ9P7Rhlz_1XDQC5p0y_VYo33-H5adIDSO4FZUCew
Message-ID: <CAAVpQUCNVfXek9cO5ZO579=pWXV5aqRjseNxdRVE-Yp8pcCZZw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> > The test does the following for IPv4/IPv6 x TCP/UDP sockets
> > with/without BPF prog.
> >
> >    1. Create socket pairs
> >    2. Send a bunch of data that require more than 1000 pages
> >    3. Read memory_allocated from the 3rd column in /proc/net/protocols
> >    4. Check if unread data is charged to memory_allocated
> >
> > If BPF prog is attached, memory_allocated should not be changed,
> > but we allow a small error (up to 10 pages) in case the test is ran
> > concurrently with other tests using TCP/UDP sockets.
>
> hmm... there is a "./test_progs -j" that multiple tests can run in parall=
el.
> Will it be reliable enough or it needs the "serial_" prefix in the test
> function?

Didn't know the prefix, sounds useful :)


> Beside, the test took ~20s in my qemu. Is it feasible to shorten the test=
?

Same on my qemu setup, and I think it's feasible with serial_.

Currently, the test consumes 2000> pages for each TCP/UDP
case, but this was just to make it more reliable on uncertain env.

