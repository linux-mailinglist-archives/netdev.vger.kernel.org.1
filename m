Return-Path: <netdev+bounces-246804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 990CECF138C
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290F230057F0
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381582D5926;
	Sun,  4 Jan 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaoKMbtW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034A3A1E7F;
	Sun,  4 Jan 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552864; cv=none; b=GwXlCbHsHA/v3Fb0WTuci/WkLwLbv/ZzpLveJEWSc0+Xe1gpFmQsC/VYGpn7yYyCbhkvTgQOEVTZ4OPZE+68Oh4eFRd09cmS82wWTNq4PpZUehZ1U64zuRObhYadX4wnzuxf5ouTSm83C7o7Qx4HdO+hJanr78WivNWfAvL+jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552864; c=relaxed/simple;
	bh=b64yCDPV0gypolmqb/BLbVIIz9PR4lYLa0jw0KQQIOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDpErUD21z0B3thyj+Gn0UZlbNxzW6ic50zJ36e5U50iIUQvXDinLH4nwxaXaV76p05R9RfpWKxQItBPJ14jUQ2izz3mbbv80ubcuMmByYuZLYXjJ4imKfjwjVsua1TsYH3DyzVx64A67XiZat+dzvUbrJx+2WOKRD08VNsh5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaoKMbtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388C8C4CEF7;
	Sun,  4 Jan 2026 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767552863;
	bh=b64yCDPV0gypolmqb/BLbVIIz9PR4lYLa0jw0KQQIOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eaoKMbtWuBkKRJlZCXIOZK8lPfmQpVACDRJ5WMcDbmU4SB8/ul2Qkgh+bhUI0cmSE
	 C4Q6zBMrr9DXj+jNjUHWYTYML+PqFFs+JfSoWF3XeGH9fqmhMavG4JD10jLH35Qnlc
	 dHFHYbnKVcDtuqNVjzzBNx5sVbCs9+dIuz5uOPFAAeEyK0jdtQ7ilq0Hb2HVz8/GG8
	 BBtadzt/jN/2EXkFYOKd184foontkFYsPnlfP5JVTVyLP7Bvz47eYoeBWKM2YDTFIZ
	 7V2f2h2uaLXFr3qwtlKFK/CAYxnIUo8GVnTcP7KBFRUbm/Lj8HKh41kGws5TlpztAs
	 GBnJ/9x+aCXJQ==
Date: Sun, 4 Jan 2026 10:54:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: yk@y-koj.net
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: netdevsim: fix inconsistent carrier
 state after link/unlink
Message-ID: <20260104105422.57542bd4@kernel.org>
In-Reply-To: <c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
References: <cover.1767108538.git.yk@y-koj.net>
	<c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 01:03:29 +0900 yk@y-koj.net wrote:
> +	netif_carrier_on(dev_a);
> +	netif_carrier_on(dev_b);

	if (netif_running(dev_a) && netif_running(dev_b)) {
		/// your code
	}

right? If one side is down there should be no carrier.
-- 
pw-bot: cr

