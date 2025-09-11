Return-Path: <netdev+bounces-221978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0FB52863
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F42C3A51E0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAF24BD04;
	Thu, 11 Sep 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJxpx45o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3623C50F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570252; cv=none; b=blqTfwwz5UQ2XDcpnnOxApl2yNbV/UddLsxgfg48JaIFXMSc1HtVyLaKzd8SBtC+jVZLQ7MFmkn9U83/jazm4ttl5Qw7u9Y4ioP4l63z+Iyu+KbV5y5p+i8SRpvNTo6viZUovF1awTSEBwMc39yF7vA1pdc2c6gKfo9UiUv4yIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570252; c=relaxed/simple;
	bh=rRyI6oJe0qy6oG85tAVoG1vG5IpnvSRYL5Bm6KfvT0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdVLTqHdn6mxYSI6NiBpW3438CqjhPH/Q+RwAzebu6oISXGWDbBA61Sx4f9vf9JHuIzCSZh0XReq518O/3OUyh2IgDmrNK3J9p4pQ3r1cbCUt4fWDG4GmQR/jVk7pRsr6DmhijpluZjQPGsY4jUHN9kfKwzqrY8oZ5uRqE8Ru/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJxpx45o; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b3d3f6360cso4008401cf.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757570249; x=1758175049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7y26fxCIN6WgsEPqiJXZr5loXTb/Z8pyfPugoj/ejg=;
        b=qJxpx45oFl42Y3LFslR8o5e5gvYmNeohgOFoNVgK3cPL2JahhacvAyDb8PcXgbDiyS
         gU1pEX7eUi2XZmOW5+1pCiKHatoApjeMolBORQlzIgQn0OWRBOwqTaDY9f3ItQP4F476
         Zpw1gb9vkMyi/rCr8ZhzMaN4jGUqZkExuBtdlW/ITsbWd59LiroY3g9zF5hE6pWz8Dj4
         FIwk8RZzodqy5J0uLBApFl2NhKgChSmAdjEwtSSY6rVcDs233N93w5w5FF2XNwy6gjR/
         eFDC68h5GG0NNo9JmMgqsuCKmKPWW/FjXH5mkymCRDRUdD2aqOL3AlGioik7YkbMzR2S
         0ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757570249; x=1758175049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7y26fxCIN6WgsEPqiJXZr5loXTb/Z8pyfPugoj/ejg=;
        b=FKjTQFk8LijleZbAGQKOFRyuoQQLSifYJmHZ9nihf6v1gpXdJKqBjWXqEv4hWnzEd5
         nI39AdcRWa3BXnfi0VxtblBPihy+R4HjJFjtVN5GstgOih2T4M7I+nV4mvzHMPebN+4i
         F2aa7Vaz6+HtO3ZX7TFd3l2qxGOMLZBIHSpCNbREwGfgvc9QWM9vBAQKyv5CdnEprFe7
         ZmFLX/rf1LKwI1R+S0U3rhJkIOYm5MCvot0E5irj/edkG9mBKPHRqyvUBO5GZiCmWiLG
         X5LYMWlrTwG+wiiB2iXqEZjT0arkqCEaUYTmk2gYevOB5MsA5m5IQbuSKj0x1zeMrDIK
         slsw==
X-Forwarded-Encrypted: i=1; AJvYcCWv4/mkJNNEGqfTs2jpQmt1SIHzg2BIq/7gaclzfPCj3AVedFIG9DQJeQk9sScSIvK05iXc9q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyH62DkQowv9BIyXSC7ciTwqq8XCc6r3AxU6+k+BTxPaSJ7Gv
	yv7nUD5gPOYAAHlq+UwwmnfrEQPCP+X1YJ0q7zPj87sy4s+rA1KG1HWeu70gg4Iy6202Hr8pUDh
	x9oE1pcfCLpHK5B2NkSKQ5gSHcM0cgPdlT90dDANV
X-Gm-Gg: ASbGncuIJgvnGBPA8fgCE8nhW6gbfxI7v0AXKi9lV7a+3/e/o9rHdQQs5gS+DfCvyOs
	FSXWd0axFmnsXSFaeVB9TO3SaJ2Ez15B/TO+gtN9exzMdGOrohOXD6kpGGdXCT1wjXFXH+Zf3wm
	wWrPDZbPZr8uaK5lGhF0Fje2EXOKNe5qeuytpYEv5Adm2APPCERabiDeDqxJNUWuGYJwA8cIlC8
	PIEQUWpDHytZI5ui+qOR2Km
X-Google-Smtp-Source: AGHT+IFYzGwOyevU2pEJ0UK7RsysYbKUXVYozwcNc3m0go7IAH36vixFfL8i/MRaYq7WCf3TqPPVzt4aivDNFvnmdf8=
X-Received: by 2002:a05:622a:558e:b0:4b6:32eb:413f with SMTP id
 d75a77b69052e-4b632eb473fmr37858111cf.24.1757570249040; Wed, 10 Sep 2025
 22:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-5-kuniyu@google.com>
In-Reply-To: <20250911030620.1284754-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Sep 2025 22:57:17 -0700
X-Gm-Features: Ac12FXwK3sTrpBG-2Ic6X98ReswaPcvkRM6UOllCYCDpZskYbOwb0qrJBsNoWvE
Message-ID: <CANn89iK7pyiZV6gUWiqYMdWn1iZfOQM4De4=VxrWYBa=wrPESw@mail.gmail.com>
Subject: Re: [PATCH v1 net 4/8] smc: Use sk_dst_dev_rcu() in smc_clc_prfx_match().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> smc_clc_prfx_match() is called from smc_listen_work() and
> not under RCU nor RTNL.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use sk_dst_dev_rcu().
>
> Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> Cc: Dust Li <dust.li@linux.alibaba.com>
> Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Cc: Tony Lu <tonylu@linux.alibaba.com>
> Cc: Wen Gu <guwen@linux.alibaba.com>
> Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> ---
>  net/smc/smc_clc.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 9aa1d75d3079..5b4fe2c22879 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -655,26 +655,24 @@ static int smc_clc_prfx_match6_rcu(struct net_devic=
e *dev,
>  int smc_clc_prfx_match(struct socket *clcsock,
>                        struct smc_clc_msg_proposal_prefix *prop)
>  {
> -       struct dst_entry *dst =3D sk_dst_get(clcsock->sk);
> +       struct net_device *dev;
>         int rc;
>
> -       if (!dst) {
> -               rc =3D -ENOTCONN;
> -               goto out;
> -       }
> -       if (!dst->dev) {
> +       rcu_read_lock();
> +
> +       dev =3D sk_dst_dev_rcu(clcsock->sk);
> +       if (!dev) {
>                 rc =3D -ENODEV;
> -               goto out_rel;
> +               goto out;
>         }
> -       rcu_read_lock();
> +
>         if (!prop->ipv6_prefixes_cnt)
> -               rc =3D smc_clc_prfx_match4_rcu(dst->dev, prop);
> +               rc =3D smc_clc_prfx_match4_rcu(dev, prop);
>         else
> -               rc =3D smc_clc_prfx_match6_rcu(dst->dev, prop);
> -       rcu_read_unlock();
> -out_rel:
> -       dst_release(dst);
> +               rc =3D smc_clc_prfx_match6_rcu(dev, prop);
>  out:
> +       rcu_read_unlock();
> +
>         return rc;
>  }

I had in my tree a smaller patch without a new helper. I am not
convinced we need another one yet.

