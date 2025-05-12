Return-Path: <netdev+bounces-189717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35727AB356D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A981883964
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042E268FF9;
	Mon, 12 May 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba/XEQAG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C9268FC8
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047450; cv=none; b=UGvpuZirJWufh9XcBiPdlDL7Eyh7iWnVebfuyKLM9KdCYJ4hVUeol1dUV0yqNNyMxGS4wmOV6Tj4KTm/u1rqb5oFjW84bYd5DCgVPTW7SrUIg+LBGV4NfuPuAVoUMzsLmQRLnYda0siRWY8qD3hUcmJsV4rzn3t/wCvemzgecBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047450; c=relaxed/simple;
	bh=ft3tp/TGCqtIPgW7LCqFQy6icTZ1RJOHTIZlPKaVFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inKtEMKjkU3r/wnaE1hiv4s1Ova0CsLtRrwrcINQn74XIXDUQ+5UcR9Fvkd/YewyVLKT7m3AINvTkattBtZlFY3XA0oDM+FvBiB3vnP5WKIaiRPfgNxOwaYHwydgACs02j7Oj6ikSmgJktjJIaXTfh94POJj9vnzg7It2wnDsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba/XEQAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4385C4CEE7;
	Mon, 12 May 2025 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047449;
	bh=ft3tp/TGCqtIPgW7LCqFQy6icTZ1RJOHTIZlPKaVFsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ba/XEQAGdUsdNOVTsAFNF2KQcRnIHUuM7Q+EtDVBHWE9mTPK7oP7Ez0CgtlvkTMMn
	 dgOcNk5ehuzNwefVX+xmKM3sRG0PYQYj171AxcnU+EVh2PRjJ1Tv4d8oyEHLTENfuW
	 fbpf87BYVnzqXtE+ViKniP1tomXb+mrTjRt9s48b3WGGMEhx+4zAmNtJye9bGYFxEW
	 trOOgbd3A1fjEol6gxm1vKJA8ZPXOWmKj5XzTCB2UMRpFHuEOMQ1qIp4A345a7rgO9
	 deUeal1v/mkfaydHWqApqq3mO2D0ikPytIRysWvGaghR5oJBznGJTa3EXfqKsTOCLQ
	 8mYIMAJo58KTQ==
Date: Mon, 12 May 2025 11:57:25 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net 1/2] net: txgbe: Fix to calculate EEPROM checksum for
 AML devices
Message-ID: <20250512105725.GX3339421@horms.kernel.org>
References: <20250509100003.22361-1-jiawenwu@trustnetic.com>
 <AB6DC619636B23FE+20250509100003.22361-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB6DC619636B23FE+20250509100003.22361-2-jiawenwu@trustnetic.com>

On Fri, May 09, 2025 at 06:00:02PM +0800, Jiawen Wu wrote:
> In the new firmware version, the shadow ram reserves some space to store
> I2C information, so the checksum calculation needs to skip this section.
> Otherwise, the driver will fail to probe because the invalid EEPROM
> checksum.
> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


