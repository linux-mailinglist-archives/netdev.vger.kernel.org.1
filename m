Return-Path: <netdev+bounces-125908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CA96F3A2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE62868E5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07451CBE87;
	Fri,  6 Sep 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O2q+iIQq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9F17C9B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623502; cv=none; b=ugbHOhXjNj05OxPmBwCyheDGQe6xJDpUutfPYGorxrcXKv5z8AFIZ7D9csnpI/4SKi6auszSO3ST+dLwC43Xy0yXWvNuWJniFYE1SSQ9uiiQ0nJ61l437pNV0HuXyeoDyX0Vxxnvxt3fmgNfqp1FuFh0csQ1TBvZNwyVrkZHpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623502; c=relaxed/simple;
	bh=7m6ZexYICBs74zpH3sBxV5HsDBb1hY839vc48opHdRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYql0lA3DJFsvEc4n9LzLhnwrXQ8NwTGYXIMR1W+IgDSYfi+eYfl0OY+Dr9oAUHgVCq9exbDW7nAdnIghUTdVJeZ7YZ28E4ase3J9jjGxgfDIc/p9o+/2iWB2lj8rmYNhKH35LnW3e/ZNxyqmnQ4Be6+pEYC/ybhrj8VWVwTruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O2q+iIQq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xxGZKPaq4+1aEX3c05z8d8tgJ8nBeiPM2f5DmTQqAw0=; b=O2q+iIQqmPh8pZEqd6sNC5G5OK
	I0Bqyvv9M4LzC4EJm3XiHGckkPwJ3dFsED4WmRzkrIq6uplrUXtXvM7rslQWZ6y8FXwARSluaqagt
	fMjpP9nddAjG3GVBTEU6JFJyS/Y+dRkRqgZWJsm9l+rQI+wyVzOFYmNOaUW0WqHBYh20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smXUs-006ngB-W5; Fri, 06 Sep 2024 13:51:26 +0200
Date: Fri, 6 Sep 2024 13:51:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] ptp: Check timespec64 before call
 settime64()
Message-ID: <e78f815a-9aba-4542-bfa7-3d73d1b684f3@lunn.ch>
References: <20240906034806.1161083-1-ruanjinjie@huawei.com>
 <20240906034806.1161083-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906034806.1161083-2-ruanjinjie@huawei.com>

On Fri, Sep 06, 2024 at 11:48:05AM +0800, Jinjie Ruan wrote:
> As Andrew pointed out, it will make sence that the PTP core
> checked timespec64 struct's tv_sec and tv_nsec range before calling
> ptp->info->settime64(), so check it ahead.
> 
> There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
> write registers without validity checks and assume that the PTP core has
> been checked, which is dangerous and will benefit from this, such as
> hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
> and some drivers can remove the checks of itself.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

FYI: Your Signed-off-by: should be last. Please fix this when you
respin as requested by Richard.


    Andrew

---
pw-bot: cr

