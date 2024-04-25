Return-Path: <netdev+bounces-91405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5967D8B2759
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0731C22FF9
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399914D6EF;
	Thu, 25 Apr 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7MOQ84u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CC14EC41
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065190; cv=none; b=Z/LibFeSMhCV+6YxcQ+ynjZJBx/18jwxsdvwa1HD3IYZEAFAIrsuv6ROsWhMwIhCmd6DzBC9hKq2zEv2EU1qmbVbzYxHQVeWtOUhh1Uyoto8dKcL9IiTsBxwFGjYg8j3WzXTUAaQsh3z8ILhlhafNVSqcesqPnes3AVTfF9UqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065190; c=relaxed/simple;
	bh=1W3JbB83zyRQOUc+d1VmZAveLbcgrQJ41owIT0g9PZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGgwJMFf+NRCSgiwrxz5+r0szx/nipmTAnVqBp4kwNc16JLiCy8mN0/peo9z3LE+zievDdMxtBwsC1HXVSWULhkw4Wj3Uc3qR2A6Li1RtVolhSTOQPpsiRF68DgvaLHtnPkcgTPMxxvZn/x+pI3DyEAMLyuZIZYUCKnRArKjuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7MOQ84u; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso451a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714065187; x=1714669987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB+oM9wJqD1tXSoof+ljbhh4vXrREACQo8b19raFUZE=;
        b=a7MOQ84uG4fv4CsrFoZou+yA0EmagPC3NLVnfmNlf6a91pJLPvVq5BDqrPHTWDmad2
         f/vpMGSHtO5jkRALZdtsGbbfRCQVzG/Mf9Hw4qQ3AX7zfTG1S6k6aTep3HolMtEsiHz+
         arG2QQZ3jpyDu4wV+la24jaCHx2+sK32ClvDvE+rwiQGzP+Yb0DvcCXk+W2qfOumZ8lr
         YuwQHQXoN2ApigppDgxOjetAxHWbo4oRDqiEvdMPa1mD1Vt6fE8KSjQrhw+JW0ISWaAi
         w+fvic7raAKNd7Fw8iHioix91t86V7kZcBkPk8m2f4pwh8MybxSa+EkLuoMMh2eFl0i4
         Azlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065187; x=1714669987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB+oM9wJqD1tXSoof+ljbhh4vXrREACQo8b19raFUZE=;
        b=b1+YM2KXbDsFj8hoVixmDMypl0vrR8UycMd5uePLkMeiNkpvwgpYkFBAVyB0ryuk99
         TBl8Na6v0dAQy13GT6KrFkbR0P92wUqUEKfux8eXThhl1T3SdRXSvnjOt9TrHYPwK9zR
         qQFQx3xL9HQeL/u1WKYJrZxW/U9dHlCnZ1e+vNj5xF8yVKPKGwElMrEBVgjiinang/cr
         A6aTR9KVN7zr5HElvj4QnikM7OE8lL9MSokg5v5kd0REXA9C4Wcs1d/FTe7vqyUf2ZaK
         BnBBSqulxOuIpDHQf8ze/70KZH7zjVcvG/6Y4FJWncHHGYqVEYFfvNB2A2tCSxRcAJjK
         7t7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHCNlrArvHFcFSxCxoIAt7Io7YvPp6hvmXPYIDIq8XBnrg2ONe+AZO0mE5iCOCF20f7LOKOF7mkhogyNWCmwEASoqlJaNc
X-Gm-Message-State: AOJu0Yz+FkFShJAPxEEnlEcBI1qLUq+X04Jm8KCfvbCmjIY0tUBzRJWR
	3eEAdjLMwmXxYbCADrRjNp3acFaEwdCb8QqsHYJlY2LP5D5vuHubLA8ULSgdx8apJAV51gK8Vit
	fXGQea9wv6N/V8GHMSDt4N4uu1VRTRZdoaaSa
X-Google-Smtp-Source: AGHT+IF//jjNNybOjb+HhKDk+shwe4+Ok3TfgFKk7++NQOH1g7MJNibduzAlu8hCcJ0t1rjc+URbNDw4Ckgdd5D+sH0=
X-Received: by 2002:aa7:d408:0:b0:571:fee3:594c with SMTP id
 z8-20020aa7d408000000b00571fee3594cmr206957edq.4.1714065187299; Thu, 25 Apr
 2024 10:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425170002.68160-1-kuniyu@amazon.com> <20240425170002.68160-7-kuniyu@amazon.com>
In-Reply-To: <20240425170002.68160-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 19:12:56 +0200
Message-ID: <CANn89iJEWs7AYSJqGCUABeVqOCTkErponfZdT5kV-iD=-SajnQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/6] arp: Convert ioctl(SIOCGARP) to RCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> ioctl(SIOCGARP) holds rtnl_lock() for __dev_get_by_name() and
> later calls neigh_lookup(), which calls rcu_read_lock().
>
> Let's replace __dev_get_by_name() with dev_get_by_name_rcu() to
> avoid locking rtnl_lock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/arp.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 5034920be85a..9430b64558cd 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -1003,11 +1003,15 @@ static int arp_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
>   *     User level interface (ioctl)
>   */
>
> -static struct net_device *arp_req_dev_by_name(struct net *net, struct ar=
preq *r)
> +static struct net_device *arp_req_dev_by_name(struct net *net, struct ar=
preq *r,
> +                                             bool getarp)
>  {
>         struct net_device *dev;
>
> -       dev =3D __dev_get_by_name(net, r->arp_dev);
> +       if (getarp)
> +               dev =3D dev_get_by_name_rcu(net, r->arp_dev);
> +       else
> +               dev =3D __dev_get_by_name(net, r->arp_dev);
>         if (!dev)
>                 return ERR_PTR(-ENODEV);
>
> @@ -1028,7 +1032,7 @@ static struct net_device *arp_req_dev(struct net *n=
et, struct arpreq *r)
>         __be32 ip;
>
>         if (r->arp_dev[0])
> -               return arp_req_dev_by_name(net, r);
> +               return arp_req_dev_by_name(net, r, false);
>
>         if (r->arp_flags & ATF_PUBL)
>                 return NULL;
> @@ -1166,7 +1170,7 @@ static int arp_req_get(struct net *net, struct arpr=
eq *r)
>         if (!r->arp_dev[0])
>                 return -ENODEV;
>
> -       dev =3D arp_req_dev_by_name(net, r);
> +       dev =3D arp_req_dev_by_name(net, r, true);
>         if (IS_ERR(dev))
>                 return PTR_ERR(dev);
>
> @@ -1287,23 +1291,27 @@ int arp_ioctl(struct net *net, unsigned int cmd, =
void __user *arg)
>         else if (*netmask && *netmask !=3D htonl(0xFFFFFFFFUL))
>                 return -EINVAL;
>
> -       rtnl_lock();
> -
>         switch (cmd) {
>         case SIOCDARP:
> +               rtnl_lock();
>                 err =3D arp_req_delete(net, &r);
> +               rtnl_unlock();
>                 break;
>         case SIOCSARP:
> +               rtnl_lock();
>                 err =3D arp_req_set(net, &r);
> +               rtnl_unlock();
>                 break;
>         case SIOCGARP:
> +               rcu_read_lock();
>                 err =3D arp_req_get(net, &r);
> +               rcu_read_unlock();


Note that arp_req_get() uses :

strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));

This currently depends on RTNL or devnet_rename_sem

Perhaps we should add a helper and use a seqlock to safely copy
dev->name into a temporary variable.

netdev_get_name() can not be called from rcu_read_lock() at this
moment unfortunately.

