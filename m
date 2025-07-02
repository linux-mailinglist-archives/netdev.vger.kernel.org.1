Return-Path: <netdev+bounces-203227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB3BAF0D6D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E15B1C24001
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315B2356DB;
	Wed,  2 Jul 2025 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Tw4tUHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101E2343AF
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443386; cv=none; b=pCFIz0KY0WMJSct9QjkDRtaxT4pwNEnRzppUWH1bTf0BFC+wS+NvzGz9tdyaN4o5BJYnbBZyyyP7Do5Ft0ndqb48GVtc/Q1yxP6grPEgtVjuUBRqr+Opmcwnj46HrSRf0Rkt71lPBdaK2qOWu40PQ6CWm7NthnSZZSH03wK88oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443386; c=relaxed/simple;
	bh=k5rRe3xa5VlcBs3acQkW7OBTqBGq71i2uzhF8vuv0ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHiZICxOETL4J3CGdgIVPAUZL3tKpJFszuOagMzifC5f6emAT0fBq8kZuqvH6VVuzbH6r9EyUstswq/8fsci5WlvVfgbbXyVKp4xwlPJvnOG/1JHVWmM36htP5dZhPGleABPU6vRIpGIms0C+YFQ/u1SrmIT9IaXQksFvjFN+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Tw4tUHH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a8244e897fso29291171cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751443383; x=1752048183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBZuk3H+46fxs/MVm+reaCZ2EIrEk1+0jJRknjvGIxs=;
        b=1Tw4tUHHlmyn9nBgfvABW/B2HXHpVP1/UC84idzP+0uDc3LlsBmqRu6jVycDjPR95s
         FrAY/iXCfJ7zzdawLEiUmMhKiZpci/AoIAe2BQGaOLGHTVeexdGB896HJlmS6hB9JO2t
         lAYFbAeV0B0fm1JCHm+3lLE9owByQZ5ttzgni9f/weDNeqlBxxGi7mkkNMEn+229sO6Q
         fF2nEh9GR13uhGcxzsN8oFlc2S6/20+xU5BXQqmaTZDATqfL1AdSsu3+ZKDRGVed2/mO
         +D9Y6JdqW13VVRKyCZLZH90ZSdQGfsmCHRq9OCAbt0xCpaY19q4OKlUkr3SJcwYwNafe
         +Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443383; x=1752048183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBZuk3H+46fxs/MVm+reaCZ2EIrEk1+0jJRknjvGIxs=;
        b=I2+I+9EY0VLtdhWDZn1Ys1/cBAg81SCRnUj2JhzH4tgErQJ4oOAJvqAvO9W8xH2SBv
         45HsYBYdNk8bLiUxlyvanIBOHrF+l3gip1apvVGECr9hrVL/tYqWwvDFmSVClfk+zvN4
         3K8R2VZylSnzYbhOu0OWW9aGfgQRcOMmIxao0+GFBOZkevCjByNXVM3ebo8qiK8CyWAj
         amFHDvJX+E80ULh9Dku3crx5SDwkPm7T7nCtSZaUjUBi1ex66Enlgo4XtLYvYE+zjuNm
         ZcjzsMTlbac4DVuq7A0NoH1tl67Et5LFJioBwyKK/XJaGCPwk6UAMZ2EndXTlXsUlKdO
         xSlA==
X-Forwarded-Encrypted: i=1; AJvYcCWyi5qv4IBqNvrxRco2B6JMmOrsfmbGAaVTVwHbg/83PbitML94nqlPba9ln8Nt64nnfuw+apY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjUa5gpcPtVmV/EM4zjGFcVIbj7uhv1VncnQHN7UXNoTSnmgT
	wIVWBmSC0b4OYkzDSOdBibCvTlmyLTAk969jWWCJDDzR6cGcrHo3GJ/tc5OUVllHBGCw5Bkl68g
	QE+aJJUyRqzqGMPCiD09WXvW3YeUr9IdefvtRl27c
X-Gm-Gg: ASbGnctHnmUgb1nTi6V4d6LsXHteSKXXc5SSfNOGQHDb0XCgcibUCvsECsL99a/Eo/J
	YmABEulx15/+3VHidBcN4a7H0X+KX10SL/TfiKuubveD83ILEdltx75KVbOTHbvMTolgrclYW8c
	s1vJYLe18UGafOk3OTMostH86pQGU0FshcjvmvvdZWMSg=
X-Google-Smtp-Source: AGHT+IEWbarWvhofM/Pc12nISnSJw5RsRYduWp+QpexvsV9hogHcgiiuS7H42Qn0RZOWso9jMo9yKjhsiKGhVcygTSE=
X-Received: by 2002:a05:622a:28c:b0:494:75f7:b0fa with SMTP id
 d75a77b69052e-4a976a6ef2dmr36464411cf.41.1751443383082; Wed, 02 Jul 2025
 01:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702020437.703698-1-kuniyu@google.com> <20250702020437.703698-2-kuniyu@google.com>
In-Reply-To: <20250702020437.703698-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 01:02:51 -0700
X-Gm-Features: Ac12FXzPFJ3gtxBFYVfZfFoTLtrIri7P5W-UntjWVFvR3CMrQaKtvPUYFwIjZ6I
Message-ID: <CANn89iKmA41ERK2VFScyrJ7PNNwqH4VBK9kpzNgxO3oFTRq=mQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] atm: clip: Fix infinite recursive call of clip_push().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 7:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> syzbot reported the splat below. [0]
>
> This happens if we call ioctl(ATMARP_MKIP) more than once.
>
> During the first call, clip_mkip() sets clip_push() to vcc->push(),
> and the second call copies it to clip_vcc->old_push().
>
> Later, when a NULL skb is passed to clip_push(), it calls
> clip_vcc->old_push(), triggering the infinite recursion.
>
> Let's prevent the second ioctl(ATMARP_MKIP) by checking
> vcc->user_back, which is allocated by the first call as clip_vcc.
>
> Note also that we use lock_sock() to prevent racy calls.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2371d94d248d126c1eb1
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/atm/clip.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/atm/clip.c b/net/atm/clip.c
> index b234dc3bcb0d..250b3c7f4305 100644
> --- a/net/atm/clip.c
> +++ b/net/atm/clip.c
> @@ -417,6 +417,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout=
)
>
>         if (!vcc->push)
>                 return -EBADFD;
> +       if (vcc->user_back)
> +               return -EINVAL;
>         clip_vcc =3D kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
>         if (!clip_vcc)
>                 return -ENOMEM;
> @@ -655,6 +657,7 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
>  static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned lo=
ng arg)
>  {
>         struct atm_vcc *vcc =3D ATM_SD(sock);
> +       struct sock *sk =3D sock->sk;
>         int err =3D 0;
>
>         switch (cmd) {
> @@ -682,7 +685,9 @@ static int clip_ioctl(struct socket *sock, unsigned i=
nt cmd, unsigned long arg)
>                 }
>                 break;
>         case ATMARP_MKIP:
> +               lock_sock(sk);
>                 err =3D clip_mkip(vcc, arg);
> +               release_sock(sk);

This will still race with atm_init_atmarp(), which (ab)uses RTNL ?

>                 break;
>         case ATMARP_SETENTRY:
>                 err =3D clip_setentry(vcc, (__force __be32)arg);
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

