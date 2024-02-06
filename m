Return-Path: <netdev+bounces-69383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5484AF2E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA441F229B7
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 07:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4386128803;
	Tue,  6 Feb 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dvn26YLR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4D7319C
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205638; cv=none; b=rHxgENfapVDydMuzVMtR14zPXURgB2sdXeZ6wDOjpU1OfHNrLLVOs8InxTHixy6wORvDWIagHnHg7w2I7hR9XGpC3enx25P1bjbwywqhOr5u0cOexNS1s6AbeXgfB3rZ9QzlGOf3cxcHogRj5uIpR/8B0yfpwrSwPnznicEekYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205638; c=relaxed/simple;
	bh=GuUdzz9DqtuLTXtZ/gzHRjdZLTio+3Y318FGx5Zyoxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah0mTIE5G1X4eyhFwFXEEHlSxajogLiyB0qNDQ1wqolhv4Wn8NBVL8l6O5/toFQMXUnpIo1cetROY5yMM+FRkpJ/BDNgDJoZmdiMxa4lY4P5lg7v+k/JsYs02iJAbHfoqnqgZcpCqy6OK8d2ULkzz5g+CGmbiwfuLdWrQQWVpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dvn26YLR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707205637; x=1738741637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GuUdzz9DqtuLTXtZ/gzHRjdZLTio+3Y318FGx5Zyoxo=;
  b=Dvn26YLRm2FcGLoqvW01BTehgpAnKXfSUKU4H+z036UwpJLQL7glYJgB
   Xsmvp3xTKGyMKcS1RmwY/RonGhX16bBzgXgxyjUYFwj502nlGZ5KvUw47
   vI4y8gw8rxKR4bd8MG5r0Uh5t6S5x5ooLoUGBkAUnoBpUsm5lCokV77Wn
   MQ7pQbXhMna4w6NKL0UpI1ZX44rlehh6QhVb7cpnVMArl/BI1cF51PrG5
   TroVE2f6XyOK2g6xCh/0A1w+7xz2Hg8CaF5cTzudZsD04Nui4ImiV+663
   B1r5Bta24e77GlHSmmKbcAfBzlIdW8+92r7wHrbw1m6OeQJU6yb3TFyyl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="574139"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="574139"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933376724"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="933376724"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:47:14 -0800
Date: Tue, 6 Feb 2024 08:47:05 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com, Edwin Peer <edwin.peer@broadcom.com>
Subject: Re: [PATCH net-next 04/13] bnxt_en: implement fully specified
 5-tuple masks
Message-ID: <ZcHj+U6BdSrflTlW@mev-dev>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
 <20240205223202.25341-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205223202.25341-5-michael.chan@broadcom.com>

On Mon, Feb 05, 2024 at 02:31:53PM -0800, Michael Chan wrote:
> From: Edwin Peer <edwin.peer@broadcom.com>
> 
> Support subfield masking for IP addresses and ports. Previously, only
> entire fields could be included or excluded in NTUPLE filters.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 141 ++++++++++-------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  19 +--
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 142 +++++-------------
>  3 files changed, 134 insertions(+), 168 deletions(-)
> 
[...]

Looks fine
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks,
Michal

