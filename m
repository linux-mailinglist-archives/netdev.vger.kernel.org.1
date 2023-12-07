Return-Path: <netdev+bounces-54921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F5808EE6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE31D2816BC
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D44A9B5;
	Thu,  7 Dec 2023 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7SuUsyj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE32481A7
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 17:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC5C433C8;
	Thu,  7 Dec 2023 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701970822;
	bh=3MgrRRErz3B11UzvKdbThDbzeiqoC9nl2Co0KiKHKTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7SuUsyjeYZVjUYjy9EFw2ib1iHEJTtYdMVmNH7f02ietc+AZGEaGmOPGeAVPM+Tp
	 7MuWLZ4NX0ohB6arsxCJdNEJUSN8/eRiLMyT7g7cge/9EbVcN/antkqLsGbQ+QQIu9
	 n+KPNeAjB2i3sywdMiiIjScvcyRS870eFGT56ixMUb5VoUu/vg5XSMKZE+rGNT/aX4
	 JQBc42daqQyGC+R+uirXAygB2P7tfyNaoyuS2rYiOdyvzYCggYFL4dWYzaxlzTWfP4
	 ECAzlY3wHQrcnbfueTWGKjy9kHgG2RhpJfoV75VchpnlF/s1va2iYVyTKIOVjt0oyg
	 oxTOGyE93WayQ==
Date: Thu, 7 Dec 2023 09:40:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, <netdev@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, "Marc MERLIN" <marc@merlins.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231207094021.1419b5d0@kernel.org>
In-Reply-To: <a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	<20231206084448.53b48c49@kernel.org>
	<e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
	<a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 11:16:10 +0100 Przemek Kitszel wrote:
> I have let know our igc TL, architect, and anybody that could be
> interested via cc: IWL. And I'm happy that this could be done at
> relaxed pace thanks to Johannes

I think you may be expecting us to take Johannes's patch.
It's still on the table, but to make things clear -
upstream we prefer to wait for the "real fix", so if we agree
that fixing igb/igc is a better way (as Heiner pointed out on previous
version PM functions are called by the stack under rtnl elsewhere too,
just not while device is open) - we'll wait for that. Especially
that I'm 80% I complained about the PM in those drivers in
the past and nobody seemed to care. It's a constant source of rtnl
deadlocks.

