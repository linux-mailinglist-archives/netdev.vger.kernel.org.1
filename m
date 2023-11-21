Return-Path: <netdev+bounces-49716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FC7F32D7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E65281229
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0056764;
	Tue, 21 Nov 2023 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5/NHoEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124D46439
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 15:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A4C433C9;
	Tue, 21 Nov 2023 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700582117;
	bh=WXTh9KkihGvv02JqYKRZ1ui0JyrCN72YLog0gJ1noz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5/NHoEiLsn0t2mf51cbLXNrcJmuefxFzAW3+DI2UFV7qU6M6LLlOQeZDpqM7jeOk
	 nisp1AJaakUo8egWB/JDrcsZnP1hwCh2CZWsVou8rlPkCif6mnXxECkpa32tShr7iO
	 7HzSpbN4yfmQiAKLtf9DEgVFj/OIQo4Kvx7VwmetA+5GKxjrN1TpCAOSeXg5o9DBU+
	 TDbYCyUPmrbCK4XT+ewK0mwaAukG9zVslk4UtrnsKB4eWBxO+QkJU9dqcgL2224Ob7
	 wIaBWFxV5Ux455tWtbbbW3hpMA0dbS6+VA2s+xNR/Ujq5hEeYO3nM9d1RX4/PzaQff
	 gFmw54MWUUOiw==
Date: Tue, 21 Nov 2023 15:55:11 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [net PATCH] octeontx2-pf: Fix ntuple rule creation to
 direct packet to VF with higher Rx queue than its PF
Message-ID: <20231121155511.GC269041@kernel.org>
References: <20231120055138.3602102-1-sumang@marvell.com>
 <745e6518-6253-4ef0-8f05-1421ee4e1fef@intel.com>
 <SJ0PR18MB52164E2721E056366EC30139DBBBA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB52164E2721E056366EC30139DBBBA@SJ0PR18MB5216.namprd18.prod.outlook.com>

On Tue, Nov 21, 2023 at 09:54:00AM +0000, Suman Ghosh wrote:
> >> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> >> ---
> >>  .../marvell/octeontx2/nic/otx2_flows.c        | 21
> >+++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> >> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> >> index 4762dbea64a1..4200f2d387f6 100644
> >> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> >> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> >> @@ -1088,6 +1088,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct
> >ethtool_rxnfc *nfc)
> >>  	struct ethhdr *eth_hdr;
> >>  	bool new = false;
> >>  	int err = 0;
> >> +	u64 vf_num;
> >>  	u32 ring;
> >>
> >>  	if (!flow_cfg->max_flows) {
> >> @@ -1100,9 +1101,26 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct
> >ethtool_rxnfc *nfc)
> >>  	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
> >>  		return -ENOMEM;
> >>
> >> +	/* Number of queues on a VF can be greater or less than
> >> +	 * the PF's queue. Hence no need to check for the
> >> +	 * queue count. Hence no need to check queue count if PF
> >> +	 * is installing for its VF. Below is the expected vf_num value
> >> +	 * based on the ethtool commands.
> >> +	 *
> >> +	 * e.g.
> >> +	 * 1. ethtool -U <netdev> ... action -1  ==> vf_num:255
> >> +	 * 2. ethtool -U <netdev> ... action <queue_num>  ==> vf_num:0
> >> +	 * 3. ethtool -U <netdev> ... vf <vf_idx> queue <queue_num>  ==>
> >> +	 *    vf_num:vf_idx+1
> >> +	 */
> >> +	vf_num = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
> >> +	if (!is_otx2_vf(pfvf->pcifunc) && vf_num)
> >> +		goto bypass_queue_check;
> >
> >Let's just add this condition to the next if, no need for goto.
> [Suman] I kept it a separate check to make the code more readable. Otherwise the next if condition will be complicated.

Readability is subjective, but, FWIIW, I'd also prefer
to avoid a goto here.

> >> +
> >>  	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie !=
> >RX_CLS_FLOW_DISC)
> >>  		return -EINVAL;
> >>
> >> +bypass_queue_check:
> >>  	if (fsp->location >= otx2_get_maxflows(flow_cfg))
> >>  		return -EINVAL;
> >>
> >> @@ -1182,6 +1200,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct
> >ethtool_rxnfc *nfc)
> >>  		flow_cfg->nr_flows++;
> >>  	}
> >>
> >> +	if (flow->is_vf)
> >> +		netdev_info(pfvf->netdev,
> >> +			    "Make sure that VF's queue number is within its queue
> >> +limit\n");
> >>  	return 0;
> >>  }
> >>

