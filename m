Return-Path: <netdev+bounces-186199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D7A9D6C6
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D77A7B49C2
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F51E3DD7;
	Sat, 26 Apr 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT0t54mt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFC6F53E
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745628173; cv=none; b=IsgrudzHlmYEageCjLDNzsFN/paj5H1XFFi7nH8OX2B2DDutF3Rk1jnJJlN5pR+XWZSIVOxzwC1bOnm1+p8KzHzbEH3O1CRaPfUNEr0X3/woHLuu7FxTgv5YGeDYVZdGEqPlmyq0t8YMtLTZsgfKYEsMAYWIsiBVHAWc/fNPu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745628173; c=relaxed/simple;
	bh=z+jlaHeemS6e93Y4MMSsAKTdJd2Qa2V9sn+CCVxxRJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW6nTVIo++5aLflJGAmqONGvvvL+YiIb1kblvx7DRQdVqrFdwX1Ep7tjyO8p3q565tHp/PJjdMni9qSOMCQ2jUnDd8T0jqnz9mrgSo2grip5pkgaZsN3rztCpOuZGSYnuJ5WNyRdO7aLOfOCP1NugQp9bq1NnRkUpeI9b6Gf50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT0t54mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EEBC4CEE4;
	Sat, 26 Apr 2025 00:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745628172;
	bh=z+jlaHeemS6e93Y4MMSsAKTdJd2Qa2V9sn+CCVxxRJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tT0t54mtbYa1r1yfqxkuAozesDizGWLCgo32AAp7uM7s4vR5ItnwsWYBu5EIGi5I/
	 jMfpph+hpSGcr/FIMDX/CU9BpVW1EjQYyeXXdhcJ6fpnrCNgHr9pEefYTM2SBfeF1o
	 jo4JQomlISTugcwfu3C8Q/ffu0/lv35qZHE6xcjhvQMyIYVN/+18QXign2uvkEL4b4
	 QJnNBkuByK/YuA3EvPnVWPZrMRCdmbMflFiNOKKbuehzbAiycPyC33t5OzwSFt1j6z
	 Im8gIxMohOlJSC+iYN5o4bv4xRh9OGusD06jY6kTYTYeccv2K/r53ic2ZfoN/680wl
	 QDmOq3RsTt+ew==
Date: Fri, 25 Apr 2025 17:42:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250425174251.59d7a45d@kernel.org>
In-Reply-To: <20250423201413.1564527-1-skhawaja@google.com>
References: <20250423201413.1564527-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 20:14:13 +0000 Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a napi
> context.

I think I haven't replied to you on the config recommendation about
how global vs per-object config should behave. I implemented the
suggested scheme for rx-buf-len to make sure its not a crazy ask:
https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/
and I do like it more.

Joe, Stanislav and Mina all read that series and are CCed here.
What do y'all think? Should we make the threaded config work like
the rx-buf-len, if user sets it on a NAPI it takes precedence
over global config? Or stick to the simplistic thing of last
write wins?

