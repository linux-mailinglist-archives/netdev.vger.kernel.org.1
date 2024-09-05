Return-Path: <netdev+bounces-125593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E313D96DCC5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B86B22338
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9C81AB4;
	Thu,  5 Sep 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHPEkAeS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5B80054
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548162; cv=none; b=Ozt0t0oJRNdJPTqpQj8UopQ9kZclfvIOBBsWcizJYYorkse7dMQCSFQcV4j64vVZAlkaSpJnuHMq/TUW9R0qfc+TA78IG8Ntxx74vs9pQG3UhdV7/aQuSzza3xoSBKs7qX9M8cZ1Tzzxj3mA+FYcVXQRlMrzPUg0iY0vmlbS1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548162; c=relaxed/simple;
	bh=ClZvtwCsH9DQ63ocYDD2EKvNRM/bTkDWlMYQX3Nkr9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWoCTsf80k2POqyv7SxIghYAsit5mvXM46dxmvyLzCb73pE+/ypD/x4SjEEXAar5jeH5lfjQHxip5h9iFggwChBbWFdXIvjI7eyQqORK0LHlbrprsBICWzj9LEzEf4PGRRa5jl61Rb/+nzkaqAF8wOI10ZMBJGNJ8TTx/aJ8rbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHPEkAeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F45C4CEC5;
	Thu,  5 Sep 2024 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725548161;
	bh=ClZvtwCsH9DQ63ocYDD2EKvNRM/bTkDWlMYQX3Nkr9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHPEkAeS3jd4/i/MhaA8yJcZG8sqWDZoRKuMooCO8H3Mt0J/hT6fHx40IS7n57cwU
	 vyyeuDKcu7cn4nmApHumYvrhZUB2PFH0auIKJagUaJdShz3eck71pWjSBr+mJ54sMH
	 4G12S1XJsygtNi2Qr6O9IOrJVG1TVV1sRp/WT6cUPiADFtdpSD7m7RUNh3CP6J6yU7
	 RN4AKuGtqiO03nC3tkdmhw9wUCRJMx7kVpNOqVP5M0mfXDGcdYXkvu/rcTbg7jC1LL
	 BAyjtlKUavLTKRBGZkesY/j7lTCP8VZ7iWn3kpYXDCA8yX5uc9XFmvy+cKVDNu8bwp
	 IdDn0+fKkDK9w==
Date: Thu, 5 Sep 2024 07:56:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, Alexander
 Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next 2/6] sfc: implement basic per-queue stats
Message-ID: <20240905075600.2b0d0bca@kernel.org>
In-Reply-To: <f7da4b25-234b-8393-66c8-6adb66ebaaf8@gmail.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
	<54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
	<20240828174114.412e4126@kernel.org>
	<f7da4b25-234b-8393-66c8-6adb66ebaaf8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 11:57:59 +0100 Edward Cree wrote:
> On 29/08/2024 01:41, Jakub Kicinski wrote:
> > IOW let's not count dedicated XDP queues here at all, if we can.  
> 
> But they should still go in base_stats, like other not-core
>  queues, right?

Yeah, I think so. I'm not 100% confident, but I think it makes sense
for tx-packets / tx-bytes to be inclusive of all more granular counters
(IOW even if we report xdp-tx-packets, the main tx-packets should also
count those frames).

