Return-Path: <netdev+bounces-223519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB9B5964F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7551018893DF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D42E229E;
	Tue, 16 Sep 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZIIOPgT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201C2DBF78
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026171; cv=none; b=rJQsjCm+DkhRVJo/yuKoh3RS1Wf7hnJqjQljG/dfXo7kgLSWt+6h4kVHxxQ40gLqT5vIt9cxJqF4gqiitIzsmCdsOx81CfJKIhXsLkCvjaAaFZ4LpLhsh9gHrOliiMZDWm1QYJXdddu7dGA7MC+z5B0sBPBSm9SRvNfQGXdCCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026171; c=relaxed/simple;
	bh=+KNT56lbH/tmqOKWYVen3BtIMtq9bc2rRKfihkLNoqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+DIJcgsOEsDyAOIT9PocVGb/NWKTx2PKGk+3HzKuHM700tUTSc0ir/IvYHoxQSj5UkoIuj8Sd3w4pQR5Py9fNZhmJB7siHbOfLqSXL7XTn45wU9WQr6985gPL9Q3APiqEnTJUcK0ruIpb2WvCFE8HOGQDTZ7f1+l/LfMOmPRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZIIOPgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7117C4CEEB;
	Tue, 16 Sep 2025 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026170;
	bh=+KNT56lbH/tmqOKWYVen3BtIMtq9bc2rRKfihkLNoqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZIIOPgTvLwB+N8t/aqUs4yJZn+q8lPzpOei1x52OHpwmpB3U2/92aLYoL+MhL9Z3
	 5YzQ0ZkzmYDzchecrRmko4HMXFWWAIaj6fUnc86XqNKZ6rpq/EAaXJZmeRLRd32erL
	 UtnQUMpcD0dlZoZeqL8UcE6PE7LqdqR39QIOkZ8usQQXxX++BRPTnW+KauloJQJ5dh
	 KFTS315delHAp4vyoTT1QPUyMn6+dr/TIwr/f+h6Cb+br+efV0g9j7+FQstc+A+8z8
	 fv4ar68xJo2VT3xEiinBHbW9y86WHZyC/E3oz4V+QD1nhB0RD+FUTOakMZ/O2C7CUL
	 4aZudFRoTo1cQ==
Date: Tue, 16 Sep 2025 13:36:06 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 4/9] eth: fbnic: reprogram TCAMs after FW
 crash
Message-ID: <20250916123606.GC224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-5-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:07AM -0700, Jakub Kicinski wrote:
> FW may mess with the TCAM after it boots, to try to restore
> the traffic flow to the BMC (it may not be aware that the host
> is already up). Make sure that we reprogram the TCAMs after
> detecting a crash.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


