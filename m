Return-Path: <netdev+bounces-55318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F980A5DC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAD91C20E1D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCD1E529;
	Fri,  8 Dec 2023 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyh7IfkS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7F173B
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702046863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OyK/hwOtOLcmVz6X7PhUXWLJeC6+muyilj4AjJlSQo=;
	b=Dyh7IfkS0DUT8vP9u7d4q0Hgwh68C9/aHiOGfEWOQrlrMDJm4Z7F27gtCtqYAXUzKCktLw
	9IrH/gJeDHk47/l7Pa9YZzz9x2/30pZJSdiSvl95Mp8SD/OAu8dG4nWdkzxKJuIo0UvQK6
	knwfotsoYzpPKQGge99fHwxFGLc7+Eg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-pUijbZdgNCKuJNibZy7C6w-1; Fri, 08 Dec 2023 09:47:40 -0500
X-MC-Unique: pUijbZdgNCKuJNibZy7C6w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77f54de7f10so49540085a.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 06:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702046860; x=1702651660;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OyK/hwOtOLcmVz6X7PhUXWLJeC6+muyilj4AjJlSQo=;
        b=mGSTaxfSr0Myuv+f1tgNfCU2CN0djCxBw/j8GDSLYOCRhP1V/JckalwevzlyrFYWxk
         huUaO0fWE+9WScnFcX9ryhvM9ZC8bFiVGwycHAhcaTpkZJ5XxElXngk1KUGQeuJbN2Ng
         TcXE31ID0+F0zoi54HEeZDDWMDJM4ys4z9C9rtO+1yU8bS2x+FO50p9TdaMhXh/gfRMy
         Iz2/2qn1TkleJrR158NWzjkN4HLikaJS4D39v9U5uz6U43pdIpsKDBSFtlwEdNaJEETV
         f1csU1Xwz8mG46zVFwnksMIuObrPns7SarjrbYxU98ZrHRS7SC53ZFgMZNWAyK1aS00J
         tK8g==
X-Gm-Message-State: AOJu0YzmN/PzasvDiljRWaF7lHqOCdYl8+WPCs3fnvWVNxALY1A1H074
	xe00QMDFxsh8RKgiDxf7o4Q21rqYsXgeAiyL13tZN3XUDxjslOlValANKG7/uzfA8nh2tHqudRL
	pwSm5ZC+Stw8Bt0Dk
X-Received: by 2002:a05:620a:12fc:b0:77f:9a0:4c0b with SMTP id f28-20020a05620a12fc00b0077f09a04c0bmr189735qkl.106.1702046859814;
        Fri, 08 Dec 2023 06:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS8oTk7W/sdXJxFVN3x8zdP6FLYD5tfQZpwV95j+7itXBMVNqFHiJaPRhZ+yDKJ0sbtIxg7g==
X-Received: by 2002:a05:620a:12fc:b0:77f:9a0:4c0b with SMTP id f28-20020a05620a12fc00b0077f09a04c0bmr189720qkl.106.1702046859556;
        Fri, 08 Dec 2023 06:47:39 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a13e600b0077f287b2393sm733803qkl.63.2023.12.08.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:47:38 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
References: <20231115210509.481514-1-vschneid@redhat.com>
 <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
 <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
 <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
Date: Fri, 08 Dec 2023 15:47:35 +0100
Message-ID: <xhsmh8r64bvjs.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 23/11/23 17:32, Eric Dumazet wrote:
> Again, I think you missed some details.
>
> I am OOO for a few days, I do not have time to elaborate.
>
> You will need to properly track active timer by elevating
> tw->tw_refcnt, or I guarantee something wrong will happen.

I apologize if I'm being thick skulled, I've been staring at the code and
tracing on live systems and I still can't see the issue with refcounts.

The patch has the hashdance set the refcount to 4:
         * - one reference for bhash chain.
         * - one reference for ehash chain.
         * - one reference for timer.
         * - one reference for ourself (our caller will release it).

AFAICT, finding & using the socket via the ehash table comes with a refcount_inc
(e.g. __inet_lookup_established()).

Worst case, the lookup happens after programming the timer, and we get a
inet_twsk_deschedule_put(). This reduces the refcount by:

  3 via inet_twsk_kill():
   1 (sk_nulls_del_node_init_rcu())
   1 (inet_twsk_bind_unhash())
   1 (inet_twsk_put())
  1 via inet_twsk_put()

IOW 4 total. So we can have:

  tcp_time_wait()
    inet_twsk_hashdance();  // refcount = 4
    inet_twsk_schedule();   // timer armed

                            tcp_v4_rcv()
                              sk = __inet_lookup_skb(); // refcount = 5 (+1)
                              inet_twsk_deschedule_put(inet_twsk(sk));
                                inet_twsk_kill(tw) // refcount = 2 (-3)
                                inet_twsk_put(tw)  // refcount = 1 (-1)

    inet_twsk_put(tw) // refcount = 0 (-1)

__inet_hash_connect() can invoke inet_twsk_bind_unhash() by itself before
calling inet_twsk_deschedule_put(), but that just means it won't be done by
the latter, so the total refcount delta remains the same.

Thinking about it differently, this would mean that currently (without the
patch) another CPU can bring the refcount to 0 without disarming the timer,
because the patch is making the initial value one higher.

What am I missing?


