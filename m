Return-Path: <netdev+bounces-242504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56EC9107D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF51D4E03DB
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E42417DE;
	Fri, 28 Nov 2025 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqUfiUtB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2B2D6E61
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314638; cv=none; b=O4feyzUM+BnOuKSuyqOtBJqNnlFCG2Iog6hzotDiOM0KhYVHY9qWRAMKq012f3cJ5hbI+BAq5O77f18NUVA2EhM2ven8s/sUDq/4mAnDekx9rL1GoZGvXP9rq+HLklYwGegwzrLQ6x0/Jqn34HpP/xU+8/y8PvmLXusz/b3Rl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314638; c=relaxed/simple;
	bh=RaLPTgBpVDMW/zKqJi2/sw2VJ3ZKqb6AXvKN2yLbXts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxZ9PweMtk3/BnZ+C0JGKJkkMwdVSQgmbYLQXs1WdolaMQ6422tQQCbTFjgZ7gUOs/WKQ/ahiHBoBIWgMttNdTF3W2sOJKsnc5tr38qm2YYCsyAEnQY4TguAf16yzsh3X8WewdIbouwhEcue2YWhqB7ce77wNZP2VxlxOSD5qxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqUfiUtB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764314636; x=1795850636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RaLPTgBpVDMW/zKqJi2/sw2VJ3ZKqb6AXvKN2yLbXts=;
  b=UqUfiUtBm8KyB0dtQuEHN7VFirebT9//rTdM08CpefRKHUkVp4zUOYSA
   DeCgQt6c+DyzeLl6W55k3XRjXgAtUv+YME6RZ4xaWVqA9l2YvKVl52oV7
   ftJuviI9ZsDO8pKkq0/qRbtGzATphCIC7zcSP33KWng0Gxp8j3y5ecbQE
   c691gFNHh2EsFsXFEjePuzbyZwN1rOA15W8ksJ5uCgLIFR1M18/Ab+VjI
   7r9dTv4bKpK2bXXqDvxc3x9SwrfOVBvbTaUL/7La6t9CKoPyCgSZ2jAa6
   RCirfQNPtjiEH//hct11ht5pHtkqK9A2N/fXWC1L/KiZWF4B8q240wbu2
   A==;
X-CSE-ConnectionGUID: EN5lMRNKSGue3RZtSvmb4Q==
X-CSE-MsgGUID: RsW9g0OhQ9qBKaA7FEesqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="53914374"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="53914374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 23:23:54 -0800
X-CSE-ConnectionGUID: xpGWeLA2T5GfGg1zJPB1yQ==
X-CSE-MsgGUID: dAYJN/nHR8OY/ib2h6RtOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="193062306"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 27 Nov 2025 23:23:52 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1B3CCA0; Fri, 28 Nov 2025 08:23:51 +0100 (CET)
Date: Fri, 28 Nov 2025 08:23:51 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: thunderbolt: Allow reading link
 settings
Message-ID: <20251128072351.GB2580184@black.igk.intel.com>
References: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
 <20251127131521.2580237-4-mika.westerberg@linux.intel.com>
 <3ac72bf4-aa0e-4e3f-b6ef-4ed2dce923e1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ac72bf4-aa0e-4e3f-b6ef-4ed2dce923e1@lunn.ch>

On Thu, Nov 27, 2025 at 08:20:53PM +0100, Andrew Lunn wrote:
> > +static int tbnet_get_link_ksettings(struct net_device *dev,
> > +				    struct ethtool_link_ksettings *cmd)
> > +{
> > +	const struct tbnet *net = netdev_priv(dev);
> > +	const struct tb_xdomain *xd = net->xd;
> > +	int speed;
> > +
> > +	ethtool_link_ksettings_zero_link_mode(cmd, supported);
> > +	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> > +
> > +	/* Figure out the current link speed and width */
> > +	switch (xd->link_speed) {
> > +	case 40:
> > +		/* For Gen 4 80G symmetric link the closest one
> > +		 * available is 56G so we report that.
> > +		 */
> > +		ethtool_link_ksettings_add_link_mode(cmd, supported,
> > +						     56000baseKR4_Full);
> > +		ethtool_link_ksettings_add_link_mode(cmd, advertising,
> > +						     56000baseKR4_Full);
> > +		speed = SPEED_56000;
> 
> Please add SPEED_80000.

Sure. One additional question though. Comment on top of SPEED_ definitions
suggest changing __get_link_speed() of the bonding driver accordingly but
it basically converts from SPEED_ to AD_LINK_SPEED_ which I think we need
to add too. However, these are user-facing values so should I add the
AD_LINK_SPEED_80000 entry to the end of that enum to avoid any possible
breakage?

> I commented on the previous version. Is supported and advertising
> actually needed? If not, please leave them blank.

I don't think they are needed (but I'll double check).

