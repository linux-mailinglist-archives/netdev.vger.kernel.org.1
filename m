Return-Path: <netdev+bounces-196832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE16AD69E2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133983A345B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7DC18DB26;
	Thu, 12 Jun 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIR8TklK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585AF1684A4
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715459; cv=none; b=E4DPYmoB92XbOjq8OwqiO7KENnT8kVYHU5Ww2YKJDlmWP2merEbcxBfClq4VySKat3wy7cvYlSug+/n2AMk7UJ+6kIvZkJglSYA5reEFIuqmWzWJ4WuYchqRwWS2dbV+7r9AoxP5pDa0zjrmFFXAMw3eO0DdnDuUhAsIBLjnYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715459; c=relaxed/simple;
	bh=dZMHVNBbyE0k8GdpEWwXqBscTuEFNGdf3G5hSUKiNHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foCqED4L/pYr3y0R3sdeESEO9YM7/r5FL7/ODb0rs94LKrtl+P6wC3a053SMw+3XsDIlrfezAKYWWD2PEb8dFEsAWPhvkP6/RAdud6qrHwLUC/MaYw2NgfuD6VDkDFSg7f42dwUyq+S3M9gLa0UgZeiAiBCErnPjup3bL0FgowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIR8TklK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749715456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZMHVNBbyE0k8GdpEWwXqBscTuEFNGdf3G5hSUKiNHU=;
	b=ZIR8TklK9uWUu24gcrscd9x9+/28NtO4U2UMq0CfGnBPApw7+8oApSeCGF1JmhdFoFU8TV
	rJB/SinKUSjoGIbYvd5Zs+6retDd5oVGiO+jeGp8H88L8W2vuuwsFHfPUTobfwHQ0861Sp
	bDBVYMXRVVHhshUricYV8fBxBdUNUzU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Sre2FBlBPTOAXpGz3K396w-1; Thu, 12 Jun 2025 04:04:14 -0400
X-MC-Unique: Sre2FBlBPTOAXpGz3K396w-1
X-Mimecast-MFC-AGG-ID: Sre2FBlBPTOAXpGz3K396w_1749715454
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7110313b92dso10029457b3.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 01:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715454; x=1750320254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZMHVNBbyE0k8GdpEWwXqBscTuEFNGdf3G5hSUKiNHU=;
        b=DnuvtgNOr1yfg5t4N8MymzlRRbZNbiFO9CxR62NpcwPTcNkGeodCu6bJv1SWbbywjB
         eDTsc/ZaVbNKADQoiAG5QZwBX3J0SvrpACvXLFEvSnvmo8WvBukyK1gZFNaYg8aZIm+0
         wX1xiX7mY9hyh6MbDfuKVOmCgLqP1aWKRGRQ3nDlglYAsV1c+LNh7CCV1NpKBw3/T/HU
         fCktWdyjYRv7PGKXCrKTfVr9VTNlA5uASyPvjjeJKyAiJ8jfmYqlUU9okvIlCHuN+phh
         zOYzbz7x2kWMYTEomLxIYoW9O4UG8k3ycE0epuRlGNcHO9GsIGPW44zkaUlGHPVKXCwU
         PrAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnDqw5c8q8Bhu6GwSwsbD6xIga+sr0hcNfJpe2pDALZCKZA0rHHXcb46PRGuZk/bBtPEFJP9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwgRJh2Dn3UqL7Pfmf3P84Jol7i0waUyU9QR/USQPuBlleGAN
	vy+gcgvP1nfpixD6rmtevPs4rAnR8eqBh/Lolm1k/tyrcgd7ufddIF0FglDyP7wm01IXkiDdh/N
	Do59HSYCMhtM38NYGH4YzKnjDtcXAPlGcauXpUHQxwid18KZvwV/RdZ9t0jqeZi3psztRc50e20
	ViqjyTGIGJxhzLCSwXCvSjJ5iLfThhroGz
X-Gm-Gg: ASbGncuXr+uVmCkl/oxptoqsH4yrogoQFoqTn3kF58qa/6H/m5Qd+pECGOihCfGMYzJ
	0HtnIQVoqpjUx+vIh+LRv8T4YTwQWrueHm/q3nJ/fMXao1yoyHr+WnBqlg3PmeHIki2EFODRNk7
	a+3GU5MndK3MMkCk+LDwMejnNzXNJ9DJoshjU=
X-Received: by 2002:a05:690c:39d:b0:6fb:ae6b:a340 with SMTP id 00721157ae682-71140af6833mr89683047b3.30.1749715453778;
        Thu, 12 Jun 2025 01:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKpH0zV8WAQdWv1lhM5ZZcw077V1kJarsSUj2zqX5HwhgGv6teM4sCUgx4Nym37iltxkdXS6Iqa2//rPnys9A=
X-Received: by 2002:a05:690c:39d:b0:6fb:ae6b:a340 with SMTP id
 00721157ae682-71140af6833mr89682727b3.30.1749715453466; Thu, 12 Jun 2025
 01:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612023334-mutt-send-email-mst@kernel.org> <20250612064957.978503-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250612064957.978503-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 12 Jun 2025 10:04:00 +0200
X-Gm-Features: AX0GCFuxXcX7tZ1g-iY8JvPcecHdu0pQdDpj1BwVsu9-6iJkGFvAwtpFRMmd4Tk
Message-ID: <CAGxU2F6c7=M-jbBRXkU-iUfzNbUYAr9QApDvRVOAU6Q0zDsFGQ@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, Oxffffaa@gmail.com, avkrasnov@salutedevices.com, 
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > > No comments since last month.
> > >
> > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > > patch. Could I get more eyes on this one?
> > >
> > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > >
> > > Thanks,
> > > Xuewei
> >
> > it's been in net for two weeks now, no?
>
> Umm sorry, I didn't check the date carefully, because there are several
> ongoing patches. Next time I'll check it carefully. Sorry again.
>
> It looks like no one is paying attention to this patch. I am requesting
> someone interested in vsock to review this. I'd appreciate that!

Which patch do you mean?

Thanks,
Stefano


