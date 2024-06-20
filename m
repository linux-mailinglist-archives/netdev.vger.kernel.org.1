Return-Path: <netdev+bounces-105443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C605C9112A6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4CE282536
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F81B9AAA;
	Thu, 20 Jun 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj2rMBzc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088433D575;
	Thu, 20 Jun 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913533; cv=none; b=s03xz+mWjUriIEuH/zvsvpoyE9uRlARfAQQa72MK+AkQPX5AHYcT0/CM5sMb7mp54LBN4I9w+mgyoG8KfQELZfw0T+SQKRaBK/6J9fy1wePfu41iB+Fot8u12FT7QHG4UWSsZez5tkNTFhxO9wD1KnEg44dPoTI8nl/xlHGELNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913533; c=relaxed/simple;
	bh=bM30UKYhIfj6luAIp3k9eTCvuMmDpCYt27nj187lpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2w5ND5kzyNYpV7S6ZS8/AkOqzKE1xDlz3YFtS0azbTYrJxX6Fb2UGnKllCQueV3wKFj1SMfrK//PfzklRTnvTjEPrABPfj4rhTBNbRDTN4isRYG4ayzZ2X2wN2bhhOvqRoDc635ZV9acua6repeY0sDAVwKsf4A+NnjqEMKigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj2rMBzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B85C2BD10;
	Thu, 20 Jun 2024 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913532;
	bh=bM30UKYhIfj6luAIp3k9eTCvuMmDpCYt27nj187lpxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gj2rMBzcVBznCM3RDIstCVw0ztqeVIkgqbRwgCOj9Fi0NInJOlazJpYSWlZ3tCzCM
	 5udSIMtuJcbihPbkjJwdpIyrRm6lEAPTouk50T0VGDGelk7y02ETqYkOBtVtrIKEG9
	 0q7km4QCynvSO9WpefCfaStaiYh990eJd0s9H+7gJ6Y3CDLSL18eCumktlINieD52J
	 4w/Dxc/cs1ND7Tm7xKmZT1bKi+TxN6+8/hOtJgxC2NIVCKzUKr+hU74EM9679+s5Ro
	 yFW35eZHHJQp4H3qD1E83A5Cx9VueWv6xI9DbG7qaA3F+DhdSk8BUCSM2qg5W1dzBi
	 BRUWXiMO/DCNg==
Date: Thu, 20 Jun 2024 12:58:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Christian Benvenuti
 <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH] enic: add ethtool get_channel support
Message-ID: <20240620125851.142de79c@kernel.org>
In-Reply-To: <0201165C-1677-4525-A38B-4DB1E6F6AB68@nutanix.com>
References: <20240618160146.3900470-1-jon@nutanix.com>
	<51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
	<2CB61A20-4055-49AF-A941-AF5376687244@nutanix.com>
	<20240619170424.5592d6f6@kernel.org>
	<0201165C-1677-4525-A38B-4DB1E6F6AB68@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 19:49:45 +0000 Jon Kohler wrote:
> > channel is a bit of an old term, think about interrupts more than
> > queues. ethtool man page has the most informative description. =20
>=20
> Thanks for the pointer on man ethtool - one question, Przemek had
> brought up a good point that ethtool uapi says that combined queues
> valid values start at 1; however, I don=E2=80=99t see anything that enfor=
ces that
> point in the code or the man page.
>=20
> Should I just omit that completely from the change, since the fields
> are zero initialized anyhow?

Not sure what the comment about 1 to max is intending to communicate.
But I'd guess it trying to convey that on SET driver doesn't have to
worry about the value being crazy, if it sets max correctly.

