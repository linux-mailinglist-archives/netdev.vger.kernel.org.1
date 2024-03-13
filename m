Return-Path: <netdev+bounces-79709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D79E87AB01
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3EE1C21A11
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7E446535;
	Wed, 13 Mar 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMEW6VcF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF8481D7
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346994; cv=none; b=fKEU/vOU2sgz2IhltGB4cn6cD5jjscT+LglrgCGEYiwk/AFragCisxP2fuFpIAzt4rETB80nUDYsV+kSDYJD9Ywi8EhBmPxli4fydvhSXZm281AxNxDmEDLHSA4o3EApCcj4luu+J2AobZ2Vri3r53qumwvIbqHmusSY2jJWbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346994; c=relaxed/simple;
	bh=bIh/N/2R/W06MlUKTSgW8YZVPxC6qNVJHsYSfuglBYI=;
	h=From:To:Cc:MIME-Version:Content-Type:Subject:In-Reply-To:
	 References:Date:Message-ID; b=OoKmJFz1zmRtGnZpUHX9gsIFccxo/w3u/DuCpbu7LVE+0wtOXIccznDwJ0GkfFmbOaron+klsJDtEfAc5D/dJ+2sX7bAr9yqXjbrRNRTGWuzQNxn27BZdyeTdCgTRWCfe+HaVI7d02+3t5LWtnX7O/TxrKe/PXPXykMml4SP0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMEW6VcF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710346993; x=1741882993;
  h=from:to:cc:mime-version:subject:in-reply-to:references:
   date:message-id;
  bh=bIh/N/2R/W06MlUKTSgW8YZVPxC6qNVJHsYSfuglBYI=;
  b=CMEW6VcFOqInQ+wsvRvUG2KdJhLEtcqQGt01plK0HrS3N2RrvBNtTSDQ
   oTGfTqRQhqvKeMDpCcX7Ysay6U+t1JoY8dThE71ZcdqGMBo/vv7HwDt/W
   sslFrdxAs8Rp4IxHCEv3gfMwUutNercdhAf06ijtc2tjp/3eGd5ULrwxd
   QeMk3z91olNwZeky4mTOIgSd6d2vkbJiCMG6lMdwPpwg9rpaAxfUjUm0H
   3TYlaaZ5HtN4ClUcusRF8SEYST8mIJdsO9/0FQEklAC8277HgSh0ipOTY
   uiZLG9Mn8kClgSkuMmi+hTlLAJ7QpDb8/4lFr7T6hhOis8mxgM6GUO4kv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8068755"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="8068755"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 09:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="16572134"
Received: from unknown (HELO vcostago-mobl3) ([10.125.110.77])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 09:23:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Muhammad
 Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Kurt Kanzenbach
 <kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH iwl-net] igc: Remove stale comment about Tx timestamping
In-Reply-To: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
References: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
Date: Wed, 13 Mar 2024 09:23:11 -0700
Message-ID: <87v85qp0cw.fsf@intel.com>

Kurt Kanzenbach <kurt@linutronix.de> writes:

> The initial igc Tx timestamping implementation used only one register for
> retrieving Tx timestamps. Commit 3ed247e78911 ("igc: Add support for
> multiple in-flight TX timestamps") added support for utilizing all four of
> them e.g., for multiple domain support. Remove the stale comment/FIXME.
>
> Fixes: 3ed247e78911 ("igc: Add support for multiple in-flight TX timestamps")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

Ugh, sorry for forgetting about that.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

