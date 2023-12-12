Return-Path: <netdev+bounces-56508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A554380F26F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B641C20A56
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC777F27;
	Tue, 12 Dec 2023 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cdGYhe6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38728AD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:28:04 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-dbcb0f0212aso1460742276.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702398483; x=1703003283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs9IfEbaw3oms8FcL73B55KEGPJ3PTlBNQTI40soCqQ=;
        b=cdGYhe6Z/IFrfPhUZN0yeKdsMy0B1JnC6bGdiP/g1e4C2VHRUIxi2tNk4vnUqciIBA
         vh8F1yr2F7q5R4gQZpD25SLg5q8YPwasRWfyKyQlzC4T5I9PJN207s3CI9Lj/PoQXnlu
         Ql1ZvmbSGEiXs2WUdrlMsKgpdwBII6glUw+7kLYyw11wADGaK46gAVxbi+3nIfjPI40P
         yJhFNBavpWC3BFOs0zBz9oCq6Ip620XgYXuYS+Lk3l2hXTcBwx4V9BWEUdg37ucM0vbt
         97/E2P/ujrld+eQ+KJy4CDEjG6Xm5U/mXOfzHvPE5GktcSE5pYo3l1lGuIPNo0IC2/ky
         8M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398483; x=1703003283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs9IfEbaw3oms8FcL73B55KEGPJ3PTlBNQTI40soCqQ=;
        b=jZHRrf/yWgczzNHQCkKfExOP7T6eVPbevOPwiK0X45TRx7SrLVocxbgUtsmGkhZIYH
         JtOgK1nCp4VUZEg15vZ5LfE9dNserlbphDuwpMR3Ob/9Rdqa9YHY62oFXg5FaLhTXx8v
         /5LyBhL8zQBsqi4s9h52wW2o2X628OkR1BZbsJTkI+0i0XgJ6gadh+EEGnqWGH5z/C3O
         gmr1z7t5CHu+/uKHsCWHc7fddeEKHKy9u836MpfhIkSfApRE8DHG6ysTgVz+aIs+RIy6
         ysSBW4JfhHdgtK1XW182gyBTs3DjrHxGRrbhKjT318cQIXL1FgvguJC5qV8i5B1GFINk
         aBjw==
X-Gm-Message-State: AOJu0Yy2/+Z09465JrRcza4AsWFXVmF7H61ABEhq+DM3lXXA12daqtVg
	ofb/ja3kGdQq/XSWpq9W6Dmvq2nlzqmGZ9WR+YDeag==
X-Google-Smtp-Source: AGHT+IGA+ze7KlxNzXvy8eMk/0diM7i/d3rjpcU+6yZ5yf23VZTAEKqBws/sF7bOKtMDjcKcwPvRDVRC+4LP6SVZz+o=
X-Received: by 2002:a81:c80b:0:b0:5df:5d59:7939 with SMTP id
 n11-20020a81c80b000000b005df5d597939mr4204578ywi.12.1702398483416; Tue, 12
 Dec 2023 08:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205205030.3119672-1-victor@mojatatu.com> <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org>
In-Reply-To: <20231211182534.09392034@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 12 Dec 2023 11:27:52 -0500
Message-ID: <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 9:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  5 Dec 2023 17:50:29 -0300 Victor Nogueira wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 4b84b72ebae8..f38c928a34aa 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3753,6 +3753,8 @@ static inline int __dev_xmit_skb(struct sk_buff *=
skb, struct Qdisc *q,
> >
> >       qdisc_calculate_pkt_len(skb, q);
> >
> > +     tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> > +
> >       if (q->flags & TCQ_F_NOLOCK) {
> >               if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(=
q) &&
> >                   qdisc_run_begin(q)) {
> > @@ -3782,7 +3784,7 @@ static inline int __dev_xmit_skb(struct sk_buff *=
skb, struct Qdisc *q,
> >  no_lock_out:
> >               if (unlikely(to_free))
> >                       kfree_skb_list_reason(to_free,
> > -                                           SKB_DROP_REASON_QDISC_DROP)=
;
> > +                                           tcf_get_drop_reason(to_free=
));
> >               return rc;
> >       }
> >
> > @@ -3837,7 +3839,8 @@ static inline int __dev_xmit_skb(struct sk_buff *=
skb, struct Qdisc *q,
> >       }
> >       spin_unlock(root_lock);
> >       if (unlikely(to_free))
> > -             kfree_skb_list_reason(to_free, SKB_DROP_REASON_QDISC_DROP=
);
> > +             kfree_skb_list_reason(to_free,
> > +                                   tcf_get_drop_reason(to_free));
>
> You stuff the drop reason into every skb but then only use the one from
> the head? Herm. __qdisc_drop() only uses the next pointer can't we
> overload the prev pointer to carry the drop reason. That means only
> storing it if we already plan to drop the packet.
>

So when we looked at this code there was some mystery. It wasnt clear
how to_free could have more than one skb.
According to: 520ac30f4551 Eric says:

"I measured a performance increase of up to 12 %, but this patch is a
prereq so that future batches in enqueue() can fly. "

I am not sure if the batch enqueue ever happened and if it didnt then
there's only one skb in that list... When 7faef0547f4c added the
reason code it assumed a single code for the "list" - so it felt safer
to leave it that way. I guess it will depend on if a list could exist
to rethink this. Eric?

> BTW I lack TC knowledge but struct tc_skb_cb is even more clsact
> specific today than tcf_result. And reserving space for drop reason
> in a state structure seems odd. Maybe that's just me.

It is not clsact main use - it is a scratchpad for all of tc:

struct qdisc_skb_cb {
        struct {
                unsigned int            pkt_len;
                u16                     slave_dev_queue_mapping;
                u16                     tc_classid;
        };
#define QDISC_CB_PRIV_LEN 20
        unsigned char           data[QDISC_CB_PRIV_LEN];
};

struct tc_skb_cb {
        struct qdisc_skb_cb qdisc_cb;

        u16 mru;
        u8 post_ct:1;
        u8 post_ct_snat:1;
        u8 post_ct_dnat:1;
        u16 zone; /* Only valid if post_ct =3D true */
};

cheers,
jamal

