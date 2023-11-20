Return-Path: <netdev+bounces-49151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79E7F0F1F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBCFB20B0B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608F111BA;
	Mon, 20 Nov 2023 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqsb3hP+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63E111B0
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E36C433C8;
	Mon, 20 Nov 2023 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700472725;
	bh=B5OTO9fXksNT8jTphZupJqAgZrBhx/cbFTutmYcoXIc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oqsb3hP+LkGmQPGqV6aAaVoPT01GPyEnqOckib4/9CVYAsw7KghImKXhL5TV21smK
	 dtzZEBez40gY6sFKxKgH2t7o11xOTts495/tonq+lIkGsgbviULx8DZ59kX5pOPcK0
	 mf6fPKUn9AUKRBOesQ5ETSCM+bj1VxG4X1EOupPu1EmVfzTkrc2YhbNS8yfmxeC3+l
	 fux8FLaanIOXfsFoxyzrFQ1llL6nADwL61h9D4fGacgS7Y/CIyJ5tWZPaveCx+hWcr
	 05RWkw95lQPfedOJuZ2Gatz2RA0094TUXv5RVZ5F9GGYcIo+PEiEoLEAOpz/I0pLIP
	 GOcA/9MeDMo/g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <85f52258-d1cb-9c3c-0ea4-602954e929e8@ssi.bg>
References: <20231117114837.36100-1-atenart@kernel.org> <85f52258-d1cb-9c3c-0ea4-602954e929e8@ssi.bg>
Subject: Re: [PATCH net-next] net: ipv4: replace the right route in case prefsrc is used
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, liuhangbin@gmail.com
To: Julian Anastasov <ja@ssi.bg>
Date: Mon, 20 Nov 2023 10:32:02 +0100
Message-ID: <170047272220.4264.16199175262224821201@kwain>

Quoting Julian Anastasov (2023-11-17 17:56:57)
> On Fri, 17 Nov 2023, Antoine Tenart wrote:
> >=20
> > Note: a selftest wasn't added as `ip route` use NLM_F_EXCL which
> > prevents us from constructing the above routes. But this is a valid
>=20
> ip route append/prepend are standard way to create alternative routes,
> if you want to encode a selftest.

Thanks for the pointer.

> > +                     if (cfg->fc_prefsrc &&
> > +                         cfg->fc_prefsrc =3D=3D fa->fa_info->fib_prefs=
rc)
>=20
>         You may prefer to restrict it for the change operation by
> adding && (cfg->fc_nlflags & NLM_F_REPLACE) check, otherwise if
> we change the prepend position (fa_first) route with such prefsrc
> can not be installed as first one:

Good point, I'll fix in v2 (if any).

>         Even if we consider just the change operation, this patch
> will change the expectation that we replace the first alternative
> route. But I don't know if one uses alternative routes that
> differ in prefsrc.

For example NetworkManager does, but I don't think NLM_F_REPLACE is
used. One could do it manually, but I don't think that is used in
practice either.

>         Note that link routes (nhc_scope RT_SCOPE_HOST) or
> routes with prefixlen!=3D0 (fib_select_path) are not considered
> as alternatives by the kernel. So, even if we can create such
> routes, they are probably not used. So, deleting link routes
> by prefsrc is good as we remove routes with deleted prefsrc
> but for routing we are using just the first link route.

Right. Replacing routes by prefsrc could help configuring those routes
so they have the right config when the first link route is deleted, but
that's theoretical too. Reasoning here was since we can delete by
prefsrc, we might want to allow to replace too. As you said, there is a
good reason to allow this for route deletion which might not extend to
the change operation.

Thanks!
Antoine

