Return-Path: <netdev+bounces-165373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B600AA31C34
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C527A3DBD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552A1D6DBB;
	Wed, 12 Feb 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psCFYWjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134E1D54F7
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328187; cv=none; b=q0BjveqjuTNQ9/kePKgmqwIiEf+XfqCZohwq/zyoQi/GhyL4f+X1i3/AkqvKHatAlhSy9MSuwG5INs0ERKjFZp65fsxilhZLRHBfvUiILt/mT7hUuulx2DH8uFUNBS7gM5RjVCMl8W2cYolyfJMWHrUqARSYia6UZCk29Cb+sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328187; c=relaxed/simple;
	bh=eIQuwGOW1w/b8CVUofqcAUf6x7lb34kw2HNoaBxUqtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGg7fPUiO8LHwlwIS8LGQnPi1oqChHshJoxvS8gKnAQZg9WMDoh/2daOWw+sgYCtPi6MTZb120J8ZzyHtFcZYKMJuNJSQ+t5l5zI7Somq8D0XG+L2X05sba6H9TK0YfaXu1u9VlrExigq4QooroEulSFeHdt2WvBs77r1uEfmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psCFYWjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FA7C4CEDD;
	Wed, 12 Feb 2025 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739328186;
	bh=eIQuwGOW1w/b8CVUofqcAUf6x7lb34kw2HNoaBxUqtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=psCFYWjA4a00KfMda7j9Bp+ZdsvLrE9jMvSxSMPFBAamSkOhLdSiAZKAp2Z3zyMhX
	 utYPQYtUI4HGgvVKEvfF5D2KY0AZ0I2pdtIFtZX3HHPGZKvNSc1qa/t9fLfUKZUic4
	 MZ9rfKXIpiybYqXbkfcUt0bPx+Jqf5bFrotNDvyNXJ5Fdaotij2IkY+bx7BW3oFKRg
	 Jw53ZDjAa3h7fbIv2xLHCejYDXIDX7vpbgxFre5mO9av4C4j9a9O/TfvgL00btbH52
	 /NtLxy2mvbUD26aW6P8HqYJD15kCUa120emDPFp/kXg0+xBbq5anKFGy03AM3Y33sM
	 cAJqgpvl/fxIQ==
Date: Tue, 11 Feb 2025 18:43:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, michal.swiatkowski@linux.intel.com,
 helgaas@kernel.org, horms@kernel.org, Somnath Kotur
 <somnath.kotur@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v4 09/10] bnxt_en: Extend queue stop/start for
 TX rings
Message-ID: <20250211184305.2605e4fb@kernel.org>
In-Reply-To: <CACKFLi=jHfL2iAP-hVm=MmLDBD+wOOHrHsNNM21dCRAjRu7o7A@mail.gmail.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
	<20250208202916.1391614-10-michael.chan@broadcom.com>
	<20250211174438.3b8493fe@kernel.org>
	<CACKFLi=jHfL2iAP-hVm=MmLDBD+wOOHrHsNNM21dCRAjRu7o7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 18:31:21 -0800 Michael Chan wrote:
> On Tue, Feb 11, 2025 at 5:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Sat,  8 Feb 2025 12:29:15 -0800 Michael Chan wrote: =20
> > > +             rc =3D bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
> > > +             if (rc)
> > > +                     return rc;
> > > +
> > > +             rc =3D bnxt_hwrm_tx_ring_alloc(bp, txr, false);
> > > +             if (rc)
> > > +                     return rc; =20
> >
> > Under what circumstances can these alloc calls fail?
> > "alloc" sounds concerning in a start call. =20
>=20
> The ring has been previously reserved with FW, so it normally should
> not fail.  I'll need to ask the FW team for some possible failure
> scenarios.

Thanks, expectation is that start never fails.
If the FW team comes back with "should never happen if rings=20
are reserved" please add a comment to that effect here. Since
this is one of very few implementations people may read it
and incorrectly assume that allocating is okay.
If the FW team comes back with a list of possible but unlikely
scenarios I'm afraid a rework will be needed.

> > >       cpr->sw_stats->rx.rx_resets++;
> > >
> > > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> > > +             cpr->sw_stats->tx.tx_resets++; =20
> >
> > Is there a reason why queue op stop/start cycles are counted as resets?
> > IIUC previously only faults (~errors) would be counted as resets.
> > ifdown / ifup or ring reconfig (ethtool -L / -G) would not increment
> > resets. I think queue reconfig is more like ethtool -L than a fault.
> > It'd be more consistent with existing code not to increment these
> > counters. =20
>=20
> I think David's original code increments the rx_reset counter for
> every queue_start.  We're just following that.  Maybe it came from the
> original plan to use HWRM_RING_RESET to do the RX
> queue_stop/queue_start.  We can remove the reset counters for all
> queue_stop/queue_start if that makes more sense.

I vote remove, just to be crystal clear.

> > > @@ -15716,17 +15820,25 @@ static int bnxt_queue_stop(struct net_devic=
e *dev, void *qmem, int idx)
> > >       /* Make sure NAPI sees that the VNIC is disabled */
> > >       synchronize_net();
> > >       rxr =3D &bp->rx_ring[idx];
> > > -     cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> > > +     bnapi =3D rxr->bnapi;
> > > +     cpr =3D &bnapi->cp_ring;
> > > +     cancel_work_sync(&cpr->dim.work);
> > >       bnxt_hwrm_rx_ring_free(bp, rxr, false);
> > >       bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> > >       page_pool_disable_direct_recycling(rxr->page_pool);
> > >       if (bnxt_separate_head_pool())
> > >               page_pool_disable_direct_recycling(rxr->head_pool);
> > >
> > > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> > > +             bnxt_tx_queue_stop(bp, idx);
> > > +
> > > +     napi_disable(&bnapi->napi); =20
> >
> > ... but here you do the opposite, and require extra synchronization
> > in bnxt_tx_queue_stop() to set your magic flag, sync the NAPI etc.
> > Why can't the start and stop paths be the mirror image? =20
>=20
> The ring free operation requires interrupt/NAPI to be working.  FW
> signals the completion of the ring free command on the completion ring
> associated with the ring we're freeing.  When we see this completion
> during NAPI, it guarantees that this is the last DMA on that ring.
> Only ring free FW commands are handled this way, requiring NAPI.

Ugh, I feel like this was explained to me before, sorry.
Again, a comment in the code would go a long way for non-Broadcom
readers.

