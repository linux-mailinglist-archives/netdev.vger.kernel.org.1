Return-Path: <netdev+bounces-241822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F796C88CB8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8F33B1B34
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B595031AF16;
	Wed, 26 Nov 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="dCF06ZMW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04219280CF6
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147439; cv=none; b=Z82R+R/eY8i/4rinQ45qDHQunaspXZiIPbCUXrreiThhSAlkfWigCP+TCs/ebdF7HghNZAcp32AKmUJBCnNXxkXj4eBo2DTQ4sejP6IbtlpZ3XC4y3vPFFSw/eWxy8qM0qFNZlr+KXYNeJMVXiZFR406/0HhYhY37dybYZuCT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147439; c=relaxed/simple;
	bh=nT+9hkMMKO2a0c2dfjEfFHNaAZraFsUcksi/FyJvXog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWzz96NbEfmytx567TL8qPSTlJGlkvnxv71KLH1iV94onbMnHgLxnuu/xLkFNGLgHONLrPRgklFmzws1Kf1npIz6RQDc+vz6ESTlltTr+wz0YtZ2iRynBuESvbI4B7ah6zLXnXGe7mIBkwFMmTCm/zq5C4tpMe71riOSh9uibvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=dCF06ZMW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787f586532bso57577507b3.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764147436; x=1764752236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OM6Ho99eQFd7mP86XuPFjtx25R80Ho6T6bFHAVogBI=;
        b=dCF06ZMW+uFpH/MXMZnG1J9O5gXd2I7u6cL2ZAm+qFO0L86jQSFxg5DNPXAMa2RNlk
         Ng/lOOuGLkTHvdDYTk0KiVJR8TeAo842XnKj/g3+0tB8XHBARydAP/B8VC3Qvm/BLOFj
         wbX/+uTUtWbEjOtDETcLPjWutf/0SIsABFWII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147436; x=1764752236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4OM6Ho99eQFd7mP86XuPFjtx25R80Ho6T6bFHAVogBI=;
        b=EZbGKk9Yp/dO7TqzCsX8HhtiJz3qq42SZTIP/7pJcp9VdIODQB7mFPBIP+rGf6pSTu
         Zjsj7BMQAMPm+OknOpHHlu7uqNJ5EfeA2MjbCeWdketSiSU3JlOlplmPbU4kIF+/Zw1n
         bRSnmB1Hm1KfhkxkKc2p9p7pQQdf7aIq1e39PLbp1I+lGljD3h7oHJ7dzS5r74cYgWg6
         kNiOLuQwZEi5JpI7BUVUdQ+gfadVFx2P5pR8fwVmAjd/LrJEalJSUoEfLygqiWdpyKfk
         JUCuM9ICJsX9St59ASJy3zm8ckaj+0DLgHGQPXduqElNsNIMRDVZjAr/h21mqUbLOlFU
         cFAw==
X-Forwarded-Encrypted: i=1; AJvYcCUICE33HquT0k2p3fPNWEivx+zIiCYC0tDN+JLkpO1XjdkxBdNgFB4uV+DIkVZdQiBOmBwg+gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvX4hQGECQEH80ETN36Zu0bEUDOSA/bZpvzwQfXgAf7hS0DBzZ
	jHquHpoM6CtcTMkIJy5x0WaErlaEFyUIy5QR+fHxEwDg4/KeYj4FyTdWrNBJ+KVy9K3mmllE5NJ
	I/3qIRkhfhbTEjZdkb8HiwBhxRPg4Fdu+U8BKVNLJAg==
X-Gm-Gg: ASbGnctmhkgUd8ajQz4xv2WGuIIHDbQYv8eWKGnHVV27qbS200FquySbwVIx+3FTuSI
	B+Up1CDBuNA6XV3hvJv4JwiSa/VX0nBx4bRqNtNcW7tAGC/dRgxnfY3JjUVoPzyqoiQyX9uDfez
	X781okFCr3XsifQmkU5qA8cliRtPiYweXdlLaZ8qLqwe1Ed6Wa3pJXHxZJKoDfVtk2o6VH+9BXL
	EXWOL4yjYoaVTAn6/q4uLf6G92+rqo2b9F7Es5FMIUoKIXac06TWzqv2Q4qnZgdpQnNGoYSX+RB
	WLqesZTWeEhuc5oYVHf55sSB7Q==
X-Google-Smtp-Source: AGHT+IHJIvCtQDQdlog8TUzs2kVVtyqB7q15hp22o49qFK1YOQ1sGDEwLFExhJCLMavAo58rcSOOrmdo7LPuV53mr+o=
X-Received: by 2002:a05:690c:e1e:b0:786:5789:57df with SMTP id
 00721157ae682-78a8b528a34mr142965887b3.45.1764147435965; Wed, 26 Nov 2025
 00:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126070641.39532-1-ssranevjti@gmail.com> <9c9e9356-55c2-4ec0-9a0e-742a374e0d04@hartkopp.net>
In-Reply-To: <9c9e9356-55c2-4ec0-9a0e-742a374e0d04@hartkopp.net>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Wed, 26 Nov 2025 14:27:04 +0530
X-Gm-Features: AWmQ_blI3bICHE0wZGePxKvJM3ZGKSLwaqnMni4SAIeax_i_EG-2dclrwCiuaQ0
Message-ID: <CANNWa06P=u44r=Nq5Er+iuJW=aEpaAq0L7HKn9id+KLjy_pEtg@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: em_canid: fix uninit-value in em_canid_match
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rostislav Lisovy <lisovy@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Oliver,
That makes sense EM_CANID operates on a full struct can_frame, so
ensuring CAN_MTU bytes are available is the correct approach. I=E2=80=99ll
update the patch accordingly and send a v3.
Thanks for the clarification!
Shaurya

On Wed, Nov 26, 2025 at 1:33=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp=
.net> wrote:
>
> Hello Shaurya,
>
> many thanks that you picked up this KMSAN issue!
>
> On 26.11.25 08:06, ssrane_b23@ee.vjti.ac.in wrote:
> > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> >
> > Use pskb_may_pull() to ensure the CAN ID is accessible in the linear
> > data buffer before reading it. A simple skb->len check is insufficient
> > because it only verifies the total data length but does not guarantee
> > the data is present in skb->data (it could be in fragments).
> >
> > pskb_may_pull() both validates the length and pulls fragmented data
> > into the linear buffer if necessary, making it safe to directly
> > access skb->data.
> >
> > Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> > Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames ac=
cording to their identifiers")
> > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > ---
> > v2: Use pskb_may_pull() instead of skb->len check to properly
> >      handle fragmented skbs (Eric Dumazet)
> > ---
> >   net/sched/em_canid.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> > index 5337bc462755..2214b548fab8 100644
> > --- a/net/sched/em_canid.c
> > +++ b/net/sched/em_canid.c
> > @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct=
 tcf_ematch *m,
> >       int i;
> >       const struct can_filter *lp;
> >
> > +     if (!pskb_may_pull(skb, sizeof(canid_t)))
>
> The EM CANID handles struct CAN frames in skb->data.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/can.h#n221
>
> The smallest type of CAN frame that can be properly handled with EM
> CANID is a Classical CAN frame which has a length of 16 bytes.
>
> Therefore I would suggest
>
>         if (!pskb_may_pull(skb, CAN_MTU))
>
> instead of only checking for the first element in struct can_frame.
>
> Many thanks and best regards,
> Oliver
>
>
> > +             return 0;
> > +
> >       can_id =3D em_canid_get_id(skb);
> >
> >       if (can_id & CAN_EFF_FLAG) {
>

