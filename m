Return-Path: <netdev+bounces-120555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B6959C0B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657821F21398
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA00188A3C;
	Wed, 21 Aug 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqU0iBRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374215747C
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243956; cv=none; b=pI+Vy+BHB0AyTFONh0Z1x7DzxXcyM4QSTtW0ZYbiDGGg/ma9h0TTzhZA06q1TAjOv0Wlq9usya7SuOlnmJaJqFZ1ntDTVzfk7A0ob2GSBkJUuyc58JWbH4AkhSndN9oB00f3O8vyrmxfmjedGEjr6rAZSQO8aSeEQtVzROkkqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243956; c=relaxed/simple;
	bh=xoESzwrpfXieX4Kh07OyvugSE6I8lNyOtX9IsDyoq0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1igW9qz0r9ILiZk6VoEy4O8zurA0fzatyw/wGJedlzL6qIbxDYrYeHhegNNqn6qyVKljzy74dVglxwLARsSMdcr4QO7OZvg4th9rtOODwmTTvlh2QE2sYVF0K588jQWv8VHslwkIhuctYRygA3+1GGd9jgW5zyZbu+PbUJZ7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqU0iBRW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53345604960so1606075e87.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724243953; x=1724848753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XXtnYX0TspnT/WnsVvRXwng5vtQAmn8MbBLaCJthzM=;
        b=UqU0iBRWh8On0AOhRRHmFHWulSGLNpQ8kZyRAMdMz625TR3/VSMLVPB22eTMfMgMrA
         zzg4MdrceT2pZUvbxaLM/bUjJaA0X83Xgzuc3py5DyNV8cjJ4qp9YB45vbs6ldkHRolF
         jH5dpJ89Jn7y034Bw2G1/TO2b2MSVagerBchJbIhSDixOUGmUk4JGmXvu7nTpgOXxQNU
         JpXlkTb3o1ewN0gumn2wzzDDKvYCr9Pau7bX/I6UlVKgrbwOZQ6V/U98fuqcBW2lkul0
         4kLA8ikmYr2GqLSNdBy1h76sHytG3IOhkT8c9vNQYdQ2gjeIquMdQX9Jru8N8ySGujls
         1jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243953; x=1724848753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XXtnYX0TspnT/WnsVvRXwng5vtQAmn8MbBLaCJthzM=;
        b=CRYv/UPHZH7uhJTGVqNEzZMwhX+9b0xMcJmLgsIpNxvZGWpGeviAWeI0+YgSdJMtn8
         GBz/vFmAD/lqQFt+yrGgAUG9uVCeTPH8VB2fhSIK0YhUgJ3qwvlrHVz+tYG7ZcrsB0a9
         LSr3wUhUWkShW9Vnp6qeGs0SOhXgNOWdWYkT3a0G1A07WLopvWEss43fjS58lW7p4KT4
         91TOeactyyZPxWK+QvpA5zbsO3svaE15fMPQwBaOQtAy1twxZMA5jIDaAWnGRJaaPOZC
         nU4Z1ipFs2kKuL+wjDumSkcXcdonVGOJfkKg1/etcWZvnb/LSTytUw+DN/4LNue4nCs/
         q4iw==
X-Forwarded-Encrypted: i=1; AJvYcCVCrE+8XoJMUItIX1HZzPh662gRe4TICuMge94niRdDp+mS8espSTl/dSyxws2kk8Sm7xPLpTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+Vt/8s63ieSptl+lB0SpWYyRYF2zbop6mh6xXLZP91BEtL1l
	ZPJPG0EhQtVmGmHG01UAeqwLjbF82QKdmN16Rc6heZyjqo3NfPL+JFLIwOgZY99jzcn4r0rroQ/
	/czK3aKYp2Vs7nTcN8NIRpBiTCitKszW+S8no
X-Google-Smtp-Source: AGHT+IF6DYRR78Cbwiq5B7Jcn+HaQD+jSTuT4cQRM7F68wlGWdreNWLGkdqlkW4s7p7QVkG/SkknEnfYDnmfbsyRYec=
X-Received: by 2002:a05:6512:1382:b0:52e:be84:225c with SMTP id
 2adb3069b0e04-533485b45f2mr1393691e87.33.1724243952123; Wed, 21 Aug 2024
 05:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
 <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com> <CANn89iLn4=TnBE-0LNvT+ucXDQoUd=Ph+nEoLQOSz0pbdu3upw@mail.gmail.com>
 <CAL+tcoCxGMNrcuDW1VBqSCFtsrvCoAGiX+AjnuNkh8Ukyzfaaw@mail.gmail.com> <CAL+tcoAMJ+OwVp6NP4Nb0-ryij4dBC_c9O6ZiDsBWqa+iaHhmw@mail.gmail.com>
In-Reply-To: <CAL+tcoAMJ+OwVp6NP4Nb0-ryij4dBC_c9O6ZiDsBWqa+iaHhmw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 14:38:58 +0200
Message-ID: <CANn89iKNQw9x388P45BtbTiGFjj6PCC6vwDF7M9DJFUPhtNWJw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hello Eric,
>
> On Tue, Aug 20, 2024 at 8:54=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Tue, Aug 20, 2024 at 8:39=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Aug 20, 2024 at 1:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > On 8/15/24 13:37, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > We found that one close-wait socket was reset by the other side
> > > > > which is beyond our expectation,
> > > >
> > > > I'm unsure if you should instead reconsider your expectation: what =
if
> > > > the client application does:
> > > >
> > > > shutdown(fd, SHUT_WR)
> > > > close(fd); // with unread data
> > > >
> > >
> > > Also, I was hoping someone would mention IPv6 at some point.
> >
> > Thanks for reminding me. I'll dig into the IPv6 logic.
> >
> > >
> > > Jason, instead of a lengthy ChatGPT-style changelog, I would prefer a
> >
> > LOL, but sorry, I manually control the length which makes it look
> > strange, I'll adjust it.
> >
> > > packetdrill test exactly showing the issue.
> >
> > I will try the packetdrill.
> >
>
> Sorry that I'm not that good at writing such a case, I failed to add
> TS option which will be used in tcp_twsk_unique. So I think I need
> more time.

The following patch looks better to me, it covers the case where twp =3D=3D=
 NULL,
and is family independent.
It is also clear it will not impact DCCP without having to think about it.

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288a47fca3ec1881c87d56bd9989709..43a3362e746f331ac64b5e4e6de=
6878ecd27e115
100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -144,6 +144,8 @@ int tcp_twsk_unique(struct sock *sk, struct sock
*sktw, void *twp)
                        reuse =3D 0;
        }

+       if (tw->tw_substate =3D=3D TCP_FIN_WAIT2)
+               reuse =3D 0;
        /* With PAWS, it is safe from the viewpoint
           of data integrity. Even without PAWS it is safe provided sequenc=
e
           spaces do not overlap i.e. at data rates <=3D 80Mbit/sec.

