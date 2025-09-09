Return-Path: <netdev+bounces-221439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F2B50819
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71F57B14DE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ECE258CE5;
	Tue,  9 Sep 2025 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="grssF5w0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6225784B
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453150; cv=none; b=U5aUgoJeK4xIKJwSuOR+TFbS6D92qcJqPR3ZJwLFNa1pIJzbIIoKDsN0p6tvUgV069XScTG9m5a8+/KF27EEdHa5TlY4gSIa7TxbVcfYoUbp4lPGwzNCf5S3s+jpykFXWxSnWjGzJdOvlh3fTyGfCuDmQnRzCjIZ/ma9vz5KwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453150; c=relaxed/simple;
	bh=HG1aKiwbbCft2voaaYtu/ctNPoefTRZYls1eG2q5yg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRzo6VO3oZFdKIVLJCzWNhIe0i1SjdCFNqDdm5RAO3LIfD+WfS6gE1RG6jhNRZ+cCIKzyjCwSodrJHlZwkxY+3/p7/sNs7MZaJKiSDgnRfbkCg3UYyTC0ERrV/bSd4Y0dwCvW6Q7bVCKulgNn7Qqa3RJO7GN+xGRqzalRywfcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=grssF5w0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wA97SVeRE8m5kCwvAAtJ15YmZ0r/gr2hTp2sNS3o7Y0=; b=grssF5w0A4BaF2fHwNqT5PPLcS
	eXiOiUMn3AATnqJyxH10FRopY1oKABqb8aHU3c7DK9NVQ0kUMhTkcCNwNffoUM+ogC8cZMdtcjn7u
	/uA9UgOu6mJgD2+ZwgDDRmBq7kS3Ov2vocID0EIwB2eZNRl4fHmeWYgwGGfx1AOnjx0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw5qM-007rTJ-E6; Tue, 09 Sep 2025 23:25:38 +0200
Date: Tue, 9 Sep 2025 23:25:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] of: mdio: warn if deprecated fixed-link
 binding is used
Message-ID: <b5db5bc3-9336-4724-9c38-ad758bc1703e@lunn.ch>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
 <d2910abd-a20c-49f3-ac1f-ff9274ed75d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2910abd-a20c-49f3-ac1f-ff9274ed75d7@gmail.com>

On Tue, Sep 09, 2025 at 09:15:35PM +0200, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

