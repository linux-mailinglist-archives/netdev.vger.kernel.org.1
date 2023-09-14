Return-Path: <netdev+bounces-33916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71C57A09CB
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90C01C2114B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261B18E28;
	Thu, 14 Sep 2023 15:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4E28E2F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:52:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39F1BDC
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694706770; x=1726242770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ByxlnlZgaOlYtt+bknRwCG8V8d7OeZwyuwY3nBwYniQ=;
  b=hnUIBgmOl28Ef97USvCqEDD+Xngf3RPKNtmc7u1TZThj9gHAM9OLY73p
   uP4XSd1NvspMr6mqhxncchfR/ERby7BK0V7dBFudalj/2q7XJpSexuqik
   02H8Ivrh+PiAycQmoKflaZ6IyXkByhUXB67GvJ/y11pQjxv9CRBxyvRx2
   toMj0r24L5HBWeoSp34yRUK6rFSfMp3O2Z8P4xVZFiTRkpK4vDR50Pjyw
   X4i5QSij3SgZkkEbQcmmO1R2cUjrrhLZiDn8IOswiF3BoiKOzT3y43lky
   oVJO7wAGlXx0EGvE6JVZEhXWXvmXpYNevwrCuUU3/9ejOdM+tx+A2//Fn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369291947"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="369291947"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:52:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="810131149"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="810131149"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2023 08:51:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 31529204; Thu, 14 Sep 2023 18:51:26 +0300 (EEST)
Date: Thu, 14 Sep 2023 18:51:26 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Yachen Liu <blankwonder@gmail.com>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com
Subject: Re: [Bug][USB4NET] Potential Bug with USB4NET and Linux Bridging
Message-ID: <20230914155126.GM1599918@black.fi.intel.com>
References: <CAPsLH6aHJGG7kAaZ7hdyKoSor4Ws2Fwujjjxog6E_bQrY1fA+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPsLH6aHJGG7kAaZ7hdyKoSor4Ws2Fwujjjxog6E_bQrY1fA+w@mail.gmail.com>

Hi,

On Thu, Sep 14, 2023 at 10:02:24PM +0800, Yachen Liu wrote:
> Hello,
> 
> I've noticed a potential issue with USB4NET when used in conjunction
> with Linux bridging. I'm uncertain if it's a bug or a configuration
> oversight on my part.
> 
> In essence, when the device at the other end of Thunderbolt sends
> packets using the TSO mechanism (default behavior in macOS), the Linux
> thunderbolt0 interface correctly receives this large packet. However,
> the packet isn't properly forwarded to another device via bridging.
> 
> Detailed Description:
> 
> The test environment consists of three systems:
> 
> A: Mac Mini (M2): macOS Sonoma 14.0 RC
> B: Proxmox VE 8.0. Kernel release: 6.2.16-3-pve, acting as the Host system.
> C: Debian. A Guest system running within B.
> 
> System A and B are connected via USB4, while System C is a virtual
> machine within B. On B, thunderbolt0 and tap102i0 are bridged to
> establish a connection between A and C.
> 
> During an iperf3 speed test between A and B, I've achieved
> bi-directional speeds of around 18Gbps. Between B and C, the speeds
> are 100Gbps+ at their peak, with a minimum of 28Gbps.
> 
> However, when performing an iperf3 speed test between A and C, the
> direction from C to A shows about 18Gbps, but from A to C, the speed
> drops to just tens of Kbps, essentially making it unusable.
> 
> If tested using UDP, both directions achieve roughly 5Gbps. (I suspect
> some buffer issue in macOS limiting the speed).
> 
> After various tests and investigations, I found that by setting
> macOS's net.inet.tcp.tso to 0 (disabling TSO), speeds from A to C
> improved to around 10Gbps.
> 
> Packet capture via tcpdump revealed that macOS writes large packets
> (over 10000B) to Thunderbolt Networking using TSO. These packets are
> correctly captured on thunderbolt0, but are missing from tap102i0,
> resulting in significant packet loss.
> 
> Since ethtool doesn't support the thunderbolt0 device, further testing
> has been hindered.
> 
> I'm unsure if this is a bug, or if it could be resolved via
> configuration. If more information is needed, I am more than willing
> to assist further with tests.

Thank you for the report. To be honest, I'm not sure how the interface
should in this case and is there perhaps some way for a NIC driver to
pass TSO packets up so that they would be passed in the same way to the
tap interface. Is there any example driver where this works? Like if you
use ethernet instead of TBT/USB4 does that work with TSO packets?

