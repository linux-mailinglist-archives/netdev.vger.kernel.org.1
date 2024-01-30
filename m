Return-Path: <netdev+bounces-66938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5784185B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221BAB214E2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BD34CEA;
	Tue, 30 Jan 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruN2F5rJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CF339AD;
	Tue, 30 Jan 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578381; cv=none; b=cCNvAIPI2M6hpqdpzBo81t6zXZG56Guj3MrTcfZg/5oI8F2COIptDN0yyhXUPs25Lzbdd3Tj/wg5UlzlAZMdSy7cV/WjfJYM15ghTOS50AwRzNTmOzzgvHz14I6Gv9tr8gTm4csQLoqbLYVAXM5a4l2mK6CnfpY5dq2Y4J8K/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578381; c=relaxed/simple;
	bh=jKVXSUHnuGD6UfpTwd8Rf6+GCaEio67YadwFP6z0OJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpCWdIs6HLIp1D03x3l20hifOqJkWxRB7OUeLr3NH8mw43Jd2tiOkSPwD/FV3UXDw1hjzpZX5ZorAxCosdcZZUP0mCHgX7tBjK+gTuGJibY9isEYLboaeJVviAJPB1F1HAlRspOc6c3eEqlsTKxZ589wKsTDAEALyM/Ck/iji5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruN2F5rJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4860C433C7;
	Tue, 30 Jan 2024 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578381;
	bh=jKVXSUHnuGD6UfpTwd8Rf6+GCaEio67YadwFP6z0OJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ruN2F5rJAMlRDAEsQoLNolTUWIfv7P4yBbvtegSJyJ1aEUnamWwVeL3omGloDjH/a
	 vCuGMt/7YR6a308erYs8Lp34/2MgcGT0+Eu8DkFfMEqMpeCKDO+vBo9MfjArJClZTD
	 i448HTnKby/rXqZAg39WZhiFnDGKTpYNFTeI4Xt0w3on9zsNNy93xs2Re3VHVA0UZb
	 frd5cRDgN+C+Sb5EtZXAQZIgBWCeYog9muf5onZutb5NtmYk+aYM6LwgmN5iZ2ngI4
	 9JeUNmCO86WoZCiWNklDeBfoU3dL0sTucwY99OMSIaEazJMnmo9kyNTwC2Ti26HUG2
	 +HxOemffu6kwQ==
Date: Mon, 29 Jan 2024 17:32:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Alessandro Marcolini <alessandromarcolini99@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
Message-ID: <20240129173259.1a2451df@kernel.org>
In-Reply-To: <m2bk95w8qq.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org>
	<m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org>
	<m2ttn0w9fa.fsf@gmail.com>
	<20240126105055.2200dc36@kernel.org>
	<m2jznuwv7g.fsf@gmail.com>
	<fcf9630e-26fd-4474-a791-68c548a425b6@gmail.com>
	<m2bk95w8qq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jan 2024 19:36:29 +0000 Donald Hunter wrote:
> > from collections import ChainMap
> >
> > class LevelChainMap(ChainMap):
> > =C2=A0=C2=A0=C2=A0 def __getitem__(self, key):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for mapping in self.maps:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return mapping[key], self.maps[::-1].index(mapping)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exce=
pt KeyError:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pass
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.__missing__(key)
> >
> > =C2=A0=C2=A0=C2=A0 def get(self, key, default=3DNone, level=3DNone):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, lvl =3D self[key] if ke=
y in self else (default, None)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if level:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if l=
vl !=3D level:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raise Exception("Level mismatch")
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return val, lvl
> >
> > # example usage
> > c =3D LevelChainMap({'a':1}, {'inner':{'a':1}}, {'outer': {'inner':{'a'=
:1}}})
> > print(c.get('a', level=3D2))
> > print(c.get('a', level=3D1)) #raise err
> >
> > This will leave the spec as it is and will require small changes.
> >
> > What do you think? =20
>=20
> The more I think about it, the more I agree that using path-like syntax
> in the selector is overkill. It makes sense to resolve the selector
> level from the spec and then directly access the mappings from the
> correct scope level.

Plus if we resolve from the spec that's easily reusable in C / C++=20
code gen :)

