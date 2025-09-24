Return-Path: <netdev+bounces-226126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65019B9CB38
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18021895EE0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785292C029F;
	Wed, 24 Sep 2025 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4g6iOFo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25527991E;
	Wed, 24 Sep 2025 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757503; cv=none; b=tJATXIiqnIwwYEj9/SW1HrPB4x6+f5jQX7xS7uiE/3zEbkKVpY6s2RPfGyNRlGx9tS2ZDU/f+i6aFet1WMVnYyQ6/GJV9rynaPwnME6t55plO29uXZkrEzS7+Y2HBv/nNtwXjaZUXQnkrWjnIcu57csqJus95MGoUhMQeEzwgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757503; c=relaxed/simple;
	bh=/ykIodAqhb0Bl6bMCnLbgZ8U4VST8ZzssJpV16F1hnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGN+2D6OUrmwiB/Ex4kMwbRdbaEImKSVZ/DhiNQ6ko9kAdT+liX5t/djBxm4n5Pz2Yy+Xcxve3eGlqjWsnCu5IUB4E/p0jX6qkH4/ZIHIF9LWQLcAYql30Z/0jh4BdTClzM+pXZ4BnwejQZKld3xSOjMlKDlPepIGIOd0/9k73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4g6iOFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6F8C4CEE7;
	Wed, 24 Sep 2025 23:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758757502;
	bh=/ykIodAqhb0Bl6bMCnLbgZ8U4VST8ZzssJpV16F1hnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4g6iOFoT6zBg59LLJk28blUXjC7uaoH1ZE9d6UJdvVPPgG4tQwKaoI/R8oywJ9L5
	 /2ZeuaMMEmlnqy44YwDXSp6Ssu3jHSPn+9k28fzJziYihPiF1FbCE/AHtNbZnyUO/s
	 J32dJmW8K2jJ6YjP8oI6/XANKoJSPI4R/pOJW2bN8iRU69UWQyPuojXmkJGvCNF8AI
	 zWQqS7s6hbz/kz8K9yK5jx+Dh4NNC/ftp2egJYeZUATEbDnIouvql5Nk72FWpdzBjp
	 nkzNQgveFFxB9vhD5yH1raMbbxxT7DctPZCVHTf/5Y+es6AAfeOaIYSWQvPykOaWlL
	 G/8e/p2fxtAUQ==
Date: Wed, 24 Sep 2025 16:45:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, pwn9uin@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
Message-ID: <20250924164501.23f6e708@kernel.org>
In-Reply-To: <20250924184451.GT836419@horms.kernel.org>
References: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>
	<20250924184451.GT836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 19:44:51 +0100 Simon Horman wrote:
> The preferred coding style is:
> 
> 		if (mpc == NULL) {

Or better still:

		if (!mpc)

we tend to avoid comparisons to zero and NULL.

