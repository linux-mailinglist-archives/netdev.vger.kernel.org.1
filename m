Return-Path: <netdev+bounces-71355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A08530FB
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2198B1F2875D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD564207D;
	Tue, 13 Feb 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WlbE29+s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CCA383AE
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828919; cv=none; b=hKpOYMkV5A6chICq52I+dQvqL286gQjTVxaf/G1+rUPWXovt6A/dihZOjZ06QcmbWucdqs7B+cT2y6/t4FS0YwCSEmJHYxmMiZo+rQit63+kU74Ox81ih0zb/3H6RvO/yyZ8QWwHEMigfczRqf5dWnjOg8ni2oYXDC0jKfLS5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828919; c=relaxed/simple;
	bh=Wa9QqcwCvGFkqHp+sH92OyFxS+Qi3Usfh0kW8jKXKoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXHt/Za4q9BAmqHoy0ZHfGwoOrbowgGfk6jqwuAqGLaWlC4Muuhc+LrMOvXO2w2SwBvynMQ/TCNW6zPJhvASIJ6LGr5Ce5LO7Kudn2MBeXu8Tvi2xuTTqecQRMBJg1gj1/89A6JxHi3JNOoMhfBjYZ9E0KiNsiJWzh0kYLDwiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WlbE29+s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oabz1KQIlGi+X/ThyAApBSuu4arkZ5fgxWZZDain5js=; b=WlbE29+sKhFQW9DwyQlJwN+FJh
	QoEWUM+nMp478GCclKEKEei0qrXwe7nrCInqlYoBUnaz+ZjkAYuu1gvEKciROE4AzsyYOsa8SXVvH
	V934S1hWy2DVM8jmo+cy1TO81A+9nG0wrCGlSWRaSozAS4FFb7GYoXUWQuaqNkFzkT0M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZsJk-007g1C-5x; Tue, 13 Feb 2024 13:55:20 +0100
Date: Tue, 13 Feb 2024 13:55:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] r8169: support setting the EEE tx idle
 timer on RTL8168h
Message-ID: <dad2f680-2f76-4025-be68-ef4b8c535ee2@lunn.ch>
References: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
 <cfb69ec9-24c4-4aad-9909-fdae3088add4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb69ec9-24c4-4aad-9909-fdae3088add4@gmail.com>

On Mon, Feb 12, 2024 at 07:58:47PM +0100, Heiner Kallweit wrote:
> Support setting the EEE tx idle timer also on RTL8168h.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

