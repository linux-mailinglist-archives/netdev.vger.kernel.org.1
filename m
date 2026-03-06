Return-Path: <netdev+bounces-264599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB+hMZkgqmn2LgEAu9opvQ
	(envelope-from <netdev+bounces-264599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:32:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97E219D21
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83332300CA06
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FC2C3254;
	Fri,  6 Mar 2026 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lW9bcmfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B440749C
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757141; cv=none; b=diU0rYYos7Oe9AyVUw9UkTs+EV7OribpWrkQAmQX5LbzEKqIUsb0G0mBToa04d+6K7JYytBCX7F6sXyYdF41Tz95aLK++aYyC65utWq4GqLglfdlTOYgoflwNqNfGXbClYv8tt4vFOL99LPH7L8gaTwWWnOqKS+nFCZ996n/0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757141; c=relaxed/simple;
	bh=nmQHG+4AnyrSSsTzc8B4eGsexpvES3uR3ESxYjP8gGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR+Xya+zlhDNzKNl6tcUhvFGNMrMFnxNlJd3vKBZdmGznYzYFwVndDIiB+aoRPxAy6uxH3K9Dkkqhm5470mzrx+J0zyXxC69kiHvjq0bx4YzWC72re8mfOUvBVC0v1XWGf1r7O1IfBZDi3H5l3+99SLzgB0PGzVXLOMREEGy/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lW9bcmfJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5138df1aso841228885a.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772757139; x=1773361939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCNCS1facBK4msNGTEPROi9xyZQiv1TuHRy7zkEiK2Y=;
        b=lW9bcmfJOXRcl1wLtmCzgwKLXB+GRjOQIl2x5BbvMWyQIijxXPUN4kLyDZOoSxNX/V
         Ksx1lrWzGYrUXYtsOsDLHaedA9O5tuL5Oq7bDCmBbA47aMv4EZp7gJ+LpiEeSS/FnAHa
         4SHX0eob9JE57WZ7+wxhAvV84oD5JLkg9tFNr0p6uJkn6xvxPiMOugeD0Hfe1BssdR6g
         Mtb8LWj/qlHrCCjTIfg7Zo5zb4KJgdasWsAM74OrjaQGMle+66hOijYy3N7bf+cMKrn6
         PtM5ESg0RoWtrPXIYOP144yeOS0MWKnv87rARYDnHEVHInt/Vr1ir8miul+Iz5tl41AC
         VmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757139; x=1773361939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCNCS1facBK4msNGTEPROi9xyZQiv1TuHRy7zkEiK2Y=;
        b=r4ePQuRxALvw6lOM0j5Ju1i2JupZbpPDeUn3hZuMts4V6xrOO9CNom+Q72SY9VZ7Om
         s4K61EHvUzoboikv0HOkJMfIGVTO042Wtv9leRbwO19tIsymYKCKRNrph/03Pf1ll1n+
         YLP6MYoW67fsrfMo82XoibMQ1Te4TEU/R28cGuxFY9kmCQAPHw/70aVKC6AHc1IOLNNe
         QOsTaTpLUwy3st5T2Y6C1vkVI1xVm66Ucflhoc2wE81ozsX54gOZ6IcwLl4Joxs/tf2K
         hX7jwoS81CIz3WB5dWCfEwHk8k1GyUeprGrzqfjjP16NJwIj6Ah1JlcmPxUUEQGFtoSX
         L4uw==
X-Forwarded-Encrypted: i=1; AJvYcCVSLwa2K3I01LQxWJdS1pOODcioguA+ku9gjWgDBHPL1ROW4sdEx0zN/F6yMe8KUS5kfpBiQ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMB5mG0VcR4WuV4IPUjDmaD67yMa9u/RC6iv7H2e+Uxd3N93Xh
	prpMTmsho27S10SnZQnH/R1LJshOQIHl1/vN+2j8mbugLJ/sY7xJJsLCo7ChT2BocNw=
X-Gm-Gg: ATEYQzwywvcFpr1WcAMyZNTTngpdsbLfjhiNN3unLJDiQHJdTIEDa7keXIWZiVEkXvd
	e9+T2v/ZdVluXJNv+k+jAplJInJXLq/kPwYCIzydwU2MTVN1E+67rpKkMBti0vs9Ty1tUeoooMB
	gzyDipVaQJzXQBnbT0b+9sbPSipaxZRG3QI8pP5VfRaiq0sgBRMAUV2tcHZ6dn0dzZV3V/h5oU+
	Q3C421ny4mIFYhivAvI6LAuB5b+h7c+ii6452jIRKx7xrDdC1EtN6rhoza8CQkwjbuojn6E2hdy
	Z3ryUNbhDbJJIkCBja8NAJA5iXyrCyXU4GQGpGshFQGIAAS5fPsZjJjOGbtfxRIqLRyCEJaz7hU
	qvyJYIN8t9YPCmZVpRRtBwzzPkh70VTQaMXwJulOYk3jlQpjv8adMDwMekteXDtokH359+7yZm6
	up1W/JsSQ9e+CLs+4vuma5m8zYPYR0W2c29ZSXPsoB2VvHxg8ucQpuffdJxX/JXya+dGxjc4amn
	AJBif3u
X-Received: by 2002:a05:620a:2a15:b0:8c7:1b3c:8e8 with SMTP id af79cd13be357-8cd6d4fb35dmr55157185a.40.1772757139456;
        Thu, 05 Mar 2026 16:32:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66b9d9sm2001104885a.12.2026.03.05.16.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:32:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vyJ74-00000008rF3-01pZ;
	Thu, 05 Mar 2026 20:32:18 -0400
Date: Thu, 5 Mar 2026 20:32:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Anand Khoje <anand.a.khoje@oracle.com>
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <20260306003217.GB1687929@ziepe.ca>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
X-Rspamd-Queue-Id: 6A97E219D21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-264599-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 05:08:52PM +0000, Praveen Kannoju wrote:

>    Regardless of the underlying causes, which may include IRQ loss
>    or EQ re-arming failure, the TX queue becomes stuck, and the
>    timeout handler is only triggered once the queue is declared
>    full. In scenarios where only specialized packets, such as
>    heartbeat packets, are sent through the queue, it takes
>    significantly longer for the queue to fill and be identified as
>    stuck. A proven solution for this issue is polling the EQ
>    immediately after the corresponding IRQ migration, which allows
>    for earlier recovery and prevents the transmission queue from
>    becoming stuck.

I undersand all of this, but for upstreaming we want the root cause,
not bodges like this.

There is no reason to do what this patch does, the IRQ system is not
supposed to loose interrupts on migration, if that is happening on
your systems it is a serious bug that must be root caused.

Jason

