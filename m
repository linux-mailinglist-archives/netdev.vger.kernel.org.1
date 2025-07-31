Return-Path: <netdev+bounces-211214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E4FB172DE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209863AE55E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA62D0C80;
	Thu, 31 Jul 2025 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgYXwPYk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467752264AC;
	Thu, 31 Jul 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970983; cv=none; b=NFRhDRMBv2yY3E4tOLEqDxTLOpSGQZs5JBLgdKcItc09PrwrxLe90bLXmYUCb2O7fcpR3J5gjVI00THq49SQ/A/Wy/uILbgGmmcIFLzM3xlY8+WCPd5YGTMCdeIHoN3a2CqUQXtincMkDbK5sOO6zLuPgbT23oXszDTeHcSXWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970983; c=relaxed/simple;
	bh=PlOK8GTL+e2G5y1us980St53a6jMgb7uMAT9Hu3Oebs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N49MnDWofqJkXCBZH+5LYbzbtInxWqseqjO/ZL4J4kL1tD3Jb/qbef+j3H3d4rlBR+FlZzOCLxMeGDa8ceaFcJ4Aq2J849OxBaL4OQjSeCGeowvkdnJ1VtYeb8U+iGufJkkpt8kh/CHJmc7PGwPuTGY4IrdnfFBnKiwKcoisKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgYXwPYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E86C4CEEF;
	Thu, 31 Jul 2025 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753970982;
	bh=PlOK8GTL+e2G5y1us980St53a6jMgb7uMAT9Hu3Oebs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgYXwPYkif+7Yq3y0cMB8070JbwiJbO4oSJP4ohjaYcpffT3PJmSQ0vt8ufuI9gTT
	 PUBhCDQ1O6ScpDdSJkqdWCzkt2pQXaOiM9GpatijRH4u8WDTPoAUFWYesSYPJmUqIY
	 NfgF+4jgiEWQV9BCjwOsBUv7pHtNWXb9t9xxXzTeqeRUg12F+HwblEXHezT98gZ5HB
	 w11ZBEpDXM6M8IUmvYqMcVlOuVAUJHGRcEc3d8UmMJphUZH8nZBVfGZbinjeW19j7U
	 Ydrocps2LO5g8PTmko5hKNZ+59NQwVY9mXn504s/x8R44O1TTpZLEGIkrY9QsgdeNY
	 FsVYiAu/Z47hQ==
Date: Thu, 31 Jul 2025 15:09:35 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, fuguiming@h-partners.com,
	guoxin09@huawei.com, gur.stavi@huawei.com, helgaas@kernel.org,
	jdamato@fastly.com, kuba@kernel.org, lee@trager.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	luosifu@huawei.com, meny.yossefi@huawei.com, mpe@ellerman.id.au,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
	shijing34@huawei.com, sumang@marvell.com, vadim.fedorenko@linux.dev,
	wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250731140935.GE8494@horms.kernel.org>
References: <20250725152709.GE1367887@horms.kernel.org>
 <20250731104934.26300-1-gongfan1@huawei.com>
 <20250731133925.GC8494@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731133925.GC8494@horms.kernel.org>

On Thu, Jul 31, 2025 at 02:39:25PM +0100, Simon Horman wrote:
> On Thu, Jul 31, 2025 at 06:49:34PM +0800, Fan Gong wrote:
> > > >
> > > > So the swapped data by HW is neither BE or LE. In this case, we should use
> > > > swab32 to obtain the correct LE data because our driver currently supports LE.
> > > > This is for compensating for bad HW decisions.
> > >
> > > Let us assume that the host is reading data provided by HW.
> > >
> > > If the swab32 approach works on a little endian host
> > > to allow the host to access 32-bit values in host byte order.
> > > Then this is because it outputs a 32-bit little endian values.
> > >
> > > But, given the same input, it will not work on a big endian host.
> > > This is because the same little endian output will be produced,
> > > while the host byte order is big endian.
> > >
> > > I think you need something based on be32_to_cpu()/cpu_to_be32().
> > > This will effectively be swab32 on little endian hosts (no change!).
> > > And a no-op on big endian hosts (addressing my point above).
> > >
> > > More specifically, I think you should use be32_to_cpu_array() and
> > > cpu_to_be32_array() instead of swab32_array().
> > 
> > Thanks. We'll take your suggestion.
> 
> Thanks, I really appreciate that.

Sorry, I missed Gur's related email before responding.
It seems that conversation now supersedes this one.

[1]https://lore.kernel.org/netdev/20250731125839.1137083-1-gur.stavi@huawei.com/

