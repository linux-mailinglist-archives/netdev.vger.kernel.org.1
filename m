Return-Path: <netdev+bounces-101200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4178FDBA8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A97B241A6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2644A2D;
	Thu,  6 Jun 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngV79afv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79BDDBC
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635176; cv=none; b=hHoavK0lcbAiQzHGzzo3j9Gx8XM00Y9bvcA0EXLPgGtnBLMfoHaSCq0omPmGTOZwozK+MEEsyVJrlxglMa/iNwvkFxxrjc11CsWRUvu7BgAAXOf8NyoRbZayyBE78itzKH5GeDSzF44t0B4emb9Es7o2TJ9t/2qp4IOqSFz9uG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635176; c=relaxed/simple;
	bh=lFib/WJsFKyB9b8ijdG++zG6LkubA6WS3J+jyAitSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKxAqQt1UoUNYgFCvU67EpGBnKD40s42r53bmcdhkPxvizIjC6ful3K+zQ78UBzZLQtfW9rDdA+RVx/GbZDcHcKzfbsZj6LLJR3dkQv80jW8LIKm1EaCeioZYyLRJaxE/ngQ6Jz6IUKCo095AeeUYKNChjG46AYqr4dkuUp5pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngV79afv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58782C2BD11;
	Thu,  6 Jun 2024 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635175;
	bh=lFib/WJsFKyB9b8ijdG++zG6LkubA6WS3J+jyAitSSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngV79afvLxbkHl8afucw0iBQhswprpHxuXFMsQm09Sa1Aogv3mTccMKI1ZGIQoT9H
	 7YDcdKBwoUB346e+wMwVPeDWm9DE4H9Bf+G78qpqwJzEZMsZe9iURLUys3OjTegqvI
	 +zaOnL+lFTEqytmSzCYGPK3MzhwrehpBOd9SLKjtJ+MSNpzxFPDedVqBz/n7FZCbpY
	 9TVHUlHO8c1/d1uha1QKR8ASuGCo9+uijQKVsc3W+ptur3w5Pf5tIChWRQMycPV0rW
	 X9KQtM8MY8ZgtmhACkDubATdDUjfDVZOKIKZAt5jlBdSMzO9i4UVZ+q1dZuNK4zNEq
	 vwBgGC1n2oemA==
Date: Wed, 5 Jun 2024 17:52:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "horms@kernel.org" <horms@kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "mengyuanlou@net-swift.com"
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 3/3] net: txgbe: add FDIR info to ethtool
 ops
Message-ID: <20240605175254.60882306@kernel.org>
In-Reply-To: <PH0PR18MB447474CD899ACBFECF63E9D7DEF92@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com>
	<20240605020852.24144-4-jiawenwu@trustnetic.com>
	<PH0PR18MB447474CD899ACBFECF63E9D7DEF92@PH0PR18MB4474.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 07:33:32 +0000 Hariprasad Kelam wrote:
> > +		if (wx->mac.type == wx_mac_sp)
> > +			return WX_STATS_LEN + WX_FDIR_STATS_LEN;
> >  		return WX_STATS_LEN;  
> 
>              Better way is to use ternary operator.
>                  Return (wx->mac.type == wx_mac_sp) ? WX_STATS_LEN + WX_FDIR_STATS_LEN : WX_STATS_LEN;

I'd leave it be. We prefer lines to be shorter than 80 chars.

