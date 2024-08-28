Return-Path: <netdev+bounces-122977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF769963524
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D729283BCF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857A16CD1E;
	Wed, 28 Aug 2024 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLL5vpkb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51C16078B;
	Wed, 28 Aug 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886094; cv=none; b=KGbYpy4O3x2zambTkyBgocpma6j4osGOuA/zkgCx2ozgabBcH5CKgAbv9+9a+UcKPt1UqEP2R+4jaIj6tNGdky+mMLa+hcaY+U4S6uHcih9Ad8D2PNoIc0o/xDcEtav629tgtcbWBgyBqAemwRnTst6qm20vm0huL8Wp5H8DUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886094; c=relaxed/simple;
	bh=QhqySy6liYUIynhmYdOqTS2jdfyWM/Ynqvc0Jr8XWpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU0Ot29IMKktSjJaU8zzS5XZQkpshIELTvN8H2ezCG+iwic+dvytuG3JWG88CmINqMqhEUM7qMZkhmAUdohZcoAMxs4r8wEhBQrNiAX9zG8USQSwW1wmtSr3aqXP4eSI9wf7GAA1M4Ms8zvejaDjpy51n4eMFKk9GXGKGPc91m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLL5vpkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F77C4CEC0;
	Wed, 28 Aug 2024 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724886093;
	bh=QhqySy6liYUIynhmYdOqTS2jdfyWM/Ynqvc0Jr8XWpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLL5vpkbTVaWqlQtIwLponzT2YfhmX8oFj7rSR0lnRUrWQUPs/Lo6ODnjBh3Y+kBs
	 v6AxBPX7wKgNxwJNG1YcoGZsFXc5gdQ2XHvtJ9RfyTqYDUi8+DNoiwBwRpeDuJM7jM
	 SKXXFzp6kgYRx12hFSZsZGYQtyhgwtBtanxdcUofVDQryNx3t4qmUPMxlSjjIDEjcF
	 a5/L/tbDVmkHZd6bMYVvyrLNAOoVDY8iKK629FdftfttpQ2Z+aGAOV3MgwBdN3y5x/
	 rpO4omEzc6fPMAIUYIiVt6W3gpf71hNjpgUeOGk+kwT+m8GpQSPJh6Iw9MR3mjcbhr
	 pLj+rWz5fbpLw==
Date: Wed, 28 Aug 2024 16:01:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Shen Lichuan
 <shenlichuan@vivo.com>, <habetsm.xilinx@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>,
 <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] sfc: Convert to use ERR_CAST()
Message-ID: <20240828160132.5553cb1a@kernel.org>
In-Reply-To: <63d45a76-6ead-4d62-bbca-5b1e3d542f1c@intel.com>
References: <20240828100044.53870-1-shenlichuan@vivo.com>
	<6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
	<63d45a76-6ead-4d62-bbca-5b1e3d542f1c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 15:31:08 -0700 Jacob Keller wrote:
> Somewhat unrelated but you could cleanup some of the confusion by using
> __free(kfree) annotation from <linux/cleanup.h> to avoid needing to
> manually free ctr in error paths, and just use return_ptr() return the
> value at the end.

Please don't send people towards __free(). In general, but especially as
part of random cleanups.

