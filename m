Return-Path: <netdev+bounces-228011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F8BBF0A5
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB94188FAE3
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B02DCF4B;
	Mon,  6 Oct 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOQsp/2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFF2DCC1C;
	Mon,  6 Oct 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777094; cv=none; b=J+wWBG3wXKt+pkefy+rd5sIua1xD7B29yzJ3M5KE1kwfGLDAB/z/xlQfnbHfkuec8rLuSB+RVBs0pYUMBzd/ACvwZUE2TL8wVixKROKj+cRJ47h6xllrkT8GttqvU1OiMdoawwHZyWOlJEtyPO9nKeT0ZRqZOh1NrTYnwDUVcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777094; c=relaxed/simple;
	bh=EQ4uWkwOsXFtr6Jl8rn1Zux/nZscRyE5FJm9/x9kpzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAwIq6YWpzZS3YRb38zGeJRzPSPyNPEGrf4O2fH6b+xxAMbSa8gxmPodSjyH3TrIugmJPvPFb35qeBidoy432aqAF+LfjP8aQxdkAzo09n0hjJjPStcUiP3cKAXWkJYNDJBz39bImeFZwPiQRgq01+v4GCi6nOx6Xrr3F92ztjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOQsp/2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599C0C4CEF5;
	Mon,  6 Oct 2025 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759777093;
	bh=EQ4uWkwOsXFtr6Jl8rn1Zux/nZscRyE5FJm9/x9kpzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VOQsp/2l5x5ZrGCDguSo9tX2p51COFjg9UTdLx2Lp8SVWRfRDTMVLfL9LFwky32O7
	 kTjgOrJokHiTSmmJ08ZWRkyeRe5C1JopFxIvXKYtDYxXpzHDC9ayE50zPhdOlX60Wo
	 OyE8m9xBKaVfOzrxB2GlNtUgiOozdFsMKgJPBLLLEu5MM5HCsglH6dws6Yc4dXYjFU
	 zsnBm20oPHQo+anO29UgtmxvE8O4KZddZaW44zXcNK3GKhTr5McA+1WfyNdGvOjY4D
	 7Ko6MW8K2+Avqzb84OsV0/YZHR1QVwJVbcINzHzeHm/CqXi0bxaCyus6/FTDsHYaup
	 JfoUIsCs7X1+A==
Date: Mon, 6 Oct 2025 11:58:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, James Chapman
 <jchapman@katalix.com>, regressions@lists.linux.dev
Subject: Re: Kernel panics trying to set up L2TP VPN
 (`__xfrm_state_destroy+0x6e/0x80`)
Message-ID: <20251006115812.7408e8e9@kernel.org>
In-Reply-To: <b353f7e5-c32a-4f91-acbc-2b7aaa64c28f@molgen.mpg.de>
References: <b353f7e5-c32a-4f91-acbc-2b7aaa64c28f@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 08:37:06 +0200 Paul Menzel wrote:
> #regzbot introduced: v6.17..070a542f08ac

Nothing obvious in this range. Could you bisect?

On xfrm side only c829aab21ed55 stands out but it's not too complex
either.

