Return-Path: <netdev+bounces-177199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A8A6E3C5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5714816E7E1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CEEEAD7;
	Mon, 24 Mar 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWNRA0J4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269D27452
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845511; cv=none; b=bVOIw8t0E684XladmDAkvvzbCMZcrTI2AMhnk8ib0LIIUDHUbVq0VExhvVIz646QdFY+brkZGbAO0Y+31fpb+mDFuLwQ/otCGrHYfqECt53BuRJ1VmwYHlPdz+uwlofHlz/BkMXWSKj+VYJFk8KllvxWvtGy3LXXrTovoFa2vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845511; c=relaxed/simple;
	bh=wy7kYBNZkAF5J3w+c4Y6DHKRttq0sksxFdsmGhTPXiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUR3V84+WlcgR436rJCLxHNtr/ciMH0Gq/0SXUfd9SUqVPC5ZkGwTcTcLErAxrmwtHoXcnY/aE6Ens1mnVJWhn4NrW0Had6S47Skv1sE6xwqSRUASY1GIBwLgaVe7pDigBcCWUmNObP/7yKmc8TChoKe/9CWqTOcPQxtovpIwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWNRA0J4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4767b3f8899so58291411cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742845508; x=1743450308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iey5W7qkYykRrTe8NRjbn5B3DBL4Qdh8Gv2ZmoYjOa0=;
        b=mWNRA0J4jcNd+s6HZTd2UJ9idhHEQ44mlnocYjN20jhV8mnAD9Ezsj584+s3lPHL1s
         pKjkFME7ZcbIkyOvYIVs9Evwhzq2vAFVJ7sc2ukmQW8m1pk4d4efm5qbsFYUkb667Evp
         zXYhFGBzNoMlrMnuigx7jQLpj/ZrLIWrsbIk7NH5ngPoZ580kqibO/8K0lqmlkRxody2
         Rl7AnXyqH46nMzi7/tfDeZk32awJOSFfCABBaJitZjxtpVzIu/3fe1fUBykSvQPYwX4F
         JeHChOVdrkM+mkqF5jWBXQln//k0iXhbKIFvsk818T5c2mDsALeLNCwf3LKCEqMBK8tc
         B8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845508; x=1743450308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iey5W7qkYykRrTe8NRjbn5B3DBL4Qdh8Gv2ZmoYjOa0=;
        b=mnoVVefO2M1hI2MuDdb6RDnemmHkbe1FiPF/l7K+6Zc4S5PuLzUdxs9O4s2Ux5Dyk7
         i2zWQFJKF3vUP8/gaJqIx2ibd9O10xxDUjMdR9ZigJqL1oJDHDlpvlbymITTkG9Ork3D
         v0McnTC/NpFzENvdCn6HTcYT4RZr7OJczn1ca77It8iZ8iL3mhwSUTYxsfHpBjKybiqq
         kH4A1gxlQU1vD4gWRzBzRAVJFTN05OXrz86zoV9VUC+LBvSxSrtfUd7ZoscTqPgQ908D
         VUN9qmtIe70LIBROHA24FzsPOLk4zuoUUOY22qhzJeCUFztA1mtzqujiTcwqJmxpy/FM
         xu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHkMAbwTmJ4tA43FAVADO5XWZiukW+HtCrounU4g10dypE8mjNBIQo0YXCgPQfs9lCWf1oEs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYT6HRFjBEaxBCrVSGEfTubCjVpv7fBsPB3jqTibE19MIxfdi4
	gVHwvWVJtRoiKmo1FKikgE8fKqzWBePJ69xzL0ZyfbZsRmexseDcsPEZB46RTL55ZvrpD8xuTjB
	g1pVAgwew6OrHLN06Gwme/tHZV97jkNwLO1a8
X-Gm-Gg: ASbGnctG40nNbuh2MEgrTDKYECIHWOizrm2fohs6wBkM5HDErl2gHOJaJrW0fRtZoCC
	xCboY7E1tJKum/nJNetzdLHJko7fRIF4v0Bj6S8cTUovsBhJ16yCNdQ41Hs4ekrCfbrTKsmbRY5
	3G6s4IGFvTHFNjV+VxNYqF3ulYiw==
X-Google-Smtp-Source: AGHT+IGiEDqWtZaqXAbV3fPkXChVhIvLt9hDe42nQt4+6rscC7VptTEcKy2FrH/zc0KslU/BSCxHxPBE9nA2kXyeaZM=
X-Received: by 2002:a05:622a:4d8b:b0:471:b544:e6fc with SMTP id
 d75a77b69052e-4771d9c9823mr239019061cf.26.1742845508261; Mon, 24 Mar 2025
 12:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318154359.778438-1-edumazet@google.com> <20250318154359.778438-3-edumazet@google.com>
 <20250324123841.58ece0e8@kernel.org>
In-Reply-To: <20250324123841.58ece0e8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 20:44:56 +0100
X-Gm-Features: AQ5f1JqR2c4pRewgsYLooPMBDnIimEp3n53Alvf9qmHJe3UnsQEfW1pWVJ47buI
Message-ID: <CANn89i+Cjm+EEmtw_GF3UsgHt1_0zrjTBvSv_baqn6yH0x0feg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Mar 2025 15:43:59 +0000 Eric Dumazet wrote:
> > diff --git a/include/net/inet_connection_sock.h b/include/net/inet_conn=
ection_sock.h
> > index 018118da0ce15c5ba5e3b7fcc1b36425794ec9a1..597f2b98dcf565a8512e815=
d9eae2b521bac7807 100644
> > --- a/include/net/inet_connection_sock.h
> > +++ b/include/net/inet_connection_sock.h
> > @@ -117,7 +117,6 @@ struct inet_connection_sock {
> >                                 lrcv_flowlabel:20, /* last received ipv=
6 flowlabel       */
> >                                 dst_quick_ack:1, /* cache dst RTAX_QUIC=
KACK              */
> >                                 unused:3;
> > -             unsigned long     timeout;       /* Currently scheduled t=
imeout            */
> >               __u32             lrcvtime;      /* timestamp of last rec=
eived data packet */
> >               __u16             last_seg_size; /* Size of last incoming=
 segment          */
> >               __u16             rcv_mss;       /* MSS used for delayed =
ACK decisions     */
>
> I get the same errors as Simon, something ate the leading spaces
> in the patch.

OK, I will resend.

