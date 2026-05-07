Return-Path: <netdev+bounces-285421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOXFDM+5/Gl2TAAAu9opvQ
	(envelope-from <netdev+bounces-285421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA334EBEFD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB71C30427C9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA793EF64A;
	Thu,  7 May 2026 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGzgQNMh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK1QSXhd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8239F193
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169918; cv=none; b=so152UgJUw/wCNrcdQEl3GFoPFN+g0vW12laVR/PStGmGEab2qbODl6bqY0HuQNziazIEvk7/2lO/77HPURd5t9SUgnIO8vwxkjuxk1pyPFq2riPEOh62MBAQ+q0hTZ2ru+OZxKc6s/dMyI2E+sDNjpH5OjOmyJ+oK1R+0BAAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169918; c=relaxed/simple;
	bh=sZ79yV65rGcfZNXlNxRvakvY2Z8WmdeNfaJ+WX7yPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbIYiNlTGpL42LEJVYsCLe3yO9b9nX4WHwkgX3YHCoe7Hp9oh5i5EtL9QnVkhzaVb1bWDfoIPES0LtmYjLN4VRJydPgYZ/VmouwpCZPL8fRzQqv4M9v62PxDFHUDVd0ytis5wgtWxyJilypxT1/8MJ8wNtDD3BhaDQJ94ejnCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGzgQNMh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GK1QSXhd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778169916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
	b=LGzgQNMhhsjc1SR3SfsZFyOJbn9gv1647ZStC9505uwaAoa93wBPK5YrS3CnjCIxqtKxeb
	XoBAsxi8fUiFGmHIHNQN1IQ5x+daTwKFKmg02wvwpeCV4Qr4t7ZgCmTnp2j/BeIOUEMmU0
	l72Z/zsmK+7ZN2diyw6QgTg80OQ1gKk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-7CMYA7luPNeFhOZdrYVJvg-1; Thu, 07 May 2026 12:05:14 -0400
X-MC-Unique: 7CMYA7luPNeFhOZdrYVJvg-1
X-Mimecast-MFC-AGG-ID: 7CMYA7luPNeFhOZdrYVJvg_1778169913
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso7449365e9.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778169913; x=1778774713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
        b=GK1QSXhdBe/uV0+4/ebp6JyNLvVoHeU5ZH7PrbVjG++te+52J5Socma5315sxdfYNs
         C4NhVpGJgxrZUfJqstfUJIcxfEGecCbrfCb3KizaW3LARuDGHdo19ZLpaRd6J1BtoWHx
         EAKVetMaudpRmx2Ot8ORJPle8dw6fpyYz/JHC5ED2M6TN8YKVYBK21TabFvCuzMMnDnE
         /pV8H8b2xEu850DZMJZNRi+hBX7j/EX4HwCRvtYVCrpTmli+K/mbH1UkI+QyFf/QS/rI
         Ivvv1JodWRviiVRcthxX/dvugJl3D1m277t9lMMC4fgqhDQEYQj7xrz+5M1ILMdRxBgE
         ua3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169913; x=1778774713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
        b=TCxm9Hw936Vo0Dkc3aI7snQkEU3ObzLKka3oiSpm7FInXx8VMYT5ulnX7Whc0CggUL
         6J2WjLQmIG2macnnwxgfddtlrhZ23CneYpySGaKxAl64lT2bHmzSxoOvkoXZIzx4uG11
         w3l4zDFOlGc8JdbWb+2Nc6g8rGj63hCayJm23zHRqXQE0RKnCqMdoxOT1M6kwXlfps0K
         BJJNrNquziakR28meIUcTt27AyT4zEeeOgMM23SBpwRKD1G7FB77oUUe3GzNNRmiC6Zg
         yt5f6SNG8kM3c60oR6IhRPl1JYmpBgiWZRrb53bQu4TLVrQwJEqwkBZn8LG6j/apZ8/N
         DNgw==
X-Forwarded-Encrypted: i=1; AFNElJ+JxrFbB9UTd/OX+GmBwmHmaQrEQdtS+4yTfFH9MPfdoBJcWHSu726AOf2coYQQBFmQS7Xr9pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kleK+eJH7gEsRh1EAjDhHEYWr9tFbVxJ9XiXmxNvWT+wNLzC
	s+FoQHaB4VXUk8hXhcnGMmy3YyRF2aTTn9awCmGykC+3k/vH/61ZlB3rItMXElRi9grMjn2dqj4
	gmVyXNLJ35gJ6+OxghxptaoHzyhXld5JM22W5n4Rjl25RdA+tZNylEjyPzQ==
X-Gm-Gg: AeBDieuOiDuqWJYOf4zlHX53b0pG8CMd/a8FH7h/F3+a3ttRGO+XWLBSonge4t5mb8s
	YkbGoebp2r+snWG3QmA4OBm6y3NMOr8umxIAEEwL69FUsmOPJ0fJgWeM+VLFd5qO0FEK3E6yY+4
	IgutvAy1v94Oo/NBz436FJBApIiFyZwBkqty1yV/BnmFHRDZ3/X2mcchfix1F7yDGJCmlaJkhrQ
	tpqxiKCj0U37fTzb8u8PSWiXArH6IXaeJH1mb3PJc4HI9GGw9Tl/EeC9dUa6bbFuwQDX/t+nRjX
	HArJKlb9j+vGv1bRHi4p4cZP8vJhCQDAecpGZhnBUXj8SVlB+RkYPmEJL/SrG/cruqlsGkTsNXe
	Ozqr2xQ7B4gmtIwzflOWB/lJwDmjdT+czzoVWhn+nryBdSvBNW7d8rylvq5JOIqQ=
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr74268765e9.5.1778169913204;
        Thu, 07 May 2026 09:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr74268215e9.5.1778169912467;
        Thu, 07 May 2026 09:05:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm145700815e9.5.2026.05.07.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:05:11 -0700 (PDT)
Date: Thu, 7 May 2026 18:05:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afyy9CeniTBF3o2I@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507073340.0604667d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260507073340.0604667d@kernel.org>
X-Rspamd-Queue-Id: 8FA334EBEFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,salutedevices.com,meta.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285421-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
>On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
>> >well if you want to support pathological cases such as 1 byte messages
>> >that would mean like 100x reduction no?
>>
>> Yep, but since this patch is already merged, IMHO that is better than
>> losing data in those pathological cases.
>
>We can revert if you think that the risk of regression is high..
>Please LMK soon, we can do it before patch reaches Linus.
>

Some tests in tools/testing/vsock/vsock_test.c are failing with this 
patch applied.

Test 18 are failing sometime in this way (I guess because we are 
dropping packets):

18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

Test 22 is failing 100% in this way:

22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed: 
Resource temporarily unavailable


With my followup patch adding also advertisement to the other peer 
(still draft locally, waiting for Michael proposal) I saw 22 failing, 
because tests expects that can use the entire buf_alloc, but now we are 
reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and 
double the buffer size, or at least digest an overhead equal to the 
buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah, 
AF_VSOCK has it owns sockopt since the beginning :-().

With that approach tests are passing, but I'd like to stress a bit more 
that patch. I'll send it tomorrow as fixup of this patch, or if you 
prefer to revert, I'll send as standalone.

Thanks,
Stefano


