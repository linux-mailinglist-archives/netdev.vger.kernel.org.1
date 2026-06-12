Return-Path: <netdev+bounces-298542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1c3cOnzLK2qZFAQAu9opvQ
	(envelope-from <netdev+bounces-298542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C3678093
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:03:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LjtXiemF;
	dkim=pass header.d=redhat.com header.s=google header.b=On2sd2O6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298542-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59EC330DC27F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727C305684;
	Fri, 12 Jun 2026 09:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF61FC8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:03:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255019; cv=none; b=LHXEIlnbZMGWKm5ArDD3QdzT13x5T+19XlUvBgejOVwNNwMoctW2qyb9FTUyCw039zhzpoLy8Fm5qufQU88tjtnqz+GUfnjmw7xKJTQ8lQqkaeZcFBo2YafLRV7QvlQvjwvJGO9vbnvu+akwFY8iOrqdBgtHWMePB5bBycxWmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255019; c=relaxed/simple;
	bh=a533Q3FFH3yo2KCYqFz2PEDlL5vMphhfhil7WUq/Fp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE7QwJXMAuZuRIrlwJsanvLBSfkvOqoG6NBgJI4F1hRv2yAybqRbzIa/C0v4h4Q7h4/ygd6b2v/CSfIlBEuXx7V21KPXLRkLUoGw2GPyTCfeiyyNWYRnIn9NPuKzVAu628BVQoKjuEwdQfSTnRiVW49l8Q+AfILekZxjSsEvBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjtXiemF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=On2sd2O6; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781255017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfJ3aCD49y+MemH4pLy7wHKCQnfYLBost5pxkmr2d4M=;
	b=LjtXiemFcb6Mf7Fo/K+UCLrz3g7zG6gV+X2KqUxgryY3hyG4lDcidmZ5t0UxVsHwWwQGqA
	So6tJlsYa+lVdJPqaK1e4m9wbIGXbdWkw2CLIz5p5CbsGwx5kYOqd6CKar811r8wEeyyu3
	EQwppc/+jLHa1eUjtqQ2cAgUuHtOT6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-dBj57f8tPa2YQYgiKCdiOQ-1; Fri, 12 Jun 2026 05:03:35 -0400
X-MC-Unique: dBj57f8tPa2YQYgiKCdiOQ-1
X-Mimecast-MFC-AGG-ID: dBj57f8tPa2YQYgiKCdiOQ_1781255013
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460198535bcso468662f8f.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781255013; x=1781859813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfJ3aCD49y+MemH4pLy7wHKCQnfYLBost5pxkmr2d4M=;
        b=On2sd2O6wkKNDAK8229+jXEACsZfn9xw4Bvsy5cvOYG1qzmLW9T+hEARerO+Ja8O9e
         wcYbzMmkiJjj64HjTCjfFbOenZrKZ0PZaxOl7zCmqsipXQjXy3nQ4Kf97f25D3yZSJ7Z
         /2whMETgAZPI91y2WnaaBfxe+UmsHUodoeK1O2ehOEvn3JypL0rMTmV7lHQeVQ7pMVXq
         tL7WSwev85Pe7/Z53RdJZlhdUgPZTv6FqNDFiI3c/iOJTbD4qudUfJLspkY/vspUDCRD
         byjTpT4esraG2z8ApxZP3E/360psyJthmUYpJnNgLePdw/yPE/VEEPLtsIbDv7cF4/BA
         H2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255013; x=1781859813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfJ3aCD49y+MemH4pLy7wHKCQnfYLBost5pxkmr2d4M=;
        b=Z7nWKKCweVFVa9EeGozY7FDGdK2ore+T7fu2GasuR/ei0Vo6KM1gfVbMb+8PL2+mZ1
         XKK/bq9G+ao/mjO9mWnuaJ9LwTKUv6+atL/Rqqyl47DfRMRObE8TtYxMOQQUXdvr+Nu7
         iSZ6UYNc4aWl4FuNJUGY4pXqQ26cgo4jJbxbx03BdXWgoFo0+O8NupaUuuB2G7xksJJS
         IsocL/nM2ZxabiOjcNw38TOijxzqWuuc97w11tMlv8tYlwQY8BClCwUbeb/2qHoDWWKH
         OQoQ3beqKEdwH3ZCz87Y26y4MnQ29R2kSCHkKjaKmJlFyQTC8DNZw+KjcP8yhuz8zdKE
         M2wA==
X-Gm-Message-State: AOJu0YyKtZdeKAucevYq3bowi16EHQwFNDPcUDnRgjCpWHN0paJY0SMS
	RcytkwSw3HemEbUQwvRnEYtqEywWvHXhcZ/8hFwkekTfa5U48Zw37EUb7JK/ZoKkLMd0ETwpPjd
	DfwsAOMs8sRpO9hQLHf44JDm1Z/R3tC9fN40CS/aXB2UWASdo+2Jhvo840g==
X-Gm-Gg: Acq92OFehAWbClleRaHLnynRwRTypKgAFGxKrqdtuEU9KS7hlVUd9rmLdfFK0oWHsFP
	EE1FXDPXrh0hrwC8kZVXCXhORkkNLVBEVWCzQfLZzONjSH2INjlDDiQPdUYxhfuqtP1G5po4Kam
	cq+pfBxtYsRDmfe62ahwgYDKMIwYL/40HsgsLe9qV7joOz2Ox3d9W8fT6P1/mkUlHrlrYXjldyy
	Q8ScftxWJGvorU+5n0kP/0F1xC59eOp69g/VDKbvcnJVgptIwwUuBwqvEj9SuhXTBucyFdz0vWs
	WuEDosZQAY9N0Ik16PsyvSBxnBuLvMvpijg6GoWqT7FHEzUrQ2IgOwTiV5OQxwrMUOfsiSH1GaU
	/7XUgIEoWB8ZmQ/+KetHfsHNm2j5l8BClHKdXJAAIOIWX4zGIQ9QsNthAU33aS9hCLrImfCE=
X-Received: by 2002:a05:6000:4387:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4606db965f0mr3187067f8f.9.1781255012811;
        Fri, 12 Jun 2026 02:03:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4387:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4606db965f0mr3187011f8f.9.1781255012353;
        Fri, 12 Jun 2026 02:03:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f4f6sm4076902f8f.16.2026.06.12.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:03:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:03:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com, 
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aivKma8mRjTXV0BM@sgarzare-redhat>
References: <20260612045842.122207-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045842.122207-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298542-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 681C3678093

On Fri, Jun 12, 2026 at 04:58:42AM +0000, Raf Dickson wrote:

nit: title should be updated since now this is not just vmci
(e.g. vsock: use sk_acceptq_is_full() helper in all transports)

Not sure if it can be fixed while applying by netdev maintainers.
Wait a bit and in case this is not queued, resend with the title fixed.

>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/hyperv_transport.c | 2 +-
> net/vmw_vsock/vmci_transport.c   | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

That said, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index b3394946b2..e6adbc4701 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -323,7 +323,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 		goto out;
>
> 	if (conn_from_host) {
>-		if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog)
>+		if (sk_acceptq_is_full(sk))
> 			goto out;
>
> 		new = vsock_create_connected(sk);
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 91516488a7..56503bee31 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 	 * reset.  Otherwise we create and initialize a child socket and reply
> 	 * with a connection negotiation.
> 	 */
>-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
>+	if (sk_acceptq_is_full(sk)) {
> 		vmci_transport_reply_reset(pkt);
> 		return -ECONNREFUSED;
> 	}
>-- 
>2.54.0
>


