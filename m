Return-Path: <netdev+bounces-91424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2138B2854
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687AF281708
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708AC12BF22;
	Thu, 25 Apr 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJeIoP+f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FF12C559
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070789; cv=none; b=WFuOCnKJ6+/VHM4/0KbQAkEbhFsXKPdCd8zpcHWjH/tkMfjzEetWHbf5V5Kdiot+Vd8nf2aq61CQgXSXNQNEYg8cbsZVDw8iJ3BUjwGUQ26QcSBdP4ZupAH9AkFpS1evK4qpYB7cHCSdXn02zqIDM5kP5FAdyOqCeLw0M3vssAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070789; c=relaxed/simple;
	bh=ZsDqYu4ojuh9VuiJbaNfZoanFnnda5qja2yT5h3wsto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VoRg7UXgCrYAkKuoNIqq5cgSXwmUcpPDcDolJpRVJN6/356CfNFSQajVdKqeGLeRYK3UcZP3voP/SpyEub0SiEqwLr0U16DlwWAud3J62Zr8RSGA+alGsbeJ2VS+SCnm7aSxbqAgKBVnB6KEsz7hM+OGcLgn4BKYB4F9XVtRTAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJeIoP+f; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714070788; x=1745606788;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZsDqYu4ojuh9VuiJbaNfZoanFnnda5qja2yT5h3wsto=;
  b=EJeIoP+f9DsIGS1QQpRext0zb0YEXuTXYmYss6314OJ6RhOtfwwVNBfK
   wFK0x2CSenhivThGtZpnKvjnzOJ8iXidJUuNyY3fqg6D1WiYGzdjpqaFi
   H7GHQZNhaw2sWoUvNEwqcBvcIVxkGMD9XaMD6evHvkPhLk52pWKXGncjO
   DE6JeU72tCRBGAiuZMHhyD4f5mQ7jgqsN/S5hcS7ynF6VYyXs5NXHrAGe
   DNSLd7C843Wwifh8G/AegWuNkLB6R5ob1NT3ReKi9jg553Pmh/zlqsMn3
   lXiu9lB+pTJRs/bm3DIhO6/IZdHnUmtd2aMtY93RPfw0DJMS6j06dfPT1
   w==;
X-CSE-ConnectionGUID: lhCNUF7LRCG/m3AhFkjGCA==
X-CSE-MsgGUID: T1kQVsMKR22ynHVAnVl69w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13569734"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="13569734"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 11:46:27 -0700
X-CSE-ConnectionGUID: pkPPmTyARQKBAQElP1o99A==
X-CSE-MsgGUID: itgeq33yQP+DFUv66C/KQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25666087"
Received: from unknown (HELO vcostago-mobl3) ([10.124.220.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 11:46:27 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix a log entry using
 uninitialized netdev
In-Reply-To: <ZioKlQR9z8RWGFAB@calimero.vinschen.de>
References: <20240423102455.901469-1-vinschen@redhat.com>
 <033cce07-fe8f-42e6-8c27-7afee87fe13c@lunn.ch> <8734raxq4z.fsf@intel.com>
 <ZioKlQR9z8RWGFAB@calimero.vinschen.de>
Date: Thu, 25 Apr 2024 11:46:26 -0700
Message-ID: <87r0etwa9p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Corinna Vinschen <vinschen@redhat.com> writes:

> On Apr 24 17:06, Vinicius Costa Gomes wrote:
>> Andrew Lunn <andrew@lunn.ch> writes:
>> 
>> > On Tue, Apr 23, 2024 at 12:24:54PM +0200, Corinna Vinschen wrote:
>> >> During successful probe, igc logs this:
>> >> 
>> >> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
>> >>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >> The reason is that igc_ptp_init() is called very early, even before
>> >> register_netdev() has been called. So the netdev_info() call works
>> >> on a partially uninitialized netdev.
>> >> 
>> >> Fix this by calling igc_ptp_init() after register_netdev(), right
>> >> after the media autosense check, just as in igb.  Add a comment,
>> >> just as in igb.
>> >
>> > The network stack can start sending and receiving packet before
>> > register_netdev() returns. This is typical of NFS root for example. Is
>> > there anything in igc_ptp_init() which could cause such packet
>> > transfers to explode?
>> >
>> 
>> There might be a very narrow window (probably impossible?), what I can
>> see is:
>> 
>> 1. the netdevice is exposed to userspace;
>> 2. userspace does the SIOCSHWTSTAMP ioctl() to enable TX timestamps;
>> 3. userspace sends a packet that is going to be timestamped;
>> 
>> if this happens before igc_ptp_init() is called, adapter->ptp_tx_lock is
>> going to be uninitialized, and (3) is going to crash.
>
> The same would then be possible on igb as well, wouldn't it?
>

Given how many years igb is being used, perhaps "possible" is too strong
:-)

On igb what exists is slightly different, as there's no ptp_tx_lock
there, the "problem" there is trying to enqueue a job on a workqueue
that is going to be uninitialized, during this time window.

And to be sure, I am still uncertain that this is possible.

>
>> If there's anything that makes this impossible/extremely unlikely, the
>> patch looks good:
>> 
>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> 
>> 
>> Cheers,
>> -- 
>> Vinicius
>
>
> Corinna
>

Cheers,
-- 
Vinicius

