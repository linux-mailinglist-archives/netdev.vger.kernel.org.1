Return-Path: <netdev+bounces-84650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D4897B85
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2351C25CCA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA815696F;
	Wed,  3 Apr 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q32+4L2G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96D156966
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182822; cv=none; b=UytSQJFAn0AjWoJvuKaEjFlwPHPq/R75TxyAY1QLAkx40mThy0eUOISQwlkeisECoWGm/LFqqlCz5QEYO7keHVzNk6GRXMrk01FPfqglrZdnM/bZSuW3GQv7MgHgCN/E0QUGwOKmq0L7QrR2VNj7aytijbyA63Dh6e1zX2OE6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182822; c=relaxed/simple;
	bh=p9hiveuG/hC3A8++MF36jAF6fAZRZ3FdL3pSH58LOnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSFGYGFjOlrFpX9o9CeEMTF4ldIT3ORwIt7q9datJX03vpTSchsXkQWKLxXDTJ3nx2twy0gA5NySMetkxVU05XZ7YKM2Lgsr7V4FliHKG4+B00M6hGhl9EYE9+wrQ9VoYszokfgH1uqwYCguL1Bwbynd1GX72xi4NmvoN2OZtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q32+4L2G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3GtwOcB7n3mzhGqoKD6rswc5N6DYnHKqbMCIrcsoaLo=; b=q32+4L2GkvWdYPKDGVcI2Hyx4m
	ZRgN59V1i3EdGTP3mg6uZogGtSgZOfquqWDtGe7RrSTilA97sBbrCSyD4blEWi7GdnSnvYJ5uFRoU
	v1P7cP6iWBSJyx6GCnRog7cka7nBN4z8bCyMt7kx5HATYmwSilAHK7r88O/MXQSZa9A4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs8xs-00C7b2-8h; Thu, 04 Apr 2024 00:20:16 +0200
Date: Thu, 4 Apr 2024 00:20:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's
 NIC driver
Message-ID: <9992d028-c51a-4086-9c98-006d980dd508@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
 <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch>
 <CAKgT0UeBva+gCVHbqS2DL-0dUMSmq883cE6C1JqnehgCUUDBTQ@mail.gmail.com>
 <19c2a4be-428f-4fc6-b344-704f314aee95@lunn.ch>
 <CAKgT0UeZ1zzJNOcTbiJYzG0_HeDW2jFKkSSSogR-gU+-mRZhYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeZ1zzJNOcTbiJYzG0_HeDW2jFKkSSSogR-gU+-mRZhYQ@mail.gmail.com>

> I would say it depends. Are you trying to boot off of all 167 devices?

If i'm doing some sort of odd boot setup, i generally TFTP boot the
kernel, and then use NFS root. And i have everything built in. It not
finding the root fs because networking is FUBAR is pretty obvious. Bin
there, done that.

Please keep in mind the users here. This is a data centre NIC, not a
'grandma and grandpa' device which as the designated IT expert of the
family i need to help make work. Can the operators of Meta data
centres really not understand lsmod? Cannot look in /sys?

       Andrew


