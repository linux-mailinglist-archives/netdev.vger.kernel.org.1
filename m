Return-Path: <netdev+bounces-68944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CC6848EC6
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0511C219CB
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5492134F;
	Sun,  4 Feb 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2Velfej"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317A224C7
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059146; cv=none; b=I5tyG0QZ6z5QvgF50W53dhNlfd8ztxc0YCeSeOd2Kliqk3/KNeE+S3ziNcmg5gP67jNBH7Ub65VCX9lUVBN11CqPGlnBytDeVjvqaKQWG+zACK7waBs5DkoPBmri7aeQv1EGOBTWd/PVpxOcrXvouSmLrD3ugZ93o1SQmwthm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059146; c=relaxed/simple;
	bh=AJAMi8u56refPBbstHaeF9yjwnclv72YCW5sJ51shrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYV2t59rO0J65TK/3/8uvyrJHeVJ9rx7arBa+kGgxLlcormBRLwaeeFuB9/7mndfEg0ZjXytpfVugxwPt4v9SBcEmJp+9o+/+YzmXuAX0Q9PzEgOfXh1BQdfhUHJYwt3u5vR98qo65hCJ/xlXdPmTdtW/uxGQY6AqiiLSwPaLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2Velfej; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707059145; x=1738595145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AJAMi8u56refPBbstHaeF9yjwnclv72YCW5sJ51shrE=;
  b=O2VelfejpFw1KgJjIi62W++7v/ey+hNcpVtsYXW8gbpdOUrmjLioo5wE
   pBy5ihG1Vvu3wtAWTOwowTPGcFVkMc9m+9NlKpXC3V6LGeQVfndPHbcmG
   MpDBu0aZ5we6O0ZwOXzZzRCdlGV/aHK2N8WXyZj9moUGvQPS6hjBUxp5R
   rRVggLcy/U0E4aZh66/5JdXUiprS09x7HtU82qtSJp7LakPZU0sG3nE3Q
   qdmmBMHXnqWgZcHDTAMK/htLpuqApW7NjzaJprAWnPn8GM+vxPj+mZqCQ
   E8z8KryDFawO+ZRmTttXaYlKIMHvsoWP1uWPIEIzJ3A4OlIuh8d0UOghd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="550260"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="550260"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 07:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="823649190"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="823649190"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.124.132.248]) ([10.124.132.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 07:05:41 -0800
Message-ID: <1e8740a0-b2b3-41d3-a554-9fb2d79dd32a@linux.intel.com>
Date: Sun, 4 Feb 2024 17:05:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 2/3] igc: Use netdev
 printing functions for flex filters
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-3-kurt@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240124085532.58841-3-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/2024 10:55, Kurt Kanzenbach wrote:
> All igc filter implementations use netdev_*() printing functions except for
> the flex filters. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

