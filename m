Return-Path: <netdev+bounces-43146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FF7D1933
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E09CB215B8
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262035506;
	Fri, 20 Oct 2023 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8BcevqW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5035502;
	Fri, 20 Oct 2023 22:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D194C433C8;
	Fri, 20 Oct 2023 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697841198;
	bh=iAM2xrf3gpA6507Ws2KOBubhjHDpEVAP1baBI4pCtOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l8BcevqWgmrirS8+FYutiZO291vr6KqZWwRWayNTYntJOWXZHGehWDx//2eIWMhvy
	 /Lr8uRTICWOEZVTPIDLBn1ONr8W0TMb5HOgS4PXlKMHIkWpf5RpGcp2VdxM0nRDg5E
	 kve8FLjLadYlesJdISFbBTR+NxHBDav9SwkFvNYxaY8OLtN0wh1R7R6LzKBTFED3j0
	 oY1Aktg9Wtwl9RvC7nXv3tQ4tsP5FLLJQ+CQv7Yzhtqhg6CVBu9tAejW9x8CVS9s53
	 067HUMNlnyzKzBAUXCDQ1+55nGvy7CZT6sA2vxZibfe0P/snViT6aJKemefmp+/D9B
	 XsHqPTblc7ylw==
Date: Fri, 20 Oct 2023 15:33:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <willemdebruijn.kernel@gmail.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <corbet@lwn.net>,
 <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <vladimir.oltean@nxp.com>, <andrew@lunn.ch>, <horms@kernel.org>,
 <mkubecek@suse.cz>, <linux-doc@vger.kernel.org>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
Message-ID: <20231020153316.1c152c80@kernel.org>
In-Reply-To: <45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
	<20231016163059.23799429@kernel.org>
	<CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
	<20231017131727.78e96449@kernel.org>
	<CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
	<20231017173448.3f1c35aa@kernel.org>
	<CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
	<20231018165020.55cc4a79@kernel.org>
	<45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 15:24:41 -0600 Ahmed Zaki wrote:
> > IMO fat warning in the documentation and ethtool man saying that this
> > makes the algo (any / all) vulnerable to attack would be enough.
> > Willem?  
> 
> Please advise on the next step. Should I send a new version with the Doc 
> warning, or will you use v5?

Not just the doc changes:

| We can use one of the reserved fields of struct ethtool_rxfh to carry
| this extension. I think I asked for this at some point, but there's
| only so much repeated feedback one can send in a day :(

https://lore.kernel.org/all/20231016163059.23799429@kernel.org/

You can take care of that, post v6 and see what Alex and Willem say.

