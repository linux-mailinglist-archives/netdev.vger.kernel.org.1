Return-Path: <netdev+bounces-93257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A98BACB9
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C440E284128
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F0152E0B;
	Fri,  3 May 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAtGL2/f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7A152788
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740284; cv=none; b=EHIVgKJJ0BV1QJJqMiWg7OMu24O+oSe9aIXcPJt9a1CABxrSKaUHkDQIbYHn17+L8VHFIZdHX7al0Up3Fg5981Soyw+oz+p/+1X1vGQEXefgQnMu9J0a6xLACRHQ0AV1jTeTHkBqkwXcA/kMpVLRKplrfgkJzfxTfuStl6Tc7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740284; c=relaxed/simple;
	bh=V0gcIEcqSalv3/fVLg5lBpr0Bu02c9T1csHtptQshdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9V31hrxl1ud4CQPkSdKlDUdp+OfPIIgd4feNv931uhqbezc8ONDXO/qbedmNoW5qwbAwBVlKKfu1KMxUSOxuz82v5PJFHyqJJ1/4KiwqmlUg+fvMb2mY+iOWzBC1LlkW2XW2HbuUEULBt6Iz5Z0rJxtxXDe20Jp5hHaybV8ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAtGL2/f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714740282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Az0khoriimVE0rkTKhw4i0O+NudtfnmpiSEgKQscMIM=;
	b=NAtGL2/fP1UucHuME7rB5lBO+Q0j7Q4eFDezfwMdozF66plUl8ZQP3q3Hb/Yd1NEMhUItL
	SPnbL+AUZUkjz8zLrI/pDP73JOQ7ncY5OX9uEog8m1a+KHc29PhToQVzn7vEB34NQhWb3E
	5YjyT+7VIHO9bw3tOL60Bw/fUDx9PkI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-LoXVsL80MXSt6h6y9PBYpA-1; Fri, 03 May 2024 08:44:40 -0400
X-MC-Unique: LoXVsL80MXSt6h6y9PBYpA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so15515145e9.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 05:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740279; x=1715345079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Az0khoriimVE0rkTKhw4i0O+NudtfnmpiSEgKQscMIM=;
        b=s9QOyA/K5ZaeF0ONqeXrncoG8j+gMqRnh8EPp+GSjo4LMPB0qr5YUZmT4wX4H1PpZk
         UAewv8Lmi4fS2LwppgohhDM/V7GvGhrgPuPACFRVGJrSW/e9QBQV0ewG+WMRF5RC2kca
         xJwxpPBOrdn1cPglalxZXP4jfJVGwPAWZugcgYvhfKfHuOmdqNU4ORg6BmMmcaQMtTdc
         fKkL4bwxJ+AMqgBHjGcgP4yJAFbjoV8CZ9z1giQ+VlAyl3bhO9GA/9ZzTul1NoPA9hzd
         A3FqTt0YjsLz26xk2wD1ezPIu7uAM/1/BUKWkOrecS8BsTIafkLebgX0zeJrjXOsPjeO
         cMfg==
X-Forwarded-Encrypted: i=1; AJvYcCWGAv2NORtAakoGdDLEPUo6lcALQq0e82oo2PBBJrcx+EC6pte1h3MRD0kX5yO2HtzwvPhlk5VdNMbClJgoFLtcjBmxeyYA
X-Gm-Message-State: AOJu0YyuwcYcLNT9oMH82XZkecD3MY2QsmdkWFXEe2ydR3H7wox+9j3n
	pdZYni6b5MDkaMr/Zo6vR8FCX1KkciEHq7rJuzFNZD+8cNX+4OxvIgiey4ADTUIicBnVG++HY3H
	H/pum5OdT/OPsHLu4xOKuCzwk3xnd33aeQc9QuM7YDQzbNtrKCR5E7Q==
X-Received: by 2002:a05:600c:4fd4:b0:41b:ed36:e055 with SMTP id o20-20020a05600c4fd400b0041bed36e055mr2401105wmq.7.1714740279134;
        Fri, 03 May 2024 05:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5URmvk/c18CX+cp/8yglaLbSG2wdKBWtyuBzLoY6EER1whanISM8mry2yc6hF5aPM5IVI/Q==
X-Received: by 2002:a05:600c:4fd4:b0:41b:ed36:e055 with SMTP id o20-20020a05600c4fd400b0041bed36e055mr2401069wmq.7.1714740278506;
        Fri, 03 May 2024 05:44:38 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418a9961c47sm5405639wms.47.2024.05.03.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:44:37 -0700 (PDT)
Date: Fri, 3 May 2024 14:44:37 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
Message-ID: <ZjTcNVOT9x8e4UG3@dcaratti.users.ipa.redhat.com>
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
 <CANn89iJJefUheeur5E=bziiqxjqmKXEk3NCO=8em4XVJThExMQ@mail.gmail.com>
 <ZjE587MsVBZA61fJ@dcaratti.users.ipa.redhat.com>
 <CANn89iJRA-1z60cvGnbqYa=Ua-ysR9uHufkrFmQGRmN-4Dod2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJRA-1z60cvGnbqYa=Ua-ysR9uHufkrFmQGRmN-4Dod2Q@mail.gmail.com>

hello Eric,

On Tue, Apr 30, 2024 at 08:43:22PM +0200, Eric Dumazet wrote:
> On Tue, Apr 30, 2024 at 8:35 PM Davide Caratti <dcaratti@redhat.com> wrote:
> >

[...]

> > > For consistency with the other path, what about this instead ?
> > >
> > > This would also  allow a qdisc goten from an rcu lookup to allow its
> > > spinlock to be acquired.
> > > (I am not saying this can happen, but who knows...)
> > >
> > > Ie defer the  lockdep_unregister_key() right before the kfree()
> >
> > the problem is, qdisc_free() is called also in a RCU callback. So, if we move
> > lockdep_unregister_key() inside the function, the non-error path is
> > going to splat like this
> 
> Got it, but we do have ways of running a work queue after rcu grace period.

this would imply scheduling a work that does qdisc_free() + lockdep_unregister_key()
in qdisc_free_cb(). I can try that, but maybe the issue is different:

> Let's use your patch, but I suspect we could have other issues.
> 
> Full disclosure, I have the following syzbot report:
> 
> WARNING: bad unlock balance detected!
> 6.9.0-rc5-syzkaller-01413-gdd1941f801bc #0 Not tainted
> -------------------------------------
> kworker/u8:6/2474 is trying to release lock (&sch->root_lock_key) at:
> [<ffffffff897300c5>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
> [<ffffffff897300c5>] dev_reset_queue+0x145/0x1b0 net/sched/sch_generic.c:1304
> but there are no more locks to release!

I don't understand how can this "imbalance" be caused by lockdep_unregister_key()
being called too early. I'm more inclined to think that this splat is due to UaF
similar to those that we saw a couples of days ago. Is syzbot still
generating report like the one above?

thanks,

-- 
davide


