Return-Path: <netdev+bounces-143528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486D9C2E0A
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B743C28186F
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6E19AA72;
	Sat,  9 Nov 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="biQbsZ4N"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6919A281
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165062; cv=none; b=NQuFqDoS/6fSYkSJOnVjqz5pdTHk04tuqOz/PTkMRDI+YezySGHQY40Ln1iQi8/9VN/OI4I64dbu0Uph0NvByIDC/nLTV4xmF3lE1Rl3chbgAKpdDE8PBwkY+AezJi1y+UrG3zUkMEZKcczn+M8vKxJo3Ojg6oYFhdQyHxVlkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165062; c=relaxed/simple;
	bh=LjhUHocqC5YNB6fr89XQSQ6BYVImywifFZE1+NW1Yzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3G4rjB8URvTnuYzJtc7XGXOULX2XdWGMmJUGFYUGy4paBXDMW1WOQgGTd/sdlm5NlSCmSF3RsHwgcCnvp6cktEZ0hWwMbGbcXBL8lQTxiKu+54Lw7z7x+BCARyt7PKwffO+HOMgBybv+hZmDMkl9qyHyMknOarI4dhH4Xl6w+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=biQbsZ4N; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bdaa8da4-aa72-43de-8b05-88ed52573a8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731165058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4+Py9BYQVH69axGQQfiqceY9K4QycVH/droHcRrVGA=;
	b=biQbsZ4NFBM9a+1tyzVLO4p2EyYrOw/IP19+S8ht0E1Wd72x9swd0HU/DuHyknGJtSzYAr
	ixRhVj13YOlVbqnoVbWqW0RAWDUW43ZsENDinssY+4KHeXILyfykuBF6CmzbjhAniLE9Xg
	KDkRYwo/n9xLMx0k1JYeO355WyWxzXE=
Date: Sat, 9 Nov 2024 15:10:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/7] octeon_ep: Add checks to fix double free
 crashes.
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org, frank.feng@synaxg.com,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>
References: <20241108074543.1123036-1-srasheed@marvell.com>
 <20241108074543.1123036-2-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241108074543.1123036-2-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/11/2024 07:45, Shinas Rasheed wrote:
> From: Vimlesh Kumar <vimleshk@marvell.com>
> 
> Add required checks to avoid double free. Crashes were
> observed due to the same on reset scenarios
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

As you reposted in <24h, could you please take a look at the comments in v2?

FYI, 24h rule in netdev:
https://docs.kernel.org/process/maintainer-netdev.html

Thanks.

