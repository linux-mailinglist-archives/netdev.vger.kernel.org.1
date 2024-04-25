Return-Path: <netdev+bounces-91466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E28B2B23
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095D11F2179F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AB15574E;
	Thu, 25 Apr 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZtfY4+Oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C42773C
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081447; cv=none; b=EEYCw5l2nw3uVpViNa6J/V/d0PcIgk9ezQRYVu09Y1lx0SilBdPV6eJbCXVxG3fN08r6GbXqXCRJyf1VciVlUR9iNx8wA53PWEHkEF/OpX15E8mXKlcVDPl1XN70lmqKgVJYQQ9XPcU9svCpQlx5tyyFR1VJxmIsM5Do8xR+d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081447; c=relaxed/simple;
	bh=/kmxt/141mzkyudqG329NMil6iqrGLmW0gLBPDpu0sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8pxYt+Um+tvTSRYRHtWet/vKPbq4I48Mr7gRu4fC/z6JS5ejn5BWGVhyuawPib6Cnj43zjEqZqcrF5AFb5jQeDA4sdp0KNkFmriWeRxwE3kvYzwY8WZKgtA96Z8Vu0lzpuYknL6La7H4oPLA1bOKcL1cF2u3jXSQ4LRx/RaJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZtfY4+Oj; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6114c9b4d83so13146337b3.3
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1714081444; x=1714686244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDknzH04kUKyh/S87lNqzao6lK47vSseHM+LIy0qOkY=;
        b=ZtfY4+OjRkSzjjO24ycELXi9iPGDvwKFd9dTWWqrEzqnwN/6O0sMIp5cFJX+sjecUN
         Gt+XQa+JN5HErBLhohGKupxMsnSJCvJVtoS/0gmED91OEnwBURLZY0L4WFmJHJIwE9Sl
         naKCD14WCoNHclQcQHsEOXZ5vfRMgOXWR8j8R7jpj/O1NlFdY0gwwEnBRkU3L9xHSVo5
         vrnjnATZhzP944WznxDPJHhAOwx4PJhhDWaRqmB74ivkUIGSO0wZKbSth6i7Zyug1T92
         gny6zmNlZU99aRy7eptLl+DLL2reMDyYUaBH0xmcNK/FLEyfj76MTUeUQYGgzLoaKTjZ
         QI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714081444; x=1714686244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDknzH04kUKyh/S87lNqzao6lK47vSseHM+LIy0qOkY=;
        b=DBCfCr+XT+EaVo7JpYuJQtd3FnOyzZHnHSn/AfBAQx5f0qME24Qk7M6kHEPfLbbd80
         zFqanbzYlutFR5TxEyL7NGsEiKHd4zK6HlAaqM8vccxGUVewOO83EQ2cBRNi/so/BjYs
         HUYN0L0Blw1i9FemPzl0RKSQpwku9Zsd/b4mUEQVoXDQTdsrAwJ31QpmtKD1D4PG6yyb
         jbexhS2culbJvaJskBSBgZVVCEqS6OWwiS8y95fohrTKql/TqvbLDlpwksEMzpwpeWF9
         mcrbFlVhoWwkvMOD4etjqSx1wMB91e+NUlazxw0Msmi0W2l4+E4UcG6NXni5IEN5fW4g
         IkPw==
X-Gm-Message-State: AOJu0YyCFggn+/4GYpWniDKuJ5S/zemG4T0Bvs9UnLuT6K1FGkznOmWQ
	u+zbiThAYF7cbCW7Ei0/DjNLHtbxI47HqSFjWlbWSQWSvH0jtkrRZ3Tbpus7T0xokACJYCxE5XL
	dX08595TJZAB30YVUaGtPwDPSTSCJoGblKWjG
X-Google-Smtp-Source: AGHT+IFpq9XTWDuUXLJnwb8fzgQFUe5CLvuyyKGWQ9k9i5ZR9z+YzqdQBArqtCHYqO500HefFw4hNMNy5RFMV8/vmbY=
X-Received: by 2002:a05:690c:64c2:b0:615:1cbb:7b81 with SMTP id
 ht2-20020a05690c64c200b006151cbb7b81mr757655ywb.46.1714081444169; Thu, 25 Apr
 2024 14:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135109.3524355-1-amorenoz@redhat.com> <20240424135109.3524355-6-amorenoz@redhat.com>
In-Reply-To: <20240424135109.3524355-6-amorenoz@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 25 Apr 2024 17:43:52 -0400
Message-ID: <CAM0EoMm_deiQpaJts6=AKZ_0DtYk5EnRVSrfhJEJCpYnaw09Bg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] net: sched: act_sample: add action cookie to sample
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:54=E2=80=AFAM Adrian Moreno <amorenoz@redhat.com>=
 wrote:
>
> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_sample.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> index a69b53d54039..5c3f86ec964a 100644
> --- a/net/sched/act_sample.c
> +++ b/net/sched/act_sample.c
> @@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff =
*skb,
>                                      const struct tc_action *a,
>                                      struct tcf_result *res)
>  {
> +       u8 cookie_data[TC_COOKIE_MAX_SIZE] =3D {};
>         struct tcf_sample *s =3D to_sample(a);
>         struct psample_group *psample_group;
>         struct psample_metadata md =3D {};
> +       struct tc_cookie *user_cookie;
>         int retval;
>
>         tcf_lastuse_update(&s->tcf_tm);
> @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff =
*skb,
>                 if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb-=
>dev))
>                         skb_push(skb, skb->mac_len);
>
> +               rcu_read_lock();
> +               user_cookie =3D rcu_dereference(a->user_cookie);
> +               if (user_cookie) {
> +                       memcpy(cookie_data, user_cookie->data,
> +                              user_cookie->len);
> +                       md.user_cookie =3D cookie_data;
> +                       md.user_cookie_len =3D user_cookie->len;
> +               }
> +               rcu_read_unlock();
> +
>                 md.trunc_size =3D s->truncate ? s->trunc_size : skb->len;
>                 psample_sample_packet(psample_group, skb, s->rate, &md);
>
> --
> 2.44.0
>

