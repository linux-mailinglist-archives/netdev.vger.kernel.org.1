Return-Path: <netdev+bounces-260560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOY+GxnAnWnzRgQAu9opvQ
	(envelope-from <netdev+bounces-260560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:13:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5829188DAC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FEA73139772
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23743A1CEC;
	Tue, 24 Feb 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8BZBiEA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ctx/NHPY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF53A1CE1
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945840; cv=none; b=H0iea8Mff0XBAGBdKh53x05JdSvXinlxZuvIKBL4Ux9fPZBSRDkPqB+suuYmCx7lHd0hmBvncsnIFZEuy65bjlAOs5lG4xtAIH9hs01wN7THTu1q7Q+RcYrCH4YLLcf1pSIsVKCw+7mUkWXVHZMwPxg9mrvEqjhElt99CxjmKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945840; c=relaxed/simple;
	bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQQ3G/tNYfYCV9zINGpzIjUAmkQekxdb34WsD4SmAcdmVFaTsh3CwmBodUKpw2srLapIfO0L5kOCDIKengxHsxr7aaIXs/1lzWSU00d8JDp0441787UCCS+YqwkuZMFmhttYh6hjuhYB3NPvyNAzpnuCwMmBKw7G//ZKYyNIml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8BZBiEA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ctx/NHPY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771945838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
	b=H8BZBiEAK/gaF4kW89vzvCvJwvv5kjeLfj4rs7Lsg7KMZIGSFZDbx+7T3MikezmaHsyHjV
	0fSZUOcvTyfKltIrzPgrm1uGJb1140gl2DO5ZK7vP4xSCgrpygTDxoIQnHMd8bjmtQCCWr
	4p9XSGfOaN8wf3tptK7V1iO7pFvK4OI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-f-TPc3xdP9iiRxko59zCUg-1; Tue, 24 Feb 2026 10:10:36 -0500
X-MC-Unique: f-TPc3xdP9iiRxko59zCUg-1
X-Mimecast-MFC-AGG-ID: f-TPc3xdP9iiRxko59zCUg_1771945835
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48372facfedso56190825e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771945835; x=1772550635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
        b=Ctx/NHPYh/VlIhSL+ainpWSuiJKnfGC3Usql9ihCvxFiUp2vlmta+HpKLeDjm3AI/w
         fOgG0S/LDwYrkqy2mOAODcmzvgS3YJwb+NLg3KFKE5b37Mui7bekLVT7aIq7MV9wT3X5
         6IBPf2e1Bz72DRpBqb30IZweq1lDFj/Tg/HFUMp70asxmsNcszkQTpyp25yGs1qFw0D+
         kjyPZkTd3sXijGeXIMOOL8PxAV4Ta4CuTcKxQZUuOaTqNfeM8Pl44eFRnZArqycjzIqx
         NrBxURzteGK9i2yZ1L21G7GciE+EQ2cVH4NBTIabyQzCjX/IsNkyE44zGtF78ryIE0b+
         cL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945835; x=1772550635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
        b=tR8Xcr5OzVO/v0UDReV/KoA9W+b5vZcUb5fycbaSMjvtNUR3cmKZOM6cooC0PRbOYz
         F32yJ5/Y3SZ+eRTLil59fkTgKWYEknaJrAnNT/JDR0R36nu6M6OQGUCbCJOybZkUrZ9c
         6CTi9sXAsEAfI3C0AZ5d2zKJRoIV+OrGQ7iKB17qegA3uKKKnptSmhaYcJjyrWXay7go
         vjnDO2XaM1UxqOAkIoPrrLu7KqI91wjx+9J/Ank+A4P3R7rdS5XgseSuT2TNZCSQqhkt
         luaJsiEIGOPBhqVr6BA+2p6TZLSuX+w0vgJTqoTW1qZwvGu8A7fm950f8yPIcOkpaglD
         0ewQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrl7qCeR7zBglu//vHTgiGFqMGFj/7/BIxrjywyGPi/ygVX2GxuM/E4pqhL3SN7pgPJZtzK/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbybJ92DNkH7o+Jhbi1NB8jneuyLxi2j0quaIYliWDjk1rrSJ
	q6gdrOhWRTZiDaXTOX6Y8Bwn/hjcPdHo/ftXne7Dyzm5iX+mGD+GWeoAcUjoYurvgG23Lc6RmEM
	x9guFfbOxI0GNpYxRvdj0tZlasSzOPRDSYykuItz9tpWaKmt1dT+zuSOfNQ==
X-Gm-Gg: AZuq6aKzBmuIlWPrg2l+mqIaMgsmeDEsrWZ2uT4j8EgtHVgsh9DCe4MTKw8gwJ3zLww
	nitEpdn6yQVXDLBDo1cHAPzR3gb1gYsq7oDODTuCgcdgU22ZBVsnAmReMyRoQnT1mKg741F+gNf
	I9fby+fjO3CrnUOvEtnaZPgg10vyzmNhlSuEjMbGDIsDXF2ij3tKe9bPRhTyO89ctg5+98pSLTQ
	2cLDqeatFdkQPQVSHGjUeQcBuXhoPPEcjmffLUNR+/76ylyYH+8Zb/uWk/wOkv9L/vZL9DwHhw4
	8I2gxMknff1HftZncloZ+DGzosN3YmnfX7CpEIYCE4Mtx/wbd4i1aJlI5DwCnXIkcyn0tyf9UB5
	dn9nWBLz3lo51M0HmQp3i8kPZwzHLfSonhovP5TNpcacO97jKsO8iYag2uyfdRp9Q9SvqhvY=
X-Received: by 2002:a05:600c:c113:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483bd742cddmr3686895e9.10.1771945835289;
        Tue, 24 Feb 2026 07:10:35 -0800 (PST)
X-Received: by 2002:a05:600c:c113:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483bd742cddmr3686325e9.10.1771945834815;
        Tue, 24 Feb 2026 07:10:34 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8791a0esm73910215e9.0.2026.02.24.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:10:34 -0800 (PST)
Date: Tue, 24 Feb 2026 16:10:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	kuniyu@google.com, ncardwell@google.com, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net v3 2/3] vsock: lock down child_ns_mode as write-once
Message-ID: <aZ2_WfJ5NVuyZJSS@sgarzare-redhat>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
 <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260560-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,meta.com,lwn.net,linuxfoundation.org,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: C5829188DAC
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:24:07PM -0800, Bobby Eshleman wrote:
>On Mon, Feb 23, 2026 at 02:38:33PM -0800, Bobby Eshleman wrote:
>> From: Bobby Eshleman <bobbyeshleman@meta.com>
>>
>> Two administrator processes may race when setting child_ns_mode as one
>> process sets child_ns_mode to "local" and then creates a namespace, but
>> another process changes child_ns_mode to "global" between the write and
>> the namespace creation. The first process ends up with a namespace in
>> "global" mode instead of "local". While this can be detected after the
>> fact by reading ns_mode and retrying, it is fragile and error-prone.
>>
>> Make child_ns_mode write-once so that a namespace manager can set it
>> once and be sure it won't change. Writing a different value after the
>> first write returns -EBUSY. This applies to all namespaces, including
>> init_net, where an init process can write "local" to lock all future
>> namespaces into local mode.
>>
>> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>> Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Stefano, I wasn't sure if you wanted the Co-developed-by and S-o-b on
>this iteration, but I added it just in case. Please let me know, if that
>wasn't what you intended.

It's fine, thanks for that!

Stefano


