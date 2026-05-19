Return-Path: <netdev+bounces-289359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDCIMqgwDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:43:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7357B7C9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188CA30A9FD9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9B428495;
	Tue, 19 May 2026 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJyLJjm4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVFT91K/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0B421EEE
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183381; cv=none; b=UcqFX9un/oBteT+4Ps7fFW9ZgQCbiswbAp9hEwpsAN24pFcg67aRFK6iZRLTJnnAXdUmiROIid1ASsmOaIAJIaNHDz/VEI92A26Kg5OW/IXFNzDqWBYLldPlYP0TSxJp+D0L8Gc5yGekJZHtdQ2u9asuZEzACakZx8dgq8jeAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183381; c=relaxed/simple;
	bh=iTxsJxAr/FOzDabg6fAhhdzq5XWXfyV2NneHC6h5vAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y54SQ44eKtLhZSFiUCRgBQVN03ZEgtL9bZ2PNSbAFB65VNyShmOk447LkTOutCg/GfjXXxH5k5WDZl/555del+Ui1UxzBfwQ6BKASX/ZA6+lEIbAG56dTH/ZsiIRemqi5ii3PR8cEax7mWFQRqe34WwoMWeG2pbiFqZ53UcfqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJyLJjm4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVFT91K/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uul1ADh4nKHpxPod9aowoWLoDn8Jx6PN3i3WQIGWzk=;
	b=MJyLJjm4v7B2wIUmPBP3E6XWlhtizghgDGUQ7D3+6+BnjVZYygydnajJqscrCUwDBgsAfb
	kM14wqr97WNez0Ywi6eehVGu7Z8VaDkeEiwzMf3ji2pC7i5rvNbC+lJy3VaPDFv2hPkKPF
	wN7OEh2lCCAzUVihXoVTcPuw/cB/0Fc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-XcU6r8KPMkK8w8_rJSaq1Q-1; Tue, 19 May 2026 05:36:15 -0400
X-MC-Unique: XcU6r8KPMkK8w8_rJSaq1Q-1
X-Mimecast-MFC-AGG-ID: XcU6r8KPMkK8w8_rJSaq1Q_1779183374
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48feb8b9acfso19914435e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779183374; x=1779788174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uul1ADh4nKHpxPod9aowoWLoDn8Jx6PN3i3WQIGWzk=;
        b=IVFT91K//TRcxwv1P0KnlS5cNH/LJ9JDFcD4BW46exnU8rTSJ2k2DBUCkPcMwFeMBF
         x3NSWgelGflW1RsLgZPIVT1jJJtaGN7MfsTBnkQNlZCEP76dLpGCJQD5LyCtJAuqUyS4
         7AVQG8rDRTTEQvSdbg1gb2TrPsRodN88iB1KXyLZ4ih45DaYlkOXXJTXXJ8ClUSxv5aW
         YpkAPL7qfpudjt5rW6ymYSjPxzBWTmxJjh2kJUhtQMuBDpC0jd7v/STcWnqaMxvcnGp0
         IbeXC+4TjShs9DbRdgzuqBgAJ/u9caH5n2aEDNsOuM1Cilk9LVesTsNQ/OYS8zU+iNaL
         82Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183374; x=1779788174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uul1ADh4nKHpxPod9aowoWLoDn8Jx6PN3i3WQIGWzk=;
        b=eNdoUOg8U1k5KXsXxQg37PZxuEgeMO64I4mg41jb6i+dFxRIX7650J/WvFuPkj8LMB
         40Tpk/3xhFe8AmTjiDN7y9HSl5qFRAoZViSusS2WYuU+r/h/uxFCa0U36H+AMyFevcx/
         i9HX/z7VGJJQmvB7SuuY10Vzj/I12LADfHr+PMPVssjzmFgA6WHOCHrqKAY3YeiWsa8i
         d/Jxj9gdUSwmsWu6FKiY3p/0sgp7JcBufNth1tqOp9IRTl3QROtNO40U/gP/NqQjhgh1
         978iAZd/lz7yUsp5ZQuu1cgnXovKoQHLVc3MGGEPcagTFjXy1GkEtcanZ/Fl34YZeJ0s
         mVRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rbQL5+jrTV3nvSlXnjoCVFN2Dr90BB4cqfa4z+yClLSjEsSbx8PtEGquZgOm4ItU813gGfz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoQRIUzqXp3VTN87FstR9LVG1uh+YA07bMmMtZCrx1Ql2byw6
	iSs1PKGiPhB1dlMfvCLLPXJY2Aq3WaU008+oOpufFhe+PEWQig7i1O75IPlveQIOmP07mJj16HZ
	8QlhfTjxkmV06LNtpxvQwk1PjHE1lRuEMpN2Vbb+PR75vXlzoIKtXtE45JA==
X-Gm-Gg: Acq92OEj7HeZHQm2mTGv/Gob5SImST8QYzDZ2TkWmKAeJ+s7bUEv1SycUSe7jFSfhyO
	H1jmxREXLheI6f037T5rdd9QuNdbIQmeCPhVCAxgJteQScKOEIX7ewFN17JN+Wpk9KAi2bd0e7I
	ytnD+RlZLPrv2LRep5J4SVNzwgxzrVLoNG514UCVozRB+MALN/sCrLR0RMR8Ek0FS+qBWBtBbgj
	LXoD+HP1c+hMChwSrGWq0qWB8ceb6kS6eSa2NPj9Gx66mgm6jrSRr4z7z8Lp2b6A/vfZbpHam57
	eIbXVX4LwPZAK47A+elx9WXhfJSIxqav9pGkMzLq32iCQUG8uJzGxJ1R+l6/ek8uNzIBMFvLlrm
	sQNpZ4/C2e2HFA1mRKCzpKSLC08oGerkUaAr/kZ7EORsyo30kLySVSJ7lEy97tUmNg5BbPHLQcg
	==
