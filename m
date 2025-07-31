Return-Path: <netdev+bounces-211146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA5B16E66
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C970F3B851C
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568428F937;
	Thu, 31 Jul 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbJLOQHD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6D1E571B
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953661; cv=none; b=Sj0o3/thAinz3DL3BbGVBSsHlqyr5Q+1+fU4X0WFB908ujs4dFlim31rTR0FiCOYXFxEnns3syYIhMrwYfYMRhDgYkP1Bdrt1TCqHpN5+uQXjJMJQsxEJ/tofGME3Rsik7UY8XWHhGkD6OGdurBJ1rBt4I6DG8kvfI1suB0qwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953661; c=relaxed/simple;
	bh=YQitdJZEqx49z+aEtgIFZrSpHymltedYz+RclMvgrQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgDgIGbmelkK5yJWrI2GI0EvBQTOb07frtOSe8ngyAeJjCkf0IKvsiq1IS56849QHPQozW3Oi8zKdnb9ZtbGY/QOceyck3lHjV53srLXqhooOCHS16fDl0BGvBPx+miITFKn/apXtHEiyozsC4OcvWNOiBzCf/WvPSHWmahEyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbJLOQHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C541C4CEEF;
	Thu, 31 Jul 2025 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753953660;
	bh=YQitdJZEqx49z+aEtgIFZrSpHymltedYz+RclMvgrQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbJLOQHDqprFeguHWI4PoV3aRzwTXcJU6XhvZc7x4IPsLrXsOMrL0wRPExZxowbHD
	 GXNz6bnZutQbK3/TCxxB9MLMC91Ty6BrQ2gWiadtfLDVTKcMRFoA4CYz80vYEwiv9L
	 V7eNWJj3DSBru/pqEwz5t2lFvzX6Bil/hG1jyWMVxnVGqjcuQwTenpv6NpkCjcnE7q
	 7Prto0sYallXr14WCC0MY5umXrDhVYP+/4Le0wPNuuv0w7JY8MOuTQ331gn5e3MVo0
	 yf08rfB8B/VZIlftPeaoEN8JBLkIDJmVXMScNO3Mc07qhkI5kbVw82LbFAwK1hq62V
	 37IRTFD5FuhlQ==
Date: Thu, 31 Jul 2025 11:20:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix PPE table access in
 airoha_ppe_debugfs_foe_show()
Message-ID: <aIs1eXkuez-sZtfH@lore-desk>
References: <20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org>
 <20250730181249.78dbe4f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iy9ceCsbIKdzJyDD"
Content-Disposition: inline
In-Reply-To: <20250730181249.78dbe4f2@kernel.org>


--iy9ceCsbIKdzJyDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 28 Jul 2025 13:58:08 +0200 Lorenzo Bianconi wrote:
> > +struct airoha_foe_entry *
> > +airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
>=20
> Hm, could be just me, but the way we/I used _locked in the core was=20
> the opposite. _locked means the caller's already taken the lock.
> Here you seem to be saying that the "callee is locked"..
> Can we stick to core's interpretation?

sure, that's fine.

>=20
> > +	struct airoha_foe_entry *hwe;
> > +
> > +	spin_lock_bh(&ppe_lock);
> > +	hwe =3D airoha_ppe_foe_get_entry(ppe, hash);
> > +	spin_unlock_bh(&ppe_lock);
> > +
> > +	return hwe;
>=20
> Is the lifetime of the hwe object somehow guaranteed in the debugfs
> code? Looks questionable..

PPE table entries are allocated at driver load and never freed, the hw is j=
ust
writing into this DMA area when the entry is binded.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--iy9ceCsbIKdzJyDD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIs1eQAKCRA6cBh0uS2t
rKE+AP9acbZ1NXEFMJ8nPy6u1cFPCw8RfBLLOGACBYGpxGOffgEAwSwgpDJiqJnM
Nv8H3NbW2BL1j9z8OroubX6meSBdZwU=
=PjV9
-----END PGP SIGNATURE-----

--iy9ceCsbIKdzJyDD--

