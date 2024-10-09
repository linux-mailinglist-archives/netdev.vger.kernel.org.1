Return-Path: <netdev+bounces-133700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7A996BAD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2416A1F22AAB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788861946AA;
	Wed,  9 Oct 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrMEsK0W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423B18787A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480002; cv=none; b=t7MO2G5jcfz7LP/eFlmEjAQ6WUWx0jljfsyjFcZMmsNlT3Tkqas4vBR5s5NI364WPZ2V/+cKzCGjv2ZLmz/gY4OUTz+qel4da/UgiIf63zzQTj8FTehM2pJggsqrDxqrHkEGO+uTWhbLbZmVzMl9dbOg48PJ8dPA1LV3yqf/Ntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480002; c=relaxed/simple;
	bh=AIHpc/xGYp84EXgDcG/alj4I6So81jRH2rYWHe4LUK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uldC/kCXI5HrtqYKKe129b5iSiKHisgDpsEBOsB60EoGDmtjldqZBFuI4ZO179rGZbEgzupujzYs7Q0WbzMvDjs4wlOOK1kUYBq7RGBa+Ny29XMfZ7rvC+k9wRXOPIVIp5Uyi0WsKtRLJe9HvfTonCV9BTMHiiiqcd7i3RxyfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrMEsK0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E423C4CEC5;
	Wed,  9 Oct 2024 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728480001;
	bh=AIHpc/xGYp84EXgDcG/alj4I6So81jRH2rYWHe4LUK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrMEsK0WA6micTY/Q7D3GcfSLUZVZGiN8OoJdi9vMRRUfHJf3YX6VdyQuHYFTBl/8
	 /cDR9/uMU40/CdR/SUDg3iISruaNcI5Gm2Cr3/94uB83pYY19eGD5rJz3OoutinxOt
	 5hqztjsBwUFXkLfItYzAQ8R/Nc0se2FY+XZILRFS/Y7B3Ty0KHr3HoO95+fyp1mnAj
	 HaVpcpdkop3nQpJsWugzz+E2o3B9t4ahY4sgNNw0T+T1madC6loXWvCmVRoIK+iCZD
	 U3w0JOvGVGQ9vq/mPTjy2nAVXzziJL7xOu+4/M5poQVg+J1/v1gea5/eYEphcghA6w
	 IwzO3slHaM4JQ==
Date: Wed, 9 Oct 2024 14:19:57 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: don't apply UDP padding quirk on RTL8126A
Message-ID: <20241009131957.GY99782@kernel.org>
References: <d1317187-aa81-4a69-b831-678436e4de62@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1317187-aa81-4a69-b831-678436e4de62@gmail.com>

On Wed, Oct 09, 2024 at 07:44:23AM +0200, Heiner Kallweit wrote:
> Vendor drivers r8125/r8126 indicate that this quirk isn't needed
> any longer for RTL8126A. Mimic this in r8169.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

