Return-Path: <netdev+bounces-163577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62733A2AC6A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE83A5B00
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698DA1EDA1A;
	Thu,  6 Feb 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFyJWy++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895541EDA19
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855505; cv=none; b=IGiCA8PZySxRr4FSG2i08JavBBpGfjvyEXlcwN0iTPicQMZ2Yg6Cr+oAvtbGhmh58v4hAXJ47tXu36rbzpnrzBhb1HrNqG2sVRflIAyhQvJiXrO5lqouhmgadJOhIJqCVn8ZVzX1VF3bHMkh8aNfFxYv6mp7/7gTjqe7anBj6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855505; c=relaxed/simple;
	bh=PMLesM+sPegvoYcCev5jpE3NIVmJ3+iUSGjK6zOUD0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRelUBkyacrVEI7wUAKJI9ciW0ESNqkK6fjWEIIecNFEYE8Q0vSXdxHQo+9ciAuo8OILrg5SS6CneB4XoHvxRz3FektGdTuKsp1c5fMDw+qMOcukH3lBm6oF40y8eq7F2nbiIVvJDNC935KOhtHqOeMjBFa4SJUEiGYGya4K1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFyJWy++; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso606697a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738855502; x=1739460302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KdOMKcFzgnDfOmgNKtWwp/r3hPNm7tMk0Q2fozSuNc=;
        b=VFyJWy++bm+tvZ5jjRtBVWFujSCEJv/QgOBL4UCk0n+tN6Wuytpwuo6xhyWiyQ0a0u
         n8mk1ulZjwBca/zIBjjSBp2HG2z+5/JWluXFs+HQ1iRWTihhlawnZh1j1Ip32S+qrOHV
         rL1S/Z4vSJWYsJhz0fSoifCDC5NzNM6wxYIwhqIFUumNJyDLdLqzc4zd6jSlH4vRn43l
         uyDKAZ441ftQTG7KxSTo5SDiPptKauM3/5VKcOhziHKNj7ExsGzdhWFMkCpSfUKUIyF3
         5KhC8I8U7b9UjXQc9BaHaDFHeypiKx+G1V3u+s5l5bkG2iGUbOmagB3PwOPUnU/6S+Uq
         NK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855502; x=1739460302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KdOMKcFzgnDfOmgNKtWwp/r3hPNm7tMk0Q2fozSuNc=;
        b=JXS+D8kouPXD2Akjmls0U8srdSf3zKwVWr4WcGvldF7FgM/g5TxRxUC98P7aN3BGIP
         u4IFj787wLAnZxO4F3WlS95MsVQB64d0W/jLxBkMXyP6jq5JT8I48jjNwB2E6IN92qp2
         eHIPxipfKnIPxgcsW57wbEGG5Ul+juDbrYCZIMSx+Tsmvv220vNwsP07B1azTG0Q19h/
         lk+RL4xifAOBaFE6TMZnJwPFucTrZtaBoRzJy4DDgAkHVO5/VbRWhB7vKSU9SGTxc9bH
         uLdcsXEpZS/SAOvPNOmacEEjhtPqDWBaU1w1orFoVoJaJKbnSNtmLfHZgJIXslEKBlhR
         cxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQxhlEsatCrEDYd9rmq4LigqdQYAsR9f/fabs7S2NszZwKjO0DP3crwk3YB30bVn8rJ5ThnpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZPaqu0yfjrkxime8PTpSqiNdDNUejGfhc7fFtKYHJ/tXSTa2
	7xmYEHzzAidWlrTbFNYzK7m38aBzjONO/nTjgScfMQfzZ+wnFikTCZc+m0OlbmgUXeWprZp0WUE
	Wy2Mq56k9DFeCo/SvumsW2TarFJFV3/Ar0Usu
X-Gm-Gg: ASbGncs6ncVNvZzO/YqJDvhiMYhTmPvbbZCXa08imvcNFfpA+iAmQy2KWvFb0Pey3T8
	HbjrFdnKROrvNNhx7C+VLoKVm7xp0XrHesC3Si/FhiO102Z/MWDlOlzH856U49Nyr1TM8d7CWhw
	==
X-Google-Smtp-Source: AGHT+IGOHBlplyJ9pA4VMmcFSNZGwnfQEuUeNgaCGG6Eqk3N+5X9Zh5XzH6+ynGov9Aw1u3s6Or12xGt4LtoDXMTx2Y=
X-Received: by 2002:a05:6402:2106:b0:5dc:893d:6dd4 with SMTP id
 4fb4d7f45d1cf-5dcdb586859mr8621466a12.0.1738855501549; Thu, 06 Feb 2025
 07:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206140422.3134815-1-edumazet@google.com> <d729f05a-e5e6-4d67-8fe6-888e1e761b34@unstable.cc>
