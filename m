Return-Path: <netdev+bounces-218862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9EB3EE19
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA62C0B22
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D251FA272;
	Mon,  1 Sep 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgUHtMHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DABE555;
	Mon,  1 Sep 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752643; cv=none; b=VX6/d2MD/9fylh/fy0+wNfi/YxCJ5qBCJKDrfUPHZWF1YY5vBAX0ba53IfLb/RPOaVXKIn/eqb6SPLbB0FhbxKPc1ZNa+0kbCVy2hp4sgZG1mb3VmPwVqZ6gQv/Ru/3lDg7vcZO4TLeXcNu9rfOeZuotmxp47lzjCYbieJJZzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752643; c=relaxed/simple;
	bh=TaDxlRij1DMVVJ7SJ7L4VH6Il0973Q1GT0fLfbvUvgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sm3xdGAcW+HvVR1XSCC3hqC0X0tHOD3IW3J4Zsz2A1PON7Quk+UpVXc+wMAS4XM7quBshJ4ePLa/SdednPvW4RwZWW0N/n57dYXpTS/UM/WIIctb5ygqDbx3gsNlz/9zKJPyg614XkZkmLVS9RX3ji39aGizymM+4tJAaPw22hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgUHtMHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE27C4CEF0;
	Mon,  1 Sep 2025 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752643;
	bh=TaDxlRij1DMVVJ7SJ7L4VH6Il0973Q1GT0fLfbvUvgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lgUHtMHOKguduGbiYVfwrbvQzEjJXroI2/q8xjw4mmexTV/ZpHVyZATn2n0XhV/qw
	 pGwXqbpinmwU8Ilyb5/LjRNs2xIzRso0WEcodZQCCRhQlsKAENXwakcGfKIdpaF+mG
	 M+Fr7SVpAacSSuQUboeSTewF9wrc8iuZ0BMr1ZB13/RpZjFR6swvc1vIofIm7hGpMF
	 VjY0dkN8P8glmTLmvvOGEFtaRHk9XrnZR81QYAESaZ74QlZLh9QPc2pmc12GbEK/iF
	 qbsagl9DejiJyf4gZIjUGxUnMJVVGbNq3kL4KtpMp+mufMEkXRoJuqm7fGA6m1MzPF
	 qlnZH3iA88nIQ==
Date: Mon, 1 Sep 2025 11:50:41 -0700
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
Subject: Re: [PATCH net 1/4] netlink: specs: fou: change local-v6/peer-v6
 check
Message-ID: <20250901115041.03d661fa@kernel.org>
In-Reply-To: <20250901145034.525518-2-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
	<20250901145034.525518-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  1 Sep 2025 14:50:20 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> While fixing the binary min-len implementaion, I noticed that
> the only user, should AFAICT be using exact-len instead.
>=20
> In net/ipv4/fou_core.c FOU_ATTR_LOCAL_V6 and FOU_ATTR_PEER_V6
> are only used for singular IPv6 addresses, a exact-len policy,
> therefore seams like a better fit.
>=20
> AFAICT this was caused by lacking support for the exact-len check
> at the time of the blamed commit, which was later remedied by
> c63ad379526 ("tools: ynl-gen: add support for exact-len validation").

No, take a look at 1d562c32e43. The intention was to keep the code
before and after the same. I agree that the check is not ideal but
it's not really a bug to ignore some input. So if you want to clean
this up -- net-next and no Fixes tag..

> This patch therefore changes the local-v6/peer-v6 attributes to
> use an exact-len check, instead of a min-len check.

