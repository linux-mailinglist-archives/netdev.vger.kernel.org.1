Return-Path: <netdev+bounces-46050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A10C7E101C
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2872819F9
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291C1CAAB;
	Sat,  4 Nov 2023 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOIwzmZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612A882F
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEE9C433C8;
	Sat,  4 Nov 2023 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699112197;
	bh=vafSQTQ5kXKyz/SHRy5gVLc2MmSNeUAQAiolRcAYYaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOIwzmZMSGkTaLl4Ih31a2Q3XsXTeyKtQqcxLwKL4lNDs+oRYQRkuwYp0Nc9MYrOq
	 gi2iiKNn3yhlrZN+IMKdk2V3OtTWXIa0iwN81TNNlAu2+tsVZ60sORX0EbyUjtn+3P
	 COycA5cNkMAKB3scLRBbiZZ7mdT4FrxRxmeN+N75rK/SykBE6DVBKurNNh0dOHPo28
	 jFQ9SqE2qs2VZMTFU6KZkmiUmZuRtsTm5NUkVBxuHEBt1kkuiX90P9yl0VbRv/Ys5Z
	 SM75E2yxn7JMDQu9vsCPLXqTvi1DhvA5zfqVy1ORwulBzjJTPQz/fZ7vlVddt54SOB
	 I9++h5DTc5hCw==
Date: Sat, 4 Nov 2023 11:36:17 -0400
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>
Subject: Re: [PATCH iwl-next] ice: periodically kick Tx timestamp interrupt
Message-ID: <20231104153617.GK891380@kernel.org>
References: <20231103162943.485467-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103162943.485467-1-karol.kolacinski@intel.com>

On Fri, Nov 03, 2023 at 05:29:43PM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The E822 hardware for Tx timestamping keeps track of how many
> outstanding timestamps are still in the PHY memory block. It will not
> generate a new interrupt to the MAC until all of the timestamps in the
> region have been read.
> 
> If somehow all the available data is not read, but the driver has exited
> its interrupt routine already, the PHY will not generate a new interrupt
> even if new timestamp data is captured. Because no interrupt is
> generated, the driver never processes the timestamp data. This state
> results in a permanent failure for all future Tx timestamps.
> 
> It is not clear how the driver and hardware could enter this state.
> However, if it does, there is currently no recovery mechanism.
> 
> Add a recovery mechanism via the periodic PTP work thread which invokes
> ice_ptp_periodic_work(). Introduce a new check,
> ice_ptp_maybe_trigger_tx_interrupt() which checks the PHY timestamp
> ready bitmask. If any bits are set, trigger a software interrupt by
> writing to PFINT_OICR.
> 
> Once triggered, the main timestamp processing thread will read through
> the PHY data and clear the outstanding timestamp data. Once cleared, new
> data should trigger interrupts as expected.
> 
> This should allow recovery from such a state rather than leaving the
> device in a state where we cannot process Tx timestamps.
> 
> It is possible that this function checks for timestamp data
> simultaneously with the interrupt, and it might trigger additional
> unnecessary interrupts. This will cause a small amount of additional
> processing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


