Return-Path: <netdev+bounces-238280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CAC56FAF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EE53BE74B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F313314D9;
	Thu, 13 Nov 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AReVX4mD"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BB3321AA;
	Thu, 13 Nov 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030455; cv=none; b=FZ2Iekjb4L38FaduQiQzw/s8gZtCW55K9Jw2KbS8Ikrlo8n31IbewGwtl1GEEw45JIeRrfRaEnPYaU0bN8DAKLTOpBI7tTDvRG1iwtQlH8wfLWZkF42fdwbpyJ9Ckw42hMcIkehVz8PP2x49U6y9ak0/KowCh75KvR8sHr0F2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030455; c=relaxed/simple;
	bh=jWVKvMsP89IrNVoESw6zclMDWLQrStgc2KW55zRlXJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKEs84dwDBap90N5DZ4Gfm96R6ISF9ip2YPzc22gNgLN3ne+3MhAXvlID7gBMc7LXxyoxnOdndLf1Bx+VT92yR6pZNujRI3SDtrDPnXXe/aTnMfVYs/l1CdnO8J3TXlqcziAlbB5Tp2KrXBdJ6lMAtruZQLuG8ti8tXcgpAyfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AReVX4mD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C28E82083F;
	Thu, 13 Nov 2025 11:34:20 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbqHMK7ZW1aT; Thu, 13 Nov 2025 11:34:20 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4216A20758;
	Thu, 13 Nov 2025 11:34:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4216A20758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763030060;
	bh=CXmCYC+bvOEUd/3XJi0/VnEgDRVHaHTYcVJn1mQ3haY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AReVX4mDyS5irq0NGwL0MUXXdNSYlVB7dMlNa4oW/kxcF7w+1SU63Rkw4oMcsl2cU
	 d5NVKw64QZLFRfqDMA+KcfqYMi7ZJ1nTEY6VZqRaCCus91InnZaxMRSeE5WN0fs74D
	 nbPjNhiTCS1ao1oUszMW0sA+19Wgn5B3XSlm4hpCbNaboGri4mZBVwz6eEQBZODOlc
	 KWLJqWyjJQzFrPj94QgFfYp359hMH0bkCyYtUz5G+wqda133TB7HBE49UGnIv5tB6g
	 AHWYkAnG71smuoeV+NheWnkNHW6NSQSACu4dHJlypMQGgZl5912OE8iwi4FCX+WM2P
	 C5uoF0kFAdYPw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 13 Nov
 2025 11:34:19 +0100
Received: (nullmailer pid 1720106 invoked by uid 1000);
	Thu, 13 Nov 2025 10:34:19 -0000
Date: Thu, 13 Nov 2025 11:34:19 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Documentation
	<linux-doc@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next v3 0/9] xfrm docs update
Message-ID: <aRW0K-wOdr3RZmGx@secunet.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
 <aRJ3rVhjky-YmoEj@archie.me>
 <20251110160807.02b93efc@kernel.org>
 <d836336a-7022-44e3-9416-1e6cc6a70155@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d836336a-7022-44e3-9416-1e6cc6a70155@gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Nov 11, 2025 at 09:31:49AM +0700, Bagas Sanjaya wrote:
> On 11/11/25 07:08, Jakub Kicinski wrote:
> > On Tue, 11 Nov 2025 06:39:25 +0700 Bagas Sanjaya wrote:
> > > On Mon, Nov 03, 2025 at 08:50:21AM +0700, Bagas Sanjaya wrote:
> > > > Hi,
> > > > 
> > > > Here are xfrm documentation patches. Patches [1-7/9] are formatting polishing;
> > > > [8/9] groups the docs and [9/9] adds MAINTAINERS entries for them.
> > > 
> > > netdev maintainers: Would you like to merge this series or not?
> > 
> > Steffen said he will merge it.
> 
> OK, thanks!

Now appiled to the ipsec-next tree, thanks a lot!

