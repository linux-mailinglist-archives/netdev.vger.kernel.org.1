Return-Path: <netdev+bounces-243246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A76C9C383
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEF8134839E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66942550DD;
	Tue,  2 Dec 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="fjbGkMwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD364212B0A
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693250; cv=none; b=GEQiBsWc/+IJjNRBph/l1owEmdn4AGM+fbVTEITXNSVdGD+T8YvZHCAGjYtofKSxO4oOyb+yECE1qaK5r+n4nancRQK0vvc9f0JIVTE/+91lXmluUK5c/IzNxqJveFiKHKkMicNoHSLGF0WvhS6Jlksw0JFpftBSUCaymTfFHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693250; c=relaxed/simple;
	bh=J7DJ/kDMELR2fLvV70hUzCnd+Gnh1kdF4bOeiqX9T/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCxh9a8JUXGsgcYS3wSZJhA8Pw/jkSUXxTGeHqqL55xOoRBFFWP6C3vpenEZmEN+i2ENI28mTZuFyyUumgYaJu9DgDuSAITtzkPQKanBgAIV1w3t5xXEUVEHqRoUD1Ex9U0rDWeIdAjsQx+2f4VWpC+G6kFqlQxJVNuWiQLXjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=fjbGkMwU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso52087905e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764693247; x=1765298047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+HKHWRUrb5GmONn65VrE5cUKXES5UAqksV8PZTR68I=;
        b=fjbGkMwUxGcA5CVZDzoFiCcscUuvamFubWg+zD/WDM34xDHCSI0u26JgIoh2N6QvvY
         k7JGhEgja4TkprbxUMRQZECIzdxM4g3/nczKVrdTG/6HNMXyEVN9QF3BqHbKrw3Eol8Y
         8F8aPqExJIQ3TZIStHyaX8SeiXwpQsPB7PpxgeYeeFqG415gN19tvkZTlDhPN+xo2SR7
         P1guNMvLdRRY7Gk3Zy7BLLDpeYFmoLHo61hQUMCRSwfPl267D3Xklj0qcEAijt6o0ug0
         8TVN6MSpcFrlAVz1b2OPhyrKJXp1Nlj9N3fpz/r7CYChEsA9pojds86bTLcpokjldWhd
         NhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764693247; x=1765298047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+HKHWRUrb5GmONn65VrE5cUKXES5UAqksV8PZTR68I=;
        b=pPJuzM467H0gHqQSYQxwu3xfAShm2qQVIITTmKEJTFmVAsG+wIMXLfjOW/sypOif+3
         4EO0siDbaByJhnW4va68dliFHNacnNkaurRryGzceTk/hL3yjlTMF5w+kq57ApqsCvU8
         4pV4oMVvOLgLHrmyink6mY4oSdCRVuCbfdyR+YWdjmKi+ZevErs/fy5RBS9dSafjBXEc
         jI57VWAGPEVVmnahXM4ybLzSJmskbtzIT9ToWjRcylT4i4zDmi+hOEgs/aeo4Ed1Cwsq
         TQrrZ1RwQUlD1mFjEB6yJRKD8FZ04wiTjBra+SLRFtLLalaB/Gmyxkw3GQAz+3fqpyxA
         DUCQ==
X-Gm-Message-State: AOJu0Yx7Pc+Jql9BZS7sTlsZJuXA59TdT14A4sib1tPojGA9e55aaVJL
	I2Ql7+LQVRp3IKXx1XGXw0JYAvGvTcVjSAeQ5HzFXWex7m+8n8EWDCpokHmJc+w7cFDcNO54C1w
	a6qXH
