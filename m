Return-Path: <netdev+bounces-115785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7184947C40
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8F51F234DF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383455E73;
	Mon,  5 Aug 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOuJVPdW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51B6F2FA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866063; cv=none; b=k9Q403A70+mKeaHRVDOfQkw0AFP+6VZvs/R6WNIS4Wi3Je+nXg7nnSU2HctEsTudebTWDtnLLy652UsRrIixqsJH3tJtFSQtsrFEWincsnDGqA6ytzrBCZjTOl4F1diaQT14oDdLo1uuATALbVGGiCqGuZdwB3YaJfW286pNNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866063; c=relaxed/simple;
	bh=1x7zHYcB0a1JRiuPibAfhdq3Rksbg/wGsgxRfkkPES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVzeOIUbAhXuEhCrSGrNaT+xLR0sJtPR8c9pvvK7OnuSJV1NMRkHnDoULCP+AS3V9EuBU4Re/ITSx2MY0hQCuIUbg0jLeNF892PatPFH9dCd1/i/ALrZtxHm0OOR3t20vi4GLlYQatgQpNMolcSVqAae24LqcdVPr38F5NX8sUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOuJVPdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077ADC32782;
	Mon,  5 Aug 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866062;
	bh=1x7zHYcB0a1JRiuPibAfhdq3Rksbg/wGsgxRfkkPES0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOuJVPdWynRbc3j1j1v6taeLUoBwk2iq0nsl/Q/wB8SenEO0gfqPmyWuY/3+6TkzF
	 Fo5how8fHcRmU72fJvHfrNiXWT7v2zQzTZxdJgykaY9wb1b/uzOjvCXl5P9YvOWto1
	 aadATUiLYjMYHLpxft4OKkrYMAuetgqGvZXeJve4oxLPjiU/QQQHoHozyYJtigXQsl
	 YBorYUoGRl8bef+sIMj4LyHGJxpC/1zsKOJkiufT/joZYfdwzsY4XnmYs1ueRoUpJm
	 8iw1QkrS0mH8x1P/0oy939siS6WdS1m/JmvwkDMDdL86ZecMo++Ex2zwhOjBM1+9l4
	 mrcYO9bwZUW/A==
Date: Mon, 5 Aug 2024 14:54:18 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/5] ipv6: udp: constify 'struct net' parameter
 of socket lookups
Message-ID: <20240805135418.GF2636630@kernel.org>
References: <20240802134029.3748005-1-edumazet@google.com>
 <20240802134029.3748005-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802134029.3748005-6-edumazet@google.com>

On Fri, Aug 02, 2024 at 01:40:29PM +0000, Eric Dumazet wrote:
> Following helpers do not touch their 'struct net' argument.
> 
> - udp6_lib_lookup()
> - __udp6_lib_lookup()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


