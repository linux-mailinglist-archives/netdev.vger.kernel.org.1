Return-Path: <netdev+bounces-52600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A537FF5A6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405DF281904
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0F54FB5;
	Thu, 30 Nov 2023 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLitX35K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2510DB
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701361826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLzc391iIUMNmGbR/ryUq+dyTvKQD1epnStnct8zYLw=;
	b=CLitX35K5vkRXwVrM1eDHeNVuHIImoJCWwq/4WpusVP3G3SQpqLQ7Rz/5+HZ7sGrDq/xUW
	BPs0dWN/33zg/AMlQ3lypyFMTTwxvTgYFQtOLk0GV9Cc6yXsMg9+EezO9BWbDuOd55bcij
	8ABpx+1OWoledVKsI+qMvrEDjM/GWm0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Ksf3lTbzOciboIFFa1ym_A-1; Thu, 30 Nov 2023 11:30:25 -0500
X-MC-Unique: Ksf3lTbzOciboIFFa1ym_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-407d3e55927so9626285e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361824; x=1701966624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLzc391iIUMNmGbR/ryUq+dyTvKQD1epnStnct8zYLw=;
        b=eTMI/ysPQ8nHagJCAlkApUyXB7AYyDGnQr4tXY8+g4TTzCbsauHAMFx2vx9he57way
         KQPlIIOgNl5Y5+zpJI/0U6jwrXkgHkkFMWLni/0xXfUndQQSVNi+EK/tT7hidKafAddF
         WRSRB0YCiG2m6676cbhtoYXNFDydW8Zj/s1G3CdQiwoYziGakI42w9rJaPWJsrmLUZWo
         o+cLD2sn9jDbUPJOr1NdkOeqIDSEOwXZnw0CkmK39Rtj6AFh4zONMT0ISXqa15S46QYA
         H/suIKpC5m2J7wZlySVe4UIjqK030ERyo+8ybvTqaseTs4swTlgTEydLWUGBklOXr3ir
         t8Vw==
X-Gm-Message-State: AOJu0Yw6wGgVZ/tJIhcVUy/k9+3u38mQWkw1sNu7FghuyfpWAeixZtTX
	rrjx9R3hc43ilMjdNguLbS9nXRLjzbYTGuvaQgB01LIE0gf0PYWSQog27AmXS+LYnRpnR4+YJoN
	R50Spi48DBO759Hod
X-Received: by 2002:a05:600c:5250:b0:40b:4ff7:76f1 with SMTP id fc16-20020a05600c525000b0040b4ff776f1mr5670431wmb.1.1701361823912;
        Thu, 30 Nov 2023 08:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6ZmCt1J7D/B1VoxZvbS1ykVi2lw4gLHJqAO4JgKM+lJN41pX2pZoGCMGQMVD717UPKOhkGA==
X-Received: by 2002:a05:600c:5250:b0:40b:4ff7:76f1 with SMTP id fc16-20020a05600c525000b0040b4ff776f1mr5670403wmb.1.1701361823514;
        Thu, 30 Nov 2023 08:30:23 -0800 (PST)
Received: from debian (2a01cb058918ce00f1553101655f9ec6.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:f155:3101:655f:9ec6])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040b4b2a15ebsm2489192wmq.28.2023.11.30.08.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:30:23 -0800 (PST)
Date: Thu, 30 Nov 2023 17:30:20 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net-next v3] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZWi4nCeJTLsVt6J5@debian>
References: <49a05d612fc8968b17780ed82ecb1b96dcf78e5a.1701358163.git.gnault@redhat.com>
 <CANn89iJ4W3DSGVm89CQ8yz=VYyLeCY4_4cOJuGULoxft8ezO-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ4W3DSGVm89CQ8yz=VYyLeCY4_4cOJuGULoxft8ezO-w@mail.gmail.com>

On Thu, Nov 30, 2023 at 05:17:57PM +0100, Eric Dumazet wrote:
> On Thu, Nov 30, 2023 at 4:40 PM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> > that are bound but haven't yet called connect() or listen().
> >
> > The code is inspired by the ->lhash2 loop. However there's no manual
> > test of the source port, since this kind of filtering is already
> > handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> > at a time, to avoid running with bh disabled for too long.
> >
> > There's no TCP state for bound but otherwise inactive sockets. Such
> > sockets normally map to TCP_CLOSE. However, "ss -l", which is supposed
> > to only dump listening sockets, actually requests the kernel to dump
> > sockets in either the TCP_LISTEN or TCP_CLOSE states. To avoid dumping
> > bound-only sockets with "ss -l", we therefore need to define a new
> > pseudo-state (TCP_BOUND_INACTIVE) that user space will be able to set
> > explicitly.
> >
> > With an IPv4, an IPv6 and an IPv6-only socket, bound respectively to
> > 40000, 64000, 60000, an updated version of iproute2 could work as
> > follow:
> >
> >   $ ss -t state bound-inactive
> >   Recv-Q   Send-Q     Local Address:Port       Peer Address:Port   Process
> >   0        0                0.0.0.0:40000           0.0.0.0:*
> >   0        0                   [::]:60000              [::]:*
> >   0        0                      *:64000                 *:*
> >
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >
> > v3:
> >   * Grab sockets with sock_hold(), instead of refcount_inc_not_zero()
> >     (Kuniyuki Iwashima).
> >   * Use a new TCP pseudo-state (TCP_BOUND_INACTIVE), to dump bound-only
> >     sockets, so that "ss -l" won't print them (Eric Dumazet).
> >
> 
> 
> > +pause_bind_walk:
> > +                       spin_unlock_bh(&ibb->lock);
> > +
> > +                       res = 0;
> > +                       for (idx = 0; idx < accum; idx++) {
> > +                               if (res >= 0) {
> > +                                       res = inet_sk_diag_fill(sk_arr[idx],
> > +                                                               NULL, skb, cb,
> > +                                                               r, NLM_F_MULTI,
> > +                                                               net_admin);
> > +                                       if (res < 0)
> > +                                               num = num_arr[idx];
> > +                               }
> > +                               sock_gen_put(sk_arr[idx]);
> 
> nit: this could be a mere sock_put(), because only full sockets are
> hashed in bhash2[]

Yes, makes sense.
I'll send a v4.

> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 


