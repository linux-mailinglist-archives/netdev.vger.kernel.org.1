Return-Path: <netdev+bounces-201433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CDAE9749
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98EA18914F0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F524EF6B;
	Thu, 26 Jun 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h5BvNrTI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0023314B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924549; cv=none; b=VH6/fZK1NYO5ocHDTFy3JxsogYvsSzqGdGwvGxwE4EMW0lLWpLTJorxAiVC5U+b+657EFEfzzQVbhoTsUGzLO2Ki30YPbWFkHBh4txKJgesZuegBGat6mf8L8/3WkNhcEajAPGmdIt1ITcSP6Oixjnes5lp4t3dm4Mhgid49Wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924549; c=relaxed/simple;
	bh=id9cGxOQNCIUAyYA2wfPW5gHcyxfGia18Dg+Yh58xkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrSXMxAIC8ip6x/kOcgizmCZG4rB3azDyPxstMFr1KBB2z8smmaSVeszX2xMK4WwylA3Jw/xqokFaK1AXVQlI96SEAjtOmP8Kob36Qpa4V5qQU5YKjDp9pzduBaC2+mJd3/IgF/wr4tNv1Aq9zd2IuKANQqIj+UtY2Fx6qhCwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h5BvNrTI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vbYGrzKotHJv1cmxdVVMnCffs6oL/R/yTEmIm6szdLs=; b=h5
	BvNrTIH7HE4zUWaNZKUhlp/nkw8uNacUaIop/unPcmPY2a5Dl+fLbyF9Ex4675QGFckmGitHRhmDG
	SkdCWlLxRyCdJWVM74eUlotORE2EkUVz3ezFK9QxFjDtpU8RWegNWEmJK7GGh1NCkzqNGsMI8+Ql6
	in6+osGD/eEZJXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUhSO-00H0w4-Qz; Thu, 26 Jun 2025 09:55:40 +0200
Date: Thu, 26 Jun 2025 09:55:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com, jiawenwu@net-swift.com
Subject: Re: [PATCH net-next v2 08/12] net: txgbevf: add phylink check flow
Message-ID: <f8b268e5-3f0c-4eed-9f78-2ec2be1ebd0e@lunn.ch>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
 <20250625102058.19898-9-mengyuanlou@net-swift.com>
 <71d0b663-c717-45a5-ae23-f5b91d199eac@lunn.ch>
 <B649FE55-96A3-4631-8714-51128EDEE810@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B649FE55-96A3-4631-8714-51128EDEE810@net-swift.com>

On Thu, Jun 26, 2025 at 02:31:36PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2025年6月26日 01:08，Andrew Lunn <andrew@lunn.ch> 写道：
> > 
> > On Wed, Jun 25, 2025 at 06:20:54PM +0800, Mengyuan Lou wrote:
> >> Add phylink support to wangxun 10/25/40G virtual functions.
> > 
> > What do you gain by having a phylink instance for a VF?
> > 
> > All the ops you define are basically NOPs. What is phylink actually
> > doing?
> 
> I think phylink helps me monitor the changes in link status and
> automatically set the netif status.
> Besides, I can also directly use the get_link_ksettings interface.

But does a VF have anything to return for get_link_ksettings?

My understanding of a VF is that it connects to a port of an embedded
switch.  There is no media as such for a VF. The media itself is
connected to another port of the switch, and you can get the link
status via the PF. Also, even if the media is down, you should be
still able to do VF to VF, via the switch.

What do other drivers do which implement VFs? i40? mlx5?

	Andrew

