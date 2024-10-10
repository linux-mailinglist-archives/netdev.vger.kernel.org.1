Return-Path: <netdev+bounces-134152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF39982F2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89EB1F216F8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC21BDA9C;
	Thu, 10 Oct 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kldeS9Hs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B01A0BD1;
	Thu, 10 Oct 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554174; cv=none; b=Ih2dHPvnLr/OSYdp7YpMlf5HpBlj3x0vDiBmWrDOwbsSIVKyacsPmi+ttYXDyN8rBLYgY1PsgBMrpTo06f/AjfUr44lRFBKcHTaurB7HcqwDDQYRtx9NxyWREFpHMqieje1RHESO0Cs4iDVfcCKKRiq6pdXwDtd4Et96Wx0or+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554174; c=relaxed/simple;
	bh=ospF9mhD7lzZs9BejfsW6l90BD8RroO4aLp3K1G/cF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKYL4J2k5yUjqkWikgGU1qQI04gD+AL/9u/qKN7Lvy14G4A9pzTNmRcV4lUFo1TbkDL9i+/SFQ2p5zajfPrDcwe9Rhhq38PEf3C/CKSDpORedxvGM1GVICwKA60IeLUdqVaPzzGezzk7DprocpS4SfReLkJ7JCq5ghMhHg3q6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kldeS9Hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0D0C4CEC5;
	Thu, 10 Oct 2024 09:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554173;
	bh=ospF9mhD7lzZs9BejfsW6l90BD8RroO4aLp3K1G/cF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kldeS9HsG1XglKKaYTYw/VAH720ZQ0dg1Upv88QBIv9ORQMUneaz5e9dy7+8cS6d3
	 A4pU+tG7TQJBsx/IBRDE9dbCtGU+XymmeIVzksIB+3MabH/29FhnKWXX9Yff059CoG
	 1m0QS6sk6Z5J5BzJsJlGlNP17mMhcIPgrFAONDTMxsFftVBuDPkQKWDOROaqkK9Vrq
	 irrHYC6pjmf20nREMGZripKLEpacHcGUYzIgoayam2RCQjTuS5T4S6lnuDRQ/II1/9
	 Rqk16Ml66kzcxgLcup24YPjaxlR+Xft99l7XK5hz1ctRpsaIGrGnPs7i5pC5NRPmH9
	 oUZX7jnh73Kwg==
Date: Thu, 10 Oct 2024 10:56:08 +0100
From: Simon Horman <horms@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com, Abin Joseph <abin.joseph@amd.com>
Subject: Re: [PATCH net-next v3 3/3] net: emaclite: Adopt clock support
Message-ID: <20241010095608.GD1098236@kernel.org>
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1728491303-1456171-4-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728491303-1456171-4-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Oct 09, 2024 at 09:58:23PM +0530, Radhey Shyam Pandey wrote:
> From: Abin Joseph <abin.joseph@amd.com>
> 
> Adapt to use the clock framework. Add s_axi_aclk clock from the processor
> bus clock domain and make clk optional to keep DTB backward compatibility.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


