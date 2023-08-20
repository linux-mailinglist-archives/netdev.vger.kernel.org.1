Return-Path: <netdev+bounces-29162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E639781E5A
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6E31C20896
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153E53B8;
	Sun, 20 Aug 2023 14:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868617C1
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C3BC433C7;
	Sun, 20 Aug 2023 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692542709;
	bh=2axdRh5qNFWVk1PGIYs/8FdjmE93UURhhLvGBII6n04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZehVKQCGSTVV0QT5my+3O+2oaYpeZVhuTkm7giu/cM2nPp1BYNMVfQCNF9D85Vkpa
	 iDpfcZN8mjcUmmqmiqIz7H8PdRxrtjkLjxAWKtnsXfSUO0fGO/vnyOURb+uQkOCQ1U
	 ARvjoLQm1o0MwltmcFtkuve2VP5lpttfz1pnR49KJTzmM/xnYL90My9SkPBjistH7Y
	 yCrxKAigsOseD6Qc+wEVtnP74RlEqLqzXvgVRpNTpQ6Ga0DhiG2rp9p2GP5K3Y/UK3
	 CI3cH2eCVxIyUjLWturIrIsGMyUiJkh4sPg0FgRF1XEmz5OREPErfhi3MR1QgStCYT
	 w+c6JPCMXLXNA==
Date: Sun, 20 Aug 2023 16:45:05 +0200
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, andrew@lunn.ch, aelior@marvell.com,
	manishc@marvell.com
Subject: Re: [PATCH iwl-next v2 2/9] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <ZOIm8TJz/ykcI+PR@vergenet.net>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819093941.15163-1-paul.greenwalt@intel.com>

On Sat, Aug 19, 2023 at 02:39:41AM -0700, Paul Greenwalt wrote:
> The need to map Ethtool forced speeds to  Ethtool supported link modes is
> common among drivers. To support this move the supported link modes maps
> implementation from the qede driver. This is an efficient solution
> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
> maps on module init") for qede driver.
> 
> ethtool_forced_speed_maps_init() should be called during driver init
> with an array of struct ethtool_forced_speed_map to populate the
> mapping. The macro ETHTOOL_FORCED_SPEED_MAP is a helper to initialized
> the struct ethtool_forced_speed_map.
> 
> The qede driver was compile tested only.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
> v2: move qede Ethtool speed to link modes mapping to be shared by other
> drivers (Andrew)

Hi Paul,

thanks for your efforts in adding a mechanism to share code.
It's a great step in the right direction.

Perhaps I am on the wrong track here, but it seems to me that the approach
you have taken, which is to move the definitions of the symbols into a
header file, is, perhaps, not the best. For one thing it will end up with
duplicate definitions of the symbols - one for each object in which they
are included.

For another, and this more a symtom than an actual problem,
a (W=1) build now complains about symbols that are defined but not used.

./include/linux/ethtool.h:1190:18: warning: 'ethtool_forced_speed_800000' defined but not used [-Wunused-const-variable=]  1190 | static const u32 ethtool_forced_speed_800000[] __initconst = {
...

I suspect a better approach is to leave the symbol definitions in
a .c file, one that is linked in such a way that it is available
to code that uses it - be it modules or built-in. And to make
declarations of those symbols available via a header file.

