Return-Path: <netdev+bounces-65124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB583949E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC351C24039
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BC64A87;
	Tue, 23 Jan 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSKkOtmA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2D5FBBA
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027233; cv=none; b=ek78pkZO794lFAV+lVGwDvndAZ8Att+Q3dZvZnNChq3C7laU2skIXp5NO+GR3rlTN1ZMoM8mwBL9j2j1hjVlBDrw39qF4FKFhU49jzwnEMxxw2UjNAYEAQa7YbL3ydMWlyRCeLMnn5xHVq/aCZNoltX1YIgjvm6wOVcHB+hh/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027233; c=relaxed/simple;
	bh=SV/DWfpTlPl1R3FUWoFj4Tx1wB415CXr6f9QK3aF6KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS6S6WsjyA6ymj8gLhWecOenNav0EzDPEA2Y9Fu2+Uq60wP+MxjSClAJ8KOUgU2pNswIB6BKBSkuawMwBWb7PnYSM0Vmp91/br0LJBnqm480FQw0fe78nr5KG4vP3ipPIv4wSYUDIGNoT8A0HdzqjlQ2FVv1/9/owvHqPZqtb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSKkOtmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C425BC433C7;
	Tue, 23 Jan 2024 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027233;
	bh=SV/DWfpTlPl1R3FUWoFj4Tx1wB415CXr6f9QK3aF6KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSKkOtmArL6TWknrnF46uvD2YcXKn5Z2DgsjCX2lmHQFC+Ft9814XYH8M+xTPE5Kt
	 zd2lgybBHzq721VlmTYkWA2PdNNZGiWpvyBDD7dJH5duvlUaP06vqVHDDVFKT6bLn1
	 kPrNXl4B/Bkz9721u1kNftgzYEX8rcqJlQTES+AKo5b+ptglybSTFO4dPMqBFnXRWe
	 cTfALfIB31Gae+73GNxCp2qq7JSK4G+TWL6CUthgfmqYTWhR66B16ehPKRfQbejlHy
	 TvI1iv0EQPtekXKcJ9P3zVUeG8y9qRw/F0koDEX0PqVHn+CNlCYsDCCC9h6O2qQ8cc
	 q+PgCxGd4/j6Q==
Date: Tue, 23 Jan 2024 16:27:09 +0000
From: Simon Horman <horms@kernel.org>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jeroen de Borst <jeroendb@google.com>
Subject: Re: [PATCH net-next 3/6] gve: Switch to config-aware queue allocation
Message-ID: <20240123162709.GD254773@kernel.org>
References: <20240122182632.1102721-1-shailend@google.com>
 <20240122182632.1102721-4-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122182632.1102721-4-shailend@google.com>

On Mon, Jan 22, 2024 at 06:26:29PM +0000, Shailend Chand wrote:
> The new config-aware functions will help achieve the goal of being able
> to allocate resources for new queues while there already are active
> queues serving traffic.
> 
> These new functions work off of arbitrary queue allocation configs
> rather than just the currently active config in priv, and they return
> the newly allocated resources instead of writing them into priv.
> 
> Signed-off-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


