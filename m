Return-Path: <netdev+bounces-145161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351339CD5D9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4888AB22B0B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29D14F9D9;
	Fri, 15 Nov 2024 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNZCOOFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2E36AEC;
	Fri, 15 Nov 2024 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641101; cv=none; b=HdiYfM+xCinPiW0ozZooNu7TMP1/DhWn3qfQ0uHGNfHLdRBg48EAE+n7Aq7IFb4x94nSrccA+fuFTjq5gSaC3gbHv+Nl0bcirafKZmH8Df4OwrcNVMY/KYw11X9yfrTopu4JeYfPArtzcS85xRvCNxaBp5kXjhOuyFRoSIggXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641101; c=relaxed/simple;
	bh=GwPx9p2fAAJpEgdXKmjcfWWIk4iKKUXNzgNV2UvJ0+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9HSTouC18D8plRTRhlk/4CHQjls3Nm2g2q25rdm94gcNBNl7a7xUHb1gpe4tErm6HHJnCMDJZHRkQiArAHRhFZ5UYptVkj1Z3332UzJsTYEx2xKfgFDXOXuMO/v9IsWoDOxsWZ6i8RMUVDe6oFleliu0rC1qDpytqs44Nm+Bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNZCOOFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82916C4CECD;
	Fri, 15 Nov 2024 03:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641100;
	bh=GwPx9p2fAAJpEgdXKmjcfWWIk4iKKUXNzgNV2UvJ0+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uNZCOOFUgyAw4ETeScWMCxscQ4txiq8XPlrNEgvaU96OLn7BreZt/jiU9vtnV09Y1
	 EwbBMo0AOeIBJ8OI+GJFm5c1NwtYOY0vZuVApsnGuwvf8VGbL0kXDAOYgpsDGk3xbP
	 5jg6+q2/7ELWDQ3yVT4yZh0WcZy4jLq4zUKm+MJ65dg/Vwnu9/HrBY0uQJftOFSbpX
	 qFuFfd3bH3ofNdMPDazrqqnxvnUY8QnSJlLTRRwwGFSG59vfi2/HhJFMLxpHCX6m77
	 PWp3mc+9M+Hs2ReF3i5Yj1uIeD60LUHJDjZbXf6AlWkny5yp2Fw2PBCfAxPco1yTOq
	 Gb3Gi1mH9NIbQ==
Date: Thu, 14 Nov 2024 19:24:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Qingtao Cao <qingtao.cao@digi.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v0 1/1] net: mv643xx_eth: disable IP tx
 checksum with jumbo frames for Armada 310
Message-ID: <20241114192459.75e5b4d9@kernel.org>
In-Reply-To: <20241113110040.24181-1-qingtao.cao@digi.com>
References: <20241113110040.24181-1-qingtao.cao@digi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 21:00:40 +1000 Qingtao Cao wrote:
> The Ethernet controller found in Armada 310 doesn't support TCP/IP checksum
> with frame sizes larger than its TX checksum offload limit
> 
> Disable the features NETIF_F_IP_CSUM and NETIF_F_TSO when the MTU is set to
> a value larger than this limit, to prevent the software TSO generating GSO
> packets that are not suitable to offload to the Ethernet controller, which
> would be calculated by the IP stack instead.

Did you consider disabling it per packet using .ndo_features_check ?

