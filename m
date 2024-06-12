Return-Path: <netdev+bounces-102984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22BC905D7A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D9B1C21502
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26457333;
	Wed, 12 Jun 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6dBsocF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3E12A14C
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226667; cv=none; b=FZdhsBSr8wIfMbe/0NpzrvSmM/RhbQlKmRaATpVka8N33DnoSDGdIa+rH0MTmg5ACMnp2Ayi44OrOj2gGH+BtV2WXN9fU/Q91ZPKEcFkSXKzLrc+zf1n7+ph+DJ6qEJ6LaJ9/Q2nQn0UOrbkBd3GhK42fCIPkjJB3eN8oMq/tKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226667; c=relaxed/simple;
	bh=/f74LLR3bYn8DSgYmSLVdzpFG7OcHRs+j1TtcoJfkaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCXED3xJAU0plFNRy1d/SgAZosqp3GIm8K82jjUDY4vEFJPi02a8TYlaVW+cGtqaKjjAjih+NAymQyLWXtDkMryh6SKNzD1DOJtoAdPFrta6NUJVYPKmnvaPeKce0ZPeXNCrjXN010UN20gOK+wcnsWB1erWDQ17MRj7ZAcCc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6dBsocF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBBAC116B1;
	Wed, 12 Jun 2024 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718226666;
	bh=/f74LLR3bYn8DSgYmSLVdzpFG7OcHRs+j1TtcoJfkaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6dBsocFIeELcObRrNUd8iMGu9u16dyyQ4H1UBFxG0WFyBqdb6mMzqGhUyA00lKmH
	 dfIhnIJrAFKsGCuX7j4S/4S9irDSozLMtUgqsl+d2VMUBE5YjFCGD5RgRyZruEu2/0
	 QXagKMooLTMcjyzfOPWWTX3FAE2164O7/7VF9lAuAIj+abMyEp10qUGIQ0btJqWEKf
	 8RNPTZBja9ggGz7wKF0g48t2Ds5UydkX+wLOkJ7aRGv8UtXvB5xV8weJ3jhMy2KY63
	 pGIHZoGuuxe9d4ICIvUQ+sd5NL9gKUHRsIgmKLPUybx+hbdO6U94v0fkWiEywqBFdc
	 01iK5eWaP4LMg==
Date: Wed, 12 Jun 2024 14:11:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: David Ahern <dsahern@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Adrian Alvarado
 <adrian.alvarado@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] bnxt_en: implement
 netdev_queue_mgmt_ops
Message-ID: <20240612141105.16880cde@kernel.org>
In-Reply-To: <80a1ea79-738d-404d-8b50-cc5eb432153e@davidwei.uk>
References: <20240611023324.1485426-1-dw@davidwei.uk>
	<e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
	<b2dadafd-48c3-4598-bee5-a088ae5a4bc7@davidwei.uk>
	<1b26debd-8f18-46de-ac6e-05bff44a9c52@kernel.org>
	<80a1ea79-738d-404d-8b50-cc5eb432153e@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 11:19:47 -0700 David Wei wrote:
> Any validation would be done outside of this patchset, which only
> focuses on resetting an Rx queue. Reconfiguring page pools and HDS is
> orthogonal and unrelated to this patchset.
> 
> The netdev core API consuming netdev_queue_mgmt_ops would be
> netdev_rx_queue_restart() added in [1].
> 
> [1]: https://lore.kernel.org/lkml/20240607005127.3078656-2-almasrymina@google.com/
> 
> Validation would be done at a layer above, i.e. whatever that calls
> netdev_rx_queue_restart(), as opposed to netdev_rx_queue_restart() or
> netdev_queue_mgmt_ops itself.

One could be tempted to pass a "configuration" object to tell the
driver that this queue will be required to run with HDS enabled.
I wonder where I've seen such a thing...

