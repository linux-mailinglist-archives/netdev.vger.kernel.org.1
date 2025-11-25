Return-Path: <netdev+bounces-241582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF2C860AF
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEBA84E3738
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40525329399;
	Tue, 25 Nov 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICcfg524";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oz7s6MO8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3332936F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089691; cv=none; b=Ul6smbCzfVQTzn9hhpceny1/+SuzrvvgeHhpinJqgEUTZAfclorqGPLZ3ezLk26TZKr6uuC9srZtlghBnYYDR6+0kkusj/RvgqYozH3tcnrd3isXDE9TG8taGNRI2FbXkpinkp15m1FlB/VQ1W9P59/hXo69Q6JXyqpY6wO+wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089691; c=relaxed/simple;
	bh=M1xVC7gLm/5kXEcyVn8F+hiOuj4fAZSxatNimx4cXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE+gam6YSMGrwED/dQcNivC5J6J8fjCwAfILFCjgiwDM0Uen98Tl3W7CnQW8qAno8V7qSB5OOIIC62AR7pC7NePcl+oASUEQrzUt9nhuIAMlNJWkXi+tfN5Z2gxtlpeuNZcLsXjjr7iAm0vhIZRnMNrv5+wPQUDSgzFDiQQltKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICcfg524; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oz7s6MO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSyjzVF3bRMyEucyth0abh8Rzk8q/nESWV3mm3a9fMs=;
	b=ICcfg524yyWncZ46IOSHVChjwYI3HeeZegxEEnf1aj0wvS26uhPhhTf7QuEdUjkfKny+Bt
	qWX+o4c+Oh5iB/O6+kwYutNmoSeCgJRkIa/p+GEPmcg3Sni/QYjaNOpZHDFLUfvbcJJMmo
	/1GvpdqqIGx6shlUmMvbGw96CdD24YU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-1rVAWoN6Meyh1L4BUnFTFg-1; Tue, 25 Nov 2025 11:54:46 -0500
X-MC-Unique: 1rVAWoN6Meyh1L4BUnFTFg-1
X-Mimecast-MFC-AGG-ID: 1rVAWoN6Meyh1L4BUnFTFg_1764089684
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d110fabso50344245e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764089683; x=1764694483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSyjzVF3bRMyEucyth0abh8Rzk8q/nESWV3mm3a9fMs=;
        b=Oz7s6MO8s4itO6fJyW7LuGeA+YQYLb63NmnVODYfKsSpxbJPrwWcAIyiyC6Nrc0jDq
         hyD24dLZInuSLysOTuSSnRbVOcWH3Ej8UinzdHLOAUzr2XRl0JMoKJEDvJClltBWDJ/5
         dlUEErJThDdC/uNkNn55Tl+URgCHiz/o2x2au9HFFzq+T1Dy6nWluZ22CIqBi/+JkZWg
         KDz0CfJOAmFDNKxePNyfITPTLtf2rfbRNUZW2ISigiWKpTOXWzg+x4P7a3vLRlQdXkA6
         cc6QLRrdKFhJTXn8iETjRQibxktidIGg4Zg2JEOCuXVAis6kPxrRRU61a4AKEAkX+5as
         kKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089683; x=1764694483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSyjzVF3bRMyEucyth0abh8Rzk8q/nESWV3mm3a9fMs=;
        b=oK+0hkG0bW6Jazpnz2c/mjQkxBKA6W8O+7IP53LfC/HJQFJr8xIdTkvaRD9ey5voBc
         pA13xdgYMw3KyITSVzhBUpp3G1hQMZdYVbf5lJzZ8s6OEBRPpqhzqKrR2qvmlFJL/Ue7
         kUEQadXObdTt8MNQ0HJ5mMzuRJ842WpaRxnJpZLzZ+TM3ddyO+xkCGmT0D8DBAOuamFo
         93kC7se4RsGr68oFnGhCPtW1LpTyqOFauQ8wzUYW8OGQhFRxGlyik+KQrk0JEvtt0vV6
         YGbmfqtFNJUNPZQQKC+iWa26bWb+hGNgC3Gr4YmXSrWjIBf76n41050w4jQeBSDkOiXW
         nP1g==
