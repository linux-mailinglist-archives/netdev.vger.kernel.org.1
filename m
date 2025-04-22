Return-Path: <netdev+bounces-184867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE658A977F2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743C1766B3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391C2C2576;
	Tue, 22 Apr 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maDEm0/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1E2D92C6
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354800; cv=none; b=OKYp7evyxs6r/oRyczjZFdNa+xOlFPlydv7qPfP+3yBCYhrhJjnWAp3HuskDTwP/QTbqAiW4EWzW6Z0RbVuxGyJOlQ3NrZKTqPIF+wyacjOJ+jAQxtH2GkWMt1d/Zj0c+LgbjKzHh7gJxswPYdtyrOpvLCPrem3d4kBx+8BpQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354800; c=relaxed/simple;
	bh=AepzvkTaXC3tf015Trnt4kidHqKonWdB6m9AqTJB5Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4H4M+oBcNIhts4v7vdSZDliwPhGMdsxL4ZiXFvDHyNyfrh1nOprB41ggdnKm+8IG6uoon/EpujwegmCvGRsL5V7fGE1SQoAgSAwP9teALqgXPSZHgesAzz0ZE+qm2NpfRhjYlayDo864L1kgJ3STpP5piUdpmh4HY+VojU8ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maDEm0/9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2263428c8baso13385ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745354798; x=1745959598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hbnVvENaVU3NRLrUDXLjqPtRsqZnanRvkC7zMsTFmw=;
        b=maDEm0/9uQs9/f9YyauaANBQvRiwE/gBMcs2NalSOx2kq7A9HxYvAFgU6uBag79YDM
         zhP8YHIrVOHPphcC182uhhXJnm1Bh4R1RaL1BmUhtTwn20leEt5B2+Yy6WZCF2jQNWYG
         a53e6R4X7AIHFD2r2iuUkFWwwqRcWh1hcVKnIz7Yz8hwp+0KlUNbVPKoYSwyo6/C17tm
         Xpxswaob9wTMBlgp30y03vJo+sd4/odiRz2MZVdNat1YJALG2hEN4VUnT9tF1qvhZgjr
         FR2N2NbZHEbYtIT/PYY4CZBl4kW/A2noNHH+lBCys5kiYlM6UZqwMnhC8ou48Aw8sWgF
         Jtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745354798; x=1745959598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hbnVvENaVU3NRLrUDXLjqPtRsqZnanRvkC7zMsTFmw=;
        b=VWxyfcW8LYgt0UakPvZCRKTBHbv8LQ4GtFs1/yOH475gy0JY0jZ2M2wiIXr/K9SX5G
         gffEDM9yO9GimONUjIVf4iqrUSf0nYJokFLXuWz38Lo6TeDOvjHdC3SHBpeb+BMRbSuM
         c15RBaOCDfBhWzXQCvPc2q00O5lzyfCT71/gqx+RH0LpQP11DVLjLGIpQMoGQS0h82ZB
         /sQYl3SQOU2d3YSVNSIyPgtUHpepVfIxXgpbmP3FdlHWNTDUmcjvXSCKmOQ4H7D7iW9c
         NTGXoV7+X+zTfvjlzCSY4YOgy1ck7NT9ZeXUnQAb7lT6MY6jF2rYCJc6WA9uDxsJhtDK
         f8fA==
X-Gm-Message-State: AOJu0YyOKxNwgXuJg7/SVk8GV7q/KuAJolc7uto87Xme7RST3QRQS7jY
	s7p+l6j3yYdZkNT42uhTJBjEsmLHzzRpEtbcMgcv4Cxstf1mvFUgnvuSnW29rGf07d5A+4usrgi
	iO7Xq4IgLfGe+6nvaWh5PFl2kCwQOanNNTGG0
X-Gm-Gg: ASbGncsWfaF3l1/mHyyLhD7Pu2pzhaDGrQTROFzRjFp9sipQrNN4t0KPmXVuVdP9TA9
	4SPef4W5aGDhQqyCeQOtLc4WUtG2MLUv+GEeiUxq/ZjrFu5MAEF/hJYyg5nM30a0Gz86cVJArjb
	D4K4RHexuCRxxOtS9vBBiWxP2BWjsrtrWcHmZ42oTtFQMzFV4U1F67
X-Google-Smtp-Source: AGHT+IEri+jHg7nzBWYce/s95T8w1odDrVsc9bNQomfJRGLKE9zLufWZUYri8enjRiH0NTmCrON34chxcEP4+8+fy1g=
X-Received: by 2002:a17:902:f78d:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-22da2c3fe23mr741975ad.22.1745354797940; Tue, 22 Apr 2025
 13:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-2-almasrymina@google.com> <f7a96367-1bb0-4ed2-8fbf-af7558fccc20@gmail.com>
 <CAHS8izMFxDG5E07ZdqnDH_2D_g1fW8X0M7u3gGyV8efzxDNZbg@mail.gmail.com> <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
In-Reply-To: <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 13:46:24 -0700
X-Gm-Features: ATxdqUFHY8ewiDnZPwv9bGxstV-8bLqJUqf0obD0wDTOy1se33mAidQpqaIoPl0
Message-ID: <CAHS8izMZbt=NAK0GF6VqJNBRKy+iZQGMFG+jFJEesbz=5RiLXg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:52=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 4/22/25 15:03, Mina Almasry wrote:
> > On Tue, Apr 22, 2025 at 1:16=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 4/18/25 00:15, Mina Almasry wrote:
> >>> Later patches in the series adds TX net_iovs where there is no pp
> >>> associated, so we can't rely on niov->pp->mp_ops to tell what is the
> >>> type of the net_iov.
> >>
> >> That's fine, but that needs a NULL pp check in io_uring as well,
> >> specifically in io_zcrx_recv_frag().
> >>
> >
> > I think you mean this update in the code:
> >
> > if (!niov->pp || niov->pp->mp_ops !=3D &io_uring_pp_zc_ops ||
> >      io_pp_to_ifq(niov->pp) !=3D ifq)
> > return -EFAULT;
> >
> > Yes, thanks, will do.
>
> That will work. I'm assuming that those pp-less niovs can
> end up in the rx path. I think it was deemed not impossible,
> right?
>

I'm not sure these pp-less niovs can ever end up in the RX path, but
I'm not sure, and I guess better safe than sorry. We usually get
yelled at for defensive checks but I don't think this one is too
defensive. There could be a path where a TX skb somehow ends up here.

--
Thanks,
Mina

