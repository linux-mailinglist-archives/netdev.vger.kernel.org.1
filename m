Return-Path: <netdev+bounces-181840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBECFA86903
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC05F1BA6D1D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132EA27CB2E;
	Fri, 11 Apr 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN6jQw7V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28C2F5A;
	Fri, 11 Apr 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412466; cv=none; b=MGZ9s39pUt+5HDfeGIez/krHYa3fAyEhDzsjXSxF13Ks2U8hAwtoTBG78qOl5GqRoHLdsi2wWb5JAaCXWXFGZRUxTTuITeU6hOPryxh4vUPHF9eHRMGDqJcorZv5R436rUd4lL+RkZhifrCPvOewfenWP/J4yXsqHUMbb7QRIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412466; c=relaxed/simple;
	bh=VzEcjbo2Os088oE9MH3nvwy/0mOPUOWhfvQwP8QlBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9xAHEPnuQalP82BhGTEkpauk9b6Jz9InOiTFLhX3/UmhfeyLXnmLmUIJ3Gpy9Dx5LteaSQQy6WlWYeZEVabvo90DTW5vuMT1trWxJQcsZdErTK7xAneJ0gFzHO7HjrCyc5aWRYbaxxyIV1Q45G43EDasep0hU6FI8CSgNJ6Ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN6jQw7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A4C4CEE2;
	Fri, 11 Apr 2025 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744412465;
	bh=VzEcjbo2Os088oE9MH3nvwy/0mOPUOWhfvQwP8QlBfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CN6jQw7VK69Bfmn7bvDvUu9pWY/0nPp1Y+Vh9rhYvwQIDtgtBJB78JMTb+O90EOHv
	 YPEDHcdeY51S8Zx1akf0kh+lVHCA3I1qPYH9EBP+vLWHrH72vxt6JpMVXd9vdvjjP4
	 8cubLr/Vb115h+NM7LZpVqaH8GINj9hvMx3hMK/KFHpaxDusQBn31Pg6mA0blVoAOw
	 t69XEEi7GQRfX25SkbTDhZjd13fvDAER6NuFBaUUoMGC4TTyrOXAYXUCiJqSXFFVu4
	 qKntuxmttGUH75tljT8GdFA5wHToiVS6OPLjMqKvxPJdKpyeR16Lmq8l/LIqkQxOHi
	 aq5Tpb+Z/sT0g==
Date: Fri, 11 Apr 2025 16:01:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] netlink: Introduce nlmsg_payload helper
Message-ID: <20250411160104.79b61fe8@kernel.org>
In-Reply-To: <20250411-nlmsg-v1-1-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
	<20250411-nlmsg-v1-1-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 10:00:48 -0700 Breno Leitao wrote:
> +/**
> + * nlmsg_payload - message payload if the data fits in the len
> + * @nlh: netlink message header
> + * @len: struct length
> + */

W=1 now warns about the lack of Return: statements and we return 
the pointer here. We gotta add it to the kdoc.

With that fixed:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: cr

