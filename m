Return-Path: <netdev+bounces-193605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE8AC4C4D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870A7189E4B3
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6912472BF;
	Tue, 27 May 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3DoaXCa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813B4315C
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342042; cv=none; b=A3vAiWKhEzXjqctX/4iBb1uD0x7NsIqNOXno1unp15tnunpS6BEARRnF2bBeIkB3AOJEQXsSzVy7Yi47fGwPzUQJSLRvuYbteCKlCYwRtFeSsrmoH+Gg9kgTnzXry5QqULQ09S525zHagfQaCcZPrMxkh/YxY1dPok2yl6CydpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342042; c=relaxed/simple;
	bh=/sXIZErf6k3wzy66bgvlT1IymRhPSE1K1esXEiM3KAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT81I33AXN1vjjxSKThVbtiK2aX2mCvKs3T2B63wqh8AJ1elA6VszG293sqNsvI+USbEmyIxS0G3ub5rPaFwoJ0OpvLjNwm1FtZ3kQmjWhTh/opPU/GBNfOz3Ht1x1vEM2fNwW57nRC289jTYm6ewftg7I/gp6A1yhiuoQ3E7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3DoaXCa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748342041; x=1779878041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/sXIZErf6k3wzy66bgvlT1IymRhPSE1K1esXEiM3KAU=;
  b=b3DoaXCaRpm0m4Nx94LT9TXbsUjzLBWKr1jLWuHsHrYEx2h9XGWFgnVV
   wWPaaJ3d/O7oJI6ooGGAlS22tki5BicMzXRnKCAwvvRfFihUo1iSEpj7X
   0HLGO9Rjvnx1IWOv0bawAyxP/2SzjbTZwFGesjESyuEgTv092q4Ev/5G8
   Q4kAecDWV9A3ChFqZYjQ7fckmVB+/X2O0Fimp/xhBfzTnZ/rOD/kXgjb0
   gfLqP7SXGEK5WifRmGeSkC47TaHm0wZjOErYuOEOmPf3+bRrutjQxMVk2
   PujoRwotV93yrGDrejjo5Ka2ZR9IDC2zOpxj4iebqsfv+CuMKyDvS5lvs
   g==;
X-CSE-ConnectionGUID: B6qGtkItTGWHm51PHIBIbA==
X-CSE-MsgGUID: BSlVTMT4SMW6AA2K30+BwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60575517"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="60575517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 03:34:00 -0700
X-CSE-ConnectionGUID: zX6uEHb6Sp2QVJfCiEuTgQ==
X-CSE-MsgGUID: Y47J0XAaTsu57jH+Yk0/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="146633571"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 27 May 2025 03:33:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BEF07139; Tue, 27 May 2025 13:33:56 +0300 (EEST)
Date: Tue, 27 May 2025 13:33:56 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <20250527103356.GS88033@black.fi.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <20250526120413.GQ88033@black.fi.intel.com>
 <55F20E80-6382-43EA-91E0-C3B2237D79B7@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55F20E80-6382-43EA-91E0-C3B2237D79B7@bejarano.io>

On Mon, May 26, 2025 at 06:10:44PM +0200, Ricard Bejarano wrote:
> > Do you see that asymmetry with only single link? E.g with two (just two)
> > hosts? If yes can you provide full dmesg of the both sides?
> 
> No. You can see that in [4.6.1a] and [4.6.1a]. When red and blue talk to each
> other directly, speed is ~9Gbps both ways.

Okay that's good to know.

One thing that may or may not affect but I think is worth mentioning. The
hardware has support for end-to-end flow control to avoid packet loss and
that's enabled by default. You can turn it off by passing
"thunderbolt_net.e2e=0" in the kernel command line (or when loading the
module).

