Return-Path: <netdev+bounces-294166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HHwNEnzBHmrjUgAAu9opvQ
	(envelope-from <netdev+bounces-294166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:41:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D1B62DA15
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xe7GW+lL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294166-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83549304398C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E803D9DBC;
	Tue,  2 Jun 2026 11:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9E3D6472
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:33:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400015; cv=none; b=piKDxTPYiWCTZE6UJ6mkJfvc0NwN6ZOi50lwT5rOf8de++20OhmJnkgXJWiOiUhaW5VSLs0UE8cX636oO+oJODcHxjQLwdQzndWr22+DrCaQViB9QDz0mYN4r02x7a1ju++QoTvsaYPRLrxszU0ecoMxeHB9sHksdG9vsBagmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400015; c=relaxed/simple;
	bh=yQeqOaHJaGWk+YRW2xodbahmHNhgxlo0/w3jGZICsWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgSaM9kVhS1y0IiTE7ek8eM+e4gzT/wlYc/fK7is5PHFL/CxU/r27HyFFBrpO4ha7Q0pGR1JrRxIeTfWkNVs5PGPRD8bDpyBob4SACRI9TAzIqt+FemdCOsamLnbeWL+MurVuipAXLM7D/t4gbLJ7VbS2HgNmhoJXnFX8TuIwYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe7GW+lL; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490af320e2aso13202855e9.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400010; x=1781004810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02j8GeA8u5NvaXQGdjmKGOU30h5jH73JVyZTDUDQ5Iw=;
        b=Xe7GW+lL4l4JH4dOQTYarpxyPI2A8j0wiXwBrNJ8eMXlNDmChKoIIS6LknUAQOkJdp
         C+RSzvHugdNWcYuyfO8mmzcq041iPHY6HJe8sNN28sPTGkj9CJspmXrWISVheuawhCEY
         vdD7weBbD0OQsWT+3+ISxNu9IJiDq1hKzIA/N6fgH9z9VF80CkhKGDxrFdDrWL3bJFjf
         GRPSCnPVQ44Rj7g5t051EvDol8wGhvtWnREEfbKzOYxZmKlys2uQ/3Hoh2t5KCKiK0dL
         KhDRwJ/n9HxkZ5ViUonh6o734Kc3UvxMQ/Md7Ua2ocZ4pfZTfO7BGVIY0Vu4pWrzFw//
         UvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400010; x=1781004810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02j8GeA8u5NvaXQGdjmKGOU30h5jH73JVyZTDUDQ5Iw=;
        b=okJM5lMdzX+Fb9SnpaaBwLSsqRvTTTrA09uTS9QpfzJoVyuFsrvHjZh0TZ4wZVIATk
         a9PrLLROM2SBnLTGGM5fEkS2iwpI5OCh18suwyQSqwz9ubR0blr//B5P6nkxvKQp79yH
         3vE6KuZAaEOsc+FN8EjIxb7LedA4aOQsbHYxWVFHXlYV3Kvx5Jf9lM3cnfuhgn2+tRRJ
         z3Q/qteu0Fk9rlrr/MtwluULqhI52mGD9wg8PKPGErUimHIn07vU1orcGqlhWMiwpRK7
         oZmfKW61X0mHTocrCA0aPYpGJfWIrvDw5XKVBiCGJNfUA1DY5gQ7nIQnlBrOGtMOoIgv
         iOzw==
X-Forwarded-Encrypted: i=1; AFNElJ9c4Y8yZWlP8v19VgFwJ7v5ekdCguexJM349kip7yrJNMtIwxKyaU+KxoJVgH+CPFvTHkgCHg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv50ZAqZN5gbxt1lmV7SzgKKqdc/+xNpyrVUss1dUiYiRrlpmI
	zafqUnSzUpsvJ1SDwGJ7EqDhf/lJaakUQG2DD/4hfxfavtnBWE3ctHgm
X-Gm-Gg: Acq92OEOmUufgCm5ymD1+vg4YBkZWldpLwEAc9VOGag1bbTYwTyCbO5zoUutMVSzGoQ
	LYBQTQUpvkLB6f1GPfKikelD2A76ji93Lit8kLA99J69fRk5lBeLk5F4TnwwH6+Ir8ZaI/OOtju
	XTEg+CZyHXrQhgF2rRlakn2V3C1bIRfzheKNJjI62SLFnxDXICiWhmajtdLWGbmRtDz3B51fail
	RxTwkEAfAjK8XWADHVdLtEEIaeCrpVQ3SrqO6K+8IjxQUXqh7cn7gRa9Sm5586UHSK2SfeNKq2s
	toRbnxaIavqd7r8NGQy/aQ/Tar5la+Gv522P46xtGIjLiWqrWtfaLqMJjg4RmQaIft92h0quQ/M
	qWScJwuJ+xOWj+dC6Zi+7QFUNBaIje6kX3eLaJ2hEnV65MoG+AXdydGaD/0PA6qxNbFj6susjnX
	4DJ2QKEjrQdnQroqTbDmEcZUA1zaFtp1u4VgrfX8L42Otq/q4hJanRrOYmnyh2yc0ax82dAB4=
X-Received: by 2002:a05:600c:2d47:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490a2961e9dmr177750195e9.30.1780400009734;
        Tue, 02 Jun 2026 04:33:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b5bdsm31629370f8f.21.2026.06.02.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:33:29 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:33:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, zyjzyj2000@gmail.com, sagi@grimberg.me,
 mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, andriy.shevchenko@linux.intel.com,
 ebadger@purestorage.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260602123327.35aa286a@pumpkin>
In-Reply-To: <20260601092534.1764560-1-ernis@linux.microsoft.com>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andriy.shevchenko@linux.intel.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.or
 acle.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pumpkin:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6D1B62DA15

On Mon,  1 Jun 2026 02:25:15 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
...
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 6482ad859bd1..852213365ecd 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1731,7 +1731,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
>  		 * All receive and all send (each requiring invalidate)
>  		 * + 2 for drain and heartbeat
>  		 */
> -		max_send_wr = min_t(int, wr_limit,
> +		max_send_wr = min_t(u32, wr_limit,
>  				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);

That should compile as min().
(The constant is known to be non-negative.)

...
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index e6e2c3f9afdf..fd6923198ec1 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
...
> @@ -1553,8 +1554,8 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
>  
>  	param.rnr_retry_count = 7;
>  	param.flow_control = 1;
> -	param.initiator_depth = min_t(u8, p->initiator_depth,
> -		queue->dev->device->attrs.max_qp_init_rd_atom);
> +	param.initiator_depth = (u8)min_t(u32, p->initiator_depth,
> +		min_t(u32, U8_MAX, queue->dev->device->attrs.max_qp_init_rd_atom));

I think you've change one of those to min_3().
Nesting min() is a good way to bloat the pre-processor output.
You don't need any of the casts.
	
	param.initiator_depth = min_3(p->initiator_depth,
		queue->dev->device->attrs.max_qp_init_rd_atom, U8_MAX);
should be fine - if a bit long.

There are also (u32)U8_MAX casts lurking - pointless.

-- David


