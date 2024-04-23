Return-Path: <netdev+bounces-90415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD88AE0E8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4568B23191
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEB15812B;
	Tue, 23 Apr 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdxFC3jB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE956B7E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864091; cv=none; b=Q2QxI4ZxlPvOdY8GdN+hPvvdmfqbE6ADA/jXtrVJFDtHbut4Zmh82J0RzseK39sFlJ4RBWW+LfRnSziAgoFaWZlvmyUwKXabySfl7h86wdyjZ0o3ccq7bjUF4U3yznu98aMsgYZj6non0VhJ1MdFmdA3eZnuHtJrN1ymjy+Ra1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864091; c=relaxed/simple;
	bh=1e/1Y2JY4gbUEnjrVk68w7mM+tQjn/QrtDDXW8Kr264=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5vScbg9QARjGk7CBBpY9OqmPAUnfEtznyDbu921/vGdOrXiDQRGC+b9fLMn48gjBGEi/1Ppy8gbPA2ZmdZ/6BNvO1zAlTQyJDvAJAVyaKe7PxlX+K7aGBCQfT3lqW+a0FkFwanQX2nrcEe5P1SYwqixPtRGu2nGMbUjX/m2JIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdxFC3jB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713864088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1e/1Y2JY4gbUEnjrVk68w7mM+tQjn/QrtDDXW8Kr264=;
	b=PdxFC3jBL2uULxcn8mkPGwjxiSs+E9cVf7Dw1gpcsKG/xjezHWNg9bDSCwZ1N7Fk3IzPEY
	fCBWFcl4kaqR5XPJ3EsvXoZqiQ1EXsLEJmjBj77QSFT2xK6YquW++q1MKwiQEiUIImnqbg
	jb2XxNaa0t4ed5jkmkhba9FudU3Zmi8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-wGbdXjJmO2yk8mTdWsqcxQ-1; Tue, 23 Apr 2024 05:21:26 -0400
X-MC-Unique: wGbdXjJmO2yk8mTdWsqcxQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3450bcc1482so740339f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 02:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864085; x=1714468885;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1e/1Y2JY4gbUEnjrVk68w7mM+tQjn/QrtDDXW8Kr264=;
        b=xCtBmsLsc1b/VN3vpqlazQE7NFwgxePQuSPaad3EJimfaflOvF5wps3o42mCLf+0Cw
         a3tB89nrmzDQpRy1kVY0BEVGd/dxeBR/7BReU2+iiIvAFcPk6S1HvN/r4sE8UeT5U8AC
         x/rnuKlLElE70cjAXFTphSL0mMhoXYuoFZrzNJhqmcqQjCSqJn7J6V1o+CCNeuEIi7jm
         KYOU5H9GARcvQe2RtfjnLhzePgxrQ/047MFYpvXZoSPtw0/1bwM8RxmMdb+Wd6XTRUPB
         JrXIvQeq5LZiO2Q3iLBf595AbkklEe5lf3moc55liRwYnKBd8fySHI6inKFha4U7iwCw
         cbHw==
X-Gm-Message-State: AOJu0YxUHJZALcy2iTGle/9XQjs/9H16oT71gKJ2Gd28aN/ZRoerWq8w
	sb4Fk9ahaNF54hAVL8W1/ueJ5fpMWt0Ss6D6BzcIZeLzSLNCNQpTTx8aI9JwG17vYUA7jJpnQx+
	vUKKp6+TzoHklzTljYU9PwAVvWiy69qNnQmP6l5vaniX2YsyF9RlVVA==
X-Received: by 2002:a05:6000:c1:b0:34a:f99:3078 with SMTP id q1-20020a05600000c100b0034a0f993078mr7909325wrx.5.1713864085705;
        Tue, 23 Apr 2024 02:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDE5EbF0JqJR2Nuz/wfQPYXLDLxGOcDtpl+xTgOXp3xOUQlvLLmMZUVbn6T5fl0ZHQxsMoiA==
X-Received: by 2002:a05:6000:c1:b0:34a:f99:3078 with SMTP id q1-20020a05600000c100b0034a0f993078mr7909302wrx.5.1713864085330;
        Tue, 23 Apr 2024 02:21:25 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id b8-20020adfe308000000b003436a3cae6dsm14050944wrj.98.2024.04.23.02.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:21:24 -0700 (PDT)
Message-ID: <7ce1a0dba3cc100e6f73a7499b407176a99c0aa9.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net/sched: fix false lockdep warning on
 qdisc root lock
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, Eric Dumazet
 <edumazet@google.com>,  Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, renmingshuai@huawei.com, jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, xmu@redhat.com, Christoph Paasch
 <cpaasch@apple.com>,  Jamal Hadi Salim <jhs@mojatatu.com>, Maxim
 Mikityanskiy <maxim@isovalent.com>, Victor Nogueira <victor@mojatatu.com>
Date: Tue, 23 Apr 2024 11:21:23 +0200
In-Reply-To: <CAKa-r6tZkLX8rVRWjN6857PLiLQtp92O114FYEkXn6pu9Mb27A@mail.gmail.com>
References: 
	<7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
	 <CAKa-r6tZkLX8rVRWjN6857PLiLQtp92O114FYEkXn6pu9Mb27A@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 16:01 +0200, Davide Caratti wrote:
> hello,
>=20
> On Thu, Apr 18, 2024 at 3:50=E2=80=AFPM Davide Caratti <dcaratti@redhat.c=
om> wrote:
> >=20
>=20
> [...]
>=20
> > This happens when TC does a mirred egress redirect from the root qdisc =
of
> > device A to the root qdisc of device B. As long as these two locks aren=
't
> > protecting the same qdisc, they can be acquired in chain: add a per-qdi=
sc
> > lockdep key to silence false warnings.
> > This dynamic key should safely replace the static key we have in sch_ht=
b:
> > it was added to allow enqueueing to the device "direct qdisc" while sti=
ll
> > holding the qdisc root lock.
> >=20
> > v2: don't use static keys anymore in HTB direct qdiscs (thanks Eric Dum=
azet)
>=20
> I didn't have the correct setup to test HTB offload, so any feedback
> for the HTB part is appreciated. On a debug kernel the extra time
> taken to register / de-register dynamic lockdep keys is very evident
> (more when qdisc are created: the time needed for "tc qdisc add ..."
> becomes an order of magnitude bigger, while the time for "tc qdisc del
> ..." doubles).

@Eric: why do you think the lockdep slowdown would be critical? We
don't expect to see lockdep in production, right?=C2=A0

Enabling lockdep will defeat most/all cacheline optimization moving
around all fields after a lock, performances should be significantly
impacted anyway.

WDYT?

The HTB bits looks safe to me, but it would be great if someone @nvidia
could actually test it (AFAICS mlx5 is the only user of such
annotation).

Thanks!

Paolo


