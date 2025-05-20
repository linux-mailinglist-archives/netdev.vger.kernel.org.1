Return-Path: <netdev+bounces-191772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA27ABD2A6
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7723B8D08
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CA25DD18;
	Tue, 20 May 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hY9CsTLd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B52673AA
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731720; cv=none; b=TlUDReq2Hw8AsdI6O1fm0GlECCLCXEk+u3lkSVbAbpVdyVpg94cvjhF1TUQCnlSJilxd1J3rHuPHP+CIlEVVeYl+mbQwuBWe/NlNhWDLt3KyZwKgXGMuNTdgT08So60SmfEbcsDKWJS+6aksiKodmXnEaQYpBSrB6ogM24qPw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731720; c=relaxed/simple;
	bh=f4PFfUo3CVYvxjRWKlbGvRUOQy86q4nrR07UPkeiNIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D67IVPVFrB+Vw/7ypWBKp3ACfHep2y+rDxX0eBcNUBInatcoAeyjdJumq2qagQtM0/x9d4XDvnRaXoeTUGwqIJzIV5PZi1pUYyjRmwz9HDkQQ9HlMPmGIyNtUXQW0LfcvZIQ7vYly+ljERx4iQemgrkLZx9bw+0vZ/VnGjIHIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hY9CsTLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747731717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4PFfUo3CVYvxjRWKlbGvRUOQy86q4nrR07UPkeiNIk=;
	b=hY9CsTLdgCRKHtt3kIy5YBHzdOSYKKoOngqZ2PjJCE1bJOGitdn9dOGfcl4tg6Y/OXAelu
	3+D1kiuYNZ5f2i6WtkupkfYomEO/hzZU+4hgkptenOB4CBxnYjKf+WF9kbD4bQxQCfrK5e
	iJJl7wO5mUr0mFhWQo1VuCswgk7RtSQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kQe-YmxeNP2wetfogSum1w-1; Tue, 20 May 2025 05:01:49 -0400
X-MC-Unique: kQe-YmxeNP2wetfogSum1w-1
X-Mimecast-MFC-AGG-ID: kQe-YmxeNP2wetfogSum1w_1747731708
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70de25bb419so8058767b3.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 02:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731708; x=1748336508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4PFfUo3CVYvxjRWKlbGvRUOQy86q4nrR07UPkeiNIk=;
        b=naf2WdWjGMEfMIiJJD3ofsJc17BAl18GnY4ByOlm32IRuXre2NkoE+sBgHAkRrYLtn
         zsKkHxJcMSdxTu6kjuS+7ggLQbsGHpXWe6tDgs/c6ns20KhyVOQsIv+SJg9o1NXYKQQY
         ShDdxAZ02jkhJl5WdO1ZxfNWdrA7U26CouHVeXctxw+8tDNPGOvw6szpJ9b2zMl0m9xJ
         40cL8NdQ9hlca9VuGl+XUHuBOXb88JfQjBcOK3iSla12F9iZKJZWtib4twqTHeOSeWaU
         SLpm6uVa5NrICMyHMbLbMDKcAZkOKlMY7yuT+E6lXzBCua1U3KyUqYrbVvuVwdPN4LlI
         7nVw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ccpDDynlvDR/EqUd2FUXOPjBpndBVU5KTQNF7A9emE6cnYv4HNmQtsSDcoKyXaBr0dfVoNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMD7Fw+tPhhiH8Nd2jHdX6U0TIHUVUSbt1l6NoM8t1kuOlpmY
	neWZL1Nb4CviecrWnpkxoUln8LsWWftcLg5Phr8WlbdrRQV50DA2zYZJ3M/FO3pL6YkLY4PRBEl
	3OaBmkX+7NXpf3JaW0HP+y2hgrOHCSTh7F63khkOzJ+RuJq56mhJr65ueRhRL/VnBVsh927VnDU
	f8h38RVN4eOG/OmAJAQ5NCNe8ydI/w2N3t
