Return-Path: <netdev+bounces-154088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1B9FB3F1
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2441884D18
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCC1BBBFD;
	Mon, 23 Dec 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkSMVUj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B038F82;
	Mon, 23 Dec 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978149; cv=none; b=oIciBLVBD0B8LoWDvN0GuejSdkYZHgxuxHtMWtQq2FfqYMXiLqmxdZ66MSF/wjajN+0avPHmgLn5zlbrz3beLL4Up90qFpNhSjMK9BcG2jS2iotCp+DUxjumpSIg5NM/LIfNXDpGFDmWQXjwyS3d/1iFEwIu+ynCulB+zsnnwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978149; c=relaxed/simple;
	bh=FF7PzJvn7sDlwqSQQcQLyBEeHni4WaUfhYkI9VeAF3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlTVFPRBaMUu0tC0sCoMbubqq5TnVuhBD24cUpDA4t/viXfMYtj4eyeYktErB0+IUwZY+AK9Vy1A9QRoZrRclGxu1puTisScFEoxznvWRqCvMNoX2dttwKFsZM/XWUN9/Ne8gNI1VZI1uoEvLKMb76lSW4yeT7fPZOgcN4fOqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkSMVUj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECEFC4CED3;
	Mon, 23 Dec 2024 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978149;
	bh=FF7PzJvn7sDlwqSQQcQLyBEeHni4WaUfhYkI9VeAF3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bkSMVUj0V2fgfEA0mKOALw2ZNypn1x/GAVZfDrdk8v3ARf9YIpNDECu4UuFr4GmyC
	 iL2zLHv1BATyAVjF1UThm5n/o01zacDf4YbwFSykchfyavvmn0Yx3CZKaS7SlRhSEH
	 OhZV1DhYNM2cW7Kv6blkkXZqNHYu0GAiHK1X6zORY81mSAnXtlH79DA7kYQA2vBN+/
	 XeFdM1aL14DzPXW5nu/EIePN175He0AjflJEFze/dzoc5OxsJJBIQ+SGbjrFtJFCuc
	 4js4/Pdglz6JPNRhOULqSkf8gDPU73H2ezt+BRttOSz5XqB4b+NK+r9w+3DGVTYP9T
	 yE1ExjJbNnpug==
Date: Mon, 23 Dec 2024 10:22:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: <wojciech.drewek@intel.com>, <n.zhandarovich@fintech.ru>,
 <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
 <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net-next v2 0/3] Add Multicast Filtering support for
 VLAN interface
Message-ID: <20241223102227.0c4e68be@kernel.org>
In-Reply-To: <20241223092557.2077526-1-danishanwar@ti.com>
References: <20241223092557.2077526-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 14:55:54 +0530 MD Danish Anwar wrote:
> This series adds Multicast filtering support for VLAN interfaces in dual
> EMAC and HSR offload mode for ICSSG driver.
> 
> Patch 1/3 - Adds support for VLAN in dual EMAC mode
> Patch 2/3 - Adds MC filtering support for VLAN in dual EMAC mode
> Patch 3/3 - Adds MC filtering support for VLAN in HSR mode

## Form letter - break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

