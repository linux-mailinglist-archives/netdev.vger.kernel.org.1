Return-Path: <netdev+bounces-134231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45B99875E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3741F234D6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E161C9B75;
	Thu, 10 Oct 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlBWK7gp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8481C8FD7
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566195; cv=none; b=d9RoKAM2HSbsBDERQUsi1JF9WREvJ/soD9rOD2ioUIUIeUm0Vg4zR2y3Hy9gkTiksut9LAMEq72B7q5KjaeZRuu6CQffGRf1nEAbrkOyKjFVQZmm5aTvNF21yhgAdp9p9bhUcv4HLZU+Xyx8wZWanwXESK0AR9IK7kXeXIKzXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566195; c=relaxed/simple;
	bh=fMI9yXXfFMdiO7yLUT1VSqHvBTbtshbZwmJFn2Ix1WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS/j4HuVhbPDsbb16VNV0Nm/4wauI4WBwRk0oL+BuYTtjI+99rMdhh4h2LG+r4tNn4nsbnR6c4UV2HB2R6wWiKTiy7f8c8b75NJE6rdIGaZ0l41p1XcIkon9JtFX9GitPgciRdrxREnbrezojBtje6SCX4k+3gVu5awZcc5rrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlBWK7gp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2faccccbca7so7461041fa.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728566192; x=1729170992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIgm+vvOXy8UJRagTVP9jYvUV/jLtiQCLgciuGUZckk=;
        b=MlBWK7gp48ZtttVHGdOEHn3ZVkIC5sDMiFr1WA9HsiFIjz9FG6gD+TdO2Xh/Ri8Z0D
         hvC977BEm8nxv4oWrbv8iroBMV5aRyblrR173unJHkn8E1PzOV/LZTbA6BKdELy4egMD
         0z7neE5r81OdV0FK/0I2cHt698m1NmxHcjuv0yeHD1LJNkO7b+WE5/s7gzNIYJ6PiMho
         m+8QjAWJrVO4XGht1d03CuRBRAjkLpAF90k4mMnQDDZ8HNhbUFwnbCQeSiaoZ17Itec1
         FSV+NcuZMnFDiSXahaCg5kUKK6k0MHqYPDSdunQYqPIYl5ylQJDSgunVFJri2PYp4ILp
         ikvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566192; x=1729170992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIgm+vvOXy8UJRagTVP9jYvUV/jLtiQCLgciuGUZckk=;
        b=cIYXwjTBbw4sudOQt+EG+1IlTzxLIMWiWkbhnSCwnl9gJiP2mN9GhuZ9fKtdZS8LHh
         3mjcoksJ3C693lpbPUKVApSrIWXsMRFE2dEXCdfVMLkJRYifR1MamrFyBJovfKNWHoUp
         Q0pN/HkKvwUNHCmdBrmMO6613I/4QnBcK17NvlDRPAhSF02cFsEgzc6NsuNXkBC8zsye
         scSpdLQtmdkZaa3MhWprQU7YJ26OXpmyFfCzAmbKqvBi0/g3ksurCREoNqfq2j2TeKm3
         PW7bg+jmkPyyhVEq/pjPsugYND4xwzCSwSRSvg5rk6tc15qKkV0vVxAYBtQQgr9TDENE
         M3fg==
X-Forwarded-Encrypted: i=1; AJvYcCUe6LScrxRLIpgpUV0H0Q0KPq6Zwj9HQElL535/Ow7sQkndRuGKpT9jIWs+gEG1BLko1EUgQpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVaotgVSjI6fs+KjwtQXpzpAbSe5PCOSYQFo7v0G1DJPPcnLS
	QCa8zjUE1tBzIJlWJeyKcAPqrP3QkV6Dxx/FR6VlQ3MJjpFDgol4Vyy72RuirYolyEUHHuR5Li3
	Wuj0IhJxu25iO5vjWMkFCOPVNpXd4GiCYv9r5
