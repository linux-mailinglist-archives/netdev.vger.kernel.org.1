Return-Path: <netdev+bounces-181683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CAFA86175
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBF23A6C57
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7B20C02A;
	Fri, 11 Apr 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS2UHcAo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408071F5833;
	Fri, 11 Apr 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384356; cv=none; b=T6oe1clZ4YAU404k7XfQ7iRZj5uS19FvP/8fVcOdAMC/JPhhndc5CNeW4H8zJ8tgQQlvxD5O7Zx8v2kTFBUiPjGJiirQniGQXdbgzxGNgXcAxDqOxKyqV8jYAGgxTK/wV9CgoqZKygM/gtWfNKyLv0aOoQ6iqPpam+FQH/9lifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384356; c=relaxed/simple;
	bh=vvzSwkKhtLdyZ9hXI/dUojub6tRyU46DlobIzZ40CJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTfXKBnYMtiBeQ8PdPPTkp+jhf0evYrMquiDY8uJ+Rmdg+ZxUMvu14ERkhumhNh5LTl0a3yLfOqmYGN7dS24IcLr508VwEWCxjrOBSeWyyp6QLQSF6dBQCbkv6Z6tlKPJbTCK0N8nYwI129IZnQtcTJcY+4TF1Ic30MV+XCer1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS2UHcAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6183AC4CEE2;
	Fri, 11 Apr 2025 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744384355;
	bh=vvzSwkKhtLdyZ9hXI/dUojub6tRyU46DlobIzZ40CJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS2UHcAowbjl6gyq30nE/oqcS+j3DYyKHWffRwavmfko1FaPF7EIAT7noZ2bmby8u
	 uUR24a5i3AAQMIvN3oCwrB+IYUPrZz/FY0wUcOUsq9bk3lSADRUj8r6mAvDmW8w19E
	 lmUmc3gHRy5qvcoJuhvxo9xpJjXBmkBFT6VJO4jxK+IifOBr5ogtnh/jHctayNezjd
	 5ej/xZoNnjhwhbvQeyWS2hrHMuz3wBS/lh3qlXV2cfx8EEpUNIdHvveLlkS9muYmWB
	 uV5k5JslWVbXXm1iyfEZ8TMzUHPjhijJBy8+Yk/Tdt/X2Zz1hPWCh4DJHRkBimnMqY
	 QXdvMez9FVy8g==
Date: Fri, 11 Apr 2025 16:12:31 +0100
From: Simon Horman <horms@kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] batman-adv: constify and move broadcast addr
 definition
Message-ID: <20250411151231.GI395307@horms.kernel.org>
References: <c9d8fd3735ffe10d199ee658703766bcc0d02341.1744222963.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d8fd3735ffe10d199ee658703766bcc0d02341.1744222963.git.mschiffer@universe-factory.net>

On Wed, Apr 09, 2025 at 08:23:37PM +0200, Matthias Schiffer wrote:
> The variable is used only once and is read-only. Make it a const local
> variable.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
> 
> v2:
> - make variable static
> - remove "net: " subject prefix to match other batman-adv commits

Updated version looks good to me, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

