Return-Path: <netdev+bounces-114379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E7942500
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622A9280983
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00431B5AA;
	Wed, 31 Jul 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+L5IZGt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D918AF9
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396056; cv=none; b=pce0xBIRXTKo114fbYzNK50LQZ9PU/8SYgd7Q9YGXO5Ady+M6LSynZWIHYsXbsA9vRI0JNpwu4awkHOOuhHH4UUgGFk4C2N56gts5XO/E6IlsAxg+EKakWDduzt0IGjmkowLoBUvLHuELkBJRkOqDy/K5E/gOPQ75YxQsdSZqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396056; c=relaxed/simple;
	bh=2pK8gm6ZVpEeA1ly3iczVmymWCxm8XAdJ3C8puJvIlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQkC+CvNwZbrvbtx9GDW3PZvSVlEXcFQOqom6weA9o7EQt8ryfevP/m7wdJzzZiiy7HPMwrPjnsvu3VqJKZZ2c3hvQOPNdkTuc68ryjweB+lq8iHzCueuEEPeVkkZq8aDenGkKnSL87FveeJTwIxaiA+RPJGJ1RhrKXZsRs1W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+L5IZGt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU6UZtmb7nqWjCNh35gVT9eXpDgbdzROuHvxgQjoBAA=;
	b=f+L5IZGtZvHaOv5BqDIFHLIWxxRVZ546G5FPanSCsxuChzCQ0x+hD8PYOp8s9cyPrKg2xG
	UQPS80fNeClfSFcwc0uIVUay8HjL/EknHWIyJjm5qBxeUux/PgYOFwh0PU3iPIbB2B9/oX
	J2dU28tca8/yDLvOGFpfUgoB/N0gFEI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-dHZIvqSsPBmYyQUUSqKy-w-1; Tue, 30 Jul 2024 23:20:51 -0400
X-MC-Unique: dHZIvqSsPBmYyQUUSqKy-w-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7a2a04c79b6so506886a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396050; x=1723000850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU6UZtmb7nqWjCNh35gVT9eXpDgbdzROuHvxgQjoBAA=;
        b=Rd+/8j4rK3kvGXqpUBy25NImbtfiJynSNB+Csu2saBNalmR3qymXVHKPrEDGNGHXdR
         4LNIrjOB8HidMOflCG95+/IdOOU8ZIf5B1fCx4/aEaFhoL96zNtnCqC3A8nCka6yGLi9
         /LMJUgpou/iplKqJc9oNu/YSmQrivOgY74u808SoIzQEASeanKZV6U0qzLPO5L3RGpbB
         /F3lWm24UowEnGh+WdFXeCoTRiyx7yjKnj0Kk2wFOSkgjfpUXCovBkNxtVdhrDjHo2Ks
         /LmKm822nhtuvY+AYvsueTsWnAuxSQ5/5eoealzEu3k1wCJQyEmuWgbq5Pahsk3iRyak
         LJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXzmZTSfuBsWNTkPZoMzb5F6YEcFvPiY4ezuhofQrOIJ78jRjvNEo5qfP+QZAaiUPgGtdr/dEAWjQsB11QJzRpKVjLZZqsS
X-Gm-Message-State: AOJu0YzHR4Wadstz7KhWZ2ECVWFETcLWPaMo23jnjBRK1HoW2bcw/ztk
	4WDPzTCi5YwFbpNw/+A/MOGTpbleIFE7tlYTcQFfD173qyjL1UebX1IlbTxaHhXBdWWwvqgNHD+
	7b009bUpA+4aOGEs5zJvjkiQHM/bXNYXlic7TQTePBiDboGeHvt30rli/ykSpa3qsVaBoT0zeVc
	8LLTkIPHG24AzDomqUPkW1D1Octp/V
X-Received: by 2002:a17:90a:558b:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2cfcabb4428mr6355878a91.19.1722396050569;
        Tue, 30 Jul 2024 20:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdikMPaOaei1HHj0OApex9jIV+xfMGVWj4qGTkYxBDHCya8v0ooI5txmdfclcFYjj3oMf8dl8KVIItDPVvzbI=
X-Received: by 2002:a17:90a:558b:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cfcabb4428mr6355848a91.19.1722396050017; Tue, 30 Jul 2024
 20:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-2-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:20:38 +0800
Message-ID: <CACGkMEs+bpWtpFp2hT+GrRUOJQq4h=2LgKWj+U4tM9a9wMQpDg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> new MAC address from the vdpa tool and then set it to the device.
>
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
> Here is example:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
>
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


