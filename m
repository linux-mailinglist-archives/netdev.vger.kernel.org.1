Return-Path: <netdev+bounces-305890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rw3kAWh8TmrUNgIAu9opvQ
	(envelope-from <netdev+bounces-305890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65004728C53
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=c05qyYMt;
	dkim=pass header.d=redhat.com header.s=google header.b="c9Zr6g/4";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305890-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305890-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE57D31E2C3D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A89409286;
	Wed,  8 Jul 2026 16:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396736F8FB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:11:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527067; cv=none; b=bOK+q2MY40FSN+YAa+KaRAonyz9yI1aYOHwVMHWwJi+cQVnqhAGEyNnBLNNBoFx0WQtzdVJObTP3lZ6lMgXI7bAMITFRgORwLkL6Tu2PTL/GH9fJDzyWz6dNsiA18OoU/uPtEOa/1sqfL7wg0wgCVsNiroGFtwLGbZ6L4LyACpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527067; c=relaxed/simple;
	bh=V5ux1nZN04PwAUuGu52W1iz2CbiB1pVFL2Nt7W3m3IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTnLqZZ+Wd4TZmoJZi63ccEAb/7fmIurpKeq5XjLx3dIeXpuDUBnUnFzx8w2nvhNtXyoEcsGNygwsxBYgTOoeiBRy9x+F87bDlOF8PIsRog+TOFhkdQdu8AMPmMFV0L6AmRwDprx+P2IAUSC+I0c86uv+OgNqThoCa/9Zn7/Y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c05qyYMt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9Zr6g/4; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783527065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo2GCqsDo0gKVs+6QoyTlZNbpg5pdmI6w3O4Dfz0CRY=;
	b=c05qyYMt4hmFy/zGuvHscBLYVbcYYgTcspxosMPWmFznJ7O0iCF7M9KwsJS19859/jRZOq
	vdBHQ5KXLDimh7j6WVgmcvP5CVL+FzaQvm7fSCcqarhD92e30xEYU+Q/jhLIYVErDM+vqt
	+ImiQscojBfIQ7sICn4Cj7oHkw8vfhE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-nS8JC_R2P7-1G84VXynytA-1; Wed, 08 Jul 2026 12:11:03 -0400
X-MC-Unique: nS8JC_R2P7-1G84VXynytA-1
X-Mimecast-MFC-AGG-ID: nS8JC_R2P7-1G84VXynytA_1783527062
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475de65009dso870359f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783527062; x=1784131862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vo2GCqsDo0gKVs+6QoyTlZNbpg5pdmI6w3O4Dfz0CRY=;
        b=c9Zr6g/4UBNEzkylVPUrye7+0oJXUDCK9+qFDRhqr9mpYSHVH8XRHfw7WXwcDuhojo
         4DCfx9YyXvdJ+oJKvW6SyQ4izFgdZ18H8Aq8jQAioJbPkBJEt8KQJZFKzTrZpvhIppA0
         ni6fQqVw4u0P+V4oS6xYEDAejoosNaeaSkL4gE41NUUNx84N09aYBiNdVqbGtwwnVB7d
         9AFZMXeN20YZCndhTlMEUfa0to5tJiXD56o61b39+3UuSwORnP6Q03zIpgnMv7BIJfbh
         ZSt9wc5JzRRg3CQFEdj/z5x+XWLx7yY5mWkRtF3ZhEAHsdUS0hbTLaNIgPAbL078iBNB
         H82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527062; x=1784131862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo2GCqsDo0gKVs+6QoyTlZNbpg5pdmI6w3O4Dfz0CRY=;
        b=IB8QzhfQgCrW12dVGO7O/JyqFXqzLpEUA3ZhHohSnf2jdiap5tdtBBBGCk3XqT10nc
         FitsdBSynk2hjHZnCK6Vg+xkXErWar3UvCVJ3W8VOi+SOkx126ZpoaB+gwHQwUlyLdAf
         TvkneLqfCkuAY9f+a39VLA1wCzT9grkGvqm8gj4/TEFFrL0Z6Dfqg66Nd/2/baED9xaE
         /V0YXMQOpa02WcfBhcpIGiSanmMC6E42SsuqmQS32Y2+VaMqK9lxG5wlzHV5j/+Xr6ZK
         iJYjpSp0+37U374LxM+GB7oBMfqQ1uBh2bjGYyDNOlqndAcla8xclDgly6AYwOJeby7H
         9BGg==
X-Forwarded-Encrypted: i=1; AHgh+RovAifv+aYduPhSxgYZTOcv+QX4GfU+Eoq2ZSu6G95S3HhTj8XR8eGVU5F8DSAEHCjXQr5SPVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOLctYC/C4iQL6abD/23z0NrlaHEpGinN0xqg6AQfCy0/pvwm
	JBPf+588xxATuhyeLNdS7i1wPTlWY1fCiIL1+tC9QT1HPB+JpRLP8ejSfWMMsvgi4+btp2q0WEB
	ukENTsZZnKYohNfgqaYybyNw1GARjfysz3IynlJSDNtk+cVGuKXNQkkBfpA==
X-Gm-Gg: AfdE7cnZ6vCxVo+gzQl7ED/TkTQJaYW+qPIZ5TM8ShRimBzziVPP/1EP2o5ABUB7vTW
	VJCYMam3NL8q6p3TbGo1qp+FfAg9bo7C2d1C7ki0QFYhkGHjq7s6alNfxPQSbVVfdF5Kk7R+zTB
	10l2YrhoopJwu+57K/4xh2sZQsN6XBYX+uJVN9mue/GvaZoVjWdH5vJoAFTjWmCu0KfD1ykxi9z
	6tXQJHNTTVcPifmtzChn1iQnHQTG9X0wHxuRov/fgUs74fQ8ABRzec/uXK5tKorvybNz3C8GOo5
	bagLheNBD3JYpUYvSwJBY4624xdn2STM4VU7ehUS7Bv05yyOaVty0ER8GTZrgIXIr1+KdmNL8Ov
	RJHXEMbhsgfwhXI7XmTCh9Njtl5N6Jc3r
X-Received: by 2002:a5d:5e8c:0:b0:46d:8169:bb39 with SMTP id ffacd0b85a97d-47df075c5eemr3831555f8f.37.1783527062163;
        Wed, 08 Jul 2026 09:11:02 -0700 (PDT)
X-Received: by 2002:a5d:5e8c:0:b0:46d:8169:bb39 with SMTP id ffacd0b85a97d-47df075c5eemr3831505f8f.37.1783527061636;
        Wed, 08 Jul 2026 09:11:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44511080f8f.15.2026.07.08.09.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:11:00 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:10:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260708120925-mutt-send-email-mst@kernel.org>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
 <akvhhy_JpH64KrcL@karahi.librecast.net>
 <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
 <ak1cIAwQzKS35x0m@karahi.librecast.net>
 <c743935b-7b6f-49f4-b1dd-3fe1cc528464@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c743935b-7b6f-49f4-b1dd-3fe1cc528464@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305890-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:bacs@librecast.net,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[librecast.net,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65004728C53

On Wed, Jul 08, 2026 at 05:12:19PM +0200, Simon Schippers wrote:
> On 7/7/26 22:05, Brett A C Sheffield wrote:
> > On 2026-07-07 08:52, Simon Schippers wrote:
> >> Brett, can you try the two attached patches here with iperf3?
> >> I think testing with 8 and 16 threads is enough, so where there is a
> >> regression.
> >>
> >> The two patches are about time when to wake:
> >> Currently we wake after consuming half the internal ring buffer.
> >> One of the attached patches wakes after 2 cachelines (128 of 1000
> >> packets) and the other one just wakes once the ring buffer is empty.
> >>
> >> This would really help :)
> > 
> > Sure...
> > 
> > 
> 
> The reverted results for reference:
> 7.2.0-rc1 reverted:
> 
> threads 1
> [  5]   0.00-10.00  sec  15.3 GBytes  13.1 Gbits/sec  368            sender
> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> 
> threads 2
> [SUM]   0.00-10.00  sec  15.9 GBytes  13.7 Gbits/sec  1567             sender
> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> 
> threads 4
> [SUM]   0.00-10.00  sec  16.5 GBytes  14.1 Gbits/sec  6701             sender
> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
> 
> threads 8
> [SUM]   0.00-10.00  sec  16.2 GBytes  14.0 Gbits/sec  19319             sender
> [SUM]   0.00-10.00  sec  15.7 GBytes  13.5 Gbits/sec                  receiver
> 
> threads 16
> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec  43593             sender
> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec                  receiver
> 
> 
> > 7.2.0-rc2 (unpatched)
> > 
> > threads 1
> > [  5]   0.00-10.00  sec  20.4 GBytes  17.5 Gbits/sec    0            sender
> > [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> > 
> > threads 2
> > [SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
> > [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> > 
> > threads 8
> > [SUM]   0.00-10.00  sec  11.5 GBytes  9.85 Gbits/sec    0             sender
> > [SUM]   0.00-10.01  sec  11.4 GBytes  9.83 Gbits/sec                  receiver
> > 
> > threads 16
> > [SUM]   0.00-10.00  sec  11.6 GBytes  9.95 Gbits/sec    0             sender
> > [SUM]   0.00-10.01  sec  11.5 GBytes  9.91 Gbits/sec                  receiver
> > 
> > 
> > 7.2.0-rc2 with 0001-tun-set-waking-threshold-to-ptr_ring_empty.patch
> > 
> > threads 1
> > [  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec    0            sender
> > [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> > 
> > threads 2
> > [SUM]   0.00-10.00  sec  11.1 GBytes  9.50 Gbits/sec    0             sender
> > [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> > 
> > threads 8
> > [SUM]   0.00-10.00  sec  10.8 GBytes  9.25 Gbits/sec    0             sender
> > [SUM]   0.00-10.01  sec  10.7 GBytes  9.23 Gbits/sec                  receiver
> > 
> > threads 16
> > [SUM]   0.00-10.00  sec  10.9 GBytes  9.34 Gbits/sec    0             sender
> > [SUM]   0.00-10.01  sec  10.8 GBytes  9.30 Gbits/sec                  receiver
> > 
> > 
> > 7.2.0-rc2 with 0001-tun-set-waking-threshold-to-tx_ring.batch.patch
> > 
> > threads 1
> > [  5]   0.00-10.00  sec  19.6 GBytes  16.9 Gbits/sec    2            sender
> > [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> > 
> > threads 2
> > [SUM]   0.00-10.00  sec  13.9 GBytes  11.9 Gbits/sec    0             sender
> > [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> > 
> > threads 8
> > [SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
> > [SUM]   0.00-10.01  sec  12.3 GBytes  10.6 Gbits/sec                  receiver
> > 
> > threads 16
> > [SUM]   0.00-10.00  sec  12.5 GBytes  10.7 Gbits/sec    0             sender
> > [SUM]   0.00-10.00  sec  12.4 GBytes  10.7 Gbits/sec                  receiver
> > 
> > 
> > 
> > HTH,
> > 
> > 
> > Brett
> 
> Thank you again!
> 
> These results show that waking earlier performs better in this case:
> For 8 threads we get 10.6 Gbit/s instead of 9.83 Gbit/s when waking early
> but we are still *far* from the 13.5 Gbit/s when we revert everything
> (see above I pasted the reverted results there).
> 
> So I come to the conclusion:
> 
> 1. Waking earlier/later will not fix the performance issues. It may
>    improve the performance slightly.
>    Apart from that we introduce smp_mb__after_atomic() for the re-check
>    on producer side (noop on x86) and a full smp_mb() for the re-check on
>    consumer side.
>    Nothing else stands out to me apart from the overheads of
>    netif_tx_stop_queue() and netif_tx_wake_queue(). But we must use
>    those 2 functions one way or another.
> 
> 2. Users may depend on the dropping. Without backpressure tun/tap acts
>    like a pfifo qdisc which tail-drops. Some users may require this.
> 
> --> I would merge this opt-in patchset, it should be fine (it is not
>     flagged by Sashiko anymore btw). I would not be mad if it would not
>     get merged but I am out of ideas on how to improve.
> 
> Thanks,
> Simon

I am fine with it being opt in, but we IMHO, need to be more clear, for users,
opt in to what this is.

-- 
MST


