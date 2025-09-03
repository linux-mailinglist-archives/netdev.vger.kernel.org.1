Return-Path: <netdev+bounces-219726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B7B42CD2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB616FFEE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27EA29827E;
	Wed,  3 Sep 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eELu2PMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56833E7
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938769; cv=none; b=Vyz9R6jmgCCQzqTtrimm64D6n7jhx+goH1a7PNJQN9vFh0JMmJJ3/BHddS6zBzHUYDMp5sfqYLjtFdyT1ec3ABMfgsYybP96bBvwM7plqfIz+2a3TRmL58aSSCbVJDcNOKoxpiBOjCuaTa2w3rQipX3pbjuaU01StQTybkHAlw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938769; c=relaxed/simple;
	bh=AKFHjOk3ctVAC25MwBoGS1g9JJM+WMO89RZ3M5N330Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uce+Pouts4GNAA0zVak86XhdgZLXLkkRLOJ20YV2YGicqylO30dqLGrtCCGkRyM5/8Fq89wsCG1VYLOVUonjdGk0eEdxK0S3slbott5ysSJ5ij5zad27RloQpiACq7rd1kbeI7uNJhMIxECF674XjJqHjWVzdv6emOtz0kcSJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eELu2PMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606DCC4CEE7;
	Wed,  3 Sep 2025 22:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756938769;
	bh=AKFHjOk3ctVAC25MwBoGS1g9JJM+WMO89RZ3M5N330Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eELu2PMIAzouMCPf9/UCTgN/OgBd0+P12ldgF8MjpMq0+vZoUXKGd/oD2PjTV/LII
	 zjftWhYc5R27Zi8cwmdkN4G+4u9l3hsFgasWd8T7o5pGMcZnZy4kuAVnFJM1xfw+OY
	 TcddSr3XP5heZv9B8xfa01RoMyMRa/9RxMQd4OVHE26fZTkfS0jj2CIsWOOk21dUUt
	 3ROdTppo04ZlGj41J8j92R+wAnh4CHz2Q/9QZBhl0+kxInpmxgvbB5j+BgzjlgAbcw
	 2VZcYv/Qx4qEPTCBrM7VGzotCyFfsOo+lUFoqJKY5NK9sQG8trsQeIm5rr0RHUYtu+
	 SqipBS5xbsLqw==
Date: Wed, 3 Sep 2025 15:32:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 00/19] add basic PSP encryption for TCP
 connections
Message-ID: <20250903153247.0e488b5e@kernel.org>
In-Reply-To: <aLesMHHTHWtbbugi@x130>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
	<aLdIUZbwF83DbUiv@x130>
	<20250902130836.65e4af41@kernel.org>
	<aLesMHHTHWtbbugi@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 19:47:12 -0700 Saeed Mahameed wrote:
> On 02 Sep 13:08, Jakub Kicinski wrote:
> >On Tue, 2 Sep 2025 12:41:05 -0700 Saeed Mahameed wrote:  
> >> Also As Jakub pointed out on V7, mlx5_ifc changes need to be separated into
> >> own patch, "net/mlx5e: Support PSP offload functionality" need to split at
> >> the point where we cache ps caps on driver load, so main.c and mlx5_if.c in
> >> that patch have to go into own patch and then pulled into mlx5-next branch
> >> to avoid any conflict. Let me know if you need any assistance.  
> >
> > Could you take the ifc.h changes as one patch into mlx5-next and send
> > a PR, ASAP?  
> 
> Sure, later tonight, if not, then tomorrow morning.

Pulled, thank you!

