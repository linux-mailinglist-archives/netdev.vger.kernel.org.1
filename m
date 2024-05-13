Return-Path: <netdev+bounces-96108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4EC8C45DA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BFB227FE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1DE20310;
	Mon, 13 May 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="trH6o5dc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7623748;
	Mon, 13 May 2024 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620667; cv=none; b=iQNnw/VwkSpdzyqhqyAS2QQ0UBw1lpwyeMJ3K7uzZbPBxeaWxUvcSQ07CYdJioIreSwnr5OsT7TU/oQH8CvntuAdsJCIA19g5jCX0clNU6p4WEDnXYh0QzH1oN94qGj4vJJgTWg+3l5QS4QR+KIFc+VjQfHOeHcgwE8l69bghxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620667; c=relaxed/simple;
	bh=xXJ2xfsVZr5m0SDYHs8VXPitjHPTAc8dVXhYkI6O4pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQHQEPK4FmeJho2J8uwUKVWguWEzRU4ftLN8EALpP9gsm/744iDpXufYSlDilWNjpNFXXeSwNFvmzlwPJs24dk1bE6HrM74sRD9Wlqs0lfMNYO3J2gvdaUZUX7tbXgKnVAtD7pEkNP7PlvVQsIHMRqBPIHgwTffiuLRk6ls0qNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=trH6o5dc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kat9PfXQHTpWcmnzIUnLFRT8Ol171C09OwLL2tg1hrw=; b=trH6o5dcxGkLEy9v84ytt6FOIY
	kpCeijP2gdbDv0W3Bvhdj1zpaKTrLZ4rgImC8Rz2Ao8HVsxX4k73KQbJ7Hn0a011q7D1L3t44JQXP
	INwRLsIUmHJUoUQ1Wi+PAND3K4/ySulbQrgDoPErM9Ncy9cFnfpDzru4GoX9S8/Uqys4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6ZIy-00FKAr-I1; Mon, 13 May 2024 19:17:40 +0200
Date: Mon, 13 May 2024 19:17:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	lukas.probsthain@googlemail.com
Subject: Re: Regression of e1000e (I219-LM) from 6.1.90 to 6.6.30
Message-ID: <b2897fda-08e8-40de-b78a-86e92bde41db@lunn.ch>
References: <ZkHSipExKpQC8bWJ@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkHSipExKpQC8bWJ@archie.me>

On Mon, May 13, 2024 at 03:42:50PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> <lukas.probsthain@googlemail.com> reported on Bugzilla
> (https://bugzilla.kernel.org/show_bug.cgi?id=218826) regression on his Thinkpad
> T480 with Intel I219-LM:
> 
> > After updating from kernel version 6.1.90 to 6.6.30, the e1000e driver exhibits a regression on a Lenovo Thinkpad T480 with an Intel I219-LM Ethernet controller.

Could you try a git bisect between these two kernel versions? You
might be able to limit it to drivers/net/ethernet/intel/e1000e, which
only had around 15 patches.

     Andrew

