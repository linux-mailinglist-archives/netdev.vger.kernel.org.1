Return-Path: <netdev+bounces-114352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191F94242F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7C6B23BC1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D1946C;
	Wed, 31 Jul 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPatpXvW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C45846F;
	Wed, 31 Jul 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389824; cv=none; b=jUxEmWdwllIR1uYQWMYyJQInvG07NpQcjhr13inju5zw3zFVf/igNy1fBIfKxxDnqGgj6D1YMii2IEOBGd/enproQYOhUIpXxHzUXz4DYgsPLBs/gd5gBwmQbazrF3kHXPufvX2bO2CAmq2QXg5MDJF4KADumWX7sSYmIqGnlb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389824; c=relaxed/simple;
	bh=CcdjNvG3XqqMvc9DEUr9pWwmF88N3sVGIUbyRy0goC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfDHiLmDdO5OPgvsayjEy2cihH/MZ+/dsRAuvXntRSs9d3mrVpkuW621a5XAPdPnJgypjBL+u7Iw8vt3XIXaeyXMTxx25Fd7PhyYXSMNd5EiUF0xEvS5JasWMtkDxU4WOW5aoN3kJH3GtE014P6Jd79E0mGP7+lvlhqPkabvDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPatpXvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8769AC32782;
	Wed, 31 Jul 2024 01:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722389824;
	bh=CcdjNvG3XqqMvc9DEUr9pWwmF88N3sVGIUbyRy0goC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPatpXvW/dYT8ex+aLXo4VxNmsmahKyQXHhKG2DregnFOtCcCWWoA+wICi1mFrgxp
	 1WC1k70mNpR8OfwuYTvOziDW19t3MORl4qkhTk23vQNgmlU6/entsUfh0PxYlvYkdF
	 lxHWRmqZeNVjq5PXyIe7AUpjbE0ugkk/Ze5dRoopNAbZ5HZ78dRGpbTezZ/swQzl+N
	 b8QviLQvB9oOtUdzwMyXK5b1E6Gx5DRoto+yZw3quTsDY3G0LfDMv8ccz+C6S/VK/j
	 t1OQEU1KATpbcm0Rsr/k4j4QiKlOSahNzGZ6AzFD+B3fJMJ3HoJNFTedWbm+GRRsFX
	 8I3VOAMPf/FBw==
Date: Tue, 30 Jul 2024 18:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v2] net/tcp: Disable TCP-AO static key after RCU
 grace period
Message-ID: <20240730183702.06aac434@kernel.org>
In-Reply-To: <20240730-tcp-ao-static-branch-rcu-v2-1-33dc2b7adac8@gmail.com>
References: <20240730-tcp-ao-static-branch-rcu-v2-1-33dc2b7adac8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 01:33:17 +0100 Dmitry Safonov via B4 Relay wrote:
> +	struct hlist_node *n;
> +
> +	hlist_for_each_entry_safe(key, n, &ao->head, node)
> +		total_ao_sk_mem += tcp_ao_sizeof_key(key);

nit:

s/_safe//

no need to safely iterate if we're not modifying the list
-- 
pw-bot: cr

