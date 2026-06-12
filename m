Return-Path: <netdev+bounces-298585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OTWMwLkK2qhHAQAu9opvQ
	(envelope-from <netdev+bounces-298585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:48:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456E678C92
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:48:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bqho1Wgg;
	dkim=pass header.d=redhat.com header.s=google header.b="Jp1/zmKZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298585-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0EB314A718
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CC347505;
	Fri, 12 Jun 2026 10:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44926CE2D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:48:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261306; cv=none; b=m+279uMeAFh4PGdBx0tu+edKMsmnqQChbsqva+Gy8luvpmP7FASsm6iIh8ZA3aDcPb0TCtmldNK0D91Z6InqoKMmmXZt/W1l8NzQ+Aodb5IGtZ1qlbqQoVIfabb4gWseZm5hMC+MrJl2780fLNpHzKYN907xU3ioAXGN1Xmdo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261306; c=relaxed/simple;
	bh=nIUd4dRQc7lninJ4PQurm9K8z6iyF8PSKyxa+RhCCws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGB5jeZNVgZZ3a3KG7tGY8ImtkHqERILGsUFX58Io8Z+KsNLsW9+VJNkNw4gTZoLQvf04LugXb+5IXQ2rAz8+KQh24j8uOnJEwVqCnsQutOOXSxHIJPbOKla9tHA0DOolnCEQRbARflqHBezbuNcI2sYt9wbn1NzlLH+qPx5Nq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqho1Wgg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jp1/zmKZ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781261302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcVW7gr962xWbfB7rW7cz9KI0TlCsoEItlTo5USlTpY=;
	b=bqho1WggcJ/LqkzbzDIgarelTYW5avPKvNBF98mNw9uEf0UqBVke8XMhlPiFpRfddSTnz+
	5pp5Ol3DEGfvNHhP602ybOicrc5m3ecylbw3LnXSQqO6wtdMV8qjeOOsg/d6BP/hPjAGAV
	Q7uTU7P9ecLQjAQ7i7jVDc2DDp80KfE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-bRA_LrJzMu2u2BgTF1Y36g-1; Fri, 12 Jun 2026 06:48:21 -0400
X-MC-Unique: bRA_LrJzMu2u2BgTF1Y36g-1
X-Mimecast-MFC-AGG-ID: bRA_LrJzMu2u2BgTF1Y36g_1781261300
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a060eb84so6835595e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781261300; x=1781866100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcVW7gr962xWbfB7rW7cz9KI0TlCsoEItlTo5USlTpY=;
        b=Jp1/zmKZY/qwLH6+Bgny2B16arSvUD9kZGP1Fex1Swu04Xam9qW6wwWN9226nhZ04z
         apHZ15qBF0zm0nvO1XeNcDQdAul9MIdMn7AzJBkzpY5wuMLg2brOL9r4/hy5NBj/6KxM
         SkZ+b6ebBPMsElV2aH2R7YpHcOUCyHH8b8K2QhgL1buZAUqGlHzd8mApdGIeDceaNHHQ
         hJKX9Hkvld3xbzs1Y/ijKwEUc46CLkJsDmWTsi6ptoCj3f2WCjK+m+HFT1m7ArxtjpcJ
         nHpDoH36o0K+Rkq7S62ADd6hJVl+gy6u7WqL0NcgZX81juPijEk3eTjvxNht2pzWXA60
         Fr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261300; x=1781866100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcVW7gr962xWbfB7rW7cz9KI0TlCsoEItlTo5USlTpY=;
        b=Fu84fulDRnkQwUcXgkOIhFhKN3+I126QwODcmuKIKVDQ0yF16ebwfREc2wIGV65ODi
         M5JL18X+yLfbNOfKY6lT82r4ng7wq2ey1OVicr+kqH362nMuFdVU52FAxp7HB5Qj/qoe
         kht7Ovy92eLc3wff5y2srTsMXii5iL8WWfPr87bE/NoC1mYT0ygVDZ69yimB+A6ZMtIe
         NSMofMybo0RsDinIPUSmUTfm6DJvpaJLcA7Zl8gxRS6/wGVN1UXq4oHVC1JIKKvy3q56
         qZCQifQpYQQoVJR93aGDG0BaxSDeV0Falb2dF1nVr36bYPN9P6CKjDWO23UXSQDWMi77
         wMww==
X-Gm-Message-State: AOJu0Yy4YWvyWeOdF44W4t/hElKeTPhmu81vggVo7YPu+gJgLAHRon40
	7SI7rIkPNMECtCfnFsxIHTLjtQoXH7hHya6Oe0wwa2wv6wcFaTbH9DB6Dvfp3nzAP4Y+lIjKIV5
	aPammS/LPzq+YSSoXnB+qDPgYprqQm7IphPmod6o+hYYNl2CqdN1ijpCRPw==
X-Gm-Gg: Acq92OFe89sTC8kRGHXHu060jm5oZwWCHoQ5yr0wMpytQkuIL5FH6BdI7+Tcb8KZop4
	1QX4rgOw5yH8X1cmfK/fHzu2Polm73Uqj0Kr5lIZxPYTVWj9IcUWl1I71jTzoaWUt8MObdE3IT6
	yGANK+QSyGSzdZhCeaQ2muh8gBmyxOqbOvKRJqrZ90WZ/kp/ZkIQ4W5j2eNSbPB/GfnafKasJ5q
	fH8qb7araAQB4I6pbrk8jDyn1DyEPotn2JFhQr9WNdK1sTn1jIkLkdpdqLY108CryaX6qgtGsvf
	O+PVFHU0S5CscamZZQxEjfc85FRuGmXAZDMKieZGPtqAtbzL2gV5nLTyzRPsSPaOStJpaPKU6Ai
	+X9g09eOx273e8Qrgg0xAwSf2JZtFZ4houFiEbYOj4bfyABhvXcwt/ZQldXWPKtqfCL1xBTo=
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-490ec4d4f7cmr30973025e9.9.1781261300412;
        Fri, 12 Jun 2026 03:48:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-490ec4d4f7cmr30972435e9.9.1781261299894;
        Fri, 12 Jun 2026 03:48:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d046d5sm137445175e9.13.2026.06.12.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:48:19 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:48:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aivjf4TZU4Q_s20y@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-5-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-5-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sgarzare-redhat:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2456E678C92

On Fri, Jun 12, 2026 at 04:52:16AM +0000, Raf Dickson wrote:
>Callers of vsock_remove_pending() must also call sk_acceptq_removed()
>to keep sk_ack_backlog consistent. Move the call into
>vsock_remove_pending() itself to make it automatic and prevent future
>callers from forgetting it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c       | 2 +-
> net/vmw_vsock/vmci_transport.c | 4 +---
> 2 files changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 24916dd4e9..4a7d6d247a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -494,6 +494,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
> 	list_del_init(&vpending->pending_links);
> 	sock_put(listener);
> 	sock_put(pending);
>+	sk_acceptq_removed(listener);
> }
> EXPORT_SYMBOL_GPL(vsock_remove_pending);
>
>@@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>
     ^^
There is an extra blank line that we can now remove here.

BTW, the code LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>-		sk_acceptq_removed(listener);
> 	} else if (!vsk->rejected) {
> 		/* We are not on the pending list and accept() did not reject
> 		 * us, so we must have been accepted by our user process.  We
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index c2db016cca..3e6445f4e1 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -980,10 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 			err = -EINVAL;
> 		}
>
>-		if (err < 0) {
>+		if (err < 0)
> 			vsock_remove_pending(sk, pending);
>-			sk_acceptq_removed(sk);
>-		}
>
> 		release_sock(pending);
> 		vmci_transport_release_pending(pending);
>-- 
>2.54.0
>


