Return-Path: <netdev+bounces-214396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B852B293F1
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83AD1B204D2
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAEB2FE045;
	Sun, 17 Aug 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mEVrTWPG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98403176F5;
	Sun, 17 Aug 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446225; cv=none; b=pxIj5E+x/vnCWDeUTdooQd1ipGuUU96i8Sk7+S1Ej0S9XA4wZ6OIhcvgWq1Phf3CNANdYFczcjiXBcIftk0ZtEBeVv+WPfR8VkDj7VHGNvNbQFMMfOLn5WJQSX0Jkxi3NEJpwhc09tmOVFdkl3CForDYGOcN5EdFVVN3DZNQhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446225; c=relaxed/simple;
	bh=a/orSmfXMgi1VtWB8YVn8eiOv4vzm/oYSSqUn2ETnAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDCl4JuK9uLa2p8t5H78xN3K3/0vUJrvg/ZF0K3N1K2nZZ00SHzNtZP828mYzLFOLSL5c1WALRXc7V39StghV9qLYgmc9dJonPLV8EM1Eo4CP4umIqSXkEuybcK2aO66czaq+K3bIxTVaKio9jP+39xcX8ttBChYOSaKuPrtjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mEVrTWPG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=db4+86xSzfb3S2h6wVVAiYGER+7ZB8I/pdntCBbI8QY=; b=mEVrTWPGSq/yn0DSOyhEXPEY/4
	C2lsonYJNEQVgGo6Pi64CBavw2UQonUy3b8sJFuSB61vZtG6i3Y9ZlNAvG/nYFuFYWjOphFCGTvJL
	Wkvf620I9g/ekncVT7L3cwQE4NDR2pI4bTOcHD+DOiZiq2fDbXthqKq2GC4qodT8MQC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfkX-004yZE-CK; Sun, 17 Aug 2025 17:56:49 +0200
Date: Sun, 17 Aug 2025 17:56:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <616e3d48-b449-401c-8c8b-501fce66c59d@lunn.ch>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
 <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
 <729dee1e-3c8c-40c5-b705-01691e3d85d7@lunn.ch>
 <6a467d85-b524-4962-a3f4-bb2dab157ed7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a467d85-b524-4962-a3f4-bb2dab157ed7@linux.alibaba.com>

On Sun, Aug 17, 2025 at 11:01:23AM +0800, Wen Gu wrote:
> 
> 
> On 2025/8/16 23:37, Andrew Lunn wrote:
> > > These sysfs are intended to provide diagnostics and informations.
> > 
> > Maybe they should be in debugfs if they are just diagnostics? You then
> > don't need to document them, because they are not ABI.
> > 
> > 	Andrew
> 
> Hi Andrew,
> 
> Thank you for the suggestion.
> 
> But these sysfs aren't only for developer debugging, some cloud components
> rely on the statistics to assess the health of PTP clocks or to perform
> corresponding actions based on the reg values. So I prefer to use the stable
> sysfs.

Doesn't this somewhat contradict what you said earlier:

   These sysfs are intended to provide diagnostics and informations.
   For users, interacting with this PTP clock works the same way as with other
   PTP clock, through the exposed chardev.

So users don't use just the standard chardev, they additionally need
sysfs.

Maybe take a step back. Do what Jakub suggested:

   Maybe it's just me, but in general I really wish someone stepped up
   and created a separate subsystem for all these cloud / vm clocks.
   They have nothing to do with PTP. In my mind PTP clocks are simple
   HW tickers on which we build all the time related stuff. While this
   driver reports the base year for the epoch and leap second status
   via sysfs.

Talk with the other cloud vendors and define a common set of
properties, rather than each vendor having their own incompatible set.

OS 101: the OS is supposed to abstract over the hardware to make
different hardware all look the same.

	Andrew

