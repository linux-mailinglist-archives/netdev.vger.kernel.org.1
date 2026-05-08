Return-Path: <netdev+bounces-285733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFOxKRqt/WlOhgAAu9opvQ
	(envelope-from <netdev+bounces-285733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:30:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13B4F444B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B3C308E50F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ABD3A6B6F;
	Fri,  8 May 2026 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YATD3T/x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b85F3mBr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79693A640F
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232407; cv=none; b=N7zfGyRd1hMqvZO0msdXnxgw5tfE9lEKvaePyYMAJJNYdCfJRlJOR/LjxJTMS7WI8K9N8cwqaKLNWuzsNLJNwAK/ufuU6r7bgxsWAZLmxEgyLgLG1GylqsMXYDUFgXUosvWiPnB1tqiOCTI+TJQHKVHlGCAI0JBYpcgY808MWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232407; c=relaxed/simple;
	bh=dFpHflt42hNwpcFXetPq0ce3vtQOlld7tM+YE9V2C4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phCZZYF/0D8VDQezgLhYCaoa92XV0ZDNKYgp8uDu8kLbIgInRhjMSG3vPXS1P97zU9NmT2OxpW23KvbEzyhCcikLtcdIhLjpZhpv8ECTCZMNTDvFuKpYgw2nKxEvNhcMwE03OrN8v1iEyT01BygZhahN5r+fhtTQEBAERYSSBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YATD3T/x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b85F3mBr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778232405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAq8IYPWybCHpSWifDil8mvZspvdO1nQAax4s7IttiU=;
	b=YATD3T/x2Z5YAATKkJejOdsIIsuDeIQDOM9aSmctVLBOqeY5zZvTEXbUQgdJcQzilZscUv
	JpRcb6LJ1qv/BD++tzJ6NVxKO+r4tVDS7LELprPfkSAfVzEP+6RHsSROC9SnJL7M/voACa
	gJ1xmS1gAC3P9pqPHQ+MqFf6UYMfRRQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-n0_ly3r3OOWIdCRJX5c5aQ-1; Fri, 08 May 2026 05:26:43 -0400
X-MC-Unique: n0_ly3r3OOWIdCRJX5c5aQ-1
X-Mimecast-MFC-AGG-ID: n0_ly3r3OOWIdCRJX5c5aQ_1778232402
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso1796483f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778232402; x=1778837202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AAq8IYPWybCHpSWifDil8mvZspvdO1nQAax4s7IttiU=;
        b=b85F3mBr5vE0cvGexUI7X6pusGr5YVQGWLuvGnFxovCMe0NyBbVAbwIOeD6gtYLGE0
         InOXSjt2EYDJs6IO+5woAuKGLt/tA7UR4XAHa4oAZNyBFL/oYTj9l7xWkqWx+YPeBkF+
         HMy+8E/KmkE2M5mlNNEEa2FU3dhuoEpshWCxT5uhhW1tBOJBOihIY64XKA41M0Yn19uz
         Sk9pEa2h81RmMncEFLXo+XK0Ik/diYjU0OSzPGwbG5Ys6jhWTm6t7++Mc+gBrb27rii5
         RLBlXV4ITHYja10rxLM1JrYis4yGT+R8ZdVBVjVWloigep6oYvKck//5UctoAxTR11ll
         ngBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232402; x=1778837202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAq8IYPWybCHpSWifDil8mvZspvdO1nQAax4s7IttiU=;
        b=tK8DKnOXTjJldG/Y8S6efVQBYOSWzoek+OzhDFiYrIG5e2RXKy0ED8Qwwa/cN7zwuW
         x4Ip08jDzP/Vw+lG8YlNrXrS7aOIXHL17uPGSRfSkgycZFzDf3MsrI9GMjdzv0vQqpJu
         QBSFw6xs1cenIcvZ/Z+dS9KDLMKwyY9r8SVsngLq5CtRhLmd5RDGYb56QtDvWWGb3X3m
         P1WPsOPWndneqkztwduKIZuoTJKPUjDcOCbYdxVg7WF9bGedQo6/mycKj9nFem2DYWRF
         GsE5Fs/DYP5LXGpmQ1ClBbzBDSF5FC2cpf5NznZEXNDjONGCfCExxA2TSj3GQGwnzCM+
         e6Ng==
X-Forwarded-Encrypted: i=1; AFNElJ+isorGX+x8pezhTjlGQ+Bhulxb2Q8ZmyJTuwdIBqDxNMAOpIvd+hw+ec5c+gBahJ33m+Qp6nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4jxLquM6sNjJRCOMtBK0+D2Sutr0Yt3aNvaKlzb0hu/KTZvk
	JcgnozUN7nnh3cK8rnVpBnXbQSCqCZrBrjG5GtPip20KuTde3Cj0tr3boFnqyiQIG7Xe18fY1yy
	SnKvP+kgaMmqxUx8yvUhMeTm4I1nsBLrDJGLPno6TXb66uFRQ1nkrn66RDw==
X-Gm-Gg: Acq92OF6UkoBcYQBWOKRRk4MkT83jSIH+EC6lWiEBWySaYopq5zG3jZDiMhVsMC7/pr
	kfJ24t6GnPM3zkQnZ5etuTQ9ZD10QGKa0uA1/SvUsrHKYfEHXG3nFUgYnTO+HZNG/faqODDVf8w
	PC6g8HsupjbaqxIj3tNvA3S9VMozxYp8dHORZnd3crnlUm9bWdIB6XBeF/7qD5r4O4+8HFcaQsw
	i9f8cPNObUHlfMpMRk88QuMz4EkOU4NCJ9Zn33cE3ucoCTsnxzGhMONkBa2WrPHrorBncHaNsP3
	8XgeTiVOEXSHNScX3Yc0xOhAertQkknCClDvuyfiV5avTgqGezRzFu7TPrhI4XtndKTPMkX94Wj
	Q+x9OV0aKY22K35YH253M5o5qmb1rpoyb1goMnm0gDi9149YlAYYwYrNAlhkUApY=
X-Received: by 2002:a05:6000:2403:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-4515df65daamr18435806f8f.43.1778232402113;
        Fri, 08 May 2026 02:26:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-4515df65daamr18435739f8f.43.1778232401549;
        Fri, 08 May 2026 02:26:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm2967434f8f.14.2026.05.08.02.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:26:40 -0700 (PDT)
Date: Fri, 8 May 2026 11:26:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <af2sHIO-9-wvmVxe@sgarzare-redhat>
References: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507073340.0604667d@kernel.org>
 <afyy9CeniTBF3o2I@sgarzare-redhat>
 <CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
 <20260507101805.6c3335d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507101805.6c3335d0@kernel.org>
X-Rspamd-Queue-Id: 0E13B4F444B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285733-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,salutedevices.com,meta.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:18:05AM -0700, Jakub Kicinski wrote:
>On Thu, 7 May 2026 09:32:24 -0700 Eric Dumazet wrote:
>> On Thu, May 7, 2026 at 9:05 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
>> > >We can revert if you think that the risk of regression is high..
>> > >Please LMK soon, we can do it before patch reaches Linus.
>> >
>> > Some tests in tools/testing/vsock/vsock_test.c are failing with this
>> > patch applied.
>> >
>> > Test 18 are failing sometime in this way (I guess because we are
>> > dropping packets):
>> >
>> > 18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>> >
>> > Test 22 is failing 100% in this way:
>> >
>> > 22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>> > Resource temporarily unavailable
>> >
>> >
>> > With my followup patch adding also advertisement to the other peer
>> > (still draft locally, waiting for Michael proposal) I saw 22 failing,
>> > because tests expects that can use the entire buf_alloc, but now we are
>> > reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and
>> > double the buffer size, or at least digest an overhead equal to the
>> > buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah,
>> > AF_VSOCK has it owns sockopt since the beginning :-().
>> >
>> > With that approach tests are passing, but I'd like to stress a bit more
>> > that patch. I'll send it tomorrow as fixup of this patch, or if you
>> > prefer to revert, I'll send as standalone.
>>
>> A plain revert is a big issue, now users now how to crash hypervisors.
>>
>> This vulnerability allows a compromised guest (controlling
>> virtio_vsock_hdr fields)
>> to continuously flood the host's vsock receive queue without
>> triggering any memory
>>  accounting limits or reader wakeups, resulting in unbounded host
>> kernel memory consumption (Host DoS via OOM).
>>
>> A vulnerability where a KVM guest can crash or deadlock its host is
>> classified as a KVM DoS.
>>
>> Am I missing something?
>
>Alright, let's leave it.
>

I posted a potential fixup: 
https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Thanks,
Stefano


