Return-Path: <netdev+bounces-226716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD180BA4612
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ABA62159E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894E1F5834;
	Fri, 26 Sep 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQndZSFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A001E0E08;
	Fri, 26 Sep 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899930; cv=none; b=JrGEil6wcW+xKAxwZWOFFXNROI86tD9M+LqGFYsbBFE8QLkMcwq5K2e0KGa/6Qxhkm4A7oU+SipwPdPNWkEuP4VTfRPp1Chat2Q4KGnT1PLGL5Mk3QdScjkOZxC4fA/0TlMs6olk49v9tttDNSio+RK6r/utgUF3G4e09ONvh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899930; c=relaxed/simple;
	bh=b+4leQtIztpH7slAr32icY1Nz5+zdLGfM57x84x5smY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1yvZxMYj2BYpizRcHNZ0ivhQWVKDepKn9HFi/AUG8CPQSCre0IEUzEaYCmV/5pODr/tn9IiX8gO0gEGixWVsq90E8Vn8rIz4HsEYxcju9NVICMXtrBOJU9HauSfTCSjfG95VPkKHpob/dtpgAmwIsyPE5XEpiz/S95FOHSn/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQndZSFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F04C4CEF4;
	Fri, 26 Sep 2025 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758899929;
	bh=b+4leQtIztpH7slAr32icY1Nz5+zdLGfM57x84x5smY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQndZSFSBZfctjqSdTZrxdX65j21Vw2bZx1Sdd43nfvQ0wbKnZGoVRGdLKfrA7coA
	 94xtWGIJGGilkwsL7I5sL5DJ4bSUpdx34R0WWwxqy0SCuuhpw+2c8/zS2ppoBl8GJJ
	 vnd/qxPFpYRJ6fJ0ejB8WmSwA4dvKdtGUYpQBpON83fNqKbttAwAfBMhPbAuTsNOUN
	 ZgvjGi/DifSLtX9cgtW6aU5bSiX5kzxPMrFse1XsfX5TqoD9uySWzsayMwTWcXCYQP
	 PmKDdJUoDxaE2ul9ZgSqLqmSwJ2cL3kkS9m0IXXjoczL9kF9KCBDXHjZURno9KcxG1
	 sM2fbntsYcZYw==
Date: Fri, 26 Sep 2025 16:18:45 +0100
From: Simon Horman <horms@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	hawk@kernel.org, toke@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <aNau1UuLdO296pJf@horms.kernel.org>
References: <20250926035423.51210-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926035423.51210-1-byungchul@sk.com>

On Fri, Sep 26, 2025 at 12:54:23PM +0900, Byungchul Park wrote:
> Changes from RFC v2:
> 	1. Add a Reviewed-by tag (Thanks to Mina)
> 	2. Rebase on main branch as of Sep 22
> 
> Changes from RFC:
> 	1. Optimize the implementation of netmem_to_nmdesc to use less
> 	   instructions (feedbacked by Pavel)
> 
> --->8---
> >From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 29 Jul 2025 19:34:12 +0900
> Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
> 
> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
> 
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> 
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.
> 
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Hi Byungchul,

Some process issues from my side.

1. The revision information, up to including the '--->8---' line above
   should be below the scissors ('---') below.

   This is so that it is available to reviewers, appears in mailing
   list archives, and so on. But is not included in git history.

2. Starting the patch description with a 'From: ' line is fine.
   But 'Date:" and 'Subject:' lines don't belong there.

   Perhaps 1 and 2 are some sort of tooling error?

3. Unfortunately while this patch is targeted at net-next,
   it doesn't apply cleanly there.

When you repost, be sure to observe the 24h rule.

Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

...

