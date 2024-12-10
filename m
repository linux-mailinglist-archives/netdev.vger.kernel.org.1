Return-Path: <netdev+bounces-150768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E239EB76E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB57162568
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46E23278C;
	Tue, 10 Dec 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofnDEbMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034241BC09F;
	Tue, 10 Dec 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850531; cv=none; b=V8jbXzj1XkAoYTsIA87zyBICwtenn8d/z7DqSMTxatd2fjYgETMHEwfY84/oPY/7+GOjAEfdeMNTz2l0i4USN9LUS8vO67mglSB2/iVpap6n6IEtQ/QARtk4tijbWg8D4XPLx0lQGXXV/AukskklrUFYaWkeaeIwHUd5toLz2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850531; c=relaxed/simple;
	bh=Y2Vsc9I8jXblIm8hGxv3z8aLdD8Oy15ilENKuf7CcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCX6vhwfspts6+0+m0/CcKlCgnFGGGlp+0TsvtXsJgzqojuxCXp+jnWjqhNKCxXqsrEwCilpBFFbT/RECb5lE36ZGBfzS2RJ6BkI4UOzbDGqCH4T+xn0iQ27lMvPJ6Vt7onld5iPKqSFU8Ekmzbu517WPlAzSb5/9JfCK2+kNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofnDEbMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23248C4CED6;
	Tue, 10 Dec 2024 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733850530;
	bh=Y2Vsc9I8jXblIm8hGxv3z8aLdD8Oy15ilENKuf7CcYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofnDEbMFjMzeKLwbusCHwIouhHE62Tpps/H0nx+myKUTHwG42TMHJ2wu/6AuaCX0X
	 WCAT90xAF+jvDZXW8Ax6apC3qPCUwd5kpI35roavSt3GiyBt5lTY7NzK2lAJi/SFNo
	 nfx1Hg/oFMwo+9TtmeW7pDxj2P6g1bafNBlXgICLyyhwyh5j6ASMgYc19OvHoNUoz2
	 oQmGirG6N0rNMeP+JnJYZ/4B/V6kXspDkb5RKsr8Csrw/QsDeaYQKimzlzfFTf2JU2
	 pEZkYD1Ei5S8WXwsG8j1OsAciT63lZEs4KPhuDbOl2UKH0RWjgpKiZO45eZjj8C3rs
	 /PzQlqpoAN5RQ==
Date: Tue, 10 Dec 2024 17:08:46 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH iwl-net] ice: do not configure destination override for
 switchdev
Message-ID: <20241210170846.GD6554@kernel.org>
References: <20241209140856.277801-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209140856.277801-1-larysa.zaremba@intel.com>

On Mon, Dec 09, 2024 at 03:08:53PM +0100, Larysa Zaremba wrote:
> After switchdev is enabled and disabled later, LLDP packets sending stops,
> despite working perfectly fine before and during switchdev state.
> To reproduce (creating/destroying VF is what triggers the reconfiguration):
> 
> devlink dev eswitch set pci/<address> mode switchdev
> echo '2' > /sys/class/net/<ifname>/device/sriov_numvfs
> echo '0' > /sys/class/net/<ifname>/device/sriov_numvfs
> 
> This happens because LLDP relies on the destination override functionality.
> It needs to 1) set a flag in the descriptor, 2) set the VSI permission to
> make it valid. The permissions are set when the PF VSI is first configured,
> but switchdev then enables it for the uplink VSI (which is always the PF)
> once more when configured and disables when deconfigured, which leads to
> software-generated LLDP packets being blocked.
> 
> Do not modify the destination override permissions when configuring
> switchdev, as the enabled state is the default configuration that is never
> modified.
> 
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


