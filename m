Return-Path: <netdev+bounces-102826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1517904F44
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A1E1C2353A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFCE16DEBC;
	Wed, 12 Jun 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwBmetO+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6CKydGY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAC16DEA7
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184512; cv=none; b=ko0UABE3Fk5NpENRlgaZ/iqvs5VvldR6EEdHMiyfo001VXvCJeWnjTi4eDDF71r+HxB0E8ZepY+X9XIhiVgOInKAY1RmKTQ1yH6xUFKEb0wDb3zqKwUMoZkAlES8vGAX6T4tp0FWwPsT029qjYlAeEaqgDrlKkWhSAIannsziDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184512; c=relaxed/simple;
	bh=cGaDMvWV02foESwJ/TJTmkxoax2nxqEIbcQBG+LzL3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efibtbi6XAlqGSRdbLf3BAt0PAo0Tj+xbNDT7/9ynHiCcMM9FWc5X9VjHRS4953jK4Yh/hjB+Ire6S47ibhlU2dux95Yvz3hJN3b9iw59Iz8XJXm2XkDhXxvW3lO1bX/LrVaG2CwuDEEfin76CkS+e3TRl/S1Nuh+9JwzL2f0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rwBmetO+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6CKydGY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 11:28:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718184509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQFOOHKUE5+8vXSSbw900OF6SGMvwSRfneg8s5agc/0=;
	b=rwBmetO+KdO1lFIgaNJkOHbT2OpUqwVdBkm4LX8/pHRg+BRzRCD0bHEkpuCRrh4UZhcYlh
	vVNJCOBAPX9kPhXmYEVzd7oya1FKjDKqYAsxujGU2k9Vi9K8AO5yKoTpG30XORPpf0PlJs
	6tvp1FidN0CZwVLK9D0Uh/PhaK404ddTFy2VL8vnPvZUgTwZIBAY6bc9F69MMtoJOwssHJ
	KkjPiABDaj59BKBMFMUas9zV3L521rFPydPU1nDbkoa9xmONrleIDO6xFa0YuW1OO5BJ+y
	73vP6JbNKGbTNAn5sf3qVKJTzuZ8Mr7G5MNc7TTFoCQN3ZN2fiRXpptL0N9Ajg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718184509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQFOOHKUE5+8vXSSbw900OF6SGMvwSRfneg8s5agc/0=;
	b=p6CKydGYM/gYUSMoNMiy9Qv+g8dF6peiPoMeI5bhgtJPDebsH+aDxS+J6WpA31fagHvB53
	lmk/luaEspUt/lCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
Message-ID: <20240612092827.ezAf-luJ@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>

On 2024-06-12 11:24:53 [+0200], Kurt Kanzenbach wrote:
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
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

