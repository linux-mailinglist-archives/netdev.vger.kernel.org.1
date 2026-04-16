Return-Path: <netdev+bounces-279001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBxSH3+/4GnQlQAAu9opvQ
	(envelope-from <netdev+bounces-279001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:52:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2F40D0E7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEA26309D1D1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA553A6B88;
	Thu, 16 Apr 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXTiiG+l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJCV6YH8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EA3A6B63
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336726; cv=none; b=B1f1gJ3lcYiIgCqVLfgXj/bvA/ccZ9XdOS7MwSciBzey509I4lw7KMhC0Is0yoTCrK4Eu+VX8KeWJBYuyK5GM1wjJjp2nn+cnZ6dVg4o7r7o0GqgxUX4NaVZlDyZt065fFEiQW0wJ1yl4n8boMggwCzIcVdc8s/q0ODbW8tlFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336726; c=relaxed/simple;
	bh=EixB+VBYELB9QZou2WcR2YRGdtQyBm7qn3tnBBWJdDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olbq4wNo29Ay1CkPIK5hz7r5XGIFThwo2Rp+V/7NkBtmse9INMdYEfKf5AV35YaD0hv3VrDneopoUV8rtQ4oswFtXKYFZrEqUHwEoP0thOZys2/NM9lKUQQvw1G/5ONpCPTQCJuH1sPQKDgpB5hO30W/T7IO23WL5z0B/ZhNZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXTiiG+l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJCV6YH8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776336724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
	b=OXTiiG+l99NyvBV50lHidVRCDyDsMQa0AFkSgkbJVMHcqgkOjxM2Jc7IdHJn0ibT7XYl6g
	t1z0UD1IOyrQKZfSOgoWYSX//aG5awgliIxBLeo4s11Yj3STvAYe0CPRBcWO93o7nemQCi
	6RnGD0/7WfebMvRuG9fVDwMz6vvuYvU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-WA9iABgDP8uttgF51jgxag-1; Thu, 16 Apr 2026 06:52:00 -0400
X-MC-Unique: WA9iABgDP8uttgF51jgxag-1
X-Mimecast-MFC-AGG-ID: WA9iABgDP8uttgF51jgxag_1776336720
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso5758349f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776336719; x=1776941519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
        b=YJCV6YH8KDAOF/LgNXM5zZEOM2M7B/vyyNQMVv/YYHuZkXmk+uj+mT28cljJ2xz3Te
         I9zJZ6dKdbfNRkZgHxy8UBHsHlJAjseoz+t+BfoIdTnLfhlNeX/nEplu4hzyt9eXueiR
         K5+u7qpLKzxJ1LglBxA4qnDSqIJ99z/jjQBGv5Eek9Ns+WUPwhV5WJ2Pgd1mWjSSzdG6
         UElY11WIU2bm+og2DeWSWzgboOevGZsjaZLoQpRhcA/1lNglJQMpLul/KxsYeMJ2YQN5
         VlqoP4UI9++fVVrn3WhsAR7l5lTufOC5t1wT9kFg6QlnLcj6CIIYRiomgrZqMCxcABSD
         969A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776336719; x=1776941519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
        b=N3z991HspLME2e7WOMjGDsROjNEi5fA08Uta9JNp+qyjV61ZA55NlZ43o25xPUWKLm
         arm/jOlKyYLTpFFh9/M4PQGRsocyaHHa6KykxjN9uWFYEiPVNzyxvPPxXDFjF+Fujw4f
         I7UXsa96EPjqk+a5ZXc4enpU0FeiFsCqNJQZk3b+dY3EQkV9eKB3XH/rJa6EQuS+nfvr
         c4Z289EN46X6fo800uSb/hYlwdRSmF46xpZI1jZIiFKB/ilbTU+aGLYqUc5t3SE+wxhT
         o/rI9u038hkEGZ27TCjzfKmUfiaSMCBYCWFy+Ir9x9THOdVvh32FXemGxAKcTXkq/4Fh
         FF+w==
X-Forwarded-Encrypted: i=1; AFNElJ8Sw5RYZezoehRF/aUJipBiB/9hBc1Sz+zx79caetV7kx3BQ9zPcSS4Q/vBFvOE7fZ5TWUR1fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpATcoshTmQhkRxzaBaxMrLav2bsNp0PqeoLsEb+9D1g/bRX6
	zhBgP9vMk6vBjm3FkaJ1f6iCqFEu+PgDWla5U0FTnfNOZyLmKf+JKY6yt5lLA5B6TFhT6Z9dOiJ
	bP/O04Jv9pFIQay82ByZpY/ksGz11hkZ6JsgRJcVI2C9+4J4WnA/Kcn+NsA==
X-Gm-Gg: AeBDiesPuKm+nddfhYX+TFaNqNk8vN2ktHhF9QcwtUBPVauIc01Khj+plKwQSFFtMfr
	z2CB3crYwtTwT+A7VK1WEqQDOYOzZ2AgJpAcVa7zBPt0Go1Mf6FPE2uMAXuJ5gj1RcLJBt4/SWd
	Bzk6lOWyXrV2gQW1MOMf+Bn/NPcE3qxL2gDDbuGN/AoW4UbhNDGtXb8mhVRbZe403JrHgZYjrcR
	8qn0wZxaf//NeeV5wmkOnEyZheznuv/0Yt7as04r2MY1GcUjW1q2w3JS+oWjGIK58NkBe0E/ZUW
	HJWtv+UFFt+3mmp7kTi9/Z2U5pid0vbBmxcO+RDHm1u3NNiXlXa+KP6fIHKk3/Q+XxPLHV4ghw2
	41aKmNJLJTVT+5WAhNHDkqe0ZRATgmUlR9FiyljdzFOo=
X-Received: by 2002:a05:600c:c08b:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488d68867a0mr252350585e9.22.1776336719543;
        Thu, 16 Apr 2026 03:51:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c08b:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488d68867a0mr252350285e9.22.1776336718976;
        Thu, 16 Apr 2026 03:51:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818d70sm73936565e9.4.2026.04.16.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 03:51:58 -0700 (PDT)
Date: Thu, 16 Apr 2026 06:51:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260416065132-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
 <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de>
 <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
 <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
 <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
 <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
 <b9d84d88-46d5-4fd3-a5b2-d914f54766f6@tu-dortmund.de>
 <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279001-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5E2F40D0E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:54:45AM +0200, Simon Schippers wrote:
> To summarize the discussion from my POV:
> 
> Open point: __ptr_ring_zero_tail() is only called after
>             consuming ring.batch elements.
> 1) Consumer wakes up the producer but the slot is not cleaned.
> --> I disagree, the consumer only wakes after consuming ring.size/2.
>     Then __ptr_ring_zero_tail() was called at least once.
> 2) Producer is woken up but see the ring is full, so it need to
>    drop the packet.
> --> I disagree, because then NETDEV_TX_BUSY is returned. This is
>     noticeable as qdisc requeue and only happens very rarely.
> 
> Points I will address:
> - Minor nit on patch 2 by MST.
> - Rebase patch 3 because of commit d748047
>   ("ptr_ring: disable KCSAN warnings").
> - Document the pair of the smp_mb__after_atomic() in tun_net_xmit
>   with tun_ring_consume().
> - Use 1 ptr_ring spinlock instead of 2 (currently used for consume
>   and empty check), not sure how to implement it pretty rn.
> - Run pktgen benchmarks with pg_set SHARED.

Thanks! The plan makes sense to me.

-- 
MST


