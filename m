Return-Path: <netdev+bounces-102078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E18B9015BB
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243DA1F21671
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B4208A5;
	Sun,  9 Jun 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YOKh9q1W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4BAD23
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929734; cv=none; b=jIbrxjkMukTguBtrAMXj3IhH6AoukzBatuA5jVADyMXRQ7s04n9e8/siOVzqOzRjeBpkUd1Z+DfepWhpwx+AoUgc8jgHEEF/5v3bWJ4f4pduSZkV/EmhrrJijvd484/5unr+OS62Cdx73GNGCzMtIdI9OfXK24+dX15U+e/t2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929734; c=relaxed/simple;
	bh=cMe7a1icw7IbnS/jsU6ZBL6w30yoff7iysN4RVc0S6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB7KkAHd4uHED0ymIUbtlWCsV7v/EPcQ7jqyOlWiNVT89RPny7DvunNoMHOFeB6/IRj6Ppu7/X9TbFVy+MoalSaCpoT539Orpsz0yMP8XXItGHw7Rqt/iZItYcv0rOOyaGzY71x2eNn5mhLjfrGTHizcEPnOdGpBAYSh1TtPH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YOKh9q1W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wOsJuXKcGSZI9dc2sRxa2aWRd7QmgjPMuX5pk/n7v/E=; b=YOKh9q1Wfalz54+zeJjL7jkHVu
	5agNKh/nU9tapR6uy9H+w9VZglpe5ggyKKMEH8A/+fX+t116AfjILUgLlLJa4i3ZeHQlmTqaAAKmt
	WiXdo1IO3TjRP9+tnkAcyBnLUonz2GEOpfVVUzcL4YgQcHvmPlJ0/cQNu5UpNBH8vA/AXqQFSI7rU
	OQTuTjdoQt0F9S3Qs+PEpEk/hKlN7IzGN0fcTh1dnFRUHmDpoggyGsxonmeD2Uk9FgD6hEKyRkJ4R
	p7PHwUm0K1bbvhDsE2eXdIMN9ZbGQUdU1pf9Rv8o7jENmyB6mrHnT62LFwQJpqa0Ew0ooteEDTvxq
	Qr0b0TBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52096)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGFzw-0000R2-0l;
	Sun, 09 Jun 2024 11:42:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGFzx-0005tg-St; Sun, 09 Jun 2024 11:42:05 +0100
Date: Sun, 9 Jun 2024 11:42:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
Message-ID: <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jun 09, 2024 at 11:10:54AM +0200, Hans-Frieder Vogt wrote:
> I have also tested your driver, however since I have 10GBASE-T cards
> with x3310 and aqr105 phys I had to add a few lines (very few!) to make
> them work. Therefore, formally I cannot claim to have tested exactly
> your patches.
> Once your driver is out, I will post patches for supporting the other phys.
> Thanks for taking the effort of mainlining this driver!

Still, it would be useful to know what those changes were, even if they
aren't formal patches.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

