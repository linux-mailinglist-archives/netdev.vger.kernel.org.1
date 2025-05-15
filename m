Return-Path: <netdev+bounces-190705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC8AB8528
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CD9167CB6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61480221F0C;
	Thu, 15 May 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fea3Sdvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CF1DD873
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309582; cv=none; b=JaPQxlEGkRSjrGe9EjV3tqG7lqZl8CR2DZqEE8sR6N2KNIYKCx3F0QttdOzAD6akY9z+5Y++5oZyV7XiZSUB/7U/y0ClMZQGq7RbWhqJKMlFMnXSKYWdPkOEM2E2k0bfJkZ5OxcEhgGXs0c9hdn/sIEF1RbM7tGkxuRdXpjGcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309582; c=relaxed/simple;
	bh=sOOr/cGmH1ZHziLiI3ddYS5UABl35cDPdQilJlXbXw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfSkD+kQnVA/p0tPAjAiz/d3WYxy8k+5A6MsgPJjqrsJmpO7A4IPR7Eswhkf0Et3sSwKMeqfG6vup7wmyfommLn4ONfF6Ud5GSTma1mT2lxSxPb0cx96tNL55bByHU5rjJHyeDLJHn3H12fgETZtroXikh9ATj9YXjBY53EWdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fea3Sdvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF68C4CEE7;
	Thu, 15 May 2025 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309579;
	bh=sOOr/cGmH1ZHziLiI3ddYS5UABl35cDPdQilJlXbXw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fea3SdvkxuOMxetev5CptIA99sIoAXbCdjBNw6fyelAoRe6Y6iHC/XJQxP5+1F2lr
	 ax0w/uVNcYCRLF9PubVoUNjVB5EPpMpcA/XICK3ipe+IEiIh9M7BA2JYn790PKcl3k
	 5Z+sLJuVD5DGJJtyjuu1PvlhqcFNjxy/WIWyzzFq/86QBmefiCh/Ofxp0p0ZlOhzjI
	 UWHRF4J+HmKaX62D0mSXcIaGHfgo05djHnu4BsonnChfWoaOWFuVq53f2I7g20mbQ4
	 AnC4owNvheAsVQm92CgnMzYY032g1Jwaa9pxZWKVJIMVScWgjn6t0DTZZJAueuQTFZ
	 tq4WVnVz1pj+Q==
Date: Thu, 15 May 2025 12:46:15 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com, jacob.e.keller@intel.com,
	jbrandeburg@cloudflare.com, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v3 1/3] ice: fix Tx scheduler error handling in
 XDP callback
Message-ID: <20250515114615.GU3339421@horms.kernel.org>
References: <20250513105529.241745-1-michal.kubiak@intel.com>
 <20250513105529.241745-2-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513105529.241745-2-michal.kubiak@intel.com>

On Tue, May 13, 2025 at 12:55:27PM +0200, Michal Kubiak wrote:
> When the XDP program is loaded, the XDP callback adds new Tx queues.
> This means that the callback must update the Tx scheduler with the new
> queue number. In the event of a Tx scheduler failure, the XDP callback
> should also fail and roll back any changes previously made for XDP
> preparation.
> 
> The previous implementation had a bug that not all changes made by the
> XDP callback were rolled back. This caused the crash with the following
> call trace:
> 
> [  +9.549584] ice 0000:ca:00.0: Failed VSI LAN queue config for XDP, error: -5
> [  +0.382335] Oops: general protection fault, probably for non-canonical address 0x50a2250a90495525: 0000 [#1] SMP NOPTI
> [  +0.010710] CPU: 103 UID: 0 PID: 0 Comm: swapper/103 Not tainted 6.14.0-net-next-mar-31+ #14 PREEMPT(voluntary)
> [  +0.010175] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
> [  +0.010946] RIP: 0010:__ice_update_sample+0x39/0xe0 [ice]
> 
> [...]
> 
> [  +0.002715] Call Trace:
> [  +0.002452]  <IRQ>
> [  +0.002021]  ? __die_body.cold+0x19/0x29
> [  +0.003922]  ? die_addr+0x3c/0x60
> [  +0.003319]  ? exc_general_protection+0x17c/0x400
> [  +0.004707]  ? asm_exc_general_protection+0x26/0x30
> [  +0.004879]  ? __ice_update_sample+0x39/0xe0 [ice]
> [  +0.004835]  ice_napi_poll+0x665/0x680 [ice]
> [  +0.004320]  __napi_poll+0x28/0x190
> [  +0.003500]  net_rx_action+0x198/0x360
> [  +0.003752]  ? update_rq_clock+0x39/0x220
> [  +0.004013]  handle_softirqs+0xf1/0x340
> [  +0.003840]  ? sched_clock_cpu+0xf/0x1f0
> [  +0.003925]  __irq_exit_rcu+0xc2/0xe0
> [  +0.003665]  common_interrupt+0x85/0xa0
> [  +0.003839]  </IRQ>
> [  +0.002098]  <TASK>
> [  +0.002106]  asm_common_interrupt+0x26/0x40
> [  +0.004184] RIP: 0010:cpuidle_enter_state+0xd3/0x690
> 
> Fix this by performing the missing unmapping of XDP queues from
> q_vectors and setting the XDP rings pointer back to NULL after all those
> queues are released.
> Also, add an immediate exit from the XDP callback in case of ring
> preparation failure.
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


