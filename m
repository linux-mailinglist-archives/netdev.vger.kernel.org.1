Return-Path: <netdev+bounces-97538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8308CBFCC
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F31C220C2
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C3824AC;
	Wed, 22 May 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvZfuPm2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6229823B0
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376045; cv=none; b=U4ycxr+DJqokiU/cLVchsw7kaZeI27xgZAzsFrQitUNrdBe7ygaeSOGZtqwcVy1r7o4LFsfMeBdGbMRdiWw0FH1XBOh+jGVG0cDPeGoRhGbfON+Rq7LQ8bWWI2oDyIx8DSTpyNX1RyfZ33tMMz04GvCAtrUckdx9iF7bIn2yjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376045; c=relaxed/simple;
	bh=qMS6G/yfZjb8tuP9M4KUhyeRB0d2t06QcWlU6rm9dxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbbeYoOdm7Q0ZR/gUiS0HHhD1jGRSmGSUNWwxM2Z6JpBArLfshpVgQyaUvkgSTfj7qxSFx/TLsUdlnz6vpR6oHjGCDzAytPPROOFHcJ6qHyN/7Hqy1flkvj8mrJMBrpQPnlF2HjpQzYI+YQVCrIhVZxc6yTjZgOkrp7Yj64YzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvZfuPm2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso12037a12.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716376042; x=1716980842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FVrQvkgEZQHDL6tSfAA3wG+/JfWS6wVPJfXE4qA+JQ=;
        b=UvZfuPm2AMYw4CSh8MNL3Dcw3Ly2ab3+hVEt8siQdmv1O4nhis+IHaWA1sIqLBECLX
         eaalkBrONC+31YtXzzgnEq41Xfi4LmGjHipfHDiRTYmox4iYr5v90gyG7OVfkNeVj//2
         vqyvsk4mQh26og9cbaB7zgOgpfuFp2Q8ebh3WXM1tU5SIi/CLh2yNMO7GDBdht9uSslP
         d0mnBu8MLxgmU2n/KvGkcKZKfr/nlENJ74wltWuTlxxjfbH6xM7W5DecFlKqgEtP9e2V
         APKbthhQlvfBJafL3kB3zkp15ASj49FvM1yMJeSKCttu3mhNpysUBhXAOBpbD4aL4Px+
         cdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376042; x=1716980842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FVrQvkgEZQHDL6tSfAA3wG+/JfWS6wVPJfXE4qA+JQ=;
        b=paIrG5ax80hN8PbXms8XvTfew3saOBDuPTxfO7mnoXOg2Sizxqcl10P6xcjHKQvP41
         SMILVEhA+KA8r8UuhLKlM2O+Ux369hY+nWyRwbApqs6lxm2z+W6oIbrDSprKJ9p9Df9Z
         0ygyb84LjRGUC45sHNLOT37qoowu1DfzpLWpx/ctO65tnw9rRd1WgVpav0EzeOoCFyIs
         f1gW8I+Kso0QXwFvpjhKBzTIZMldloIRveRRW/NlABDGtFr8LAIdYRNfrN2FQQBxJ5J/
         cuvB5e36JTsQxfum5BAwxx14pZBVExjFmXdLH/W+B+ItdZ91Bm3ts0ZlVIbXNSJJmXKt
         s+cg==
X-Forwarded-Encrypted: i=1; AJvYcCWQmd8oyxmuQEWahsWeVBMgvwwFV0XFeA9FibfwTIUZz460DwDxQyR23Pcgx+RzEwSI1XWH6TOd6ISVbzFpjuwr/0+mVCPV
X-Gm-Message-State: AOJu0Yywsvn+nFC9fU4i+71/tAIi/qHJ523AdGntxdbDh+piR9hB5M3l
	yJiBGKN5iQE5x6+bzGPrV3UOeDkNOMnk3UPg/pyP1SbWtkIKtxptH9cvG43Cs2NS+Lov0yO1tVt
	cjj/XlQhT620fJT269HMJZ+ttENVX1jR8Vbpj
X-Google-Smtp-Source: AGHT+IEz0J2W8ruyCIYhKq5GUFLoChk6HFjs+dRb9Elzu/IDRaRjWvMHsuVD+FOB7W6fi60j7SuJ6F0Z+r8p9anrBrk=
X-Received: by 2002:a05:6402:2710:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-57832313f54mr123865a12.7.1716376041609; Wed, 22 May 2024
 04:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513100246.85173-1-jianbol@nvidia.com> <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com> <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
