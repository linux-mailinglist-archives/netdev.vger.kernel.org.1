Return-Path: <netdev+bounces-306102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id etJqMAxnT2o1gAIAu9opvQ
	(envelope-from <netdev+bounces-306102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C529B72ECCE
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:16:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BlAyjAbL;
	dkim=pass header.d=redhat.com header.s=google header.b=VRfyHjBN;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306102-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306102-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB87B3117D28
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50B3FDC00;
	Thu,  9 Jul 2026 08:54:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118D3ED5A4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 08:54:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587287; cv=none; b=JhbEHGyMA+LIZvJAvrV5m7gp2rRE/Pk959CEXkjOyLSf9FkJn0hlg8lM+/AY+xTfklmKaGMHNmXIZSWcILzct6DqTHljHAoLTPfWaOPD19xOy5OTS4vDF4mwSCzptb0R3xCx5h3AS8YpIzLZMhi9HAxidZRjz0kbCZKeEgm/cPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587287; c=relaxed/simple;
	bh=wRRaBds4GutgazHTelDLWoEKQjUD+qekfGeab8oKIas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/1k1A9UosB7iliCA1U9FlaBZFTQwZoQOeJZokgWhIu3guZrLqiE5LZXfKmNd8VfY2++jjOblre+Mwy5Jff4rSU/OPzojE/Zal7hxCykOP0OAVyqshsylDx4scVHn10vepc/bS0Eq0ryMUn+TXJI2Bq4Tu7oQ+VCmQRZMmuDafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlAyjAbL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRfyHjBN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783587284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
	b=BlAyjAbLykGVnxtSiIUcYYke3Ot7vTQth/cP4NWIv/m6yme76bTdo9jqpsi3IYY+qSWdvD
	SKW+4Du4VQksNJlpdpoG0V2F1lHYKZGzb9QLREV/M3l1h9mJ0K4HFkiHgR3ii7CKsWXGyS
	7EePKe9LQiCImxRy38vrkBO56kdltGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-RwlKtgJ2MLyFi1BIFacpTA-1; Thu, 09 Jul 2026 04:54:43 -0400
X-MC-Unique: RwlKtgJ2MLyFi1BIFacpTA-1
X-Mimecast-MFC-AGG-ID: RwlKtgJ2MLyFi1BIFacpTA_1783587282
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4629f312a67so1414032f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783587282; x=1784192082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
        b=VRfyHjBNh75myXSj6eNN9uojHY/fPLF/k/3P9YZXppPcS7iBiRZqeTWfibSaIP70v6
         XGR8dPfKKBQF9kBq9xpuF42VD6BcpktQA7kWflvLltjUTxAocimpGwiAX00jK6WNBwkl
         vwKNXNuj8dCSYzNRfPjR9A99k7L1oUpHYF9utMTVxIEU7TatuRs5RNPNDDTJLxi8K0Gd
         OxEEogW7gkOBtgHO4BZpFOD4z5IYpLXMm6WsdhziMWAs3Ua7lgVYlbPEurPN9YgR7QJF
         PZ16ptZigP6FjrVoVuAZDd8hY/eODzEveoxkPZ7hnjG+aOgR9yT5IUJADM990A/bNhJK
         3B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587282; x=1784192082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
        b=jyrIliav7vIQ3JlcXCJ8ImV1sAMAUM9R0IKxU1Jpgm3HSIF3ZzphkfKOKpwWtFHG6J
         6FKKTnI3SIkGvwDs14RNdzci5YTVNyZASfoh7E0M3tIzafh9f86neQiJzOeRdnZx06++
         J89qw7OZAaRxpAGMJFGyvdBH5IG9oww4njDtwMJISi9nszj5KLFRYZrKxbhZZT8YsLGe
         CDZ6OllQZfQvIM++In4A3lLIZda5Um+fMDa9PxK9bVCpL8aEvEVtlm98L6SqAFzI5DSH
         qPr3uk6k0T2YuVF1ao1kAF2boainTXFbpPvF75bwa21/WSgeJke9MmRxl071CLNethHk
         7rsA==
X-Gm-Message-State: AOJu0YwfbXL4uq4SjzXAVbATswAXdBm41Tz7Gjea4oFXVUoZme6TVctU
	JtG4PMcZ57gEBuymkasTeDexfKypaMdAL3nnp+PGxw8URqNzpcR16JdFeNPRxkWCgRrHjwOWXcC
	LVgvipMHgzBUqO8ihnmtypC77/FSiEedHs+7AFlHALyWUra5dGjH4yNK8Pg==
X-Gm-Gg: AfdE7clOS4MVdjaymoLHG2pvyM0os/gK42AQOxSUOEL2mxTrcBvOpiUNWykHHWaJY63
	XOiu9JUm5Blb8lAx7viGEu7zVIb5ToLjGk4l0cVzSKXBXTUT+HFBWdqFcitE7BxFou5GglZSlBX
	QV0vzo6eDjhVMN/7U+HJZYB7hxsA99O0UxPxBIx5QTVm17d6ketLd+NajvSCw6KkjlxwzUTdaaz
	+5WGLzwJRB3GMdl/v0Uqg0gbDU0ACarcrSyuwppZs0X5EcZqGp61Hhlgbsi2sCQHg8K7m+6cVCH
	Yv8TeMJ8msE581vBGoXg7zkVmIuZeqf43y1M49D1yKZS5NOvSrjqWX0UW+RWtZdSSupLKIoI2VX
	orbJDCDNiYq6UfBWV0ZflYgJaxsm9uiIblhCrdDTwWE6zKZQz+UB4iTwtqy5R
X-Received: by 2002:a05:600c:1993:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493e68c6c98mr55722895e9.20.1783587282447;
        Thu, 09 Jul 2026 01:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493e68c6c98mr55722455e9.20.1783587281922;
        Thu, 09 Jul 2026 01:54:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm54564705e9.7.2026.07.09.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:54:41 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:54:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <ak9fGNnW7gdqVXie@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-2-sgarzare@redhat.com>
 <20260708065947-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708065947-mutt-send-email-mst@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306102-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,google.com,redhat.com,kernel.org,davemloft.net,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C529B72ECCE

On Wed, Jul 08, 2026 at 07:00:00AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:03PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When many small packets accumulate in the receive queue, the skb overhead
>> can exceed buf_alloc even while the payload is within bounds. This causes
>> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
>> resets during large transfers under backpressure.
>>
>> The issue was reported by Brien, who has a reproducer, but it is also
>> easily reproducible with iperf-vsock [1] using a small packet size:
>>
>>   iperf3 --vsock -c $CID -l 129
>>
>> which fails immediately without this patch but with commit 059b7dbd20a6
>> ("vsock/virtio: fix potential unbounded skb queue").
>>
>> Inspired by TCP's tcp_collapse() which solves a similar problem, add
>> virtio_transport_collapse_rx_queue() that walks the receive queue and
>> re-copies data into compact linear skbs to reduce the overhead.
>>
>> The collapse is triggered proactively from when the number of skb queued
>> is close to exceeding the overhead budget.
>>
>> A pre-scan counts the eligible bytes to size each allocation precisely,
>> avoiding waste for isolated small packets. Partially consumed skbs are
>> kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
>> maintain SEQPACKET message boundaries, and skbs already larger than the
>> collapse target because they already have a good data-to-overhead ratio.
>>
>> Walking a large queue may take a significant amount of time and cache
>> misses, causing traffic burstiness. To limit this, the collapse stops
>> once enough room is freed for this packet and the next one, but may
>> opportunistically free more to fill each collapsed skb to capacity.
>>
>> [1] https://github.com/stefano-garzarella/iperf-vsock
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Cc: stable@vger.kernel.org
>> Reported-by: Brien Oberstein <brienpub@gmail.com>
>> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
>> Tested-by: Brien Oberstein <brienpub@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>this is the right approach

Yeah, I have a follow up to start to use skb->truesize, etc. but I guess 
more net-next material.

>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks,
Stefano


