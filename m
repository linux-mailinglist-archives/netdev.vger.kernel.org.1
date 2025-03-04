Return-Path: <netdev+bounces-171741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ADFA4E6B0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B672819C19D6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B7A285414;
	Tue,  4 Mar 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhWCrHq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A2284B4E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104905; cv=none; b=NDWYGZP4WhtAeeFo9eV95gdutjaOyeOd4RczBRwGhbAGeK1SMXD0fA6FYwhRXngC4xcWlCWLTce1RF+eDhrBedA7rvZTtjBGbyP1jEMLurFOZPQfYJOYlRjsunMidNVjUFyJ83GrHPeWMsvK+29nkhaHiuHI5VTcfrTiGjT/3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104905; c=relaxed/simple;
	bh=hdtddEBPGrCFoEOxYVxiaIWm+3bZUgiumlMKV1OxVvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2xgvcLd9yt1y1y7jxpZx0tUQm6w7tiwQvnqaQkgCBJBL2xjtMKp6GZuW3Nzf1xhMzE9BtF96MSW7u2S4j/A3Er4seO5HZL2loi2nkAC3i+hMxlQ/Pdw+bmR6rYgMDaHwfajLgsUMb/Zr9otwKLfJ0m0KXoG2KkXahL7TiRAWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhWCrHq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7DCC4CEE5;
	Tue,  4 Mar 2025 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741104904;
	bh=hdtddEBPGrCFoEOxYVxiaIWm+3bZUgiumlMKV1OxVvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uhWCrHq+roctKTG+SEM4/z7ZmPUo6M709Uyz65a2JeyP3+xhWtK4pQVD5G4bvb+G2
	 Ybw5t/rWSWpWbxKQvdiX2jfpS9pZGdKAcjFuOUZbPDlS3CXywbFJE0CMHhtSJ3+oqU
	 xq5Bk2clfiR3IYS0uB7AG/Vz122CgRfKFSIfz/l/5hhjir56/4TH6pWx0chZshG3mf
	 R5/iRy+K6UynZ03Uac9PqWzytRqt5V1tv/2oaEY096AVwhEMx1fRb17595nKC+1Lez
	 Wcf5YbaIxa13g8fUtRge/HWfopSTes80qydRxABvX+1XlKiDgtvS+nb1+8xPIs4M4W
	 bfAxf7XJ7m8VQ==
Date: Tue, 4 Mar 2025 08:15:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: linux@armlinux.org.uk
Cc: Andrew Lunn <andrew@lunn.ch>, Gerhard Engleder
 <gerhard@engleder-embedded.com>, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 ltrager@meta.com, Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for
 PHY loopback
Message-ID: <20250304081502.7f670381@kernel.org>
In-Reply-To: <3d98db01-e949-4dd7-8724-3efcc2e319d9@lunn.ch>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
	<20250227203138.60420-3-gerhard@engleder-embedded.com>
	<20250303173500.431b298e@kernel.org>
	<3d98db01-e949-4dd7-8724-3efcc2e319d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 14:20:02 +0100 Andrew Lunn wrote:
> The current IOCTL interface is definitely too limiting for what Lee
> will need. So there is a netlink API coming soon. Should Gerhard and
> Jijie try to shoehorn what they want into the current IOCTL handler,
> or help design the netlink API? How can selftest.c be taken apart and
> put back together to make it more useful? And should the high level
> API for PRBS be exported through it, making it easier to use for any
> netdev?

As we think about this let's keep in mind that selftests are generic,
not PHY-centric. Even if we can pass all link settings in there are
other innumerable params people may want in the future.

