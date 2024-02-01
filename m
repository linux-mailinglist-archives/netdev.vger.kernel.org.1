Return-Path: <netdev+bounces-68035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD87845AD8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EACC1F252FB
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804405F493;
	Thu,  1 Feb 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvQ5QOyz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5E5F477
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799953; cv=none; b=XwrrTYtCfxSJ+8ePHwKcNp7K6rr7tX9zSk58GCwDtmXTgBNVqPwFWwqO5tQl9CGz/8HQWGHiv4o0cmIUNzxLTe1ehqgpoXlSgFIrO/+bIf4bQE5LDgayFzzEnvCpJVZ5N6b2maBl1Y8VNSShua7wTMhXpY8G7IOUepp1/UvMHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799953; c=relaxed/simple;
	bh=Nz9/kINegG6gx14t3dQC6pXGv4Mh7wDVItfkjLfv3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaRm9wlErfj6kSbvWr44XAOe+dDItj1cUVk8++nuiHevv6VX5GsjnkbjM57Ss2WfRU2bINHMHE00tqdqK+ykhVG+g8ZdgUSicKJj+Ps0U0395XSZRW3pcNQJMEVvf+Hj0oqs3xT2lzWs/yV3e9MvwBLuB3UHytwqyq3RM37QMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvQ5QOyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46211C433C7;
	Thu,  1 Feb 2024 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799952;
	bh=Nz9/kINegG6gx14t3dQC6pXGv4Mh7wDVItfkjLfv3W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QvQ5QOyzH/cxxWU3j2EI6ah2VvNNMHfbkqqKeyc3998TWpwpYNAJ8er9fImSYarqK
	 YZAQURV7/E5lIjWUwDPWpT+K5cznTCCDkSFEYI6hDISn55AqcDW6Rf7fd+99jJ+OcP
	 534dgeyY2zdNC0xSGcp1SbLn8BG9gdcTdHFGUJ7aFz/TBmpHbwEfbqF6SlOLo2qD94
	 SydU+pCi0L91NbpQNDK+bwcqdnXTYmCceVpiPq8rm6VaqCKejNV4CiMWcYzqdrmnM+
	 eo/H1uB8YNKrITMR7LSUyZd3iBT8BBF4/Y3J1g84A8ROyMaOdSYajpjwzwTUMo5f77
	 D6D0etiRPzIOQ==
Date: Thu, 1 Feb 2024 07:05:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "G Thomas, Rohan"
 <rohan.g.thomas@intel.com>
Subject: Re: [PATCH net v6] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20240201070551.7147faee@kernel.org>
In-Reply-To: <b757b71b-2460-48fe-a163-f7ddfb982725@electromag.com.au>
References: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
	<b757b71b-2460-48fe-a163-f7ddfb982725@electromag.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 17:38:07 +0800 Richard Tresidder wrote:
>      Thanks for your work on this patch.
> I was wondering if this would make it's way onto the lts kernel branch at some point?
> I think this patch relies on at least a few others that don't appear to have been ported across either.
> eg: at least 2023-09-18 	Rohan G Thomas net: stmmac: Tx coe sw fallback
> 
> Just looking at having to abandon the 6.6 lts kernel I'm basing things on as we require this patchset to get our network system working.
> Again much appreciated!

Hm, it may have gotten missed because of the double space in:
Cc:  <stable@vger.kernel.org>
double check if it's present in the stable tree and if not please
request the backport, the info you need to provide is somewhere
in kernel doc's process section.