X-Gm-Gg: ASbGncsTV0LpmUA7Tu3UkJok1M0Xec/Vc/5zeAxmFoG3mnxpDH3n085+CcbzE96+Csi
	+kZMFM86Ow/s2tUKoYgoSRPS2EmAoaGwpIf7G9g9Q/EPu3e4lqrtyhfjkHYmNxXrKw50=
X-Received: by 2002:a05:690c:6f03:b0:700:a988:59dc with SMTP id 00721157ae682-70ca7babbb1mr240865967b3.31.1747731707604;
        Tue, 20 May 2025 02:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3XkPTDHC2bT/+30vHIfK94LVFwuyNrNbVOqdnshE4e5m8CfpmTKyeL6GG9M8oi09my2f4OCE0WTxgWx8PWBs=
X-Received: by 2002:a05:690c:6f03:b0:700:a988:59dc with SMTP id
 00721157ae682-70ca7babbb1mr240865377b3.31.1747731707035; Tue, 20 May 2025
 02:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
 <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
 <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co> <CAGxU2F77OT5_Pd6EUF1QcvPDC38e-nuhfwKmPSTau262Eey5vQ@mail.gmail.com>
 <720f6986-8b32-4d00-b309-66a6f0c1ca40@rbox.co> <37c5ymzjhr3pivvx6sygsdqmrr72solzqltwhcsiyvvc3iagiy@3vc3rbxrbcab>
In-Reply-To: <37c5ymzjhr3pivvx6sygsdqmrr72solzqltwhcsiyvvc3iagiy@3vc3rbxrbcab>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 20 May 2025 11:01:35 +0200
X-Gm-Features: AX0GCFvwufUSjICCevkhSa4UF6ys3CpGsz9VU3OXC4m_4xblOUg6kg956W_4nJw
Message-ID: <CAGxU2F4ue9UxZd1_wB2D=Oww6W9r7kTBPVjjbnm24Lywz+0wSA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 10:54, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, May 12, 2025 at 02:23:12PM +0200, Michal Luczaj wrote:
> >On 5/7/25 10:26, Stefano Garzarella wrote:
> >> On Wed, 7 May 2025 at 00:47, Michal Luczaj <mhal@rbox.co> wrote:
> >>>
> >>> On 5/6/25 11:46, Stefano Garzarella wrote:
> >>>> On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>>>>
> >>>>> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >>>>>> There was an issue with SO_LINGER: instead of blocking until all queued
> >>>>>> messages for the socket have been successfully sent (or the linger timeout
> >>>>>> has been reached), close() would block until packets were handled by the
> >>>>>> peer.
> >>>>>
> >>>>> This is a new behaviour that only new kernels will follow, so I think
> >>>>> it is better to add a new test instead of extending a pre-existing test
> >>>>> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
> >>>>>
> >>>>> The old test should continue to check the null-ptr-deref also for old
> >>>>> kernels, while the new test will check the new behaviour, so we can skip
> >>>>> the new test while testing an old kernel.
> >>>
> >>> Right, I'll split it.
> >>>
> >>>> I also saw that we don't have any test to verify that actually the
> >>>> lingering is working, should we add it since we are touching it?
> >>>
> >>> Yeah, I agree we should. Do you have any suggestion how this could be done
> >>> reliably?
> >>
> >> Can we play with SO_VM_SOCKETS_BUFFER_SIZE like in credit-update tests?
> >>
> >> One peer can set it (e.g. to 1k), accept the connection, but without
> >> read anything. The other peer can set the linger timeout, send more
> >> bytes than the buffer size set by the receiver.
> >> At this point the extra bytes should stay on the sender socket buffer,
> >> so we can do the close() and it should time out, and we can check if
> >> it happens.
> >>
> >> WDYT?
> >
> >Haven't we discussed this approach in [1]? I've reported that I can't make
>
> Sorry, I forgot. What was the conclusion? Why this can't work?
>
> >it work. But maybe I'm misunderstanding something, please see the code
> >below.
>
> What I should check in the code below?

Okay, I see the send() is blocking (please next time explain better
the issue, etc.)

I don't want to block this series, so feel free to investigate that
later if we have a way to test it. If I'll find some time, I'll try to
check if we have a way.

Thanks,
Stefano


