Return-Path: <netdev+bounces-114115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A271940FF1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E71B23354
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3E18A929;
	Tue, 30 Jul 2024 10:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195440BF2;
	Tue, 30 Jul 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336634; cv=none; b=Bwb0nQ58aH2n8kQ86Jyl5hufLOv8wUgMDaNENF3iQfxL/fK/cjMtukMCi5CTOO0HB5sDwFciRRN0gPAOGEv+4VqNR9l18djTnl0onKMprnu+E8uJFYdmrXe1cEIE/b0XREd5XFOi1Ua+YLA0YLCFuTrQfCUnbVmZe/urYMmHPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336634; c=relaxed/simple;
	bh=if265VCvG249S0C037ga2+9rWuA+o6BXYnogxToqFSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSBiiOpRbiSYBIy/hJf22qZOYs2bkDo7zfFQZfzxYp7dSEIqNRbFcHPPFigUpt3MHRWk/mr7WAMDBONKKC8bU6bWl4ENZwrqNpLSiML9CvRcA7qNc13Si91gFCFZmIQ9aF7Ggtc2+ES35s1e+9UTW4qK1pFvxWsHs5IeouqEfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sYkQm-0000XD-8A; Tue, 30 Jul 2024 12:50:12 +0200
Date: Tue, 30 Jul 2024 12:50:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, leit@meta.com,
	Chris Mason <clm@fb.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref
 when debugging
Message-ID: <20240730105012.GA1809@breakpoint.cc>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> >   	else if (likely(!refcount_dec_and_test(&skb->users)))
> >   		return false;
> 
> I think one assumption behind CONFIG_DEBUG_NET is that enabling such config
> should not have any measurable impact on performances.

If thats the case why does it exist at all?

I was under impression that entire reason for CONFIG_DEBUG_NET was
to enable more checks for fuzzers and the like, i.e. NOT for production
kernels.

