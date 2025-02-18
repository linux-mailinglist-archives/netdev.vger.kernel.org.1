Return-Path: <netdev+bounces-167132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD3A38FF4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B2F1889ED4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28518C2FA;
	Tue, 18 Feb 2025 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPYBCLh0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22788F40;
	Tue, 18 Feb 2025 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838826; cv=none; b=aURGQQeFWKmyk19UP+D+UwilzDiwh9p+XxS2pOHkUCtFtldUqA6sibO2rPm7q+DUTPMbbi3MzNzRP3b8WDOuqN9J09lEeGROXqTl1dKCj2mwuBd/6U11UDwRwp4exX7BM2C/28L4JmUgkON6M0Qeq4BxfqU5sn2ZaOl8gokDF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838826; c=relaxed/simple;
	bh=q0rcWJuVp3xACT0C9VSicr9GFn4icXokQr6eAKrie3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsYOoUccQGAu3+nBR3GCJfOboJj1ver8iIILiEqNVuIAkkGfTjS7tKpC9xYeevSSiH+faQCRvuFAN7AjNnRjdHu538Is8bqf33R4hB+D03MG6CD9rzIznvuiamsyCuP42phcQRo5BCLRyI4mp+jC9po9S922o+t/4dYl/Jv/DQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPYBCLh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DF0C4CEE7;
	Tue, 18 Feb 2025 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739838825;
	bh=q0rcWJuVp3xACT0C9VSicr9GFn4icXokQr6eAKrie3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPYBCLh048/MnFcVIMotJk/mVcUUWpWas+X/Fc8SjrfAYhwoGKtg1cdviibGNNlAi
	 TZZ9dSuu7lwyztrpCvdgBk7nqiRCZ1FQZ00o8WuyLWvi7Wlm+7IEys0tBFIyRC9gME
	 h2AutDLPaCjtbWodiIpi7WRwxoW5/jzv24b0mlrJWL1luB3Wv/CN7v/e/ylfuC90MF
	 Ywi2g5E08uC+ZnvDdNQOwKdsoFRhkHV+YyBqe4IpBDTAjtpcY801kZXeVqa1zRicsM
	 GN55nDjb2nFlRsSlMEBJW/JBk18clBkNuhf4mz5Ro3S7VvFt4gRN2teIsxYChfgT4R
	 vovoJ7QSaYYbw==
Date: Mon, 17 Feb 2025 16:33:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern
 <dsahern@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, kuniyu@amazon.co.jp,
 ushankar@purestorage.com, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net v4 2/2] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Message-ID: <20250217163344.0b9c4a8f@kernel.org>
In-Reply-To: <20250213-arm_fix_selftest-v4-2-26714529a6cf@debian.org>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
	<20250213-arm_fix_selftest-v4-2-26714529a6cf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 04:42:38 -0800 Breno Leitao wrote:
> The arp_req_set_public() function is called with the rtnl lock held,
> which provides enough synchronization protection. This makes the RCU
> variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
> dev_getbyhwaddr() function since we already have the required rtnl
> locking.
> 
> This change helps maintain consistency in the networking code by using
> the appropriate helper function for the existing locking context.

I think you should make it clearer whether this fixes a splat with
PROVE_RCU_LIST=y

