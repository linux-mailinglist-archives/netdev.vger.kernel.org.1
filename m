Return-Path: <netdev+bounces-292810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF2mJiuVGGoMlQgAu9opvQ
	(envelope-from <netdev+bounces-292810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9955F6FA0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FB93145E60
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32F336EE1;
	Thu, 28 May 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQRMEHIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11F327C00
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995532; cv=none; b=ZojZWNv8KvjpsKFCmgzYpRQjGb6Yc+IIqIY75l8OZowLnt1om5d9VtVoWht2ZBanoQh0ECjyLhtdzTe3mYl2aWVUdw8jhc5wqZKbbQTV0SJPpdtdab4gN3m0KvQjyIIuypWnYp5G5/LL7CNaQuHs20PqVlHBEo7m+sKn83qMXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995532; c=relaxed/simple;
	bh=PXKn2fj8MiB6ZRn+FpH6vI5y0lb+a4h1PKvU9QBWPSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2sj8/B78S/mABff0f6IdqLGWsW2Py3ThsLjUAB2xoh/VFznH+qk/Jn1Zyy38iOrU9owYfW6EHDXiWrOHRNZmr11LbRqyxHYXMloLAakHZGOWNDsVGxjvBy5OSZpvcsqurxZj1UcFCL2v2ePIp3yVp0bqIh6POSKx3dYgqnPMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQRMEHIp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F161F000E9;
	Thu, 28 May 2026 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779995531;
	bh=VlcLyxzqqQ611AZcuYt9h0jVgmDu431mMCnzpC64ho4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JQRMEHIpWgY8LfCau6zfRNgCi+wUCzLyRJrMW+YYFhgf10HMZFRBNcJTSXqLXLN1s
	 eK4Y8eIrVF2rmN6FKBltc5i6OR1zXIsgG+kPD0X1IS8A757XiXr+X1Kp1Q1FJUmKHS
	 nkrm7q7Kl6HDfjERPXbgRqi2XL3MWDPaCp77kSBV082Vs9+FAYSe2R4IUXeRpcIaoD
	 RVvtJPnY7UcLIFujw/O1Xh4wOTjaSkXch+WxfEjpXre8E85RZP70cS8uWIF+FKMTyc
	 bzKoe87bxpn1mR6iLMkfvA8MebJqqVLF1jITsb+wRT5YRgZUegYTImbrZendqmCCrB
	 TZjNkL9darvLw==
Date: Thu, 28 May 2026 12:12:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260528121210.40b0e493@kernel.org>
In-Reply-To: <20260528170510-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
	<20260525125437.4061-3-oscmaes92@gmail.com>
	<20260525084528.547fe263@kernel.org>
	<20260528142851-oscmaes92@gmail.com>
	<20260528080748.3e74355f@kernel.org>
	<20260528170510-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292810-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC9955F6FA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 19:05:10 +0200 Oscar Maes wrote:
> On Thu, May 28, 2026 at 08:07:48AM -0700, Jakub Kicinski wrote:
> > On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:  
> > > On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:  
> > > Intel x86  
> > 
> > LOL. Please. Which _hardware_ platform.
> > Or to ask more directly - is it QEMU.  
> 
> It was indeed tested on QEMU.
> Either way, the performance measurements were just a sanity check.
> Changing the code to use the modern API is just better.

Please don't waste our time with optimizations to unused code.

