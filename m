Return-Path: <netdev+bounces-214912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E80DB2BC3E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B3E175D0B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32C31195F;
	Tue, 19 Aug 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="BUMIAagK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8621DC9B1
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593510; cv=none; b=CeyKrSk88yriyuMm+XPMZSkWBoUylLeZ5KE3Mhfv/H4wsYbakeMK7DbTpXvzgT6xA7FBNOPrT2L1zx7hwACtWn6UaGmsw/TDtIXt7s/Be7yLEUTXF/EtAY+pGIi/ab/99asWzBU5yXfVQb/NJsBlSiz+oJtiLEQpKg4oh1KPHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593510; c=relaxed/simple;
	bh=jgcAdVqxyFY4tD8DGpZ73j1dA0dSsUrPS79OJAYl0NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MobuUCzqgBmxyfaQP7W7OyPshARfXLNsopnm2GuqUideUAetZjW2v2YP9Z8y++T2aQ0eZ4u597r5wO2PjNhe3u2IIOcqZbYLL0QKjU7FYXzoF2tbYLfjpllwPu1clsNGa/M0ZZxSLnl6X4PebKjhOk4iJL1tdUrCMpXOanbK2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=BUMIAagK; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1755593500; bh=jgcAdVqxyFY4tD8DGpZ73j1dA0dSsUrPS79OJAYl0NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BUMIAagKBvzWPsGJjIyM4bF6MsPKG8CuWrTP3PR/VzeuxXMCacozumt0jFWQ9kvu0
	 iILiri72jmnCaISAYIM6NK9ID0yjfsroRs/dJu57L1t+PEEsL6dm+4PTerw+1lLHJy
	 HzwsxTExfT1Jq174m0ZNg6heNhXnXAZvMYOR2xcMJRVgRfYISTvuKlsljTQRGJWnFd
	 jins3iFTYF/MUD9DTZqO/C/CfGLEgwaZehXlnvNvlyFgFpasn7cE4kFjkBGTAcivUX
	 R6yaTXq3YfPwtDnCuv3Vd98JDcbRZPVzefuNdY3zZAgR6/v6rrzH8ZDVUtkGZ3GGfV
	 E0ZTg6UmeKCzA==
To: William Liu <will@willsroot.io>, netdev@vger.kernel.org
Cc: dave.taht@gmail.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, cake@lists.bufferbloat.net, William Liu
 <will@willsroot.io>
Subject: Re: [PATCH net v2 1/2] net/sched: Make cake_enqueue return
 NET_XMIT_CN when past buffer_limit
In-Reply-To: <20250819033601.579821-1-will@willsroot.io>
References: <20250819033601.579821-1-will@willsroot.io>
Date: Tue, 19 Aug 2025 10:51:33 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871pp7k82y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

William Liu <will@willsroot.io> writes:

> The following setup can trigger a WARNING in htb_activate due to
> the condition: !cl->leaf.q->q.qlen
>
> tc qdisc del dev lo root
> tc qdisc add dev lo root handle 1: htb default 1
> tc class add dev lo parent 1: classid 1:1 \
>        htb rate 64bit
> tc qdisc add dev lo parent 1:1 handle f: \
>        cake memlimit 1b
> ping -I lo -f -c1 -s64 -W0.001 127.0.0.1
>
> This is because the low memlimit leads to a low buffer_limit, which
> causes packet dropping. However, cake_enqueue still returns
> NET_XMIT_SUCCESS, causing htb_enqueue to call htb_activate with an
> empty child qdisc. We should return NET_XMIT_CN when packets are
> dropped from the same tin and flow.
>
> I do not believe return value of NET_XMIT_CN is necessary for packet
> drops in the case of ack filtering, as that is meant to optimize
> performance, not to signal congestion.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: William Liu <will@willsroot.io>
> Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


