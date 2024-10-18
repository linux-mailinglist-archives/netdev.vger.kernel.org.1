Return-Path: <netdev+bounces-137005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA99A3F0F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33D51F24EC4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F01E49F;
	Fri, 18 Oct 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BU08sEq2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960D1CD2B
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256508; cv=none; b=qIbI0WBbjTY+VTm+4Ue4fQ0BA2UwVF0ArYWCOEcTYdU1/65B4Z4UndGMr4UuDOA8W+NpE27VcwowMjlNIQv4TjZ+Qp0nPr6hHGe9jj66MaMrBzIdUY/ym6Y7tIEh4w2G1yZSD7Z152kJFfL0Px0ICWfKkqsIOctCZfTP0hFYM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256508; c=relaxed/simple;
	bh=mStUNjabKx12iWSfi46kkz26Xyj85ONFbsvZKzpGWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXh0d9RXQDhngesFDAI+/KyeRuchBzTxFoTGs0qLqWPH++yAKbHRS+SKPSLmULfxsCuLFygFA7aZmrRfrq46MDqFME6i1QJdwOKlvsV8eRkZ/e0tzo8GV0MGmzg9sXNAobLYgOHIbQSXNLZlbp96hsR39EyH95Tl7Tzu5cc54rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BU08sEq2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gTOCzT2gZJAtZ0HjofC8U/1UdSDZj+Dwd1U6LVTwhZQ=; b=BU08sEq26D7gtMmph9HsKQpgfd
	y/XuCQmYu2LYnBsUG/zzOtkmSCvbUtBRMyaPS9GWieyO40XBsHMEua9JB9nuBOyNHU9jwtQPU90KT
	mX8PpI0ZboRcr2F5dfhqgh5itTk4YrGTkykB8KG44wJPCHjQMJSLP91NimMkT0y3wpVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1mbi-00AXFL-P9; Fri, 18 Oct 2024 15:01:30 +0200
Date: Fri, 18 Oct 2024 15:01:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Pengyu Ma <mapengyu@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: avoid unsolicited interrupts
Message-ID: <5741e028-2a3a-4368-b14d-3b93d3998b0a@lunn.ch>
References: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
 <e34dad2c-7920-4024-9497-f4f9aea4a93f@gmail.com>
 <83fc1742-5cd6-4e67-a96d-62d5ec88dfb7@lunn.ch>
 <c580367c-7f66-4f3a-bfe4-53e5103e200c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c580367c-7f66-4f3a-bfe4-53e5103e200c@gmail.com>

> > You should be able to mark your own patches are change request etc.
> > 
> When doing this years ago, don't recall which subsystem it was, the maintainer
> wasn't too happy that somebody else was changing the status of patches in patchwork.
> Next time I'll do so, thanks for the hint.

To clarify, you can change it using the pw-bot.

Put

pw-bot: cr
 
somewhere in the email to set it to Change Request.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

	Andrew

