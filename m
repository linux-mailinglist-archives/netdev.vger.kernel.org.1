Return-Path: <netdev+bounces-158300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B75A115A9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53A6188AD3B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21B21423A;
	Tue, 14 Jan 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdo9LpT8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1A214205
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898711; cv=none; b=CfxClKhHlOhZDoIx/uV6RWtfyzWp0D1DL/y9+8jMHmTCMDrLQ2ickBRyXb65aswzqRU1IwqhNz+6KsMZUJBGwqwKxKC3PYxc8Xr/eUwTaXLgzry+ZJ7v66CaOAuvZA9xO7jahtHdnoKOd1gr+rXvOJDlaFrWF44svQMsH1DhM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898711; c=relaxed/simple;
	bh=HRTPbj0ERfct67nUxfURToU47umkgmXTfC30HbW5HKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF6ZqM3bkqjWdyt+KLD/d/44I7Pg32PsToG29hXi2cE+27NpEngAbrGDD88W9W6tANyv64AnNBYsNWOkQ8YzHn47j9hgu5NKJXpvYQqJjdDIL3JlFUPO57+hLUnQyyqVXSoIvdikY0IZpDzJNLaluChwf2brBoiLEqmIQ8FPCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdo9LpT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB209C4CEDD;
	Tue, 14 Jan 2025 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736898711;
	bh=HRTPbj0ERfct67nUxfURToU47umkgmXTfC30HbW5HKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hdo9LpT8UJ4+kIRz/fJKp78HeH2JbFQGHHinSmvq2/xcJzdGBzQ1BGAMrUrLPnhzd
	 FvxxRk0XvJINMyKt2SShRHOC2gJw+zpdupGbulgt41w23RH3FauFQlwsw0dDkhR1Fl
	 SVfSAgN2XkNj0k+ch/A9CtBsNchcCUcdCIiwEoHv/QfDgl358akxFCQM5X94wvhRDI
	 A8dxB4kG3xoRaw7jNQth+G2If0gXJFHPVYPGpOAHAIivgmkrtrEotjvB8YnkJkj/kZ
	 GxkF6W6IamEKSe3OobtgGlDJOyH4s27ujux1ZwR/1SXcVRVdpEu73Ogh/SLEKj868g
	 Vy+/7INjKoQNg==
Date: Tue, 14 Jan 2025 15:51:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 02/11] net: add helpers for lookup and walking
 netdevs under netdev_lock()
Message-ID: <20250114155149.41cc3ef5@kernel.org>
In-Reply-To: <Z4bq2y0fHtAlfBpf@LQ3V64L9R2>
References: <20250114035118.110297-1-kuba@kernel.org>
	<20250114035118.110297-3-kuba@kernel.org>
	<Z4bq2y0fHtAlfBpf@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 14:53:15 -0800 Joe Damato wrote:
> > +struct net_device *
> > +netdev_xa_find_lock(struct net *net, struct net_device *dev,
> > +		    unsigned long *index)  
> 
> Minor nit, the other added helper functions have docs, but (unless I
> missed it somewhere) this one doesn't. Maybe worthwhile to add
> docs if sending a v2, but probably not worth a re-roll just for
> this.

I didn't add a doc because it's intended for exclusive use by
for_each_netdev_lock_scoped(). Shouldn't be called directly.

