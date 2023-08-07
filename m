Return-Path: <netdev+bounces-24999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16C772816
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092AA28140D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CEDDD0;
	Mon,  7 Aug 2023 14:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC4C2E3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F004CC433C8;
	Mon,  7 Aug 2023 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691419470;
	bh=1iK6HhqiiyiDhvbrqw13iO8JYdVtQdt6tXR+KXCDicA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQrzzpa19/zu6yFs2WNURe7i7TQQ5UcnkfdvTS8zWuEDTbzN4HDYs/jkg4ICBYfZd
	 oFKkkw2EuqwGmGp8s6pTS0d/eQ5ukatdHxVFtYTJVVSv9HU4+JWpj1Ts0kWaoypmM4
	 t81tRd0dBmMCshuohHimOEPvgl4IRU+QiOyWqcvRjO+lN1DQtug42YArVhvThnVrp3
	 XiWFLWWJM7PYCkHPwGUjgzG5RzhyPJLAUR6z6gVFU7fXq/BwsJY/tkDizZ3nejNtu2
	 W0xM18etmyOMDQoDtH9FeAbHnfSPQf8XuLgmdsSowHZFBbEf0VuyT5NMWnTBA4ovGj
	 +5aI/S542h/GQ==
Date: Mon, 7 Aug 2023 16:44:25 +0200
From: Simon Horman <horms@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Simon Horman <horms@kernel.org>, edward.cree@amd.com,
	linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH net-next 7/7] sfc: offload left-hand side rules for
 conntrack
Message-ID: <ZNEDSVHLPzoq8Zcj@vergenet.net>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
 <9794c4fd9a32138fb5b30c7b4944f4b09e026ac2.1691063676.git.ecree.xilinx@gmail.com>
 <ZM0Ac2MZxamaS0bG@kernel.org>
 <a6510880-1617-84e7-f5f2-e417feb65285@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6510880-1617-84e7-f5f2-e417feb65285@gmail.com>

On Mon, Aug 07, 2023 at 02:12:24PM +0100, Edward Cree wrote:
> On 04/08/2023 14:43, Simon Horman wrote:
> > On Thu, Aug 03, 2023 at 12:56:23PM +0100, edward.cree@amd.com wrote:
> > 
> > ...
> > 
> >> +static bool efx_tc_rule_is_lhs_rule(struct flow_rule *fr,
> >> +				    struct efx_tc_match *match)
> >> +{
> >> +	const struct flow_action_entry *fa;
> >> +	int i;
> >> +
> >> +	flow_action_for_each(i, fa, &fr->action) {
> >> +		switch (fa->id) {
> >> +		case FLOW_ACTION_GOTO:
> >> +			return true;
> >> +		case FLOW_ACTION_CT:
> >> +			/* If rule is -trk, or doesn't mention trk at all, then
> >> +			 * a CT action implies a conntrack lookup (hence it's an
> >> +			 * LHS rule).  If rule is +trk, then a CT action could
> >> +			 * just be ct(nat) or even ct(commit) (though the latter
> >> +			 * can't be offloaded).
> >> +			 */
> >> +			if (!match->mask.ct_state_trk || !match->value.ct_state_trk)
> >> +				return true;
> > 
> > Hi Ed,
> > 
> > I think that to keep static analysers happy there ought to be a
> > break statement, or a fallthrough annotation here.
> 
> Yeah, I see on patchwork that clang complained about this.
> Since the fallthrough is only into a break statement (which is
>  presumably why gcc doesn't mind), I'll just add a break here.
> 
> > Otherwise the series looks good to me.
> 
> Thanks, will respin v2 shortly with your tag included.

Sounds good, thanks.

