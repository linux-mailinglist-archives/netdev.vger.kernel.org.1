Return-Path: <netdev+bounces-208830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC88B0D513
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60B07AF224
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1212D9ED3;
	Tue, 22 Jul 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cyaXQL6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B92D9ED6
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174657; cv=none; b=emkv9suGuwS53HCMW08T+giAaklz5LcnjtLNNdXEp3G0pGDFrvhSK1/T52TXnngvXWTfzZ71Uv48HqbTBAAb6nm5HWFca4RsgjxJf80FQdxQmgVkrHYw+8/9NxRuZcJNMvNK/7PToqc6zx8tt5EegyXz7lYrwQA9B60CKovoTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174657; c=relaxed/simple;
	bh=KqU7rxxNZLEKSh5qj4d+ptYtQIVDf5Cvufv55o9U3TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7UShOP9hMsXYyMJvu39xZCimZKvy6zZwVDgnq6miFwI871AWbf104kVrswMSWrEmulobKumZ2yihOUTwCn6+tadcfkg9btcGAOQvf1GzW87JRcFIleaaajkLaiUc4xL7kyIXTDBzCnvg/Fxy89ucqBB3zc0IoArmh33rrUyTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cyaXQL6p; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so8974544a12.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753174654; x=1753779454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNMnV47ZUbDg8R0JvYfcMgUdadfoUEmj1nySGscgXA0=;
        b=cyaXQL6pnxecoqcw3zw4lho0kJg/VEScW4Ba2Q938j6qnqGzGezMKHpwm2hILjfAbG
         Wx1d3AVxmLONGLIWkbBDiIwOqzeq1oNlcLMWYqMAHzVb/PzYzcDeBYjvg3mWFqHoop59
         PdgBdtiUXH9Qo7LLPOG2FRFnbOAXuy0bcOaYP4/2b6Z5KNPRATEPZwvVUIbWBGz96jXD
         fhys2sHNG5wXqJCAY+mdsHPSTZ16YvPhzliQblmA/NCJmeaPJOy6vyPki+2SMJrMBjDC
         L4Q+DnvZRu60hp7D4f4MUoek4lg4vJ7Kbv6iVMOj1a6uWhuUNjOjiqZo1yvNr54HOdEH
         YkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753174654; x=1753779454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNMnV47ZUbDg8R0JvYfcMgUdadfoUEmj1nySGscgXA0=;
        b=MqtlDA5un1QAVgqj8EhuGz1ZPEwgdohFPhEugD3yv99OqSiwwVRTN1RZ3wbbdbFplT
         4f7vhCHs30wOjlyztsgQnBtIca4wZx/J6b0ydyZNj7ffryByi0NhpBI/rLKV5Vfw0jEh
         GUL8rXejUR/y0LykTx7tyzY8eUGPt/SY9QBi1aP9llBmugxAvgHWmCw69L+fKXuvNT/c
         9Oj5vT13loOz+3xnhzTOb0joU3RhLlSSRJifms2oht1jBgPqXjJ86yK42UvXBmDn+tyH
         0U6EsPlnhfFI4/wXOwswhBXOCa/03rZPIrwyINakcIpEvYwYz1ns1xwfRhsBp92Pxjke
         Cjjg==
X-Forwarded-Encrypted: i=1; AJvYcCUWkg2Nf9yfcHUxyU+nBlAIUgMBTqudNxwjlm3hUAvZJX9Ex1adGbt+WkIEtYxs2tfSARi64PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/Z9UB6XRyvWfaWaMS8z79lJ5nd0/a4W/PunDR7w3QYnXbWZi
	lblfW0vZy0qbo+AHFe3zEfBmjZSBoaJ2o7pfvpJwLKSMaMEJvGjJAQxSgFk6J4IMIss=
X-Gm-Gg: ASbGncvEXz3AbisnIOa2Pg0hHMTYrsQARm16xS96PxQNanSM/5Gm2A3wLu4HKVWZCeG
	C4767wM7g3UtWWhKRiVIzx12PH+huxOTV/85bioy52BNNQCRt8zfog7B9opjOEzhcS7dK0lvcxj
	LBFxSOT1odrmb1i0/o2d7ffthtvpfZdcr5DR4Lr97JBybMH2Q/WNZM3pz9/BYq4Uw5TiZ3NAMAT
	WD93JgxrBMvVT1MF9mO5RrhpgNO4WZ4uFfONfL+a44VEl6AQSOUi+wacRlUVrbYv1keDf6nODTL
	dWrIi9aw8NaOdXvN6wx+z92H0MPBBkWwF21gCPRUxiqP0yGkIIVeyRRsVMgysaMFvFpnKzDeLD7
	yYk5DNWqmTMhjBV/IyRJsU9voy+Q+8bdMj8Owba8qOw==
X-Google-Smtp-Source: AGHT+IHriI4KhT13mpTW0P5YyPB+MWO8TtjIccFRhtOyc8niEg4j4aeLhKzGzFFWbvcFzm+T+91jfQ==
X-Received: by 2002:a17:907:1b15:b0:ad8:8621:924f with SMTP id a640c23a62f3a-ae9ce1ad71cmr2274955166b.56.1753174653724;
        Tue, 22 Jul 2025 01:57:33 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d2dasm831496766b.127.2025.07.22.01.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:57:33 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:57:31 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5nf5kf3mjwyhcfjs"
Content-Disposition: inline
In-Reply-To: <20250722071146.48616-1-daniel.sedlak@cdn77.com>


--5nf5kf3mjwyhcfjs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
MIME-Version: 1.0

Hello Daniel.

On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@cdn7=
7.com> wrote:
>   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
>=20
> The output value is an integer matching the internal semantics of the
> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
> representing the end of the said socket memory pressure, and once the
> clock is re-armed it is set to jiffies + HZ.

I don't find it ideal to expose this value in its raw form that is
rather an implementation detail.

IIUC, the information is possibly valid only during one jiffy interval.
How would be the userspace consuming this?

I'd consider exposing this as a cummulative counter in memory.stat for
simplicity (or possibly cummulative time spent in the pressure
condition).

Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
thought it's kind of legacy.

Thanks,
Michal

--5nf5kf3mjwyhcfjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH9SeQAKCRB+PQLnlNv4
CIQKAQCO5i3J7Cs42HJq/hTN0DwAicGGLfouEXIwhUAZ+gV3kQEAsDc74zW917vT
W+w/EI/QrRkPMIo/vDxFkEuhPHrLcg8=
=NGpc
-----END PGP SIGNATURE-----

--5nf5kf3mjwyhcfjs--

