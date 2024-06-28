Return-Path: <netdev+bounces-107685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376191BF1A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764C81C21F56
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580D1957EA;
	Fri, 28 Jun 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDwFXP0J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B704C3BE
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579557; cv=none; b=TxMeD4WeiJYehRBcANu39uiDUxovAo5KRWe3MtgAjYiNq033ZKsb7jpuVWdGiGFuCCwq3vP4Cu/rDuRsCR0LsIIU349PjkfaosHQymk82jY1WGfzVwHkECR91H7tzrohCeit+rCqMNLtUleRw3RQbdzh9UkjY/+YvaGl86oaF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579557; c=relaxed/simple;
	bh=AALzB7Je+dbwh9aqhaMZgSkeBrDEJ4ks1mzPpaq1yQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4aJt9JvGwBQBEtA8uBRsnIW2ZSgshSUc8tu/oGriVsFdxsfTpj+uWzJORMbIiDf+pMsx0y+JEt/Cf7ev/Ah2geoWNQLpuhFtjTpKHki1oDZ2qcMD/ieoA0LvnoxzkaZl7WWoW9OCsp2VzW4SSeG3ve0Dn15dzVdWSLUU5nX1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDwFXP0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A098EC116B1;
	Fri, 28 Jun 2024 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719579557;
	bh=AALzB7Je+dbwh9aqhaMZgSkeBrDEJ4ks1mzPpaq1yQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDwFXP0Jezjh6HwRwWyN4HiJxGhb1hSRwHt/ZYzmyzmOCyrPwU/rNrckD4px3ywZd
	 E8odmGUnqgblI3gL/sdST1uqbx785TAEVx98PMpcJIwajUWnwnNy5io8K4FjqaZzh3
	 q7N3prYya54Qn95j3rXkErV9SKsVK1a23VS1VV9JXms5ID3YTy5TvnsEBu+bdVWdGY
	 xhQCOLU+Cd1I2HZ1HUlg7ZE/g/4OVyLO7tuNZogKO7k4wF3fEDY/wALEmkRoctDL9H
	 SidVEi+c01SgPB7yBsR0uqmON+sGOUc6WFtEY0lXT2QeKRNh6ewq+bznFm8KTCk2Pb
	 uI5N+xPfkNc5w==
Date: Fri, 28 Jun 2024 13:59:12 +0100
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igc: Get rid of spurious interrupts
Message-ID: <20240628125912.GF783093@kernel.org>
References: <20240611-igc_irq-v2-1-c63e413c45c4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-igc_irq-v2-1-c63e413c45c4@linutronix.de>

On Fri, Jun 21, 2024 at 08:56:30AM +0200, Kurt Kanzenbach wrote:
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
> 
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
> 
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
> 
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


