Return-Path: <netdev+bounces-227796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80776BB76A5
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 17:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397E63AD91E
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773328D850;
	Fri,  3 Oct 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEPoFUGw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA728D82A;
	Fri,  3 Oct 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506929; cv=none; b=JFMSntRlyb+ZUqHoteOI6GmR0cQsxscyDF8hBIOj+xeioe07ZOjhBVQZ/Of+yMOw7hp/a0NOvAcHSTFegcQ3oGeaw4DPwYR6XgnHRd3CZZHoUQGxlEkg5AyWd9uO/7m2ndKohPGuVZdzGP7u/kyPZtC60h+BWJtT2syEW/LAN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506929; c=relaxed/simple;
	bh=Co2oBsOIbM6BDzLDTygJTO1DpFTpPCVsSSuNKjDRJwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQr8DjmkzTIosRC16NMDTS85K7m0xVIq8klH7dklsp7VdFvvNPn8ludNrBqzp65q2gFxu9RkKtX28Wl/xfDAMvHz8BcbFQbmcml2X8lTOJelX5dPI74KGsIRNDAMRompM3KJFCX82qosjgRXiOmXVX0+30Elz1g/8FvkJ8cCmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEPoFUGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543FDC4CEFB;
	Fri,  3 Oct 2025 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759506928;
	bh=Co2oBsOIbM6BDzLDTygJTO1DpFTpPCVsSSuNKjDRJwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OEPoFUGwCoC7KQbt+WUWygx/z1Fv3jGhkXAnIp5w9S3QYo1KOqalyeCBYlMi7wmI6
	 YAgHDmYQpzvwljt9EXOw7gJtCfaF+BycS3NDu+hkJbl8JIRacotblEnmgrYQFSVqDP
	 TzSjjCkawzkQk+AfJo6pYsik/KRu9NK5CVclhC9TDn0T14T6qfT6qrIoTrNr9GDRVR
	 d1+EELP+Gqbd4BTWYPbZ5i4JWwL6NhUx5w9dBsasSbWg9+JuNunzVwpdVLw6qIbsk5
	 5cwOFYbQGDtKFFhUdpHezNqb4eoIz7/EHl9FGNGKPwepELYVAQFc0F2icaPv6WXYXD
	 tnH6BEayoMGEg==
Date: Fri, 3 Oct 2025 08:55:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Yeounsu Moon" <yyyynoom@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure
 properly
Message-ID: <20251003085527.2edb69f7@kernel.org>
In-Reply-To: <DD8ORNMB155Q.1JK8F13D9FLNR@gmail.com>
References: <20251002152638.1165-1-yyyynoom@gmail.com>
	<20251003094424.GF2878334@horms.kernel.org>
	<DD8ORNMB155Q.1JK8F13D9FLNR@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Oct 2025 21:29:23 +0900 Yeounsu Moon wrote:
> If an immediate change is required, I can submit a v2;

Please do

