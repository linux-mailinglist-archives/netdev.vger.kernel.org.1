Return-Path: <netdev+bounces-179436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A00A7CA02
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D531898784
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8A535D8;
	Sat,  5 Apr 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EAsuTVOZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C31D52B
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743868344; cv=none; b=XDioBAQNZvKrs19VmBOIgY1V08Qr94sI6O4ZPyCFrtTWgpaDfJ9lkfHZqdUmYdCWu7+OZmz408l0CHZ17g4GrM4cJ4GHO2G0t+mNw7mJLblwubd2QgG5yxGsEXD8+4e7OnUmNffDEVA+g4IxxfAIcMQ0SefY1dfpZm6alR8IRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743868344; c=relaxed/simple;
	bh=meEHZTOGgpmVs9ZVl22qSCn0eVlawXYveTIdmgHykQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYQAYrJymGJNZkzmTfJt3xR8xfV3eQA3GSOpzQotvQEYrILvbfE6I6UWwP4xTdg7zOwXKAffcFL95ovEahvJQDXbsrSr10a3/1gc259KBTPtr0izl0CRlKAlrxPxpFPIUtaSqBJpOqSWoEGtdNtEDD+oOScTIROLdynzvM4J8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EAsuTVOZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vFmzxxsJRMwkhu9h5ng1gYnUrihmT+8O7JaW/N79IJQ=; b=EAsuTVOZN2MYGgklHg38B8UueE
	qSF2l/j7zlezzTH/1yFnonAwfZ9K+7JUNKdsB5RhATfXyNHxZnPmb4nh+23LmhfsmaxOs8aTlrNO9
	oYDlYxacT7Vl0oBC9NOwB0aOKXE5hWV3eP7g4K4Ks1UhKUmTRzk2KX+VE8nlFL/NbNgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u15of-0087X5-0R; Sat, 05 Apr 2025 17:52:17 +0200
Date: Sat, 5 Apr 2025 17:52:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <2f09e79a-fbc3-439d-bd51-13b50f04395a@lunn.ch>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
 <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk>

> Hmm, I'm guessing 50G is defined in 802.3 after the 2018 edition (which
> is the latest I have at the moment.)

I have 2022 edition to hand. Clause 131 is Introduction to 50 GB/s
networks. Clause 132 is the RS sublayer. Clause 133 is the PCS. Clause
134 RS-FEC, etc.

IEEE makes 802.3 free to download, along with all the other 802
standard, although it always takes me a while to find where to
download it from.

	Andrew


