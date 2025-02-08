Return-Path: <netdev+bounces-164255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08325A2D265
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6293A4CC2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182318479;
	Sat,  8 Feb 2025 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTdTSxkm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7861EBE
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976084; cv=none; b=l6SVaHoOlbUyTEuKUffP8z1LNIF4xiKbFAtx+WW8DtofPcTu6xeM0BkQGat+INuBBcBQLB6PqSnWfU4+4lpOOycvy9zd9oq6WuXJUqyq/vofQeUzlVZBRdqrFjnYApZcn0anVIueqKYQiGAFpRi39ZiDEKz1M6TRzUUw8qD8ddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976084; c=relaxed/simple;
	bh=QfUYU85R8YbDrf6eQDZngQqOXW212y3pKUFigdGt9+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYd/HHSjc0ZNdifxaaiXo6DBZrt+UcVYnsjFYyEjBIr7dHTvEOYGLI448kZjHStCMC8wKFgDhvqzNKNU3OO5lL1mVhsnQK7QyVscxY4PAxjIZlbFe7+pOLhE2G1xIDnP3VfvhclL4iOTtheIT1J1xFSBCMSPtzSUMqIripvHgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTdTSxkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68834C4CED1;
	Sat,  8 Feb 2025 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738976083;
	bh=QfUYU85R8YbDrf6eQDZngQqOXW212y3pKUFigdGt9+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTdTSxkmJByMjTQeuHhMBNeOOSQyiGjq2ipuhdUTWXSCtoIOhnCvzEyl/G+KDqOJi
	 COlf2ek/PNBH308rX393lo4QMAae0BW7ub3dxoHhJzqbOsHFD5D17F2GYGUvKg35UU
	 MWgAuUr0mTeAM9E5pqJbgU1NsddJQvOhIshOuS/eI08+R6pI95SqlIBjE13YmhfyXl
	 sd9iIQninB8P3da4bEBtM4mmo6+obG4imFHia5iKaQbvf05ULLG5EZ6mc2XIveokW9
	 RaZj+z7O+fKBj9p4FhjHpH/5+6PbIEqrH4QsRUuyZk8kwMTkrPa0ylzLrhGHOIZHbA
	 pJPxXlwyFPA3Q==
Date: Fri, 7 Feb 2025 16:54:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 net-next 1/4] net: ena: Add PHC support in the ENA
 driver
Message-ID: <20250207165441.00484f2b@kernel.org>
In-Reply-To: <20250206141538.549-2-darinzon@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
	<20250206141538.549-2-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 16:15:35 +0200 David Arinzon wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411020050.npvLNJ7N-lkp@intel.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202411020715.L7KdiUt4-lkp@intel.com

Don't add these for new code. Only if the code gets merged before
the report, and you're sending a patch solely to fix the build issue.

