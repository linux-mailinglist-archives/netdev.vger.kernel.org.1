Return-Path: <netdev+bounces-185990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E42A9C9D8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793C11B61593
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F92472A0;
	Fri, 25 Apr 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X9iw1XwW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667F1F1520
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586722; cv=none; b=mdGeePWSSQ6eK92Nhvtqp7uNKJNvk65rK7FhUHhkhW616971Dz1fcDCnZVRC3/WcK7TOTt84h0NFgB8z4gQsxe7jdYHPFGokxJROKYkKXTsLU98cQ/YPGveGg2C7JBMT7L+k1eIg1/frh6RuHxiJYVL/3kY5VTOaZvjXUn9SOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586722; c=relaxed/simple;
	bh=ok273Re/47yENxhCBkVAZl3sTc0FoBC3QT/sloab4ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpqYtGGSmZFOSySHhxy8s9XpKmRs17Re3686Naw7mLrNcGYnNjoVd6O8YBND4fOe5j/dc7jYegxt1cgX858PGcbf+rt6kaWHw0bm4+kElBqJUIiiLSjGku8mVF58Iu6o5Gju5Sb2Lt1elQEBrSK/fEKgXZM2LmLOQm6/00XjHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X9iw1XwW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=50s/4PLw8Huk/h1SRtwzLcx0CiCuZJqNMymhkG2yWWI=; b=X9iw1XwWqIKV91DXxnDZ+adC81
	jwy+7KTzdSePxxScxrcWLykIj2PPeLfBdIwYhErGk5Fb311U0yB+HeRCXTJnzGeM+qwVu2blgIz8h
	p09SzE5QzP/2Qa1e5COspdqma4NW9a8t9hH1g8PNEArk1MAw3yQYXqtY9JT2LDRzACUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u8IqS-00AZw2-B9; Fri, 25 Apr 2025 15:11:56 +0200
Date: Fri, 25 Apr 2025 15:11:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <d2c690d2-d0f7-4fe2-9e8f-08e71e543901@lunn.ch>
References: <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
 <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
 <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch>
 <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
 <3e37228e-c0a9-4198-98d3-a35cc77dbd94@lunn.ch>
 <CAKgT0Ufm1T59r4Zn48_8gkOi=g0oqH5fvP+Gtxu0Wn9D5jNdaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ufm1T59r4Zn48_8gkOi=g0oqH5fvP+Gtxu0Wn9D5jNdaw@mail.gmail.com>

> Part of the issue would be who owns the I2C driver. Both the firmware
> and the host would need access to it. Rather than having to do a
> handoff for that it is easier to have the firmware maintain the driver
> and just process the requests for us via mailbox IPC calls.

How do you incorporate that into sfp.c? sfp_i2c_configure() and
sfp_i2c_get() expect a Linux I2C bus, since this is supposed to be a
plain simple I2C bus. I'm not sure we want to encourage other
abstractions of an I2C bus than the current Linux I2C bus abstraction.

	Andrew

