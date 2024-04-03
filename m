Return-Path: <netdev+bounces-84427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF0896EE0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1431F231C4
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E20146A7C;
	Wed,  3 Apr 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxDTG0Y0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E087146A75;
	Wed,  3 Apr 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147396; cv=none; b=UiwPJD4pUcjnnn6UYPkT4tm5Lo3xDh9MvhQcZ/ZXiUIqag09nwgWW60JKBvuV+A9bQyFFOenqH003tGOWBCvFE2j0x4f4oerujMjkzrVY/XhYw3ZsA9f3I2bvjU6DubR+1tIyt4wEr3gX8W8TeojkHOhDJ4KxUT19VqWoRVWHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147396; c=relaxed/simple;
	bh=17nw4mBwdw7o/BMzv+AdA/BNvdIhvtEGu58LPXIywWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwH9n4L7HexI9umLXjC7J399QCp/q9ebOxMQulGFht0/2Mh4+j42a/GLKHeocMy7phKoNt+fNqX9H+GOTkUfHWjTAYaeeyzpjXvnSegOu2C9cRAkuoFjRT9zT22z+QaGDMQcMGMpczZyZ/5cuWMt+AxHA7s60WD4tQQSXZo1tDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxDTG0Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B4C433C7;
	Wed,  3 Apr 2024 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147395;
	bh=17nw4mBwdw7o/BMzv+AdA/BNvdIhvtEGu58LPXIywWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxDTG0Y0ZNLCTZsOVSyrxsIBoEhpVmvIMmny1/TM2qgOH0VUnoowjDsDOGICA1yDJ
	 vIxUahUjS5hea8LZwB7N5FHram9vFUY1yOw8WfIfDY3ZyUsSH+dfhuBSCE2BBTDRKK
	 NGfjCFkSaIXRNMGo09Wjp7bssxBcX9/R2tCyOO2IPgnDSY5BWibcVcd/HKiJuhvOA4
	 ZZig2iKJjHbD1PToatsm37Hphwp7ZpogsP0qbnjOixphkNOVc1xnNMGLBCCPUiyP3j
	 nJ47aCz+q6A4QxmnhxZHXLUghr/D6qNLW8vZmu7Gdv5lRESsRepHg61+99gv/OBWgN
	 Zx+NK3JJAdIog==
Date: Wed, 3 Apr 2024 13:29:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Stefan O'Rear <sorear@fastmail.com>, bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Manu Bretelle <chantr4@gmail.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
Message-ID: <20240403-clanking-undress-b18346aa4cef@spud>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
 <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>
 <20240402-ample-preview-c84edb69db1b@spud>
 <871q7nr3mq.fsf@all.your.base.are.belong.to.us>
 <20240403-gander-parting-a47c56401716@spud>
 <d6eae62b-60fd-4f3c-92e4-7ea5f1c4fc68@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sTVykUQukqcz7+L4"
Content-Disposition: inline
In-Reply-To: <d6eae62b-60fd-4f3c-92e4-7ea5f1c4fc68@huaweicloud.com>


--sTVykUQukqcz7+L4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 06:05:38PM +0800, Pu Lehui wrote:
> Hi Conor and Bj=C3=B6rn,
>=20
> Thanks for your explanation. I totally agree with what you said,
> "CONFIG_RISCV_ISA_ZBB only controls whether optimizations for Zbb are bui=
lt
> so that if Zbb is detected they can be used.".
>=20
> Since the instructions emited by bpf jit are in kernel space, they should
> indeed be aligned in this regard.
>=20
> PS: It's a bit difficult to understand this,=F0=9F=98=85 if I'm wrong ple=
ase don't
> hesitate to tell me.

I think your understanding is correct. Sorry if I confused you at all!

--sTVykUQukqcz7+L4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg1LvQAKCRB4tDGHoIJi
0mlqAQCxxkdbSEap3IEfCOExj7NWGtaUdUrEOON0RDSxpdgCYQEAtp5IpMEHfa9u
V7IQVi50lwcIe+Z0M4FzSa+afLjRWgI=
=AuOI
-----END PGP SIGNATURE-----

--sTVykUQukqcz7+L4--

