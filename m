Return-Path: <netdev+bounces-250104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23FD2409D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CEC53010768
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC6322B6E;
	Thu, 15 Jan 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUP5DQTt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506982FFF9D
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474844; cv=none; b=ezHRqJp2mdmhm9RdZ3muTcubpzElMROly9prtTQhay9SOOxLBJ5c9t54b3WKrFg9sMD35XgIThJ2h7noXXlzlkF0EXb+RIMLEFSygl8Ml5YHn2Lj5c0hKUChcKf000amb2ElxuP7LdNFeKGb3ZjqeYoMlK+vbBAxi0GpmIP5XhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474844; c=relaxed/simple;
	bh=KV8au2rEFx59wbezKuS9pej8/Huc6GBz+7s+0BSdx0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzxcnGC8QPROuefcAwwaQgFrmvr0R5NHmzh+32ibdq/v14NN2+/DG1qq64cJDY4TnuUEocZB4/OhVOizAbSPGXS1tzlzJzCxMs8fmkRKIL/OyNYJlUpjSo/opV74Me/GK8SQfLz+ZbnrblhBkQ4sCHoYusf/y2kBwDB/hRMnxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUP5DQTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CBC116D0;
	Thu, 15 Jan 2026 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768474844;
	bh=KV8au2rEFx59wbezKuS9pej8/Huc6GBz+7s+0BSdx0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUP5DQTt10gGsV6O1VE1FGRLELjhCcxjMk3w8Yl1Dzm8vLcuS2PjNFgLgRl6VC7Cc
	 ULYOR40TDjzKEgE7I5O0Ai/MMHxsj4PyGn9EVWdHosHaes2Lox03FMWlbUrM2Xz8M0
	 OsaG8+8YW3Yt+kRuoXQw19YTMN9CKpAgOCVFxxIMzjKifnm2HOlE8j/+0YalyV3Zeq
	 QqOiWYlcTkzoVPTfkiL2YxUgJsjhkmErP5Ta7R/jKfNsEPyKZr5ZFoPyr7IvqVtCvz
	 Se7Infti1rB9N4TcSbbcRlrtIkbr53OTK8/DEK/uJhYwDZHkyrr+8WZqI4+6LVIxfH
	 YS/Ou5glh/H3A==
Date: Thu, 15 Jan 2026 13:00:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v5 2/5] bnxt_en: Refactor aux bus functions to
 be more generic
Message-ID: <20260115110039.GE14359@unreal>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
 <20251014081033.1175053-3-pavan.chebbi@broadcom.com>
 <20251019125231.GH6199@unreal>
 <CALs4sv3GenPwPXJxON8wkhRW1F-KB7DT3DkPbzm4BY620aTEvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv3GenPwPXJxON8wkhRW1F-KB7DT3DkPbzm4BY620aTEvA@mail.gmail.com>

On Thu, Jan 15, 2026 at 02:58:55PM +0530, Pavan Chebbi wrote:
> On Sun, Oct 19, 2025 at 6:22 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Oct 14, 2025 at 01:10:30AM -0700, Pavan Chebbi wrote:
> > > Up until now there was only one auxiliary device that bnxt
> > > created and that was for RoCE driver. bnxt fwctl is also
> > > going to use an aux bus device that bnxt should create.
> > > This requires some nomenclature changes and refactoring of
> > > the existing bnxt aux dev functions.
> > >
> > > Convert 'aux_priv' and 'edev' members of struct bnxt into
> > > arrays where each element contains supported auxbus device's
> > > data. Move struct bnxt_aux_priv from bnxt.h to ulp.h because
> > > that is where it belongs. Make aux bus init/uninit/add/del
> > > functions more generic which will accept aux device type as
> > > a parameter. Make bnxt_ulp_start/stop functions (the only
> > > other common functions applicable to any aux device) loop
> > > through the aux devices to update their config and states.
> > >
> > > Also, as an improvement in code, bnxt_register_dev() can skip
> > > unnecessary dereferencing of edev from bp, instead use the
> > > edev pointer from the function parameter.
> > >
> > > Future patches will reuse these functions to add an aux bus
> > > device for fwctl.
> > >
> > > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  29 ++-
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
> > >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 238 ++++++++++--------
> > >  include/linux/bnxt/ulp.h                      |  23 +-
> > >  5 files changed, 181 insertions(+), 124 deletions(-)
> >
> > <...>
> >
> > > -void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
> > > +void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_auxdev_type idx)
> > >  {
> > >       struct bnxt_aux_priv *aux_priv;
> > >       struct auxiliary_device *adev;
> > >
> > >       /* Skip if no auxiliary device init was done. */
> > > -     if (!bp->aux_priv)
> > > +     if (!bp->aux_priv[idx])
> > >               return;
> >
> > <...>
> >
> > > -void bnxt_rdma_aux_device_del(struct bnxt *bp)
> > > +void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_auxdev_type idx)
> > >  {
> > > -     if (!bp->edev)
> > > +     if (!bp->edev[idx])
> > >               return;
> >
> > You are not supposed to call these functions if you didn't initialize
> > auxdev for this idx first. Please don't use defensive programming style
> > for in-kernel API.
> 
> Sorry for late response, I started reworking the patches and wanted to
> address this comment.
> Without a map/list of active aux devs, we will have to check the
> validity of the aux_priv or edev somewhere before. That won't change
> much for the defensive programming concern.
> To do away completely with these checks, I wish to handle this change
> separately where we maintain bnxt's active auxdev by idx, in the newly
> introduced struct bnxt_aux_device.
> I hope that is fine.

I don't know. My preference is that you get things right from the
beginning. For reasons unknown to me, the Broadcom drivers are full of
random `if (.. == NULL)` checks, which makes the code hard to review, as
it's never clear whether the functions are re-entrant or not.

Thanks

> 
> >
> > Thanks



