Return-Path: <netdev+bounces-175289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A18A64EB1
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1916CB89
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD34238169;
	Mon, 17 Mar 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a1u/V42i"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF98214A8F
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214271; cv=none; b=LKqFG8+d2LKVMeABpTyn17WtiM00Ep236PijT5g/pcUzpftcMsiKELcNQrH33tSaStIkBMezbBVDM94gpllMvivwlsLi4tVYEf85cHlnHkLDWWSGt4N9AN11dVePw+7MTXfUuaBs7lV9x0iXuNZGJMlJim76lJcG/qV0zmfvjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214271; c=relaxed/simple;
	bh=JOegZOnQMUIuBMQO11F/4BW/sIh7ZiD3dnoGY3CisQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeniPvthUuU3X3G7mHZXten1jhvIeQQGsfyXxR0t3zK6EUWADqWyCF8AgWiPVGTfJ8aMLYISjpPEVy9u7X03F+1kKO34573Wbk95+8ouo9Ebn2e/6bCJPsgKL5sw35tiJZyQ4C1bfbKuyeso1oTgTS3pH/uf5byhWzIwTKl4EH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a1u/V42i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tfqWM4Bh/OLWXhT8iiT4hZIQMbTtiaS4ZNbkgisaRBk=; b=a1u/V42ij63QHwMFQpxtVeBIlf
	ta5bWt9dplxV+fDU+iuHvPfIDN/iVJdFKucWq9uFoDLsJTyKNEI4NNCXwLTlnoG9K28gYZVn8mkmb
	doJflVjQkJBJngqQ9fD2BuPDJGYvriRBcO6eu65ERFIkejKPA/I/Xl6jc1gI2R2ybKbibJ8Zmygdk
	SZU8u9KfFFV4xzvno+t2XOcFMXpVnlus77sxyq8nWjKWCdFydHuW83Srd+DGoiggoDZXNUrtcOAVy
	2KntmfqrJ+UDxy0QuH/vashELfl8/BM1ZRvxLRfePWvY5f8oo6JP74z3o/UbTy5H24OaT97k3mjlB
	y7Ug0JRA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tu9W3-00000008gGR-2GX8;
	Mon, 17 Mar 2025 12:24:23 +0000
Date: Mon, 17 Mar 2025 12:24:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
Message-ID: <Z9gUd-5t8b5NX2wE@casper.infradead.org>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
 <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>
 <Z9Q7_wVfk-UXRYGl@casper.infradead.org>
 <a901bf8d-d531-43b5-a621-b2e932f67861@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a901bf8d-d531-43b5-a621-b2e932f67861@intel.com>

On Mon, Mar 17, 2025 at 09:55:44AM +0100, Przemek Kitszel wrote:
> On 3/14/25 15:23, Matthew Wilcox wrote:
> > On Fri, Mar 14, 2025 at 01:52:58PM +0100, Przemek Kitszel wrote:
> > > What about changing init flags instead, and add a new one for this
> > > purpose?, say:
> > > XA_FLAGS_ALLOC_RET0
> > 
> > No.  Dan's suggestion is better.  Actually, I'd go further and
> > make xa_alloc_cyclic() always do that.  People who want the wrapping
> > information get to call __xa_alloc_cyclic themselves.
> 
> Even better, LGTM!

Is that "I volunteer to do this"?

