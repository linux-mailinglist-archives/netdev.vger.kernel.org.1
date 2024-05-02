Return-Path: <netdev+bounces-92986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489B8B9871
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFB21F21D81
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE95677C;
	Thu,  2 May 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKs3p66c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076C55C3A
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644312; cv=none; b=AKPOOLF9CbTNeaXKBjR4qL98/bGUPxO0U7MS3QKaLeyED10OTLKBbzaq+wKbcKi3Tu5a/D2qW6EqfC+c3GIQkQ/WP7w2kSPFngX5pKgqgSSbM3qy/J5h5MwHPQ7U2AmbB8sPth+foVPlYgLeir9c4PreGShGlUAEhmh8fByBoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644312; c=relaxed/simple;
	bh=XA54+vkxyFiaYwnHsiXyvBh6VdPEEYCKBNNOuwZdloE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duJMNWnAXR8ctjMkBUx4qwaq14cPBwbdPwqCFTcxFoAv5XHapwG4l1C7auqBjFB1hUDIXaDEriKZzhMh37UgwSyXrjU9KVWSEJXz/b9PH5aloCS81QjkXoQ860ylM+I2vKZZ99aI8Q3Ubv9/snlZ69IGy2XRD7bS9bPT7Ib+HOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKs3p66c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3282AC113CC;
	Thu,  2 May 2024 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644311;
	bh=XA54+vkxyFiaYwnHsiXyvBh6VdPEEYCKBNNOuwZdloE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKs3p66cc/frFKugP9CudH9mdBPe6IRPj4mi0aYq1/iYnch8iiGVAWeu0LrunnyQa
	 ugtS4zpzBPb6b9xwFjjuGkuWJN1oQpx+mrzjzXgD3hg4t9CAyBtr2DfkYoQ5wcVBnN
	 XyDqlRgibkVeOfyju1YnSw4YoZV9PzdJF4pe/+ylRNHoZln/aPnbZQ6ukAFaxnWdfQ
	 F48rtsfMilz6tAenHvtJlTzPEWK4yRgcBqDGTgmGUmF/qd/QewcyjFPwaJK6Kt++1P
	 OYP27bE1sx41HY4vHnyvjt0wGuYLIhgHjm5JWboRrsTP4b6SCohDiQfYSm8DJc3lFx
	 2x3s8R+QSmlEQ==
Date: Thu, 2 May 2024 11:05:07 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next v2 3/6] bnxt_en: Don't call ULP_STOP/ULP_START
 during L2 reset
Message-ID: <20240502100507.GG2821784@kernel.org>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
 <20240501003056.100607-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501003056.100607-4-michael.chan@broadcom.com>

On Tue, Apr 30, 2024 at 05:30:53PM -0700, Michael Chan wrote:
> There is no need to call ULP_STOP and ULP_START before and after the
> L2 reset in bnxt_reset_task().  This L2 reset is done after detecting
> TX timeout, RX ring errors, or VF config changes.  The L2 reset does
> not affect RoCE since the firmware is not reset and the backing store
> is left alone.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



