Return-Path: <netdev+bounces-209129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9323FB0E6D9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FE07AF03B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4328B7D3;
	Tue, 22 Jul 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um7V0viP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CC28AB10
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225204; cv=none; b=dFqvahWiZW6u3glBcHswGrPqViPcU8PwbbbWh/YK863Q4QO9d91X6Yizj3OlV00ypORZwDILMqKicidUP35v1WVLkbFRQJCQlvrLjt9OMn2P0hG09zJs3uzewRjGd6dk9DLO4ra/jYSn6pUSvKdV6CUwBEKHsjP1p4Ecez0k+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225204; c=relaxed/simple;
	bh=udmL8cVZ4v/HoPSrSTwtMl4e5vLAQwy3ouWL9zvxlCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2zyHV1Pik/zEvUG9wb7bNaj2g8lDYgq78NBw/HMEFtiXeVbtQP0nXp85cf2JurxN6NhJMpuYS+FGP1OXPQ8wIw1L+p2qJ03jnMDpsgLAr4Jn7pjOe7kC/AQYHLnmWb+6yxWEldXF4r+LTLzexu7LILhI3afvsr6v1qlWgjWv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um7V0viP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4779AC4CEEB;
	Tue, 22 Jul 2025 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753225203;
	bh=udmL8cVZ4v/HoPSrSTwtMl4e5vLAQwy3ouWL9zvxlCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=um7V0viPHIYrVPhW2izd6ZP+LBlQnJ+qCH+A7GC9JD4zv4Ph5wzXU3bNlKRTq2PCJ
	 vXvHtXb1BBGnahRI1u6vEkrjnBaIaw/e8wSwjfWaqNH1J4BKTliJFHpOU2N79wu6tj
	 z39oeRVP3NjLasW1jZ9DZCy6RGfbXs4XcN11UrrI9LgJbp/urATHFrk5yjoiXndw1H
	 JJuopHNDG4EFOGYpMuR5jgvczyEBp2HC0RnsET2TfqQYQ5FnJq4sCCb9w/g5mGCWFH
	 huu0V0xqX9eZXmekrm6TLZhO8RKpB1weSezWvd8bOasfEZWt3hyBHkUS9cIuGJ/bfx
	 4Q7Xtc/VZAJEg==
Date: Tue, 22 Jul 2025 16:00:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 3/3] net: wangxun: support to use adaptive
 RX coalescing
Message-ID: <20250722160002.2b5ca56d@kernel.org>
In-Reply-To: <27eb44ae-b84c-46c1-9ebb-53a79a3d68a1@intel.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
	<20250721080103.30964-4-jiawenwu@trustnetic.com>
	<27eb44ae-b84c-46c1-9ebb-53a79a3d68a1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 17:02:34 -0700 Jacob Keller wrote:
> I haven't yet reviewed the adaptive algorithm in this patch..

I presume you are already familiar with it, as it appears to be
a pretty close copy of the code from Intel drivers, yet again :)

Agreed on the DIM suggestion.
-- 
pw-bot: cr

