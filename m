Return-Path: <netdev+bounces-13751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68FC73CD3B
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AAF1C20934
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928ECEAF2;
	Sat, 24 Jun 2023 22:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF8DDDD
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DCC433C0;
	Sat, 24 Jun 2023 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645152;
	bh=idJ66CRxT3yfJvKA9u94RA70y7BMoYCiaLo9F/vPj1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQoU9/Cvaljws7IscaBPy5n1X320AYW1Bv27puvgqSJkdj2QRxaXsatElti+TtcDg
	 npesna2s1JSPGMDbAx3efWbO6G2H3iOuUcdoWZxCybiIYegR/IV6PIjkZo4ggNz8ya
	 ddZrS6cy1uKSqWy7scWIxp7cAL2GT30isP8g+QnSzahHvytMmNal8m45JGvrNoj8Gl
	 6Ma+iqQSuifHljv/MNCgKdrg2R9cVltuBN0hl1P+eOqGcrx1U0sjyyK7SgeqsNqbXa
	 a/OXhUWJwFLnvhyEmyLTQNnQziwkdOeKQjqhpkqHBAtP13e4VyftTZnWyc1fLNsS/1
	 TuplP+/J19Ohg==
Date: Sat, 24 Jun 2023 15:19:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
Message-ID: <20230624151911.7442620c@kernel.org>
In-Reply-To: <20230622190332.29223-1-nnac123@linux.ibm.com>
References: <20230622190332.29223-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jun 2023 14:03:32 -0500 Nick Child wrote:
> +		if (adapter->reset_reason == VNIC_RESET_NON_FATAL)
> +			clear_bit(__QUEUE_STATE_STACK_XOFF,
> +				  &netdev_get_tx_queue(netdev, i)->state);

Why are you trying to clear this bit?

If the completions will still come the bit will be cleared (or not)
during completion handling (netdev_tx_completed_queue() et al.)

Drivers shouldn't be poking into queue state bits directly.
-- 
pw-bot: cr

