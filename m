Return-Path: <netdev+bounces-203169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7BFAF0AB3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3276E1C02059
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724535973;
	Wed,  2 Jul 2025 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="k2Zb8sp1"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9114F90
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434013; cv=none; b=eD21FMOmWpiIPd21eawXAuB/4hwjQDHL+rKy7z0soylyB/PZa0xI04c+JVfIstCLaqTne4D2BNEFwS6fq7tp6ATFO8fiSAwLZyPCHttI8Zn239o+/ZBx5bOn8W4OpRTm6Uvn4mmuLIva2LSDxh858ZQFvb0uvTAo26fa48ABCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434013; c=relaxed/simple;
	bh=a9f2J/VY/MPeojNuqsrXR6X9ZCrmgS4CGyLabEmMEkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWGQVixm3zRm5G2AW/lPye65IkgPO3i3cRnZLIAQ+OGtnQGozDMJ5JkiKVul64KhxfdS/obtqYm85MLrBQAu5gv6mKe9KPG7ObkKKWPP7KZT6DNvuutNqJHhuLybzwgw4rXucqffWR2PMeWhOoL9dfnQHHs0zAcOcrE6voFdhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=k2Zb8sp1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751434008;
	bh=a9f2J/VY/MPeojNuqsrXR6X9ZCrmgS4CGyLabEmMEkI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k2Zb8sp1swBYSlMdyhBMeRxr2p8K77YxGW/MC60iFcFt6K0PY3QYeXJbFT9ZZcIdj
	 jFbDTVlGy1Htl2/nRCfrE7p4iYbaF7DL0mOPERiFVgBfNvMF2cBMimqrRjkgvc9gwJ
	 jY2MUSQT5zl/649q5RA6tdAoSjUaRtIA5YjyA+XTyFdznKcScR261LlkFuZFcfDv5K
	 HhCS0lMePJ5sG+/VCKPy0GQvH/PuvtnvvMPpBOg/8jR1LBg11bGOBuvHrWR4K+YtXb
	 XL7s7mvc/B+745lwb+xZZfPmncMVxDIs/pM6PNBzurNlkd22QvvXdL/Qu3ASVF6tZY
	 5me3qxm3QcRfQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 366666A6BB;
	Wed,  2 Jul 2025 13:26:48 +0800 (AWST)
Message-ID: <b70106de70c7c839f0bcafd4b855a3f66b0ab8ef.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v4 03/14] net: mctp: separate routing database
 from routing operations
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Paolo Abeni <pabeni@redhat.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Date: Wed, 02 Jul 2025 13:26:47 +0800
In-Reply-To: <e858532f-3e70-4d97-a088-3218d9822df5@redhat.com>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
	 <20250627-dev-forwarding-v4-3-72bb3cabc97c@codeconstruct.com.au>
	 <e858532f-3e70-4d97-a088-3218d9822df5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Paolo,

Thanks for taking a look at this series.

> So here 'dst' should be uninitialized when reaching here via 'goto
> err_free' above

Good catch - we can return directly from the error cases here until we
have initialised the dst (and allocated the skb). I will update in a
v5.

Cheers,


Jeremy

