Return-Path: <netdev+bounces-235224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A3C2DC5A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567C23BBCA6
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316931D73F;
	Mon,  3 Nov 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OvyYtt9S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280931D392
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196378; cv=none; b=quQvmxKGjDZnmgnorc45Q1L1qy2A9oEFFmf998XAN3KT3aXFG7j1HAnOy8CcpDWZjpMmApSe/h3IF2JadtmjCx5kesMn2hqmU1LufWwphGDGSbW1cj1UCYch5d+N8FNOQS+fszrrSTq6+kT8t/ktq/cZT4CZ+au+Y480RrsTSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196378; c=relaxed/simple;
	bh=yfMSt3J3pEvw7IlLe0z2DcFR+2yxDUQf6QS0x4J59z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXhTHB6pQcSRnuYAKQW/lJgiUkZ0Gkz/zI0lLd6nWfY/QRiRASqD95R8zV6W+rfzC7S2CEcx7ggsgiFm7U2AwdxgiZD0FlhCDuYsW9ErMI/kIhI+zhs1CaO9fk1yYKnxIBYhauiP7FG+It/QzZ5pk24TwlP2VdvNPc5iyrSfDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OvyYtt9S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w5NM7xK46dcVQasHZbN7gcnKaDk/kkBxjUULcDw6NAM=; b=OvyYtt9Sk4DQJET4OarK1L+lbX
	qkEs9dM6Nm51FC5qDMHjeoxBAUv9hc51ABrWrJKcqwaA9X8K5upVhxjyOJtjxJNAG6qWVNWI8AxiK
	dAO7QpNbnTK1W/lXv/KCF8oaP/fShnigAj6nat/4ZAC3p5IzeEkoHV7ReltU5fqEQMeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFzm7-00Codi-Up; Mon, 03 Nov 2025 19:59:31 +0100
Date: Mon, 3 Nov 2025 19:59:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH v2 09/11] fbnic: Add SW shim for MDIO interface
 to PMA/PMD and PCS
Message-ID: <2fabbe4a-754d-40bb-ba10-48ef79df875c@lunn.ch>
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218926115.2759873.9672365918256502904.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176218926115.2759873.9672365918256502904.stgit@ahduyck-xeon-server.home.arpa>

> The interface will consist of 2 PHYs each consisting of a PMA/PMD and a PCS
> located at addresses 0 and 1.

I'm missing a bit of architecture here.

At least for speeds up to 10G, we have the MAC enumerate what it can
do, the PCS enumerates its capabilities, and we read the EERPOM of the
SFP to find out what it supports. From that, we can figure out the
subset of link modes which are supported, and configure the MAC and
PCS as required.

What information is missing from this picture that requires the
PMA/PMD to be represented? And how is this going to work when we do
have access to the SFPs EERPOM?

       Andrew

