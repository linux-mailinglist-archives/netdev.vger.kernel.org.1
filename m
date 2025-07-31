Return-Path: <netdev+bounces-211201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD2B17232
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500DE3A5EAE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CD2D0C84;
	Thu, 31 Jul 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S8AovRPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729522425E
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969144; cv=none; b=LzSXYqtNo1CMHFhxs25BvsCGV7/+yyH+Fwc95PVcWIkHjjPfDoxO4zKxSVYGwMF6JrEwHsCPFDvbscC/NWVEdYPLz2HB88TPKhV0NtHdnjSkLObowzumvZDcshY62cTeQMIP2xTESnanOA1G2PS72XRF6ze5GAhgufGMLva0HEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969144; c=relaxed/simple;
	bh=kOpGIhGHdpLiDUIPN5tfSWZvVyiUegYsJVHK2hDz4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL3bRTsbe/3wfM9gZ1v8YBNCnekVTeoWuT3zFsuhyya2kows7+/jipJv9uPoHQLEoDxeu3N56JV5Oi8KMfV5dtBzrOKahkqT1vMsESuRdu57crD9MrzJxEfKDx2/v2knP/8eZgZX4S4dsgAsUMi+Kbv3YghqYFeHOQk8ty8SF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8AovRPG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45617887276so5503645e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753969140; x=1754573940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnez6DValapR3ZUUqRysmzvL+YRs62blvNyrOJaANrI=;
        b=S8AovRPG45f6NhxVcuX//ZvxSrIcsANJtq5pFbo0l/nMYuky+MCcCw2h5nDDixhMc1
         tqkqlofVIeel11Cx0GCsU9jmWlLbctw8FmXC+Q8dLjYJTm/kpVCQ+uiLZP79SuqVk59g
         nXbqxqFiY9YkfX4Xl++Xm573IE5DoU3QqrGPyguGc6sFJh/MQ7JtswMXIvruqO8Kg8qH
         9+yPQJNSzyOSJxBpZTHU1vmMlD1hpFXNvagu48inn8ndWEMAjVC1xpVuKJYNQFrBjb3b
         yHHLbEI/xWt3rHTvqBVhpBnhsSz+HgluW8dBya1S0BGVx1+uzJ9rstpw0Md0nKzXgIcA
         lgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969140; x=1754573940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnez6DValapR3ZUUqRysmzvL+YRs62blvNyrOJaANrI=;
        b=w4onQYmbdUijCmIFPqPvMW5mMEFV03IRb+r/umeA5hvw6RksCPv0yajChLJuY/QN9q
         ffOzu/22o3ttrkZM4S5DqNPAup+UHkAVlL7C/2Y14rZI8L9u1aaCLPCRYfiYYJrIiB9G
         xE+v4esUm9waZdZad2qDz27zCDLtpXeFCjoWY1nZrEo7+WhQN7gP3QPvXvrDTnnK82f+
         ehy2F12+nz+ZEIJ+U1zKebSZ/8o2CrjIs+mZHuL2NYoJKGyxvt0GOIx8l0dMGCt9+yiC
         NCQMMTB9x+Pd0fKLMVgfBtQPqhwUYrbiGvo58/HGU9LIBEmxQNzrAS8F0Az+IUKNPN7D
         KeTA==
X-Forwarded-Encrypted: i=1; AJvYcCWo5fetz/hkUJGdO6zeoMAF8yrC0g9hbXdWmW4VAvlKefFcdyp7h+ulx3IPvmTtdVs/fmcpC8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvN0yTpUySKy7dDt2z4Rey84B76RzOrCsnvJgG+bxksgCkkzHz
	nfhDbwJNJB4R6N50EVNfjZJdKBXrTTQXo8z16PfW5FlN8yg2UY/xjT+aR2x3QeTpSbE=
X-Gm-Gg: ASbGnctVH3oGAXSZVHRzQ2W9DZOcCxyEmj559NchTclWqcIuwxBTuBPDwZmdnlRWJe6
	wgVOtX1dI6keIzvCRkHk9M3uAKbx6kik4OayysRJA3kH3R2ke0BNBMrKARgycFOSyeFpXWhx/+L
	WT4DVPyinltZ7meqWuj5HmBL3H3oS4/M/iqRI0k3ICEJB7WlBWM3BzB3vo2mY8CsG8cmDGlt5dU
	8GzswF3wX4gFIV/2pru3HismPAxvVfQ8Vm8B7AlWF/f3YyEUJbW/oQh3YhnktoqPBXBkb4Of8eB
	Tb8K+d2ZdFlKSSJwxuYV152BKQ2fIg/H2Xy/QnzucVrKSRPSvjxqApj7LvAvHgs3Jbgr6ShZhNo
	vkltqzPe5QH6/F9++yI68NzQlN8HIfYBkJHPfps3aDg==
X-Google-Smtp-Source: AGHT+IFFm9zky0SxbktFrrzQ+NTv6G8i6eERwaMpUiFW2QYSxbmEiN7oSr8vkltvo3nUOZWrxX7dIw==
X-Received: by 2002:a05:600c:8114:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45892b9e4bcmr69774445e9.13.1753969140187;
        Thu, 31 Jul 2025 06:39:00 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm2409107f8f.47.2025.07.31.06.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:38:59 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:38:57 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gxvsfqre7jriys5"
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com>


--2gxvsfqre7jriys5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
MIME-Version: 1.0

On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>=20
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
>=20
> Even when memory usage is controlled by memcg, sockets using such protoco=
ls
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).

IIUC the envisioned use case is that some cgroups feed from global
resource and some from their own limit.
It means the admin knows both:
  a) how to configure individual cgroup,
  b) how to configure global limit (for the rest).
So why cannot they stick to a single model only?

> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
>=20
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
>=20
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.

That doesn't like a good idea to remove limits from possibly noisy
units.

> Let's decouple memcg from the global per-protocol memory accounting.
>=20
> This simplifies memcg configuration while keeping the global limits
> within a reasonable range.

I think this is a configuration issue only, i.e. instead of preserving
the global limit because of _some_ memcgs, the configuration management
could have a default memcg limit that is substituted to those memcgs so
that there's no risk of runaways even in absence of global limit.

Regards,
Michal

--2gxvsfqre7jriys5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaItx7wAKCRB+PQLnlNv4
COjkAP0UcZBWkhc+vB0FfA1p+pH/BzzZDKA27tR3sA4T4P3PBQEAyknqdHl6GIJ5
yIxBX8DBx92ijoCOGSF1vaocgD203AQ=
=iTKX
-----END PGP SIGNATURE-----

--2gxvsfqre7jriys5--

