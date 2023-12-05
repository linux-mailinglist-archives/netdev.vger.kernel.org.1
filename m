Return-Path: <netdev+bounces-53907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937AA8052EB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F94328178A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B8697A3;
	Tue,  5 Dec 2023 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avWgSGhP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34B1B2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701775938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEJE+KjZNyiwZrf3ZQWOaI0waeXTg0m3LsEIvZUCCiU=;
	b=avWgSGhPmkjYs2QS57/LGsd8a91bZk5kaAE3N3TJSH6u9UzOz0eCdjWUium3LSwzjeYPLl
	VkV6LGCnyJ0OXkgOuult8SeD7hQ4rIEJicikeBMN1mLbUY1dczcFbGIrGwXnMbpwU+D31i
	hi7SaR3QzzyQschqTeiFX9A4Q8dueVY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-4sGl77SSMzK3W5cS0NmBnA-1; Tue, 05 Dec 2023 06:32:17 -0500
X-MC-Unique: 4sGl77SSMzK3W5cS0NmBnA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c9947db19bso10432241fa.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775936; x=1702380736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEJE+KjZNyiwZrf3ZQWOaI0waeXTg0m3LsEIvZUCCiU=;
        b=doZWvPDGqQwsDdmJ1UyRfzFXUAfERH8+GEn06oRftQWWab5cv8m7icLQ2eGJZs0Y8Z
         3VSOIOoa9JFhPs2wFEUBy2IHAS3NOhn7asG0kUPoyTDmzqrNemk4EMmx1kC+FooDfGI0
         D5HHYMcUXAUHINJvmrla0xytNQe7yYrxio60z25TpcHg0UqzRr0kGQ9uZQWHJDI9Mczk
         YSvmnWP71Lo+WUGuFJJ+c8gC+6qwYJlduJ90Sg0NI1rnuJXN97W0DK9j//b6MO0S4cy6
         rMdpcmOGAWkhsBlqzQANoVeAJhJ1MOc1rjVMkNyjVlXDdGDsIsJSzJEh6/YiKd1cOAki
         MIig==
X-Gm-Message-State: AOJu0YwtSU6J0rL62R63QN9QbSo/+ko5wKtqL1fOPwA/mC9aHEoG0CsP
	gTfhXAZCAokd+yAMYTj55eAqeWRzX40FllNZXveexZTB+qo9N/7Ws+qlMvrhrQJbLrRtfuJRAvx
	LbaRRlp935Qalcw0A
X-Received: by 2002:a2e:868d:0:b0:2ca:2db:23fa with SMTP id l13-20020a2e868d000000b002ca02db23famr3090576lji.5.1701775936074;
        Tue, 05 Dec 2023 03:32:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/xOUP6Bk2iKrrYtgdV9IlpPVNzg5bcqbV0Dj6e1dMctwHGD3r+BKnRsp74ReUpx1NBbABNg==
X-Received: by 2002:a2e:868d:0:b0:2ca:2db:23fa with SMTP id l13-20020a2e868d000000b002ca02db23famr3090559lji.5.1701775935723;
        Tue, 05 Dec 2023 03:32:15 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090635c700b009fc576e26e6sm6495163ejb.80.2023.12.05.03.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:32:15 -0800 (PST)
Message-ID: <f0401a8cf451194733457fcedb5c44c9b0c96731.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] net: sched: Move drop_reason to struct
 tc_skb_cb
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira
	 <victor@mojatatu.com>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
Date: Tue, 05 Dec 2023 12:32:13 +0100
In-Reply-To: <7315d962-0911-81b9-7e60-452ab71e3193@iogearbox.net>
References: <20231201230011.2925305-1-victor@mojatatu.com>
	 <20231201230011.2925305-2-victor@mojatatu.com>
	 <7315d962-0911-81b9-7e60-452ab71e3193@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-05 at 12:06 +0100, Daniel Borkmann wrote:
> On 12/2/23 12:00 AM, Victor Nogueira wrote:
> > Move drop_reason from struct tcf_result to skb cb - more specifically t=
o
> > struct tc_skb_cb. With that, we'll be able to also set the drop reason =
for
> > the remaining qdiscs (aside from clsact) that do not have access to
> > tcf_result when time comes to set the skb drop reason.
> >=20
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >   include/net/pkt_cls.h     | 14 ++++++++++++--
> >   include/net/pkt_sched.h   |  1 +
> >   include/net/sch_generic.h |  1 -
> >   net/core/dev.c            |  5 +++--
> >   net/sched/act_api.c       |  2 +-
> >   net/sched/cls_api.c       | 23 ++++++++---------------
> >   6 files changed, 25 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index a76c9171db0e..7bd7ea511100 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> > @@ -154,10 +154,20 @@ __cls_set_class(unsigned long *clp, unsigned long=
 cl)
> >   	return xchg(clp, cl);
> >   }
> >  =20
> > -static inline void tcf_set_drop_reason(struct tcf_result *res,
> > +struct tc_skb_cb;
> > +
> > +static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
> > +
> > +static inline enum skb_drop_reason
> > +tc_skb_cb_drop_reason(const struct sk_buff *skb)
> > +{
> > +	return tc_skb_cb(skb)->drop_reason;
> > +}
> > +
> > +static inline void tcf_set_drop_reason(const struct sk_buff *skb,
> >   				       enum skb_drop_reason reason)
> >   {
> > -	res->drop_reason =3D reason;
> > +	tc_skb_cb(skb)->drop_reason =3D reason;
> >   }
> >  =20
> >   static inline void
> > diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> > index 9fa1d0794dfa..f09bfa1efed0 100644
> > --- a/include/net/pkt_sched.h
> > +++ b/include/net/pkt_sched.h
> > @@ -277,6 +277,7 @@ static inline void skb_txtime_consumed(struct sk_bu=
ff *skb)
> >  =20
> >   struct tc_skb_cb {
> >   	struct qdisc_skb_cb qdisc_cb;
> > +	u32 drop_reason;
> >  =20
> >   	u16 mru;
>=20
> Probably also makes sense to reorder zone below mru.

Or move 'zone' here. It's very minor but I would prefer the latter ;)
(and leave the hole at the end of the struct)

Cheers,

Paolo


