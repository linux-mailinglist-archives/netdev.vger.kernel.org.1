Return-Path: <netdev+bounces-122422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A876996139B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EBC1F21742
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DF1C86F0;
	Tue, 27 Aug 2024 16:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220211C6F5A
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774732; cv=none; b=n+2vjPlslLWptM3j06ZcjyRNdTcReCnNGvs+k4+vGnLuQzxO1LVwjXV0AUHIRYuj9vPDPeowgszPY+xx+6tCy/xf2U6/KZ1/IcMSiEdEj0yzNbe4EaesJ7AJoQHUOWZ3M6IOdk6qXdTSqtU+4I04WWwoXMjs6KIHH1nRbPXGink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774732; c=relaxed/simple;
	bh=ZboCG4JruvjXUV6pV3kduWo0kU0nDy9wPAiXDKO4SBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+rXry+F9vPAkKGy3IzOnyK5pnl6yyh9Ifw0Jz+U6L+FUxBhFGvcvCjlxwDHsnF30DI9gcIatY1BkfQoGyxyLQjHjh/Ma2e+3rZM/gGtnirUxMNpFxfHmV22FIVXWuuDRRpdHkHOzsLt3SZRUySaioZnA18fdFkJW3rUieuQ2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=45930 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1siyh0-000F7h-JJ; Tue, 27 Aug 2024 18:05:16 +0200
Date: Tue, 27 Aug 2024 18:05:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	Andreas Schultz <aschultz@tpip.net>,
	Harald Welte <laforge@gnumonks.org>
Subject: Re: [Patch net] gtp: fix a potential NULL pointer dereference
Message-ID: <Zs35Oeb7O0rpR5mR@calendula>
References: <20240825191638.146748-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240825191638.146748-1-xiyou.wangcong@gmail.com>
X-Spam-Score: -1.9 (-)

On Sun, Aug 25, 2024 at 12:16:38PM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> When sockfd_lookup() fails, gtp_encap_enable_socket() returns a
> NULL pointer, but its callers only check for error pointers thus miss
> the NULL pointer case.
> 
> Fix it by returning an error pointer with the error code carried from
> sockfd_lookup().
> 
> (I found this bug during code inspection.)
> 
> Fixes: 1e3a3abd8b28 ("gtp: make GTP sockets in gtp_newlink optional")
> Cc: Andreas Schultz <aschultz@tpip.net>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Harald Welte <laforge@gnumonks.org>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks.

