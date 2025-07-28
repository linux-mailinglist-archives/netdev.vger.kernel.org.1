Return-Path: <netdev+bounces-210435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5E9B1355B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580CD3AA658
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F13224B03;
	Mon, 28 Jul 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcQtNXXM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BF223DC6
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686590; cv=none; b=QbI//70r3whj0NAHaoW7X9Y7bYbRmm0RhGmUS9eRP75h8tZ8mU710LWTbMLxc4fXDTnw3ynLwTvw7zxGns0uBtRvwc+YkZXzVjE83L9x6DogsmxiznbXrbux0aA5Hoe3MmkWxYvLnX3zLivx8tk2XEqFgSZaqvnFtBjb8WfY/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686590; c=relaxed/simple;
	bh=5fXnGchnjHO4TOWfhXO75IOuOawIJKqMIt/0YfGbIlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJx9sKXeHB5/vwyuEHA7mK2ERZ0vp7JbZaVcc4hkAh/f2Ra4gAkkhPd1RLsQpfOw82vPAkkMnZ+tTTzHRxMvclVQH5z9GrzC+xR3diDDw415LeTvAuPOtHty0D8QkuYqRXtjwBzRzgrlFj2zuce+NuF4jKRet6XFnYVuDYB01vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcQtNXXM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753686588; x=1785222588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fXnGchnjHO4TOWfhXO75IOuOawIJKqMIt/0YfGbIlI=;
  b=mcQtNXXMvi8n72KsYO9aN6k3AcMBCKfgKX1W2t3zWDfwLzJ30QwQXwIG
   wkEnWn/3i3ye8TljV7brI2iaeqvA58ozvO6I+lO1wy8ID4xkJbdMKna8m
   UsT3Cx1wD4rjbnwYt9Brs+5tZsZ+TW+ONDLWLTR9DGMYV6D9c3KlXpOh/
   XieStcNHHgpxPAX1dnxGSKvJHPDR2Y5XUrzNIDcwBP2XSgpYMR5utVx58
   PXyPbhiSju/wCBSSTMRCX7Hm5ucF25v5lz9xAWouA3PekXB0WkDkiOz7c
   GJblzGQfTy9V7QIKEvmBphk0gBfTI4paREiB71eqWMDthDJOwzoRf9453
   Q==;
X-CSE-ConnectionGUID: nxmrbkcBSPGZr4jFI4WuUw==
X-CSE-MsgGUID: EZ+LMZmwTdmX7Aehfusoqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55894491"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55894491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 00:09:48 -0700
X-CSE-ConnectionGUID: JfkGzxs7T2OjKUqdquzJ3g==
X-CSE-MsgGUID: uitf9B/BSoedRaB3UlDR0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162399126"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 00:09:45 -0700
Date: Mon, 28 Jul 2025 09:08:31 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com, larysa.zaremba@intel.com
Subject: Re: [PATCH net-next 5/8] libie: add adminq helper for converting err
 to str
Message-ID: <aIch76xAiGUWd2/b@mev-dev.igk.intel.com>
References: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
 <20250724182826.3758850-6-anthony.l.nguyen@intel.com>
 <20250725160930.23f9c420@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725160930.23f9c420@kernel.org>

On Fri, Jul 25, 2025 at 04:09:30PM -0700, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 11:28:21 -0700 Tony Nguyen wrote:
> > +const char *libie_aq_str(enum libie_aq_err err)
> > +{
> > +	if (err >= ARRAY_SIZE(libie_aq_str_arr) ||
> > +	    !libie_aq_str_arr[err])
> > +		err = __LIBIE_AQ_STR_NUM;
> > +
> > +	return libie_aq_str_arr[err];
> 
> All the LIBIE error values map to the POSIX ones, right? And this is
> mostly used in error messages. So why not use %pe I wonder..

Hi,

unfortunately no, not all values are mapped correctly (I don't know why,
just FW thing probably :( ).

