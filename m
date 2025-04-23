Return-Path: <netdev+bounces-185268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA0A9991E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3CE442D93
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646C190472;
	Wed, 23 Apr 2025 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srC6GUeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F1139566
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438587; cv=none; b=pYHx6q6jKvUOe+YKgMGukbV9Z5bY8R3FmBV2JEdbEDgz/I2YKZ2g001cGmznAyH04gYaVaj4+PR4A2wC9dh5aMYU4cSJbGjUlXqxg8EpVatyfT3mUqqAR7CcpQd+bchSDa/nPS/kLIH/7uggT+R78OQFc5rJI6cvxZKTkWcgy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438587; c=relaxed/simple;
	bh=LFMvKrt+NeQG6HVm9/qE5kZikjR5SUoTf0b4leEdIu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0WZhoWYW4SfC3C1DRhbzatQ6R9bvg/ZNHmwcy8QBX3E376GG9y42vCnFVZTEXhYqkSujC/qzXotYuJzj59A9qv+dCbx74A9A2OFtpPMldOBW1Hs4YtzpgVNRL8iei+tSat0nu0U0da3vpMY9BH2WrAwuW++j6JyZwvRuyDmD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srC6GUeF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so56945ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745438585; x=1746043385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFMvKrt+NeQG6HVm9/qE5kZikjR5SUoTf0b4leEdIu4=;
        b=srC6GUeF+o8aXR3d5i9KqPx9nzYOMQNYy5VxW00+7l1bqQY5xadAU7j6v2qzDCcdF9
         idoYiWww+YyryB0b6uKiGbpe/KDpKiZzbfmuprJebhB+95c12zxu4jxUKBHYh/71ICSS
         7do+vqpH2DoG4GxlTnL9TrFri0TSVZK0M6nsdkrDX7X9J2v4lYHTKmgzCOKm0paw+X/2
         f8QSNRhplosnZ0J8toI1IjTAmcvokJB5yEmqO014XIJzlqlDSgGLI45G9ABzBGrbvEmp
         Unq078vOQ8Pq7teSi5g69qycoTA7CEI0erbNrxiD46MdhjWIgOSVZgs71xOroa/5lKHM
         TY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745438585; x=1746043385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFMvKrt+NeQG6HVm9/qE5kZikjR5SUoTf0b4leEdIu4=;
        b=uJB3iuMqiVg6/atTTSNELpSACfChCcEn3gxDYsjs+q8BdvTJ7zfhn5e1JagXOXCMmP
         dbz4UuZs6mnDd1i/nssDQPcEP7v3mDFVEW3biVvFGg2vndtx78Yy+nzth/kiYaBlDBTa
         uFJ1KwBFB+LU/uKX6NjNMiA2l8S9lLwwVGxmQ0y01XSltgh+o+nqCmyN37tDgWwXDOrK
         uw5njMo7rWt5JyOSNLEvNvA/2sTY05plHESG/b6dQOYX7mTh+x+EWUmlw0jqE8f5SutH
         kJoGBK3GE0Yn2K1uRYbpfYzVdCOPMWnGD+jpL7jSc6UOEBNMoxSIoZcJItRgz0Qsvxzh
         VrCA==
X-Forwarded-Encrypted: i=1; AJvYcCXF5elQDEfAJSq3IbOWYBNHluCQx7oAfIskYFV2+Ou6MW5T0K7DTl+iArmqkLiQHO1tY4w+5nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4Sw12coRUe3Vhv94haPfvswuKKPMCjEjwASoBBZF0qwZyeTH
	j6EQitiThEkLg2qfvLPXxYR3JFht4sxli1ooAiK6rmdpjGJZFebTel4193HSvQktxB93g1DQrJL
	r3Cn7FW+ziIVvK77C0nEMmkAQL9pfYRW98I6z
X-Gm-Gg: ASbGncs32mGPAEz8OhqyXsGVMlupDRytkYH+QpXc4N7b2l3fMgfdUC9Pj017uFgw3Hp
	kjhwzjLw70MPD9j8cCooYFJU8QLdn0L9ibmJhZvJnCzCe/s41CKh2nwDidP0G0VS0Mlh8QpheM0
	lo+gvBkiZ+zaTYP12OiYRJqMVQnvjAzznWy3AiB36Klzc6rWzf5YxIV8GAQO7mj7g=