X-Forwarded-Encrypted: i=1; AJvYcCXxvkBSrnd9B3V+5ZQ+YDr9+LoHPHyvUEBWFDFhLRHqh5UPWpfXW4aC3Hlz43Xm+YzRhh/4T34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pSna6MntbGy8T6WgONiSVCRcuyr9hpq9UjgdovqJfpFvjgrn
	xtCw2PY3C26P1x+KIt+dBW3wsklQbUa+idhStN3k6G+3TfSjAkfPv09Fk5kWnkCHfoDvKIaNLQp
	IhrE04sW8Ui1HInrPAgOhkRq5r13KR+T1ExCUZKN65OrO5nSYuzthwd0cIQ==
X-Gm-Gg: ASbGncsBbjBpbVKOjj2DyxroIDeH3QTsaYRghMbFmf7l6bZzf3SyfabraAOoq4US15f
	+p/Us7FRc7fBy9vX85VsGiVHIzloYLlBwvx1CU90Av/w5+kJcuKD0KxhWJnqHl7us60dc3TvQyV
	6OKcqtCPe6lotpxlzCmvD25I8hqWeeTQGNqsXvCj+E15VR8KojOK7H8A8iQwtyuSPBpDTOK/ysH
	lSaK7jse6SdCwVtz7yoSey2hj8ipsM5yS99hE/jyS46NQhWa2Xe5Y/g+McF3t0LN/4BcYwsFDU1
	ox/hNbAux/lJPGqp3fMvkqgg/ctwGJs52BiwEFIfsSu7ubgX7MbYi4T+c51Cs5L/yeS55kXc4GG
	GgoRefIkTfnPPo3o=
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr43823265e9.24.1764089683432;
        Tue, 25 Nov 2025 08:54:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI01s5vSZlwPc1XuZyxkfAjV2ILVY5rmqifLiNvt5a+hPHMgV9ZhgyCmVtX0zbnJSE6jyd/w==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr43822735e9.24.1764089682896;
        Tue, 25 Nov 2025 08:54:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e86b3sm317496245e9.6.2025.11.25.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:54:42 -0800 (PST)
Date: Tue, 25 Nov 2025 11:54:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 3/8] tun/tap: add synchronized ring
 produce/consume with queue management
Message-ID: <20251125100655-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>

On Thu, Nov 20, 2025 at 04:29:08PM +0100, Simon Schippers wrote:
> Implement new ring buffer produce and consume functions for tun and tap
> drivers that provide lockless producer-consumer synchronization and
> netdev queue management to prevent ptr_ring tail drop and permanent
> starvation.
> 
> - tun_ring_produce(): Produces packets to the ptr_ring with proper memory
>   barriers and proactively stops the netdev queue when the ring is about
>   to become full.
> 
> - __tun_ring_consume() / __tap_ring_consume(): Internal consume functions
>   that check if the netdev queue was stopped due to a full ring, and wake
>   it when space becomes available. Uses memory barriers to ensure proper
>   ordering between producer and consumer.
> 
> - tun_ring_consume() / tap_ring_consume(): Wrapper functions that acquire
>   the consumer lock before calling the internal consume functions.
> 
> Key features:
> - Proactive queue stopping using __ptr_ring_full_next() to stop the queue
>   before it becomes completely full.
> - Not stopping the queue when the ptr_ring is full already, because if
>   the consumer empties all entries in the meantime, stopping the queue
>   would cause permanent starvation.

what is permanent starvation? this comment seems to answer this
question:


	/* Do not stop the netdev queue if the ptr_ring is full already.
	 * The consumer could empty out the ptr_ring in the meantime
	 * without noticing the stopped netdev queue, resulting in a
	 * stopped netdev queue and an empty ptr_ring. In this case the
	 * netdev queue would stay stopped forever.
	 */


why having a single entry in
the ring we never use helpful to address this?




In fact, all your patch does to solve it, is check
netif_tx_queue_stopped on every consumed packet.


I already proposed:

static inline int __ptr_ring_peek_producer(struct ptr_ring *r)
{
        if (unlikely(!r->size) || r->queue[r->producer])
                return -ENOSPC;
        return 0;
}

And with that, why isn't avoiding the race as simple as
just rechecking after stopping the queue?

__ptr_ring_produce();
if (__ptr_ring_peek_producer())
	netif_tx_stop_queue
	if (!__ptr_ring_peek_producer())
		netif_tx_wake_queue(txq);







-- 
MST


