Return-Path: <netdev+bounces-125715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F322C96E542
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9191C22FED
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F41A4E6B;
	Thu,  5 Sep 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGO+eM4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47961823DE;
	Thu,  5 Sep 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572834; cv=none; b=jENodQHECv9DbWEl5g/0tSta5BHz1kPdGMDEQeSyyg7axGzZpjRhDDYEuSH+5kEkt16Ylo74KnoG9K+gABOlxZZzANVWXSPn22CmG5ydGddiT1+hfefRwyU8PAuMgKLPPwoip2TxT9QZHtU/rVkOvjBq4TR9yrfyRS3eDNWZ/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572834; c=relaxed/simple;
	bh=uhgK5Fgg1EVK3uIYtD9j5KLSTSz7iQLddBiXKhSxejo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hObd/VdY4EwHESWADen7r4CubvO5ZQTKmBBvyNnu2wnAJNlOhSn+SGGmKWL4zxCSn15I1c3q6Kp8VX2eEFsT7TynAxB4zmR0UuSbp8mnnB9bngVInKPJJbXUbg0Vy0nYJ/Sn9Fmp+e5QdTvJlW1JQm/MDDOd6hv3lXZ/rby1cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGO+eM4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93920C4CEC3;
	Thu,  5 Sep 2024 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725572833;
	bh=uhgK5Fgg1EVK3uIYtD9j5KLSTSz7iQLddBiXKhSxejo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGO+eM4C2yRU3rdIGPnW7bMrhAOMyGVNQcsOeOmaB/s4IAgZM+RL0aUQfuezmIOsF
	 exqSGiF6a0ExffFottQrBRpNr35TIk2VLt3XP9/kmJCEVHEec4Di8qfTO6w0mEpArE
	 FGflG6cx3svcMuTRjdY72B3g2tHWypymBxK2PVhsYjKHJ+Nc9F/ZBr4CEFajIvGKV4
	 c6t+avUGeoBsfzChJzuOOlXCxYteX2hB3R/4AiN4LdAngaV/mUld7rlddb+IYwzP+a
	 S4cwLvo0isKHBzJXjU5PRYT3/6pfuWEf6Ma4UVKsMuNeCKbvLtBpl2P3yoJX4+Y3RZ
	 0Q0vWx/b8z0+A==
Date: Thu, 5 Sep 2024 14:47:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ftgmac100: Enable TX interrupt to avoid TX timeout
Message-ID: <20240905144712.6492ca9b@kernel.org>
In-Reply-To: <20240904103116.4022152-1-jacky_chou@aspeedtech.com>
References: <20240904103116.4022152-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 18:31:16 +0800 Jacky Chou wrote:
> Currently, the driver only enables RX interrupt to handle RX
> packets and TX resources. Sometimes there is not RX traffic,
> so the TX resource needs to wait for RX interrupt to free.
> This situation will toggle the TX timeout watchdog when the MAC
> TX ring has no more resources to transmit packets.
> Therefore, enable TX interrupt to release TX resources at any time.

Please answer Andrew's question (preferably send a v2 with the answer
as part of the commit message). Add a fixes tag, I think this is where
the bug was added?

Fixes: 10cbd6407609 ("ftgmac100: Rework NAPI & interrupts handling")

And when you send v2, please make sure to CC the author (Benjamin).
-- 
pw-bot: cr

