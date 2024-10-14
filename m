Return-Path: <netdev+bounces-135083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12499C26E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEFE1C240F2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7E1494A7;
	Mon, 14 Oct 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRnWGdcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27814EC77
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892929; cv=none; b=dA5TDaG/Jme/FqXPy8aEth86r3YkUtfY3E5APKTpSj5/12tNco65J6P5fGEHWK9ruiFAdwhF52tgjWpuQSfwegc5gqntE4wYyLAghmW8t8XoE7E5JWiGgQ3H8sqL2+gZMs9xrtcYJn9+B9whpIE/IKrAfZY5+1Sm9T0rnY/k5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892929; c=relaxed/simple;
	bh=nuZ+/9Xi8MObRa9fKflg+L/SWu48UZGuezop0WPxIho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkiGcNJHDfe+lvgtltv9WDDugqZ/8HtIbxceI/RpTKVXtZg1TDYsQ2Dj7JcBVf2fWPXsOT/0W7YUS7Ev7ULM8wOk0kRr80b+vnZkJBfhBxhsF9ExD24EGxYgprZXeU9Cz49bIikBfpmvUFampp7Tj0V/4iqniMIMAnj0AVX7wDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRnWGdcS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso5952131a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 01:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728892926; x=1729497726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsfMlAFoOVRfJ6OWn19ze27ra+qpllPZSwMGKUlhEkc=;
        b=kRnWGdcS97O8eJCy1hBOlAq+tmzOT1NBP0Ozf95cGRt7O0KQ22HIDpzy7Z9VynObQN
         iTtSeYANSUg4U469qK9mGjVdk7dfrfNabmqcFEz9AwJyiGbaPnh/8hLrCJ/UMYtIRkSW
         h9FnUmyzxdd+uhtq47Z7zCOp0wQ80i2JpwjORJWu0vlMDjz4ec+tLpYEynBJywDOIRfw
         4+lYvKOKIjYpnocMNB3JfJL4ACrIs1WccvZkIQqBl9o08Vl1SjeOO36j5MX7Q+0LtQ6E
         kQZOAcJyfXe9dGUQaCXtbKBv5K5Fjhzu3K6+ql5q7691Y/mIFxSGTupwdxZSjced7EaM
         B9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892926; x=1729497726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsfMlAFoOVRfJ6OWn19ze27ra+qpllPZSwMGKUlhEkc=;
        b=gRDChLCDr0vTwnp3dEdT/Tbkb1HSXwswRFJZ9oIEKkZkv5TF85J50wBigchmayAito
         BMjOgb39aCtKLGF6md8sw/ZC5etRrVcPyRcwqr5Zk0MQZeiFhaEmMo8oc8iuqyuWnshE
         1ICtSjWNYUws2Dq5140025fhIcxBxUyYnrRbBLrfN9FXDzK/5qlUu6MX523NGS3WLXIG
         Y1uPkb83rwQHEC6+AvoDrQ7lWxy2mUQlFpFpuSlBBTC9UbDahCD3I5gAR7kuBJmWNJ+o
         lzc9MLamV2iOLh2JToGhatM0EoTGrhxDhfMSrFeJvDfOx0ro3JXuBe5rN3OrloIxhCA6
         4JrA==
X-Forwarded-Encrypted: i=1; AJvYcCUYp8PZ/A9awKtogrMLhYivLIeVJwvPm7RmRMOBwprWZuRr/HfmiKFNsEGC0gh3XuCA+K5h1LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6aFnZtwf4hSmACCTiEPFHQT8MqRS4NJlg3MT39YW/m6Bz1AH
	m9sPET7Cj8FrfWf0fy/L1ftaDg9kQiHOUpeFjOgby2aC5w6+1TXKgZ4ucb3fW3naTQldkXpk4S7
	GSskRW2xReLdFtPgC2lZJ/8S5DazNxYBa5f59cC60FdT3PBvHQYQh
X-Google-Smtp-Source: AGHT+IESBSR/j3NNtjjOZAMpaiJq0RzZ/OhtmG8+L1HoOFeeNyxITRAraKvPq36us/jB/UmzHFnKmo77m9Wi+RK9yRo=
X-Received: by 2002:a05:6402:4402:b0:5c8:84b2:6ddc with SMTP id
 4fb4d7f45d1cf-5c948dac386mr7433193a12.33.1728892925562; Mon, 14 Oct 2024
 01:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011220550.46040-1-kuniyu@amazon.com> <20241011220550.46040-4-kuniyu@amazon.com>
In-Reply-To: <20241011220550.46040-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 10:01:54 +0200
Message-ID: <CANn89iLhMM9BJLYMg9N0iDfLg-iTjjSof8djopYQfMdbbLeZLA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/11] neighbour: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:06=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/core/neighbour.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 77b819cd995b..f6137ee80965 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3886,17 +3886,18 @@ EXPORT_SYMBOL(neigh_sysctl_unregister);
>
>  #endif /* CONFIG_SYSCTL */
>



> +static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] =3D {
> +       {NULL, PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0},
> +       {NULL, PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0},
> +       {NULL, PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
> +        RTNL_FLAG_DUMP_UNLOCKED},
> +       {NULL, PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info, 0},
> +       {NULL, PF_UNSPEC, RTM_SETNEIGHTBL, neightbl_set, NULL, 0},
> +};
> +

Please add __initconst qualifier.

Also C99 initializations look better to me.

+static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst=
 =3D {
+       {.msgtype =3D RTM_NEWNEIGH, .doit =3D neigh_add},
+       {.msgtype =3D RTM_DELNEIGH, .doit =3D neigh_delete},
+       {.msgtype =3D RTM_GETNEIGH, .doit =3D neigh_get,
+       .dumpit =3D neigh_dump_info, .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
+       {.msgtype =3D RTM_GETNEIGHTBL, .dumpit =3D neightbl_dump_info},
+       {.msgtype =3D RTM_SETNEIGHTBL, .doit =3D neightbl_set},
+};
+

