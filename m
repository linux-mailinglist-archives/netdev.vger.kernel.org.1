Return-Path: <netdev+bounces-204704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6749EAFBD5E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D725189C8B4
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07B285C8F;
	Mon,  7 Jul 2025 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ4KZ2YT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1E1B4236
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923216; cv=none; b=tA/2cmlqS0raA9kAkt2nzwX4BmIq9tdP29LgeSqROlny0vJcOWSlfzdVMSwedDvxzhDhhboSsYFKv+R/tLGg61rYwDRxjsArX0bM0K7NGtpfcy1lwldojwaCiXYUUv2n+wrr+WHfxPAjWcXegFkbhnrSyl/mn67/r30fYUqDl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923216; c=relaxed/simple;
	bh=zOsbUGbUwRnbN317T3bQj5XiIW5RAFcX7vgDw2/vTHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUjufKszN67/5gL664v3C5F9qJruZan7DIz4TwQ18E/qC6xMjqEQe9bzR2kfpWTHR2QgY3bt7MD+GA/cMjUzmnZ8FJOZgl6zK83IvOZSrjBL8m6Vve6p1IC8QgP3bYVJqSOOC9xE8zpN+FEkLJp81KQe1TFS3oU3vnzAgpvqhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ4KZ2YT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75ACC4CEE3;
	Mon,  7 Jul 2025 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923215;
	bh=zOsbUGbUwRnbN317T3bQj5XiIW5RAFcX7vgDw2/vTHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQ4KZ2YTNmJqfKxyaGObFlZ2Qmw3VSiSdUzbPb8SfmdJjRxk8vn3npjEp6+L787ke
	 pqOGZoCambWQI/CWndCVb8YcpuCcDSp6N9kgpnd5AZ8qelrACBi9SqSWYXIYa1xut1
	 Cw/qiZybe6bpaYX9fLDqCLSCXVIVDzdyEoFdYWfcldkmOtjv36SkAqLj0dD7P1phKG
	 s0Xy0LOpvh7K5V60dKi2o4ebd2UQ8Trjs8nSIFgbQeTdGSR3pYrAl9lEyWPx+ze04h
	 gFcAOiQqBBWIWyDPbSYHY30ZqpTqGN3Jb/Uf956SiCHdA/vgcUNeVxknq9oWTRKoV7
	 myOjldjONLb1A==
Date: Mon, 7 Jul 2025 14:20:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern
 <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, Patrisious
 Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Rahul
 Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/19] net: psp: add socket security association code
Message-ID: <20250707142014.4629f9d6@kernel.org>
In-Reply-To: <20250702171326.3265825-9-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	<20250702171326.3265825-9-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 10:13:13 -0700 Daniel Zahka wrote:
> +EXPORT_IPV6_MOD_GPL(psp_reply_set_decrypted)

Please make sure it passes an allmodconfig build
-- 
pw-bot: cr

