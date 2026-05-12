Return-Path: <netdev+bounces-287054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gESNEsj7AmpOzQEAu9opvQ
	(envelope-from <netdev+bounces-287054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:07:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BE51E443
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1498430219A1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4230E4BC034;
	Tue, 12 May 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO7bTLVC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2+jM7UD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27C24DD17
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580232; cv=none; b=kHZi2wLbNstNUlQpluzrykfUmkY2JZStEv7iGOwXb3XggfALjMCGnTBA8uUzOhzPSQICHPHTlnN9q9/JKsmaOa+ZKxrU6JFOW5JgbRPVLXt8urJ7jysN/rSnW2K51p44lB/IR5cFyhlFjnuxINyFr0T6AB0JNnK4VF6mvcgnClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580232; c=relaxed/simple;
	bh=Xwy+EHHbHLCBc2qgYzK4qONDiarEocrGw7v3cd+QUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myVxw5Wfep6ncZgmO7kPIVF5xNv2zd5eSsEEeomF2Lz9hlu86Kg98cZl2IsViHBUsO9VyArzwKbGVdJZAx6zM9kzyRROn+lJU7Izugrsihr8W+SShFbgHmbjQsmEFjbEgtErBL5qPNNwvU4KgHQwFULERj+lJQcefu5mipEPorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hO7bTLVC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2+jM7UD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778580229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
	b=hO7bTLVCSeXP8BXFe0EDO1/BeOTgUqsiTsZKtPz6i7ZfYIVa/aGU3Uz079TDf5YL/jpnil
	41JA2Gbj3GMUeFBqu/Pf4hVh+zSfsaja7c9kq4WfddJ1sp7TxqkKJNEx68jb/ro1yPOlqk
	5/ClwJB75nPjmsUY2d3j7D9Qo5UwsRo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-su4HJ4puOC-7M8zKXDAsXw-1; Tue, 12 May 2026 06:03:48 -0400
X-MC-Unique: su4HJ4puOC-7M8zKXDAsXw-1
X-Mimecast-MFC-AGG-ID: su4HJ4puOC-7M8zKXDAsXw_1778580228
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eacc2008b2so962353185a.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778580228; x=1779185028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
        b=M2+jM7UDPO1yRQYtWCvHeFftYeZiCSHgeYGlMPTTnEhc6X5wh+tlojXnvbrzcIVwC9
         vl2KUdPVC3Ja3/5wRW+fdtQkLPnnmgiGyehiqFXHVCecPQvnFdRdcfbUQPL9NPiPpKPD
         Yd5IhsauBQXM4K+PEJvG24WFoZLtSUTApzMXAI+yr3zb92SswGc9RRP/Uh8BA7MgOm9F
         +nYsf2XDFGYloKfS8nWmk0XwadWGz7d+DYk9sORd1HS99XsjGjj9mtksfO0JISRFIDJP
         zdDtNqyUEZyj8wbIqXkfVYoUcAclpz/RUp2JhTkGvIkCod0pg8zhWuFhlvXm6+eKHp1Y
         47kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580228; x=1779185028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
        b=X1firYb4+jFNSSRxKq4MlRXxROMgSmf0+vzNJ0W29SHh3GyzwA/1r0tedFl5y0SFhR
         qToouaBG9ekHAayfLAsNGnMBJjuU+aX4BjJPxEsxuZHgXfgyzjJvNs9J9kYkFILMiHE5
         RUxlv9VVqEQF8XYKcGZBqyP0gSgCOEagjRIQCpv84IuA5nwjRn6Nwu8DK/AcxG6rglNj
         hhSsvNegY5MjwTBzZzZMZhKmKB6JuLZUG+QkPfiX5d0ZDP3iM7/nlBwKCXW7py4jKWSo
         Vu/kHHvj5UGaAYr7ZAciz3nr2MxJg9Ga/3Y/7VgU2UzQ8KHfWHsVqKal0SlE3PjTvR/V
         40LA==
X-Gm-Message-State: AOJu0YxdQe6ISvkkAfnnpxUf2gWvmQFuy6tCHTaz6ETihJpGzOwcPkVc
	yACcPbN2LcU3Y+l5aVmwHbroBK9tw6VIWrwJPYy8sEUaCwEEjuxBDLHKNolbte9OMX3WdrGUgIl
	qy21Y5LUon91fVgIBOrKRdquUu/aLYpGB+U1DfHJCPyv4tM4JF18iwf1aLw==
X-Gm-Gg: Acq92OFwPyTHl/bJGj6OVeAvUTD7C2b1VVZl3Yph6UU4tcs4Avy3lOH2kK1VOb2LcCR
	tqJmebyPFagLwzsye8LbUK+bKIgfh9kiIlcz+GCAA4eA8igB2tJjGi320NnrqOp+qilnCwSKdL+
	FDP/IMbPK31QeZcqaQZGTBUvggmXLLwcZxFo2qmD5OpAGzacU3S37waBFZMXwbeRRUDX2XZlWqs
	rcX4nyGjJPLBgCgZcT/T/FD3OyDSo7t0eUEW3O8+Em+MIXGzt41BfVILXG24ca4d4Ab7qn/wOwI
	on4ooBB3Wf3qM/C4UlMWKuQQ+DzvrBXZhoKyiA/3aJIDGIKMpeNNpoeNiKSxS8k1Db+fZMOSwG2
	2YYoY3IITxLaavbPtB21SaeQe4TJCOYW+EKfBZ5WL33uAntJPTJ8GWr+91WMrHKoM7f+Dw/xjLY
	9PCbUoaMKu
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1965595285a.61.1778580227665;
        Tue, 12 May 2026 03:03:47 -0700 (PDT)
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1965587785a.61.1778580227008;
        Tue, 12 May 2026 03:03:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3644793085a.36.2026.05.12.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:03:46 -0700 (PDT)
Date: Tue, 12 May 2026 12:03:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agL0ewq9R-Br9mUh@sgarzare-redhat>
References: <20260512080737.36787-1-sgarzare@redhat.com>
 <20260512044008-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260512044008-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: 031BE51E443
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287054-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:54:34AM -0400, Michael S. Tsirkin wrote:
>On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> buf_alloc when checking whether a new packet fits. This reduces the
>> effective receive buffer below what the user configured via
>> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> silently dropped and applications that rely on the full buffer size
>> to deadlock.
>>
>> Also, the reduced space is not communicated to the remote peer, so
>> its credit calculation accounts more credit than the receiver will
>> actually accept, causing data loss (there is no retransmission).
>>
>> With this approach we currently have failures in
>> tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
>> test 22 always fails in this way:
>>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>>
>>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>>     Resource temporarily unavailable
>>
>> Fix this by using `buf_alloc * 2` as the total budget for payload plus
>> skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
>> is doubled to reserve space for sk_buff metadata. This preserves the
>> full buf_alloc for payload under normal operation, while still bounding
>> the skb queue growth.
>>
>> When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
>> flooding where overhead dominates), the connection is reset and local
>> socket error set to ENOBUFS, so both peers are explicitly notified of
>> the failure rather than silently losing data.
>>
>> With this patch, all tests in tools/testing/vsock/vsock_test.c are
>> now passing again.
>>
>> A solution to handle small-packet overhead efficiently also for
>> SEQPACKET (we already do that for STREAM) is planned as follow-up work.
>> This patch is needed in any case to prevent silent data loss, because
>> even if we reduce the overhead, we can't eliminate it entirely.
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thanks for the patch!  I'd like to split this:
>1. buf alloc boost
>2. reset when out of credits

Good point, also the reset maybe should have an other fixes tag (i.e.  
when we introduced that check)

>
>this way we can revert 2 easier later.

I'm not sure if we should revert them at some point, even though we'll 
be able to handle the overhead better, but I agree that we should split 
them.

I'll wait for a few more comments and then send v3 with the split.

Thanks,
Stefano


