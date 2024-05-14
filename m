Return-Path: <netdev+bounces-96399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7438C59D4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB54B20A01
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609351C42;
	Tue, 14 May 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TeaGyAij"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E71E4A0;
	Tue, 14 May 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704618; cv=none; b=A3hdNVNN/TJMZbexS8Jsr/248kvDEVSb2Vl436+y+vlRmvRsWSoC07Hd1/VjRP7z/dgv/gNYsZs6E7UYBsCt7ZXDWoSl85AJw3hXk2zjRxO48xIua6aVyXr5YJFgEVFfce2GNt+V/8B3QTjRIyr9BJ2Oyi3IxjYxfXztQi7IAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704618; c=relaxed/simple;
	bh=nqcFAEXxwiPw3in3vd/H7/+fYyvOU8CLAGLOLtfVL9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/glMmzYLDwXtCjyN9YGcWtEtY5IdVjToZFl1QALQ553wMA1Ksl+xQO3NaqLqdqp8Br+MnpDZlqomTGIq9WO10NVtMGBhn9z3BE5V1y5e6QUFBWsB7z5rO6+FwXBio9asGJ91R7hssuiN5BXJEy1CcOLfsX/sVl66NtTYhtP6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TeaGyAij; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YcukAh0HocjCtBqiwt2lxfdiQZRo1TjafRxTMWwqbQ8=; b=TeaGyAijbpaaSRoUjduMd0DyiP
	hElXRqvwXTs8NCYUjPp3uFgpEw7yqxTHiFCzDnbp9ax1AwkRt2gJ0SdUhzrYt9zOhngNPnPvSdJ48
	AWLT42F74JmUCQM2FtLRWccuSc+dbxXF1W7e8Ed/Z3BNG9FV2moA+oi0zTFQSQ0+xbHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6v8a-00FOvA-TE; Tue, 14 May 2024 18:36:24 +0200
Date: Tue, 14 May 2024 18:36:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>, justinstitt@google.com,
	donald.hunter@gmail.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim profile
 management
Message-ID: <87bbcd23-e837-477f-99b6-affe8199ce16@lunn.ch>
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
 <20240509044747.101237-3-hengqi@linux.alibaba.com>
 <202405100654.5PbLQXnL-lkp@intel.com>
 <1715531818.6973832-3-hengqi@linux.alibaba.com>
 <20240513072249.7b0513b0@kernel.org>
 <1715611933.2264705-1-hengqi@linux.alibaba.com>
 <20240513082412.2a27f965@kernel.org>
 <1715614744.0497134-3-hengqi@linux.alibaba.com>
 <20240513114233.6eb8799e@kernel.org>
 <1715652495.6335685-4-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715652495.6335685-4-hengqi@linux.alibaba.com>

> One more friendly request, I see net-next is closed today, but our downstream
> kernel release deadline is 5.20, so I want to test and release the new v14 today,
> is it ok?

5.20? Didn't Linus run out of fingers and thumbs and went from 5.19 to
6.0?

Anyway, this is your internal issue, since netdev only accepts new
features patches for the next kernel release, not stable kernels. If
you are forced to do upstream first, you are going to have to wait
until the next cycle starts, and net-next reopens.

      Andrew

