Return-Path: <netdev+bounces-173420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CBBA58BDD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE603A8332
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF821BCA0E;
	Mon, 10 Mar 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTPk36vJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193611AAC4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587553; cv=none; b=Nd5Yy4b3Mi4B5d6B7vavI9YxjDrIpevGh372C8VBBoffNaDncow0v67Dt2tsq5BOjdRZxsyNUnOtnLut4WYPYdYM7EQ91MxljjLGzf69f1z7aH11xT4+uqbeaewMzSTgsKzziFghLo5dIocqws8a3ajeuK8mbVZ8HF2P1tBTTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587553; c=relaxed/simple;
	bh=Sv4YmjFGO0+CNLZfnQkZWDeU0F4+7mLECbFBYPMWMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IebzoYGhCC5SyyoVaA88EQl4GWAlVyBwzHKKrMy2bkzaWtLU7rwrQmcypD08wzKuD4A5gSOIlpeph4osOdShNlO+yZAewfLWtqWLVWBPHd/YP9sf+z6+ohop3UBqXPbpPDj0M1J7Ke7nT2ek3EpAehCqEoVpndVhK7TzlgU4yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTPk36vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E689C4CEE5;
	Mon, 10 Mar 2025 06:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741587552;
	bh=Sv4YmjFGO0+CNLZfnQkZWDeU0F4+7mLECbFBYPMWMS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTPk36vJKNl8nXiYImvQPlLZbIrQZGxqz4p1u0m8wolRJiKMCYCrr3sLH1pU800Y5
	 XRbPdycnE7MjFJpmhJoJFby2Nm+j1IifK3xGDuJR92usonGNSicdaR7yud6uhQxuOa
	 scpcIsZ6WHG/9JiRtp/OK7HSdEWDWes7b17dtaKUr93A2eyuiUOJo5sjR61lilNQ8P
	 jVr+lZF1MbUfze3v8MmQJNeXKEGMZPiPmXmW240fRs7+Jun6dzl7ZEQdfhYgrPGvV2
	 G1G4I0iv/nMsUB8gU7RtVhvcfB5bW5wq+FQCI7lNTysyQVSqcdUvupYVxmtklpu/FO
	 Co4ZhxkO+4wDg==
Date: Mon, 10 Mar 2025 06:19:04 +0000
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: mctp: unshare packets when reassembling
Message-ID: <20250310061904.GB4159220@kernel.org>
References: <20250306-matt-mctp-usb-v1-1-085502b3dd28@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-matt-mctp-usb-v1-1-085502b3dd28@codeconstruct.com.au>

On Thu, Mar 06, 2025 at 10:32:45AM +0800, Matt Johnston wrote:
> Ensure that the frag_list used for reassembly isn't shared with other
> packets. This avoids incorrect reassembly when packets are cloned, and
> prevents a memory leak due to circular references between fragments and
> their skb_shared_info.
> 
> The upcoming MCTP-over-USB driver uses skb_clone which can trigger the
> problem - other MCTP drivers don't share SKBs.
> 
> A kunit test is added to reproduce the issue.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> Fixes: 4a992bbd3650 ("mctp: Implement message fragmentation & reassembly")

Reviewed-by: Simon Horman <horms@kernel.org>


