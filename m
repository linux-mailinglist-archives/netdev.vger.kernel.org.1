Return-Path: <netdev+bounces-87191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B138A20EB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE251C22BA4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAC3717B;
	Thu, 11 Apr 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioHXflM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EC524C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871037; cv=none; b=UeGtv3fpiT8UNXV9mP648gQDZCkhoH9p6oppa4K2d+0YEVvFKleUZhqWVWCPiy/Z2tGAW5i0LGA2PIGmci589u22VSCnwrSCp/7NuKJjFsSXA3CJIp1QZwH+UDxcmMm8+b0dTuean9ngmZcLi3Or+D3tDh9Zzxaza9+YGMnIzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871037; c=relaxed/simple;
	bh=rw/OK3NbCiBmqbHtj0VrSr+yszThCqMeBvz0TC4fH/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNmHxPaZjrgMA1DCE4cnpxU4dCq9toKQa2zZm4TokZ4S/van6PdL2AkG8lspdDbdxaTy1uVylDyKvUWy+3Y1RLFdOl7DTsKwcKWiI3vFem884/a3WSw4Bc8ms6temKsveihKKDKhdmUcwQmXoAT8XWIMShLfQAai42QE8zfa85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioHXflM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F810C072AA;
	Thu, 11 Apr 2024 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712871036;
	bh=rw/OK3NbCiBmqbHtj0VrSr+yszThCqMeBvz0TC4fH/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ioHXflM/OcHtQa6P+vIFsvAtSJqgQGQ38cuw+ksdCqeJuu0+Hvoh317g752EYMsVF
	 u8dpHTRYsihxiRE6cx8f4g4dGs9NCgn9xY/bVNk7mQYuTtY3hGQQcz18hk31xS+mcj
	 PslKu7lw2WecEnuJnsaEo9DKnI0EfFyaxGQ5uaFrJ6/macdBuNWM06rHrViBgGczOJ
	 mOzZ+9SKa6XZiF6YR5VAHHO164LH2/x2g81GoNrvcdrTNOPbsUVWUdo32ujGmCSrZy
	 w99XQOCFx7s77ed+c6tnepIGIwKYAeh0myMP0am8tDNI1mo1kLuRAZ9fswBUlUoZVH
	 XrjKlq51BjRXg==
Date: Thu, 11 Apr 2024 14:30:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <mhal@rbox.co>, <davem@davemloft.net>, <edumazet@google.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v2] af_unix: Fix garbage collector racing against
 connect()
Message-ID: <20240411143035.737d2d33@kernel.org>
In-Reply-To: <20240409232700.61277-1-kuniyu@amazon.com>
References: <20240409201047.1032217-1-mhal@rbox.co>
	<20240409232700.61277-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 16:26:59 -0700 Kuniyuki Iwashima wrote:
> > Fixes: 1fd05ba5a2f2 ("[AF_UNIX]: Rewrite garbage collector, fixes race.")
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>  
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Hi Kuniyuki! This problem goes away with your GC rework in net-next,
right? I should keep the net-next code when merging?

