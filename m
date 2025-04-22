Return-Path: <netdev+bounces-184764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE3A971AF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8EF17ED9F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FEA28EA7C;
	Tue, 22 Apr 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR7Qd09e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08111F4CBC
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337159; cv=none; b=H1uFq39yE7tjSTsmOehyTB9FafsN53DP0aywMv3jxoBEePrnsKTaeiZh606PTEZROTnfCOvnzGeAH3K2ZPaYQMYMDejoNhCXjLRtFzAAa6oJpOiZED1FFmAFBTrIYnC47apjxPH3+Fp+xm6D+EkIOhFVRRgr0KDSSFHkHex+Pc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337159; c=relaxed/simple;
	bh=K78QEFH4vnZzDZ5+dBn1mvVeELeWIMfgOL+CDMgksWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6hVNhpSwLKb/AYlLfT+gz+yIlfo2qxIDC0Z21H0uBBiQiaaiMPqV2+moQyxjQ/BLaQeZnx9UoldSdW9JzbrUE76ITI9NHyqRENRrwbFkoNCSuVzcMpGBGbqnrwqhYRttGBG8Spwnwpz4DqLugJHb7FCPcCQFbw3MFRevqom40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR7Qd09e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEF2C4CEE9;
	Tue, 22 Apr 2025 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745337159;
	bh=K78QEFH4vnZzDZ5+dBn1mvVeELeWIMfgOL+CDMgksWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SR7Qd09eWDPJBuNxeecOVTAUogxAaRq89Kyneo3wQepp6pWnCnnP2ZG/dRUn4HRgP
	 mAAbRx36RYPxT9Vs8GgRyBK4oh7/nG3vEQYu85Wi7ts4P8nndh1hZg4l9V+xkb4AEm
	 hC1UmDe9o/qkWbiqH/dgdhi4Nc3OjYWV1rwVq22+hXqz3z4sS7VhKAuXyWCZqDr1ht
	 DhumuqgGf/mYE0KCNO6c/a5bDG3eVrxsnLN7idGNwPq0rZ5j7nASAZxwuo1Jd8f6rm
	 ALwpjOJcZaQeoF/ETLFbRh6BoJkcq6+UqtRfLaHtxyAPSjz+BLsJyZJJ0aDPeK3DUq
	 6qT7n81VfOIJQ==
Date: Tue, 22 Apr 2025 08:52:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 07/22] eth: bnxt: set page pool page order based
 on rx_page_size
Message-ID: <20250422085237.2f91f999@kernel.org>
In-Reply-To: <aAe2jaAUi0-deSeI@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-8-kuba@kernel.org>
	<aAe2jaAUi0-deSeI@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 08:32:29 -0700 Stanislav Fomichev wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index b611a5ff6d3c..a86bb2ba5adb 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -3802,6 +3802,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> >  	pp.pool_size = bp->rx_agg_ring_size;
> >  	if (BNXT_RX_PAGE_MODE(bp))
> >  		pp.pool_size += bp->rx_ring_size;
> > +	pp.order = get_order(bp->rx_page_size);  
> 
> Since it's gonna be configured by the users going forward, for the
> pps that don't have mp, we might want to check pp.order against
> MAX_PAGE_ORDER (and/or PAGE_ALLOC_COSTLY_ORDER?) during
> page_pool_create? 

Hm, interesting question. Major concern being that users will shoot
themselves in the foot? Or that syzbot will trigger a warning?

