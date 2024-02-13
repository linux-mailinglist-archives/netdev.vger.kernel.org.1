Return-Path: <netdev+bounces-71354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E18530FA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B0F1C244B3
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7C42076;
	Tue, 13 Feb 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gr2GhOHN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376141C75
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828890; cv=none; b=k90ryz5Dne10w0SZMT7qZUiYEAb0KiCMnHRyUMf+Nhg8qQo/ijkeQkN83GXKRpoV065jnkOspB6F4FfsVo0asZJIEV+woLhqZT7B6MsiGnNwOLkWBV9/WWwmpc6ZTWs+PKztB+wWA2k2jNea01PXVYvX1zO62/kJSr/fimh/nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828890; c=relaxed/simple;
	bh=V/e93psDKz9e7aHcG47Yz9ESWT0sIpc4LVeZ1f+xoNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD9ZdsDRTjxLphpSRKvI4jOqpBBmlBEZ2dzgKqThDNnYsT3bMrHatERjVrl4S/z/EBm/hstMY+h2jOf+q288RgxMr36nvUDMT9rpm/BspPjA/o6G4KCFESnlW+0OyBZWCpLBHmTFpj5mmmqECnTkA3FsV5IG5scUJNrBfBuOtf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gr2GhOHN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UYncPc5pXhynPMdvHIemtFvifWtO1wYMxJtAF98JlN8=; b=Gr2GhOHNqtQUaQQ6m1BNiooqLa
	qPgLT7X0gOuOKRWTDdN1SRQeE4SetKghb/Z/0d4+0OQzz0Fn/XL6GPWwT/Eua6pQcHOwOILavrRZ9
	O4E0gjXBB6iyuSugVOtb+/upykDZezChXTxJoo81J1nXg4dhVChmpcxDXpp32UdnV4go=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZsJG-007g0R-JI; Tue, 13 Feb 2024 13:54:50 +0100
Date: Tue, 13 Feb 2024 13:54:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] r8169: add generic rtl_set_eee_txidle_timer
 function
Message-ID: <c200f133-62c9-45d0-a6b5-4e02e60ec688@lunn.ch>
References: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
 <39beed72-0dc4-4c45-8899-b72c43ab62a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39beed72-0dc4-4c45-8899-b72c43ab62a7@gmail.com>

On Mon, Feb 12, 2024 at 07:57:46PM +0100, Heiner Kallweit wrote:
> Add a generic setter for the EEE tx idle timer and use it with all
> RTL8125/RTL8126 chip versions, in line with the vendor driver.
> This prepares for adding EEE tx idle timer support for additional
> chip versions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