X-Gm-Gg: ASbGnct69mSF21vX6pdYQ3CtZ/xKufx2CNnLDKSA4538z+GkpPqrYu2umzLSBCQ/mwf
	LLqBhzZsz1FIBgvGkLiG9FzxvQHEX6bYgzHryaPmpkZcOwYJ2h67Z05LYmMkPedhGLPHKTvlTqu
	6cxdSjnxx5HRbSA9xg2xMOyiDJguQNACyj0NlYGL2IUD9+XUbdntFlGAqe+ybH/q0QctXOpSYRb
	ZWuqFKRsany6tVuGuMiC6wLjLPAkLeVX0dQKH/2Tfx0K0NUyQYROH3MUKaArqJSc27zmUsLXrbr
	84AnMe+7ayXJM/zvijSVYAKyXA/m9zz+eZY796Mz2jn6u50RPC5PDA5lwgPeawsbwfyI/b/qx1m
	yU7EkcW8Ou25dG9bD7t7OkkPDAl3xfuztrKOr9fIt+LVvDehnDQIiSiWgZspu6cmFElNC6xLYL0
	Zh5J4NFSF4x90nUmiLk/9WAkSEJGhjemAsum63QNeqJwt7GiNG+wHCcaurVQ==
X-Google-Smtp-Source: AGHT+IF+RCbHLwrxahRwrsJxRufDBn8yEwtGYeX5LW+8LuHPscJm0XOq5ELouo1Uq98LeD/P2yAwaw==
X-Received: by 2002:a05:600c:1f8f:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-477c01ee3camr424174565e9.23.1764693247114;
        Tue, 02 Dec 2025 08:34:07 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a4c02a2sm801545e9.2.2025.12.02.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:34:06 -0800 (PST)
Message-ID: <08816d1ac76019f3cc9ae427047545e08b78ea4f.camel@mandelbit.com>
Subject: Re: [RFC net-next 13/13] selftests: ovpn: add test for bound address
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 02 Dec 2025 17:34:06 +0100
In-Reply-To: <aShhdULYMt58e2_B@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-14-antonio@openvpn.net> <aShhdULYMt58e2_B@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 15:34 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:44 +0100, Antonio Quartulli wrote:
> > From: Ralf Lici <ralf@mandelbit.com>
> >=20
> > Add a selftest to verify that when a socket is bound to a local
> > address,
> > UDP traffic from ovpn is correctly routed through that address.
> >=20
> > This test extends test-bind.sh by binding to the addresses on each
> > veth
> > pair and uses tcpdump to confirm that traffic flows as expected.
>=20
> Same as the other bind scenario, the test works even if we don't bind
> to that address.

Right, will fix this test as well on the next version.

> A few small comments on the implementation:
>=20
> > @@ -547,45 +518,83 @@ static int ovpn_socket(struct ovpn_ctx *ctx,
> > sa_family_t family, int proto)
> > =C2=A0		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx-
> > >bind_dev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strlen(ctx->bind_dev) + 1=
) !=3D 0) {
> > =C2=A0			perror("setsockopt for SO_BINDTODEVICE");
> > -			return -1;
> > +			goto close;
>=20
> ret isn't reset here, ovpn_socket will return a stale value.

ACK.

>=20
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	ret =3D bind(s, (struct sockaddr *)&local_sock, sock_len);
> > -	if (ret < 0) {
> > -		perror("cannot bind socket");
> > -		goto err_socket;
> > +	return s;
> > +close:
> > +	close(s);
> > +	return ret;
> > +}
> > +
> [...]
> > @@ -2221,6 +2228,9 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx
> > *ovpn, int argc, char *argv[])
> > =C2=A0
> > =C2=A0		ovpn->sa_family =3D AF_INET;
> > =C2=A0
> > +		ovpn->laddr =3D NULL;
> > +		ovpn->lport =3D "1";
>=20
> Why do we want lport=3D1 on the CONNECT side now?

That's a mistake. I should have set "0" to let the kernel pick an
ephemeral port.

> > +
> > =C2=A0		ret =3D ovpn_parse_new_peer(ovpn, argv[3], argv[4],
> > argv[5], argv[6],
> > =C2=A0					=C2=A0 NULL);
> > =C2=A0		if (ret < 0) {

Thanks a lot!

--=20
Ralf Lici
Mandelbit Srl

