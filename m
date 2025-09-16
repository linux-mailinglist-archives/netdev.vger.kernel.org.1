Return-Path: <netdev+bounces-223705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83597B5A18B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9247B7B66F4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B727A442;
	Tue, 16 Sep 2025 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TYbtWmQd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63582D7DF2;
	Tue, 16 Sep 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051397; cv=none; b=ttPHb71W9C0Z7zMb0C6LzrZsN/eNbt2UYHYforEKJ6eJhnKP+IlUTkb4QbcVSVMd4/hr34Vx1e1IC9wnIueohzjE9Qmo5cu4eg2Oj834jEo3Pq+gUYwOrfY/FUufYZaNmWwow5LmNAsYEt/UJBIFXSxhaV3g/VZW5C9GO1sbuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051397; c=relaxed/simple;
	bh=Wvf3CRlex5A67yULWvZhkX7JJVibOm8kYl97GzFho6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1KbIG/d3YMx88hXMyUl8odvDxkSQ7ZcJvTGFAQcbeYpa2IRYvVjKG38Xpbc9BUFORyZs6hSPR5ANwwDAs7wy6DnA4MxTo8MorEiTLGoS76uSa7pR8z+hJ/bzTQs64LLeXDJ5mdZplwyvzcYCiVGWIMTfdi0Xb2GXGUtSKE5vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TYbtWmQd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AaJPIyH7F5dhR2/nGCajaIe+q8ITXHr5yM5P7k34RUc=; b=TYbtWmQdNFR82w4Oap0ApPXaPR
	gmPIH/gQA9ze2JJem0CyqdqRddcPJ2BPJGxGrK5eYB4gnHTdpBTwL6KobOsgW6H/pSd0QFbUTJfRB
	yH2bfIuSTliTwH+EsuQgDYU5mhOVIsWoCoApRo5LEJqa2gxGWOVhWywAewn5u8eMKh7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uybTY-008bTd-NZ; Tue, 16 Sep 2025 21:36:28 +0200
Date: Tue, 16 Sep 2025 21:36:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: dlink: handle copy_thresh allocation
 failure
Message-ID: <6ab6f484-5ad0-4135-97cd-e5b0af6f691f@lunn.ch>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
 <20250916183305.2808-3-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916183305.2808-3-yyyynoom@gmail.com>

On Wed, Sep 17, 2025 at 03:33:05AM +0900, Yeounsu Moon wrote:
> The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
> If the allocation failed, dereferencing `skb->protocol` could lead to a
> NULL pointer dereference.
> 
> This patch adds proper error handling by falling back to the `else` clause
> when the allocation fails.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

