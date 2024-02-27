Return-Path: <netdev+bounces-75201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61778689D3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE61F224C5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1A5466E;
	Tue, 27 Feb 2024 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAgKUzsS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mt3TYD9A"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AD53800
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018839; cv=none; b=MIxXSK5sA/JpSTzGaCtmd5BS5TX9rpDDbdohI7YEiFuIB4cni4tV12XlURXpNrqbUh2KdMqbQC702l8l4YxwnVE8Rcin8hnS3vZ0FWzx2BSwhc5p20KehPj5BtIvvgodhWftFstDsT463Dy7acjQyrbv7K9ItvTsiPeesWMjClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018839; c=relaxed/simple;
	bh=ovDXb7nfi5rQKi/H0ArwmyLPQ7bTNrpfPNw581cCGys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/6cX3hggN4lO2NyEfGzE6fc+tnZeeYItw8v5yeYPz5A3VZWCx9QMEj92WYsCVhUmQPdu/WDZnsgOccbjFgr40kubCJv3kS92Y9RohV8UVENjXkFIzfeo9Ee1YuJP4E9N1GLHoiWIj3yCZbVGPPybhkGwOcOiqxFhbLqFtk5NMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAgKUzsS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mt3TYD9A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 08:27:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709018835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb6XdsVV3WsraE/g6xHhfxoquv/kpEULW77yWdRJ2xw=;
	b=TAgKUzsSmsRsKgcUXHv45VGkuZa8tpukjf/h5VEAXYeKP0J2WcCCTJQalNEm56ynJ5Yf6G
	uVTba05ReoVwKpc5mV2HCrtNW/7zmbHtqs9cMR3mkpQ7zzEZ2wa2MzloBShZTbWoQZge3j
	SyNyH++CHMpsIYc81LmFtbT34q6tZd30CSDDjCNYOi2pQ1ABvRILMbB31Qg4PGXy3GU8MH
	WgrxaZEUBpaFPFZQT2qQ0l9liNL4McEs/pL5/uYdVswEkV3Uk6OZvvIZ53QWvoROJAJM9V
	Sy91UvNWx0m52y25bHgvmTjnq4rEj65nLspX6abhgEXEZ3EgIkivmOLsLri5gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709018835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb6XdsVV3WsraE/g6xHhfxoquv/kpEULW77yWdRJ2xw=;
	b=mt3TYD9AyL5jVpu0V5Vyhs0viOPUS2FoolmEGpCRvN/s8XI+w0ZAgvtOQ4tj66Ixc6+Hux
	C6G/Ry6TnQ2ryIBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 net-next 3/3] net: Use backlog-NAPI to clean up the
 defer_list.
Message-ID: <20240227072714.qeSGBXNj@linutronix.de>
References: <20240221172032.78737-1-bigeasy@linutronix.de>
 <20240221172032.78737-4-bigeasy@linutronix.de>
 <20240223180257.5d828020@kernel.org>
 <20240226115922.3ghr5wuD@linutronix.de>
 <20240226172233.161c6e7e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226172233.161c6e7e@kernel.org>

On 2024-02-26 17:22:33 [-0800], Jakub Kicinski wrote:
> On Mon, 26 Feb 2024 12:59:22 +0100 Sebastian Andrzej Siewior wrote:
> > They protect the list in input_pkt_queue and the NAPI state. It is just
> > in the !RPS case it is always CPU-local and the lock is avoided (while
> > interrupts are still disabled/ enabled).
> > 
> > What about
> > 	input_queue_lock_irq_save()
> > 	input_queue_lock_irq_disable()
> > 	input_queue_lock_irq_restore()
> > 	input_queue_lock_irq_enable()
> 
> SGTM. Maybe I'd risk calling it backlog_lock_* but not sure others
> would agree.

Let me repost it with backlog_lock_* today evening (UTC) unless someone
objects.

Sebastian

