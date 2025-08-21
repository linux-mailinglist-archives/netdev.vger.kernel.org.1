Return-Path: <netdev+bounces-215425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1EBB2E9F7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702963B733B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96411E7C23;
	Thu, 21 Aug 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHJowb46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D31C3C18;
	Thu, 21 Aug 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738291; cv=none; b=Ynw9Ge+fBgOsOB4d9ZtjcgppyPJedIIfxqbczuHoaMpZD49SvIi5I0mqGE3WIwBKVHA+Th733DSA1kkMgQnZbZ6BuG0rPaeX+leWIXBlD+Oq7hIIOGbGTaUlGJTjm9v27S2Y4OHa6igSEYAsSO08QLe1i8nND3HADfE933UdBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738291; c=relaxed/simple;
	bh=/AvE710i0gE6Lo3lrAtZqoubUx3I8RThexbrYd/Lo1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCwg2yjQE6lOOo/iBaDE8kgAxGxZHCuTtoHldZB7+2E9sEO/C5b6P0PgnPGAU9Jt8MfWbp+cxJq8btOnbqLWWy/KWKdraiQLfm2Vd6EqJGFTr5/q9qNUMsP8J1rFs64emPOdx7Sie4+CNn1qfz+YnE7jdwyArVivRnqlocsfGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHJowb46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE94C4CEE7;
	Thu, 21 Aug 2025 01:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738291;
	bh=/AvE710i0gE6Lo3lrAtZqoubUx3I8RThexbrYd/Lo1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZHJowb46dkhYXePfIeNmN2jI/DW6/t8FemZmBo+GHaBaggmLs9oWyu2O9dY7sfBjo
	 eT1nV9btUoohXQazA7IXwsmLiNJgGCn/VSYOaZZddj7AJgzymxopsRBMHlOjHlV/nT
	 kXi4WC9qZC7Vf0SiAR5FGF4gAO2M++2QhQOJgVnTsJ7B3yGL5XO0V2glNbQmha03ft
	 w9cR3Q3CRwKiG7G+zsuQrKp13qCdWzot3u9NGIVyvCFSg+1bQPyzgnM2/+JzmRFXOH
	 KXI/w9WY8nlVDYJRxKrZVCp08FgXkNaZQdOGQHy8qRQShigPfHUVu+eu/MlkxWX9L1
	 zUR58I1mj+X3A==
Date: Wed, 20 Aug 2025 18:04:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/7] net: devmem: get netdev DMA device via
 new API
Message-ID: <20250820180449.15da4691@kernel.org>
In-Reply-To: <20250820171214.3597901-5-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
	<20250820171214.3597901-5-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 20:11:54 +0300 Dragos Tatulea wrote:
> +		NL_SET_ERR_MSG(extack, "Device doesn't support dma");

nit: s/dma/DMA/

