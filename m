Return-Path: <netdev+bounces-91423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A128B8B2853
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE0D1C20F84
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15F12BF22;
	Thu, 25 Apr 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHin9p0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF438394
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070766; cv=none; b=CgfYxZbuT/cfmngjijxscxJxolH58JGGxYTIE4BNusoIxAFuC9x8QtkXIMqjZOwcnh+cNjXX/gISaKetZhIYTl/Vx4tJFoJ4D1YxFQ27ItmM5ORQUhWsq8eR6YPw+o0042Rko7eW4y3jkJ9Q76F+VCQjLfSK2cqjWwfB18C/Pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070766; c=relaxed/simple;
	bh=6184qCCv9BqchdbV+oA0YzVmw35bUYEIlwBquxUVha8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4qILfDAb2u7l9gKavyj8Eejg1jHQ7YDDF9b151v0ghupz7N9cgKY5ofzQFT/wwhKAgGqDACiHL7fOelAa7ykBZrV9AvRCLhC4p9j6wHuRhg90MmTu4of4X3tOlE7nF8hr6cE7OgC51Wg47zdiMuIH/HAjSRKGuxk2c/fF6CCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHin9p0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB97C113CC;
	Thu, 25 Apr 2024 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070766;
	bh=6184qCCv9BqchdbV+oA0YzVmw35bUYEIlwBquxUVha8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dHin9p0KNEAzK6NMhjVlYYMP5AEEGlw7Dw5ar1d0HjwuunROtCIZa19PvVuELwGUd
	 qbZm4lVPTGKCdOgJCjQfqOrILvz81kvOI+nyHAfiXm+YGtuE3o5/XI8JmiCrd7BjxI
	 QyaDIT78u8BuAQptSJgdXqvWy312d6Lr1jYui87S+Olu33xH1aKuqjkiUwVk7V0d6y
	 cQrRBWQmysNM+aNG9lYH5eSXpAZbB4ZPDQLwOUF03K2NVLxCHyYslPSBitlWaD0JTn
	 AmNfBwgdqIAfAIAId1YZKYj6R4oRJ+v5FXm2yS3ll5wIoIX1ftTaJWCZ3xLzMYuoAz
	 c06zjjx8pLa1w==
Date: Thu, 25 Apr 2024 11:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, Neal
 Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: avoid premature drops in
 tcp_add_backlog()
Message-ID: <20240425114604.1023bc28@kernel.org>
In-Reply-To: <20240423125620.3309458-1-edumazet@google.com>
References: <20240423125620.3309458-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 12:56:20 +0000 Eric Dumazet wrote:
> Subject: [PATCH net-next] tcp: avoid premature drops in tcp_add_backlog()

This is intentionally for net-next?

