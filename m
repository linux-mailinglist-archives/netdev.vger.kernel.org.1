Return-Path: <netdev+bounces-144678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003169C817F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA2A1F2415E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88321E7C11;
	Thu, 14 Nov 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GagJbptv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37DF1CCEE0
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554965; cv=none; b=Nn9wu/ZN41UUo09m/17lYDj3PXeVlM4nEoGradnBSHfmq7v7kSJZpk+0CcAdskFDDqstvPhbxnhO8zb3U1UD18MntLNSNYztlMESxlL4qenucB0WhpFuDgmGqIkt2kbtoe48gIx1lGAMZgwSlr5Oa7sIR5LqxJVv0jQYlN9XSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554965; c=relaxed/simple;
	bh=nCepui+kqrFl6kmYkPfbtY32xjkFGpz9a3cuT1618zE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVOpTVFg3mFyNglxSlcyuyB386E7NXHoIMyMbP1imuQ0r06nHj88LYlecPdFc1i3IXywmZ+w9hOT4H4CeWzSw0aEgA0AW/kcS961JIeOKWXDKX3Ib7gZFbYJ0EZtlX8w28Ho4RhybuEG8e3HDrusYMv+5OnuazZAtqeGZdBwuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GagJbptv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26685C4CEC3;
	Thu, 14 Nov 2024 03:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731554965;
	bh=nCepui+kqrFl6kmYkPfbtY32xjkFGpz9a3cuT1618zE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GagJbptvtukA6WieSEonNlLmSg0fuhreb/FBUQmby1hI9Dtulp7XqhoxFc1AoIXmo
	 G+fbO9DdWDMAU9Ig9W3ZF1+47A3w9eVFmmn7+fHlLs2lJNDr5B/tyP7OwSlbNzulva
	 uvO7GbqNUUtrsJCvrSSBGFVsz0yzSob5J+WFqFXKa3c3j8uPn4z9ADAqadrKlz9tkL
	 xY7wCvsB5Q6sE7UPeqaHDleX/Zvjdqc8PSDt0/FwJ38ZJkXUP79XAYvEX5O1kp+M5+
	 CF3KGDIX0I5/90F7qx5vJZqbHvkNo8varSkp71ISqb3E8PGjMdRwL/TYC6xH6bh3+F
	 1L9vf367NwDdA==
Date: Wed, 13 Nov 2024 19:29:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: Make copy_safe_from_sockptr() match
 documentation
Message-ID: <20241113192924.4f931147@kernel.org>
In-Reply-To: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
References: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 00:17:34 +0100 Michal Luczaj wrote:
> copy_safe_from_sockptr()
>   return copy_from_sockptr()
>     return copy_from_sockptr_offset()
>       return copy_from_user()
> 
> copy_from_user() does not return an error on fault. Instead, it returns a
> number of bytes that were not copied. Have it handled.
> 
> Fixes: 6309863b31dd ("net: add copy_safe_from_sockptr() helper")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Patch has a side effect: it un-breaks garbage input handling of
> nfc_llcp_setsockopt() and mISDN's data_sock_setsockopt().

I'll move this to the commit message, it's important.

Are you planning to scan callers of copy_from_sockptr() ?
I looked at 3 callers who save the return value, 2 of them are buggy :S

