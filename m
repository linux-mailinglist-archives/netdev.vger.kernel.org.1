Return-Path: <netdev+bounces-41809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF497CBF07
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDEB1C209D2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60A3F4DF;
	Tue, 17 Oct 2023 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTABAXgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC3381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFEBC433C8;
	Tue, 17 Oct 2023 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697534787;
	bh=3I2isP02DUWWgaL03Ie7ZnapruJ85XiGI+EyBpLF3HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTABAXgEgWhUnCG8Thm/YSTajtSZUU3GrEftgaJFm9yB1fpHAsLcVnEo2D+YJQyjN
	 BXoQcPtfwyeXDBP2zkR8npidKN+p2V0O4jVk8Gmhv7twyGH3Q3bL1EuyPQto8CTii+
	 F+UCV19SkiQjDHidJsd8ogdeEkQciLbsKftZt5hrbA4ih03TbK2HJFcq/+RXen4dAA
	 Jk9bOYTN1WiEtlZrSzAmMvIUuuXOJTLK5+I+0DL98K8H2tQVulkhmbNvrI7p0/lRHO
	 Xiaibqj4GhNB3kbbKp87tIYAeENKca78e4zUXUNFZOD6QLWuKU2SbCioBvwINxiTjA
	 JvIsJ8cP9i6WA==
Date: Tue, 17 Oct 2023 11:26:22 +0200
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, aelior@marvell.com,
	manishc@marvell.com, vladimir.oltean@nxp.com, jdamato@fastly.com,
	pawel.chmielewski@intel.com, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	d-tatianin@yandex-team.ru, pabeni@redhat.com, davem@davemloft.net,
	jiri@resnulli.us, Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v5 1/3] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <20231017092622.GT1751252@kernel.org>
References: <20231015234304.2633-1-paul.greenwalt@intel.com>
 <20231015234304.2633-2-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015234304.2633-2-paul.greenwalt@intel.com>

On Sun, Oct 15, 2023 at 07:43:02PM -0400, Paul Greenwalt wrote:
> The need to map Ethtool forced speeds to Ethtool supported link modes is
> common among drivers. To support this, add a common structure for forced
> speed maps and a function to init them.  This is solution was originally
> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
> maps on module init") for qede driver.
> 
> ethtool_forced_speed_maps_init() should be called during driver init
> with an array of struct ethtool_forced_speed_map to populate the mapping.
> 
> Definitions for maps themselves are left in the driver code, as the sets
> of supported link modes may vary between the devices.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

Thanks Paul,

I verified that this duplicates infrastructure added by the commit quoted
above. And splits adding the new from removing the old into separate
patches as suggested by Jiri in his review of v2.

This leads to nice code reuse in patch 3/3
and makes for a nicely constructed patchset.

Reviewed-by: Simon Horman <horms@kernel.org>

