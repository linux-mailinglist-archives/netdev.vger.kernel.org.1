Return-Path: <netdev+bounces-135373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A599DA23
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCA8283040
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531B91D9685;
	Mon, 14 Oct 2024 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUdQohqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565322318
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948940; cv=none; b=fdKgoFMpsXQV6Hbf8e5AjO+qFJkfqKhM0E5ECu8t2ajxrY4EcN/2oUtbVlVYJQqfhhNOZ/rk7nx61aEz2Wodd1RQTZIe2xcsaMxG4LdfKNUag8xUBRNxPTtOULRQc5fCF1sCm3NB3PvqAFjBP9wUSH3iUpj6mjB+4FcCo7nYLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948940; c=relaxed/simple;
	bh=sjN0R8V1gEsWJGhOPn3LinwX4xloqEljgMK6jqED1Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP5Rle22Jtj49cSeW0on/yIHLZT4zQoGUAVM+MFATxftaLEnsCNiMYMFoGgtqrTpSvBQ9pS7HTu9GE7ZQTX6VFmSTstCGt9zGFkoJ1P2SibnmgET8RBvo9pSKPlRNOodxhsvRA9DcyPvsiZB/ut6AWp/YOCvrJeqMUd4CliCS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUdQohqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD3CC4CEC3;
	Mon, 14 Oct 2024 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728948939;
	bh=sjN0R8V1gEsWJGhOPn3LinwX4xloqEljgMK6jqED1Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IUdQohqYm/vyZDZwZDKBFfy5ZXtIMmyLwvEVh5RDqWY4Q0i2b37ItT5SwegC25I+z
	 5AKVqrPudCXv+Pu8qCRwhs6nphRJsnMlziggOdDFmzurRGFprCVW6XslR2efoOxBZM
	 XKFs0jgH5I1ow5Uc/7AVFgGhMV1AohS5QbFwn4WFb0kPqllA1yCK64ArzPssabqzzf
	 fPMm/n8XBPG7aILvRLHnCf7t61IwEe/iiJicKfQqRnStGbgabkiZLZIij1oD502dOk
	 M8LZk/lUC81q3+SrtSile/Kv2PvLFrhDBre64HLGYuOUEpX/ROP8oECVOsV+NmBpR+
	 5kWeAdYuB0bTg==
Date: Mon, 14 Oct 2024 16:35:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
Message-ID: <20241014163538.1ac0d88d@kernel.org>
In-Reply-To: <20241014232947.4059941-1-vadfed@meta.com>
References: <20241014232947.4059941-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 16:29:47 -0700 Vadim Fedorenko wrote:
> -	spin_lock_bh(&ptp->ptp_lock);
> +	write_seqlock_irqsave(&ptp->ptp_lock, flags);
>  	timecounter_adjtime(&ptp->tc, delta);
> -	spin_unlock_bh(&ptp->ptp_lock);
> +	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);

I think when you adjtime / adjfine (IOW on all the write path) you still
need the spin lock. But in addition also the seq lock. And then the
read path can take just the seq lock.

This will also remove any uncertainty about the bit ops.

