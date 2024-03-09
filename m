Return-Path: <netdev+bounces-78986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28545877350
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892891F21577
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490E42A84;
	Sat,  9 Mar 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnUzSyEs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2E1CA9A
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009480; cv=none; b=d4mRDyS/XhdEjTQ9FFaZ9/cemqZXtrjKHhHCT+c2upYAp90Ws6m8g7xvTAPhBICSQKR5TOeT2RHDiqeZ1KkNGOBsHBzw3EGfnL5AF7OjzdduQXt5cJLSV7vlzSb62gP/v5HNo5G+RbOUuxr935SQjGh6qUkJU439IesjvZcKKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009480; c=relaxed/simple;
	bh=goZe3xygOYeYwVqrKSXDHdaK9U2VZqyTnbWak1yiAks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKoRRKbtiX4q8lJ9zjmTZDUmVeurgnNewtjxVvBd9UlpKK3Xh3GI+O37zqZE82u/snRnPKTNp3jYa3zxXQHONEu8QkXFrbTnpbaezNLJ805eD6UWz1Rq4ifnKBkf5z1kFNRrz973wi8GwML2aMaraiV/C/k0jMKvBNZFETZU050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnUzSyEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8138C433F1;
	Sat,  9 Mar 2024 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009480;
	bh=goZe3xygOYeYwVqrKSXDHdaK9U2VZqyTnbWak1yiAks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EnUzSyEs132JwJAuchtC9bxbi5c4uxqilYdtjxBX6hrKLmKOh9GIiVpVjOz4BSjBz
	 2WbVxnQCUZxsmalf8E6fpTsMxgkchCdatTALu3mD6OLYxW3Qj1P+Yofggs/iKvz1JO
	 Oclx/TEcBYgNJ4gTKANX6K0wG6aH2L8kCnM1NZf9js9a8XE4HOpxTQO+meE8tmKeGL
	 bBVJ2iWglNHosFnXmEoezqI9qXSMvhqiYPCG95rl54stPfS+Krj+m2hr34oSAP6pf0
	 q2rcuVGFNsl/ilZuHNGt+D1DzHv4fyoWCkGqKcpXziiXD50eiA7dtRrIGgWNJ+BKee
	 el7cQHAjcYQFw==
Date: Sat, 9 Mar 2024 10:37:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@kernel.org>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next 1/4] libnetlink: Add rta_getattr_uint()
Message-ID: <20240309103758.7bd0c249@kernel.org>
In-Reply-To: <20240309092158.5a8191dc@hermes.local>
References: <cover.1709934897.git.petrm@nvidia.com>
	<501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
	<20240308145859.6017bd7f@hermes.local>
	<20240308194334.52236cef@kernel.org>
	<20240309092158.5a8191dc@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 09:21:58 -0800 Stephen Hemminger wrote:
> > > Don't understand the use case here.
> > > The kernel always sends the same payload size for the same attribute.    
> > 
> > Please see commit 374d345d9b5e13380c in the kernel.  
> 
> Ok, but maybe go further and handle u16 and u8

I guess you can if that's helpful in iproute2, as a "universal getter",
cost of a few branches. In the kernel I try hard to convince people to
never use u8 and u16 as they simply waste space on padding, and the bits
may turn out to be needed later.

