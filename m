Return-Path: <netdev+bounces-137113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBD9A4685
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D966C282CF9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB4205129;
	Fri, 18 Oct 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McYEXrSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0420494F;
	Fri, 18 Oct 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278563; cv=none; b=OjHe6deZNnuVnmHbHpMHksqIndevmaVLQtj/8Hoa/Y9IqLtA1Q/3PClwCz8QLwr/UCk1S+t7qOE9L+jVaNe5npwm0Iqk1RR3BJMJyAAEvXP253vkmumXeQGmGSFcXyHw91gm2cUdq/elMtH2gkYFXMtJMKJH82NcavnpamJr434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278563; c=relaxed/simple;
	bh=E7PA/3i/5NXgiLYNswRWYovfYFZZvNqQX3TmbuRgYQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9y4xXn4Lh3cXuj8URkQrEDaKR6gaXB7DSBPcaOry4Nk+qK2513KTz8uZjoWzE1caNivqsJedf0U1RrQVS7AMBQCd7N0O4I0AbqrOhb4jlUd5uUUQUIAkPv3VJ3pgJfaQ8TF2gTfljcoB4fXmqGJpJ+oglJXzdzONi06FFaehM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McYEXrSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EAFC4CEC3;
	Fri, 18 Oct 2024 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278562;
	bh=E7PA/3i/5NXgiLYNswRWYovfYFZZvNqQX3TmbuRgYQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McYEXrSgtY68fGEzeFSPasP48gjag/oEICl/h8DsoiqBwtj/OaTX4PqXFxgAA4d0b
	 bXsECZI9D6t1KPY1JMD+k5OtjpVtvGLchHAkNa+KHVuUdqPQ4pOVAHeyOEDKzZy604
	 rnIqBgjdI4KaRxIYSffX+UccCiUcIFB6r5nZ7gSOXHqjweXPGfb2IYdwV/vajSPDHc
	 AIXhhuYhiZ1+56koZOGUwB+heHCccAxvdH/K+simgcSjEdVQSJSdhQclBemrG5CPTq
	 vd6ASmTTSWYqQ7+UDKx56Bf83yTXMtp0EYwsHmV2lowkFsrMYdnSAdtZfdw3T+PS6w
	 Hit9BYnPCVo6A==
Date: Fri, 18 Oct 2024 20:09:17 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in
 otx2_flows.c
Message-ID: <20241018190917.GU1697@kernel.org>
References: <20241017185116.32491-1-kdipendra88@gmail.com>
 <20241017190845.32832-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017190845.32832-1-kdipendra88@gmail.com>

On Thu, Oct 17, 2024 at 07:08:44PM +0000, Dipendra Khadka wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 9917060fc30a ("octeontx2-pf: Cleanup flow rule management")
> Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
> Fixes: 674b3e164238 ("octeontx2-pf: Add additional checks while configuring ucast/bcast/mcast rules")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


