Return-Path: <netdev+bounces-235264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D165DC2E643
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F994E197D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A668D2BD580;
	Mon,  3 Nov 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtwp0WwM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332819DF6A;
	Mon,  3 Nov 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212179; cv=none; b=brD3OyIcygnDBuV4ivgumwxilT/fJMTlA8Ma1nLkz4nQPIv5QLHRBBv2Jx3hzvxJ0ljzeM7HgjBDKT35u8p2ZVQ13YXkqklpYW5qV7jFUOkf0BXloy+T10hM7Qit9lwRQg9b2HvJBVFTxPJRhixTZAZ977UTCG5eX1FPOaltXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212179; c=relaxed/simple;
	bh=854Co9JIPac5ftPb0Z+jt3kkc012HKqinp+p8MxORFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEJWVfDr+6+TdmsfW6Wre3qyYsBVJHw+uOWoIZhtxbAY6YU7j/qKvUyqGymZ+WG7HZcPntB2erEdH1NKQE3G0d5Pj9VkxoxDBmcWrskzO+i8UaAAOmpYoT9baqZ5TaoPKj9oKxKWnFxA9S0keJkG5FiLsex4nKXgxhBEk15JiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtwp0WwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE7C4CEE7;
	Mon,  3 Nov 2025 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762212179;
	bh=854Co9JIPac5ftPb0Z+jt3kkc012HKqinp+p8MxORFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gtwp0WwMwanFkumr1nc9fYwmQeFZ2I43nliRmGnUnlPz/UFc+nH42ffZjKrC4w8nN
	 9ievxFM0WsoGDpLEEDNYerKxfotShI6Bw2L4P33gvxWeqoJrnjYVrzsxduHShnMdgm
	 Auhc9IK0Yd8Znn0mlz1CwzF/6VPgVZaAQW/DXIQysmFWYtP6HBzI1C0CaCr3ZxwKf3
	 a0uPglNXe7HvSYlq20twtjJ5IYGk2N5B1mHrUAvIb/DfWYaJrRJ/13nibL6fQj67GP
	 RDBpzOE1sTRu79nATXtvmLRJdriYIdK9YHAuTuQxDacUiSNpHaViHGX+yJMcbT/K7T
	 lygZA5qbhWJbw==
Date: Mon, 3 Nov 2025 15:22:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Doug
 Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Antoine Tenart <atenart@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Yajun Deng <yajun.deng@linux.dev>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 0/2] Allow disabling pause frames on panic
Message-ID: <20251103152257.2f858240@kernel.org>
In-Reply-To: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 11:46:29 -0800 Florian Fainelli wrote:
> This patch set allows disabling pause frame generation upon encountering
> a kernel panic. This has proven to be helpful in lab environments where
> devices are still being worked on, will panic for various reasons, and
> will occasionally take down the entire Ethernet switch they are attached
> to.

Could you explain in more detail? What does it mean that a pause frame
takes down an Ethernet switch?