In-Reply-To: <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 May 2024 13:06:53 +0200
Message-ID: <CANn89i+m+S-fP8K=Cw-e_5+U9DRUC2CYnep=dv6t25RkOctuJQ@mail.gmail.com>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "fw@strlen.de" <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:34=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Mon, May 20, 2024 at 10:06:24AM +0000, Jianbo Liu wrote:
> > On Tue, 2024-05-14 at 10:51 +0200, Eric Dumazet wrote:
> > > On Tue, May 14, 2024 at 9:37=E2=80=AFAM Jianbo Liu <jianbol@nvidia.co=
m>
> > > wrote:
> > > >
> > > > On Mon, 2024-05-13 at 12:29 +0200, Eric Dumazet wrote:
> > > > > On Mon, May 13, 2024 at 12:04=E2=80=AFPM Jianbo Liu <jianbol@nvid=
ia.com>
> > > > > wrote:
> > > > >
> > > > >
> > ...
> > > > > This attribution and patch seem wrong. Also you should CC XFRM
> > > > > maintainers.
> > > > >
> > > > > Before being freed from tcp_recvmsg() path, packets can sit in
> > > > > TCP
> > > > > receive queues for arbitrary amounts of time.
> > > > >
> > > > > secpath_reset() should be called much earlier than in the code
> > > > > you
> > > > > tried to change.
> > > >
> > > > Yes, this also fixed the issue if I moved secpatch_reset() before
> > > > tcp_v4_do_rcv().
> > > >
> > > > --- a/net/ipv4/tcp_ipv4.c
> > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > @@ -2314,6 +2314,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > >         tcp_v4_fill_cb(skb, iph, th);
> > > >
> > > >         skb->dev =3D NULL;
> > > > +       secpath_reset(skb);
> > > >
> > > >         if (sk->sk_state =3D=3D TCP_LISTEN) {
> > > >                 ret =3D tcp_v4_do_rcv(sk, skb);
> > > >
> > > > Do you want me to send v2, or push a new one if you agree with this
> > > > change?
> > >
> > > That would only care about TCP and IPv4.
> > >
> > > I think we need a full fix, not a partial work around to an immediate
> > > problem.
> > >
> > > Can we have some feedback from Steffen, I  wonder if we missed
> > > something really obvious.
> > >
> > > It is hard to believe this has been broken for such  a long time.
> >
> > Could you please give me some suggestions?
> > Should I add new function to reset both ct and secpath, and replace
> > nf_reset_ct() where necessary on receive flow?
>
> Maybe we should directly remove the device from the xfrm_state
> when the decice goes down, this should catch all the cases.
>
> I think about something like this (untested) patch:
>
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0c306473a79d..ba402275ab57 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -867,7 +867,11 @@ int xfrm_dev_state_flush(struct net *net, struct net=
_device *dev, bool task_vali
>                                 xfrm_state_hold(x);
>                                 spin_unlock_bh(&net->xfrm.xfrm_state_lock=
);
>
> -                               err =3D xfrm_state_delete(x);
> +                               spin_lock_bh(&x->lock);
> +                               err =3D __xfrm_state_delete(x);
> +                               xfrm_dev_state_free(x);
> +                               spin_unlock_bh(&x->lock);
> +
>                                 xfrm_audit_state_delete(x, err ? 0 : 1,
>                                                         task_valid);
>                                 xfrm_state_put(x);
>
> The secpath is still attached to all skbs, but the hang on device
> unregister should go away.

Seems fine, but I wonder if we need some READ_ONCE(xso->dev) to avoid
races then ?

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 77ebf5bcf0b901b7b70875b3ccb5cead14ab1602..55eb5898e9a4263048b70d5a0d5=
dc274ab784c0f
100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1950,9 +1950,10 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb,
struct xfrm_state *x);
 static inline void xfrm_dev_state_advance_esn(struct xfrm_state *x)
 {
        struct xfrm_dev_offload *xso =3D &x->xso;
+       struct net_device *dev =3D READ_ONCE(xso->dev);

-       if (xso->dev && xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn)
-               xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
+       if (dev && dev->xfrmdev_ops->xdo_dev_state_advance_esn)
+               dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
 }

 static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
@@ -1976,20 +1977,21 @@ static inline bool xfrm_dst_offload_ok(struct
dst_entry *dst)
 static inline void xfrm_dev_state_delete(struct xfrm_state *x)
 {
        struct xfrm_dev_offload *xso =3D &x->xso;
+       struct net_device *dev =3D READ_ONCE(xso->dev);

-       if (xso->dev)
-               xso->dev->xfrmdev_ops->xdo_dev_state_delete(x);
+       if (dev)
+               dev->xfrmdev_ops->xdo_dev_state_delete(x);
 }

 static inline void xfrm_dev_state_free(struct xfrm_state *x)
 {
        struct xfrm_dev_offload *xso =3D &x->xso;
-       struct net_device *dev =3D xso->dev;
+       struct net_device *dev =3D READ_ONCE(xso->dev);

        if (dev && dev->xfrmdev_ops) {
                if (dev->xfrmdev_ops->xdo_dev_state_free)
                        dev->xfrmdev_ops->xdo_dev_state_free(x);
-               xso->dev =3D NULL;
+               WRITE_ONCE(xso->dev, NULL);
                xso->type =3D XFRM_DEV_OFFLOAD_UNSPECIFIED;
                netdev_put(dev, &xso->dev_tracker);
        }

