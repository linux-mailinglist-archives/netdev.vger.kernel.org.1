Return-Path: <netdev+bounces-211195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5DEB171C3
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D70117C0F2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330552C3244;
	Thu, 31 Jul 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oA78FtAY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8082C1591
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967228; cv=none; b=Iu4jGME+9jwFTtQV37VRR6CfQQeJLfqqT6GTqkgJ1mSF+af/GpL/0uF9BzicmUVQPaQ7kg8ugPf7SvYMROS3MlU9JNMfMwLuW9yHanh8nsnHaTRmno9LbLCFd08bw7qMeaNrPWo+aRLP8lKJvyoeosD9jRNs4UPt/u2aUkZymV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967228; c=relaxed/simple;
	bh=b7asKDyEFfe5FrErmZgsuqPSXjANIdaq8x+7guAJ5c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foF67OvIpNw/igkivZtKIgZmR0ySYDpI4Wv7NIwD13sNPItLwuYofX2VI4BlKnxkNniGCrm4S4h/4gi4Q9rd1oaFIzbOlfq8b1iOFJnyIIf9glCJGko2F/7Vz/BRcwhYf68JkNJ8o7lIWKFrfvGaYB34nJiy+EeQMaVjs+xxHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oA78FtAY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MNAj5RtY39As7wJ+cKGkqEsAnMAgMJ26Ed685zyoy6s=; b=oA78FtAYLtcaX4HUqByf7dcv/l
	7ude7HaZ9ur6HGyXslPUNjl0cYCrajaTQ9mvcLq54BFrig/DgljG6N0+wkaeMjuGExsLhL3wwpMkr
	4MYZY0Fp9RV4y2QtL3nMSbEoHJ4dc32qcULQJrmfzz2BherGB8/6He0iKu3hydxCQBnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhSzu-003N1q-8r; Thu, 31 Jul 2025 15:07:02 +0200
Date: Thu, 31 Jul 2025 15:07:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	Ryan Wilkins <Ryan.Wilkins@telosalliance.com>
Subject: Re: [PATCH v2 net-next] net: dsa: validate source trunk against
 lags_len
Message-ID: <ffba7b2f-ad0d-4855-83ae-a3e4f0de766f@lunn.ch>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <5E37B372-015B-4B19-92E9-7212C33D59C5@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E37B372-015B-4B19-92E9-7212C33D59C5@padl.com>

On Thu, Jul 31, 2025 at 07:56:37PM +1000, Luke Howard wrote:
> A DSA frame with an invalid source trunk ID could cause an out-of-bounds
> read access of dst->lags.
> 
> Add a check to dsa_lag_by_id() to validate the LAG ID is not zero, and is
> less than or equal to dst->lags_len. (The LAG ID is derived by adding one
> to the source trunk ID.)
> 
> Note: this is in the fast path for any frames within a trunk.
> 
> Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets from LAG devices")
> Signed-off-by: Luke Howard <lukeh@padl.com>

Adding to what Vladimir said, please also have each patchset in its
own thread. There is a CI system which takes patches from the list and
tests them. It does not always understand multiple patchsets in one
thread. If the CI misses a patch, it pretty much means an automatic
rejection of the patch and you will need to resubmit.

	Andrew


