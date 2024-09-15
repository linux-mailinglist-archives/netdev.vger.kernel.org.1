Return-Path: <netdev+bounces-128412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6BF97977A
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04581C20E04
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1C1C7B88;
	Sun, 15 Sep 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou79OWhh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62818B04;
	Sun, 15 Sep 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413793; cv=none; b=V5azN++hWp3Vfh1p0irRChoNnTlbO1juT3TMLXO8AXfE6tsxdfXmqDKNZoeF+Bs91XpffKftz0+KrFZd/OsJMWcwUR7PKS6tZMzAJVuLmc+zPcWw6ohHC7z7YVtkkXeDRebDBrtErKpcP4naHP4LQjyVm2rkeR6IBP2g4+WsLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413793; c=relaxed/simple;
	bh=R/g4saXUaOYNd7GFwzwvAtexn0eOT+sQsDa86TyX4gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNnikxT16a9Khhmeq/o+vlWySBXNvi9g08ZeGZZpBWFnLKe7dnj5KUksUbye1yd3iQI/+c3Y43kOZ5KVez6vyNzKOYeoAf0/hkUOXMbZfgcQNcS1UosE+DeoNNbMTq6v38LBqBNRFl+/PNCisYpAvYVczxs8J7n7R98KN9NTgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou79OWhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FF6C4CEC3;
	Sun, 15 Sep 2024 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726413793;
	bh=R/g4saXUaOYNd7GFwzwvAtexn0eOT+sQsDa86TyX4gU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ou79OWhh/Wh1UekPhxZD0VuJjuiuAGCSaJ/Gyc/25IMKBR/wJ7mGskKBf5MTMG1rO
	 6T4GL0eYpH0Q2Kj1AnKwncKPf69Mxk0xorp+LF9vSscizvlXODZZ8KG74fL+DTMkkk
	 biNmL9EQ2S/V7y9CpF4vrbpNqGcZBV4sDtd2/EoafEle3+f3htuXs31rB22SNWZ+kh
	 Sa8v1neYx7FUgc9dhJ/onmQ1xmsuAFBGNhje4QNin6PWCJ0Slsz9caSvcTnSk2LN+N
	 iDldc42Lhi5et51xwrpg5oeoZBGq9ifLpYv8upIHVPe2p8UCjINzdhv8KwRqni//v7
	 nWoaBkyslLWlg==
Date: Sun, 15 Sep 2024 17:23:07 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl-gen: use big-endian netlink
 attribute types
Message-ID: <20240915172307.354caffd@kernel.org>
In-Reply-To: <376db1bb-8a00-40e5-bf70-f8587d460372@fiberby.net>
References: <20240913085555.134788-1-ast@fiberby.net>
	<20240913213941.5b76c22e@kernel.org>
	<376db1bb-8a00-40e5-bf70-f8587d460372@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sep 2024 19:03:38 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> > We could just swap the type directly here? =20
>=20
> That could work too, WDYT?
>=20
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 717530bc9c52e..e8706f36e5e7b 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -157,7 +157,10 @@ class Type(SpecAttr):
>           return '{ .type =3D ' + policy + ', }'
>=20
>       def attr_policy(self, cw):
> -        policy =3D c_upper('nla-' + self.attr['type'])
> +        policy =3D f'NLA_{c_upper(self.type)}'
> +        if self.attr.get('byte-order', '') =3D=3D 'big-endian':
> +            if self.type in {'u16', 'u32'}:
> +                policy =3D f'NLA_BE{self.type[1:]}'

LGTM!