X-Google-Smtp-Source: AGHT+IHOOgkDEz1BzB1Huw4IYNV20kvslf1WKtNl6e2FLaUj1MbSuD54Lz6m4FZxewCwS2cHuUm5X2HTPXALPgYGuak=
X-Received: by 2002:a17:903:2384:b0:216:27f5:9dd7 with SMTP id
 d9443c01a7336-22db233b7d5mr546065ad.11.1745438585345; Wed, 23 Apr 2025
 13:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421222827.283737-1-kuba@kernel.org>
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 13:02:52 -0700
X-Gm-Features: ATxdqUF4PdCWIt3lwFgLq_7phV68lTaEn8SQI7vMvQH2u2CmChWJj90qNffBd64
Message-ID: <CAHS8izMYF__OsryoH6wyvv8wf57RHWHH8i4z8AggYZVvNqH2TQ@mail.gmail.com>
Subject: Re: [RFC net-next 00/22] net: per-queue rx-buf-len configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk, 
	asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com, 
	dtatulea@nvidia.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Add support for per-queue rx-buf-len configuration.
>
> I'm sending this as RFC because I'd like to ponder the uAPI side
> a little longer but it's good enough for people to work on
> the memory provider side and support in other drivers.
>

May be silly question, but I assume opting into this is optional for
queue API drivers? Or do you need GVE to implement dependencies of
this very soon otherwise it's blocking your work?

> The direct motivation for the series is that zero-copy Rx queues would
> like to use larger Rx buffers. Most modern high-speed NICs support HW-GRO=
,
> and can coalesce payloads into pages much larger than than the MTU.
> Enabling larger buffers globally is a bit precarious as it exposes us
> to potentially very inefficient memory use. Also allocating large
> buffers may not be easy or cheap under load. Zero-copy queues service
> only select traffic and have pre-allocated memory so the concerns don't
> apply as much.
>
> The per-queue config has to address 3 problems:
> - user API
> - driver API
> - memory provider API
>
> For user API the main question is whether we expose the config via
> ethtool or netdev nl. I picked the latter - via queue GET/SET, rather
> than extending the ethtool RINGS_GET API. I worry slightly that queue
> GET/SET will turn in a monster like SETLINK. OTOH the only per-queue
> settings we have in ethtool which are not going via RINGS_SET is
> IRQ coalescing.
>
> My goal for the driver API was to avoid complexity in the drivers.
> The queue management API has gained two ops, responsible for preparing
> configuration for a given queue, and validating whether the config
> is supported. The validating is used both for NIC-wide and per-queue
> changes. Queue alloc/start ops have a new "config" argument which
> contains the current config for a given queue (we use queue restart
> to apply per-queue settings). Outside of queue reset paths drivers
> can call netdev_queue_config() which returns the config for an arbitrary
> queue. Long story short I anticipate it to be used during ndo_open.
>
> In the core I extended struct netdev_config with per queue settings.
> All in all this isn't too far from what was there in my "queue API
> prototype" a few years ago. One thing I was hoping to support but
> haven't gotten to is providing the settings at the RSS context level.
> Zero-copy users often depend on RSS for load spreading. It'd be more
> convenient for them to provide the settings per RSS context.
> We may be better off converting the QUEUE_SET netlink op to CONFIG_SET
> and accept multiple "scopes" (queue, rss context)?
>
> Memory provider API is a bit tricky. Initially I wasn't sure whether
> the buffer size should be a MP attribute or a device attribute.
> IOW whether it's the device that should be telling the MP what page
> size it wants, or the MP telling the device what page size it has.

I think it needs to be the former. Memory providers will have wildly
differing restrictions in regards to size. I think already the dmabuf
mp can allocate any byte size net_iov. I think the io_uring mp can
allocate any multiple of PAGE_SIZE net_iov. MPs communicating their
restrictions over a uniform interface with the driver seems difficult
to define. Better for the driver to ask the pp/mp what it wants, and
the mp can complain if it doesn't support it.

Also this mirrors what we do today with page_pool_params.order arg
IIRC. You probably want to piggy back off that or rework it.


--=20
Thanks,
Mina

