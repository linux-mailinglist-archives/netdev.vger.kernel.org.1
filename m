Return-Path: <netdev+bounces-211413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7413B1891E
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543BC58660C
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0124922B8B6;
	Fri,  1 Aug 2025 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA6ETZOc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBF222587;
	Fri,  1 Aug 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754086012; cv=none; b=DSoIAYoMZwCbKU1KL8NOyGmT10MF5+v4rtaxWb/uGvq7FRpBkhilBRqTcGOrQ/m7BDZPhnadBdzR7AkenusBYGcQsyvd7FuK2Hqse0FvwzPtNAJxPF+/atkZ2YA2tOyTODAtgS6NoK/uD8smPsStkVwFdIhbCfM2LSzUc4MB1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754086012; c=relaxed/simple;
	bh=pwxbqxUHDfTPGoCghA+CLoB275KxIHwAbXzxd7xhiBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+CSi07nta+NnOFgWc4cTUNXTOSDkziBXcuitJH7Fdt14CnkNJDjRyi8sZhLvi1YwhUOCV70NTCOuc0I+fwEVFCUJ/7Hx5QdGRKN2UoCtPTctkxB9bmGPOUgD5NiiWF61/uyo7EDjKVvM2fMHrnnRhGPn/+7HYYnuJoLE2Apoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA6ETZOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0839C4CEE7;
	Fri,  1 Aug 2025 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754086012;
	bh=pwxbqxUHDfTPGoCghA+CLoB275KxIHwAbXzxd7xhiBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jA6ETZOcf/PV/IbKiZN3Znm1BqaK55SSBxGTNoZzSWpIuGX/5xOsqLNRC5JVx/TOq
	 aVUWe/uPludz3M44heR+sprjyQT87Z5PjKpCg9LG198F2wKlbIMtCjBReZsaEyHfm5
	 0hhz4p/Sdesv+PaVpiRovtEwTkC4nkRMhL80+UZZKxvwMJo/IV1xjANPtWuB2KhgHT
	 87XWawVTQ6hR4itYaWdrpL3k2r4iGB3isTewCsn9ZuDhh/8I6ZABlzDnWQCW1txmQM
	 pMwB0kTTlOTkxYIRzOWv/ian9wGnzxZBcBeJCCjcwlAqBYvJCH0cPee47XNPM3XvxW
	 wIUJ8y2L3/LHA==
Date: Fri, 1 Aug 2025 15:06:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: maher azz <maherazz04@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
 Simon Horman <horms@kernel.org>, Ferenc Fejes <fejes@inf.elte.hu>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2 net] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
Message-ID: <20250801150651.54969a4e@kernel.org>
In-Reply-To: <CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com>
References: <CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 16:39:26 +0100 maher azz wrote:
> From: Maher Azzouzi <maherazz04@gmail.com>
>=20
> TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack write =
in
> the fp[] array, which only has room for 16 elements (0=E2=80=9315).
>=20
> Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.
>=20
> Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP
> adminStatus")

Don't wrap the Fixes tags;

>=20

no empty lines between tags;

> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>

your email client is corrupting the emails, tabs get replaced with
spaces. Please add the review tag you received from Eric on v1 and
try sending v3 with git send-email?
--=20
pw-bot: cr

