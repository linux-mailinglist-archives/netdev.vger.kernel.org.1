Return-Path: <netdev+bounces-237276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BACAFC48468
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 155144F0C18
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5962641FC;
	Mon, 10 Nov 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iN4YF2AT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86491C6FEC
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794961; cv=none; b=Z2z4cPLnfUvUA4VIkj2mq1uT/tsi4rhJo1FX8bgtKzBVuJhuxRfGyZs5yh/JID05AcK2BjV2n+lBfAIYZG4Dflla3SULGPfM9NXjghZGDsW51oHWwARbrmNPEjex0dHr+5VH2xQgCy4ysMEdBbImdDNQtEuDmhGadAFYfDb+8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794961; c=relaxed/simple;
	bh=q3gT6xLU+tIrITxHQJvuL8N+/olJ7lNbh4RUpS+p3pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRodMIUrq6boT2uz1qroH1nUXTnRl2u4GQvYEj8HH6mgHTPjCdhA+W1jdJKHV+IB+rJ+XjkHtvmj7d8YKCQWn8afDlfBUW5ikjJCXYT/tFyZ9dZs2Q+lWucHsYVX6OWT0uJKFf5hFOaRuq7wEK2sZ6iYj/T3U6HS7DsHHELuMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iN4YF2AT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e89de04d62so27597841cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762794958; x=1763399758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltb2mIM0WB+GBKVlymLkGCeDhxuED5A8Qr1lJnPGsjA=;
        b=iN4YF2AT8Xm3WOplmQOa5XCWYZeZHlxtqepgiP2HtYlAMpdPo37Y/EXiaHA8rK4NTt
         H/qiQ3drTbQbWdShYVt/XsXzWEc2fMnIESOg7PA2AyeuPHKLnSp53XotmewQBjwBm06j
         +Drm/2V76rFSCTnTEdMAyzIoT1Eo4q6Settjl1HtyA8hRVCH1OellmPl6AMN9+7J6mPx
         c6Q3TBNCc2FkezhJ4t1rcykey04egPcdASwdwZ/OJi+UFGCvNxCuWia8le0laAwg6dEv
         t3jgLjhwRW7TCei9hWgFM9stmpuUhDmCYDofwivGA9xsUKjA1CTENYxb909hyvj5uuNO
         MQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762794958; x=1763399758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ltb2mIM0WB+GBKVlymLkGCeDhxuED5A8Qr1lJnPGsjA=;
        b=AcV2/biHqbMxOFEbdkuvc05Q4QQqyNriaJeF2kvlFIX7y9Dij2hFWCPBr18mri9Vp+
         Vmw5tsTIXHWjXtdgVRMBDFVxBV8QHUKTy11A6UCD/lXGuAII9EkIyUywDwoNLL0uywUL
         GQv2XCXFvQLrj0DFwc4Ws0txF4AwRoieiSirQvUkvtzCOPFavVrJOp04z6Qka8FTcboz
         fFs+2R3qOHUbuB4QUvK3GnvT5YLT7+aGtgkxe+RNHA6rzofhdkWNCRc9R3KokZWshBNI
         XSv7LrZ/OEmgCrklu4qqMl2V49qFvJab4oUKhf5OTEz4Emg93dCuNaRoMdMCk1knE5OL
         GawA==
X-Forwarded-Encrypted: i=1; AJvYcCUmPlxJGLumIz/kZnmcLyi3wJm+YJo2R+fojykPmQDRVbHC5EiRvR3KCQKW6dlZIuBO8QwUltA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVkTqHsDG6teAwqGKWWjXwernBlCrR353cQWrZyIDVN2uFk3T
	U0Pi+skfrxNssvLheIXBgx/L6hQxLBiXxsT0ebXrRWAYM/fmB3O1xL1IZHppj3Tmi95qgwr9U94
	Vd/AK8vv0U3rZX7NYN5EytRIEiHXaaveUMctSCrlf
X-Gm-Gg: ASbGncvwLzIAxJ8BjIeU6feJT4vlFtP1O1RDbTlcreaWZfaUew7qI47VqFV8EkPQbWz
	QsCUmrPR1cIcqtCI7xy8lAbEoIavQC1+m2gxxl7jMZoDwBc3MZfDh6on+3X7KrXUivff4SzQPDF
	YTcRCT/06Lz85El12J5sJsDLJFbsc1Gyk380qNAaLLgxT/OhhmSLm6t/RgYD4XHGb86MD0N1FiX
	xsXlWtETKU4taKdegVLVt2nbtwEZJ8wS3IBFkPY5txzCdugHiitkO6RkTb8
X-Google-Smtp-Source: AGHT+IHkGy6q2p6uY+fsXhPiUJJO/IYV9wFfalejhsynKqQkEww9ef4WkLzBDGsMU+4NxrtRZYPZYxTezPey+97YcQs=
X-Received: by 2002:ac8:5756:0:b0:4ed:680e:29cd with SMTP id
 d75a77b69052e-4eda4ed8fdbmr114738101cf.27.1762794957266; Mon, 10 Nov 2025
 09:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com> <20251110084432.7fdf647b@kernel.org>
In-Reply-To: <20251110084432.7fdf647b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 09:15:46 -0800
X-Gm-Features: AWmQ_blMZO6w-Bl0FzjR45tH8nntsGZtBltdCRyuh3gi3oij98t_j6FoJUdnpXQ
Message-ID: <CANn89i+KtA5C3rY2ump7qr=edvhvFw8fJ0HwRkiNHs=5+wwR3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net_sched: speedup qdisc dequeue
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Nov 2025 09:44:55 +0000 Eric Dumazet wrote:
> > Avoid up to two cache line misses in qdisc dequeue() to fetch
> > skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
> >
> > Idea is to cache gso_segs at enqueue time before spinlock is
> > acquired, in the first skb cache line, where we already
> > have qdisc_skb_cb(skb)->pkt_len.
> >
> > This series gives a 8 % improvement in a TX intensive workload.
> >
> > (120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)
>
> According to CI this breaks a bunch of tests.
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-11-10--=
12-00
>
> I think they all hit:
>
> [   20.682474][  T231] WARNING: CPU: 3 PID: 231 at ./include/net/sch_gene=
ric.h:843 __dev_xmit_skb+0x786/0x1550

Oh well, I will add this in V2, thank you !

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index b76436ec3f4aa412bac1be3371f5c7c6245cc362..79501499dafba56271b9ebd97a8=
f379ffdc83cac
100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -841,7 +841,7 @@ static inline unsigned int qdisc_pkt_segs(const
struct sk_buff *skb)
        u32 pkt_segs =3D qdisc_skb_cb(skb)->pkt_segs;

        DEBUG_NET_WARN_ON_ONCE(pkt_segs !=3D
-                              skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs =
: 1);
+                       (skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1));
        return pkt_segs;
 }

