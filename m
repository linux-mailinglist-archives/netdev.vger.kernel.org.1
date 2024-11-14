Return-Path: <netdev+bounces-144655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A79C80FF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1642281111
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40560B8A;
	Thu, 14 Nov 2024 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmj28HLf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FB6AAD;
	Thu, 14 Nov 2024 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552457; cv=none; b=cThrSj/akN3N0QgUgfQoD6YfywZ35bRTOQukCOfMo12rqUQl8bY8915TI815UXsSqI5/5duAt4MZlieXztigakVlJE8BN88oYI7cZkI1Nvc2hNtTRiE4QdT3vO9Kwc6G1PZf3pjw+Zx6uVnhFFtvoBPH2D2vKkTJY/LAbP4u/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552457; c=relaxed/simple;
	bh=ckLeLN0G88iRttmSUjcB3Pw3BO4IJmRq3+6rgv4qs5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZkjsPd8hvIyo0IMk1/uD4kGnq2Ts/+PLM+jou2WanvcvHGL76SUQ5RCNWZ5zX83rsKfz+xmOku4CsrOuw9rlcFZf9uqgPUSxJRw6KCd115CVQt7AQVLoUdSWknhWsu4bIhE6d1s7nuTtItpKZjsZjh6e+6cxI1La8qSU/6lKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmj28HLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BCC4CEC3;
	Thu, 14 Nov 2024 02:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731552457;
	bh=ckLeLN0G88iRttmSUjcB3Pw3BO4IJmRq3+6rgv4qs5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmj28HLf2QpcYxrxbQA7zRQk5binGaFoBuytF5qnLreolqhpO4yyyAPnrrL3zGmWz
	 xCfYXGE+wHNrYYmMFy6jnDGYd07TgqHOXf9ghcBpRiZmYizXb5JK7i+XquC/1IN6Ju
	 o46HbzbRKtgfTjDH5vcOjLKwz2XTTqKJ5K9RTpy0SUoaLYXjgM+5SEAhAh3UfXDNoh
	 HrzYEIdiLZDbe/5+w8+EQ/eiLt0guV8N8tXOcgZEtEIi1Ef7EK6AEypUt3c4EdJTrA
	 86UJgAVcFo2nAsKTzGQS+0kUO9V/NJlSStPD3s+VebOvMmi3xMWQqEk88FceEVeUjv
	 5Q6Tin2UnuHzg==
Date: Wed, 13 Nov 2024 18:47:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org (open list), Mina Almasry
 <almasrymina@google.com>, Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <20241113184735.28416e41@kernel.org>
In-Reply-To: <20241113021755.11125-1-jdamato@fastly.com>
References: <20241113021755.11125-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 02:17:50 +0000 Joe Damato wrote:
> base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5

which is a net-next commit.. please rebase on net

