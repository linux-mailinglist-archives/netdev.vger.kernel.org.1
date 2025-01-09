Return-Path: <netdev+bounces-156867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618BDA08137
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AA816882D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4C1FAC4E;
	Thu,  9 Jan 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ0HSGkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611BB677;
	Thu,  9 Jan 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736453582; cv=none; b=uD01iWpYcs2WLKQ0tXgVm278MMSRKAiOGJWBDEWT0jwOqe/615vJfMreRcJ3ABg2yj6lF1vFBi04tf0OHSWjBiA4ZfD8ebKSi07BAKp7wb8DZdCTE7DhJQufUm2k28dipoIbR2ePsqnejmwQHPKBpMyMBB2sHC/wXIcpoWavOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736453582; c=relaxed/simple;
	bh=tperEaRIIGhyHN7oi8TZqp05v9Ha5g2DOJQQBgil3bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMnc0RXVz2HFdqOSu+GkRaGS9CTvrMpEOLFa1f9Hp/cUOo+8jmvkRCojwryB9fYg9CmQdXE7JgwsNaV2NA+FCAqaxX8H6AOWk7YDT4BqRA83LaPTehustk8Gt7TuPbcA+WTVWdUgVdcT9WmisobHnJ65pNBo2fdCdRp5PQDlazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ0HSGkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29636C4CED2;
	Thu,  9 Jan 2025 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736453582;
	bh=tperEaRIIGhyHN7oi8TZqp05v9Ha5g2DOJQQBgil3bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQ0HSGkcitx8D/Cm6ANa5kWlw40Im2jiezJe8pfTRmrMG9qJa89u0zhb0DFhuX3Jo
	 /Z1DtXsJkhl6VAjNsfWY5e54Y07XlyYO4XSifVH2ePdeFcmDDq1qqNCHBlOeoPH41m
	 stu4P0BYNBdlzuPscwW9U0hxk05xWFl63+tQUbeFOAbt9CIE8dQLjEZ4VUMoUovfg5
	 364PbPiJc5qPoUOYUS92LZgy6LAFVXY1TpJkO16hDJbqt1F+xbUtjJWqXKc6d3sKY7
	 AfqGpBHE8GUkpxPZHc7RLd6R2jzAB9fkoEGHNmXITRHUK7KWilWMCRTyo+NWk7f7Ub
	 cU/yC00rxW4vA==
Date: Thu, 9 Jan 2025 12:13:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: Carlos Llamas <cmllamas@google.com>, dualli@google.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com,
 tkjos@android.com, maco@android.com, joel@joelfernandes.org,
 brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
 bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com,
 smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <20250109121300.2fc13a94@kernel.org>
In-Reply-To: <CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
	<20241218203740.4081865-3-dualli@chromium.org>
	<Z32cpF4tkP5hUbgv@google.com>
	<Z32fhN6yq673YwmO@google.com>
	<CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
	<Z4Aaz4F_oS-rJ4ij@google.com>
	<Z4Aj6KqkQGHXAQLK@google.com>
	<CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 11:48:24 -0800 Li Li wrote:
> Cleaning up in the NETLINK_URELEASE notifier is better since we
> register the process with the netlink socket. I'll change the code
> accordingly.

Hm. Thought I already told you this. Maybe I'm mixing up submissions.

Please the unbind callback or possibly the sock priv infra
(genl_sk_priv_get, sock_priv_destroy etc).

