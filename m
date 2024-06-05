Return-Path: <netdev+bounces-100891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D28FC793
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE761C23024
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741318FDCF;
	Wed,  5 Jun 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A72h750k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYQ7G8Md"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944419006D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579269; cv=none; b=cJbmriU6Hxniop/MGIWxAs1CLe0nC3cHHyKzO5gN2Vrnrv3utBnWXO7LmFTxjjIL9rw+ld9C5dk09rEryxu1dYq8YCrXw3qq64Zs5Jgu3qHjFdmLcQalckJ8qw1Uq+vU14ErBaGDgrhlcFDg9LOhrMa2qTxkKWErS2UiFjyqqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579269; c=relaxed/simple;
	bh=fQAWaG8IjYwFoNJ/5ZQ8Lrp5eSNJNKrarceh1eOSO4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpxpegIrAeofXeJHGrOIJ972gANrVfONL+0UHO0Fl68eRay92wZv16si+hQUBt39NU9VINJvPrjfmO92DuMtlb8Kt/GKroMaAqXjIEU23RvXDiKguTN2oU7HdciBt4boGZWY7dpBNYdFT3IRikQNcBbFXBCBQXPQV9u+bQfYdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A72h750k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYQ7G8Md; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Jun 2024 11:21:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717579265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxkoxRwLXgAKWp+FF/vf5zwvc9f2L3v10RH0DhQzJvk=;
	b=A72h750kFYzKhpI9cljNPltENzhXpSuFbnHpPiMafM2zUU+J4IgJT/k0fBloOokASHfScM
	XnvSrRUxgWDxymQcN/DkmfPlXdamTwJHtLKA8fKIoSWV9qLKkyDWuypxEtAWY/9ixc2Ujg
	e21lKhaDNVLfaMtFBgwq4RT5+LEx1hbtc+tAEs/RGEyi0NgcPpvqJPi2ItTRbqN/KyCyeb
	PmxZAl/Leu644ddt7+9F887oIKaTiUbk1nwhExaBtW//Jyb31D+2y6Ej75LF5DGMHefuBe
	OSiXyshMS49d4FsEsu7tjAtJd7jGp8d86B5WZeObVhvfgoAkasv9dQyKX9AK0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717579265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxkoxRwLXgAKWp+FF/vf5zwvc9f2L3v10RH0DhQzJvk=;
	b=wYQ7G8MdcIwUFR7q3ielcH/uBR4NPSFTsUd0VOnkuHd8xfzj45qJ44NJ6+v4ePHv/YuU09
	KvAHX5VxQVIhSbBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com,
	tglozar@redhat.com
Subject: Re: [PATCH net-next v7 1/3] net: tcp/dccp: prepare for tw_timer
 un-pinning
Message-ID: <20240605092104.CKiGDh9T@linutronix.de>
References: <20240604140903.31939-1-fw@strlen.de>
 <20240604140903.31939-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604140903.31939-2-fw@strlen.de>

On 2024-06-04 16:08:47 [+0200], Florian Westphal wrote:
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
>  					   struct inet_timewait_death_row *dr,
>  					   const int state);
>  
> -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
> -			 struct inet_hashinfo *hashinfo);
> +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> +				  struct sock *sk,
> +				  struct inet_hashinfo *hashinfo,
> +				  int timeo);

Since this is gone now, could please also update the reference to in
tcp_twsk_unique().

Sebastian