X-Received: by 2002:a05:600c:848c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48fe60e3c3fmr285046655e9.1.1779183373864;
        Tue, 19 May 2026 02:36:13 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48fe60e3c3fmr285046015e9.1.1779183373393;
        Tue, 19 May 2026 02:36:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm298640545e9.12.2026.05.19.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:36:12 -0700 (PDT)
Date: Tue, 19 May 2026 11:36:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: ziyu zhang <ziyuzhang201@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com, zhenghaoran154@gmail.com, 
	hanguidong02@gmail.com, zzzccc427@gmail.com
Subject: Re: [PATCH net] vsock: keep poll shutdown state consistent
Message-ID: <agwugKMrTsNxQ2BD@sgarzare-redhat>
References: <20260516034745.260442-1-ziyuzhang201@gmail.com>
 <agrldIdftDXvATYx@sgarzare-redhat>
 <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289359-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vmware.com,lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DD7357B7C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:39:37PM +0800, ziyu zhang wrote:
>On Mon, 18 May 2026 at 18:16, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
>> >vsock_poll() reads vsk->peer_shutdown before taking the socket
>> >lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
>> >lock to report EOF readability. A shutdown packet can update
>> >peer_shutdown while poll is waiting for the lock, so one poll invocation
>> >can report EPOLLIN without the corresponding HUP/RDHUP bits.
>> >
>> >Keep non-connectible sockets on a single lockless READ_ONCE()
>>
>> Should this be paired with WRITE_ONCE() on writers?
>
>Yes, since the poll path uses lockless READ_ONCE() snapshots of
>peer_shutdown, the writer side should be annotated with WRITE_ONCE() as
>well. I will add that in v2.
>
>>
>> >snapshot. For connectible sockets, defer shutdown-derived poll bits
>> >until after lock_sock() and use one READ_ONCE() snapshot for both EOF
>> >readability and HUP/RDHUP. This preserves shutdowns that arrive before
>> >the lock is acquired and keeps all peer-shutdown-derived bits consistent
>> >for a poll pass.
>> >
>> >Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>> >Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
>> > 1 file changed, 26 insertions(+), 14 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index adcba1b7b..bed42347b 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
>> >       return err;
>> > }
>> >
>> >+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
>> >+{
>> >+      __poll_t mask = 0;
>> >+
>> >+      /* INET sockets treat local write shutdown and peer write shutdown as a
>> >+       * case of EPOLLHUP set.
>> >+       */
>> >+      if (sk->sk_shutdown == SHUTDOWN_MASK ||
>> >+          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>> >+           (peer_shutdown & SEND_SHUTDOWN)))
>> >+              mask |= EPOLLHUP;
>> >+
>> >+      if (sk->sk_shutdown & RCV_SHUTDOWN ||
>> >+          peer_shutdown & SEND_SHUTDOWN)
>> >+              mask |= EPOLLRDHUP;
>> >+
>> >+      return mask;
>> >+}
>> >+
>> > static __poll_t vsock_poll(struct file *file, struct socket *sock,
>> >                              poll_table *wait)
>> > {
>> >@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
>> >               /* Signify that there has been an error on this socket. */
>> >               mask |= EPOLLERR;
>> >
>> >-      /* INET sockets treat local write shutdown and peer write shutdown as a
>> >-       * case of EPOLLHUP set.
>> >-       */
>> >-      if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
>> >-          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>> >-           (vsk->peer_shutdown & SEND_SHUTDOWN))) {
>> >-              mask |= EPOLLHUP;
>> >-      }
>> >-
>> >-      if (sk->sk_shutdown & RCV_SHUTDOWN ||
>> >-          vsk->peer_shutdown & SEND_SHUTDOWN) {
>> >-              mask |= EPOLLRDHUP;
>> >-      }
>> >+      if (!sock_type_connectible(sk->sk_type))
>> >+              mask |= vsock_poll_shutdown(sk,
>> >+                                          READ_ONCE(vsk->peer_shutdown));
>>
>> Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?
>>
>> Not a strong opinion about that, but in any case IMO we should add a
>> comment here to explain why we are doing only for not connectible
>> sockets.
>>
>> That said, if we use WRITE_ONCE in the writers, do we really need to
>> move this after the lock_sock for the connectable ones?
>
>Yes, I will move the non-connectible handling into the SOCK_DGRAM branch
>and add a comment there.
>
>For connectible sockets, my current understanding is that
>READ_ONCE()/WRITE_ONCE() make the individual lockless accesses explicit, but
>they do not make two separate reads in one vsock_poll() invocation observe the
>same peer_shutdown value. So I still think using one peer_shutdown snapshot
>after lock_sock() is useful for keeping the returned mask internally
>consistent. Please let me know if you think WRITE_ONCE() is enough for this
>case.

What will be the issue of "do not make two separate reads in one 
vsock_poll() invocation observe the same peer_shutdown value." ?

In any case, I'm not against it; I just want to understand the issue 
better.

Thanks,
Stefano


