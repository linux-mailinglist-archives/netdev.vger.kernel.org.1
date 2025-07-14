Return-Path: <netdev+bounces-206747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C560B04420
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA227B5659
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D020262FC4;
	Mon, 14 Jul 2025 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKf71UNI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F5258CF1;
	Mon, 14 Jul 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506879; cv=none; b=hguxv+DPsY5wjhVsjtsnp9K+OFxS6avv1+hOgdPCBH6WEla7LEewKUy8MM27PHmbqSWnlAHTXTAY9y++2NQIt+T49IE7IxOO4Q1YCFTIs617MOy+u0qL9At3kc4Urz4tSUEBZ0lcxQ6cPrdRJ6UAhLcbz1BTluRuh6We66GulKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506879; c=relaxed/simple;
	bh=JfYzcH35yQEz/AvVHc+jJi4BFe3B6cDYMbptaM286xE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHHgWTBlJpibIPS13bhrtuR4Vr0btVXydBdS/+2yDwy7JXFbHkuL5gudjsSemzrzVYoIYJNvOJv5XnIpguDM41o2A7ZkTdGqoO6ekBQSaVCJyLrixcIleX78SKhbPCcNQD/X6OmZw3jAmDK1xrBKjE04bgQRMRyZVUo+TlK1SCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKf71UNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE304C4CEED;
	Mon, 14 Jul 2025 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506878;
	bh=JfYzcH35yQEz/AvVHc+jJi4BFe3B6cDYMbptaM286xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKf71UNITsHDLVJW75pB1mMFXL1+YZTv3tvoDVnuraQEa7N9cl9VjY5S87qbVuWQF
	 OILDihjolZvV/JwtFurZbuBCaLcR4ucyx+BCVz/bTsw1zIBQlr7mwlXQqj3lgNJEz+
	 7hGVrdGWikxGxVc4jfJYBzJadau2NrTdzGaA95cuCAdEiXhDF5rRJ4YizuomAdaWs1
	 heiLZb9lki4gN8vS2EnSKmYIfaXyJg0rtBanFSm10YR4o3/OPqcq3qhMFf/9KIhGDB
	 +s0Cu3oLlts3nefLDYIjx7j4nxDELKiYLcTlQ31PuiC0o8SBF45iPcz7emriMnPUhZ
	 f2EaILjeegeyg==
Date: Mon, 14 Jul 2025 08:27:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman
 <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] devlink: move DEVLINK_ATTR_MAX-sized array off
 stack
Message-ID: <20250714082756.40ad644c@kernel.org>
In-Reply-To: <5ca43852-0586-4811-bc45-99e19232ce9d@nvidia.com>
References: <20250709145908.259213-1-arnd@kernel.org>
	<20250709174547.3604c42b@kernel.org>
	<40196680-c34f-4b41-a6cb-36e3a6089634@nvidia.com>
	<5ca43852-0586-4811-bc45-99e19232ce9d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Jul 2025 15:28:11 +0300 Carolina Jubran wrote:
> > Sure, testing it. Will update.
>=20
> I have tested and it looks good. Thanks!

Awesome, would you be willing to post the official patch?
Add my as "suggested-by" and with my sign off.
Most of the work here was the testing :)

> >> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/=
=20
> >> netlink/specs/devlink.yaml
> >> index 1c4bb0cbe5f0..3d75bc530b30 100644
> >> --- a/Documentation/netlink/specs/devlink.yaml
> >> +++ b/Documentation/netlink/specs/devlink.yaml
> >> @@ -1271,12 +1259,20 @@ doc: Partial family for Devlink.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: flag
> >> =C2=A0=C2=A0=C2=A0 -
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: dl-rate-tc-bws
> >> -=C2=A0=C2=A0=C2=A0 subset-of: devlink
> >> +=C2=A0=C2=A0=C2=A0 name-prefix: devlink-attr- =20
>=20
> Maybe use name-prefix: devlink-attr-rate-tc- instead?

Sounds good!

