Return-Path: <netdev+bounces-214313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B2DB28F37
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E1E5C2593
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC291547CC;
	Sat, 16 Aug 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FpEz8krS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CC6FC5;
	Sat, 16 Aug 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358680; cv=none; b=UClRsmV3fHG3nL6aPxrqnFHR4lTjKFVm8qA32CqH2tDTXsk5R/vOmxnc75ek4ewkYXQSv5fKGPax/GwXSuP98upZElPmhzyUMHHXexKFaeonjH0MJm2IGXdqCpQretb4oZXPFtNB7HIltQ/oZfuNe2Ye057t12NW1kOLjJBuq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358680; c=relaxed/simple;
	bh=fmUjxBqT/YQptLLFUCnuBtOiMVGfqLNL5OiA/bV5gvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qnuz1b2SHqpYGVAkNBKuzogtLpfowx44DzcRA4ODLQMoNajVXRc8k7VchvCieV8EiIEPlEUbZ3DikvDtcHjQIJ98Xaed9dq2PBwXMjdxDjemyYWnpXSbfMmXpVdlRvDe+77T/yZqubwD1eHJZu2w8Rl79RJzu5ltu4p8sjw/ytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FpEz8krS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RvC+UC/AdOwrm3IlIaz82Z8Ib6je8cnny1YfptPh3y4=; b=FpEz8krSo3XZrKdIGIf9Cniw4q
	qq/+8JbM3iURszASaV3B5xrxulu5ttSDVG/SaE1HoUJt06qh0dQsm0DuIbjzoYxzNcZ1+0orKY8br
	FzIbN+DUdioUXbgrzCLm9AQuwfJz6MRLCC4U/nWLmu9de/UmBxWX6nSkyrKURmmpDYJM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIyX-004ufj-4Z; Sat, 16 Aug 2025 17:37:45 +0200
Date: Sat, 16 Aug 2025 17:37:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <729dee1e-3c8c-40c5-b705-01691e3d85d7@lunn.ch>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
 <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>

> These sysfs are intended to provide diagnostics and informations.

Maybe they should be in debugfs if they are just diagnostics? You then
don't need to document them, because they are not ABI.

	Andrew

