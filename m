Return-Path: <netdev+bounces-179625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB0A7DE17
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B441799B1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583FB2505A8;
	Mon,  7 Apr 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPlW1FxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32417236A7C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030066; cv=none; b=ArA/wFmLY8u70Rc7uhp7Ley5ZQwUUN9GPdAVbu+f4BKJ3mC3jfD7GAsX6j5+Fciq7hvvb6rR6EXqT0WBwHHiOlpkEEWGeWy4a7X7MEkHJUenLuta2Tf+6vasTkuxjP4U2pnJH3pDQQaor/UVqNj1L6cuz4VkEtKV0L1NfhbbxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030066; c=relaxed/simple;
	bh=IaB8foPsgHa6VHTC6ye/QBFhLDTe7BVG+PauPaynAM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI32Cb5gUPLasCk774KtlCAkdKyntNuXRFYsEqLEhvF8dedO1D2Urqu0Yc+uC1oOFdmy5ItM5SPxBMSpBmqlTpL7sxF+11KiZmN0K7KEVnrP7pSInulOGYjM63x1gSPs0TjSatSsR4JWFRv9jYU3yWwY6yUXb2o/fMq45KvGhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPlW1FxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B116C4CEDD;
	Mon,  7 Apr 2025 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744030065;
	bh=IaB8foPsgHa6VHTC6ye/QBFhLDTe7BVG+PauPaynAM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPlW1FxOtPxLrYXc/E+Hd7eE9R4F7FlzvjlfXg0KlgJlq2KBXepi0oPo2kRm4LJEh
	 M3jhM5oBaQm4a5TzPxXiFOm1sp3KVXljAclJVxjPC5ZnYcnP4ShWSBgJ9n86bKvstI
	 Ahnzske/3EYalXgGFqKcuRgk+ZqJY7kOp76VBBHjYaNamRLhCPiINT5qn7dH3M3x0m
	 brdfZ5cyF7ZuUNPZWw5lvK4Z7G8ETZGxNwFbbHzjCpgzJQVrPsFPVSVADoRDcYkHjl
	 rFMrtRh6xuQuaHwhRMUFcNa11iBBGUIAhRn6Rh9/SovRBhFew/VHrKfQEmwBf81iau
	 reQOUL7AYE7zQ==
Date: Mon, 7 Apr 2025 13:47:41 +0100
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
Message-ID: <20250407124741.GJ395307@horms.kernel.org>
References: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
 <20250321-igc_mqprio_tx_mode-v4-1-4571abb6714e@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-igc_mqprio_tx_mode-v4-1-4571abb6714e@linutronix.de>

On Fri, Mar 21, 2025 at 02:52:38PM +0100, Kurt Kanzenbach wrote:
> Limit netdev_tc calls to MQPRIO. Currently these calls are made in
> igc_tsn_enable_offload() and igc_tsn_disable_offload() which are used by
> TAPRIO and ETF as well. However, these are only required for MQPRIO.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Hi Kurt,

Thanks for the update. And I apologise that I now have question.

I see that:

* This patch moves logic from igc_tsn_disable_offload()
  and igc_tsn_enable_offload() to igc_tsn_enable_mqprio().

* That both igc_tsn_disable_offload() and igc_tsn_enable_offload()
  are only called from igc_tsn_reset().

* And that based on the description, this looks good for the case
  where igc_tsn_reset() is called from igc_tsn_offload_apply().
  This is because igc_tsn_offload_apply() is called from
  igc_tsn_enable_mqprio().

All good so far.

But my question is about the case where igc_tsn_reset() is called from
igc_reset(). Does the logic previously present in igc_tsn_enable_offload()
and igc_tsn_disable_offload() need to run in that case? And, if so,
how is that handled?

