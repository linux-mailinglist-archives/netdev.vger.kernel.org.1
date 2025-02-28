Return-Path: <netdev+bounces-170598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC5CA49321
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37DA188E42D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED301214223;
	Fri, 28 Feb 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4DIBl66"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A81DE2AE
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730505; cv=none; b=riLw8YPY5weaR4UWEAnviYa63GDMKtjTb2NKSpN1yVoi5SgUTF4LXR+e4Hcck/KZ0KP2AqgVtoFiPifGb8puZJB//RurTIgUsoxVXjTK1aiCODnQmJ1gh2BXm3O4StLjQB2Jrr9/Gijwf2Sbq31RfOY0nRSpp2zAJTaTDppiUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730505; c=relaxed/simple;
	bh=i/awX897IKbbFPKU31yR0reOKho27xl7tHdkuuKPePw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiCX9Q8EyI8wuY2fSw76W91lZrEsuL4/shPN/aVRdEih2DQHV5g/yNtBCE9xbyskyvIueoVQNlxW3SBTUIT1sXIniUhPCi0mzI72UOGtUtcc9PVTF0ykVJSYnet0Mey7qjzrXgeYKriENG4n2TqeNe1jGZePGkiMmYTqmWKksxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4DIBl66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVPNzs6ByW/HG56n5ZRSBScqeoqqOmHNsYho5zA17Ek=;
	b=R4DIBl66kcWAN4HHATNQHPQXFkuSUZgAXFwtVCcKRgh7IyyEZxS6AKvxRmjfydOc7UxUrY
	qGu0qS+axEsE5Tu6XZD+GdIPuhWMzPQKQrRo7J6hdi+zzQSrBCKUwReLRL/5JtcG+vzusW
	ddrW9aTp48rgjEKotjdKm9dMjm0mudg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-jWJp7mIQNlKzJbpbm1zZig-1; Fri, 28 Feb 2025 03:14:59 -0500
X-MC-Unique: jWJp7mIQNlKzJbpbm1zZig-1
X-Mimecast-MFC-AGG-ID: jWJp7mIQNlKzJbpbm1zZig_1740730498
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so6629654a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730497; x=1741335297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVPNzs6ByW/HG56n5ZRSBScqeoqqOmHNsYho5zA17Ek=;
        b=EJ5V856h32vix+aWe412P6PutzZ3fAP3jhLx5e/xV+D8FYfJPwU9C+s17qBWJEuCbv
         6jl0ULFUvoCfE6KsZ5Egz+Bn8TrY/hB6MAs9SnMMCebv0t2+UhiJjy/vK3W/tENvZ0OS
         AYxPVcUHHcJaC+epH3Mso5NQdobkBnKqR3Cp5ME1JAmPD07KwDbN0ExFU+BWOkTH9P9/
         9Orv7WTnJf1O7ihOnKW/SC51mmA0uhWEQSme+JIa2Z4syuDLpKjYumQIziUkDpzx8O8i
         fBpt4CmhKkfgqtbjWrYY/8OB0PYkxkg4E9AKTLuQeWqWrh/9gWmslC/kHs+XL5/kdgUD
         bKKw==
X-Gm-Message-State: AOJu0Yy1s7M+EyW4nDVaeZlIXOkgru/WtohxEUEe11nC7VLLeSGR2gbi
	p6Kezns2RfLJhv3df3Ue/A4cz0YSiMiP6TlXDv8uM3etiQsz6eI54yCy1La+km9C0Qhsx9wGwpJ
	mfEdJywLUd93xP2QHJsm8yAlt0jKdAbzgDa6Fb7hAt41wePOQ25eXdLAAJ0/STa/Z0AStWntNUb
	webqxfck4rzcEpfmjdICoWjSSiFL3wUCmcxW+r3nzuoQ==
X-Gm-Gg: ASbGnct1P8Lz1koCre1THMRYyGmhwovarFt32/phZ9kfn7ns8IKFRwZpKq/d8wZg+Jo
	07wevALgYoKe/3lbojEGoVL/d341jhYAEn+N8mFH+z6vEQiWYNrm7naU1DXhCSdsQzO7wTMeW9A
	==
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-2febabd9c6bmr3713390a91.26.1740730497703;
        Fri, 28 Feb 2025 00:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcn+x0GZCIknQ4zTQaIWwzNhdUzSiOqz72PNKBkKpuyU9ZwZnQPTZZgdJG8a4JcV4cazyA92Z/y0DGoohoCj0=
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id
 98e67ed59e1d1-2febabd9c6bmr3713377a91.26.1740730497420; Fri, 28 Feb 2025
 00:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com> <20250227185017.206785-4-jdamato@fastly.com>
In-Reply-To: <20250227185017.206785-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Feb 2025 16:14:46 +0800
X-Gm-Features: AQ5f1Jol8DOnnluZJdrms83ewIQuIWuNFxqYbgH6IOJBaoShyIqsVl50giYriC4
Message-ID: <CACGkMEus3m5M5ecA4u7irKd-N0p0=ZjnAPanLk-YJgoB6jhgBA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	mst@redhat.com, leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:50=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps. Note that the netif_queue_set_napi
> currently requires RTNL, so care must be taken to ensure RTNL is held on
> paths where this API might be reached.
>
> The paths in the driver where this API can be reached appear to be:
>
>   - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
>   - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
>     an ethtool ioctl or via XSK - neither path requires a driver change.
>   - power management paths (which call open and close), which have been
>     updated to hold/release RTNL.
>   - refill_work, which has been updated to hold RTNL.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


