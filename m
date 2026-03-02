Return-Path: <netdev+bounces-262665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMEtItGapWnxEgYAu9opvQ
	(envelope-from <netdev+bounces-262665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:12:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7CA1DA730
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EC16301168A
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF013FD12F;
	Mon,  2 Mar 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P7Js+9Em"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9113FB06D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460295; cv=none; b=OLR2BODooNO4N9uZWnU/ylsriaHFZNl3BnIYWxmduoVi8RuxCmRY1HK209IV033u2FmSxjm0dOKWO6ISEYA6s8KZk9+6GDUhKpHBBpa7VKuO5gqYA33tr+eQ5ycpAtru8aBQlp6w9qH/Lg56j1E4bc0/bvROEuXJiYrlcwfoMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460295; c=relaxed/simple;
	bh=8WaYxskhhRsHKhY63Ip0eu1QWZBza4VWUtV0RctbcDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcEXRgYzlS3alfdRm/LKUdJKJxwClGjGxpyK636Qj7JxwQ+kHyTgQB4QyHUqf+BXYd/nmqKdMoAo2xlB/zfzvXX21gBogJOK+b4mcyroQv3E/jYYFdyeqUFSSFfN2dTLRw5b9IgD90mJOM+KMtsfxBc3PDuVFoMlDr4ajVF4BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P7Js+9Em; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a018cbbf8so6857676d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772460293; x=1773065093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLrcIKGueBjnIWT3IFgt22YqquPVYuia+ThnGOOIiM8=;
        b=P7Js+9Em6FdZ7jMAbNY6UgXifGkMEsRdje45fjq6M6qjRgwlFy7h1D5ClhRc+BD6nz
         lD99gFKTzWa48hXLpWlE0g03bEf6B5Aa+GfkdNTfhAkv5zxTFwg63AvrFtsS61jds5hO
         0+lu/UHeHJBv3EYZKlx44Pu0m02zi8gbgABoMUwLtNHa94aiP3fpk/RvnN9KgZ4Zfylm
         NZ2g0MS85sk/l1eHakle94yAYN/hvgzduphRYmtMJnBJenCSuddH79ZCzfn/CdjANtxo
         /hhsa4WynJhYSEDJJHqtzrxRhknujk+XVj+FKHHd8VCqpKXG0M7SmB1uawZ03jJKc2IG
         P50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460293; x=1773065093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLrcIKGueBjnIWT3IFgt22YqquPVYuia+ThnGOOIiM8=;
        b=lBeP5HM7gV5He+qzB4eKxrf/QAXPNogWybUWv8bpW09ruZ7XA3Z1OA1Ud19NJNPSv7
         yiYfiVe7QAqztUvTT8xEgPCg0q8BPGCrx9UIDyIWqUdsUdhU2gtoMPdfjISRn4jXDqhr
         Uqk65GUrsyZPWZhdSTqkHQ5E0BIy3JuNthMHQgPM8oLz+Fbxs+HLSZlde3BYbI6d0UbR
         5DVRJ2LnY/bT1plP5RZxDZ2NhOUkIfD7mJgbSYQWMviifWlThUFHfqcX9FV3NcJonVw2
         /tUIU/eWB4F/5vN+aSieMYD+dzFFlEGxYRPkEJaut1YTD7fhr7MWuK4cvYsbTgkvODAZ
         OfZg==
X-Forwarded-Encrypted: i=1; AJvYcCWf73hNnq8I/4AnRAdoDthubd5Gi3l0ShmpoidgwKvx2CHPhkyW0nG1sQdJtmlKobb8LG6hsAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IZn49YoFWqj53Gb6XaZfNV5fSQQdkYjzhGS4DdlHRhG3Kg8J
	+h3LAhHmu9u4VwncFwMaS9UJZDDNwA4znoJAA3EHp50pSxuXcsc1ZmIsH13DShaM/rg=
X-Gm-Gg: ATEYQzylEN0RlJ5fM1iLvgXabEC13/oR5bRJ22bGLCI04gLjMpIF83VO2rzuEfnYvfz
	vwdpN+EJYrd22IyD+CuqR/eGSaR7blw85mp+R4R80DsYGE2yrBQ66I4/oMND+T047UnqFf5ZUvb
	L0gwvMx2ylDyGGyvHmV4M42aihWybPsdMrFsAlJ2iCINDdw/4xOeUqZjzA3AaPvB9PA7j0sCUUx
	z9ZzhsC7bhf5SCV3dHmvmkTt9gvopF/buf9wohTtWuaisxZyEpd8nS7Yo8xb5EWPIAEe+SksWTR
	xFYkil0YWGDdjJ9qnthwwI8MOmtLaI/qasWNR7l/+c50p/3BT3AOt5F0Nkv4886TAEB9BI9QE5W
	QdRM/UxGW3o6vsebdj2cHhJdRuicu/uLfsfueeqfPxOrArIK4+/gtXmO6yrEO34LC8mnBuw/ppA
	EAZ2VMcuclKx591h6L3tadLgSYW152XvC6kg48jUMpQJhFJKVEFXI5bnmk0d6zGa1lhXBk9gVSN
	z+3/6nP
X-Received: by 2002:a05:6214:40c:b0:896:f4db:82c0 with SMTP id 6a1803df08f44-899c6766020mr242485226d6.1.1772460293275;
        Mon, 02 Mar 2026 06:04:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a017add76sm10957346d6.36.2026.03.02.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:04:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vx3tE-00000003fZH-0C57;
	Mon, 02 Mar 2026 10:04:52 -0400
Date: Mon, 2 Mar 2026 10:04:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] Add support for TLP emulation
Message-ID: <20260302140452.GW44359@ziepe.ca>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
 <aaIOgcfCbRIBlpUO@kbusch-mbp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaIOgcfCbRIBlpUO@kbusch-mbp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D7CA1DA730
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:37:05PM -0700, Keith Busch wrote:
> On Wed, Feb 25, 2026 at 04:19:30PM +0200, Leon Romanovsky wrote:
> > This series adds support for Transaction Layer Packet (TLP) emulation
> > response gateway regions, enabling userspace device emulation software
> > to write TLP responses directly to lower layers without kernel driver
> > involvement.
> > 
> > Currently, the mlx5 driver exposes VirtIO emulation access regions via
> > the MLX5_IB_METHOD_VAR_OBJ_ALLOC ioctl. This series extends that
> > ioctl to also support allocating TLP response gateway channels for
> > PCI device emulation use cases.
> 
> Sorry if this is obvious to people in the know, but could you possibly
> give a quick high level description of the use case behind this feature?
> I'm just curious what emulation needs are enabled by having access to
> this packet level. Thanks!

These days the DPU world supports what I think of as "software defined
PCI functions". Meaning when the DPU receives a PCIe TLP on its PCI
interface it may invoke software generate a response packet for that
TLP.

At least the Mellanox DPU can route the TLPs to software in many
different places: various on-device processors, or on the ARM cores
running Linux..

So, for example, using this basic capability you can write some
software to have the DPU create a PCI function that conforms to the
virtio-net specification. Or NVMe. Or whatever else you dream up.

The peculiar thing is that this is all tightly coupled to RDMA. Eg if
you want your TLP to trigger a DMA from the PCI function then RDMA QPs
and MRs have to be used to execute the DMA.

Jason

