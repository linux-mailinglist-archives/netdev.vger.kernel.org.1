Return-Path: <netdev+bounces-110921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0E92EECC
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569CC1F22681
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2107016D9DD;
	Thu, 11 Jul 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZYIPrUS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F176034;
	Thu, 11 Jul 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722159; cv=none; b=YJDBr31msZLj49i4/5kSlteMq+3EBDFxXv1Y92u1ppp8Ql9+Wg5up1zTzUlQINU9l1gFqJx7zpOR/iN/nzh/6bgqjzpQnvPNezxX76X+0y6aFX3BvAjzp7YjtwjXZz4xebnsYlXH2isioIZT0GRlNZPaayqKsXgK15drp/3lJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722159; c=relaxed/simple;
	bh=rwRq5sHZuJi1yLF7Y67zhwSlLDwgpG63WbjsUOAnJro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikJXl9kjHebVOkGN8k63+zvyJ2SA9VzFLomX8wC8QV7mFiBd9ty2+gMBD9FjA9jI9Ubhde4IEiXD4t9WNBMXD36jeRX0G8iylxagXxP5myRVMmt1wb6Ph2oKoQ9M+m4uaeZ1lYxVlss/l3CocuxhmqolXZxjCgRV5EiP4UsUhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZYIPrUS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720722158; x=1752258158;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rwRq5sHZuJi1yLF7Y67zhwSlLDwgpG63WbjsUOAnJro=;
  b=WZYIPrUSYhHbUQTe848HnU9UXqCIW9wQaR7Lyn65Gn1Tk6HyzFbUES+x
   JTTosFhSFkmnfimpD5dqaMkD5ikZmoLq4AmW1jkiT5RihX4ayxIvHPjxi
   SULPq7j8dElRdGsxRIZbHbDoHYOW8paxiL71CTjCC/fNWtnbCK33VV0su
   OyhGAmpxADhtnp9FU01cdYcJrkDXIn9beQtgzNX1i47TV7KKD9sw9pWTR
   1F+HC0hgam0Bhxy8tW4FWQrlaNQhyR4RXyYbPk1k1lY41GjLdwaE1wp8H
   SyDHI1XBgyS6wvd4U3yMKVzkaTId5xf02+293qw9xmqrHysAtAWlLg58t
   g==;
X-CSE-ConnectionGUID: M2cZTRTJQlmNmQ8CNguZiQ==
X-CSE-MsgGUID: nQftZ2UESeqD1ql7Wg2eiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29541743"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="29541743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:22:27 -0700
X-CSE-ConnectionGUID: nOfmpfp9Qe2U/rAbMkJAbQ==
X-CSE-MsgGUID: bhYsYfL6SzaAPuz4kI4/wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53244456"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.92])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:22:27 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-net v2 1/1] igc: Fix packet still tx after gate
 close by reducing i226 MAC retry buffer
In-Reply-To: <20240706153807.3390950-1-faizal.abdul.rahim@linux.intel.com>
References: <20240706153807.3390950-1-faizal.abdul.rahim@linux.intel.com>
Date: Thu, 11 Jul 2024 11:22:26 -0700
Message-ID: <87h6cvss9p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:

> Testing uncovered that even when the taprio gate is closed, some packets
> still transmit.
>
> According to i225/6 hardware errata [1], traffic might overflow the
> planned QBV window. This happens because MAC maintains an internal buffer,
> primarily for supporting half duplex retries. Therefore, even when the
> gate closes, residual MAC data in the buffer may still transmit.
>
> To mitigate this for i226, reduce the MAC's internal buffer from 192 bytes
> to the recommended 88 bytes by modifying the RETX_CTL register value.
>
> This follows guidelines from:
> [1] Ethernet Controller I225/I22 Spec Update Rev 2.1 Errata Item 9:
>     TSN: Packet Transmission Might Cross Qbv Window
> [2] I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
>
> Note that the RETX_CTL register can't be used in TSN mode because half
> duplex feature cannot coexist with TSN.
>
> Test Steps:
> 1.  Send taprio cmd to board A:
>     tc qdisc replace dev enp1s0 parent root handle 100 taprio \
>     num_tc 4 \
>     map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>     queues 1@0 1@1 1@2 1@3 \
>     base-time 0 \
>     sched-entry S 0x07 500000 \
>     sched-entry S 0x0f 500000 \
>     flags 0x2 \
>     txtime-delay 0
>
>     Note that for TC3, gate should open for 500us and close for another
>     500us.
>
> 3.  Take tcpdump log on Board B.
>
> 4.  Send udp packets via UDP tai app from Board A to Board B.
>
> 5.  Analyze tcpdump log via wireshark log on Board B. Ensure that the
>     total time from the first to the last packet received during one cycle
>     for TC3 does not exceed 500us.
>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com/
>
> Changelog:
> v1 -> v2
> - Update commit description (Paul).
> - Rename qbvfullth -> qbvfullthreshold (Paul).
> ---

Looks fine.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

