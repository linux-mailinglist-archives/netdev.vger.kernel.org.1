Return-Path: <netdev+bounces-94966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDF8C11DE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E1F1F255FD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97B16D4E1;
	Thu,  9 May 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M15JjTtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24D15279B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267996; cv=none; b=Ea2xbK8FXFSqUxtEfWfRRUiPwYrY0G/yPeBrmeNOwGRYss4urgayHeN8imXqE4VPOO1r2O+kEk7NafXMYRYa35u2ZwycgkZ2/RD70Dkdp9fxXTmLuG9P64ilSoYVXhpG1jWUGSorVboXrg5i1qG2zlxPnKuQz7erwlFYoOUtxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267996; c=relaxed/simple;
	bh=jX0a+3lm0FQFwX8VLLyGGx8e+soAmyNHPbaYw8MGG6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBMN/CyFGHRC/8M97L+mtgHsH19nhqR17X8CIsQnmG/qTV1L3aVgph/Jp2PNl1TApdDwHyE7Spso5s4EsRtdnXuooBziWZThzMuFr+A/WC9HE9M2vrQ0N91WGy6Hl/RuRw3woPzfHnC2Hm3rHt8BOwfk6ImvlQ7gAEkyjRQHf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M15JjTtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66807C116B1;
	Thu,  9 May 2024 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715267995;
	bh=jX0a+3lm0FQFwX8VLLyGGx8e+soAmyNHPbaYw8MGG6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M15JjTtEQhhTVrzpRrtwSWfZMkqutR7NiOEpfs5aR775Jm8Lgfsqhn3phWOw8pBnP
	 BnZ/HO2rzTEWedNk45hU1fCAC0jfy5CIklllfUZ6mwgDf43BbofqfmcBvPdfHPtxmA
	 W2UT9INM7ShdBgP+f5RCnJYkhqcPnuojBJw5pgb3naO+0WkjC1HCfIBaa0DP9XTcrW
	 IMpjRYm3GXJKzPAhEFD/ih7aQ7UYOKz8rGPEGMuw02MGHCOFm39h+4h9uUl0HK5qhZ
	 Y2QwopcqBsslTVcNoiIgyDN8UjzBIzQWvMhNNfWO5mGTjK1hQn8HpXxDfrVnWu6Owk
	 f8NuvPgGGJGMQ==
Date: Thu, 9 May 2024 08:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <rmk+kernel@armlinux.org.uk>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
 <mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net v2 1/4] net: wangxun: fix the incorrect display of
 queue number in statistics
Message-ID: <20240509081954.42d71326@kernel.org>
In-Reply-To: <009c01daa1ba$1986bae0$4c9430a0$@trustnetic.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
	<20240429102519.25096-2-jiawenwu@trustnetic.com>
	<20240430185951.5005ff96@kernel.org>
	<009c01daa1ba$1986bae0$4c9430a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 10:39:22 +0800 Jiawen Wu wrote:
> > The ethtool API fetches the number of stats and the values in an
> > unsafe, non-atomic way. If someone increases the number of queues
> > while someone else is fetching the stats the memory of the latter
> > process will get corrupted. The code is correct as is.  
> 
> So should we keep the old code, showing stats with fixed maximum
> number of queues?

Yes.

