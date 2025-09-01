Return-Path: <netdev+bounces-218936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F421FB3F0A9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A532C3B0EAA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73F25A2CD;
	Mon,  1 Sep 2025 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjKElxbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE52367C3;
	Mon,  1 Sep 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756763225; cv=none; b=Izi3sESpLRNIoq7pD0gtnzPaEOFsw/4mZMyYoa/VV5MDoWP/XL8Sk/jvtBTV+0qFEvaWvGtZc9T4i3KlgulpcuJuJlUHMZVCHOQwlIm1XbFO4Hqg1YADrSUITDfSYcjRJ96gF79Rnxh0W6KM+oQ/iM2zDK3RhZTqOlwECMPRCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756763225; c=relaxed/simple;
	bh=+NY02T3EKXc/p3Ldv7PZSvRzUT4MNdBvJAIeMcl80GM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxI4oLiNPBa0NOj08S2xIsgAGgpMcb6+lC23vXLcArtFDGnapb1b5Lw5nwt7nVtAL8TAAVAIJhO4dsgM9RLXH7zyxHUXvurEvdw9TLMzfR3j0GKM/KmbNNe+3KwkFqQ2cFxlg8d8fqtwpWPz633msZaA0Sqq1XbqQGYpufQMtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjKElxbJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248ff4403b9so33404385ad.0;
        Mon, 01 Sep 2025 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756763223; x=1757368023; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OlsE2WeMOlyP3bzmlKQubQNSIzHK7RKjbs8UIIIjOHk=;
        b=LjKElxbJStuoA5WmqRK1sFe9pID3nEASrzQdG60C5w//WMeIASC0qYXoYLqBApPmjJ
         bnLTZH/fHxS7sfQi30CdS8UFYXAChjrRMf0DLt5NOVXIkL/OCNMEy+b+2zmnzMXD/+qU
         qnzExx3RL0uEna66NMzDuMMZclBeSpjWiiUxd2nbiAGyASmcNOaAFx899CfA4pbDZn2/
         WPAgfVKAMMxGy7d9hjagTjafxIGhwuA0Olp3jFkkI+tA1vlKIQub+PK+DSE9HP/d1BeS
         R/z/ATeDNsgbTiKF5LprZ5ak6LB9CDlgH5z8gyYH87Jqu/+ZGCnHCamiB/9lSeI8cIU9
         clDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756763223; x=1757368023;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlsE2WeMOlyP3bzmlKQubQNSIzHK7RKjbs8UIIIjOHk=;
        b=PPMvZf5CwYjaO3rjm500AXHHM3T1OyJ1wtZcS19P7uSdWBTY3oBs57/okiy6kQSsL2
         6sGTtkCVmT/BSHTlAO/GhefsSNuBs4nWn0X5Xx/n1MET2m0LU8S+ag+wN1tdyq8Y9oaZ
         SgGPdXzsaAvbc1UeYhn48X1MaYv5mUR3m6Jb03/jERQrxZuviSul+KJw1SaHnScNwRC9
         UQqhI7Zn4PQhWSn3YIPjHKO2DU0dVykPiTo4b6d5jOh2f+KuJb7m2ZzGhzAUb41yJVTw
         h2y37igcvuJIUheAilu8DXKqLzP8le2qMFjpCfgd2Z7nEqtAU52E2optKhpSN+R5oaBH
         MHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFYGKTWxoxqB8rKVeERILD0phTAX63n2Quityo2zPSVba7Cor2AKLpxR1/JUo1gupIKtpWWPK8@vger.kernel.org, AJvYcCXjMVA4rOcsrxR6uigLT3kt+5CvhciPXjl/mIA2gbVAgkm0HctNEUT8MwEBB5zMSATGM9pAoHxRyJs1kxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjl1PlNaduqDRuCafhkp2KoZeBsFvBk5MPgtXxAbRFpQPlV4ou
	sAl/wLAeY1qASXghBS1amozO5X3YkuQOF1+lqcei3dNI0xPsfNTuOZHx
X-Gm-Gg: ASbGncs1FdzyBfoKTHoI1KN4nSm9O98sW2Nj3fikm/TiEUd5hCKxT2jRvN/Hgzi0fop
	4ToHUYhZEGgzuUESQDKXzdsT0Zqwqrj1HuvCKS193GzGMnvbHstj8Iys6ZyNsa8xHeSYmbglrJt
	RJdsirt2HEvWh2zYnkjOhAQOqVuKF+yxPNIzxfxAQ0NoRNFVMTcyno/XiuGm/3XQwTp9MrDuFuJ
	kglWEesttTmqrssHH5iWHkE0cpMBx7095wbG9xpgNue5JN4Fcddsoa/pfz/xGoaPbxWdeaCK8Mx
	T+ypdAuyPnW4+eGLY7xzFHcSpiD0G4if9+55JerL0qTCwigX2aN0P9D5vgnTZlgc9ExVT9Tuw/F
	I9IbctvSuBKxnHlF8nvDVrOxmDuSRWf4tDpBieczwB5a1lJQ=
