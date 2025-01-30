Return-Path: <netdev+bounces-161651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF8A230B1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 15:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D4A188851A
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444711E7C18;
	Thu, 30 Jan 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrIEd/qZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B1E285A
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248972; cv=none; b=ax/DlVozYwDk72CpFZN/AcsbGSu7D7LFY8uGkcWOU2tzYZFwZf0rdQERURv/M2f1RVB6XcmSgDFFTEzcB2nfSvRjSq05Cr4U+DI4UyzF+kFqmZVps1Qk6GhPtrNt06kob3ENSqYsYuWzw5XKKOOfWCXSfpx5DqyNcJLNI/mDElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248972; c=relaxed/simple;
	bh=uEBJaIgm9yaActeKUG0czWvfc/SHOt5RMpErHycXtAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHIaXGCNkbHAYszEMqCP0dkr0WZxVzT01jOeORRtKc3Hl0iRYPKp5V7qsTgkeU63qwsxS/2i8Osih7OQMuPdetLR5Ig2oUmSTjZHddXFhDMtOuS16EEoChkUblDfcgIlj81SD2G2GZYPs1y6GU1iWS6oHyCbF+hFt73LNDfYZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrIEd/qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4717CC4CED2;
	Thu, 30 Jan 2025 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738248971;
	bh=uEBJaIgm9yaActeKUG0czWvfc/SHOt5RMpErHycXtAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrIEd/qZxmVKpVaVp4LmWi/PFtABSQidZd2A/3aeeB67HQS1OVIfWGRKeGfwNASsZ
	 T3GSpCE/X2H5iL3/HhIJdXOYJAGR3aNslDM4VxQppxI9Nri9fyR925cbqQrd40+m9l
	 Rqk0DzXAtws3OgwBCvxYVeZUTojGS0DsztpSuvoVp17XaEN/En+C5KofHUfvxuTq1o
	 cpDMOByBm9A1dT8lYeo4pOi4UDAQ7E1M9kwbNElyMQAMLi4LaZImT6jROCFib8CZdW
	 Bfot2ajBjY67oLvdmQ88q5/zwwC+eiBgPq9K5qeXbebq3EK4Yc68KQljUvNKA7dAqH
	 eUyWTCi4fp0Yg==
Date: Thu, 30 Jan 2025 06:56:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, dsahern@kernel.org
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6
 and ioam6 lwtunnels
Message-ID: <20250130065610.1f5aa007@kernel.org>
In-Reply-To: <91681490-63fa-405f-84cc-7ec0236eba8a@uliege.be>
References: <20250130031519.2716843-1-kuba@kernel.org>
	<20250130031519.2716843-2-kuba@kernel.org>
	<20250130102813.GD113107@kernel.org>
	<91681490-63fa-405f-84cc-7ec0236eba8a@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 14:41:56 +0100 Justin Iurman wrote:
> This was my thought as well. While Fixes tags are correct for #1, what 
> #2 is trying to fix was already there before 985ec6f5e623, 40475b63761a 
> and dce525185bc9 respectively. I think it should be:
> 
> Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and 
> injection with lwtunnels")
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")

I'll swap the tags when applying, if there are no other comments.

