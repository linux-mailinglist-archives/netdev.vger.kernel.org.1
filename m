Return-Path: <netdev+bounces-200470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E4AE58D4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B27A1B6014A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1E18DB02;
	Tue, 24 Jun 2025 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw2socHm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81256179A3
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726218; cv=none; b=uaCfKvRTnIkzYeW+J23ICStqfvkjDZR8Mf87BA68GW1BPHn+aQu6Jn7N9e8EI/zzI2L2+N6H/GgH1cxj/Z5i2PpBKIrel5xjqU4dB5uoAJjdaqWOdff8NlmYFws2qlNHdT5cazVU0Dr7cpnnzLaQizHQaFRnbRFH65442TZ2ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726218; c=relaxed/simple;
	bh=/auqGXR0o1/P/foYc6AgZw0KxuJdncmvKGkmkIKxkSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azcWjVn5r9RGU/5o8XyTCvrI+z/1cQg0oRhzRasrvk/gGOHi1fFtJp5PEc8C398K4oz6eeoGsRKxRh1teTg/sI5MYF5eHzo3T51vJVq/1Ko8ADm9GsKd+Eu+Mh5B0Zdg2Qx3uMEeVwopGY1xF9ohXS9lDCyHCiBjMA8J084JgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw2socHm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750726214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/auqGXR0o1/P/foYc6AgZw0KxuJdncmvKGkmkIKxkSQ=;
	b=Hw2socHmMCLeu7lfybV86LQsaGzvvR0Ih4xSp3uoPzn4YygUou62Q3H+WPoS8vx2MVHZ1P
	n6Zv7ywMGc+edyA1g+HR+KXvw6kaiwO6zp9qnkp/m3tknJHXZXetY11urVhHOLWAt86HHg
	VibpRpDiieYUPDMDR1OdK2bkX3zf828=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-apN06B0VPkWczv8aTkmfzg-1; Mon, 23 Jun 2025 20:50:13 -0400
X-MC-Unique: apN06B0VPkWczv8aTkmfzg-1
X-Mimecast-MFC-AGG-ID: apN06B0VPkWczv8aTkmfzg_1750726212
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso6338989a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 17:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750726212; x=1751331012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/auqGXR0o1/P/foYc6AgZw0KxuJdncmvKGkmkIKxkSQ=;
        b=O66om4EkITChTPmMBZqJsY0fSdgFQIv0RrEHo29E3JgbPJvvCeEA/ItGKzINndYcoZ
         u9my9voGSFHRb4vrwDSw/tKYmpkEXxBgstAc0bjW/xsK+ojfVyIQZmKiRiTtZqpkZ7zA
         wWU0MdsSARP1lQMYEK91AMF5V6kgvOBpDDApnU6RL5p6e8TLOfAr6giC0LV1/F1NqdHz
         qNst0uVxjru2oObA2agtwIWdInqjKFAuoTulJrjpcNrB9xvpK6smrtlHkAIjSMiX6pn2
         mjir7MI3xZO+NsooGl8Q4TRUzxLKASeUTpdaclMTdh5VAVkv10v2dVHM+JTLHH/J/cSt
         bQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK7HEyxOD8uJGZ32XgOm/8V7DwALFyvhQ/fAeQpLrOPkVCkJ7z/MGVcxx/92+TjqKo9WUNiD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUngokw2LU4fJsA0oU/oiv6o6gsQY2xZ3nHis7gYOG6vChPY2k
	XqNN+Vjr67hpHVNmPZIe6fNCBqzYeygIr7S4qFxGMS3gjqt1IBFs+WGNtTtKlC6wGAKcDwvUiRJ
	h2vwaNlYwroUGAdklOiC89jL+4Gb0HoFw/GKD8pMYNg8Kuyh7YkV5S7camFgaqNeEE51AZXDAKg
	845p6zQSLN65I1ogRwbIYO6po7gNpJ4qXH
X-Gm-Gg: ASbGncuvMUIB5wFG7xAp62edQcPtT+G4S96TJClCMjl4eE4HxW9/xSkWRmIQb4A1aoc
	ncKefTw7QxZ4EqvCKVT8yJkziapXYzXsRxy/CfpvKwDzs1mLGKgHncAR9Lmh9V3GlufRZzFHyjQ
	OS3sec
X-Received: by 2002:a17:90a:d888:b0:313:f883:5d36 with SMTP id 98e67ed59e1d1-3159d61b385mr20481162a91.1.1750726211541;
        Mon, 23 Jun 2025 17:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2mZ6TFzZC61NvgUQr50RK9GKr+Zt2TEe1NWxDOMMJSfnof6RsI9yY3mdeAsIKTHaPT/FkDTx1NOWeRFhiZ3M=
X-Received: by 2002:a17:90a:d888:b0:313:f883:5d36 with SMTP id
 98e67ed59e1d1-3159d61b385mr20481119a91.1.1750726211082; Mon, 23 Jun 2025
 17:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
 <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com> <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
In-Reply-To: <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:49:58 +0800
X-Gm-Features: AX0GCFuyvFlQ7RhA5QlpqKcUbeYXfBe9mHMJd9IBrNPZibzgOsK55WFol474x3I
Message-ID: <CACGkMEuPsCNuNZbPsAj2d-tqz0RrJGAyPQAjt1nFbJdgtiKsGg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:28=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Mon, Jun 23, 2025 at 11:07=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > > Yuri, can you help to clarify this?
> > >
> > > I see here several questions:
> > > 1. Whether it is ok for the device not to indicate support for XXX_EX=
 hash type?
> > > - I think, yes (strictly speaking, it was better to test that before
> > > submitting the patches )
> > > 2. Is it possible that the guest will enable some XXX_EX hash type if
> > > the device does not indicate that it is supported?
> > > - No (I think this is part of the spec)
> >
> > There's another question, is the device allowed to fallback to
> > VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?
> MSFT expectations for that are at
> https://learn.microsoft.com/en-us/windows-hardware/drivers/network/rss-ha=
shing-types
> If I read them correctly, the answer is "no"

Ok, so I guess it implies the implementation should be ready to deal
with arbitrary length of ipv6 options.

> BTW, my personal opinion is that placing all these things with hash
> calculations into kernel instead of ebpf does not make too much sense.

If I remember correctly, we tried to enable it via eBPF, but failed
due to the rejection of eBPF maintainers.

Maybe we can revisit the idea. But anyhow the hardcoded logic might
still be useful as eBPF is not guaranteed to work in all cases.

Thanks

>
> >
> > > 3. What to do if we migrate between systems with different
> > > capabilities of hash support/reporting/whatever
> > > - IMO, at this moment such case should be excluded and only mechanism
> > > we have for that is the compatible machine version
> > > - in some future the change of device capabilities can be communicate=
d
> > > to the driver and _probably_ the driver might be able to communicate
> > > the change of device capabilities to the OS
> >
> > Are you suggesting implementing all hash types? Note that Akihiko
> > raises the issue that in the actual implementation there should be a
> > limitation of the maximum number of options. If such a limitation is
> > different between src and dst, the difference could be noticed by the
> > guest.
> >
> > > 4. Does it make sense to have fine configuration of hash types mask
> > > via command-line?
> > > - IMO, no. This would require the user to have too much knowledge
> > > about RSS internals
> > >
> > > Please let me know if I missed something.
> > >
> >
> > Thanks
> >
>