X-Google-Smtp-Source: AGHT+IGJ+VbL+KkwAJkiu3byzjAamHyXWU/kRNAZj/DaRKztP3TxkmdmFFWUola7Qz5AGr90A4KQ/Q==
X-Received: by 2002:a17:902:f608:b0:24a:ad42:3559 with SMTP id d9443c01a7336-24aad4237ddmr89121605ad.56.1756763223308;
        Mon, 01 Sep 2025 14:47:03 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490373a3a9sm112563485ad.50.2025.09.01.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 14:47:02 -0700 (PDT)
Message-ID: <7d71d5d3c708451372d2cd0580951997ccc4b883.camel@gmail.com>
Subject: Re: [PATCH] net/tls: allow limiting maximum record size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: chuck.lever@oracle.com, kernel-tls-handshake@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, donald.hunter@gmail.com,
 edumazet@google.com, hare@kernel.org,  Jakub Kicinski	 <kuba@kernel.org>,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, Hannes Reinecke <hare@suse.de>
Date: Tue, 02 Sep 2025 07:46:55 +1000
In-Reply-To: <20250901164355.GM15473@horms.kernel.org>
References: <20250901053618.103198-2-wilfred.opensource@gmail.com>
	 <20250901164355.GM15473@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-01 at 17:44 +0100, Simon Horman wrote:
>=20
[snip]
>=20
> > diff --git a/Documentation/netlink/specs/handshake.yaml
> > b/Documentation/netlink/specs/handshake.yaml
> > index 95c3fade7a8d..0dbe5d0c8507 100644
> > --- a/Documentation/netlink/specs/handshake.yaml
> > +++ b/Documentation/netlink/specs/handshake.yaml
> > @@ -87,6 +87,9 @@ attribute-sets:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: remote-auth
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: u32
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multi-attr: true
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: record-si=
ze-limit
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: u32
>=20
> nit: This indentation is not consistent with the existing spec.
>=20
> > =C2=A0
> > =C2=A0operations:
> > =C2=A0=C2=A0 list:
>=20
> And I believe you are missing the following hunk:
>=20
> @@ -126,6 +126,7 @@ operations:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- status
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- sockfd
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- remote-auth
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rec=
ord-size-limit
>=20
> =C2=A0mcast-groups:
> =C2=A0=C2=A0 list:
>=20
> ...
Ah good catch thanks!
>=20
> > diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> > index f55d14d7b726..fb8962ae7131 100644
> > --- a/net/handshake/genl.c
> > +++ b/net/handshake/genl.c
> > @@ -16,10 +16,11 @@ static const struct nla_policy
> > handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
> > =C2=A0};
> > =C2=A0
> > =C2=A0/* HANDSHAKE_CMD_DONE - do */
> > -static const struct nla_policy
> > handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] =3D {
> > +static const struct nla_policy
> > handshake_done_nl_policy[__HANDSHAKE_A_DONE_MAX] =3D {
>=20
> Although it's necessary to update this file in patches,
> it is automatically generated using: make -C tools/net/ynl/
>=20
> Accordingly, although the meaning is the same, the line above should
> be:
>=20
> static const struct nla_policy
> handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] =3D {
>=20
> > =C2=A0	[HANDSHAKE_A_DONE_STATUS] =3D { .type =3D NLA_U32, },
> > =C2=A0	[HANDSHAKE_A_DONE_SOCKFD] =3D { .type =3D NLA_S32, },
> > =C2=A0	[HANDSHAKE_A_DONE_REMOTE_AUTH] =3D { .type =3D NLA_U32, },
> > +	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] =3D { .type =3D NLA_U32,
> > },
> > =C2=A0};
> > =C2=A0
> > =C2=A0/* Ops table for handshake */
> > @@ -35,7 +36,7 @@ static const struct genl_split_ops
> > handshake_nl_ops[] =3D {
> > =C2=A0		.cmd		=3D HANDSHAKE_CMD_DONE,
> > =C2=A0		.doit		=3D handshake_nl_done_doit,
> > =C2=A0		.policy		=3D
> > handshake_done_nl_policy,
> > -		.maxattr	=3D HANDSHAKE_A_DONE_REMOTE_AUTH,
> > +		.maxattr	=3D HANDSHAKE_A_DONE_MAX,
>=20
> And this one should be:
>=20
> 		.maxattr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D
> HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
>=20
> > =C2=A0		.flags		=3D GENL_CMD_CAP_DO,
> > =C2=A0	},
> > =C2=A0};
Okay did not know I could "make -C tools/net/ynl/" to generate this.
Will use that going forward. Thanks for the feedback!

Regards,
Wilfred


