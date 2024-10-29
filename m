Return-Path: <netdev+bounces-139935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640B9B4B69
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379BA1C2219F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561F206956;
	Tue, 29 Oct 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0f9vfjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC2206066;
	Tue, 29 Oct 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210176; cv=none; b=MZ2H9RIATpdly52lvrXZmq7Ic4z7FQ+OFUTE69asMwP2IpqWBzpNu9IsQjYTrE0MYBr1x5QGAW9LR9NWC7Sf9ph/JAHnLmcqScKDSlOoOnYrTf29q86MFoWa5zOq4eYhhMdH1uDIrSEweq+DzwIO1SH5RJG8OQ9OWMnkEuNN2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210176; c=relaxed/simple;
	bh=Omhk+6bzE563DEqVrxai9r68DZuEFQ0N24D4UaTyCso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6Ccsw2TeyGjgLfwd1Lw6ihbIhTz5nJaUs4NvDCELDz8eC8GGFZWk54PBBI6TFB82L4zglK7gSQpx/tZGxJP9Ucc0Bj7RlgjVU+8czc4Dl0vKo/C/0d9T4t0HTrn2a/O/+UoWftLHd0d36k5Lfs0b+32d9mOvgmLjG9xmT5fm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0f9vfjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2698C4CECD;
	Tue, 29 Oct 2024 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730210175;
	bh=Omhk+6bzE563DEqVrxai9r68DZuEFQ0N24D4UaTyCso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0f9vfjYGZzHbNOVqFFa8Xtgy3daCLGh1XnyJH7rQbwBFV/lJO7IJwwcltcO+boxM
	 Ap3GMPsIhzq3QWVLum1Q3zmtW7NTLNWj0rlCM+6jlt/muN+FUDmnp4w5WCjenYkxGr
	 S2ACCQgyVX3Ls9BRWz3FWS2LGd8A5e0Sosn4E3TE6R4Mj+3ebvDeqSWleAc0IuoXbi
	 /aiohecPvbNE2opvRcIRlGh/zjTkhQZtWWgF9zPn78XvnAcbkAORBFzh6usu6ciEe5
	 wSh8lm2HT4TF8bNcXk+JKzN4cXXcEZWDxCEBpOOGpNIhU2D2oquAEkkheqz/lI8nzF
	 +z2Ag3kbdaglg==
Date: Tue, 29 Oct 2024 06:56:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241029065613.043fa9d6@kernel.org>
In-Reply-To: <0bc27725-cd55-493b-8844-ee2c5baca5f0@embeddedor.com>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
	<20241028162131.39e280bd@kernel.org>
	<158eb222-d875-4f96-b027-83854e5f4275@embeddedor.com>
	<20241028173248.582080ae@kernel.org>
	<0bc27725-cd55-493b-8844-ee2c5baca5f0@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 20:37:13 -0600 Gustavo A. R. Silva wrote:
> The rest will essentially remain the same as the change in
> include/linux/ethtool.h triggers a cascade of changes across
> the rest of the files in this patch.
> 
> So, you tell me if you still want me to split this patch. In any case
> I'll update the changelog text.

Unpleasantness. Okay. Update the commit message and I'll give you a few
more nit picks related to variable ordering.

