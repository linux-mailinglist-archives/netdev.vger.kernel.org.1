Return-Path: <netdev+bounces-95699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529E98C31D8
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A171C20C8E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121E355C1A;
	Sat, 11 May 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hf91AIkh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C154675;
	Sat, 11 May 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437811; cv=none; b=nUPAtKUVRuD6YDNuQ7W97UFqoevfRp0WXDr4e6yk+z7lbj/xN/QTuSofqSEzuJv2i5F0Q/kz9WZ2EvLVdL/vlIeeNVHvoOjIrukyZ6+xC/UJpB59YVd71T3X9MmZ1aflBG8MB0+sz6VawVeHNk3e9Z24R4x81+2bXHCKFSd+PZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437811; c=relaxed/simple;
	bh=Ljf9kyd52InGJKqfdBuV4Ah4NYoQ0uueOOS0D+QxAlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adqaZeZsj6mMgDAnpUzMQIPcG31zWbBvKuhTn34Eyyb5adj76feXHhYieb8/BCDgb2uZqGfdEwa93YUmBQLZsCEwJz5KOKL35LWGH4slrp+otQCrapX8uYn77HmBR8NgDUjDGK8sS/PhtF6kb9C/bOQXMIQW8SbDIdjYsmUqnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hf91AIkh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5MHosLGyMfOMQTFlE11a37ZDMCC9zCbFJQj+2H5rwUU=; b=Hf91AIkhkaSC/B2WvhNWfwFnWf
	Kq/EjgoDVI6qd9M6wXYFCYedTgtUun6AbuF8yvyUPI32/G6ilEsrdkmELeZYD1x4pyjh33PZ++2ok
	xa0UUy15UX1uZDoqYtGX2wzPl4ea9Pyie9+77E5Iu29n/yCdXDzpTH2O/k/0BGTruXz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5njP-00FCTL-Pz; Sat, 11 May 2024 16:29:47 +0200
Date: Sat, 11 May 2024 16:29:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net: fec: Convert fec driver to use lock
 guards
Message-ID: <b96822ea-4373-415d-8397-d8bc5da88120@lunn.ch>
References: <20240511030229.628287-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511030229.628287-1-wei.fang@nxp.com>

On Sat, May 11, 2024 at 11:02:29AM +0800, Wei Fang wrote:
> The Scope-based resource management mechanism has been introduced into
> kernel since the commit 54da6a092431 ("locking: Introduce __cleanup()
> based infrastructure"). The mechanism leverages the 'cleanup' attribute
> provided by GCC and Clang, which allows resources to be automatically
> released when they go out of scope.
> Therefore, convert the fec driver to use guard() and scoped_guard()
> defined in linux/cleanup.h to automate lock lifetime control in the
> fec driver.

Sorry, it has been decided for netdev we don't want these sort of
conversions, at least not yet. The main worry is backporting fixes. It
is likely such bcakports are going to be harder, and also more error
prone, since the context is quite different.

If done correctly, scoped_guard() {} could be useful, and avoid
issues. So we are O.K. with that in new code. That will also allow us
to get some experience with it over the next few years. Maybe we will
then re-evaluate this decision about converting existing code.

    Andrew

---
pw-bot: cr
     

