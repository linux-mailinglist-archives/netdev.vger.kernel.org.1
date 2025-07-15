Return-Path: <netdev+bounces-207100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A3B05BAF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E8C565F59
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC62E1758;
	Tue, 15 Jul 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1zytxRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665127584E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585736; cv=none; b=WzXBiaNutT2kV8AoO5Mtnw4DqSHTqlPSkBJFU2SgRggu24CVLZs0Jc2UFE+0oSVNKx9mj6XN27UDLyEFTH7UUu3sKGMMch+nPSoUddZgz5oJz4te5XvynjhLlw9jmEmqxOxfjvvyu89Q8nYVUtbL/QYXabpx5eTXmCfZsKPXs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585736; c=relaxed/simple;
	bh=Yg5a7S4Npf/0qneupN2Ntl6VDAdf3Fo/j2aD7zqyz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD+rt6UGzoufybKyCU5IRDCg1zYv5MkyLoMk5AS9tGYOiZY/dAMt1M77nLnFIjYiG7axFb5CKEhhGxhDfiB8OQf89Dpw3a5mbqRuNsNDJWBAwpGCe7NAsoryPKYGIaTCcPwx8ZXvnVniG0zF1XaJp5vI53odhCSa2g4ZKP09SHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1zytxRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B5C4CEE3;
	Tue, 15 Jul 2025 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752585735;
	bh=Yg5a7S4Npf/0qneupN2Ntl6VDAdf3Fo/j2aD7zqyz4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1zytxRcwgNmpaU9kcdVul+znY9uvhc8PNIr8chdYm5jNerVdy4bjYC9thsU8VFpU
	 RD5i7fTfCQTn5kzm+29y9K3vp1xeZpRtN4VKSNA2htO8aso2uoWUw9HStqE+TDkfB9
	 jSlYq2u9GbZApBIwejMUIzuISMhndrhq3HbNrF2u2Rc4NMRmO2PaJfSSr3OXrMRUK+
	 YxVk5nsV76IBBK0oZ10yHVXc8FNkJtJL6/izIH+d+m7HlrvKMosqqI/iwnPIIKljZK
	 MmazNSm7MEa+NhEPY/jSQlTwTdR2SN6bbLcIAmpGUaAQSVH0tK8wxhvQqkOIF1Kvbf
	 rSkVcxNarjczw==
Date: Tue, 15 Jul 2025 14:22:11 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, bjking1@linux.ibm.com,
	haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v3 net-next 2/2] ibmvnic: Use ndo_get_stats64 to fix
 inaccurate SAR reporting
Message-ID: <20250715132211.GX721198@horms.kernel.org>
References: <20250714173507.73096-1-mmc@linux.ibm.com>
 <20250714173507.73096-3-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714173507.73096-3-mmc@linux.ibm.com>

On Mon, Jul 14, 2025 at 01:35:07PM -0400, Mingming Cao wrote:
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


