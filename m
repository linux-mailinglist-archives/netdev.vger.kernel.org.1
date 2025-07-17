Return-Path: <netdev+bounces-207864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD041B08D44
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB8AA43D47
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8F2D4B47;
	Thu, 17 Jul 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFxsa7FO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFE2D46B3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756246; cv=none; b=gd4Vxp2exYB7a8N4HMjCYnbjDX4v5dXwtXLpGlb9ZozD0M7VA68/PMDmu2vBT36Be+AWCTnQp0bhAUrSCXuyM+4gtHdw5RUUrdWE8xZVgTkRb9eDaeDs2qZe0rrMqDVu7fIOznK8+c3IKzKYtjVZ4zDaSQKyU/XFgiQ/p7N3ArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756246; c=relaxed/simple;
	bh=uuXD6SnotlE3ZAtdByhh03tp3skU1BwGpFoYpxE08jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO/KNq/jF6KKh6QvwcG95Wgov7tOlTO60dhKLIbqMwaxzxFPsQtW+0cZhsDoAz5Uu5V8v+RpCKULZNvzKULb6S/82ChzrhUxcCOccmHH1dT8VN7wbPaMF8RYBWTFkAKOJZyyDNdUQv2DBBQpYbXSUkSRmsO8ocdFlFGIApbGXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFxsa7FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D5C4CEE3;
	Thu, 17 Jul 2025 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752756246;
	bh=uuXD6SnotlE3ZAtdByhh03tp3skU1BwGpFoYpxE08jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFxsa7FOqgSSAr8tVLp9tBFRMMuTE2gbT4tjaBfRVzlATlXC7TI7V8p1V34/W3lkv
	 JZPK9A5O2xn+ecWCTPsfjIT2NzyNVhgFHM1M0zDGeBGF1p5226z8zozBqTcMZafpeC
	 3ocjg7klDBWmCNgNF5X+MX6U1HtVZ5y8pAjWW3FoOfI1JNjl+NsUU4MfVyCjCtK3AI
	 VxNvyH7zkPHw4pCsqZIr1NFr9/BF/5APiEHCjbg+QbKc8pPaFnRoqTnlYi381TtOYN
	 OK7DoMtrPdOS0xXA9RsjJ088lvXpthTBwZ3hfC2zSbAwav9KGZae2yg/h3OYzfWnyp
	 ifIsGKRPjYYGQ==
Date: Thu, 17 Jul 2025 13:43:59 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/19] add basic PSP encryption for TCP
 connections
Message-ID: <20250717124359.GF27043@horms.kernel.org>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>

On Wed, Jul 16, 2025 at 07:45:21AM -0700, Daniel Zahka wrote:
> This is v4 of the PSP RFC [1] posted by Jakub Kicinski one year
> ago. General developments since v1 include a fork of packetdrill [2]
> with support for PSP added, as well as some test cases, and an
> implementation of PSP key exchange and connection upgrade [3]
> integrated into the fbthrift RPC library. Both [2] and [3] have been
> tested on server platforms with PSP-capable CX7 NICs. Below is the
> cover letter from the original RFC:
> 
> Add support for PSP encryption of TCP connections.

Hi Daniel,

This is much more of an observation than a review:

Unfortunately this patchset did not apply cleanly to net-next
at the time it was posted. This is a requirement for our CI.
So at least one more revision will be needed to address that.

-- 
pw-bot: changes-requested

