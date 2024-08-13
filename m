Return-Path: <netdev+bounces-118079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C1950756
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CE4281CD1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1769419D076;
	Tue, 13 Aug 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlAGOM2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AC19CD16
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558487; cv=none; b=UGUQFBkCvey6VgLU+j8XGymoyWnC0vRM+L/q8fyyu/El1Wl3qfHnjtgZ61FtmIbfxXCJOmSUuknf36EAui1hCUfbx24P/TAz8YRl5xnnlRcYY4LBR2WyJrzmKv0NQ5JiCNGT6Mc3z/yg8HI5jBxGC+Nbce1QJY5fUJYl2iJeCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558487; c=relaxed/simple;
	bh=rk7QqrdwBT1Zphy9XGtQ8dPcOnM731zoMTLFzFWoILs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryHOUj4E5l93zU8i3kYpoU44ThWVGT7LemQRU/+mKGY/VHId5zjti/o4ukQLUmh6jcAFgzrigc7ULNg84YV2zJsMYzPjHhLzrOl2FE1V1jf2X/HkvMnslCMi0qjAEb5sPYOy1USnbWJJmwCoI2L9o7TadOWIc91v13tGWmB4jUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlAGOM2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281DAC4AF09;
	Tue, 13 Aug 2024 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558486;
	bh=rk7QqrdwBT1Zphy9XGtQ8dPcOnM731zoMTLFzFWoILs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlAGOM2cJIRMCucwnxjWJ6KyRNv6c97JNbQDvPuGBH55euTGrlPKUX3jKYPH+9oa3
	 tkRWOxQWj+3OUDGN5LTlrf1BsJwzBv0FAYjeiW8Ay5ZKf1tiI0sYW3a0Dz50eVYRAW
	 Ctli+pJ3L6OKZ/kADNDJIVonCVRSKchZiE1g36VpV3YVKV0Zp8rRH1SmY9FIe9yPll
	 XFW5/Ht2LhAxf3T0rnYfaZvFWn96Sm7qox3GwbaSnfYRGlL+AlwB6aWYwQmQYT48bH
	 gAZQt5twJJWLBfQMgwUzlO94W+xUkxoQEW+rGguZm9PtNFHN84r8fyZc6ZkRXHme/2
	 QYc/F2BD1t4GA==
Date: Tue, 13 Aug 2024 07:14:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman <gal@nvidia.com>,
 "jv@jvosburgh.net" <jv@jvosburgh.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Message-ID: <20240813071445.3e5f1cc9@kernel.org>
In-Reply-To: <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	<20240805050357.2004888-2-tariqt@nvidia.com>
	<20240812174834.4bcba98d@kernel.org>
	<14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 02:58:12 +0000 Jianbo Liu wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bond =3D netdev_priv(bond_=
dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rcu_dereference(=
bond->curr_active_slave);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave ? slave=
->dev : NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock(); =20
> >=20
> > What's holding onto real_dev once you drop the rcu lock here? =20
>=20
> I think it should be xfrm state (and bond device).

Please explain it in the commit message in more certain terms.

