Return-Path: <netdev+bounces-237078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E9C446C3
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 21:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31140188A9F6
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CF1D63EF;
	Sun,  9 Nov 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhPEyOep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7D18C008
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720166; cv=none; b=AyIBg64Bj96bQJ0VRdQphK3Kq0uZSF/dZLCk52z59gjfrgzAqgpD8xKl8UzOrRVzgNPsGmVbONfXR9vfYZyBbZpxSTxLSDWfO8dRuC1wUBtz3A+a6cVJozkVGfiMrbnEzxu5EZ+O67toyuM6FkuS3pUwBVdeQyvH8rNuMgT15Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720166; c=relaxed/simple;
	bh=DKWhTEfbF1u7VaeY598VubNvX4U3TuN99wDUdi0Go58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0MUXk8d8XJuL9SxZwE8kM0tMeyPOVY0/lQNhlhKDl3oG0MIXrSOLkAZBAYvu1uGiFZG0/GjHEF1iBNfYlXrPPULKofg1gUFCcMcl3yxPsJmsvE7XgjuN4xipfZLKKkgctY+6SK9saz4KEne1H0wznV7aAndI6CS7PqaMzxutAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhPEyOep; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed65fa5e50so12293891cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 12:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762720164; x=1763324964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owVNhf2xPKoAgisWdLVWtHH6ar6p+j9QE0hetXNjQDg=;
        b=hhPEyOepF1VwZk04g+SVoaTWThqekZCKHJM5wuk/ZnFdbdi8LaBXWcmGw5ligEmkPk
         l//gH0v2KXXvPXIxJT9pInX3pz0LcgQTGVTPzvx5KZom8s/3RrAXVPkiQBhes+f1a4Zi
         AnQIWt9SrZgk0k8r4ouXf0EzdsdpgXKHxfvuFc8tJijNm6Ptf2uVuV8V5xjRNdOk4LeI
         SnP2BXqzlsWgasdSBOGxNctOnW/tC3jl0t+tLKG/gWobxKZlap/rtDHBVmYpGYAQmtmf
         IkwxyvUvOAUpG/OhOwGIACKL3k363TPoBov/+wtuAmvii0pMgVvlZhefij+rBP+gSLJh
         7fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762720164; x=1763324964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owVNhf2xPKoAgisWdLVWtHH6ar6p+j9QE0hetXNjQDg=;
        b=HxdRzjqhEPATrxGivgspObZ6ayC3+suTar2HZFVX6xHtyYOYXAyXD1bCSS9x/FgUad
         FR8oBNBnrLJ61yitC3aQZeSr2MeqNCTodX/O5PKaH3o6//3rMYFp5Cds10PgVQlErJAq
         Z950mbsNJ3xL9kKUO13hKub3Vlwy6kewRIDbm7EmmogNqPnUOjvFsGrPBjAMEnCrivN9
         cT8vKY7EkubkLWFzkSJnTPGEeael84utQL3BoUvAhtr+rgJsgA3X0rjNNJR/018DFc1V
         4eSkjqvA4GgaLbRmEHvQOSTXKSebIZuX3wTM/DumojsPMnymVzqNxPIo43dMdL2n+mKX
         10Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV7xH6/b+QeQ77xKVENofLlmoLM8joAY3FsLjbaJzBp74Nn24xl/knO8KW5DUxNJ6zP6MUPXrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHxMushxcFEfDn7GWcxjmOb0gR5yqFtgXqUKnT9OQq43S16Fg
	HaoIb8rHYYy2BJTmu8QdBc0PgaxFtxpmc5TIUUnoJT7CYBxE+W+CfGimuR5v6pjkeK6+JUz4+LU
	jK4Oe4274CaK34FGIN5GPrcxQ2FmMyFS2cGPrmJ56
X-Gm-Gg: ASbGncud8/vjMHgt3RIfUVfRHT4twuknqRc08nWTvqqt2IcLKFKS1lQ/xOTNd4MSL03
	Kl0l+ZWKPndpFa3MAbZl6lYcAQIUUYlo+pjFDhndfqcbj6mXN3eevvNb8cKO2TfAzlrwXZCEGoP
	ecb9l+DfuldSKg1CNCdmFH8fbXEG9+nCW795VDuMcgd2liLRMch2hpZkokOOUpoxB9kG+DGnP5L
	rWQjHqVZmeLdck7eYgCCg9sYwSSRghS415MsqoxfTSNXRDfhQGYB85Zo7NCWA==
X-Google-Smtp-Source: AGHT+IG7S4o51xpVOQ4SI92c1LdCGlCN8lb9TEiGKXMzblk4ptEHUKqly+NkldHFroI0rUwEmQtf2mLY1Ym5gtcpJMU=
X-Received: by 2002:ac8:5751:0:b0:4ec:eea3:41fa with SMTP id
 d75a77b69052e-4eda4fe0032mr63948201cf.77.1762720163534; Sun, 09 Nov 2025
 12:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk> <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk> <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com> <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
In-Reply-To: <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 12:29:12 -0800
X-Gm-Features: AWmQ_bmOtIxTG6VEPVNFYUPU0X8nkY35d-tJHQbXmn1q20bIWEKxwdGtvF2pjws
Message-ID: <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 12:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>

> I think the issue is really about TCQ_F_ONETXQUEUE :

dequeue_skb() can only dequeue 8 packets at a time, then has to
release the qdisc spinlock.

>
>
> Perhaps we should not accept q->limit packets in the ll_list, but a
> much smaller limit.

I will test something like this

diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc6a157046f31b3dd343a59ae192ab..e4187e2ca6324781216c073de2e=
c20626119327a
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4185,8 +4185,12 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
        first_n =3D READ_ONCE(q->defer_list.first);
        do {
                if (first_n && !defer_count) {
+                       unsigned long total;
+
                        defer_count =3D atomic_long_inc_return(&q->defer_co=
unt);
-                       if (unlikely(defer_count > q->limit)) {
+                       total =3D defer_count + READ_ONCE(q->q.qlen);
+
+                       if (unlikely(defer_count > 256 || total >
READ_ONCE(q->limit))) {
                                kfree_skb_reason(skb,
SKB_DROP_REASON_QDISC_DROP);
                                return NET_XMIT_DROP;
                        }

