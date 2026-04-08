Return-Path: <netdev+bounces-276347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDmnBJ4P1mmxAwgAu9opvQ
	(envelope-from <netdev+bounces-276347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:19:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECD3B8E66
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2981930B50AB
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335CC39DBC0;
	Wed,  8 Apr 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZekJZRM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYAyfwzY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87139D6F9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635967; cv=none; b=cY6D2L4xo9YV2S/nDN8SFFX98pCyomRLfs7PTEoKjybbLNse+Hjvh6rxSkPGQD4cFxn/Z4SpsPLwm04I5O7OWw/tPqL8wYg50wLzqqsL7+s2VrcKCIMjSHVSjAU2WvwiB8E5fJpucPeAezUUzFXIthOYulOk8EFeBDXbC+A8BE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635967; c=relaxed/simple;
	bh=RiCBBjqJ6U8+nG7CHcXztQnXvaUlmfGwoy/fj7EupJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFA2bIfZvSgF25RdxPS7lBLKvQY9v0E38G9RMsFce+AhCLrEhmTPtPBAbEETUL9/SktTN6LdyTMx1xVkDyx3DfwzHEieJnfYWM7fNiEXKg/u1NlIxWEKv4Jo3XXvGL9tcXppa2zFNFYf2GFSXQP/RthpRbCo0qClqnP/IFMqYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZekJZRM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYAyfwzY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
	b=iZekJZRM3zKNAIIaSBRoy376AIUXEWZToNvK8/doUu8Q+TNZWNFgu2jflWbgtfqi8C1/DN
	QVQxf7MNwz9rzutsF8gSkcI8GqdyjD99Q7TeWoc7w1kAk7oSZmaXnsSqHHomhsqjNGXe4j
	p4ym3uI7FHj1/j/nirrk3TC54vRT+jU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-FkuJsWUaP0aS-eRovORkBw-1; Wed, 08 Apr 2026 04:12:42 -0400
X-MC-Unique: FkuJsWUaP0aS-eRovORkBw-1
X-Mimecast-MFC-AGG-ID: FkuJsWUaP0aS-eRovORkBw_1775635961
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b99add7f3so423869f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775635961; x=1776240761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
        b=LYAyfwzYzM4jrthJZ/lY7ufkbH5zV9GFY2vZ4YcPwwy6Pd7qfBP6gt/sbkZ5FlDMvD
         unULd31vEeE+nSPhaamL5XiN1mIVnKQYpdNOpLmQtI/qdC1ptA2RxY97bxVCHvj9h3uf
         jC/dDfE+Y1tBaPpkH/pl7cmFvv8dOH20uzptHKcqAIu3DtR2RP4bkZpE9WwX6+h431m8
         kr6Jq3lVE7Z/0wV2R1H/15yhzRQXHNswl/ymF05c2V7RgV2/dS9H2WJ0VRMtb7nCniO7
         c33NOftGYvVmJy09enFLeODEuAvl0jkif6DEsK0pyrA+79wEIvjhJu2Eo6OQFJPAVkjd
         B1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635961; x=1776240761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
        b=fOasXL4p/9rCvDejS3g+It2Tp4heTuNqUXWDjyWgdZma156nVtXrajbqjNe/lqh88G
         c+NXD8coyjETtmBbwiRJCL8aRn+ZZ7+47d/0R4yI6fhfEftUCXT4JbqZwiQQcKXHPjoc
         GuORDLoV3800a5LxGfz4DdHG+wCgYFIypS+MCT/QpUiS4Der25LYBNINXmaHoj28494N
         Garf7dIlAmGfUaGDnV79XMI7nliCmchRmPeRL43I4UJZa2rIxVm6Ny3M0uYgzfnIocXW
         rtqiJBT+BztQOUAMnAsd4w2SZBO7Kp/jvYlENNHNmnofvS3PCkhZ93j2U8cPJtE0aiuF
         XsoA==
X-Forwarded-Encrypted: i=1; AJvYcCW5HqnUWqKL2y5+1FPNvN+8Duo9rP7aXiUsmm/ue+jOyD9AvVutqznJ3dfe9EZu548Wd8pLjZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygoW1gz1gZT/ALFnP1LeqeO4MrpQy34cuth2O11NMp1vNDSJ5j
	6YBUWzJijhik0kiZo+myUSpnrpCFM9jNDT+gZF0WQKk6ebKTi3CZFU8uFUorIIRSkiaXsWf9DF6
	J+oCBXD1Hklq4utCfzAhoWkTdHFFK0QvLgmnA76x0547dapjuzeTDjDA7CQ==
X-Gm-Gg: AeBDietw4B8H/NCB9dGek47gHm//JIzzl31SNa0DbR5ZsbY58sZh6oO5q9iWoF4Ngxa
	60JwOUF2z+jf0wPqXtGRs5soXy9k0aUO4gsz2nbz2OZBaoUkwxQIwMeHhqCp+spSCMOWtGp3XWT
	rDgsUet6VQCTEvlQoRetepNE4E6a//PBnH5QsWbKV6ypz4HUS8KQ9K5T1z5MjdB9RM7kztyxf2z
	bA9sldm5kmF/YrquxTZ8GiBf/CoaUPxp+x4rnlFSgrTB2SCuUMtRQfvmUan+Ucb51R8lMc6uU/w
	LAxg1io/+Y+rV3FfnmIuvWKd29tXVjaufMVLxF1/H8nMqtbFU2cUVXQivE9MsTV/v9ODJuqBp5f
	EvWGgAkEjWCau6mHFxCJXzHserezxOHMx13whM/jw7W4vBTGdL936wHF5WOIe+bMNdvfiquadJQ
	==
X-Received: by 2002:a05:6000:41f6:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43d2124e1f5mr31165865f8f.24.1775635961035;
        Wed, 08 Apr 2026 01:12:41 -0700 (PDT)
X-Received: by 2002:a05:6000:41f6:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43d2124e1f5mr31165826f8f.24.1775635960583;
        Wed, 08 Apr 2026 01:12:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm50930205f8f.28.2026.04.08.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:12:39 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:11:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adYNUs3pmVmQe7pk@sgarzare-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FECD3B8E66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
>`virtio_transport_send_pkt_info` gets all the transport information
>from the parameter `t_ops`. There is no need to call
>`virtio_transport_get_ops()`.
>
>Remove it.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>I marked this as net-next material, but honsetly I'm not sure if I
>should have targeted net. It's not a bug after all, it's just a cleanup.

The patch LGTM, but as Michael and Jakub pointed out, better to remove 
Fixes tag if this is not a bug fix.

Thanks,
Stefano

>---
> net/vmw_vsock/virtio_transport_common.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e85..a152a9e208d0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 		return false;
>
> 	/* Check that transport can send data in zerocopy mode. */
>-	t_ops = virtio_transport_get_ops(info->vsk);
>-
> 	if (t_ops->can_msgzerocopy) {
> 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>
>
>---
>base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
>change-id: 20260407-remove_parameter-f61a3e40cf90
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


