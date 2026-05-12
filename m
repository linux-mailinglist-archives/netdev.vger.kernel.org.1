Return-Path: <netdev+bounces-287107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGEkJG8MA2pI0AEAu9opvQ
	(envelope-from <netdev+bounces-287107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:18:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529551F386
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1C3F301AEC7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194F42B72B;
	Tue, 12 May 2026 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBAvkLU2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRuX/FN6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CC3093C6
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584682; cv=none; b=GL1z5HaXLVD2EL7YGNze2GPsfCZcQsR60AUq7t8L9BedGx5+xAU2JUc1u/v9joFaA36fhIRsybeb3idCVxtszaIXF+XbcCFgm4M7ljUb8oNUzEMSdFZU/UUFgYVF56hfJCmXJsHy7xGV9ZRmOPVuex2s9eEmxfvImY+yO8cqGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584682; c=relaxed/simple;
	bh=3pilreO7Jxj4wUh3RXkY1+6fibHwDc1PkYQ0dqDnEg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAsDDlwjHX18/1N+DgzuebhhMcqnA/S0PfnsbSMqK9Bk6VgxFv/UYhPsmpDUNR9BEbnrdyC4bLxgPcv1tPxOIinIFKqz1+HDCIOZsEMat0GKA8kedqWSXrHxtiG/P/fmvpbwiRTpCWNXErdSoO8qhgaic0uXuCjpNTFZqpETaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBAvkLU2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRuX/FN6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778584680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
	b=jBAvkLU2Iup9kO1Z2nvhy+d6NZJj/gyve01FmKWU6HKJ2EgOVbn2P7clbLHzthjsE+7qlO
	SumMIuJaTFQPMA7BnwyqepJ1nFetxk8yqly2PMwmw5k+vrX/8VDk+QI06tdD7ZbnqvQC5N
	xJaQfAyJT4ma9PF5nWPCOVOgvi8YdYA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-FmEjpSqvMuqLUooMayaA0A-1; Tue, 12 May 2026 07:17:59 -0400
X-MC-Unique: FmEjpSqvMuqLUooMayaA0A-1
X-Mimecast-MFC-AGG-ID: FmEjpSqvMuqLUooMayaA0A_1778584678
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso48418665e9.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778584678; x=1779189478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
        b=fRuX/FN6dm1C0Ye5oQwmlUqlEQEwx8xz3DrkfMms55t6vKjxQHnQ/FWUSH8OuJDu5H
         UbmgSKwuTPHteKN0LRKiNbRwKEr2u1ltkKOcpEOjnHqI50i0WxgW3OqZSVexGdbCDla/
         aA/Jom1jsqTrftAQipTz9t8gASuO+dxJ2JRDU5CKa2g8rHFmWXR9lJJwX9ku0pee0E7c
         6aKLNHac6hiYlFRFwHt4EMRS83p24An5OfSwmOImKndlBoVot+S7WA4TEqu/Gx5lt17y
         vbR4OBrVdMnWJwYfOJK8+QNbw3fRY3fx0Qpty58z7I3eauiszpeWy6XUIJ82V+6VEDvS
         vt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584678; x=1779189478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
        b=Y928M+jitzuugXM6GZU+ouiIRgZNoz94KRcYo9BIFJ/RZz/qxF4vzouNUCx58Zcvnc
         eIWYdbm/GtDUUcEQSO8K/ZrAYiKkEPN0gtaO9MAbJChFz9MSG7l0WS0qKxgUV0If8s73
         GYk+HlDVbyiRl/PrR8C95s5OCwa+/ir80cCHKPihUALVvpAKsMCVNMelS5oSvq7yMs/9
         2ejeoOJ0c5zqKPnNyszMp68Oc97cw24L0XhmMJ3yAPjcjQnAfGdAHJ4lcFGJH6P4WchA
         +5lZRQGa86U6WUve/HZm8kClMyuXdlCtQZkUpWuOwBKg8NNza1mR7CwxbT3bm5nTeOB3
         AG3g==
X-Gm-Message-State: AOJu0YzCqG4FejMQEYxPz/0xVFbTCOrU+g6AvVUwdlhrSXzKXUD/aNyD
	u872LMsCKDREFVr8P2lNEScWZd41M6LpqnJgvHVwNiuU3c9rxeAztUM1Lu6UxX2MP25hKBBZb2e
	ilukvrhEaZe5rSXAZVlUuLwcGzBmfqtF2Yw8Kcr0BnA0FVpjM6bmfnWIB/l21OzDC+g==
X-Gm-Gg: Acq92OE6qDwfh3Df59a/6wg6aKNmR03OegYL0Q3p4sH6u4y4nPsCxjzVaUaRxd/JQQy
	y2aVoYGPkXCDYBVmJaNfvf4f3B1JmeHZDdy7LpUGdaXvqoEE8IMMMw2GBejngBMMtrVmevGiBRQ
	MkUiGMdJ4ALF7V6dh7DD3LRz6D0MQ3OZwqFf2gjt9ToNlsaBss0dxF02VjcMfXYEi33LaYAImyL
	u0VEyHNjTX+XJfhLJYmYyjrtPsVuf/2/sPBxQhDO5pLwUoBTMOKv3wz/eBa9LQT2Lrf0TsF8I7L
	IY7LBcsXH40+gh5Rtkd+zAqo/WognTVAMbFfKd3rphfr8PeYuTcTjOeoFmiZipC8Xs4dVc6M0HP
	ZXcGJYoaiXguXRQxVEcAi1/dlZYzIXoppuEFaGemF
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr53750875e9.8.1778584677971;
        Tue, 12 May 2026 04:17:57 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr53750065e9.8.1778584677428;
        Tue, 12 May 2026 04:17:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm26866475e9.1.2026.05.12.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:17:56 -0700 (PDT)
Date: Tue, 12 May 2026 07:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260512071726-mutt-send-email-mst@kernel.org>
References: <20260512080737.36787-1-sgarzare@redhat.com>
 <20260512044008-mutt-send-email-mst@kernel.org>
 <agL0ewq9R-Br9mUh@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agL0ewq9R-Br9mUh@sgarzare-redhat>
X-Rspamd-Queue-Id: 3529551F386
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:03:38PM +0200, Stefano Garzarella wrote:
> On Tue, May 12, 2026 at 04:54:34AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > effective receive buffer below what the user configured via
> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > silently dropped and applications that rely on the full buffer size
> > > to deadlock.
> > > 
> > > Also, the reduced space is not communicated to the remote peer, so
> > > its credit calculation accounts more credit than the receiver will
> > > actually accept, causing data loss (there is no retransmission).
> > > 
> > > With this approach we currently have failures in
> > > tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
> > > test 22 always fails in this way:
> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > 
> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >     Resource temporarily unavailable
> > > 
> > > Fix this by using `buf_alloc * 2` as the total budget for payload plus
> > > skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
> > > is doubled to reserve space for sk_buff metadata. This preserves the
> > > full buf_alloc for payload under normal operation, while still bounding
> > > the skb queue growth.
> > > 
> > > When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
> > > flooding where overhead dominates), the connection is reset and local
> > > socket error set to ENOBUFS, so both peers are explicitly notified of
> > > the failure rather than silently losing data.
> > > 
> > > With this patch, all tests in tools/testing/vsock/vsock_test.c are
> > > now passing again.
> > > 
> > > A solution to handle small-packet overhead efficiently also for
> > > SEQPACKET (we already do that for STREAM) is planned as follow-up work.
> > > This patch is needed in any case to prevent silent data loss, because
> > > even if we reduce the overhead, we can't eliminate it entirely.
> > > 
> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Thanks for the patch!  I'd like to split this:
> > 1. buf alloc boost
> > 2. reset when out of credits
> 
> Good point, also the reset maybe should have an other fixes tag (i.e.  when
> we introduced that check)
> 
> > 
> > this way we can revert 2 easier later.
> 
> I'm not sure if we should revert them at some point, even though we'll be
> able to handle the overhead better,

I mean we'll prevent the overflow, the condition will never be met.


> but I agree that we should split them.
> 
> I'll wait for a few more comments and then send v3 with the split.
> 
> Thanks,
> Stefano


