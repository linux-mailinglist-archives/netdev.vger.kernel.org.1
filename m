Return-Path: <netdev+bounces-239647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF0C6ADE1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BCB1E2D098
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D143A1D18;
	Tue, 18 Nov 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cu9urYDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F2355038
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485861; cv=none; b=lSMw3g7sC+frL1n2kQK8hwuB8Oi+1biCCy+BEb+bgJUBscfqzQPsycWFLtiLFtkXCZk/PKmmblx+GDT3sgPXAxuM7II74kw3KDlQfmDh0yVnb/RvU7vFtMwP76ldF040GIGTstkRrzhbE3HJuou0AqAxwcYK5xFyiOph0h4Kdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485861; c=relaxed/simple;
	bh=h+J7u3/CpPatdeQYr/tmIncQdjRefuqRNa5ojln1lvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1ViHMlCTSSdTl5ucAWTiXpRV5oJSfzUsTDnhcL3SF3O6JYdl9EFmG5mnUHe+258zKpPmqWyyXpNE1sZ1wPE0EtPXj7kpUdQOekE5KbIKUkNIjSt+cLGmey5t7IP3AlNFv3waKO/YjztFYeTBSniFW0cBgsiyYTMMIdFTNaw/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=cu9urYDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A5CC2BCB1
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cu9urYDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763485855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vplNO5csMyvgI0N+D58HkHbAeNRmIHcdSs3oPvlRhjY=;
	b=cu9urYDHTq35ESp8/5LBlH+0dt3QdLsjnnK3GfcvJ24psLpnaLjR08u066RSbTP90HwWJM
	pWwrB8+RTwA7dUfjXmQhT8QTOWhHJSjzqzrWwVHFIoFkaqkNtfPYYQupE7mv58V29nk8Cy
	gzr5KOuelRlQ/K+A6buaMBly6+CSiDU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b6cadc28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Tue, 18 Nov 2025 17:10:54 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6d13986f8so15885a34.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2eWtVqx7NUWj+kY5hKAqUgv/umssX+v3KNgdQgM+OLh5y284ArXMospB+jv9GjHs6bLBhNrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXK59CF6DTpKIPj93NFUKkYnF6HIqmLg8zOZ34zWmrsXD3IwL
	R3153XNqVZ6sC7yDh3SPIW90QfvxBB9mlOVjJoUAvzH00bV0ClYMdUyuCfv9WLgLdfw/UcpfMK8
	QNEj+L4n8Tq2Q16YaRffSNpxMtxw+3Do=
X-Google-Smtp-Source: AGHT+IHyJUxom0hIRKScdEIXcqhrOcYQvTp4xIGZtuKdvJzwmINJbL3H3L94nnkBnG5pxXMRsYlyY/8rIR7RH87Fvjc=
X-Received: by 2002:a05:6808:13c4:b0:450:c6af:7c10 with SMTP id
 5614622812f47-450ee21dcf2mr107881b6e.22.1763485853009; Tue, 18 Nov 2025
 09:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105183223.89913-1-ast@fiberby.net> <20251105183223.89913-4-ast@fiberby.net>
In-Reply-To: <20251105183223.89913-4-ast@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 18 Nov 2025 18:10:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9pYvUZ8b9dzWi-XBk9N6A04MzSLELgnBezHUF7FHz-maA@mail.gmail.com>
X-Gm-Features: AWmQ_bnuBzEBp57HuRaFihbm9Rt0pgcJuXMd6cUvTwLP-PJHaf_yRwTXcyrtcqM
Message-ID: <CAHmME9pYvUZ8b9dzWi-XBk9N6A04MzSLELgnBezHUF7FHz-maA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/11] wireguard: netlink: enable strict
 genetlink validation
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Asbj=C3=B8rn,

On Wed, Nov 5, 2025 at 7:32=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <as=
t@fiberby.net> wrote:
>  static struct genl_family genl_family __ro_after_init =3D {
>         .ops =3D genl_ops,
>         .n_ops =3D ARRAY_SIZE(genl_ops),
> -       .resv_start_op =3D WG_CMD_SET_DEVICE + 1,
>         .name =3D WG_GENL_NAME,
>         .version =3D WG_GENL_VERSION,
>         .maxattr =3D WGDEVICE_A_MAX,

This patch is fine and standalone enough, that I merged it into my
wireguard.git devel branch:

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/c=
ommit/?h=3Ddevel&id=3Dfbd8c752a8e3d00341fa7754d6e45e60d6b45490

If you wind up rerolling the rest of these, you can do it against that bran=
ch.

Jason

