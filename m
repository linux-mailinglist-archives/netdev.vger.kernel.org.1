Return-Path: <netdev+bounces-128961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427A97C998
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B261F2439E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66E19E7D3;
	Thu, 19 Sep 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaM+65IT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879519E7CF
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750698; cv=none; b=VS1bwo4CtVORVZIZ21nKPko0BfyzYdZ87Xf6KeVZ9utHJR1LF4NWiaCqZ/KwA42bJ/V/1mtFZtBDuRxjToUgzoefzks6EYdxzaW+74uffhCNUCYTxi7G5IwRm4YcEd0Tz6OzIMR/bpaBGSAytqOXmhh44jNfE7v5cJ62cyNmH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750698; c=relaxed/simple;
	bh=W5rW+UOPbgjcmK4qV+KS2eF5X3h1ICmUe1mF7wcNqpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAGDWvIxUzjEkU4Xn0Jx44COZAwD6Grfm6QX6K9TPXJ11zduYwYIkNmJPxtERu8mJO7AQZcxJh9KpoAuPh4y7M4pO3qwTZIhZ2lVvdRd7/F9ysFr/74zxzm41no02Tcb1xU60Cus78ompCUhCg69x+FCPwW/RzWnw1M6BUNkrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaM+65IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423B9C4CECD;
	Thu, 19 Sep 2024 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726750697;
	bh=W5rW+UOPbgjcmK4qV+KS2eF5X3h1ICmUe1mF7wcNqpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaM+65ITLgexVSOBdzMZzDe3/k/CsQ+DLdB9VYYcYmA/rsIelll8GkISXbDsR2Wvf
	 ANhxMttVF97HY7ulw62NTY7XjoBUFxlDME52Yl06iIQFNlihlBs4HDPKqzl+1f84mJ
	 KDJuWgN5j6VWB/eAuhmNs/S/XFB2xwr0GYY3B8PSP9tz/2UwsLOi+sdUJB7Dqy1221
	 rqKfcNvfL08zMas2mrPTBij9L5LNt01frBQ19lqO364Lf7bACOLRwcT2SkqPbdyQqe
	 R6ugVXHG/R17LzRMtJpWjIO2oxBda/ViPK7lwdy4g7LlcPkPzPiywFFgCHtS2pNXZM
	 sRBaDd9yy1aeA==
Date: Thu, 19 Sep 2024 14:58:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>
Subject: Re: [PATCH net] net: airoha: fix PSE memory configuration in
 airoha_fe_pse_ports_init()
Message-ID: <Zuwf57d09WBYKtSS@lore-desk>
References: <20240918-airoha-eth-pse-fix-v1-1-7b61f26cd2fd@kernel.org>
 <20240919074210.GE1044577@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MUSAIOmjrs55SWjh"
Content-Disposition: inline
In-Reply-To: <20240919074210.GE1044577@kernel.org>


--MUSAIOmjrs55SWjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Sep 18, 2024 at 04:37:30PM +0200, Lorenzo Bianconi wrote:
> > Align PSE memory configuration to vendor SDK. In particular, increase
> > initial value of PSE reserved memory in airoha_fe_pse_ports_init()
> > routine by the value used for the second Packet Processor Engine (PPE2)
> > and do not overwrite the default value.
> > Moreover, store the initial value for PSE reserved memory in orig_val
> > before running airoha_fe_set_pse_queue_rsv_pages() in
> > airoha_fe_set_pse_oq_rsv routine.
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> This patch seems to be addressing two issues, perhaps it would be best
> to split it into two patches?

ack, I will do.

>=20
> And as a fix (or fixes) I think it would be best to describe the
> problem, typically a user-visible bug, that is being addressed.

This is not a user-visible bug, do you think it is better to post it to
net-next (when it is open)?

Regards,
Lorenzo

>=20
> > Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN758=
1 SoC")
> > Tested-by: Sayantan Nandy <sayantan.nandy@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...

--MUSAIOmjrs55SWjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuwf5wAKCRA6cBh0uS2t
rPFPAP9xnrw2/lCkRgHlcVpazfjalAUsglQFFQuurdgduIO1QwEAyTuv1gpeDlEd
h2YB6NlhlOtRJUuPIiVFTpAZ2jED4w0=
=ppxr
-----END PGP SIGNATURE-----

--MUSAIOmjrs55SWjh--

