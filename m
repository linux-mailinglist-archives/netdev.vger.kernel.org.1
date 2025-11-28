Return-Path: <netdev+bounces-242543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 392A1C91E2A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D80ED348D32
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 11:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B50316197;
	Fri, 28 Nov 2025 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="VQbf00I0"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D7314D36
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330830; cv=none; b=Zxok5qK4mUWt9NeYg63gtGhdtcEJYI5lfLjgbTnBClfYB8TB6XFC4qbm5Fvll/766rLzZe+Wvf6KeuaLxRUQdPuXJpW/9OZlvCpUKsu8sdLSkHnbsAEzYvVqTdKTOBVA9TWa7n9gn+WrNGUA93MGYqcQc2er/ahxyclM3teChlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330830; c=relaxed/simple;
	bh=xJPt0+6ekkUnt4iPkIJyylGvfwEgLiZOj5WDFgQfhFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdkfYDz/2HHUDoKqR7cffP/jpnqZkjHKt6etuLhdgcksI9sUjhnFXjEjFb0Igpyvks/bTgH6Ub+uizo5Krxq9I+mBXEvy076AOapsBeqJrqsoB7CJpkuPbefvB6eLlkIRrUh6wOYOy//Bhh8Zq6WKSz3vzM8vT/Vjp0z75kh0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=VQbf00I0; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id AAAE460254;
	Fri, 28 Nov 2025 12:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1764330823;
	bh=N+HUNPbg4D0KEcLpR4O+kOtSPZORTM/JvurAeCieHD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQbf00I0LknFbrhjf+2Kk1mLk6RoAp9VYqphT4SHJk8tYL19u7gmw31pRu4zuIKjN
	 impgdeZrje2+hIAtKVWkra8/oGLodKmk56jnd7XLpQaDQtfyywukxvX8vktajxhwNk
	 lyD+ZQCAFHI6Mz/5Y+h35X/X9UQCTkdxObhE032f52z6Mj/OwUdKtNVQ+mHWn2VpwS
	 srNGcpObeqTi2ARuAjmtbHjNXDMOReBQ9IxoojTwrpB02rspqSntTVp9yZQNVR025p
	 TUL/lGH/F42dVMcpboQWHyjznOt691wafMU+M1YYfAHSM+Eg028knPKK9QkFOqJ3Np
	 WrJZOoTlaw9Og==
Date: Fri, 28 Nov 2025 11:53:40 +0000
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
Message-ID: <aSmNRDG8RAHVoC7C@chamomile>
References: <20251126140705.1944278-1-hca@linux.ibm.com>
 <20251127181127.5f89447b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127181127.5f89447b@kernel.org>

Hi Jakub,

On Thu, Nov 27, 2025 at 06:11:27PM -0800, Jakub Kicinski wrote:
> On Wed, 26 Nov 2025 15:07:05 +0100 Heiko Carstens wrote:
> >  net/iucv/af_iucv.c                      | 3 +--
> >  net/iucv/iucv.c                         | 3 +--
> >  net/netfilter/ipvs/ip_vs_app.c          | 3 +--
> >  net/netfilter/ipvs/ip_vs_conn.c         | 3 +--
> 
> Jozsef, Pablo, should we ask the author to split this up or just apply as is?

Patch looks trivial, and not so large for a tree wide.

But I'm Cc'ing Julian Anastasov so he has a chance to ack the IPVS bits.

