Return-Path: <netdev+bounces-242044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB8C8BCF0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2BB64E07BF
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275E340A79;
	Wed, 26 Nov 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jqOd0rgh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B83148BD
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188428; cv=none; b=Q4OGp9Tw4xO9vt5IBE90Z005WQYyrFIwsHS3NSTqQNBJAAJvDgtWm5jJppr82ynvVyp+wnligUrgBx1foU0oq51892PVa7dbZQqdduVPxgR19SvK29OCuWFdNZVaPxhnncIelKohYrAPD7BMUdjnUtlbZe/toySILGFNvG0pxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188428; c=relaxed/simple;
	bh=s6+VOjSxW0rFQ/Aau/c2Ab0oWGxyuzEY2yGCrA8dtyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIWrso/LODVAye2utG5p6R3PFxCFZ/5vFJQqzLO7SufCDN51PkR/U0l3VBDu8BFeAYtJGn2u5sHdmi80cw98gK5/bWSWjoWgR2BP8AxkMOK11wjFpUUVU0Mjk9IqBYOpj/x02CYYwAfJm9VRy/It6lDLSBTtDQSXAdBvxZs6fKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jqOd0rgh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29812589890so1901185ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764188426; x=1764793226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhapffvBMHSAzz0gP7Hz86mVNhs9Q4A7pwye0xenJCU=;
        b=jqOd0rghlE7WUjEA8G2suwNZksT0LBhyDXeZd7T0SOyI1HT4ILP2qHqQ2AuO9ONoQO
         ikK/j59OVDGz2UPlCJd0PJBFhyzqaS1aVg/1cCOErOTkda4MhutfwwAVRNJdwuu209tl
         lRFavvDb60vL0frSb6i5xyiKOSV+LK7Bjtm3fplDiY+XCyCoWdcxIV+zwhQ4EzhRWPHf
         GIvRuvGLzFoocavms3SVQBvdJwFMP52y7la11ySreSUjtDaqs5024mL+4Da0Y2xzfptI
         NB1Mx+N9KS4PlYvoFyBaNWkggfQeLfzi49v6bJhOLL0xlgrTAOh/ODGwh4D0tMQiJeVP
         Nw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188426; x=1764793226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhapffvBMHSAzz0gP7Hz86mVNhs9Q4A7pwye0xenJCU=;
        b=T2d9ZTqYNvfmA6hOwwAm8/POu3YmYy3+q+J0RY4eZGA6xS16GdV/Agqr4QJUfXSG0j
         nQio6uYyGQtNiaV8N3fRkB+44eghGdkp6Wp4cCbFHnnzgJmKA3AmzXf1yoMY9hifxxv+
         Km4SnhhEh8Iwf8qZoiGjDC719Ypsi2FgWCY1zLt/o5qnKrWCYVRnQnQGByxylqlVNPck
         zjDFizp0bg0YsSJ70li/tIwvub61Pw0u0reAXOLPlPX9JntZnaDWAlHp9hUrenSDTsb7
         X0DlHcEk4yfxyeKdaqZTjo+n2oL+KjcoFBSY+394h1g/tjNbVFayKHyCEv5GzdJJ5n6O
         OVIg==
X-Forwarded-Encrypted: i=1; AJvYcCV6G2kWHmvY8pjgEAsstMIUcEVhPQuHJ3Ky8GsDZanciLKrH5sz1ThZWBBEAxL42/OgZWONrvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHw1tIzsh2cKvGiCbQLt8xL33bF8+MxjOvaJlJBZXadXLpDKdr
	Ko2SL4F8R1FXDcYMPiqL9nKPEMfZDR00hdwojh7KrGHTM9KqLMrbM+WBHWlbLxry2oUVfSf01we
	Q6xEzsK71qinYs4EW6zrlsgClSAkQt4QNhc9Yd0qe
X-Gm-Gg: ASbGncshmTu3c8zOvKUYsGYit8Ha7koBfw7O8voAMSEIJrWfgHmhHYW8u5Ui67UyAz5
	4tvU167iXCV/MYnayqsbA0kJxhTJTnulUKIrGUJiKrmzrGivWvXoWPCWzVAfuZ2CyHjJz+g5MFq
	nawj4hee6uh74CVxRmPOGAitfNPYXBAuKVZPRKmypJWOHD3Pw7DTvOTRn5X8/vj1cvwDhp8HlI+
	fK1hX4HYKtENmGhDDwUrbpVNW2vBABmtw+FFvtFIHjI0eMOvESNubkW1+ZG8ladnfi5Lper3qMR
	lC0=
X-Google-Smtp-Source: AGHT+IENlKo2mknI86CHP5wEat5rQO6OaaMCsr+2henrqCniZ3MhdPmImBkuCTd6+tMwAfMN3hXEeV+U+tbZxON7K/0=
X-Received: by 2002:a17:903:3c46:b0:27e:dc53:d239 with SMTP id
 d9443c01a7336-29b6bf3b302mr249431245ad.35.1764188426047; Wed, 26 Nov 2025
 12:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
 <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
 <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com>
 <CAM0EoMm4UZ9cM6zOTH+uT1kwyMdgEsP2BPR3C+d_-nmbXfrYyQ@mail.gmail.com> <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com>
In-Reply-To: <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Nov 2025 15:20:15 -0500
X-Gm-Features: AWmQ_bmMsmC7VvzyK1UGypcrr81e9W-Pc8KGYP0rO-P6sfI3tpDgTGX7WloMMH4
Message-ID: <CAM0EoMmoMUtrBHyYUWNeBnFFj8kDFYPyQB+O1fdGB4xk_bMWZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
>
> > It's the multiport redirection, particularly to ingress. When it get
> > redirected to ingress it will get queued and then transitioned back.
> > xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT will
> > not help you.
> > Example (see the first accompanying tdc test):
> > packet showing up on port0:ingress mirred redirect --> port1:egress
> > packet showing up on port1:egress mirred redirect --> port0:ingress
>
> Have you tried recording both devices ?
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c07a39f9c9=
4226357d5faec09
> 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff=
 *skb,
>                 return retval;
>         }
>         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> -               if (xmit->sched_mirred_dev[i] !=3D dev)
> +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
>                         continue;
> -               pr_notice_once("tc mirred: loop on device %s\n",
> -                              netdev_name(dev));
> +               pr_notice_once("tc mirred: loop on device %s/%s\n",
> +                              netdev_name(dev), netdev_name(skb->dev));
>                 tcf_action_inc_overlimit_qstats(&m->common);
>                 return retval;
>         }
>
>         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
> +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb->dev;
>
>         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
>         m_eaction =3D READ_ONCE(m->tcfm_eaction);

Did you mean not to decrement sched_mirred_nest twice?
I dont have time today but will continue early AM.

cheers,
jamal

