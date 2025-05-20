Return-Path: <netdev+bounces-192046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF2ABE5CB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CF87B0C38
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8031AAA1E;
	Tue, 20 May 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QwjMz1oL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA547846F
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775436; cv=none; b=M/BhOTyfAVtpGAJo0tDokJMJZsWaGEVQiH1thFSOaF+WKVtPY1Kaj1QBG/FmLVB6qgfqu7DWCvqyTMDmP1Vweo85NJySGWH9Ax0oR3EPxInONLfg1NIoJG/6DC0D0jprZ9VvlkpSJrgC0gbs4vDhQrAMXsimosX+zVwx8ZJNKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775436; c=relaxed/simple;
	bh=wGt/PRoUTXt8q4ByPicf9lrCtA/S/v7jf1tXnbH4IO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT/aMVY53NeQoVf1jiuWYx0nOgWbce4EtKkYaNHF1ZB+GQVPZ5n9h8lF2XUbLPFJLNR6PNQRdh+hqzZA65KJOpF7FcQPSwGceQiJdRVDLyD7jFLKlDOQih4VWcW11+bdBwvgSVkYA6/ki1AfWiDZBVuIAuDyjlIcZ5nH7o3xdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QwjMz1oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7474C4CEE9;
	Tue, 20 May 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QwjMz1oL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747775433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FcnEUGIidvbrlCTFSfkiuxs9z+zoIVTbHGD/stmUpa4=;
	b=QwjMz1oLEl1hY9lT5yC3iLOlYgINaXWp5E7pdcGmuRJx55H9Abqa1/AY8pRzs9SexBNZTz
	f33q4DeERkETNmmZhFy8j2uHEQzuD07l8nBYE5DpYIbV+H+6Q63mThUG7tJx0BqInuJBUq
	5SdNFiYan795g3SR9e5YbFtHXTNv6Eg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 387b7411 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 May 2025 21:10:32 +0000 (UTC)
Date: Tue, 20 May 2025 23:10:30 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support
 incremental allowed ips updates
Message-ID: <aCzvxmD5eHRTIoAF@zx2c4.com>
References: <20250517192955.594735-1-jordan@jrife.io>
 <aCzirk7xt3K-5_ql@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCzirk7xt3K-5_ql@zx2c4.com>

On Tue, May 20, 2025 at 10:14:38PM +0200, Jason A. Donenfeld wrote:
> On Sat, May 17, 2025 at 12:29:51PM -0700, Jordan Rife wrote:
> > Extend the interface of `wg set` to leverage the WGALLOWEDIP_F_REMOVE_ME
> > flag, a direct way of removing a single allowed ip from a peer,
> > allowing for incremental updates to a peer's configuration. By default,
> > allowed-ips fully replaces a peer's allowed ips using
> > WGPEER_REPLACE_ALLOWEDIPS under the hood. When '+' or '-' is prepended
> > to any ip in the list, wg clears WGPEER_F_REPLACE_ALLOWEDIPS and sets
> > the WGALLOWEDIP_F_REMOVE_ME flag on any ip prefixed with '-'.
> > 
> > $ wg set wg0 peer <PUBKEY> allowed-ips +192.168.88.0/24,-192.168.0.1/32
> > 
> > This command means "add 192.168.88.0/24 to this peer's allowed ips if
> > not present, and remove 192.168.0.1/32 if present".
> > 
> > Use -isystem so that headers in uapi/ take precedence over system
> > headers; otherwise, the build will fail on systems running kernels
> > without the WGALLOWEDIP_F_REMOVE_ME flag.
> > 
> > Note that this patch is meant to be merged alongside the kernel patch
> > that introduces the flag.
> 
> Merged here:
> https://git.zx2c4.com/wireguard-tools/commit/?id=0788f90810efde88cfa07ed96e7eca77c7f2eedd
> 
> With a followup here:
> https://git.zx2c4.com/wireguard-tools/commit/?id=dce8ac6e2fa30f8b07e84859f244f81b3c6b2353

Also,
https://git.zx2c4.com/wireguard-go/commit/?id=256bcbd70d5b4eaae2a9f21a9889498c0f89041c

