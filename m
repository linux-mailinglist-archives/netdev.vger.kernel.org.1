Return-Path: <netdev+bounces-241948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6851C8AF50
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1653A54E5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D6328B50;
	Wed, 26 Nov 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PgIbDxLx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF6326D6E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174385; cv=none; b=Dl587hUIsHqt+SeBp9vZ4BD8NefUfJbtMIptzgrYeDE/MqEztRBiBiuQECYQgcz4q79inPyeuRDOBY+4JeFOU/U0DMX9kJZ4jY9Oaf8k5zD3kLetUMrYmskdC9a1W96bXlqr+eqZnPgfEd0QhFO/37QVK3NPufSG2jcrO239IqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174385; c=relaxed/simple;
	bh=k+PV/+w3GwC962tCLSEXCASPhFHz0jqYZzGEAcQNDho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTXXqcxp2XXodcCZsmXTqVcV/eyv/xKpjPjfG9t7OMRrnB53vQbayMswxjwGHAJ70bf4pG0Irj7XbHMCvMoEwmd+YIOlhpM/VMKsQU6jdq4mRYowSvCYL9vEJpw61nlCF0ehBfNAh8E1za6BT660yhsCTZDOy+BlFmP57nyDMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PgIbDxLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E67C113D0
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PgIbDxLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764174381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qgrp8ZiZmWwsVN3KOkzcx4XHl7+XVN+AKrWgb6Xt0U=;
	b=PgIbDxLxjZXMCcafDa4KB1LEZEzc5CBaryGcWylBb8m1YiZ4HZNptnEjpGKnkUGLZ+x7lZ
	CxV9HWsIi6qrWxZuII811mVb77/7vyGEe9AZCSy9s8WWExPcxEvZT1H1a9qLlz+CviNxIl
	1ZvRFP0UXQVfN1cD1NMYsq5NIRHSPGM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5639fea8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Wed, 26 Nov 2025 16:26:20 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c77fc7c11bso824363a34.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:26:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHiRxD3C8mEQuCYI6TVkRxbKwN3bM40vatCQiBdmO+0fpNPW8AuEwAzX5uqp4CJl1Of3W3Nsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscfvJa58MjJ/Kn6d3z6obDbFr6+2Qga923bslkgOpFLjb20+W
	NoVubJsMi6wstymvcj6v1yK3V8zyvRiesvyFEwWkdFz0luPGonZ3TFiif4oWtY1PN+7sB4iNAYm
	1EWosG5I8aeHLAMnlzicY5GnvTHOnX80=
X-Google-Smtp-Source: AGHT+IG1x6fZtqxKvZTtAuueGJIXHh6boeEFjB536/oD1ZvnaG1RS42xrXQwomgnDlloFJSGha0dxhrca9MI+NZ5Nl0=
X-Received: by 2002:a05:6830:6d85:b0:7c7:6a56:cfb5 with SMTP id
 46e09a7af769-7c798b6cc17mr9283452a34.11.1764174378875; Wed, 26 Nov 2025
 08:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105183223.89913-1-ast@fiberby.net> <20251105183223.89913-4-ast@fiberby.net>
 <CAHmME9pYvUZ8b9dzWi-XBk9N6A04MzSLELgnBezHUF7FHz-maA@mail.gmail.com> <66b74e25-dfbf-4542-9067-cc38b56dbf6e@fiberby.net>
In-Reply-To: <66b74e25-dfbf-4542-9067-cc38b56dbf6e@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 26 Nov 2025 17:26:08 +0100
X-Gmail-Original-Message-ID: <CAHmME9qeutDAYXVCgP5fh5gyOimX4iWvDjUszdm_Gny+Yk9H4w@mail.gmail.com>
X-Gm-Features: AWmQ_bl35qjZo2Wa1FfaZ448Mcfkf-D_fX7DT2US7bopJNJWmspW90thmSQ7Lwg
Message-ID: <CAHmME9qeutDAYXVCgP5fh5gyOimX4iWvDjUszdm_Gny+Yk9H4w@mail.gmail.com>
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

On Wed, Nov 26, 2025 at 5:25=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> On 11/18/25 5:10 PM, Jason A. Donenfeld wrote:
> > On Wed, Nov 5, 2025 at 7:32=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen=
 <ast@fiberby.net> wrote:
> >>   static struct genl_family genl_family __ro_after_init =3D {
> >>          .ops =3D genl_ops,
> >>          .n_ops =3D ARRAY_SIZE(genl_ops),
> >> -       .resv_start_op =3D WG_CMD_SET_DEVICE + 1,
> >>          .name =3D WG_GENL_NAME,
> >>          .version =3D WG_GENL_VERSION,
> >>          .maxattr =3D WGDEVICE_A_MAX,
> >
> > This patch is fine and standalone enough, that I merged it into my
> > wireguard.git devel branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.g=
it/commit/?h=3Ddevel&id=3Dfbd8c752a8e3d00341fa7754d6e45e60d6b45490
> >
> > If you wind up rerolling the rest of these, you can do it against that =
branch.
>
> If you update it, so it includes the 2 new net-next commits, then
> I can send v4 based on your tree.

Done.