In-Reply-To: <d729f05a-e5e6-4d67-8fe6-888e1e761b34@unstable.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 16:24:50 +0100
X-Gm-Features: AWEUYZmLNMOyertnK904apoKkiVMcJPz0eX6UZCANJ8E7eXqNpVldUrAkNrzFFQ
Message-ID: <CANn89i+ySFS5C24guM9E9UsPWfQBL69-OoRDbOGfih9vLGxDJg@mail.gmail.com>
Subject: Re: [PATCH net-next] batman-adv: adopt netdev_hold() / netdev_put()
To: Antonio Quartulli <a@unstable.cc>
Cc: Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>, 
	Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 3:13=E2=80=AFPM Antonio Quartulli <a@unstable.cc> wr=
ote:
>
> On 06/02/2025 15:04, Eric Dumazet wrote:
> > Add a device tracker to struct batadv_hard_iface to help
> > debugging of network device refcount imbalances.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   net/batman-adv/hard-interface.c | 14 +++++---------
> >   net/batman-adv/types.h          |  3 +++
> >   2 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-inte=
rface.c
> > index 96a412beab2de9069c0f88e4cd844fbc0922aa18..9a3ae567eb12d0c65b25292=
d020462b6ad60b699 100644
> > --- a/net/batman-adv/hard-interface.c
> > +++ b/net/batman-adv/hard-interface.c
> > @@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
> >       struct batadv_hard_iface *hard_iface;
> >
> >       hard_iface =3D container_of(ref, struct batadv_hard_iface, refcou=
nt);
> > -     dev_put(hard_iface->net_dev);
> > +     netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
> >
> >       kfree_rcu(hard_iface, rcu);
> >   }
> > @@ -875,15 +875,16 @@ batadv_hardif_add_interface(struct net_device *ne=
t_dev)
> >       ASSERT_RTNL();
> >
> >       if (!batadv_is_valid_iface(net_dev))
> > -             goto out;
> > +             return NULL;
> >
> > -     dev_hold(net_dev);
> >
> >       hard_iface =3D kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
> >       if (!hard_iface)
> > -             goto release_dev;
> > +             return NULL;
> >
> > +     netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
> >       hard_iface->net_dev =3D net_dev;
> > +
> >       hard_iface->soft_iface =3D NULL;
> >       hard_iface->if_status =3D BATADV_IF_NOT_IN_USE;
> >
> > @@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net=
_dev)
> >       batadv_hardif_generation++;
> >
> >       return hard_iface;
> > -
> > -release_dev:
> > -     dev_put(net_dev);
> > -out:
> > -     return NULL;
> >   }
> >
> >   static void batadv_hardif_remove_interface(struct batadv_hard_iface *=
hard_iface)
> > diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> > index f491bff8c51b8bf68eb11dbbeb1a434d446c25f0..a73fc3ab7dd28ae2c8484c0=
d198a15437d49ea73 100644
> > --- a/net/batman-adv/types.h
> > +++ b/net/batman-adv/types.h
> > @@ -186,6 +186,9 @@ struct batadv_hard_iface {
> >       /** @net_dev: pointer to the net_device */
> >       struct net_device *net_dev;
> >
> > +     /** @dev_tracker device tracker for @net_dev */
> > +     netdevice_tracker  dev_tracker;
>
> There are two blanks between type and member name. Is that intended?

Not intended. Also a : is missing :

I can submit a V2 if you want, or feel free to make the changes.

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a73fc3ab7dd28ae2c8484c0d198a15437d49ea73..8ac061379b6f72ef7f1d4e19188=
8db2cc56376da
100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -186,8 +186,8 @@ struct batadv_hard_iface {
        /** @net_dev: pointer to the net_device */
        struct net_device *net_dev;

-       /** @dev_tracker device tracker for @net_dev */
-       netdevice_tracker  dev_tracker;
+       /** @dev_tracker: device tracker for @net_dev */
+       netdevice_tracker dev_tracker;

        /** @refcount: number of contexts the object is used */
        struct kref refcount;


>
> > +
> >       /** @refcount: number of contexts the object is used */
> >       struct kref refcount;
> >
>
> We also have hard_iface->soft_iface storing a pointer to the soft_iface
> (batX) netdev.
>
> How about converting that to netdev_put/hold as well?
> See batadv_hardif_enable_interface() / batadv_hardif_disable_interface()
>

Sure, feel free to submit a patch for this one as well.

Thanks.

