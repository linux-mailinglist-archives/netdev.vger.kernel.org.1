Return-Path: <netdev+bounces-100241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9538D84D6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A902898EC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50112EBE1;
	Mon,  3 Jun 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzgeAJ8t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164B12EBD3
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424557; cv=none; b=mTgW5PcDrZ2dcYV9JJupaoSj9vkFGcIaymF2HeR3GyWrH+dcYy2yIEW+3qa4MPoDQqSWAQu1XbRrhhcMoVNs55JsfaTuDjFZnBN5bedm4ak9dlErommpxUVfkRmaheDWeP+I3qIvRFAtQ664XUPkrHmJHAQ+bwlg5mDob8Ibbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424557; c=relaxed/simple;
	bh=We6rDzcmNkZka8Yg/UlI2NOrRc8wZeBmovLsr1vpxms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewFGjaTuQyp2jfYMLyEqkAym8UNFRWMQazhTXwxWc8bAx3y5Y46BgJafDMxU4bDG6W0Djb6eg6y/nfCLRLioqMJVWjUj4n71jBpQcilTc16rFFqDzI3wFQCX06E8ss01YH0J/iAqbcDEs/0Gkwk8lZ06I1uWUfqBXuD+o5YrtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzgeAJ8t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42133fbe137so114605e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717424554; x=1718029354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8oQaL9FAbTlCxOBkxoi1tsS9fGHeajwNfgQS79Eab4=;
        b=dzgeAJ8tRQ+ykTrLKMx9/nAwCI4DR984reWh4BnR/jcQNWJv5GGqZ9eXmFsJlaUd3Y
         6mRCk3QpTRHpU6a4XC1meVpYRyYhDeNOK7GrP+avkVxplvIfMUOJhGQSa8annvb5rMow
         +d+6EJsTR2ecomqEUl0p8h9lCluDVo9fKTmN3tMXd9rp6efUICO1tnB9ibnjXGCq/J11
         IoGUPYFsMidASbZnjRRcAsDL73t+q+dGED0B4uPc6JqAmDt86CGlC6Zu9DNYtvIDKtcL
         VPH6KPlO5s9dO3g7in7+da0EGOKz6meLFWPWuWrLHFqY5EXo/bYjjGuaZmzoLNYSBzHy
         bzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717424554; x=1718029354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8oQaL9FAbTlCxOBkxoi1tsS9fGHeajwNfgQS79Eab4=;
        b=E/BAYoVQpFWmGb0rGYgFXsVMLViT4PS+KW/hKsEt6JLtfn5q43jZkohI9Yt2Qae1UW
         vAA9dEtQr9OcyDD/cbaZF8CGgK+3ocilAgiLLZaWoRVrF88K5vaFrhEc4G6CFMXbM7I4
         5QMoF4NtZLB0SCFK6E883WJ6SKhjnxDRFp1DUddApuL7hFrM4CS5jofhGuCv/Vy2VASb
         hu5RcMMCkSwPhBDz+9J2+h1McjU0omsn0HiAULNGIEOc8J9hMa8vZZ7L+951kzPU1vLT
         d6FBnJ82V7EH7N7rOgu5imRqyrOZkXkFwX7KYIUqwaEfMdDiuPEcihUtcyytplSCtrWo
         tSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx8uPbbNQkfD2jDvEWwEkBN5VVyT6C69LF3e/kjNIO9tQOl8zYEikwzbyPK6SuEzM8upZ+cKOLY6TUlRPEnLke7wOcy4r/
X-Gm-Message-State: AOJu0YzuekhRyTT2bK5s6oin/uZ0SrbyfnAX1xO+dI0h+1f+fpyUlg+k
	u5a6FpjncxgQ69NgKJH2/3OJwMbGcIDY7N91mISKH9wnkkUtf4EU+jtszq7w1eWGkVt0F8KAe9o
	6EgGJh0a8UFuMsD9EIepKUiI8qW4UDWNPjFoQ
X-Google-Smtp-Source: AGHT+IGfBZSQC3nuMyFIA62nQgOn5i3KE9nV0HmxA6glYXaTTKcthM+CvYrX0yBPIaZTUjSBF0eToYcanDe9tlaGby8=
X-Received: by 2002:a05:600c:1d27:b0:421:328e:99db with SMTP id
 5b1f17b1804b1-421358b2ea5mr3535925e9.1.1717424554207; Mon, 03 Jun 2024
 07:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212517.644844-1-kuba@kernel.org> <20240601161013.10d5e52c@hermes.local>
 <20240601164814.3c34c807@kernel.org> <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
 <CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
 <20240602152102.1a50feed@kernel.org> <20240603065425.6b74c2dd@kernel.org>
In-Reply-To: <20240603065425.6b74c2dd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 16:22:19 +0200
Message-ID: <CANn89iKF3z_c7_2bqAVcqKZfrsFaTtdQcUNvMQo4mZCFk0Nx8g@mail.gmail.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun, 2 Jun 2024 15:21:02 -0700 Jakub Kicinski wrote:
> > Netlink is full of legacy behavior, the only way to make it usable
> > in modern environments is to let new families not repeat the mistakes.
> > That's why I'd really rather not add a workaround at the af_netlink
> > level. Why would ethtool (which correctly coalesced NLM_DONE from day 1=
)
> > suddenly start needed another recv(). A lot of the time the entire dump
> > fits in one skb.
> >
> > If you prefer to sacrifice all of rtnetlink (some of which, to be clear=
,
> > has also been correctly coded from day 1) - we can add a trampoline for
> > rtnetlink dump handlers?
>
> Hi Eric, how do you feel about this approach? It would also let us
> extract the "RTNL unlocked dump" handling from af_netlink.c, which
> would be nice.

Sure, I have not thought of af_netlink

>
> BTW it will probably need to be paired with fixing the
> for_each_netdev_dump() foot gun, maybe (untested):
>

I confess I am a bit lost : this part relates to your original submission,
when you set "ctx->ifindex =3D ULONG_MAX;"  in inet_dump_ifaddr() ?


> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3025,7 +3025,8 @@ int call_netdevice_notifiers_info(unsigned long val=
,
>  #define net_device_entry(lh)   list_entry(lh, struct net_device, dev_lis=
t)
>
>  #define for_each_netdev_dump(net, d, ifindex)                          \
> -       xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex)=
)
> +       for (; (d =3D xa_find(&(net)->dev_by_index, &ifindex,            =
 \
> +                           ULONG_MAX, XA_PRESENT)); ifindex++)
>
>  static inline struct net_device *next_net_device(struct net_device *dev)
>  {
>

