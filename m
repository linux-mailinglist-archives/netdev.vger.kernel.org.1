Return-Path: <netdev+bounces-186174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCDAA9D5EE
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A639A22D4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6E2957D4;
	Fri, 25 Apr 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqPjhoXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3F224AE1
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621521; cv=none; b=V2NXFSJmP+cwjl/oojsJGqYhPkFiqD1B4GxtrgAzajiXFmVMe9GN0ZsGKxfm1pN1JACR8nmNcTTbEe1oZowWGh4PEZ4umLMp+I/WLnVQa3rvkou3isQ/bVaa7iQsH+I0oeiTKMlIILhut1HM/31vt9i/8Gun+emwwyG46bNOUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621521; c=relaxed/simple;
	bh=nlKafP0UVqrrO5vkg1rxZpzzysLcNruXsNLBcs9xvm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zcy7SvPS5jXu1hRePUCgWlct8Ix7YoAaXwFCGh1jaFgqnzaRHQPZ9AKFGZx+cajNSE4xpY8EyfvB5IFS3eLfPrjB5k/FYNAIZmJEXmlwRy6e1xijfJwbbH6w6IVPSQh5Gbo9BuPU4LjZy6bwetJbnM4fpX05NTvP3LFaAx/a0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqPjhoXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E6AC4CEE4;
	Fri, 25 Apr 2025 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745621521;
	bh=nlKafP0UVqrrO5vkg1rxZpzzysLcNruXsNLBcs9xvm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nqPjhoXr4vvJqy4ua1fVyO2edmf5ecbrB9Lj+T6wkUpOcWcJLn4MWU37t16CP2uMp
	 5NdDzTVXAxEHp8AD/3wMS2hjRtRIrZ1hnwvvvob00ZYZRE2DJxHVlIhHh8L7c8TUUQ
	 tFlFii7cF4iA/Hs3hLBMbDfKvNAel+uvOqG8Sh52mihheon2gP2YqrAnufGWami4PY
	 XOdVvGJ52Hg5q8X6yB7UwwKy7NLMZPZGB4y7DQ66jRKtl/EymZTgZt0wmYiwI+x0gj
	 xIJJko36CPCf80b1aMN3bv3ucNm/TRCEl7dP0uagZ0Dlqzq5DaqqxmOpLYAyXpSuB2
	 NFG1RxeUaxDdA==
Date: Fri, 25 Apr 2025 15:51:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk,
 asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com,
 dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 06/22] eth: bnxt: read the page size from the
 adapter struct
Message-ID: <20250425155159.1c82f280@kernel.org>
In-Reply-To: <CAHS8izPze3g7qdTGJ7xd9LeipVyx5cNTKisLDaT6FOTj=X_VzQ@mail.gmail.com>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-7-kuba@kernel.org>
	<CAHS8izPze3g7qdTGJ7xd9LeipVyx5cNTKisLDaT6FOTj=X_VzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 13:35:00 -0700 Mina Almasry wrote:
> On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Switch from using a constant to storing the BNXT_RX_PAGE_SIZE
> > inside struct bnxt. This will allow configuring the page size
> > at runtime in subsequent patches.
> >
> > The MSS size calculation for older chip continues to use the constant.
> > I'm intending to support the configuration only on more recent HW,
> > looks like on older chips setting this per queue won't work,
> > and that's the ultimate goal.
> >
> > This patch should not change the current behavior as value
> > read from the struct will always be BNXT_RX_PAGE_SIZE at this stage.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 27 ++++++++++---------
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +--
> >  3 files changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 868a2e5a5b02..158b8f96f50c 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -2358,6 +2358,7 @@ struct bnxt {
> >         u16                     max_tpa;
> >         u32                     rx_buf_size;
> >         u32                     rx_buf_use_size;        /* useable size=
 */
> > +       u16                     rx_page_size; =20
> I think you want a hunk that sets:
>=20
>  rx_page_size =3D BNXT_RX_PAGE_SIZE;
>=20
> In this patch? I could not find it, I don't know if I missed it. I
> know in latery patches you're going to set this variable differently,
> but for bisects and what not you may want to retain the current
> behavior.

Hm, it's here, last chunk for drivers/net/ethernet/broadcom/bnxt/bnxt.c:

@@ -16486,6 +16486,7 @@ static int bnxt_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 	bp =3D netdev_priv(dev);
 	bp->board_idx =3D ent->driver_data;
 	bp->msg_enable =3D BNXT_DEF_MSG_ENABLE;
+	bp->rx_page_size =3D BNXT_RX_PAGE_SIZE;
 	bnxt_set_max_func_irqs(bp, max_irqs);
=20
 	if (bnxt_vf_pciid(bp->board_idx))

