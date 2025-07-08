Return-Path: <netdev+bounces-204955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA30AFCB19
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89416DD84
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977762DCC0B;
	Tue,  8 Jul 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZM0odBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3792D8DC8;
	Tue,  8 Jul 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979407; cv=none; b=kq3dgQT+N58C1w6QVam61YlJrW72FtAkpvmLZxoFFGIyMS8Z8Wfc5Xa7WPO7VUM4J8ekX79P6u2aY7YX1/UWxQsLTxdJAN8W8ubtyO9phfGItSMaNGDvLLnisKX7SMIO4FW6/kJl+J5vsPHb3YyhRR2lx5jAOs40Qv6wss/0RRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979407; c=relaxed/simple;
	bh=DgL7bLUmiUt/MpTC1cR8mct465iShHYmoEa2seWwnfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIqm1B3iwpUC69ayjCwNW3qY9Rs4a5jRYgsqhksceEy2aecOkpEO8YhUcewskHBOz0F7xq8yqWXwCcBaqNvSzb9iwLKZzuLW0HmJGmkxPXq/whN97HcL/mSVoCnEvv523JIwFNP98fWLjK+FXvEOPEjlPPTi5+ALUzCPS/qcmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZM0odBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D67C4CEED;
	Tue,  8 Jul 2025 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751979406;
	bh=DgL7bLUmiUt/MpTC1cR8mct465iShHYmoEa2seWwnfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZM0odBBmlb87vvBUNE5aQPx+bD01JtGBtU9Q+QzjJPGSVLgu1ZpjGCkuSOJQeBVp
	 vgYTmez6DsdmHrqBcCDAzdDtAz0YnANztaHRN80hl08Jun5semQck7c5rfapikiYap
	 7OxRFnWxYNjxB//S4zFsc7tGHUFXSjr5YeOF9Ex5ct/K48N0DTCa8EC3CCWNiW3ZPq
	 lVk5vEVVIdc3yzy790zi7ZfsXm57oZG6Qp/v+/reMMVP0+TxtIEJ1lKESxMwD3fOdQ
	 D3jCS99Z26aFvqXy1EWNl8ER5KmVn9vE4RiNbVrPPRvEJVIbJqfwTfg/ACMPLsIC7Q
	 EHI0aBAhB7UKA==
Date: Tue, 8 Jul 2025 13:56:43 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linma@zju.edu.cn, davem@davemloft.net, gregkh@linuxfoundation.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v4] net: atm: Fix incorrect net_device lec check
Message-ID: <20250708125643.GH452973@horms.kernel.org>
References: <20250705052805.59618-1-linma@zju.edu.cn>
 <20250707175558.3137384-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707175558.3137384-1-kuniyu@google.com>

On Mon, Jul 07, 2025 at 05:55:58PM +0000, Kuniyuki Iwashima wrote:

...

> Given all the recent commits are odd bug fixes and there are more bugs
> (e.g. firing netdev watchdog infinitely, lack of netns_immutable, etc),
> I'm leaning towards removing lec and mpc completely.  I don't think it's
> still used nowadays.

Yes, I agree that we should consider removing such code entirely.

...

