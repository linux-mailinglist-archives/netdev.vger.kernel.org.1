Return-Path: <netdev+bounces-303825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d/XyAR1/RWq4BAsAu9opvQ
	(envelope-from <netdev+bounces-303825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:57:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2C6F1B0F
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QwLsO5oY;
	dkim=pass header.d=redhat.com header.s=google header.b=q7rA9alm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303825-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303825-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0187A301746B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4D3A1A2D;
	Wed,  1 Jul 2026 20:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9938F258
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 20:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939418; cv=none; b=XXiug7IhNy8YlPt3rEkbflaOyiebwzZpUV08JZ+EP2rhLlMxC+ZBBCFtK7zVA8sVWpUeQwSsujP9hpY0FFXGrjPfDKg+vEn77UF6KHa+y2xqSfmSNDean/fu8xN0WBJ7enm4acftTLxU2PPqUWH5CbgEmWJ/WO4rs9mRKX5l/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939418; c=relaxed/simple;
	bh=mRiwnn+oiSq7d7lkAzV+P36bj5VEEUrH+Uwbhlo8reo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o42/DO+ymJqTZ9uU532KxRgu6SF9KXTltPS2tKVd2us/XgzuqZTUhvi8yVWHnFSBOar5Ko67UHRqz6/ISl60GOptixV9gI5cgOXJrv1U4/EHUPU6r0rlDG2Cg6FanzL48RPmY6qAAvuw3gDXU3dwcgfk1NDkhkTvpTmCMw58XwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwLsO5oY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7rA9alm; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782939415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hYyIfv1CaoGsqa362UdF8tkaUCPwp79KqO05jVLqz0=;
	b=QwLsO5oYBX5/T0Z6bfeWOKBDOldzTXErgRWrQiUFGV2EUh4yro0amcV5w3+8yH5XBYswX5
	UOxWZITk3IaV2kdFoBJvX0aq11F4PtHO9Yrf5X+9grDcnrYzmUlm0yLZQ5wPOY4vuCIPpd
	ZDV5Lszd/Xrg7f9qZ68MviUNU2+PLL0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Ksie43NlOweV_PIebuTdhQ-1; Wed, 01 Jul 2026 16:56:54 -0400
X-MC-Unique: Ksie43NlOweV_PIebuTdhQ-1
X-Mimecast-MFC-AGG-ID: Ksie43NlOweV_PIebuTdhQ_1782939412
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492714d002cso8415055e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 13:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782939412; x=1783544212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hYyIfv1CaoGsqa362UdF8tkaUCPwp79KqO05jVLqz0=;
        b=q7rA9almzPKmOB9lCJxVcQPsivay114G9jE24jOWBajFEh0K0DQ9zxYnGSJfqLVoW8
         V1n9rbQbHIyPJADLShchYw5BlDoIplgnLsG7lBuNfXwwE9Iz1sThflO7PiDLO5i5Bjee
         56yBVTsK/9jxvaQmCn7mXLuwAYJGsm/zuO2DTAFlHTzVmMoxX0KLjS2vt/aE8a6T1yZf
         uZ6Pw0u/dHxkyL2PwDBiYINxbY0VCyyIAB8RsAbie5X1TjN6b+wbGJ7aMBKKZqLVfmxH
         JiRszpfPN0mjz0mqYOmMQusgyUosg9nQ3Q/lmWBFvWc3Q9B98z9qzCMz5nIEiyxqJf/i
         p7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939412; x=1783544212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hYyIfv1CaoGsqa362UdF8tkaUCPwp79KqO05jVLqz0=;
        b=nx084Msky++IqZpMFtj4bjtxHywU33uG6uafka54qVi9oFnhI1C7czz/WRTLF1F2CF
         es9vOivQGeHgoYS7xWrvLJs53MFuUNXZ90gmSUDvvczPBDgkQIWszaeKZrt6tm9UMX+n
         KsqpFxYdjmszMEEGmttPRFUOcrEnKaSks//pON8XIcwKm7F7NYQHmvPPRhDUGiPrWIrR
         xQY1fuwDrGoKzZ/offvHko3TNm023AfWXR8svyeG+AhdhdFa4wOMQLPM68YBs8smYPB6
         05NDnouIOkSsWadufk+Wi3CqhPRj4O6x6J8/YOT8+uI8HoCkWKncZnegSgzczfM9xwG4
         fZ5Q==
X-Forwarded-Encrypted: i=1; AFNElJ82nipKWNTJvWPdqE0C7c8qQgDjqqszJcQ//r8ZsmMqi4rJnEIJikO+2rbjVnTShNwfQ9oe/gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncDosPDcCNVjEzR55QJZJdt9kv72kV2W61KiL2to/WfObe+ge
	yqHcEmHXEpIgKv8ELsYchR8q0jbrPQgYRQtomNjmClOR41bmGYGkJYb+oO2+Wjvfk2f66NbNmTJ
	FJcblzR+n99soeuP1e+mxejwvu6akSQqk3v0kKw1b57zrp/nPP5RePWcpMw==
X-Gm-Gg: AfdE7cnJkzmYpyfW3ZHLEC1nMkGg90EDjnDFztjFToXZyO79AQfnPnvfuYqeMOlyhYr
	86HtTf0DzsqYi43vNG6KA5QVy8Ndb0d8O1jhJcZwlfoJlcU7mJtijUjas2cMi7jRzpqHLDO+Gqw
	cmm4HgUBrM6ayiG4ZBtoQJBEaO3vlGdLFw/t0FyVaI/Q53MR0gvngC8GPjY0JHuEoo6lY4aDGXp
	+0OtLekjw3eebzwOn5tKHmi1mWDe2Dgwz6DCFM2Q4s1lOq6CwzAdQfjTIqGAahAj9jNZTMQjkQy
	uyqYxXGOQeFWTQYdLWw5D4nIC60WsEplueAXsL6+AxL1p6Q4ItZ9Lud+GGMRx3M67wCto+b31xy
	eoDzjdSYRudvHB03V8Xq9ErC/yRXfSzbg
X-Received: by 2002:a05:600c:2e53:b0:493:b8dd:9d68 with SMTP id 5b1f17b1804b1-493c3cdac7emr20916815e9.10.1782939412269;
        Wed, 01 Jul 2026 13:56:52 -0700 (PDT)
X-Received: by 2002:a05:600c:2e53:b0:493:b8dd:9d68 with SMTP id 5b1f17b1804b1-493c3cdac7emr20916495e9.10.1782939411763;
        Wed, 01 Jul 2026 13:56:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bf11eba5sm54818415e9.0.2026.07.01.13.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:56:51 -0700 (PDT)
Date: Wed, 1 Jul 2026 16:56:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brett Sheffield <bacs@librecast.net>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Schippers <simon.schippers@tu-dortmund.de>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <20260701165359-mutt-send-email-mst@kernel.org>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303825-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:simon.schippers@tu-dortmund.de,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,brettsheffield.com:url,librecast.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ED2C6F1B0F

On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> significant performance regressions with TAP interfaces and multithreaded
> network code. Please revert.
> 
> 
> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
> interface. This test has run successfully on every stable, LTS and mainline RC
> released in the past year. Every kernel with my Tested-by has run this test.
> 
> There have been a bunch of changes to MLDv2 so I started bisecting there, but
> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
> 
> Reverting this commit fixes the test.
> 
> To eliminate my code and any multicast weirdness, I ran tests with iperf3
> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
> reverted.

Thanks a lot for the bisect! Reverting is not out of question, but
just before we do, it is worth analyzing the situation.

Could you pls tell us
- do you see packet drops?
- does it help to increase the tun queue size?

Thanks a lot!


> CPU: AMD Ryzen 9 9950X
> 
> [ host ] - [ bridge ] - [ tap ] - [ guest (qemu) ]
> 
> Running matching kernels on host and guest, I started iperf3 in server mode on
> the guest and tested from the host so traffic passes through the tap interface.
> 
> iperf3 -s -V                 # server
> iperf3 -c guest -P nthreads  # client
> 
> 7.2.0-rc1 (threads 1):
> 
> [  5]   0.00-10.00  sec  20.2 GBytes  17.4 Gbits/sec    0            sender
> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 1, reverted):
> 
> [  5]   0.00-10.00  sec  15.3 GBytes  13.1 Gbits/sec  368            sender
> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 2):
> 
> [SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 2, reverted):
> 
> [SUM]   0.00-10.00  sec  15.9 GBytes  13.7 Gbits/sec  1567             sender
> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 4):
> 
> [SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 4, reverted):
> 
> [SUM]   0.00-10.00  sec  16.5 GBytes  14.1 Gbits/sec  6701             sender
> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 8):
> 
> [SUM]   0.00-10.00  sec  10.7 GBytes  9.15 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  10.6 GBytes  9.13 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 8, reverted):
> 
> [SUM]   0.00-10.00  sec  16.2 GBytes  14.0 Gbits/sec  19319             sender
> [SUM]   0.00-10.00  sec  15.7 GBytes  13.5 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 16):
> 
> [SUM]   0.00-10.00  sec  10.9 GBytes  9.35 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  10.9 GBytes  9.32 Gbits/sec                  receiver
> 
> 7.2.0-rc1 (threads 16, reverted):
> 
> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec  43593             sender
> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec                  receiver
> 
> 
> As you can see, the new code works for single threaded, but for all other cases
> there's a significant performance drop. I see this trade-off is mentioned in the
> commit, but the performance drop off is much worse than suggested with the
> current patch.
> 
> In our multicast use case data is sent by multiple threads to multiple groups
> simultaneously, this just breaks things to the extent that a <2 second test
> times out after 5 minutes.
> 
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
> git bisect bad dc59e4fea9d83f03bad6bddf3fa2e52491777482
> # status: waiting for good commit(s), bad commit known
> # good: [36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks
> git bisect good 36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1
> # good: [db314398f618a3a23315f73c87f7d318eaf06c1b] Merge branch 'net-bridge-mcast-support-exponential-field-encoding'
> git bisect good db314398f618a3a23315f73c87f7d318eaf06c1b
> # bad: [079a028d6327e68cfa5d38b36123637b321c19a7] string: Remove strncpy() from the kernel
> git bisect bad 079a028d6327e68cfa5d38b36123637b321c19a7
> # bad: [f396f4005180928cd9e15e352a6512865d3bc908] Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
> git bisect bad f396f4005180928cd9e15e352a6512865d3bc908
> # bad: [ec1806a730a1c0b3d68a7f9afe81514fb0dd7991] netfilter: x_tables: disable 32bit compat interface in user namespaces
> git bisect bad ec1806a730a1c0b3d68a7f9afe81514fb0dd7991
> # good: [50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85] mptcp: do not drop partial packets
> git bisect good 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85
> # good: [68993ced0f618e36cf33388f1e50223e5e6e78cc] Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good 68993ced0f618e36cf33388f1e50223e5e6e78cc
> # good: [34c78dff59a25110a4ce50c208e42a91490fe615] Merge branch 'net-use-ip_outnoroutes-drop-reason'
> git bisect good 34c78dff59a25110a4ce50c208e42a91490fe615
> # bad: [9587ed8137fb83d93f84b858337412f4500b21e9] Merge branch 'gve-add-support-for-ptp-gettimex64'
> git bisect bad 9587ed8137fb83d93f84b858337412f4500b21e9
> # bad: [83ea7fd73b11dd8cbf4416507a5eac3890b49fb0] net: dsa: microchip: remove unused phylink_mac_link_up() callback
> git bisect bad 83ea7fd73b11dd8cbf4416507a5eac3890b49fb0
> # bad: [f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a] net: make is_skb_wmem() available to modules
> git bisect bad f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a
> # bad: [c411baa463e85a779a7e68a00ba6298770b58c4c] netconsole: move push_ipv6() from netpoll
> git bisect bad c411baa463e85a779a7e68a00ba6298770b58c4c
> # good: [fba362c17d9d9211fc51f272156bb84fc23bdf98] ptr_ring: move free-space check into separate helper
> git bisect good fba362c17d9d9211fc51f272156bb84fc23bdf98
> # bad: [d0273dbe8be1640e597552f81faf1d6c9997d3e3] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
> git bisect bad d0273dbe8be1640e597552f81faf1d6c9997d3e3
> # bad: [3803065cd6b0630d4161d86aa04e2d1db0f3a0b5] Merge branch 'tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
> git bisect bad 3803065cd6b0630d4161d86aa04e2d1db0f3a0b5
> # bad: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> git bisect bad 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3
> # first bad commit: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> 
> -- 
> Brett Sheffield (he/him)
> Librecast - Decentralising the Internet with Multicast
> https://librecast.net/
> https://blog.brettsheffield.com/


