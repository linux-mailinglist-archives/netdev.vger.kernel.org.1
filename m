Return-Path: <netdev+bounces-191979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA2ABE162
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3538416C537
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679F242D85;
	Tue, 20 May 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLwg9g0U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211279CF
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760227; cv=none; b=jS3OcFgQfrlDqNFqeExdDIb7IOBbHbXieuR+Hb5Py6J9J2GP8gqV9TqM1sM3PO/irYdHDkcm5PTdi6OVpB5lI8NG6DF4cwwnh1YyrROGKerWxtIdUrrOCTZSNklf0IQ5NpCnXlowhCb98u5umeVMX51VlyAChj7oTHPCXFTUCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760227; c=relaxed/simple;
	bh=4sX/fln62L+mSdDAuNnMkFrBHMwLa7HtjG604R4Nu7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAjbKfRVIVzZzJ8UzI0nuE+OfUJ51ql6gHAVa7mR+1nyPyfJk1z8QG8JN4M9v+WOHtN735sWmv5DJzFiKV0VxkUfETNEo1HYarlfgTCHA8tMeupQjRw2S29FG8erhicasPtUqETpF1NOfsWnkRKaKA2ngFU1GRtZtcL5WAr56EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLwg9g0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39066C4CEE9;
	Tue, 20 May 2025 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760227;
	bh=4sX/fln62L+mSdDAuNnMkFrBHMwLa7HtjG604R4Nu7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLwg9g0UmTcPBH4lTc0YTpY6k84nE2GFN88ywK9KeAxB0IlSnPAqnb91k6RsVocLQ
	 u291cvOqjFlA34nHLcd+nXSY74TXEFyHaryC65C7WV9FnlwHZ6lyXF/p6QyrmHCEcN
	 Iz0DG8KlYm7OSg/l/E9O7X6FYJ7zMMm6yutidgnpvLCsYsSRL2sbPrFHA4cCJd9pEG
	 W7p+qRSLw96Kp/pOki32Nm+zJiZ7r/I1SZiReG+Ofq0nHwDlzBx+AyI5yc36Y7hCyi
	 TjrpLVpH1N3/W1HdZD5dVTNypNmgejcZCvG5yfJyKaA3NCMJ0neQ75g8T79v7izRz/
	 VVNbfo4bPoPfg==
Date: Tue, 20 May 2025 17:57:03 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/9] net: txgbe: Implement PHYLINK for AML
 25G/10G devices
Message-ID: <20250520165703.GJ365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <A8546B4037DAA0AE+20250516093220.6044-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8546B4037DAA0AE+20250516093220.6044-5-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:15PM +0800, Jiawen Wu wrote:
> Support PHYLINK framework for AML 25G/10G devices. Since the read and
> write of I2C and PHY are controlled by firmware, set fixed-link mode for
> these devices.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


