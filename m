Return-Path: <netdev+bounces-216055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E56B31C52
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB551D25A3D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4217330DD09;
	Fri, 22 Aug 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ouDdew2s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71239308F16;
	Fri, 22 Aug 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873284; cv=none; b=tFJ3t5hRBmJXuWkPNAvvzIB4Hp08rEx9aYQS9CSHeMwgRg+Ww1a7R4bZtyRKmZi8U1KhLHiHpWDF3feoOnuW1qa1sgLY6cORKL6g6E7VWKyrDiJBZYcthG4x6BRDE6iEll3VjfvSLGpshN9REnWFxmM+lTYtgSELFGEx/f8qbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873284; c=relaxed/simple;
	bh=VII7U6zoNNMy6Odpt6FG1UI25vengIXA2fltFhm+W7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0i+WwGJuV0MSPEsNC/Hq5OZkApinVbUa00QkK7rmoLT7FY1Vh8wjVRFHzvaxtYVGwBgpLt95z8PNCzRzcabtYMXjg56KwluAsw+M17PdEboIhxt7MHIISeAPCVQShG0+lHnHBO6tt6x+qV0dAdZ0r28rQEHUnS9BYO4fNrFo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ouDdew2s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ogSGEAU2urSqL2qER3Zt/zAjp+FjNQ7ySdicQ6sxfPM=; b=ouDdew2scoE5UdbmgR+qZ6fyUY
	ixVCBd5kSQvJG2mCWuXRTFp+I/74SXkF0H7ZcKef+NiMw7BMrk7UeFBNoJwyL6M+EMIVVNV5Xohh8
	Bp/H+DUd8b5kGHuR0ljOFinlLEPzfAsuf7l6eZVz7YB1qALzU/l5O1IXgTdJn+IRg3DE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upSq2-005aXb-Dt; Fri, 22 Aug 2025 16:33:54 +0200
Date: Fri, 22 Aug 2025 16:33:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: Parthiban.Veerasooran@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <b488b893-389f-4c20-b2c3-23071279272c@lunn.ch>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
 <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
 <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>

> /* Initialized as a defensive measure to handle edge cases
>  * where try_cnt might be modified
>  */
>  int err = -EIO;

We don't use defensive code in the kernel. Defensive code suggests you
don't actually know what your driver is doing and you are guessing
this might happen. You should convince yourself it is
possible/impossible and write the code as needed.

	Andrew

