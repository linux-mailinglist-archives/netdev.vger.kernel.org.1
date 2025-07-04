Return-Path: <netdev+bounces-204219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F6AF9990
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA21BC6695
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC342A83;
	Fri,  4 Jul 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caOz5lzb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FA2E3707
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649569; cv=none; b=kHf6e35DO93o+LpgGRgV82MMgsofLtAIWtIMHMKfJMCeLGL5QBQrc5L8w6sJ7TUeD1SZmpQmfC8cWAA70OM8YDoT/kJGSuiRAIhLdD20WLAf6Fp/JP/DXofXoelsF5daXksTONzZXG1QO/2bCbZ4P08mOVjzI1VSL7H54RI3ZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649569; c=relaxed/simple;
	bh=63eeHKTGY7iDPjf5kDa47PI5nqnQJNjObDFdFYAyPY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehUCKwOU6I6iF0lMS94rGn1dEyMwAd9P+dAEVEResS2ssSLld0kvHNo3JnhhdyJu44rAXsD8xizqPfhoD3tpRPjBw/mIAtClSzEEmKvwvtQX23gsrWsMvgA4Fdeuz/JxeGlWDsW8wkRsC0DqkTpC7dzdCUfHSgVJMnDl00CBwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caOz5lzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92B0C4CEE3;
	Fri,  4 Jul 2025 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751649569;
	bh=63eeHKTGY7iDPjf5kDa47PI5nqnQJNjObDFdFYAyPY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caOz5lzbh21dptuhdp0QAJsAqyJQThH3ru0FhNfYYw/VsJ73lXjSOVrmnXEJVBFgG
	 kn3ZFc0S/4XTsPDZdmst/RBMyWZ1k+GctfTkQp+SSuf57RdpJGX5Y1KB1zz3eCD07q
	 vY3oVCq25huqTemoUyVoYSq7O4CKhqnSgXnjkPOLoUwp/jOOCbxYXdkeABPlJ00j8U
	 IDS0bCF7yChOGnA+fDDCzv3c2oxqQRjdN5Xwhn8fRqo+mN96m5Bp9T+h3nhowupF7R
	 n67b/J65zD52C/pinnXwESe7r4de7LBnuEw8VKiTz6vpi47SDXweHtVYHj41iwnlnz
	 zWBFQ6ugD9mPw==
Date: Fri, 4 Jul 2025 18:19:25 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v2 net-next 3/4] ibmvnic: Use ndo_get_stats64 to fix
 inaccurate SAR reporting
Message-ID: <20250704171925.GO41770@horms.kernel.org>
References: <20250702171804.86422-1-mmc@linux.ibm.com>
 <20250702171804.86422-4-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171804.86422-4-mmc@linux.ibm.com>

On Wed, Jul 02, 2025 at 10:18:03AM -0700, Mingming Cao wrote:
> VNIC testing on multi-core Power systems showed SAR stats drift
> and packet rate inconsistencies under load.
> 
> Implements ndo_get_stats64 to provide safe aggregation of queue-level
> atomic64 counters into rtnl_link_stats64 for use by tools like 'ip -s',
> 'ifconfig', and 'sar'. Switch to ndo_get_stats64 to align SAR reporting
> with the standard kernel interface for retrieving netdev stats.
> 
> This removes redundant per-adapter stat updates, reduces overhead,
> eliminates cacheline bouncing from hot path updates, and improves
> the accuracy of reported packet rates.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed by: Brian King <bjking1@linux.ibm.com>
> Reviewed by: Dave Marquardt <davemarq@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


