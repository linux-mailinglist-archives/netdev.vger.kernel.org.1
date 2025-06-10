Return-Path: <netdev+bounces-196221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DADAD3E60
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334AA3A5B8A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060523C4EF;
	Tue, 10 Jun 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uqL934Hs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05F23717C;
	Tue, 10 Jun 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571737; cv=none; b=aEvYy5qrJtfHCfmIl0Hw3mFe5S6YtmTpVPYZp9A6UzPYU9nS3l3ZRlhXHZk36SrVyNnkdAv3gnFoUbyuJsUT4tjoqvUJvWJSB46hpWiIUDpXWjtPOVvPS/T5pyCYLmyNy6SW9E64n2wIfTM2+LiwkWeS6+S2yUZYsDW5aGhwmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571737; c=relaxed/simple;
	bh=oy3R+OQN5lqjjHR2lh3SlkiG+2hGqOcM7G7q89F8AvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcFfn3a5gitqIw/xycwSTY+QeoTGDEA20Z86bTeVQNA6dvVtMvQ4eHqJu6cZeyAL82THK9CJ5JOLXUtOylbnj1+20Ic8d34BhBiYbpq7bg8tH7AHfRkc0Hu5r4VQPfH4LvfofD/SICVJXKEdN0BMvzq159i/6xoEFyTXsK4ittc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uqL934Hs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=52NYi1mWALW3LxhXJD+hvsQNqhKYCgbOKqMlh/SaiCI=; b=uqL934HsMkGWVZvayAg2oMaWkx
	qArXYPOpKJznKIL77OaHLjhHHL1T1SvPYzYmMEmWlumLrCcuUiWbqFN4M+rIHVqKTLqC+Zefjt/Mf
	pk/qZzeIkIun4qysFTD3q+PMOBZG7UNysaw5M2YPlQEuKpXivrbCedoBr/g/COpsBXRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uP1Wj-00FIOW-NL; Tue, 10 Jun 2025 18:08:41 +0200
Date: Tue, 10 Jun 2025 18:08:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Hao Lan <lanhao@huawei.com>,
	Guangwei Zhang <zhangwangwei6@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] hns3: work around stack size warning
Message-ID: <2a565f22-b8ba-409a-8551-91cf86788657@lunn.ch>
References: <20250610092113.2639248-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610092113.2639248-1-arnd@kernel.org>

On Tue, Jun 10, 2025 at 11:21:08AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The hns3 debugfs functions all use an extra on-stack buffer to store
> temporary text output before copying that to the debugfs file.
> 
> In some configurations with clang, this can trigger the warning limit
> for the total stack size:
> 
>  drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:788:12: error: stack frame size (1456) exceeds limit (1280) in 'hns3_dbg_tx_queue_info' [-Werror,-Wframe-larger-than]
>
> The problem here is that both hns3_dbg_tx_spare_info() and
> hns3_dbg_tx_queue_info() have a large on-stack buffer, and clang decides
> to inline them into a single function.
> 
> Annotate hns3_dbg_tx_spare_info() as noinline_for_stack to force the
> behavior that gcc has, regardless of the compiler.

This warning is about the potential to exceed the stack space. That
potential still exists because of the tail call from
hns3_dbg_tx_queue_info() to hns3_dbg_tx_spare_info(), preventing the
compile from inlining does nothing against that.

> Ideally all the functions in here would be changed to avoid on-stack
> output buffers.

That would be my preference as well. Lets give Huawei a bit of time to
rewrite this code.

	Andrew

