Return-Path: <netdev+bounces-258236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNq2EMlNjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:37:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D5122CDE
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4611300463E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C63570C9;
	Wed, 11 Feb 2026 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQzf1Sop";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hujw+aPI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4D3570BE
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802628; cv=none; b=Df1kZDTa0efp2/YPjoQwICBxdcCQQbQCYBzzHr1SwzyNZy8W2ijcKPEcEennMv2H+N7vetEparWT2RUXXj778pMBulyn7saRJhK5B9YdIp1dA/fE0g4W9M5gqHByBtYgnisYukAewqtQc8RcilwWJM94LoNq1f/X90yt8z6S18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802628; c=relaxed/simple;
	bh=bspBO2FdrrAqZFdWd9MvqX8zHS/3AYlNK2RPVUvzVDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRD8Z1lW079li3HzlnIt1cv/bJCw5J0gJbg4jlk1+2tZvNiPHLDoVMD8uP7B1tg4pJGeInPg9nyKJXZ2wBmpSLSR4NA82rtlt/kjeHhTZtazdjbcloyQ4FnKhVKIY4tQ27GlhweHff/FqLfyLdsLR/1isYOzd2rubmO5CRbGyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQzf1Sop; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hujw+aPI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770802626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBmAJXaSxyay4y/Pt9nQaFQQMgJqtE9oD0z31uD46SE=;
	b=ZQzf1Sop9rgPR/Z6mzwAuXvHKs3m9pnoIu4W7jkE0enKwhc80RgAQ+4Ru/xhouLef4gq/D
	f3ff9KJitC9vb8BXZbLXcvFmFwOC0gLnB3MbqsHVpQOpOWIoT11rCFe1SASYESDH6Q17iL
	p6PlqjsLBiDgFDl0qH26JGIT/l867MU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-w7W3-aSROfi7z7fnWgzreA-1; Wed, 11 Feb 2026 04:37:04 -0500
X-MC-Unique: w7W3-aSROfi7z7fnWgzreA-1
X-Mimecast-MFC-AGG-ID: w7W3-aSROfi7z7fnWgzreA_1770802624
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435aadfaf4eso3598727f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770802623; x=1771407423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBmAJXaSxyay4y/Pt9nQaFQQMgJqtE9oD0z31uD46SE=;
        b=Hujw+aPIpneY16LXyrLRJn6ckLs49FR4uZXNjjJirLrh/eawPpG7ZZkM8wXKM/GV0k
         tm+Bc0jVBF4eisTPesny3PuN1wGdrm04ohFeAXdRMOhQ1XxH/xfuiZWEma1DWeH858cd
         PtmOFQqxCek3P5x5MIqxLt+lBgrYPWeoTittKBEIEupse+YRM2qa7eBFV4C3PhaHzjOv
         kRgRxLiaumdA8JXlUFg1z+QZ746P1OI5K1xJOETOgcnpxZLrCStUvnWkgImvi0MbDfbG
         r4JqmJHxWdG6dtv5KBLI85yIrwmg4cgqLAnKtniHZctQWwt9qFoIPshrmMcxTy1/sif9
         BJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802623; x=1771407423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBmAJXaSxyay4y/Pt9nQaFQQMgJqtE9oD0z31uD46SE=;
        b=NnDNM3DErjtFrJf6vrpdMWxC+ac0mqhUrgeRGmjba2rh+i3+06vvTV+TAt/8+CcZZO
         5vakCeL5tlDIpToGYspMEAwq3bLhsV34Nsnvn7jwJ7Zv93vpHOEbrg9p3UqembtlM7Nk
         D0qCiReDWpgmmJgMhlPhc7d33qZkc1r2krJ5tRSwfZfj9JVwAuD21/ZZF/AR1JPA3e8I
         jNBKcHwyhbPdM911g705fCfLrLmH0J5LI3WsM+xJWolIxC/5HQC45Ghli7kX4U/o+byN
         NlZStjwgDSNtIq3L1la9gBVmqpFl7BWNQ3kdQeNSQE0Q7T+OEtvOEGhUPewgnPTwrsXe
         Jl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX33Uj8l6EOxFer+EKQFg5lGtKXsrOXaYes9c24UAT/V3R/Gvc1pwK2v6A5QbwtCbQP0awQb0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXDxdyVR4mUDHakMrjpef8JZZ0VFM4Isemrx1LX0tCWvdk4Sx
	eh7IaFy2prNDddR2rX1ewMryePfRfrXneaanWZchmHyqrGUAzQIe6AuCTuqnKxMYCKksZqURs6p
	F/se/UnmgG2O85rvEs1MkQA7m59PJURFMfpo0dDF8wUyb+njIvXPEV48hL6NiQNBiEg==
