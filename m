Return-Path: <netdev+bounces-197522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EBAAD902C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA0189886E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B19444;
	Fri, 13 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/QKlcvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FB1A3155;
	Fri, 13 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826318; cv=none; b=CDZyoT1WZfKWZ4ZqgZXsFEXpCycDX0u+of2Lnlhz+dCC7osm9THUZo8bP7sM6Ur6W9uFwQULLb5A1smz0EYWeXpA2wjXTbfSyvysLYqUDffvDZcXLcXCEqtNivwb5cpbcOmQ2bY01kUlKKuCJeRs01IxX6gcJeA8uhj05yF5NIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826318; c=relaxed/simple;
	bh=HL592iK92IpQcaoTgucoduyxR9zy++9nH4BvdPgg5XI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xp+CeKWTP+wfZRSRHIKnK6Xw32Qc4k2U9ZzZTBV0WSxClwo8mAkiUj9hTnKp9mJZEPYDnYGopP0v7A2FipQEUDPaXEqjivEpq+VSXioNiuTjkoYXf95rqWRbe34TFp2ty/gbCH//wm3kdSkfRuEY6lbjTgus7zMcScb7FyNhN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/QKlcvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2631C4CEE3;
	Fri, 13 Jun 2025 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826318;
	bh=HL592iK92IpQcaoTgucoduyxR9zy++9nH4BvdPgg5XI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/QKlcviBMAakgpPNgOtZpNSlUvNvjuarvWvcfz7MTB3lA1lmL1KfBcE18hvzfXGV
	 KQ0AjDi8NeZ4+jzSgm5qrJh/JkPmAa6qq1fzVSI/fJC7/GUxX60oeAZrrpbZMO2tSM
	 XL9TX7fAZAnm09+Z+VikP6tSQc1c3fNkx+ScwUm1NLkq5qVe0Dt7Agw9pkvemdxPN6
	 lymK7kx9IpXc3hf0+GVoYV5vQ4i9VqpypxfZAyXMN1Ahgw5ZzdM0RtdtpoAm0KfGMf
	 pwq6T/6TxXe31+G+rp2vXkKwagZp35nE0+BzT2eGUP7bbgYxCCdgyr+jGQ5MvA9XeU
	 lMzk1/brZSRMA==
Date: Fri, 13 Jun 2025 07:51:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haixia Qu <hxqu@hillstonenet.com>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Richard Alpe <richard.alpe@ericsson.com>, Jon
 Maloy <jon.maloy@ericsson.com>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: fix panic in tipc_udp_nl_dump_remoteip() using
 bearer as udp without check
Message-ID: <20250613075156.5dc12d97@kernel.org>
In-Reply-To: <20250613073826.96527-1-hxqu@hillstonenet.com>
References: <20250613055506.95836-1-hxqu@hillstonenet.com>
	<20250613073826.96527-1-hxqu@hillstonenet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 07:38:26 +0000 Haixia Qu wrote:
> When TIPC_NL_UDP_GET_REMOTEIP cmd calls tipc_udp_nl_dump_remoteip() 
> with media name set to a l2 name, kernel panics [1].

Please take the time and read the doc Eric mentioned to you.
You're doing other things wrong, too.

