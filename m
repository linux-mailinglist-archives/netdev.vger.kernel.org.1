Return-Path: <netdev+bounces-274511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ8aOTtdzmnvnAYAu9opvQ
	(envelope-from <netdev+bounces-274511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD75388E48
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CA0E3044B43
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245A03DCDA6;
	Thu,  2 Apr 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F15lLYHd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh20RAxq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D193DD51F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131392; cv=none; b=Jza9ppujP4SusuoturDI4XRc6yRzj6A+MPb7iJBdXCKNOrr2CLXbQdfmXAqFpp8vJ9uVZuNZi4KbrocInolIELasq5xmTjgHrqmhENOpKEc0pJmuk0ZY90b7W+BRAgfQU8JfYsPLFJldDb6iu7WJ9M6vXN5jrzG20Qjpm7BgynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131392; c=relaxed/simple;
	bh=fomV+dLqeGgoLHM89BIl0h+eUKeo11/8svGhhNAX9fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGR63Su9R5t6O7JMbGvAh9NhAVX+WLX9z+pw01qL+zm5+VvQIjYvHhie7aNJl0QFo2QugdATsR+mWQYejNOBs5qdxB3G8fKv1lqVrbskq1uxtpxotnRjrhsQskkeusZFFU3HwXtn64wyj+EVaHZi6+0wvUwqrVToKSkXFexGCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F15lLYHd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh20RAxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775131385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31cBQ4GFBHgCy9kgeze7QNmzRd+J2y9VlWwIz+Jz0mc=;
	b=F15lLYHd7JpyhSMxvfyRno6i3s1xw9KIDTHyDKnvd1CTPx9/+ZATcW5rR6Y5QnPmqBhlMR
	PilBSTwXeaDMuwPe49ox8gwG5fpnqrvSPLDWdTZNoDJ6ydH+rFX+AnV805WElWWdyWl/Ns
	Ka+V9uURkDZrh6CCrRrhrTkxHurcXrM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-X6WwdLjzOLG4-HN6uI9GWg-1; Thu, 02 Apr 2026 08:03:04 -0400
X-MC-Unique: X6WwdLjzOLG4-HN6uI9GWg-1
X-Mimecast-MFC-AGG-ID: X6WwdLjzOLG4-HN6uI9GWg_1775131383
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4887f516cf5so4908625e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775131383; x=1775736183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31cBQ4GFBHgCy9kgeze7QNmzRd+J2y9VlWwIz+Jz0mc=;
        b=Gh20RAxqmWsizmtYtoPEDxSxCrB5y5zBXg9cFJlX2AQhMemDMvud4H4u4dkVDejXgt
         DzXyXhZbJbAoAV9opbX/Njfg+GwrYHCTYQs0FBzeaeoFRB/YRs8Sriypcc5h+vm9Ajq8
         lbCgo66XuNKewgn18nN8X4CZJXnvVRugMB+scIG0K0P1/m36kIZHF3JMsHpXTUELNjdk
         j5/HIp6DCxeV0jSv2etK1h4ubj2vb8Z+91VUaOIG2OnCrsXRlUCso5g637Pgkb9W5ogp
         WMC/eeDkeR7VW9MNhYkTx/y+eA3ZkHiwuaPKqlIXaxPz3OwECyrO94rLe1CwjjyNLBIg
         OAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131383; x=1775736183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31cBQ4GFBHgCy9kgeze7QNmzRd+J2y9VlWwIz+Jz0mc=;
        b=S7pzCNDu/UKBhd7/8Je4PiC2F5rv0l21LsnPDq8RINgZAkc6t3RwIHTBC2dEcQMvDS
         YhPowWrviOT/d+OZ68RSUzu699hX5Phc9HYhRvKJK4zf2ZFRvZ3ruHQT6UfNNY7loU5Q
         Cz3RLTqP4JcjlOJfLyC8g6an5vAPzMnev+FdVNPCedbrwzC/OGPwWpd8gvdEzB6H+yWg
         YWlSDUlf3eEUTLUjM7b0WwIDKBixSoW9ahAlS89v2AfiyGOvzm2pO7f3a2Q5JQRdS9rw
         HSQOmNepbsxIxBjVdhZLoOxBDbSg92ilc2pj048pzUHbsqtctIwzfQ7BUjJ0xQQbX6Ux
         L4IA==
X-Forwarded-Encrypted: i=1; AJvYcCUBxQPyC4kJy/wvc8GcOLRre+Om5wcz/hEHACHbXpZXoMoc5duEgT7tK18a/xlT5bxLSCObFUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYpi6qPptGJJKaMCnH49lDTpU5bpHdZSFP4uuR1fgy0I3Ab6Q
	E+ANYXEIv21BTrkP+9RI87sziK4I1AxpEYYzMN75ww31cuqkFeZ6lmJq5uw4AfazZYhkqplaAJD
	b18UVjS3tuewFWODsUXUZBr8vIyMoDSEq5x7s5U0o9blXZqhSqT7x0zsjJA==
X-Gm-Gg: ATEYQzxp+CdSOdEkuUF5bM7uNVPteujHcC5qmIecz8Mw7HQu5gutC55bJ6I3TAXjWNf
	uUn6o9BUVwy5tfQC9c0/0HlZ3rvZxLxzzQAlk0lm4qs2Joshk5OhbxU0GRGYYlqqJxtZ6naTM57
	Rva4PK8gzAMzHL2Eix+r59QkwUTdSqEKhwQ63UmR2FUFuoW612I/KiYoPKzBiKn7lTpKbX0iZsh
	pIcTedszC4AvuNbW0a3gKSCRAt+RbpoLo5AaaWFKck7g7fWBXQkQkynZC2ZG8OP7ttYxjcb86Sf
	q1PMWRgmjQcjvzogGJZM2zqMqtn1urXB+rkmj9r9IRA+UoRa/OSzmJyRTJu7PsV8FHfklV7Uvvl
	IFJfeF2kAYrC6qpgaXMCp6SGty7RPp2vyE4AzNM6Slh6tPrVnECpTt1jHOD2yvpP0C8RhWtXwce
	Js
X-Received: by 2002:a05:600c:a00f:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-4888b7c2d90mr53165055e9.30.1775131382829;
        Thu, 02 Apr 2026 05:03:02 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-4888b7c2d90mr53158705e9.30.1775131378094;
        Thu, 02 Apr 2026 05:02:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm154893345e9.9.2026.04.02.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:02:57 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:02:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with
 empty backlog
Message-ID: <ac47PYPeL0IyRtY6@sgarzare-redhat>
References: <20260402044637.73531-1-laurencerowe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260402044637.73531-1-laurencerowe@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274511-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CD75388E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 09:46:37PM -0700, Laurence Rowe wrote:
>A common pattern in epoll network servers is to eagerly accept all
>pending connections from the non-blocking listening socket after
>epoll_wait indicates the socket is ready by calling accept in a loop
>until EAGAIN is returned indicating that the backlog is empty.
>
>Scheduling a timeout for a non-blocking accept with an empty backlog
>meant AF_VSOCK sockets used by epoll network servers incurred hundreds
>of microseconds of additional latency per accept loop compared to
>AF_INET or AF_UNIX sockets.

Not related to this patch, but should we do something similar (in 
another patch) also in vsock_connect() or doesn't matter since usually 
it's always blocking?

>
>Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
>---
>
>This fixes the observed issue for me:
>
>1. With loopback vsock on the host running Linux v6.19.10 built with
>config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.
>
>2. With Firecracker guests with current torvalds/master, v6.19.10, and
>amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
>CI and examples. (Firecracker guest vsocks are unix sockets on the host
>side so this fix works there with just a fixed guest kernel.)
>
>I struggled to build a generic 6.1.166 kernel that worked as a
>Firecracker guest but the patch applies (conflict due to change of
>`flags` to `arg->flags` in surrounding context) so I believe it should
>work for generic v6.1.166 kernel.
>
>Alternatively a minimal version of this fix is to just wrap the
>`schedule_timeout` in an `if (timeout != 0)` but that leaves an
>unnecessary additional `lock_sock` call.
>
>There are ftrace's and reproduction tools at:
>https://github.com/lrowe/linux-vsock-accept-timeout-investigation
>---
> net/vmw_vsock/af_vsock.c | 16 +++++++---------
> 1 file changed, 7 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682..483889b6d8 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	 * created upon connection establishment.
> 	 */
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>-	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0) {
>+	       listener->sk_err == 0 && timeout != 0) {
> 		release_sock(listener);
>+		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);

