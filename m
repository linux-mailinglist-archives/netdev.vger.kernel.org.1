Return-Path: <netdev+bounces-118819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1613E952D93
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AE9287DEC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05C1714BE;
	Thu, 15 Aug 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQdAilbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A161714A6;
	Thu, 15 Aug 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721716; cv=none; b=awjF35cUPDfS+ycjLpf3gB9/n1YPyeR2pkvf76mZAPwck0rtb/S0HAxO5dRH47cw2QyXh8b8Zpffcatbgkrmb3ax5/i+GAsb3u4QSqHanyhMWThPZFe0jucUeRTWjTKo2EXqLjMp7crH/3TR37jrS6sF71JHDhzj1hHTmYzL9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721716; c=relaxed/simple;
	bh=7/N9dKfCTcABgLcBg6++TIXMVXynOJhPlQR/7JwKwq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHq68ujR6YooF6+T4ETtpNhtDg9r6KM0LsI1mzRyRV/Wp5CF+E+xlbS5TxlH6RWuGI3AvDRTWZGCtW/v6pgQbg9+7zTa0ihC8Ba4gifCogcTrspNt1AR0C6zrlmbqiXLwMyyX3ces2OIe0kqmrIZTQY5xzfDyiBCc38L1uznJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQdAilbK; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d2044b522so1460405ab.0;
        Thu, 15 Aug 2024 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723721714; x=1724326514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbkjk4Bs4K+JdpDJMUZAyZCtxjsEym37+NyVuanBCq8=;
        b=gQdAilbKKnDAWsi6+Roi7srzPbfElUd5IPeohe/dNr0KdvwMLBz/xem7vnyihD2Ki+
         /oob4zHO1f0oEFscctKYvkoXHSdnrJclmYwlZ9LaTKl1Wz5+PsUywbj8hppETClZYkoN
         X++geEDot/AUH+VfymVQ39MYx+PQe0kB7Tjp6FcJihWqjxFd4yz2YxMe8ifcRptyeHxo
         jpsf5ygSsXejI3SHEM/vtjbQWOga6iFwwmQa45Lwft1Zlw0BTUUhlrr7/516LKs0VdrM
         Y2akzNVSXnOg1aKlyFyLNMFjdMWeOPPjkTAwA8OeE3pDe+YvIkZzBc4lNVvCPn9eKdNi
         m+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721714; x=1724326514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbkjk4Bs4K+JdpDJMUZAyZCtxjsEym37+NyVuanBCq8=;
        b=kPKgOeeS4BLEqipaIKxGvavzn3MCrBz4M7JQerhW7uqJh0+LvXnOM3AqNVMEPA/BNl
         c0xFqiqAj4p37MDg0T556zSNQxqaPUCXT7x4eOK+dSsMPokO9qybuNdvxZbDSZWd1LvA
         6oH1nnGrDi5k6OmLQhbU9Mjr0yauxmrGl3rhZ4Hv+p7EpKelA5E0KS7UI8PiXpRrRE5B
         61SGooHTQm/6J5mR10/ugHSuQbguC90BhVadZbF3BBYlJhx1mo0aOAMIAwsrA2yTQfPK
         Af2mstM122ryeBgdyV6Fb5pvJI1SsDOv6q1346L8wCkVUc0T6jOy63C36MAMKnrDsR0u
         PV6g==
X-Forwarded-Encrypted: i=1; AJvYcCUpmWkRR4CODVvQ6xyjUlCdL2FNWH4gx9YIx4K6NdMhcEqmz7aDeHKRJOpLM5yhT1WztobfrbsTbywZfb7F7WPZakL/9a7YDzlaz1IHVjk2ufp6+SzeFc4/EAb7BP6BPOo9Ncwv
X-Gm-Message-State: AOJu0YycjlBZPMyazsZkmfrFyIHp7I2RG6lJyyw4/RVPWaBurJ0BDZ40
	zySyxjE6n7n7UJtxQ+zIdB0KIZ1wuzAnbLiGEFrfH5O96XxgwsD1WVhCboN91dIj4fm5Lb7IhKS
	8bGOrxSX5tJJ166YMTSlqrnjzvhXJEQ==
X-Google-Smtp-Source: AGHT+IEA1NAOe/fDn/DCs1+nWs15Aa14rDsChusAoU0npNNJNf19dEt6t2H1OkuEoarl3TxP6vD4We8mWA/Co8HcwfU=
X-Received: by 2002:a05:6e02:12c1:b0:39b:385f:65a6 with SMTP id
 e9e14a558f8ab-39d124e1c2amr73311545ab.28.1723721714339; Thu, 15 Aug 2024
 04:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815084330.166987-1-sunyiqixm@gmail.com> <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
 <CAL+tcoAiOwWEsbkqSJ3kpwLxd8seBBUOAODeBideFdQYV7LfWg@mail.gmail.com> <dc46f9de-641e-4b38-8661-4efd4859f49b@redhat.com>
In-Reply-To: <dc46f9de-641e-4b38-8661-4efd4859f49b@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Aug 2024 19:34:37 +0800
Message-ID: <CAL+tcoBqkE+s2JbuwijWkrJJA2YBg=Z78oQ-ROqoqKEpnRgTtw@mail.gmail.com>
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: Paolo Abeni <pabeni@redhat.com>
Cc: sunyiqi <sunyiqixm@gmail.com>, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 7:23=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 8/15/24 12:55, Jason Xing wrote:
> > On Thu, Aug 15, 2024 at 6:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > [...]
> >>> -             release_sock(sk);
> >>> -             lock_sock(sk);
> >>
> >> This is needed to flush the sk backlog.
> >>
> >> Somewhat related, I think we could replace the pair with sk_flush_back=
log().
> >>
> >
> > Do you think we could do this like the following commit:
> >
> > commit d41a69f1d390fa3f2546498103cdcd78b30676ff
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Fri Apr 29 14:16:53 2016 -0700
> >
> >      tcp: make tcp_sendmsg() aware of socket backlog
> >
> >      Large sendmsg()/write() hold socket lock for the duration of the c=
all,
> >      unless sk->sk_sndbuf limit is hit. This is bad because incoming pa=
ckets
> >      are parked into socket backlog for a long time. >
> > ?
>
> Yep. To be more accurate I was looking at commit
> 93afcfd1db35882921b2521a637c78755c27b02c

Thanks. It arouses my interest. Now I do believe we can do such
optimization in this function.

>
> In any case this should be unrelated from the supposed issue.

Sure.

Thanks,
Jason

