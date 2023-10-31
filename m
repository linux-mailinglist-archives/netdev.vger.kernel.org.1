Return-Path: <netdev+bounces-45443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861297DD062
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420A2281298
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035461E514;
	Tue, 31 Oct 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv1wKYy8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42051E502;
	Tue, 31 Oct 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C6C433CA;
	Tue, 31 Oct 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698765625;
	bh=+pUsleWzGMzecEeUZif7UWECC6Mweiv0OQf1A394Bkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hv1wKYy8+OLbQMgqnshEK/330tGcnyimFW7fLtgJoOlKTlpSMbSPtkyluGUhUgIJU
	 QK1lqkPvF1cDZwwmBaTj23GXuQpCjTTEfjUkHgVFDpeJiIAdk7ClovoD9ZxGT2we+t
	 VdytgADwcsNRUK/Qjuy2zJ9ugwHUrDGKrYjFRFaOMbkhbXOakCnyU7vM2y6tB/k2G9
	 kE69nuGxdA/PS/VGx8Eh2mnwAGzQIfAfimNSgeaPvztPu0DpS1uWnu+V9d96pLC/e0
	 ByP8lErAY/VNo3yfVM88/ZLelTfyZ6KfyAd2RwD4V3zNet+LBUiAis6hGaQKW8WfYd
	 EtNtZDJG+Ifow==
Date: Tue, 31 Oct 2023 08:20:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, "Alexander H Duyck"
 <alexander.duyck@gmail.com>, <mkubecek@suse.cz>, <andrew@lunn.ch>,
 <willemdebruijn.kernel@gmail.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jesse.brandeburg@intel.com>,
 <edumazet@google.com>, <anthony.l.nguyen@intel.com>, <horms@kernel.org>,
 <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
Message-ID: <20231031082023.3fd4761b@kernel.org>
In-Reply-To: <e7679b57-af11-42b1-91c7-b18cbcc70119@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231017131727.78e96449@kernel.org>
	<CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
	<20231017173448.3f1c35aa@kernel.org>
	<CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
	<20231018165020.55cc4a79@kernel.org>
	<45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
	<20231020153316.1c152c80@kernel.org>
	<c2c0dbe8-eee5-4e87-a115-7424ba06d21b@intel.com>
	<20231020164917.69d5cd44@kernel.org>
	<f6ab0dc1-b5d5-4fff-9ee2-69d21388d4ca@intel.com>
	<89e63967-46c4-49fe-87bc-331c7c2f6aab@nvidia.com>
	<e644840d-7f3d-4e3c-9e0f-6d958ec865e0@intel.com>
	<e471519b-b253-4121-9eec-f7f05948c258@nvidia.com>
	<a2a1164f-1492-43d1-9667-5917d0ececcb@intel.com>
	<d097e7d3-5e16-44ba-aa92-dfb7fbedc600@nvidia.com>
	<aa1dd347-a16c-44f8-95ad-5d50bcba8f34@intel.com>
	<70132b6f-542f-4fe6-971f-ab9ea80acbe4@nvidia.com>
	<e7679b57-af11-42b1-91c7-b18cbcc70119@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Oct 2023 09:14:58 -0600 Ahmed Zaki wrote:
> Do you mean add vendor-specific implementation details to common docs? 
> Not sure if I have seen this before. Any examples?
> 
> Or, we can add a note in ethtool doc that each vendor's implementation 
> is different and "Refer to your vendor's specifications for more info".

Gal, can you shed any more detail on who your implementation differs?
It will help the discussion, and also - I'm not sure how you can do
xor differently..