Is it okay to move prepare_to_wait() after `release_sock(listener)`?

I'm worried if we can miss any wakeup. BTW if this change is okay, we 
should document that at least in the commit description.

> 		timeout = schedule_timeout(timeout);
> 		finish_wait(sk)sleep(listener), &wait);
> 		lock_sock(listener);
>@@ -1862,17 +1862,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
> 			goto out;
>-		} else if (timeout == 0) {
>-			err = -EAGAIN;
>-			goto out;
> 		}
>-
>-		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> 	}
>-	finish_wait(sk_sleep(listener), &wait);
>
>-	if (listener->sk_err)
>+	if (listener->sk_err) {
> 		err = -listener->sk_err;
>+	} else if (timeout == 0 && connected == NULL) {

 From checkpatch:
CHECK: Comparison to NULL could be written "!connected"
#58: FILE: net/vmw_vsock/af_vsock.c:1870:
+	} else if (timeout == 0 && connected == NULL) {

>+		err = -EAGAIN;
>+		goto out;
>+	}

What about simplifying this with (not a strong opinion):

	} else if (connected == NULL) {
		err = -EAGAIN;
	}


Also 
https://patchwork.kernel.org/project/netdevbpf/patch/20260402044637.73531-1-laurencerowe@gmail.com/ 
suggests to specify a tree (net-next I think for this change) and be 
sure to CC other maintainers (scripts/get_maintainer.pl can help).

Thanks,
Stefano


