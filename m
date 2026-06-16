Return-Path: <netdev+bounces-299833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NNDxIUxDMWqgfgUAu9opvQ
	(envelope-from <netdev+bounces-299833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4D68F642
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:36:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IxPbmlI6;
	dkim=pass header.d=redhat.com header.s=google header.b=jcmzkd1U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B363014C50
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F799364024;
	Tue, 16 Jun 2026 12:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBD2C3248
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:36:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613379; cv=none; b=rWSXazb7a1PiBLcTy1GFq+57BxV9kcUfMf6KsIoRGqghygONAfLl1D7MG4x37Lp1GGOROwV6vvUBbyQ6PoTXOjIGjHnZS+DqMJXMPbvcARDOeOeqUcRuZZ29H1BVNRgjwsMsGT5WtJa7RuEfleWtMiimBTqDpQtYIVAn1T0SvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613379; c=relaxed/simple;
	bh=We5ZGXz91oTGJ0dJSujyq11OFk6rNuSPRZXQZ0H5xKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+rCgPgmk5TTdVXB6mqW5KOBXRuEFenwCwKAVXvFBKr4EYMYqcm2ZFHbvJxqwWQjryGNAknxleO2wFm9ct6vf9LyttBJGi9dXhrWJVLDTkIG4nEAPqnEulIHjK3+mkpK6RhkIHUZUzTV84actpbkjquJKdzjxbsZEWFDe3xeC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxPbmlI6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jcmzkd1U; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
	b=IxPbmlI6aSEC/8pqlUFbfau5OzCNQTDg5zBsJ/G24WhfDnXA0Fn/zhkTb3QAvfRifhmYtx
	F2nMkg+h41HR5V4owmEEGa2eDa/6PmvUiqmIZ0viK1g2c6em7i9XAnEzrSklFUmw5U5hmn
	+nFyRkDM5lxVQGR8QGCrM+m7u00+c1g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-gNV9P-amNlOd6zanVnIdzA-1; Tue, 16 Jun 2026 08:36:14 -0400
X-MC-Unique: gNV9P-amNlOd6zanVnIdzA-1
X-Mimecast-MFC-AGG-ID: gNV9P-amNlOd6zanVnIdzA_1781613373
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490aadb1386so27578675e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781613373; x=1782218173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=jcmzkd1U8AZO+33GkNqsb/EQkTiGu5fMKNKLIrbA4p1qV0S8vaiGRy/nExL8CR0fOc
         egHCFb3rXStBZffCohHs7+5yjVH8MFGu4qnF6tL3ya+lOl3zwwxhhVdiQayHu/DTrAaH
         EnLxd9/3ev8McLB9rRF82/NtpZlLTY2UYrxrn2Gx6k42obGFEZMS0Fye8B9GYusCGRl4
         hT4lKawPTG5386E7aC5eS9EwJ1rGTgqiofFafmTipl6INfLiE2INXT2SlvJmxXpahiqk
         BPXB21vA7ggGV1C6/gIsWklWWkF+RZHJ83lulVj/tc6X8005OwF+k35QPg9aTaxEcmyW
         WZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613373; x=1782218173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=qgBiIu4Uz00PKAu3xMeUq0moVIjp+PLaAoYqrkR/z0WA1ttshijDryIe0lREmJIYhe
         1bXJfA/NjBG9b2/f12wLvEDI2Vf6a/B2HNPcNFCVdzXOsLfYw3VUAyw8SMlIrPmnpi5g
         kUQsHqHimWOw9EH60jcPzAJyP8zrQMnJU40QnnLyyDHpKgc7VVr7NDAeKb2UmpnN2Iga
         8pUNIPC+YU/ut0E7/X2f1nEQCoivSY4ktU0XS6EBbtRiBgs9XCxVNqzmbDRNZBqhsmvC
         at0v4c+I3UxgCY5RQ/4C5GTq1HKNJgl2lDx/BmQC8KUYpfy7+IfJYVpe2L0nIAgRFyFF
         JT6Q==
X-Gm-Message-State: AOJu0YxX2JXO5Vzn/UnyRr7gQkDxpaH6jMKeyTCLLLxDwUh69OybkoFQ
	iXkep/NnHF1JeofQIqIx7QHlYJbbGL+HB7GdltA6zoD6UDtwo5uiTTCUdImzGkxngaf2Ze9DaEQ
	y825aito65FkE5IaRwdPPEWKz9C/8psyWSkH20jUL8xGrdWckQzUanxLwmA==
X-Gm-Gg: Acq92OGUXyTVDqz6OyVa1umY4bo8clfl3e9LYCw6j2tQCaxfAF5XFT6wmD2WsG6CZO1
	L0NVYFb2gf698UBm/BiDzmXa3w2ro4Z8yLAA+ND8t1oDgb969iR2527Tch4WcPLsmJU/MIPbfH9
	Kpm0YQ/kefxKeN7HnggbMlikHDncE9GT9Qh7Ib9683HMXOBI1TPs9DNSeeJg5XOY35RUCKwFONf
	qabhhnbAK7Vz0x0dXHBRWox9QMvCXa07rF4SB8t8HRqzhYPNs2ujmZ+038wOE29yPLDwjVCrSTF
	PN4tQBctRcrzh1SKgtyDMimBL1SNvZ0nBoKDgIkxGTqUBbCKR4OLkhj7mDt9YurKxbmhJDLwfeH
	UpuA4C/TP+hdu+E/+0IgsCOxgk1z5nXTLOF3X+DWC6lJKUsp1ij+g2VDyVDWTDcV2fvG6WNM=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52204365e9.3.1781613372006;
        Tue, 16 Jun 2026 05:36:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52200315e9.3.1781613368029;
        Tue, 16 Jun 2026 05:36:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm53027215e9.9.2026.06.16.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:36:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:35:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
Message-ID: <ajFDIHuKC31pumnY@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
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
	TAGGED_FROM(0.00)[bounces-299833-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:tavip@google.com,m:netdev@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:akpm@linux-foundation.org,m:avkrasnov@salutedevices.com,m:davem@davemloft.net,m:edumazet@google.com,m:eperezma@redhat.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D4D68F642

On Sat, Jun 13, 2026 at 12:09:52AM +0000, Octavian Purdila wrote:
>Export iov_iter_restore so that it can be used by modules.
>
>This is needed by the virtio vsock transport (which can be built as a
>module) to restore the msg_iter state when transmission fails.
>
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> lib/iov_iter.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>index 243662af1af73..067e745f9ef53 100644
>--- a/lib/iov_iter.c
>+++ b/lib/iov_iter.c
>@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> 		i->__iov -= state->nr_segs - i->nr_segs;
> 	i->nr_segs = state->nr_segs;
> }
>+EXPORT_SYMBOL(iov_iter_restore);
>
> /*
>  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
>-- 
>2.54.0.1136.gdb2ca164c4-goog
>


