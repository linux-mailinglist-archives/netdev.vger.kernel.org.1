Return-Path: <netdev+bounces-180893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA7A82D60
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26093B2134
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38307270EDF;
	Wed,  9 Apr 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7+aRtmy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C5270EDD
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218745; cv=none; b=KQbOn+iZG0VP983zRl2QUN/6X/NxvT1KYl6JVNvdh9VHjB2yGlwKsXrnjf0GUT1Iaip69dVE2MzLwn0HaktYS214B1M3944HpmMUCJnZDsyZyqLaxbF7vXNviiVQSobI4NbJkakjZfuIMZFlLX1xGOd7v9om/E1lYERNEacmMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218745; c=relaxed/simple;
	bh=JIZFCjcTXRdnW6c6x5d8dJNp8rrFEgq4XX8fK7te02w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfMg7KmhXz09cbPZOx98jgzFRrs7cqor56nFW+wbHor8CFuZZRemToqrpvbW8NYBlU5L/wpQWw/CYQf8SWOLOWwImCDhlorndSvvBjSniO1lOLYDZpVg/EtMP5fWkvXN9+uu+S8ND2e0f0AiAQAN4Xla9M00QS6dOXbhwVvbn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7+aRtmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26810C4CEE8;
	Wed,  9 Apr 2025 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744218744;
	bh=JIZFCjcTXRdnW6c6x5d8dJNp8rrFEgq4XX8fK7te02w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7+aRtmyOE2VQQk0xZhoUORYDK+6GU8sRnNbKqbeTnWMd4EYZhlKK1lYd06UMD0Ym
	 BjxS02lO6IE8Oac+FzF72keKwK0OFTG8XG3K/2M1hIw8QrBLxo1YfgR/uMTQgFcJ9G
	 n53zPZiol1fkdF24YznvJqhZnR6dvYebIb0rviBzo5V0UQzex90XJo+U5m+S+PsYUx
	 lUN3z3/XLficvL0WxA18EgOg1/2Rp5h+oBsDQ7rgxDT/qC0+HEL5yp6rg8X+Eo0TJ7
	 AmHjnUnyXFFHLP3Aipcg4BniesanVqb6iyv5r/G2lSbc/FSQ/bwJD5v8xRwgACc9oR
	 BXvz9m120TuCQ==
Date: Wed, 9 Apr 2025 18:12:19 +0100
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 1/2] igc: Limit netdev_tc calls to MQPRIO
Message-ID: <20250409171219.GQ395307@horms.kernel.org>
References: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
 <20250321-igc_mqprio_tx_mode-v4-1-4571abb6714e@linutronix.de>
 <20250407124741.GJ395307@horms.kernel.org>
 <87mscqsvui.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mscqsvui.fsf@jax.kurt.home>

On Tue, Apr 08, 2025 at 02:04:21PM +0200, Kurt Kanzenbach wrote:
> On Mon Apr 07 2025, Simon Horman wrote:
> > On Fri, Mar 21, 2025 at 02:52:38PM +0100, Kurt Kanzenbach wrote:
> >> Limit netdev_tc calls to MQPRIO. Currently these calls are made in
> >> igc_tsn_enable_offload() and igc_tsn_disable_offload() which are used by
> >> TAPRIO and ETF as well. However, these are only required for MQPRIO.
> >> 
> >> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> >
> > Hi Kurt,
> >
> > Thanks for the update. And I apologise that I now have question.
> >
> > I see that:
> >
> > * This patch moves logic from igc_tsn_disable_offload()
> >   and igc_tsn_enable_offload() to igc_tsn_enable_mqprio().
> >
> > * That both igc_tsn_disable_offload() and igc_tsn_enable_offload()
> >   are only called from igc_tsn_reset().
> >
> > * And that based on the description, this looks good for the case
> >   where igc_tsn_reset() is called from igc_tsn_offload_apply().
> >   This is because igc_tsn_offload_apply() is called from
> >   igc_tsn_enable_mqprio().
> >
> > All good so far.
> >
> > But my question is about the case where igc_tsn_reset() is called from
> > igc_reset(). Does the logic previously present in igc_tsn_enable_offload()
> > and igc_tsn_disable_offload() need to run in that case?
> 
> This patch moves the netdev_tc calls only. These do not have to run in
> this case. The hardware configuration is still applied in
> igc_tsn_enable_offload() and igc_tsn_disable_offload().

Thanks for clarifying, in that case this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>



