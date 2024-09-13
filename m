Return-Path: <netdev+bounces-128086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6F977E8C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543181F243AC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A81D86D8;
	Fri, 13 Sep 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnXBoyDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804231BD4E4;
	Fri, 13 Sep 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227451; cv=none; b=XwwzYZjqagrpooPP8pfU5q7cXgxuuappUmky5Vcq5Ykcg3F67pdhMoEcyJ9cSHSi6BrH2sAg1fFHD+BzkGvTRWifuCVtkdt7KP8tMWwfMx7rU2RmWcjPy5mtBVgYQVt0z8iIZ6siQgA1rmp8kW452VvKR6nw6xrkDvn9sE00ELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227451; c=relaxed/simple;
	bh=9/pekRjHqpcBVcnkLOUUKkxWln7sVWOI9vseeK/GQ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP55ZIVCo7MEGEOFoLVwO2MrpFFEKdcFQ2YuHdAiDjWNdME85IQVDY2OnJIfawkYXKL1yed1mKUfXj09E38LWmCLoxHHbmLsvDA2JOotyjTdxKNrdr7QM61D/kfCdeuT+P8ZwqaVXQAmlgeN7mQO5vESaUR6Nf3P/rzI/+d2jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnXBoyDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FBBC4CEC0;
	Fri, 13 Sep 2024 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227451;
	bh=9/pekRjHqpcBVcnkLOUUKkxWln7sVWOI9vseeK/GQ9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnXBoyDkN2YOmW0+EIyLUILqERRz91M6LAaxlSS6M9C86Kxu/fZK/cPY5A1gMsrOF
	 pQ1ZoewiAKSjIiVn9DG/w2kq9hbvSuiQUDtspS+C5D8zN0c4d65ljnR35X4J0XPjoD
	 HGazJgDxpNQSDTZeV/iLgXGBlK+f1HqtegZl8QfNNTD9xOWnU6XT/VowFCRimSY1KZ
	 ICm6mSLYR93lqDXsrkz/s/ZsRu/uh5XvpxFSbe1Kki4t1Ifv+O4+BTOlT2H5Xhg5sI
	 /5WCEEKf0rgdrdsylOPN6WaJ/rEnV2n8n3boLbCdkYuAGWKZr99320z98OpV74gW7L
	 5WgT4lUCqgTYw==
Date: Fri, 13 Sep 2024 12:37:27 +0100
From: Simon Horman <horms@kernel.org>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: davem@davemloft.net, wtdeng24@m.fudan.edu.cn,
	21210240012@m.fudan.edu.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH] net: seeq: Fix use after free vulnerability in ether3
 Driver Due to Race Condition
Message-ID: <20240913113727.GX572255@kernel.org>
References: <20240909175821.2047-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909175821.2047-1-kxwang23@m.fudan.edu.cn>

On Tue, Sep 10, 2024 at 01:58:21AM +0800, Kaixin Wang wrote:
> In the ether3_probe function, a timer is initialized with a callback
> function ether3_ledoff, bound to &prev(dev)->timer. Once the timer is
> started, there is a risk of a race condition if the module or device
> is removed, triggering the ether3_remove function to perform cleanup.
> The sequence of operations that may lead to a UAF bug is as follows:
> 
> CPU0                                    CPU1
> 
>                       |  ether3_ledoff
> ether3_remove         |
>   free_netdev(dev);   |
>   put_devic           |
>   kfree(dev);         |
>  |  ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
>                       | // use dev
> 
> Fix it by ensuring that the timer is canceled before proceeding with
> the cleanup in ether3_remove.
> 
> Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>

This seems like it is a bug fix to me.  If so, it should have a Fixes tag
(immediately above your Signed-off-by line, no blank line in between). And
be targeted at net.

	Subject: [PATCH net] ...

Unless the bug only exists in net-next.

	Subject: [PATCH net-next] ...

Link: https://docs.kernel.org/process/maintainer-netdev.html

...

