Return-Path: <netdev+bounces-174518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD2A5F0EB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E8A173E1B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91226037A;
	Thu, 13 Mar 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QWMuSpED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B871FBC87
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861876; cv=none; b=BnCLc8oOyBhfwK9WdGTeJeaaSrKsSPFfYBq6nVWpSkYINrkJf+Pl4c8pY+pYTMOI33PrCkYi/U5eDUz+NT38440We7DfiKmVJ9VrxXwKktn/JTtgv8x+N4cYZ3tahF7S67rXrsYAKO9KPBMkaGCIxgNkA1fTL+N1P+rpH2atP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861876; c=relaxed/simple;
	bh=+Qc1/rhEavEwxsG3hKdFM0w5lhAAqdDttjw6g+YQ8mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGSDNHN/GIgvJJZLkg4cUFtFMIB+PW1G6or8IW/8NQKnRSX5ogxwSVpN3cKiubX9ihxgex0Q1HrEaM6s0G3yDZP3f1R6rOH+NXKLozbIJP37zz2RnmtCEPnsIErMkq16XLjde1fuyaUyO6e1mZAbDkK5747Sd2z+4nn695SVq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QWMuSpED; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-391342fc148so504648f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741861873; x=1742466673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qc1/rhEavEwxsG3hKdFM0w5lhAAqdDttjw6g+YQ8mg=;
        b=QWMuSpEDetsgtiuuFcbZJ2jMMxP3+kX5OgKgbwxmQW6sUGE8IjDwWuD/ep184RU4XP
         BD2F9eMCwAnSns+1NQAs4b4H/nomuwTywijY2xjJybA6xPRGPTyQl4o+ef3fyYpAtbts
         bwqG7XxKhlj2xXx9IvMYD1VKjQGVud02yvfi5eAR/VzUWU8ABMEfOkh2ftp7Pzt39LLJ
         0wwhiFwh5oOh26mNNWvNJvHlYr/Iqk02Tic0tdSZtuvjGbyvzIbl3bXgAu6u/qXmAN0+
         Bdd9rJU+2e9ANA/yJ21A4K+a0871DFhkdUDc1hVhXSlxtFVbnnqL2h1kIMIvSpEVWWWe
         zDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861873; x=1742466673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qc1/rhEavEwxsG3hKdFM0w5lhAAqdDttjw6g+YQ8mg=;
        b=eq4O/RLwc7DD15LB2nceVDtxaera3CkPWIFQVH9ENchdjab4f7Vkcm9Z5LlgxYdeOp
         kPLXcax2Hy/Em8XOPuXKnoIxo5J7IIiUzpAAjuKXhCB6W5jfZee7zLSFeIoJptlGZVtK
         7QCCK7A6XrP6NN6BSFqB/2ZhVCUJpKF+QBGdIOm+4hjAxNI3L3HT9/2mHCEJUIO1E7tL
         sCqHRRzyra4it+gEiTAzJ3DvtmTLcTPx1eCwqpQkdrqQ1n8IeiHx9dgR/OS16s3lJsXk
         vDTSCPT55BCu1PwL/GWk7KvPHEVvAcqCNrS71viNSIm+OM9aT/xlJKPMmuoYPG5cMh8x
         deIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7uEhBC6eGKKfgQi0F64ZNMKvY0A4uNVjUFrujNHwfnscUIzQYIavqERCRMc54F1Q4M3fpEGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyort4nhEDMn5ZrMjT9zLIPqRLa+G0mvOgRxh/qt9iLkq1QUU5K
	qGyC7u+lSo9tfGH5HP9K+1JlK6LdvVXaKvJQ0hFV32VsAleLU9gfOh2F7Q4CC9s=
X-Gm-Gg: ASbGnctVULz2D/7ijdzeITSO0CCxrmTP8yj2Jiz08j19q9WaGNosEI/N+UfjVeEdc35
	mx68/u53T1nehWU8nTCP1v/ALhMEzBHEHhFHPRqPlW1COpF0V3YmpA+Sj5qECqxbXkConPnrVPN
	lmpMXqrEAi9EnRw9tnXGt6z3D53vWulm+4diXwwt9FuwuY7+Etr/Ud32Oavh48NczjJeA8MhIr9
	+LtZGCSv3WybiFAu4Yk98PpiYQbJD0YdRoS3mySLlPXbFUF1uyKSKSuHSGw4JGf9Oesw8gib/J4
	wuI30266BjSLePSAmxcTzWiZ6UpfxnwxX8+ZniQF2gY/wos=
X-Google-Smtp-Source: AGHT+IGutrF+qhtpUeJyR+v5dxXEJQUHmE/j1jQ80iIR/51IL4Oi+Mu0pGNz5DfWd0qOs62NuhFHZQ==
X-Received: by 2002:a5d:6dad:0:b0:390:de66:cc0c with SMTP id ffacd0b85a97d-3926c69b260mr11326833f8f.46.1741861872973;
        Thu, 13 Mar 2025 03:31:12 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df31f6sm1651918f8f.6.2025.03.13.03.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:31:12 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:31:10 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cgroups@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo
 API to retreive socket's peer cgroup id
Message-ID: <m73uknqti2uvh2sdak6fs75ms7ud6yken6cgaotbq3hllg7wmt@hgqewykjxkfn>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gn5un3rlxk2imiai"
Content-Disposition: inline
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>


--gn5un3rlxk2imiai
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo
 API to retreive socket's peer cgroup id
MIME-Version: 1.0

Hello.

On Sun, Mar 09, 2025 at 02:28:11PM +0100, Alexander Mikhalitsyn <aleksandr.=
mikhalitsyn@canonical.com> wrote:
> As we don't add any new state to the socket itself there is no potential =
locking issues
> or performance problems. We use already existing sk->sk_cgrp_data.

This is the cgroup where the socket was created in. If such a socket is
fd-passed to another cgroup, SO_PEERCGROUPID may not be what's expected.

> We already have analogical interfaces to retrieve this
> information:
> - inet_diag: INET_DIAG_CGROUP_ID
> - eBPF: bpf_sk_cgroup_id
>=20
> Having getsockopt() interface makes sense for many applications, because =
using eBPF is
> not always an option, while inet_diag has obvious complexety and performa=
nce drawbacks
> if we only want to get this specific info for one specific socket.

I'm not that familiar with INET_DIAG_CGROUP_ID but that one sounds like
fit for the purpose of obtaining socket creator's cgroup whereas what is
desired here is slightly different thing -- cgroup of actual sender
through the socket.

> Idea comes from UAPI kernel group:
> https://uapi-group.org/kernel-features/

In theory shortlived (sending) program may reside in shortlived cgroup
and the consumer of SO_PEERCGROUPID (even if it is real sender) would
only have that number to work with.
It doesn't guarantee existence of original cgroup or stable translation
to cgroup path. I think having something like this could be useful but
consumers must still be aware of limitations (and possible switch from
path-oriented to id-oriented work with cgroups).

Thanks,
Michal

--gn5un3rlxk2imiai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9Kz2gAKCRAt3Wney77B
Sbf6AP9fsNpqSW9pup+OWVUAqnwAa4Rv5tCANUaEBtzokfTACwD7BDGhFEavKmvp
9jS3uaw95+lDb7W2z0WEmZBKQ0regAs=
=CHE+
-----END PGP SIGNATURE-----

--gn5un3rlxk2imiai--

