Return-Path: <netdev+bounces-281833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPgpAjmm8GlAWgEAu9opvQ
	(envelope-from <netdev+bounces-281833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C0484C1B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E3E3044B88
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78E40FDA1;
	Tue, 28 Apr 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB2bK3Gj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLeopdxU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9440F8F6
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378541; cv=none; b=HwHIFJE30ulDcYz5Rfo+HadK/IKwGgWzd0A4mqy2UxZwElFuZZyDbP9cLKLN6dE8hbqODDMYiXJdfwpiE4CyC/E1kL9QEarZtHchtzrWy2gRHMt2LxFh8AjFIXXUWb3E/TJceTqPKLsl5qkz4wOHehIO74UrYTnqYAnNBty21Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378541; c=relaxed/simple;
	bh=s59HQ/z0DRUQxzWAOS9RZKTQ0TksCpF9LL3RKo4XTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0MImiZ9i9IEzG7JvpMW7Grn/MJ69xukoqPJe0dB8qxUd+p+kCO8MsqAv7US3Zo5KygTFA4o1B4oY7duCK+KFN4hmZGi3C0TORCXkssJzruPMSEawx3dz/aTPRKzgjbeudT3Z4LlrcqrYSCD3ToP0qJvUj4sAVL2V4gLsiRj3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB2bK3Gj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLeopdxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777378536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
	b=MB2bK3GjFtxL1pdvdvlw/xFUPrvqZwi2rPSkNqIF+jCqv98FFNJKr6vWEMdnUCpx1Tkjcs
	ewFyz7hCJgetsiYiyG9gvI0fwp07Sgf2CJBa/CO538TanwjUz8mwJ23D5ime6Pjiy/g1yK
	prVn0n5ekcQF9Fbqe+v6B1BwbQd5KPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-3Cqcc5bfPKeM4SmT5fKBIA-1; Tue, 28 Apr 2026 08:15:35 -0400
X-MC-Unique: 3Cqcc5bfPKeM4SmT5fKBIA-1
X-Mimecast-MFC-AGG-ID: 3Cqcc5bfPKeM4SmT5fKBIA_1777378534
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso97179485e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777378534; x=1777983334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
        b=GLeopdxUQP8kG6kg2TMDGdLSiZmJWQc3gKk0HMlMceC2zjxyQjpu5JL6xXp4A1PJF/
         LRyOZiZu5/FFkCQD/QQQl4XIia7LQewUxwErFOeUHXI8AKMQA62jXrbGKsI2xGaiUK31
         ip3xwqjDYSg51O5xrWM59ChvrM81XxBYt5H2Tl5ZWj97ZZIOK/zmm1aQsBS819dfM7Fg
         YeYJbO3AL36NgAugH/gw+H4sE2XcUBC09CuvNXt/MWwRbilCCMQ8XwWxjxG5XShwRbem
         f2uPar3YK960GOXbosZM1+mP7HL6Y2xap5xtZ+oxreYCQEhFU0DNi7m0oXax6zpdnnOY
         fEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378534; x=1777983334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
        b=IYZwHwlul5nSeJfv3Cx1xrNGB/alLacRF3b0VeWhhndDV5zVCl5Z8DYNn4wB0tCjwL
         rE2g0McU+irfwKC+QVxbGcl0ow3ZSl8cUVRdkwsbC0+RWGIX5l/hP+3g1Cx1R5awvRF4
         WKzKbGPLjcnoApJhrxJRzv7YfHrWbUaLx7t2IXGQyfOe2ODGXksFxuB+M6O41r0mrprj
         szmDk3yw+xHf7+YwLZnIMu8BaMzUFD2eObY7oAbNdG4cytB5g+5G5MV7KaZbZ95hDibW
         O/sVfzdZROUcLEsXiWUYplM3i2a5SuCH3eXtbC+J/A6U0I5qQKSVPEbBAynG6lSijyBK
         dKjQ==
X-Gm-Message-State: AOJu0YxIm2P0eLOV3hEfGGaMCyQ7gzERGJaGrddhUdrF8ufj7TENzy9o
	yiC10EPXY9N/OhD/v1yFw/JYnx8zA23vkGBF+FZ6TVZ8gKNaUiCEyW2jmBaD7wG4WQicY9yxeFq
	wyPN+vdcRDqMAkWHVDw+DO03C/7yr2qKhPa5qGhKzSnizE7DbDq4m3d8qnQ==
X-Gm-Gg: AeBDiesUy+EQ9/1jZ6mwxX/SksvoixeIvlYZGnvemfgN2p7kThX5LLPA33zXTcIVxP8
	qjs5Ik13m74AuU5EOxCiOB+HEmfSfK6s8Q3X6xnmva0nDnjWTNl1N0duP55w7VRJQJhx3oCnNsN
	u92W5JYo3z01noIMKPVN0T7CaadLr80oEKvaDXxT+JqfpSskPfFQdtGuADriNq/Aj6e75rK29Su
	5SN9UvZf7tXuO4uIXZOLLNJSGUfsiZHrguvL9jr5dlvFG72PIdVvTrFMZZUqb6CqLY2vTLSxjps
	uX7Ek9bRU3wK34zT1s9Ka+jwx3kCuiZbKhp6tpBLP8Mmq/5HKNYPQKLjCo+TBASn5G6zs/JbyBI
	DcfSrAhtsXGHxy1mwASgKt9mEGqtuQDOh8kkGtL7DVQvq2LfZ4zw5s8mC+Cymk1YapCSfui5PWc
	CxeIlNdA==
X-Received: by 2002:a05:600c:83c3:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-48a77aee45amr48089525e9.6.1777378533926;
        Tue, 28 Apr 2026 05:15:33 -0700 (PDT)
X-Received: by 2002:a05:600c:83c3:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-48a77aee45amr48088625e9.6.1777378533314;
        Tue, 28 Apr 2026 05:15:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773a87bfsm64239235e9.2.2026.04.28.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:15:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:15:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@kernel.vger.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCjpGa4Xm4hIPj6@sgarzare-redhat>
References: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
X-Rspamd-Queue-Id: 736C0484C1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281833-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,lists.linux.dev,kernel.vger.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.org:email]

On Tue, Apr 28, 2026 at 07:05:30AM -0400, Hamza Mahfooz wrote:
>VMBUS ring buffers must be page aligned. Therefore, the current value of
>24K presents a challenge on ARM64 kernels (with 64K pages). So, use
>VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
>hold all of the relevant data.
>
>Cc: stable@kernel.vger.org

mmm, this is the first time I've seen this address used for stable. Even 
after searching in the log, I don't see anyone else who's used it.
Where did you get it from?

 From Documentation/process/stable-kernel-rules.rst :

   To have a patch you submit for mainline inclusion later automatically 
   picked up for stable trees, add this tag in the sign-off area::

     Cc: stable@vger.kernel.org


The patch LGTM.

Thanks,
Stefano

>Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
>Tested-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..40f09b23efa3 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 	} else {
> 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
> 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
>+		sndbuf = VMBUS_RING_SIZE(sndbuf);
> 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
> 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
>+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
> 	}
>
> 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>-- 
>2.54.0
>


