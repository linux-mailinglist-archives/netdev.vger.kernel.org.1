Return-Path: <netdev+bounces-56571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1412E80F6A6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E434B20EBA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2681E50;
	Tue, 12 Dec 2023 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqztavui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDF80059
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2394C433CA;
	Tue, 12 Dec 2023 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702409258;
	bh=/cJEqTxk/CbtjQIWxlbZtNd3vqq4MbKnFPuX7Jd+ots=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hqztavui8CRP+Ml4w7lGCsb4/nmAXu2/48mPx4jh+/i4BJt7l4zLWC0D6ROr/ar7u
	 lyDGJ4cIH/pL5/IzVGomF+W7N63GoDxlWYd/CPcDV4ahGZeBcNPXV+UxcMVQvMJhTn
	 SLQN2nX0L5pXZff0Ro05+kSQ/W24RYNPmunvbrn2LBmZ9fCZr91UOX+MY0wOYlH/Xc
	 +Cft2dqwIor0nG8bXnKtdqYEvA/vp00LKNsuSJHGOIqy6A4duP4BcYUJYbSiHXhwQK
	 /2RDbOR7wxtNTXNlFaIJuDgzPtwtZ3vDOymgH9zaD7BcKy4Y2hyRPRK8m9QMr8bwfW
	 lTlHkzIwX1cRg==
Date: Tue, 12 Dec 2023 11:27:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 03/13] rtase: Implement the rtase_down
 function
Message-ID: <20231212112735.180d455f@kernel.org>
In-Reply-To: <20231208094733.1671296-4-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-4-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 17:47:23 +0800 Justin Lai wrote:
> +	netif_stop_queue(dev);

You most likely want to stop the napi before you call this.
Otherwise NAPI can do some clean up and restart the queue.

> +	/* give a racing hard_start_xmit a few cycles to complete */
> +	synchronize_rcu();

Call netif_tx_disable() instead of stop_queue(), it takes the tx lock
so you don't have to worry about in-flight packets.

> +	netif_carrier_off(dev);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		synchronize_irq(ivec->irq);

Why?

> +		/* wait for any pending NAPI task to complete */
> +		napi_disable(&ivec->napi);
> +	}

