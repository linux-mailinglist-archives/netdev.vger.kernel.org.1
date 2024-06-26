Return-Path: <netdev+bounces-106716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14B91756A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D771F21FC1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621FB64E;
	Wed, 26 Jun 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvCoGavG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F5C13D;
	Wed, 26 Jun 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363891; cv=none; b=bhNkyKeEwDCyLH3LumOgLIdNAGyFwhb6wfQd6CveFLydUihw+C9JDMTsLWFxE2OGkbYkedoFxF/4XlyfAozIi1WamH2tUCNVYD9hXu8pTiio3AyUJSoN2VLsvMMI4YdydcV6yd3OP3TPMk6iAqqp+LjSu5IYIxSQ1Od6shJDa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363891; c=relaxed/simple;
	bh=FHzW/DVKidcZT55HraJ3rhZSFrRW8mJxc3kQAWC95Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nISufea3Q2oeAz2TjRQ/t7CNdA+luPqFuIV0D3j32Bgz/tsPrHr8hnIhs5Rt67JBvJMmvl54qh9OMa6cgmf6SR0lq0/j6YJGgYpK59pQyNp/HmFZtx6Sk3yCG0chFioV3n+4CDL9rmOZD9UWuRZErVCUtMR28Km90RsO3cQm7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvCoGavG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB38C32781;
	Wed, 26 Jun 2024 01:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719363891;
	bh=FHzW/DVKidcZT55HraJ3rhZSFrRW8mJxc3kQAWC95Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvCoGavGJy9+7Hj/x+hf/g88Vpgl+wkF25XLiOBfR2LiLhig/PGTtQpLPsT7oc5iP
	 91T2DeilXrLwtJRPDzgz5suMh65zL2P4w4LHKza1BoMZyqlWloqny1YhDZXxlU3aGf
	 YYVktBdbT26jkQD5uEoLEVGRyr0pGsYGV1J7nYR3eURpXjP7ZI38JIObBGAJd0neJU
	 wbV9TJ4lq99L7bkhj8dWDgu3j7m4vB2sC9B0TKgxzTVfNGSLJDBsaVctdSDTfM3jqL
	 LRQEqtKzaUQuCbMT0AcyQ19YVcr/TcUZ/7qXpQxDXA87g48I18kpYx1aYyR+ONAH4L
	 5qpvpb6j0lLtw==
Date: Tue, 25 Jun 2024 18:04:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Jerin Jacob <jerinj@marvell.com>, Eric
 Dumazet <edumazet@google.com>, Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Subbaraya Sundeep Bhatta
 <sbhatta@marvell.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [net PATCH v2 0/7] octeontx2-af: Fix klockwork
 issues in AF driver
Message-ID: <20240625180449.64e5feb1@kernel.org>
In-Reply-To: <SJ0PR18MB52166806AA7FB13ED3DC3E39DBD52@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
	<8fd713c2-5b85-4223-8a06-f2cedc2a1fb8@web.de>
	<SJ0PR18MB52166806AA7FB13ED3DC3E39DBD52@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 18:34:55 +0000 Suman Ghosh wrote:
> * Why did you not directly respond to the recurring patch review concern
>=20
>   about better summary phrases (or message subjects)?
>=20
>   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_torvalds_linux.git_tree_Documentation_process_submi=
tting-2Dpatches.rst-3Fh-3Dv6.10-2Drc5-23n646&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyP=
az7xtfQ&r=3D7si3Xn9Ly-Se1a655kvEPIYU0nQ9HPeN280sEUv5ROU&m=3Dtyo7VgAvJ4PW3on=
ftljYvIjrznQ9gYDoeBImOruW9-jUya4QuUMNK2qYOPd2dJK3&s=3DwYjJjR6jScQdlXWCRWzeG=
3SidVq0MRYYjMlDPBGMJI8&e=3D
>=20
> [Suman] I thought the =E2=80=9Csummery phrase=E2=80=9D is per patch. The =
cover letter is mentioning the reason for the change and each patch set is =
adding the summery for the change. Since it is not some actual =E2=80=98fix=
=E2=80=99 I am not sure what more to add other than mentioning klockwork fi=
xes. I am not sure what more can be added for a variable initialization to =
zero or adding a NULL check. Can you suggest some?
>=20
>=20
>=20
> * Would you like to explain any more here which development concern categ=
ories
>=20
>   were picked up from the mentioned source code analysis tool?
>=20
> [Suman]  Development concerns are mentioned in individual patch sets. Hav=
ing junk value in the variable if not initialized or accessing a NULL point=
er, etc.
>=20
>=20
>=20
> * How much do you care for the grouping of logical changes into
>=20
>   consistent patch series?
>=20
> [Suman] I thought about it but then I was not sure how to add fix tags fo=
r a unified patch set. Hence went with per file approach. Do you see any pr=
oblem with the approach?

Please configure your MUA to quote correctly, with > characters.

