Return-Path: <netdev+bounces-188986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F9AAFC07
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A464C3AB796
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F222D781;
	Thu,  8 May 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ysvlySLH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908022D78A;
	Thu,  8 May 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712205; cv=none; b=La570c5xJ6kt1BBqwjtM5CW0YoKLY8oQRH15vZrzLy+HJzvKPzzafx/B6pI9MOo21WFDAnWYnvr2ACSZ0wLJZGRxek3sKkTvEybFfkOX6+bRfQYeFDvLiooAl6UUGsLVyOLnDFy4SiH+HiXCmGrpq0BqrS+tHqqZ6h8QjGgVrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712205; c=relaxed/simple;
	bh=0EyK9e2+4H7Pex31IKdbeRr3vnvhsMjNR005z+yFXpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSQ+7H83Hese7oDuu/pfTa+JC3OOmKxJhq4etGOr2a3mYNaoNHdsqJPdTIQshlQaEZHEPxHCHb7DE4YcqwyCV3tPEGFUVqjBpvyPNrRfrb81nYapSZAh+Uh1BqUfwlmLnlg6MBKSRDMNWKSCRibQe9XXtJAtTEIddtP5PKwJodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ysvlySLH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BBMQ5XTCwDcUX/+sOEWH7t5+cMaTPyMq//LBTJtsKY8=; b=ys
	vlySLHv8o9A2OWFk99RrKHE2IeH1Sokua9EuNVzJ8fkQ+lyundNB+n90ofBh1FjvYNmk4FqeTRTpC
	DfuEjO/lkbt+dbMvGC234hA4rE9YaewVi539YJ8akGZGLRmT785gHoqaG6LoyBpNTr4cBoKArO6ar
	p9uE5YGeiyG9QxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uD1dH-00C0U7-0a; Thu, 08 May 2025 15:49:51 +0200
Date: Thu, 8 May 2025 15:49:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ozgur Kara <ozgur@goosey.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethernet: Fixe issue in nvmem_get_mac_address()
 where invalid mac addresses
Message-ID: <2dce66e0-2a06-46bb-b1a2-cb5be1756fbd@lunn.ch>
References: <01100196adabd0d2-24bf9783-b3d5-4566-9f98-9eda0c1f4833-000000@eu-north-1.amazonses.com>
 <c18ef0d0-d716-4d04-9a01-59defc8bb56e@lunn.ch>
 <01100196afe6cdc1-41e8d610-06b8-4e6a-bc41-d01d9844df3b-000000@eu-north-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01100196afe6cdc1-41e8d610-06b8-4e6a-bc41-d01d9844df3b-000000@eu-north-1.amazonses.com>

On Thu, May 08, 2025 at 12:37:40PM +0000, Ozgur Kara wrote:
> Andrew Lunn <andrew@lunn.ch>, 8 May 2025 Per, 15:01 tarihinde şunu yazdı:
> >
> > On Thu, May 08, 2025 at 02:14:00AM +0000, Ozgur Kara wrote:
> > > From: Ozgur Karatas <ozgur@goosey.org>
> > >
> > > it's necessary to log error returned from
> > > fwnode_property_read_u8_array because there is no detailed information
> > > when addr returns an invalid mac address.
> > >
> > > kfree(mac) should actually be marked as kfree((void *)mac) because mac
> > > pointer is of type const void * and type conversion is required so
> > > data returned from nvmem_cell_read() is of same type.
> >
> > What warning do you see from the compiler?
> 
> Hello Andrew,
> 
> My compiler didnt give an error to this but we had to declare that
> pointer would be used as a memory block not data and i added (void *)
> because i was hoping that mac variable would use it to safely remove
> const so expect a parameter of type void * avoid possible compiler
> incompatibilities.
> I guess, however if mac is a pointer of a different type (i guess)  we
> use kfree(mac) without converting it to (void *) type compiler may
> give an error.

/**
 * kfree - free previously allocated memory
 * @object: pointer returned by kmalloc() or kmem_cache_alloc()
 *
 * If @object is NULL, no operation is performed.
 */
void kfree(const void *object)
{

So kfree() expects a const void *.

int nvmem_get_mac_address(struct device *dev, void *addrbuf)
{
	struct nvmem_cell *cell;
	const void *mac;

mac is a const void *

In general, casts should not be used, the indicate bad design. But the
cast you are adding appears to be wrong, which is even worse.

	Andrew

