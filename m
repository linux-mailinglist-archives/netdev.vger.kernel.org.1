Return-Path: <netdev+bounces-109738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1250C929CB9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE91C21145
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728F182AE;
	Mon,  8 Jul 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM6WQDM/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52861B815
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422299; cv=none; b=cduwKQ+JBsY3r7n+8lZWX1XMN5cprr78DyuCrq3J0Do+eQcmanxaWppiDD22olzW+tIZasKiKiEqsZunhKo+QTRh0jp7E1bB8q5qMM+diYO5sDrDu1fcwoefdrlLbbMpCCuHMemoEKUPRTbWCI0TshKv0HW367R9+oeanP78LTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422299; c=relaxed/simple;
	bh=Lyh+OGU1qSqkgNUOSt3XboZ5A/fxDtSPgkO065fsa0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ot7cU9J6dRL2miKCZMM31dDjoKsbHLwkpbILto6CXq/+/jaPNGEs+bpz9FTIWUmxGrE3OSjdfQibmKz4+QHabW8W61fgG478yAbm0b231OOEwfsxRfrdP/Tw7/WNSyvt93ljQx+2Rs2nvlAmeUNHVXMFvG9YKTqPDR2G0TNR3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM6WQDM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuevZFB7MKI/Lq5uYauYhSH0Qsz8j07xL7h/7QL0zAQ=;
	b=UM6WQDM/wnJdVgKngAc32Z+IT86JiWSeC26b5V/bMkQpQGbObm4E/NrltT330JyM3tIdQS
	0QaeL4F/cjlwRJr9cSWu7JmU8jlzZKVYS1tvHE8XcvwHSnZRhCW6mMwa/Ff3SQfPKQXxFo
	eOU521CGEboWQ5s+c6xzKqR1ai4hWsk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-KafUUnicOUahRHWoE_lg_A-1; Mon, 08 Jul 2024 03:04:55 -0400
X-MC-Unique: KafUUnicOUahRHWoE_lg_A-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-81017abda59so1011343241.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422294; x=1721027094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuevZFB7MKI/Lq5uYauYhSH0Qsz8j07xL7h/7QL0zAQ=;
        b=ZwUC1kCsix9CQF9+r51pIte0OdIrzT3lMsrTP/bGwmezvhbdv9gwSECmbPfyLNE/WE
         0RJH3vr6sgS2LzW50tJ1hhuNWRORDigcJ+AyqsRI3RzNer2V60l/1ybf3MJWSWvSDxzQ
         Daq1dtFdHU6OMEQoug69ox6luhLUcGQg4SrU9dr+0YApe75//+dRWi3SHS7xUKH5be7W
         hIVQW7YDv+QeEEB3YpaDRlrS+gKynJbvZd3LRjgwfnszCQ6LnK8+2J8t5p7rgc+WA/D2
         q0eB+F4lI+Xh+x90hUC25Rggdqi4UdXOexbFIF8jhts7T3UNhH3qfjnEuCpbsxBPN55n
         jZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIo5fyvOmUhGe1UUwZ6U1Z0vs9ufoPfElmKRuYa3fFMFc/gQfabU1BC2n/NSrk8VPeCld1+DoGE9yxipQoQdd6lD3BDlSu
X-Gm-Message-State: AOJu0Yzu9mR+yFAwZgxw+Ed0rvDAxY9YycqXGxI64ZuUlx59n6Otklrk
	z/gNdJ28Lzqu12qJSTm4Mrl1J3ujywJZ8fW2c7d/RDhaCUXhs+/2HosYFuS7PN9kKeg+p3HWoZX
	iHl5s2mAcWeMWPwTxerlPTTmmTQKK6aX6vEB0lU7Sb+Y22AoDIopA2jUPrbg/kdzQNngZEdwQn8
	reZjIP6XCxX9pQXSaaWeFE6IyFTZ9M
X-Received: by 2002:a67:fd99:0:b0:48c:376f:fbfe with SMTP id ada2fe7eead31-48fee6dcb3cmr8108043137.14.1720422294490;
        Mon, 08 Jul 2024 00:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNBSM7bOK3sbqftf/T7VmMO3M7PHhmrjnMZg1tK5qooR3N3OIZ0nrg5Mz/+IAvFBjtZftOxhqa1SVHpbqFvk=
X-Received: by 2002:a67:fd99:0:b0:48c:376f:fbfe with SMTP id
 ada2fe7eead31-48fee6dcb3cmr8108021137.14.1720422294089; Mon, 08 Jul 2024
 00:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-2-lulu@redhat.com>
In-Reply-To: <20240708064820.88955-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:04:35 +0800
Message-ID: <CACGkMEvm59kNPvivACZt8mAZsZyp7O7FO5NUF6abB9XS_SwaEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


