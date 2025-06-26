Return-Path: <netdev+bounces-201576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ADCAE9F5D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BF74A5BFB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD52E7189;
	Thu, 26 Jun 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH3ZYAG6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07B2E7173
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945774; cv=none; b=trX4RS2j9M/H6GK70g9sMEP2d2NNUdUHkduKiEBDDSkNKZXOg0wg2jEtOPK06hdY4GVme1SJQGXAQJPKVIbTvscqPsgIo1KVPiC7KhTnJCD1Rr+kIzVUmlpmHajneLpIDE7ukSpN4L4g6NHx8+Td5OHYSPZYX/z1ZuKuY2HcXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945774; c=relaxed/simple;
	bh=DoGAv9lcM7hRc3Ufwb92w0PGYMgc55+Hn97OwIclCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVhQIGTRup14GMBFzqVtWfv6cixuFIp5BcKsg4XBHB5f5of15L3JVyLdTaKiIyVqJMXUudAPl28wxYwkUZEVoCiiAQCdz/Y7tHBIHrAnjRc+sSh+NkkCWnHMvk+zKv2H7FEuxB7O9PTKK5jLzmqAz3IhRkeI928nKIpNCLlsZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH3ZYAG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB87C4CEEB;
	Thu, 26 Jun 2025 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750945774;
	bh=DoGAv9lcM7hRc3Ufwb92w0PGYMgc55+Hn97OwIclCpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GH3ZYAG6jlTOrdY0n5hme+tBHViSXxaibfNkYjdTCutzX1kPYi6f6IbuZsTrt/UbK
	 8aGcZaJKChDU6VqkffcdekbBY/inwDbMpb8UaxMCK9+frm70C2YI4t4a3IDq7a6fjI
	 Fxx0uMOzx8oIxOTqTPo9ri/TD0arS1Ofckgur0db11qmZmvC52fQIwFGijEHI6PJmC
	 XYPq6c4xWQ7J3Ar4ynHl7lt69JLT/CcjoPVmhhFkiuzFSbMkuDRQbUHon2uwmA36WO
	 6sojIwwUQDJ/VbBe1hH+rH+p2kfwzswpJhmyIVmZ1cGReYjWYJnYcwoUaIm2L4XD23
	 Hmp76TFWrsAqg==
Date: Thu, 26 Jun 2025 06:49:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Donald Hunter
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
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/17] psp: add documentation
Message-ID: <20250626064932.1be18542@kernel.org>
In-Reply-To: <edaa7ae7-87f3-4566-b196-49c3ec97ed7d@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
	<20250625135210.2975231-2-daniel.zahka@gmail.com>
	<685c89596e525_2a5da429467@willemb.c.googlers.com.notmuch>
	<edaa7ae7-87f3-4566-b196-49c3ec97ed7d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 07:55:34 -0400 Daniel Zahka wrote:
> >> +after ``psp-versions-ena`` has been disabled. User may also disable
> >> +``psp-versions-ena`` while there are active associations, which will
> >> +break all PSP Rx processing.
> >> +
> >> +Drivers are expected to ensure that device key is usable upon init
> >> +(working keys can be allocated), and that no duplicate keys may be generated
> >> +(reuse of SPI without key rotation). Drivers may achieve this by rotating
> >> +keys twice before registering the PSP device.  
> > Since the device returns a { session_key, spi } pair, risk of reuse
> > is purely in firmware.

I don't think this is a requirement put forward in the spec?
Specifically if a device wants to allow partitioning of the SPI
space it may let the host pick the SPI. To me the device allocating 
the SPIs seemed more like a convenience thing that a security feature
to prevent reuse.

> > I don't follow the need for the extra double rotation.
> 
> Indeed that last sentence is superfluous. Re-initializing a device 
> shouldn't leave a device key from a previous initialization, while 
> resetting the spi space. If something like that were possible, it should 
> probably be obvious to the driver writer to do something like double 
> rotate the keys.

