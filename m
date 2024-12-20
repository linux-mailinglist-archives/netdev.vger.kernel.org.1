Return-Path: <netdev+bounces-153566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC09F8A8A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CA7A2272
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134A26ADD;
	Fri, 20 Dec 2024 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlnyQmbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90171CD0C;
	Fri, 20 Dec 2024 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665005; cv=none; b=QG7n4OLWRAti9bJp5FXAFp6QyZRKmofoUYK79xuOV6j39JJP56pgyA7yjMzowiW0OAJtSERQPCsIqMWERBc6v5NHOn7ESMAEBRzGyaNzy0yeJNn2YHyM3NmECqDDrVKzJfxpC+lKHvDMCTDFYQRu72S5G9tcSi5Hgv++dlVegLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665005; c=relaxed/simple;
	bh=D5o1KS1ZXYqDexW5gR7ofSa6ubikoY1hKDDLGKr32/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjs1MshcMYmI5OKdw6Q4letLEjD2BW84LUXMdMf06spKX37uBuPdLnZ5v6hM2GsaJ13oXK5vZNNZqAh2rGodt8d+lKA0CCCX9amt7zYmkaCgOporoSGGp1q76+EB7leHOhBV2g6vf1rL+ymIHI0rKb13ADP9+H8DwA1VVwRKMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlnyQmbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D23C4CECE;
	Fri, 20 Dec 2024 03:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665005;
	bh=D5o1KS1ZXYqDexW5gR7ofSa6ubikoY1hKDDLGKr32/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YlnyQmbzIr16276pVP9oCaRdFS4pBR0bVA2Fq0taAD9IFXDL7wDAjs5MLuFv8ZI5b
	 f5XHr2RhFPBUf55NH3we4J7OJEkPGQaIRoOWM0IoxqH7Rzfg5N40t9AsP+RypD27do
	 6EnzLuC6rqO3ahAEdakcbSNKwIlkuSmANmmg8TPDe9Wh81H0QHywR4Ppmu9Z1Ep4/v
	 dQqj4hv3ih4zugwTC2bFdVjmXYcHNaxj6UzkYfLfbCYJsJYlUKaEIk9SaVelMj9mT3
	 FA3O3U01P11Zr5G9Ix3ZX4KfA2sYcnq6kFVaPH0iNDaePvjaV5D61uL0e9pXwdm9oq
	 paCn0D0GipUUg==
Date: Thu, 19 Dec 2024 19:23:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Abhijit
 Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>
Subject: Re: [PATCH net v3 2/4] octeon_ep: remove firmware stats fetch in
 ndo_get_stats64
Message-ID: <20241219192323.4a083d37@kernel.org>
In-Reply-To: <20241218115111.2407958-3-srasheed@marvell.com>
References: <20241218115111.2407958-1-srasheed@marvell.com>
	<20241218115111.2407958-3-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 03:51:09 -0800 Shinas Rasheed wrote:
> The per queue stats are available already and are retrieved
> from register reads during ndo_get_stats64. The firmware stats
> fetch call that happens in ndo_get_stats64() is currently not
> required

Because they are just additional error stats?
No longer reporting errors could cause a regression for monitoring
systems.