X-Google-Smtp-Source: AGHT+IFOopb7XEdifq+ffnPw/OUPxMhUkqF4qycsNEzsajXQAxxnDTNy9l1QsnBhG5bwXHqNix1B8fXWbkmBiuyh3HI=
X-Received: by 2002:a2e:460a:0:b0:2f6:5c64:ccc3 with SMTP id
 38308e7fff4ca-2fb1873e859mr32439541fa.16.1728566191617; Thu, 10 Oct 2024
 06:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-14-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-14-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:16:20 +0200
Message-ID: <CANn89iJUX3nkQJDOTsj9RN0dH4_u=mVQd4Z9m_mMCLm60Eppug@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] rtnetlink: Protect struct rtnl_af_ops
 with SRCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Once RTNL is replaced with rtnl_net_lock(), we need a mechanism to
> guarantee that rtnl_af_ops is alive during inflight RTM_SETLINK
> even when its module is being unloaded.
>
> Let's use SRCU to protect rtnl_af_ops.
>
> rtnl_af_lookup() now iterates rtnl_af_ops under RCU and returns
> SRCU-protected ops pointer.  The caller must call rtnl_af_put()
> to release the pointer after the use.
>
> Also, rtnl_af_unregister() unlinks the ops first and calls
> synchronize_srcu() to wait for inflight RTM_SETLINK requests to
> complete.
>
> Note that rtnl_af_ops needs to be protected by its dedicated lock
> when RTNL is removed.
>
> Note also that BUG_ON() in do_setlink() is changed to the normal
> error handling as a different af_ops might be found after
> validate_linkmsg().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/rtnetlink.h |  5 +++-
>  net/core/rtnetlink.c    | 58 +++++++++++++++++++++++++++++------------
>  2 files changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index c873fd6193ed..407a2f56f00a 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -150,7 +150,8 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops);
>  /**
>   *     struct rtnl_af_ops - rtnetlink address family operations
>   *
> - *     @list: Used internally
> + *     @list: Used internally, protected by RTNL and SRCU
> + *     @srcu: Used internally
>   *     @family: Address family
>   *     @fill_link_af: Function to fill IFLA_AF_SPEC with address family
>   *                    specific netlink attributes.
> @@ -163,6 +164,8 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops);
>   */
>  struct rtnl_af_ops {
>         struct list_head        list;
> +       struct srcu_struct      srcu;
> +
>         int                     family;
>
>         int                     (*fill_link_af)(struct sk_buff *skb,
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index a0702e531331..817165f6d5ef 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -660,18 +660,31 @@ static size_t rtnl_link_get_size(const struct net_d=
evice *dev)
>
>  static LIST_HEAD(rtnl_af_ops);
>
> -static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
> +static struct rtnl_af_ops *rtnl_af_lookup(const int family, int *srcu_in=
dex)
>  {
> -       const struct rtnl_af_ops *ops;
> +       struct rtnl_af_ops *ops;
>
>         ASSERT_RTNL();
>
> -       list_for_each_entry(ops, &rtnl_af_ops, list) {
> -               if (ops->family =3D=3D family)
> -                       return ops;
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(ops, &rtnl_af_ops, list) {
> +               if (ops->family =3D=3D family) {
> +                       *srcu_index =3D srcu_read_lock(&ops->srcu);
> +                       goto unlock;
> +               }
>         }
>
> -       return NULL;
> +       ops =3D NULL;
> +unlock:
> +       rcu_read_unlock();
> +
> +       return ops;
> +}
> +
> +static void rtnl_af_put(struct rtnl_af_ops *ops, int srcu_index)
> +{
> +       srcu_read_unlock(&ops->srcu, srcu_index);
>  }
>
>  /**
> @@ -683,6 +696,7 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const=
 int family)
>  void rtnl_af_register(struct rtnl_af_ops *ops)
>  {
>         rtnl_lock();
> +       init_srcu_struct(&ops->srcu);

Same remark, this could fail.

