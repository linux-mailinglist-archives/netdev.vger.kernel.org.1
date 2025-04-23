Return-Path: <netdev+bounces-185302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80021A99B90
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC271B6815A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD81F584E;
	Wed, 23 Apr 2025 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOQN83hH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E72701DC
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447595; cv=none; b=OJJKZ6zxYkY6iDuSvlVgb6DSpzpq5xQnl5RzWyoXi6zhihOEQ6KT+rLaR6Us923rG/0Hr7XLir7ROzliLdxBNigdzVzliTS+Th1JVMzLL2IkBlwQIqH6aiPLN9azqOKNgmTUvO7+dK/IUglPOnsyeikh9HkqN0Bka+Trk59K/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447595; c=relaxed/simple;
	bh=5Tl68l12QKePWTi4Fci1YuVxHp5REKn62c5v7vuWp7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b58buYDABB60qH1947uBB7yB/hmsxP5Nd5xFVVU4hajwPgFKMgI2vAKrauL94QF2yuuEpUt0AMK1cMwOLFQ0OxOH55HiKDmcIVejkMrvWcc1Pzm3qKXu3iEeU3wG38zf7xrr4gTJuxDDj8Knoa26Q0R9mnurnJhGlJRulfunRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOQN83hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C39DC4CEE2;
	Wed, 23 Apr 2025 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745447595;
	bh=5Tl68l12QKePWTi4Fci1YuVxHp5REKn62c5v7vuWp7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vOQN83hHnkpkH5Jn180CTTGNnvqimZQvMuDEMYghA9HK7jxWDq/K0RZhcUaK3qVqs
	 EV1f65eQRxFpQQFKzvAjQNP88vP9zzCrUYALv9O7+yv8+cauYhgarezcMEk3yzyKKN
	 gbDpCTN+jzK/UDWvNPPX9bcW7nEnXk8AOTfdP+DOUytGdsUowDB8sGbFT42B7GuNP2
	 ZRwb+T4u/OHU+6dS/RcZkvyDPL6aVHBV+KrbMEoknSC1D1hwnsjplqeFLtugzytF5h
	 VLZWmWv+2ULwmpLxsTbs6jr9X4nq39NsO0Hs8Q+HpV2RH2GiIq8DPKjKVFeesFMKj6
	 YH8gJU5eIckwQ==
Date: Wed, 23 Apr 2025 15:33:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250423153313.7e72c924@kernel.org>
In-Reply-To: <20250423145736.95775-1-kuniyu@amazon.com>
References: <20250423064026.636c822f@kernel.org>
	<20250423145736.95775-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 07:12:55 -0700 Kuniyuki Iwashima wrote:
> If the netns is queued up for cleanup_net(), the local netdevs
> are handled later by default_device_exit_batch().

Missed default_device_exit_batch(), I love notifiers so much!

