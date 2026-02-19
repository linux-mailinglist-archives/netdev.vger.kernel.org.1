Return-Path: <netdev+bounces-259429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ5sAy/olmmNqwIAu9opvQ
	(envelope-from <netdev+bounces-259429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:38:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A593615DE92
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA2463033AB0
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45231326927;
	Thu, 19 Feb 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP8YIe7Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qIsEgonr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA2333436
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497410; cv=none; b=rL5sskaRBif+YiyLZvWImsm0JCMIrIs80hi+jsjRojpfYQTW9afSSCfxihgE2BB2/7IAi42VZpCnqE47YofhbyaxWXAOjQSZDp6Je2yjttKATv/kKIIBqaMFnmsc5ozNevui+23uYTt+Dsk29NATP2n3aYUFsKiEmi8k21jL4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497410; c=relaxed/simple;
	bh=oqw0KlNKIPYnEI20309wgxqKSge7eobGKUbr1LdjuGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTidI60ps3e1u8aeilDVTK9NUJ766UjI2aKHwUSp2yXYhLTo1h9U4rFDRSpUdMcouqahwI9lppYBgWtKG3lgcqpeIx4ZTQVbXQ1+yB4oYMbRKWRNfZb0R2mIZ9oPiw9pdR/4tvwmYsvCACTFdm1CtQX4oINpdWauaQD96pAVotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fP8YIe7Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qIsEgonr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771497407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HuCXThfRUEeEl7yH4RijL3+g7m+evVIDET2wFtyGPA=;
	b=fP8YIe7Y7YCduuZ+wD3Ap+qBUjlLZjGAhQqtnkYaC7nAKRaUi+4yAF3+LK7vzwgTXxadyW
	FFntZkKvt+sC3r2nQXM2FneIMx2NQeXt073JK4f06DZfH5MYTVjuCH4t1yAAQLuv1IwtRN
	ScqhJQU7y7h7wvxc7FM5dWvUaScB6qQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-42CUSnkpPXyz9H1z-8JbFg-1; Thu, 19 Feb 2026 05:36:45 -0500
X-MC-Unique: 42CUSnkpPXyz9H1z-8JbFg-1
X-Mimecast-MFC-AGG-ID: 42CUSnkpPXyz9H1z-8JbFg_1771497404
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48378df3469so8101745e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 02:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771497404; x=1772102204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HuCXThfRUEeEl7yH4RijL3+g7m+evVIDET2wFtyGPA=;
        b=qIsEgonrPfvZJWqC1SF7flDp7dYt/nEHIjpY99Jbl9Yo4ZoBYfcrfBxW98RFMYJStX
         OhWdWkrrmR7WZe1IoL+EnvtqZyDTl5catuoBvtFPloxY/FDnMEW4aySa9FLP3I+23f6w
         AQVPSUQZcFHfTcJurL3NXkg5ArIZZt22k7TQ/WeBEreojzEvkvBTguymSNbQOBciACG0
         IuVknXHwPhcfjTQegTSKy6f7mp3eMYtKk2puiPpfKWRr1jhAdat/JTLt+3zgvTlsH9vs
         uw9UGWpTEBDOLfX/KaVNCH9rWBOuI6o22LJpmnBKjXJoBwHlfuO0lzW/fF0yksVGrL+L
         P/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497404; x=1772102204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HuCXThfRUEeEl7yH4RijL3+g7m+evVIDET2wFtyGPA=;
        b=KDu/1JGiJYyQPZRbSG1SvXIMnHZ4ib4xw+7W6Jt12DZyZxJdfqYnpN8xIJ5GzGdb2i
         7EDABhM62is6TtkK/hREL6U3R0A+0LM36dXN525nj2e/V+p1x8ogbXKh7U12YdTf+y1T
         Ouebl3Z0WNAKNYyzZfdf4DM97N9xezfi8CVO3bYj/iTy0h24LHImhtWM1Pl45QgTy27b
         IV7SeWy1wwd4/+C5wkM2L3fYLp+RULJbJjzzsvy6VxDTvQBfLzdRuHXBE2+urI30vhoY
         q4dtyNMDBVRgkGe+oSsvIIiXpA07JxV23+VejJ8i8gAMCzI3M9wtLeMeKBIJ9G3gfTTl
         /JUg==
X-Forwarded-Encrypted: i=1; AJvYcCVdSMoLaqaU/EhCk0fLm2wL7Rj/RW26+Nlm4V5JdZMskCgXeNjB3RRsGkiJrDbOQGg/AXS2NHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aKG4oebj5qyR8TX9gq5eqAbbxYAl34BSM1LfTsQrPZWL+7XW
	XoUk/fckk6L6wobXlN0sYjHCOVyFr8HFaH+UsbkA+mUzcz5YozuBNrCvS1g9ZBgFW3ja4RsTVqW
	FxJQPftTC1qvvmxy6ngAWGV1ttoYfJhOMmY5CUl1Y5KUVT8KpV4dIT8GMUA==
X-Gm-Gg: AZuq6aI1ZbEXq2p04YCvmf/iT1OM5CYKtkey5qMaiyvZDH87Z9TNM3rzoFt0YVqVbJJ
	I9ZlhS/MehhaVMVauggQ3Wpq7TFc53N9X6tzFVFcUa6ft5aPja8KdoURjjMUYasr1uaB05+Nws+
	p4rgJPVDBBC5M0yZEg9MhQ4/nlWtKeJBOSWAQgbgJIylfozT+m80OlYAfeEnhgys0DmaIkdltbW
	Cxg0Sx8DLrIjFQWRRaq0hcVIkRZ5dASBQ8GZcuVUVTYifOyQapGftM/0fJRGohGI0DqwAVXYKSc
	94XuICEDD0hOUNwdy64m/c+uhmxwWnrwmqiq5Skdw1k5IZsjgdUXAJ2Rc+F9fvSA0ADAMRNWeUY
	Twi4s6VsP/xJCXLYA/JrC00D5XH+Hsoo7PbnFu25hgzABfhkBOnaeBYnJ2yTFokkoeQkZqXM=
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-4839fe90522mr18467475e9.3.1771497403785;
        Thu, 19 Feb 2026 02:36:43 -0800 (PST)
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-4839fe90522mr18467255e9.3.1771497403315;
        Thu, 19 Feb 2026 02:36:43 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f99067dsm17354955e9.29.2026.02.19.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 02:36:42 -0800 (PST)
Date: Thu, 19 Feb 2026 11:36:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Message-ID: <aZbN8fXtCkhItSV8@sgarzare-redhat>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
 <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259429-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A593615DE92
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:10:38AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Update the vsock child_ns_mode documentation to include the new the

nit: s/the new the/the new

>write-once semantics of setting child_ns_mode. The semantics are
>implemented in a different patch in this series.

s/different/preceding ?

IMO this can be squashed with the previous patch, but not sure netdev 
policy about that. Not a strong opinion, it's fine also in this way.

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> Documentation/admin-guide/sysctl/net.rst | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index c10530624f1e..976a176fb451 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -581,9 +581,9 @@ The init_net mode is always ``global``.
> child_ns_mode
> -------------
>
>-Controls what mode newly created child namespaces will inherit. At namespace
>-creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
>-initial value matches the namespace's own ``ns_mode``.
>+Write-once. Controls what mode newly created child namespaces will inherit. At
>+namespace creation, ``ns_mode`` is inherited from the parent's
>+``child_ns_mode``. The initial value matches the namespace's own ``ns_mode``.
>
> Values:
>
>@@ -594,6 +594,10 @@ Values:
> 	  their sockets will only be able to connect within their own
> 	  namespace.
>
>+``child_ns_mode`` can only be written once per namespace. Writing the same
>+value that is already set succeeds. Writing a different value after the first
>+write returns ``-EBUSY``.

nit: instead of saying that it can only be written once, we could say 
that the first write locks the value, to be closer to the actual 
behavior, something like this: 

   The first write to ``child_ns_mode`` locks its value. Subsequent
   writes of the same value succeed, but writing a different value
   returns ``-EBUSY``.


Thanks,
Stefano

>+
> Changing ``child_ns_mode`` only affects namespaces created after the change;
> it does not modify the current namespace or any existing children.
>
>
>-- 
>2.47.3
>


