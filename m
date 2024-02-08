Return-Path: <netdev+bounces-70303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17D784E4E8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE4428EA27
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7D7BAF2;
	Thu,  8 Feb 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNRBjsfa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C47EEEB
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409286; cv=none; b=MpTY+lPB59m4wPuc+mfZfNzg29a0ZsMf+ZahMJe4AUD3P+AZYeFhtRmauV1zzfxCHyqd1y3rG5EQNG9TAYZUFvMCe0RW52yiyZ2JwkIOfqTBGe2YoRq1qlPXd1OonLulc/nsnueSXJc2EoN5HeURRU+psaEwlQmPfTx27rzpJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409286; c=relaxed/simple;
	bh=V0SrF9hCzBjzNy1frf96dnJyvujypGgq6Ptnox06IQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZAKsAcWuUioLT/jq/whNTNukRPi1mWyFmQxTEw5sZhAQu2exJ1jC3hMY8bWKu9r13sGzkxfTJ4PrUtl2wyBT4+Eu28Hrl3KNRDGsaYkjGYIcv39eXFepIPnBaD11DBRp7hSXimdf/1HDKBRZk4bQAiDEntn697eDLkUo4xzP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNRBjsfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87239C433C7;
	Thu,  8 Feb 2024 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707409286;
	bh=V0SrF9hCzBjzNy1frf96dnJyvujypGgq6Ptnox06IQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNRBjsfaPKXKJytpE/y5iXQW+Ceh94qfO4XrL23BbA06CWFa+bStYHz7a8lLDBosc
	 7R+Dh/UQwqkM3Gg97k8Z8iM56SxMISKIAWEdN58kHmilb+L1/eP25GOBlRTgKwPlL1
	 QICbztgqh36f33Ow7YY/b6BgsQCaMxMBXVhkRP6BirBM9/rjyFBt043k9MM9K+Kzjd
	 kKefADsVHGGSS87C8G1XSQTNLTmRxDkw2U7lhslWhMGnvsW0qyvo26h+BR+kro20Cd
	 BrBTrGuYLYyfZrr1ZRXdYStk/TXM9JeOwbwuO0xPNyBA9C101m2Kshd2LN2dtCDqSk
	 W48VGNJLY8m9Q==
Date: Thu, 8 Feb 2024 16:21:22 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: improve checking for valid LED modes
Message-ID: <20240208162122.GL1435458@kernel.org>
References: <8876a9f4-7a2d-48c3-8eae-0d834f5c27c5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8876a9f4-7a2d-48c3-8eae-0d834f5c27c5@gmail.com>

On Wed, Feb 07, 2024 at 08:16:40AM +0100, Heiner Kallweit wrote:
> After 3a2746320403 ("leds: trigger: netdev: Display only supported link
> speed attribute") the check for valid link modes can be simplified.
> In addition factor it out, so that it can be re-used by the upcoming
> LED support for RTL8125.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



