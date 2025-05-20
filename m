Return-Path: <netdev+bounces-192020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D071FABE491
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C9A7A4E0B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C0288C86;
	Tue, 20 May 2025 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T+7fCAcI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6E288C1E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772087; cv=none; b=jNK5vJoNGLqFRKgdup+2HgPF6tnGWnV8vR7QBJSgBSGbeEQDZXser2DLWXUsw+KS0khe0P7qlNz9qXnsqk1PkEAPeIPIO2cvg679nciOxPxR2eE/fXgPxyenKxdKSWD9vM0+ahk3X5UW1iCjHfm3Lu2fKR/vQKZNrGYZUPlHd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772087; c=relaxed/simple;
	bh=TlR/dRTUvnM7UqANvHrX4aBWK3+udPPb507JJeNHiNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG1/93xsZ3OnOQr7xb+FiVJLij7+A834CsqKHk/M7Bspu8GTn2sP3T/Bl0sZGkara5J5glvR+OzTg6gtJ7g2VhxVdr8OAIB3+FOtZQ5ZoGR3v85Z6bT/YjVFnIEp0xfzXbNOOvYfKALgX3hCkbkZxGLIVoK4kAPFBmtUBfVUcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=T+7fCAcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2957EC4CEE9;
	Tue, 20 May 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T+7fCAcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747772082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYSS96uTwjKSBfcMuBK5F5h9dI4mxU0zoFKgrU6mSbU=;
	b=T+7fCAcIZm/kOhYe3Bp7eFizdkBQIp1Ruq4TOBvo3V+V3EatzF94P6NRKKHsP8TgWOEKx5
	auNUCV0RW29fgdzyhROC21DHAKyWDPclBNqgzTlFB4eYPnWbjLTMZjX04UIE5Vlkos20Pl
	WQzObaQSabuCa+mNh3kbuqiqzBGgjNM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 191e9dc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 May 2025 20:14:40 +0000 (UTC)
Date: Tue, 20 May 2025 22:14:38 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support
 incremental allowed ips updates
Message-ID: <aCzirk7xt3K-5_ql@zx2c4.com>
References: <20250517192955.594735-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517192955.594735-1-jordan@jrife.io>

On Sat, May 17, 2025 at 12:29:51PM -0700, Jordan Rife wrote:
> Extend the interface of `wg set` to leverage the WGALLOWEDIP_F_REMOVE_ME
> flag, a direct way of removing a single allowed ip from a peer,
> allowing for incremental updates to a peer's configuration. By default,
> allowed-ips fully replaces a peer's allowed ips using
> WGPEER_REPLACE_ALLOWEDIPS under the hood. When '+' or '-' is prepended
> to any ip in the list, wg clears WGPEER_F_REPLACE_ALLOWEDIPS and sets
> the WGALLOWEDIP_F_REMOVE_ME flag on any ip prefixed with '-'.
> 
> $ wg set wg0 peer <PUBKEY> allowed-ips +192.168.88.0/24,-192.168.0.1/32
> 
> This command means "add 192.168.88.0/24 to this peer's allowed ips if
> not present, and remove 192.168.0.1/32 if present".
> 
> Use -isystem so that headers in uapi/ take precedence over system
> headers; otherwise, the build will fail on systems running kernels
> without the WGALLOWEDIP_F_REMOVE_ME flag.
> 
> Note that this patch is meant to be merged alongside the kernel patch
> that introduces the flag.

Merged here:
https://git.zx2c4.com/wireguard-tools/commit/?id=0788f90810efde88cfa07ed96e7eca77c7f2eedd

With a followup here:
https://git.zx2c4.com/wireguard-tools/commit/?id=dce8ac6e2fa30f8b07e84859f244f81b3c6b2353

Sorry for the delay. Next, the kernel changes.

Regards,
Jason

