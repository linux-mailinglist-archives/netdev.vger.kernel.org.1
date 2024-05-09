Return-Path: <netdev+bounces-94907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C091A8C0F80
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5633F283611
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC914B963;
	Thu,  9 May 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA31DIYw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48D14B95C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257147; cv=none; b=Ojqes2PI1dBp0NQxGhcoHZhy8yEqc1DnUcwqWiYjz60A11RkZZu9RV516eVyBsJvgbu1lRmjA3yyHGxls/ToGPvRNVg1ufnw3oHXpEQUbEIwm+doHAFfkH9l/i+L5KQWezMTNWs2KDtx9/jhKocsHWprvn4b679SE5jEhgKydcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257147; c=relaxed/simple;
	bh=QstXnYS0JopeKxfu1qMjw8x7buBvKTejHVWAUqD8HoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJK+bst/G2UV7p9s7fcZ7iUgVu1PHnTEmVoqZpk4tCQU/o24YU0UjD/0EMePnCWTfKsthI8XyhySdRtQv3Zk0Q/hv11sEiDD6pCUQoJnGMUziRUyIqWLqXY6wuA7ud/oGUGoqOJFkMtUQpkjiKU9ovjmZaePFGlAQ+M3uoPa/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA31DIYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B812C116B1;
	Thu,  9 May 2024 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715257147;
	bh=QstXnYS0JopeKxfu1qMjw8x7buBvKTejHVWAUqD8HoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FA31DIYw/0smGmh8N+4b9Pg6vEyQ4V7IVEZ7AGuPh21c1WYMBaoag7k00mZghw0Ew
	 SoaffORucBVvftPOjrLDQG3gtu/G0etQDVZIiwhhyst7WMpjBgjGYbqiWYS6FZUR6K
	 9YCMbInb/AM90SmUc5Fh/oW2mjuwAOSyOBmbkMc6DQxc20lzB+2fomE19dupcIrkkp
	 7A7wSJO3jyxHEQ3+H7S+uV0sD4cML1EI/YLWk4v7+oiit+uwX23hTfenFA4p2wx/t+
	 TJYpeSBD4p6Ea8SOF/5CznOslGo0eDkg+BDBUwmzmuUYjDQhj1P8+qIVQuuAjpd0HX
	 0OqFYRQC4yIHA==
Date: Thu, 9 May 2024 13:19:03 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 12/12] gtp: identify tunnel via GTP device +
 GTP version + TEID + family
Message-ID: <20240509121903.GV1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-13-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-13-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:51AM +0200, Pablo Neira Ayuso wrote:
> This allows to define a GTP tunnel for dual stack MS/UE with both IPv4
> and IPv6 addresses while using the same TEID via two PDP context
> objects.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


