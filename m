Return-Path: <netdev+bounces-145851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA339D12F1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E90BB23BC1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8F3B192;
	Mon, 18 Nov 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ThzumbFM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE17483;
	Mon, 18 Nov 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939337; cv=none; b=aErUc2bR+VTco9XX1Z6bi2iyvb8I0Styd8nu9SejnMu65nV3SnOCS+kAouxM4Q/0yCoTc5yWqD4KRrqQlZ5DqMMnGZO2sV5fvv6SG1WXwhYTbqP6aDslUoAUOwZA6TicCrCRr2FkajIFWzXr2TqQ5Re6L+ApLeX00aWRTt2m0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939337; c=relaxed/simple;
	bh=pLw8yLEbJuvUtq9sxywo7ARuhOc5cWXO/kJtX8g68XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoDCj8VToVId0kIUNZnxN8dYqmF1JpN/hw8hh6Em40TxMjyrjGfmEaFeZXKrjz3rbC3eAULQgXKsBxJzCC+PPlYp9pIs1EN1V2Z4cSmHqW50EZmeDds6kGn1bCI0bKHH6vnjR4vdO0ObXXph7ngbw4N/eMjKLHNgzJVvuiQ+fQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ThzumbFM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=osWqrHi1PTnMhMN1ifWmZoFzhh+9H9ujv9/LFvTGxmM=; b=ThzumbFMkF9hLn0QG1QYfcRDGP
	//KKlsqblN9hrJCe7/aZIpkKJlxEtuYEjNlBX67Cw3Jgz/pQKy2+vWUhiGLm52PH2ObST/MBVf7VZ
	Zeg+X8o7hW0YRIm9v7PZLsnPrNoTVoEU0O4WMjIgxIcN+ufS8UHeH630mQDJNP1AK6pU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tD2XC-00Dg4Q-2X; Mon, 18 Nov 2024 15:15:22 +0100
Date: Mon, 18 Nov 2024 15:15:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qt2025: simplify Result<()> in probe
 return
Message-ID: <2f3b1fc2-70b1-4ffe-b41c-09b52ce21277@lunn.ch>
References: <20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in>

On Mon, Nov 18, 2024 at 06:39:34PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> probe returns a `Result<()>` type, which can be simplified as `Result`,
> due to default type parameters being unit `()` and `Error` types. This
> maintains a consistent usage of `Result` throughout codebase.
> 
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Miguel has already pointed out, this is probably not sufficient for a
signed-off-by: You need a real name here, in order to keep the lawyers happy.

Also, each subsystem has its own way of doing things. Please take a
read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

