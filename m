Return-Path: <netdev+bounces-127617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B939B975E00
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E35285843
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872D815C3;
	Thu, 12 Sep 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3O8BjYw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA73370;
	Thu, 12 Sep 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726101112; cv=none; b=KcO1GocNMturvoh/5nrS2Ul2S92wqnGJ5dYtX1wEkIuThc+y5OKXIY+8xHxzx9+5qxLAPR8rW63RodhCg8nZ70oSnXWHY6AGNI32PNE8ksYI6+83iYvCBlxOW77/yuxI0N2xHDYws2FWqf5I/F2JnSuZx+1H461C8TAwb/TDTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726101112; c=relaxed/simple;
	bh=6dia94czC1Fp4ofQjnt32+c1X4fP5tmFPVdV8/koypk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5fXkS5GKBugWW5UoJ1e0kYvtJbRDSXybXtP80FEFT4RrSK/ExZpqaZrDGzRfCdnjV87J6b5BvvXYFpHHUYaIMRIbimvkGoK0lDMUX+IKuB8m9KQsVUDaXUhs8VnfUxUdnlwk2mb5MIQGTB1w4SA01jAhihzyhMhleJUBzzcfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3O8BjYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED8BC4CEC0;
	Thu, 12 Sep 2024 00:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726101111;
	bh=6dia94czC1Fp4ofQjnt32+c1X4fP5tmFPVdV8/koypk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3O8BjYw+TluWxdftotstM9aiPiqrnwTapH06/EKh60jkLP9EIggzX6T3q3zxtC/k
	 J8jGwD08v2Fh+O/hOjXzrIFajm/mLGtv6KD4Xk6r3inKt3P9lQW+cnhM0kyXkkLr9O
	 zW2e2DxDJdSe/tF27pI+vNljFCwVZ8hB+q/M2iR2flOS1q7n+DnA/lSdwzvbv8Rv4l
	 oHa6BMqCwfdyuv9sZzG77TRx0kpYRLCSJui3qoEoV9q+cdE8Fzef6G7PRG82+1RWvB
	 8dF33LYd0+r4epnEvv3ecv/2MY3+1F7SwhQ0ni93yjq70kKyuQU+icUMYoaNapHvw9
	 TEipsGNo8AzKQ==
Date: Wed, 11 Sep 2024 17:31:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Taehee Yoo <ap420073@gmail.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <corbet@lwn.net>,
 <michael.chan@broadcom.com>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <ecree.xilinx@gmail.com>,
 <przemyslaw.kitszel@intel.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
 <kory.maincent@bootlin.com>, <ahmed.zaki@intel.com>,
 <paul.greenwalt@intel.com>, <rrameshbabu@nvidia.com>, <idosch@nvidia.com>,
 <maxime.chevallier@bootlin.com>, <danieller@nvidia.com>,
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring
 tcp-data-split-thresh
Message-ID: <20240911173150.571bf93b@kernel.org>
In-Reply-To: <c970e22e-9fcc-499a-8c83-32b41439cbb9@intel.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
	<20240911145555.318605-4-ap420073@gmail.com>
	<c970e22e-9fcc-499a-8c83-32b41439cbb9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 11:51:42 -0500 Samudrala, Sridhar wrote:
> On 9/11/2024 9:55 AM, Taehee Yoo wrote:
> > The tcp-data-split-thresh option configures the threshold value of
> > the tcp-data-split.
> > If a received packet size is larger than this threshold value, a packet
> > will be split into header and payload.
> > The header indicates TCP header, but it depends on driver spec.
> > The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> > FW level, affecting TCP and UDP too.
> > So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> > it affects UDP and TCP packets.  
> 
> What about non-tcp/udp packets? Are they are not split?
> It is possible that they may be split at L3 payload for IP/IPV6 packets 
> and L2 payload for non-ip packets.
> So instead of calling this option as tcp-data-split-thresh, can we call 
> it header-data-split-thresh?

This makes sense.

> > The tcp-data-split-thresh has a dependency, that is tcp-data-split
> > option. This threshold value can be get/set only when tcp-data-split
> > option is enabled.  
> 
> Even the existing 'tcp-data-split' name is misleading. Not sure if it 
> will be possible to change this now.

It's not misleading, unless you think that it is something else than 
it is. 

  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device
  is usable with page-flipping TCP zero-copy receive
  (``getsockopt(TCP_ZEROCOPY_RECEIVE)``). If enabled the device is
  configured to place frame headers and data into separate buffers. 
  The device configuration must make it possible to receive full memory
  pages of data, for example because MTU is high enough or through
  HW-GRO.

If you use this for more than what's stated in the documentation
that's on you. More granular "what gets split and what doesn't"
control should probably go into an API akin to how we configure
RSS hashing fields. But I'm not sure anyone actually cares about
other protocols at this stage, so...

