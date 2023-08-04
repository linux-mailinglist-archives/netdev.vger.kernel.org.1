Return-Path: <netdev+bounces-24416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA00770212
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA361C21856
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13CC140;
	Fri,  4 Aug 2023 13:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44911BE6D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD59BC433C8;
	Fri,  4 Aug 2023 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691156599;
	bh=WF+BCfLicDbntAVz2V7em89LVOAKPuE4WtSKVjLWPp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGF1+v9PCUe2Zzfi+iVuN1cX2feHXgyJ1qHJN5JH0kxk4xloDRIIiPhL3I/33RZc0
	 UbRE/dLNiBEnHb7VSEQImvncNKc2yhnzShlhm+VYzqdVesIWihmhmQ9W6vE47Z4J63
	 ig0gwN/eMOPWpCR500PJlwaGGktLYQ2Q9UmCNdB+rj24awqcn2jdpiLStEj9evFTL0
	 ssJ+xydvZDktiRc+tCc20AmsMPwjWLgvcjAqu2D7tLTvHOtC6xVwE8bG+VldF5a9wX
	 wtmnH79sJxVNOg/qtDyQhUQ6sFKBsF4DpMKDGOICbaPXA+xPpoOOG3jGEKP0ToUuJJ
	 0FdWjQAJa5NIQ==
Date: Fri, 4 Aug 2023 15:43:15 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH net-next 7/7] sfc: offload left-hand side rules for
 conntrack
Message-ID: <ZM0Ac2MZxamaS0bG@kernel.org>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
 <9794c4fd9a32138fb5b30c7b4944f4b09e026ac2.1691063676.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9794c4fd9a32138fb5b30c7b4944f4b09e026ac2.1691063676.git.ecree.xilinx@gmail.com>

On Thu, Aug 03, 2023 at 12:56:23PM +0100, edward.cree@amd.com wrote:

...

> +static bool efx_tc_rule_is_lhs_rule(struct flow_rule *fr,
> +				    struct efx_tc_match *match)
> +{
> +	const struct flow_action_entry *fa;
> +	int i;
> +
> +	flow_action_for_each(i, fa, &fr->action) {
> +		switch (fa->id) {
> +		case FLOW_ACTION_GOTO:
> +			return true;
> +		case FLOW_ACTION_CT:
> +			/* If rule is -trk, or doesn't mention trk at all, then
> +			 * a CT action implies a conntrack lookup (hence it's an
> +			 * LHS rule).  If rule is +trk, then a CT action could
> +			 * just be ct(nat) or even ct(commit) (though the latter
> +			 * can't be offloaded).
> +			 */
> +			if (!match->mask.ct_state_trk || !match->value.ct_state_trk)
> +				return true;

Hi Ed,

I think that to keep static analysers happy there ought to be a
break statement, or a fallthrough annotation here.

Otherwise the series looks good to me.

> +		default:
> +			break;
> +		}
> +	}
> +	return false;
> +}

...

