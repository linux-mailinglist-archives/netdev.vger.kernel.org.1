Return-Path: <netdev+bounces-194001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A6AC6C41
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A1916312E
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC11288C1D;
	Wed, 28 May 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHYbuvSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16609286D72;
	Wed, 28 May 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443838; cv=none; b=KdhltMuaHmR3RNHQAAQzPyl0BfpDE2sFH0exQnIb4qQFGjtOeBeJ4EzwvQbjbGcbUjpLoCw+Km9ajC1SqrvWk9mZ7HFZuPvs9qs+DbTQ+GNZcZ1U5yl0rToO4r2i9YAlavQEavVwk1xqzmermxOksyq8oROBwE6+YHbEZ6wtrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443838; c=relaxed/simple;
	bh=ccOcOcTAk/DHCjdt9j3xtztJfkcF/KpTBh2jMVIYcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdthyPA5q6yJVBm1RCLR3TQW/8Kd/E4vNHFq9Nka9IPym+v/PYgLzCmgN3tmIbl4mGdKJ9rJDNkocnH/Yzibxdh/yzdcle7KEifziPSHILT8dU+teVIYa2pQwlqlq1WY9GHdqAnXei5lUTfyr44DVbSgh89rj2ppsVlhET2e7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHYbuvSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A98C4CEE3;
	Wed, 28 May 2025 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748443837;
	bh=ccOcOcTAk/DHCjdt9j3xtztJfkcF/KpTBh2jMVIYcAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHYbuvStpLdCpvHrb1K1Y0yhch/to5cnea+PsRziKlHdOAH8rKMXGyTgRWxmOX0Fb
	 try2HmWzKMxlMJkrkkVtKq4RkDYmLqSXxvqPlI/C2UmAvEvWT0ZcjcXl8xgIRCk/tQ
	 YT+pqUIFVZqYSmfg6XElBpP8dlIOhXCh6zO8JjYe7xlwrhMsaoltD2DDusbZWiu0yu
	 f3ZY7o4B7evTqGV/XB5AYQHXiupMyQoyFoXg/RqUPT/0jViDed4Sp+Xkvm/FpBlr1x
	 qpX+0VtskL2QumvQ6j89U4XwKNyXyu75N0hnzEd455o0T7KSLV8l5IDa1b9m0PQ+IR
	 OS4Oh27MgOiHQ==
Date: Wed, 28 May 2025 15:50:31 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [net] Octeontx2-af: Skip overlap check for SPI field
Message-ID: <20250528145031.GD365796@horms.kernel.org>
References: <20250525095854.1612196-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525095854.1612196-1-hkelam@marvell.com>

On Sun, May 25, 2025 at 03:28:54PM +0530, Hariprasad Kelam wrote:
> Currently, the AF driver scans the mkex profile to identify all
> supported features. This process also involves checking for any
> fields that might overlap with each other.
> 
> For example, NPC_TCP_SPORT field offset within the key should
> not overlap with NPC_DMAC/NPC_SIP_IPV4 or any other field.
> 
> However, there are situations where some overlap is unavoidable.
> For instance, when extracting the SPI field, the same key offset might
> be used by both the AH and ESP layers. This patch addresses this
> specific scenario by skipping the overlap check and instead, adds
> a warning message to the user.
> 
> Fixes: 12aa0a3b93f3 ("octeontx2-af: Harden rule validation.")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

