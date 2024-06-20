Return-Path: <netdev+bounces-105244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E69103CB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48B41C20EED
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701F1A8C02;
	Thu, 20 Jun 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvLzlxYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FC17624F;
	Thu, 20 Jun 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885591; cv=none; b=BlYxE+9Ql92DNP3pBPiuRdq2NT44tXm4U4VopekR5UCeAvm6xEbYBy9d0llJddZNIOfShDBsL/cXE3dbsmcXwqU4/e/GAaS/nEk0kC3nrqy3V6KmScrf+hDU+lkDTB4pMfxbjBnxkTbyRSAmnkpz9/jYzJ7tCgfmcysSN3LNdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885591; c=relaxed/simple;
	bh=fcjqc2DlsenpKHk3vUiUYkCTpF3AXEaIKopNgB+UK+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYinqmSRwt5t2o23x8VdkUgWIJsTZ/ALgt78KlkbF/PqF4StXTfd55pK9tPaixCRRJNbc3YpgGWKZE7iDw5QX1bw9tTW2oJQGspFvqJhrRnPiqvBUrbm9rERtx2tMW6MqemI8EZim1Tuf/51dLu/M43uxBJ0x8DkhhEPShp0Sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvLzlxYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CECC2BD10;
	Thu, 20 Jun 2024 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718885591;
	bh=fcjqc2DlsenpKHk3vUiUYkCTpF3AXEaIKopNgB+UK+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvLzlxYgut6YlyqrUnKm+yQTRKukhnjxAuofzafIvIMyAwI6Q4qvo1GR/opIeawKz
	 VkC9Gd69UGkrlBTY9rQArAeh//g1LJmErx7NtApRViP1ecQQP7tNnwZyZ5JOsfcOmL
	 +qk664PJkXwjszehoodp1FyB/h0DMH6nSbivpqv5zUgzEzouPlXWX2WRdYZV7GmKyf
	 kwQzOg9sH9JyFpP21Ds7P6VqhT9qVQ2suSyjgmYbA/xW5Ws99o/ReAZldZDKiYayX7
	 HV2ZDa6DgclFer43yASLl6M5dCdzd0hbHFjQIrcvjC9ZWsVB1M+hS5iCZvORsLiTpG
	 CVzmxOgWTTXwQ==
Date: Thu, 20 Jun 2024 13:13:02 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
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
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	donald.hunter@gmail.com,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: Re: [PATCH RESEND net-next v14 3/5] ethtool: provide customized dim
 profile management
Message-ID: <20240620121302.GC959333@kernel.org>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-4-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618025644.25754-4-hengqi@linux.alibaba.com>

On Tue, Jun 18, 2024 at 10:56:42AM +0800, Heng Qi wrote:
> The NetDIM library, currently leveraged by an array of NICs, delivers
> excellent acceleration benefits. Nevertheless, NICs vary significantly
> in their dim profile list prerequisites.
> 
> Specifically, virtio-net backends may present diverse sw or hw device
> implementation, making a one-size-fits-all parameter list impractical.
> On Alibaba Cloud, the virtio DPU's performance under the default DIM
> profile falls short of expectations, partly due to a mismatch in
> parameter configuration.
> 
> I also noticed that ice/idpf/ena and other NICs have customized
> profilelist or placed some restrictions on dim capabilities.
> 
> Motivated by this, I tried adding new params for "ethtool -C" that provides
> a per-device control to modify and access a device's interrupt parameters.
> 
> Usage
> ========
> The target NIC is named ethx.
> 
> Assume that ethx only declares support for rx profile setting
> (with DIM_PROFILE_RX flag set in profile_flags) and supports modification
> of usec and pkt fields.
> 
> 1. Query the currently customized list of the device
> 
> $ ethtool -c ethx
> ...
> rx-profile:
> {.usec =   1, .pkts = 256, .comps = n/a,},
> {.usec =   8, .pkts = 256, .comps = n/a,},
> {.usec =  64, .pkts = 256, .comps = n/a,},
> {.usec = 128, .pkts = 256, .comps = n/a,},
> {.usec = 256, .pkts = 256, .comps = n/a,}
> tx-profile:   n/a
> 
> 2. Tune
> $ ethtool -C ethx rx-profile 1,1,n_2,n,n_3,3,n_4,4,n_n,5,n
> "n" means do not modify this field.
> $ ethtool -c ethx
> ...
> rx-profile:
> {.usec =   1, .pkts =   1, .comps = n/a,},
> {.usec =   2, .pkts = 256, .comps = n/a,},
> {.usec =   3, .pkts =   3, .comps = n/a,},
> {.usec =   4, .pkts =   4, .comps = n/a,},
> {.usec = 256, .pkts =   5, .comps = n/a,}
> tx-profile:   n/a
> 
> 3. Hint
> If the device does not support some type of customized dim profiles,
> the corresponding "n/a" will display.
> 
> If the "n/a" field is being modified, -EOPNOTSUPP will be reported.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


