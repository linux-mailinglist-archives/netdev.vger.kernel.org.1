Return-Path: <netdev+bounces-159508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19DA15AD3
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E5188940B
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA6EEA9;
	Sat, 18 Jan 2025 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTDe7hZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFF40849
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163487; cv=none; b=OsgJnbP7LlVDXdIoSOg75DsjQND1aqfIWh/7hHZlu3Us0EkvNoZc0v1eXzY0TXBDxTCDseXUV4hPAHECZQ9BfJ2JXYMKOg4CcOn0G2264+JMhLac4jzlfeyCmqZvv8tfzHicNnWRxOG8N0liyJQIhPwTJUrfQ6uZBqBX1uJthbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163487; c=relaxed/simple;
	bh=TkFXNm4KXGU9rL5ppRUNmsN5Coll6+nI2t+qjppw410=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cvd8b8JWxUH7NBaTsA8maNvAyF9OtXgnNFJISRQIXWXRgCsLisgvc5jjVLUMWKYSGYTgmnTOZK/Jp+nlnn73RcVQXSB8Uhsj+Nh0LPrf0Nqw/1aJmD1MV+6rtU7MjwG9lTaP0DuO6mnZ1XC/OyXdwHQ2YIjV3Iti4RdWK9B65EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTDe7hZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B19C4CEDD;
	Sat, 18 Jan 2025 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737163486;
	bh=TkFXNm4KXGU9rL5ppRUNmsN5Coll6+nI2t+qjppw410=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qTDe7hZF6Llf7TbtzY0347Xf77g+D4lLaVTKtEbLMfAdF/WikEU3hBC5rpVHOYNpx
	 e3FQQw8hzCDZRPtnPBUtMzFSst4bP/3e6PU5OFTHu0AIOm8X9CwusYCZTZhF+qPPH/
	 r3xBX0nWR0m7sVRhPqlIbzaBb4uMg385ZAYp3UuF8gAuhykomodzQ9riaEcJF0/Nb+
	 LyuNhWz6Juo+mTSCOy4FHpL2GzMgJVxMSdtEj5mlI/ymgjXAhSH2NFeZSlDGsW3/g0
	 KYvQM41c4KN2FXhfwjUzaAlJj2b90M1YX/6T7SjnwRTvVabB18PCXkTaTD1aKjuMGD
	 0hGRZFn4J3piw==
Date: Fri, 17 Jan 2025 17:24:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: introduce netdev_napi_exit()
Message-ID: <20250117172445.7719a86b@kernel.org>
In-Reply-To: <20250117232113.1612899-1-edumazet@google.com>
References: <20250117232113.1612899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 23:21:13 +0000 Eric Dumazet wrote:
> After 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
> it makes sense to iterate through dev->napi_list while holding
> the device lock.
> 
> Also call synchronize_net() at most one time.

I suspected you may send this :)

I was wondering whether we have to call sync_rcu() at all, Joe moved
unhashing the NAPI to napi_disable(). Assuming the driver is sane 
it will call napi_disable() at latest in ndo_uninit(), and there's
already a synchronize_net() between ndo_uninit() and free.

But maybe drivers are not sane. We don't have

	/* napi_disable() sets the SCHED bit */
	WARN_ON(!test_bit(NAPI_STATE_SCHED, &val));

in netif_napi_del(). I think we should add it, after Joe's changes
if driver doesn't disable the napi it will leave a stale pointer
in the hash table.

In any case, your change makes sense:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

