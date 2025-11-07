Return-Path: <netdev+bounces-236742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5041C3FA08
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85971891298
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0A31A571;
	Fri,  7 Nov 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRjor6wD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2131A07B;
	Fri,  7 Nov 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513467; cv=none; b=DF0y9SCGsZnCMBCr3a+zAW/8R/4Ha6vxvhCENsPYOYiftyM9MqteFOFRfRLNFi7Bkfl+69X44avXKE/WZlPVk507pgppM75qWX5x24CgNNTNVztkAlxCuDpVfB4eUySu0YOFnr/t8AM8rsPNzocTBxvBdcm6C3zs40Ik+3ajnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513467; c=relaxed/simple;
	bh=sl9h3yMfjPSxtJrcT6HfRKy85d3oCmDAKn59+bM3b/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGjY01JiJC8PxaAO5H8Fpc2fliRXlcmP1gfviwDtXWTnvs4sqlgiNrSgfBVv8S/hayn87OhuC5WMXrJXKmIKtz2s39FJKhcblFQacoOytWmHElPrho3Jwz8YetFYEvOHAxqFwDuSgrTSFjdK7LDI0joxnh3LYJ06KNwxHWPEGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRjor6wD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5E9C19421;
	Fri,  7 Nov 2025 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762513467;
	bh=sl9h3yMfjPSxtJrcT6HfRKy85d3oCmDAKn59+bM3b/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRjor6wDeHJRiukHQkSIdsva65dzC+eNBo25iJQ0X1DLR0Yu8g7D42n6ZfISmdxqM
	 mToyYEbbPAhOIi1B1PYFHpOECT3R13mUxS6FHvWMGvC5rgvAbPpG1TKi+O+bMQ7PXi
	 Cd1TgW782RRhq6nYrn9LBV2cfNoBa81QJF/M7aUPE766HJTFMo5wOMM4uBwW632wU3
	 t4b2vILugTMIMJmhtOL9vNUZ7mf7eh0td+LoDLeLOpQhUAp24aOjgpDtOsNczFocla
	 Wg2hIYnLZulpVbVjay0W+rMR6GpQomPfkRqh+Ev8FmrEf/8vINh4uCyReh4cZxCO25
	 sOzX9D015tJaw==
Date: Fri, 7 Nov 2025 11:04:22 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Breno Leitao <leitao@debian.org>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Message-ID: <aQ3SNvSigJwffoQK@horms.kernel.org>
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
 <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
 <CACKFLinyjqWRue89WDzyNXUM2gWPbKRO8k9wzN=JjRqdrHz_fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinyjqWRue89WDzyNXUM2gWPbKRO8k9wzN=JjRqdrHz_fA@mail.gmail.com>

On Thu, Nov 06, 2025 at 10:45:21AM -0800, Michael Chan wrote:
> On Thu, Nov 6, 2025 at 9:06 AM Breno Leitao <leitao@debian.org> wrote:
> >     tg3: Fix num of RX queues being reported by ethtool
> >
> >     Using num_online_cpus() to report number of queues is actually not
> >     correct, as reported by Michael[1].
> >
> >     netif_get_num_default_rss_queues() was used to replace num_online_cpus()
> >     in the past, but tg3 ethtool callbacks didn't get converted. Doing it
> >     now.
> >
> >     Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com/#t [1]
> >
> >     Signed-off-by: Breno Leitao <leitao@debian.org>
> >     Suggested-by: Michael Chan <michael.chan@broadcom.com>
> >
> > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > index fa58c3ffceb06..5fdaee7ef9d7a 100644
> > --- a/drivers/net/ethernet/broadcom/tg3.c
> > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > @@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_device *dev)
> >         if (netif_running(tp->dev))
> >                 return tp->rxq_cnt;
> >
> > -       return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
> > +       return min((u32) netif_get_num_default_rss_queues(), tp->rxq_max);
> 
> Isn't it better to use min_t()?

FWIIW, umin() seems appropriate to me.

Commit 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
includes quite a long explanation of why it exists.
And that does seem to match this case.

