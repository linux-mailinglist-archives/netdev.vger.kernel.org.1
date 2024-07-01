Return-Path: <netdev+bounces-108005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EB91D8B4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD5D1F21761
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F5482D8;
	Mon,  1 Jul 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhaqeEKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B818F62
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818113; cv=none; b=qQC9QufX5VCnrF1nZDAPjxUCwkfdCmRCloeIQy6QhbLkAzGIUvBNlQBoNrEo+qSGh8GQ6qGS5Xs9jSiflYUmX6HBb4X0N5OFyIIUpA6d7v1Lvv3Z5yS/8V84df6w+ZyQdxdpoto9Q7w294c9jEOhtsG3CasCEVqDy4zpmR/yo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818113; c=relaxed/simple;
	bh=nkdyaCnnE2lxXci6pm9KjxbTWn7tU+ZcXRARm8bOYW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8tA23QJNkszgHJbnL4niZhETnqVM6aqR4yFzOK5WLbvCklYxw0RV4A001sFUKxfiSnz42WAY3Ryo3FM/r8mZYgWRp+17Ezs2dJCa9gaDYDruEeLueXDeBuHLxBpEqGf3gMMozf5CbJhwDfHMUunez5wLAK12Eox04kwi82wS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhaqeEKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF12C116B1;
	Mon,  1 Jul 2024 07:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719818112;
	bh=nkdyaCnnE2lxXci6pm9KjxbTWn7tU+ZcXRARm8bOYW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhaqeEKqq98NgKUAseyC8r5cT5SaAHirG2AnMafzn9m3y5vUpmYva/erfeptRLkvj
	 v+ES4xXCF/N8KYTgjCI2O9qEWVd8DlnvZ0kSZUKlk1T09E/mfvn916mBwzI3mxdTU6
	 2ks1Ha8WxNTwNavwwxF+6gvvrcQkKPgbNxvOK4APXkVID4Qg0zUFOI3JOWv/eIWOuN
	 pe8Wea+DAhpjus0vT2X01hc9GAaLflnh7owm19ltFLw45EKlJRnzqOkMhEkHw5jsPu
	 BkKX3ZUnU+m3R7nmX4X+UvzsBzUTkdKHeAi6B/O8bOuLWmV6ARtRaAOEO2fUmVQ4fB
	 Lp+0/xHqhpn5w==
Date: Mon, 1 Jul 2024 08:15:08 +0100
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"shenjian (K)" <shenjian15@huawei.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igc: Add MQPRIO offload support
Message-ID: <20240701071508.GD17134@kernel.org>
References: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>

On Fri, Jun 21, 2024 at 09:25:55AM +0200, Kurt Kanzenbach wrote:
> Add support for offloading MQPRIO. The hardware has four priorities as well
> as four queues. Each queue must be a assigned with a unique priority.
> 
> However, the priorities are only considered in TSN Tx mode. There are two
> TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
> Therefore, use the legacy TSN Tx mode, which performs strict priority
> arbitration.
> 
> Example for mqprio with hardware offload:
> 
> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
> |   queues 1@0 1@1 1@2 1@3 \
> |   hw 1
> 
> The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
> frame preemption is not supported yet.
> 
> Tested on Intel i225 and implemented by following data sheet section 7.5.2,
> Transmit Scheduling.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


