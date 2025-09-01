Return-Path: <netdev+bounces-218865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6AB3EE2A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7BE487E9E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6A226CF4;
	Mon,  1 Sep 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Rq/QKB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25814221FC4;
	Mon,  1 Sep 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753012; cv=none; b=QodEg2/Uci+LYA0i6jNDuOMvmlpEBORztGc9dTBwOuVWJ+LEhUaC5K+Fms+wKCZtc3BRSwDJjVbtNT7/ay8Mml0EIN0ni0jnZPBbaF85IlO6dqP/anftRYd6PDZcC/RNui2y4mhn3Kys8zFcuJ5c5B2ACLAPYOug8hzuOtcnFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753012; c=relaxed/simple;
	bh=WMeBQ5LaQhNBOxQYP4YDZIlEjORXejgbydjuanvpe5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKZnu3XcZ1jIgtbTosAgMbNkfyQWEKfqdR3iJNrSrM4ujevn1mCnK1jkTFLcoVzathPAO7hYUssLIqmNwWN4cZqiM8kd2Yk4ufGNLgTwb4r0peiHUHhVz2NrXq0huZRFgW6g29PzoE6an/3Q4V9JX4GuklSYCIVkZ4Pfxdropv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Rq/QKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCA0C4CEF0;
	Mon,  1 Sep 2025 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753011;
	bh=WMeBQ5LaQhNBOxQYP4YDZIlEjORXejgbydjuanvpe5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7Rq/QKB5e/77qPGwxGk1p6BzygRX5C61NxXehq2AmHRxsjKRQxcolFzp6syuHS5P
	 hN98tge7DuoNLlmHDeb0HOqS7FwZ9VAQ4cZGKQpPXHBg52avfYmx196O0gsWVSW1xF
	 b0kEJHSSPtUn0GPHbWZnN2DyospER+QKUwJYOMTo99OAI5LvAUJDUoJyiFPFC1PlNZ
	 a3SQWiWaLR2YflzVbe2SGDbTVSjRYbLdVrwGN0HHlsvFQe7sMbjvTBOIB+5o+qHODl
	 qoblnIYsMBKMnnQlkVQyXEz8GxenTjbnjX0BUUQdOIbHZ+Jhh08jDPt6UuY3w+X5ZL
	 84g7ulCXhmeuQ==
Date: Mon, 1 Sep 2025 11:56:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, David Ahern <dsahern@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] tools: ynl-gen: fix nested array counting
Message-ID: <20250901115650.107e078e@kernel.org>
In-Reply-To: <20250901145034.525518-4-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
	<20250901145034.525518-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  1 Sep 2025 14:50:22 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> The blamed commit introduced the concept of split attribute
> counting, and later allocating an array to hold them, however
> TypeArrayNest wasn't updated to use the new counting variable.
>=20
> Abbreviated example from tools/net/ynl/generated/nl80211-user.c:
> nl80211_if_combination_attributes_parse(...):
>   unsigned int n_limits =3D 0;
>   [...]
>   ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)
> 	if (type =3D=3D NL80211_IFACE_COMB_LIMITS)
> 		ynl_attr_for_each_nested(attr2, attr)
> 			dst->_count.limits++;
>   if (n_limits) {
> 	dst->_count.limits =3D n_limits;
> 	/* allocate and parse attributes */
>   }
>=20
> In the above example n_limits is guaranteed to always be 0,
> hence the conditional is unsatisfiable and is optimized out.
>=20
> This patch changes the attribute counting to use n_limits++ in the
> attribute counting loop in the above example.

Looks good, thanks!

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