X-Gm-Gg: AZuq6aKJLwYjXlBZDIGw6uro8mVMsfTiYsbYagdzP5BKD5xpwRqvGLIzy6zWJGtW6fR
	gNJEMSG+qNpbV69xqZvWF/kiCXxCbQmmN6SmCB27chTQWV16rVu0mE+0lIifZki2L0j2A+K1OH0
	fuBZc5dbCtBvjE8Hs81opglUWIYS85+oInGAapRdJ1roIH5DLqqWS7ua5F0lW07TU3tBlY4Oba/
	ue7Cgy9gkyvCZqk+/EQH/KGOR8EzAHkDIcXgUlkVd41VOOQqrifBTH0ua/kwsNG+SZZf9WHL9n6
	RiMRqU9Fep/hCxDLqsBbr259xemTpBw2D0kyL4FzOX/I9VtLHCC41BuJMWoggj2NP3SA32XsYm6
	a5IvH1tswKIickx/ulS6L1sdP5hjJVxouddfLoxEYnQRuNQ==
X-Received: by 2002:a05:600c:a43:b0:480:52fe:58f5 with SMTP id 5b1f17b1804b1-4835d54f897mr20485065e9.31.1770802623390;
        Wed, 11 Feb 2026 01:37:03 -0800 (PST)
X-Received: by 2002:a05:600c:a43:b0:480:52fe:58f5 with SMTP id 5b1f17b1804b1-4835d54f897mr20484195e9.31.1770802622456;
        Wed, 11 Feb 2026 01:37:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm102408485e9.14.2026.02.11.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 01:37:01 -0800 (PST)
Date: Wed, 11 Feb 2026 04:36:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260211043542-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260211030643-mutt-send-email-mst@kernel.org>
 <CH3PR18MB637977B15CD77E0884DF56B1A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR18MB637977B15CD77E0884DF56B1A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258236-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5B0D5122CDE
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:33:26AM +0000, Srujana Challa wrote:
> > On Wed, Feb 11, 2026 at 07:44:54AM +0000, Srujana Challa wrote:
> > > > On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> > > > > On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > > > > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN
> > > > > > to align with kernel's standard RSS key length. Add validation
> > > > > > for RSS key size against spec minimum (40 bytes) and driver
> > > > > > maximum. When validation fails, gracefully disable RSS features
> > > > > > and continue initialization rather than failing completely.
> > > > >
> > > > > Hm, FWIW clang says:
> > > > >
> > > > > drivers/net/virtio_net.c:6841:31: warning: result of comparison of
> > > > > constant
> > > > 256 with expression of type 'u8' (aka 'unsigned char') is always
> > > > false [- Wtautological-constant-out-of-range-compare]
> > > > >  6841 |                 } else if (vi->rss_key_size >
> > VIRTIO_NET_RSS_MAX_KEY_SIZE)
> > > > {
> > > > >       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Which is kinda annoying because the value was increased in net-next.
> > > > > If Machael wants this backported then we need to keep the check
> > > > > and follow up in net-next? We could try to cast the u32 away but
> > > > > that feels dirty..
> > > >
> > > >
> > > > I'd say yes. the warning is harmless.
> > > > so
> > > > patch 1 - this code
> > > > patch 2 - replace with BUILD_BUG_ON
> > > >
> > > > but i ask then whether this code was actually tested against net-next.
> > > Yes, tested against net-next (before NETDEV_RSS_KEY_LEN was changed to
> > 256).
> > > BUILD_BUG_ON would always fail as-is on net-next since rss_key_size is u8.
> > 
> > BUILD_BUG_ON(type_max(vi->rss_key_size) >=
> > VIRTIO_NET_RSS_MAX_KEY_SIZE)
> > 
> > why would it fail?
> I was assuming BUILD_BUG_ON was intended to catch the type mismatch 
> (when VIRTIO_NET_RSS_MAX_KEY_SIZE exceeds what u8 can hold). I understand 
> now - thanks for clarifying!

maybe we should just 

#define VIRTIO_NET_RSS_MAX_KEY_SIZE type_max(vi->rss_key_size) + 1


> > 
> > 
> > > Can we cast the comparison to u32 instead?
> > > Thanks!
> > >
> > > >
> > > > --
> > > > MST
> > >
> > 
> > forcing compiler to generate code where we do not need any really seems silly.
> > 
> > --
> > MST
> 


