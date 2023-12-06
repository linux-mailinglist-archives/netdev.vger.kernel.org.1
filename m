Return-Path: <netdev+bounces-54643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF61807B54
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC301C20ACC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD5563B6;
	Wed,  6 Dec 2023 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NxqMoF+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF6D5B
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 14:29:00 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d0aaa979f0so2307435ad.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 14:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701901740; x=1702506540; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/l6Rr9GMTmqW+sTOII/IEKtjg7NaSJo/S0s3iJkJlg=;
        b=NxqMoF+uqCBh7k+Joq0or4Iq0JU3NGTvJK+iIkKCs4wI/bsjGNnlmh64s/kDxuLn9L
         BNMqLUhdK7vjJaJOrG2raHQy3lndzXt+f8ie9rfALtfFPj6oe3ztHyJT9K+cB4OeI+VX
         JbNO5bsib62CvliOLe5v7W1rhaVLH6E1Kn/cSKsskixkJOBL+uR4VNcYiJ8i4hGggKJU
         R7bccC8ue2HqSxTvwVeAvZIp1vv3HR/14FgBPD8+YPKuRF+0cbX118NJsfei05ovqWUT
         w/HRmTETQZWcD9AtQODXxNxwcAQ1NsS2O4UehbmT1BSHEqCNMmVoqR+oMWcU79+Xhjt/
         ehXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901740; x=1702506540;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/l6Rr9GMTmqW+sTOII/IEKtjg7NaSJo/S0s3iJkJlg=;
        b=B7Lr/xTChA9nxVJKZZbdu9OAjv3Z30g+yQ5UtarEAt8KpTh5bKu+axmzP/sr2t/3On
         uD2YPMXvFxXEATOZvezJqQEMrkDW4unjzXDrBxeBL3R2diFP4tKj7kGrGj4fc+D7Bzsm
         jjOpmcsp9hEcCl6xXFkR3TP2VF/1/UsQpU/jyZD9IDsP9pakv+UQNN9WeN6AUn8vmvoq
         tLFcyzqXMVcCMwq0RYwo7wxHlwd7F+d+gJ5ATX4zg+7vC6IA7CpDMD7YpbSTiKtI/fDu
         DgvWoloJFP4rBErKJ93T8Q7mvXo6QYfF1LN8TGYmXa5GW7sBkeiplstKrixzwhFjPGjE
         Eyxw==
X-Gm-Message-State: AOJu0YzFqphxfKEgFnHG1+FLjJ7ML0FTARfKFdROlb4HgeNvWcDBTYYl
	XuEtVIFlz8atX2Ar2VrHsRjtUw==
X-Google-Smtp-Source: AGHT+IF4uW9bK6yyANxChBWzaE1Y3zrx+2hRhaqcc+9gMpyrucm57mySnQFhCzjnEOUn+tcgs4FTLQ==
X-Received: by 2002:a17:902:ce8d:b0:1d0:c41b:1d0c with SMTP id f13-20020a170902ce8d00b001d0c41b1d0cmr1215417plg.75.1701901740213;
        Wed, 06 Dec 2023 14:29:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b001cfc1b93179sm305347plb.232.2023.12.06.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:28:59 -0800 (PST)
Date: Wed, 6 Dec 2023 14:28:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek
 <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
Message-ID: <20231206142857.38403344@hermes.local>
In-Reply-To: <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
References: <20231206192752.18989-1-mkoutny@suse.com>
	<7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
	<vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eEONBPhTWRmcfcuKyiwe6pZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/eEONBPhTWRmcfcuKyiwe6pZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Dec 2023 22:18:25 +0100
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> On Wed, Dec 06, 2023 at 05:16:28PM -0300, Pedro Tammela <pctammela@mojata=
tu.com> wrote:
> > Can't you just keep the sch-, cls-, act- prefixes for the aliases?
> > They look odd in the current patchset TBH =20
>=20
> I'm open to different better naming.
>=20
> Although, this natural option would clash with the behavior
> (modprobe(8)):
>=20
> > there is no difference between _ and - in module names =20
>=20
> Thus blacklisting via an alias vs not-blacklisting via non-canonical
> name would contradict each other :-/
>=20
> Michal

It is not clear to me what this patchset is trying to fix.
Autoloading happens now, but it does depend on the name not alias.

--Sig_/eEONBPhTWRmcfcuKyiwe6pZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmVw9akACgkQgKd/YJXN
5H47pA/+M4lxqb/IvlgJPzS8zJ6TBstZrVncp/IqsyJhWEf8EQPg139zasxJQiz/
PQn2bADBEqQ6c9Um8MTP4GHukWU4SRp1JiyKZxkMdabB0De7wZSUUaaFi78Y5nOu
qCpPePt9RHGgZIqPogjOJRpGl52H4Qaypieq/pg845n3DtVi6jSLa/fJc0AWmVfj
8mbXT+Uv5jRpkVOTlri+nZ+QBoJ+CEO8kUM7jQynI6hedJGbD9QHghOczxYNbN4D
UBmRNiL1ewfoH2uTH4IRSnHa3TMXv7iYMzlfDOmW1G8TTpm/6tYJ2eYArLeoRyG0
yTFbH+RZ0WCSdHcFYJG32NWV4BoikjhoBALhzYjLnxKOqck3xvHfkrf7P8WPLmRo
h9o6AuIb8ahsgYnghkuYdOhUYmijj4Fr8UWjmX1xQKPqwvTN0/6yYqikDAgh9rQT
sCGFZfbrRF8mlIG0B9KnKL5131AjxwAmrLbcLzsC6OkbgkpBsPpgunOMoCHYR/9E
84vnorBr+imly0obQ21of1yNAJ2D4JBoBnX6dnY3bHfA/jPWTwrPJKMjX8sq1XRD
3ajxlIdpmzVqWUdqpvoW4ku3vLLRh1bG5RI/WC96hzX1FAIV66G2rI53f22+P499
5Bdre8yF1LpeEceSjgU5YgWF8vSo39k+Qa6c4gm9JZ2BXvRTACo=
=L6hG
-----END PGP SIGNATURE-----

--Sig_/eEONBPhTWRmcfcuKyiwe6pZ--

