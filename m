Return-Path: <netdev+bounces-133187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8767999543D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDC1F25ECD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B11DE89A;
	Tue,  8 Oct 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfTRWE+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77827580C;
	Tue,  8 Oct 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404387; cv=none; b=dPS9SW2vAPSX1Htdy8WSM2X+2klLzJFv85t/7tjvm2eRQ+GeQ7JLyUrLgd0/tiBDePn1HDm8jwv1Gly82RFFZ8bvuDwjWbJFxdPNwvWa/JjuyCNOfXaG5wQ9X6xg8HE8YrIBhHPFSAYXMNvVcKK+mmwERXsToYxdjO3/yTsVSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404387; c=relaxed/simple;
	bh=Vj2g89hH873pxGtBNbvA/Dz/9+d/kuB58Uusb8enIOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCh2Boed4E//eMO590xwavZ6qo/56z0+mgbOs19ZTOWr1zGCbove4QQajlWyJhzDP15SPmigKQkXMdkvBDg7LaAXg1S82cDNMIWx6QrNECxg7qBc/SV6halEM6LSc5F7lESQz+ieWPGVIB9y8wgVKo0JN+41LV4fmTXSWSx0d04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfTRWE+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13800C4CEC7;
	Tue,  8 Oct 2024 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404387;
	bh=Vj2g89hH873pxGtBNbvA/Dz/9+d/kuB58Uusb8enIOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfTRWE+h1l0NU0HtZM6F+WlJme9GmzQ4nW1qp4yMwhzqlmLXbhtfEElfts2CuaUmn
	 duRqnyd3pytZephfTwkW9RcdLbaPe3D65DTu9wQ4p8wfH6SGnMKJZHtqXtJ2rxBWDk
	 8SzA79Ih0yU9KLhEm9htnFZRQ3Mxvi00pszTC3h/g0Z20XHPkAvw/qY9hhj84XRIjt
	 uJ8SXqXw8PEY/D+8zpod0jkviVPXZggdtrhHcyDKeBsbelgD5TgLVCggqtGrMXhP4G
	 GwdbDoJHSCnnJIEWovY2mYQ+CmQU9inkz8r2+yp81I8Ia3ipIQz7EzXaHl6kxtzU38
	 6cLhYyvgqE3lw==
Date: Tue, 8 Oct 2024 17:19:43 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
Message-ID: <20241008161943.GA99782@kernel.org>
References: <20241006163832.1739-1-kdipendra88@gmail.com>
 <20241008132024.GN32733@kernel.org>
 <CAEKBCKMrtLm1j3dU+H12Oy8635Ra2bZ6eFfxdixTvYwSEEyaJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKBCKMrtLm1j3dU+H12Oy8635Ra2bZ6eFfxdixTvYwSEEyaJQ@mail.gmail.com>

On Tue, Oct 08, 2024 at 09:28:18PM +0545, Dipendra Khadka wrote:
> Hi Simon,
> 
> On Tue, 8 Oct 2024 at 19:05, Simon Horman <horms@kernel.org> wrote:
> >
> > On Sun, Oct 06, 2024 at 04:38:31PM +0000, Dipendra Khadka wrote:
> > > This patch series improves error handling in the Marvell OcteonTX2
> > > NIC driver. Specifically, it adds error pointer checks after
> > > otx2_mbox_get_rsp() to ensure the driver handles error cases more
> > > gracefully.
> > >
> > > Changes in v3:
> > > - Created a patch-set as per the feedback
> > > - Corrected patch subject
> > > - Added error handling in the new files
> > >
> > > Dipendra Khadka (6):
> > >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
> > >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
> > >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
> > >   octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
> > >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
> > >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
> > >
> > >  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c   |  5 +++++
> > >  .../net/ethernet/marvell/octeontx2/nic/otx2_common.c |  4 ++++
> > >  .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c  |  5 +++++
> > >  .../ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c   |  9 +++++++++
> > >  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 10 ++++++++++
> > >  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 12 ++++++++++++
> > >  6 files changed, 45 insertions(+)
> >
> > Thanks for bundling this up in a patch-set.
> >
> > For reference, it does seem that the threading of this patchset is broken.
> > Perhaps there was some option you passed to git send-email that caused
> > this. In any case, please look into this for future submissions.
> >
> > Also, please use ./scripts/get_maintainer.pl patch_file to generate
> > the CC list for patches.
> >
> > Lastly, b4 can help with both of the above.
> 
> Sure, thanks for this.
> Do I have to send all the patches again with v4 with the new changes
> to the few patches and the same old unchanged patches?

Please send all the patches when you send a new version.

