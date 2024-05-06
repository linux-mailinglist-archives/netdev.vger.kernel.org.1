Return-Path: <netdev+bounces-93820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832B8BD48E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C973B1C20F72
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33415885E;
	Mon,  6 May 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2echNGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65B197
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020005; cv=none; b=Y29004YjvddyDNmdXTpBrQ0B/i/p7BXeLX7QK9GpjxodOrP3GtyliFjUjHQhfA8WE5ej9GlStButp9YA0oqYv0swuARZIta5JKAPAefkqj1onrK7N0mnT9kt1aKADjaas5HpONt1wKtBahocw24O2X4D3NbWBEKEvuCYFhKId2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020005; c=relaxed/simple;
	bh=Em6TwdJYY+t6qMpMzCkW4vcPeCcSzeqEa7YwkzTNEgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e94CAbFb487D+sv1EzPh8uy9/m8SrMHeObr8HCSIxFkpJ5C2EKCFZLkyrw0um8mmnQyuXfMs2bp97wrhLkgasL+8ke4ppkz/Om2xmEMKC7/cvRZvsnaAgaNeXbRWr3JYAAFsVnUsKPkzrX+AoFoZlFiyfvF3auMLhjF+PCXvqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2echNGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC28C116B1;
	Mon,  6 May 2024 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715020004;
	bh=Em6TwdJYY+t6qMpMzCkW4vcPeCcSzeqEa7YwkzTNEgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2echNGsUSH9Mzglr3Oji0JjgqcWSSfxqlpDc4/FMfkL70EVP5sePTvMSN1E8kIsN
	 Udh8CZ28IwtztQ0JrrdcGQhSTdLEeW4EnG1JKI8nM76O4OCVjYqSxj8QC2EAckVAB4
	 nbl4d4OTB+nfGZTF3rcODa1Rn/bddUozL82tVGhtVSvn6QTwt+QXINiUhm2j3yGbn+
	 oNmuYdiIDMXMoM8ZYX5odI5E+tiXrSQzA53Tbf9G6pAghuCfa69x73ICrLvoRdyXVf
	 P7Db7+qW6HYo7058BkoOtrWgK0iTyGTiQdsl8y8piplY7UEpBLff+vZ6Mhwuz+Qwfo
	 2+s89GZ5pW3Gw==
Date: Mon, 6 May 2024 11:26:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Remi
 Denis-Courmont <courmisch@gmail.com>
Subject: Re: [PATCH net-next] phonet: no longer hold RTNL in route_dumpit()
Message-ID: <20240506112643.43c63b69@kernel.org>
In-Reply-To: <20240506121156.3180991-1-edumazet@google.com>
References: <20240506121156.3180991-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 12:11:56 +0000 Eric Dumazet wrote:
> +		if (err < 0)
> +			break;;

coccicheck says:

net/phonet/pn_netlink.c:280:9-10: Unneeded semicolon
-- 
pw-bot: cr

