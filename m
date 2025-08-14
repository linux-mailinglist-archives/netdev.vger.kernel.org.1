Return-Path: <netdev+bounces-213695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74523B26569
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3A81B6018D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DB22FC89C;
	Thu, 14 Aug 2025 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E4H0oF1v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE12D0C80
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174628; cv=none; b=OB9t+59deLIyoFiabxvtfUecOpNFY7oEu5sdU9GJ3h/0AewJuFwku1MvIr1KZFHi4cYVoCyP311wh2OlbyLRSu4ruDYvcyllgX8qgO8en28TpDTCHHxqjlXg/ESCxGxHSJZLUx5tpe9AuNWsR2wYV/6djJRTRCwi3aM7MzevZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174628; c=relaxed/simple;
	bh=1PE9vqqyAAJHt2b4anvd33upg87s7/sb4TrxyKMVNKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK2e8xOfQZKWoIML5zCCPZ2XLyEMi2e5FztzSPQN5ZbhRC0x7RjeB7A1QQDmpR12ats1RBeVpLarAtr9VqeYTk3vyFJ2/HLGL6AlSsle61Ou82iGlKWayLhUWLDqqIKariDazZ3NNTxTti6TOTc18YQnpgHCXfnKT3HQQ2Hcp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E4H0oF1v; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so468520f8f.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755174625; x=1755779425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ1w1vX016HZnhf51EVaJqwNMCPhdOvsodT4l6hbFIE=;
        b=E4H0oF1v9HyUEv/PaapQmZXv2Qj8FbNSP2dSaO73BcECErZ+qjpyThCT5uyiNriH3H
         VYwQ6gBxjru8L9YTVAOlfkD4AuJxv6UCCSYHWe1yyAZAwZIJ4dvSuVEjliiXp3rOGwuq
         LHAkyT5gbIgYe5dxMM2m3hWjam7zAJVboHAMc+2mqKAkjSw7w+4n9CwS/M36ugrW5K+d
         FJwKjSg7UAJZtvjohWd3QyiQt7fRaq2Ry7UOCNIaWEZOjN2VQBFBokWKZYgFAZGkgkm4
         MY7uL9KR0ngEgs1OnYXlAG4cRY6EaQ6SsSMPp10yc/kpDGg69I7Anjadgg6YmIgdSCQX
         yxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174625; x=1755779425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ1w1vX016HZnhf51EVaJqwNMCPhdOvsodT4l6hbFIE=;
        b=EGg4wGYQAEOgx03MV58tCTUp5mMCHh2Ma/HlYtCjL0B8Gqjc+06Eho436r1pu26lm0
         m8p3AeOm4+2vpUoFWRg5xZ7p1Kkk8T54+pTjyEuGWUUt6retQTd10wgbqx6dBucpHsCm
         g1KlZ60o6BR6Y8nlTYojPGsbvuX9KIqBVRP9zJmueiZrGOLcj++/nl3UQuJFPtn4FKrV
         PkbDgrtPFu+rOaD0oW2rInksrvQqvB7VrUkRwq5Cdk5k8HqoZGwUcXKd4L9/8qbZm5HU
         5lnqnhZnV8TO1LntHXN8ACLMbcNhtmCQdGDMs4z+UQHecmJL5uup8a5vu6Azeu00z0Un
         JxtA==
X-Forwarded-Encrypted: i=1; AJvYcCVcwLjpCTGpX4KebKN9Ew4mmYFSbA7swXtNAdeac6Ljo1yio9m/XUhBCU/4JsDQbVbmyR8BIeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTEBTBrtxhsxDfCtSLPaWvEDjvGXZ+khLa0rt4hHvlpybWS9/
	sa0iURxe3G77fW5r9RQWuqvItGl1EOsSrabf0zQUjM5gMzP4j428/jebxTwJqjkGYoc=
X-Gm-Gg: ASbGnctmpRXAQHsWSgm1OF9cYCglyCCce8rqIfGPQ2b8LAjrcinAm5lykUZuPugsy5I
	r8hEBHngVLakE/fCqet+lVhUqHQMDOQYbZ7XOOx8/QarYYMXCfpDMtXEKEokLI41ipMAkDe4GAf
	POOKVZnatRjK7ky4F0HLeMq443cE1jAavLmR1AIJdy6pIVTaC599YCcdD48m/4MSXA69LNcTknc
	tfo75bDFwgMI+T3w+hXNKmFXNB4mY2eu2N6/4NstxJ+mTW6GUjM5XEfhvqtuFF/0ocB50fBZvRb
	ZhWDLax0WPNrfIQLMCKzlFDdr/POkB1IBi7I8Mezaj7d0CLv0zGsIEUubffMrl+0CvdTYsQ2mJB
	xvxmsHRtxY6wQ32n0mnGxhhFjudHIi2KXDlwxa5PIjQ==
X-Google-Smtp-Source: AGHT+IEcamlanLgHj4e3UiHXnuoZFx6EM5i/6/BHJ22GOTsUGejY8ezIfKRRmd/gWCi23iogf+4+lg==
X-Received: by 2002:a05:6000:3111:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b9fc359a99mr2276811f8f.32.1755174624685;
        Thu, 14 Aug 2025 05:30:24 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm348329055ad.60.2025.08.14.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:30:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:30:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <ukfrq6ybrbb2yds5duyj2ms6i7xgssjsywzgknxctfgkpzupor@tjxbuiil5ptt>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhbunld2ijovocqb"
Content-Disposition: inline
In-Reply-To: <20250812175848.512446-2-kuniyu@google.com>


--xhbunld2ijovocqb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
MIME-Version: 1.0

Hello.

On Tue, Aug 12, 2025 at 05:58:19PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> sk->sk_memcg based on the current task.
>=20
> MPTCP subflow socket creation is triggered from userspace or
> an in-kernel worker.

I somewhat remembered
d752a4986532c ("net: memcg: late association of sock to memcg")

but IIUC this MPTCP codepath, the socket would never be visible to
userspace nor manipulated from a proper process context, so there is no
option to defer the association in similar fashion, correct?

Then, I wonder whether this isn't a scenario for
	o =3D set_active_memcg(sk->sk_memcg);
	newsk =3D  sk_alloc();
	...
	set_active_memcg(o);

i.e. utilize the existing remote charging infra instead of introducing
specific mem_cgroup_sk_inherit() helper.

Regards,
Michal

--xhbunld2ijovocqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ3WwQAKCRB+PQLnlNv4
CAoVAQCrDITNqluusq0b12YFFhfY1gKK4Q8uAHs/KsISm9RelwD+JxaqxOrcmstY
zyqaWiykc0r7xJAjUUU3so6cKm+/lQg=
=6bNw
-----END PGP SIGNATURE-----

--xhbunld2ijovocqb--

