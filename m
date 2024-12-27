Return-Path: <netdev+bounces-154327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F79FD033
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 05:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D13716376C
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0612FB1B;
	Fri, 27 Dec 2024 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Xstp4uhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72735947
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735274057; cv=none; b=WN2fy5jp5exzYJmK85F7yi88l5Yu6stuQKE1L0r5uGKRj9oQGDa/whzj2EoPmv2g8C1cBREzoSukShWQFH7KuyhsMwSwSykzrYX3arufnP8LyzGwm9irkpVEcS90Fd0Hcft8VQgmIpl3zy8ysLPREYkTWt/DiusTWyx5vbpnjno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735274057; c=relaxed/simple;
	bh=FVW7XNY64xuydDmLofP+sTKTUNUDp24hB/HXdgDSItk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSGWGhENIQ1crfAmufXOQrbj0/NGXFDyMrnIb2lcR9Crtd9fIJo1Ehe8HtdLtkc4XRP+SZ8LLeunLcl+OMvvQw5vEGu/D0gjCFXnzjOJStpUItwjOaFDezpIMVG1N656Yd7tvReSZlOLDMe0b5Yd6VBoHky5r5seKMj56WGcKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Xstp4uhf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso6525895a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 20:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735274053; x=1735878853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwCjjlIrKBk+YtuDMOqh5H8o6TB/HNBq181H/Zb/guw=;
        b=Xstp4uhfh13NkilnzVcowH4103wj2tYBtgE78Ll3pLRMwB6JCyZoKElGgUgo4pfupO
         uYwRll+Nnp+2oEtUV+lrT1tOLjaka5cchaR2KlxilAIfgJ8TTLtbcou4ENqmmCoHTQrE
         ReA4XGFR41vl0NIVSvGiXFV+KcyKC/dSbSff8Oed4BrNebgxPkRkBvghc7/IDKds7BWb
         vXVJrHG1dc1Q+fFX9M1r0dExRn4ONqlBbiS0dceMKREn8kCQz8scqOPcwECOsh6iy0JW
         I1YGRDEm8Xp0Nu2UR1KAChpvDJo88qLKy0278pfU809hQzYqzPCIeyK5/vQijsISmFwy
         nXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735274053; x=1735878853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwCjjlIrKBk+YtuDMOqh5H8o6TB/HNBq181H/Zb/guw=;
        b=iT/v8FWEu7zjDj8kAM9Zqy5glKmpQb/fTMzhhIss76GCXQOu3QNkPIxp60O8FICz2a
         zbf1UW1dkJD7OpPNBD350WLNTfXFWf3SJGKl99kOvTz39SEh7eFdwSGxruc0TAoBLI/S
         9eCIbRtDBAZA6d6U9hk4SxtYXJNiLws45hG7Vzun/om3w+Kx/PmZFZPJmPI2vpKRtTj6
         /4gs2/SH1Pbls02CjDZ9srS3SMhSKt6aeDRju3NgQg/ajAspPsxITcxkYIXsisaiQ0i4
         QJrLiBJeAVvZpc1MxN0iKyiOXorI8KlWTO8Hhom5Bk0/ZbyuDfPu6un7CMzUbFhu2EwK
         2Dag==
X-Forwarded-Encrypted: i=1; AJvYcCVC6/QLOHnvUy+H13M2kbkLWmc5v1lP67kMnLmTdlZ0NkKKUAGTkf8cBn3pYShLEWUSjXPlu14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NTUUxncJqR5bMFeXvNscyXRQZ8eNnYdhOYIYFh/aEbUfOYiV
	giO4WkqYJLkguwzqv65mjADoDRAp8+OWZ7YfLWJ4SCQOl5bSIzRX8j8luK37Pfw=
X-Gm-Gg: ASbGncuLbT4YJPqkIbAV/EJjBoDzkXKmGivrIpm+X67HHQqpH3I6kevILmwASIKJUUg
	Xbo26AOwScyMhEF2+7l3StLKp6KzKbfxEUfkLQp75q1Q8/d3edGuQMP/21tdkAWRJ3NfRzaXjiH
	JHLdm3MtPc7uGADSvMLgNoi4FVdt8ofE9reGnvi8aKUsIw0g96K7VXbNZtoD7bepJW/rvqva3FA
	LQ1rLQzch7TFATlF0nyCDIyzJ+mNv/pHn+ovXq9BXfKcXTRy30MyIQF4pYzF4wp0Nv+Qg==
X-Google-Smtp-Source: AGHT+IHbpgq5016PFvFeTeZ6RoKGAfu8Cv7iPr2JE4+A0XviJrDeYl5kAk/GomPB/LPyZ9Od5C0lCQ==
X-Received: by 2002:a17:90a:c2ce:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2f452eb24b8mr34814458a91.23.1735274053570;
        Thu, 26 Dec 2024 20:34:13 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478a92absm14894900a91.44.2024.12.26.20.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 20:34:13 -0800 (PST)
Message-ID: <cd4a2384-33e9-4efd-915a-dd6fee752638@daynix.com>
Date: Fri, 27 Dec 2024 13:34:10 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
 <20241106035029-mutt-send-email-mst@kernel.org>
 <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
 <20241226064215-mutt-send-email-mst@kernel.org>
 <CACGkMEug-83KTBQjJBEKuYsVY86-mCSMpuGgj-BfcL=m2VFfvA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEug-83KTBQjJBEKuYsVY86-mCSMpuGgj-BfcL=m2VFfvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/12/27 10:29, Jason Wang wrote:
> 
> 
> On Thu, Dec 26, 2024 at 7:54 PM Michael S. Tsirkin <mst@redhat.com 
> <mailto:mst@redhat.com>> wrote:
> 
>     On Mon, Nov 11, 2024 at 09:27:45AM +0800, Jason Wang wrote:
>      > On Wed, Nov 6, 2024 at 4:54 PM Michael S. Tsirkin <mst@redhat.com
>     <mailto:mst@redhat.com>> wrote:
>      > >
>      > > On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
>      > > > The specification says the device MUST set num_buffers to 1 if
>      > > > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>      > > >
>      > > > Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
>      > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > >
>      > > True, this is out of spec. But, qemu is also out of spec :(
>      > >
>      > > Given how many years this was out there, I wonder whether
>      > > we should just fix the spec, instead of changing now.
>      > >
>      > > Jason, what's your take?
>      >
>      > Fixing the spec (if you mean release the requirement) seems to be
>     less risky.
>      >
>      > Thanks
> 
>     I looked at the latest spec patch.
>     Issue is, if we relax the requirement in the spec,
>     it just might break some drivers.
> 
>     Something I did not realize at the time.
> 
>     Also, vhost just leaves it uninitialized so there really is no chance
>     some driver using vhost looks at it and assumes 0.
 > >
> So it also has no chance to assume it for anything specific value.

Theoretically, there could be a driver written according to the 
specification and tested with other device implementations that set 
num_buffers to one.

Practically, I will be surprised if there is such a driver in reality.

But I also see few reasons to relax the device requirement now; if we 
used to say it should be set to one and there is no better alternative 
value, why don't stick to one?

I sent v2 for the virtio-spec change that retains the device requirement 
so please tell me what you think about it:
https://lore.kernel.org/virtio-comment/20241227-reserved-v2-1-de9f9b0a808d@daynix.com/T/#u

> 
> 
>     There is another thing out of spec with vhost at the moment:
>     it is actually leaving this field in the buffer
>     uninitialized. Which is out of spec, length supplied by device
>     must be initialized by device.
> 
> 
> What do you mean by "length" here?
> 
> 
> 
>     We generally just ask everyone to follow spec.
> 
> 
> Spec can't cover all the behaviour, so there would be some leftovers.
> 
>        So now I'm inclined to fix
>     it, and make a corresponding qemu change.
> 
> 
>     Now, about how to fix it - besides a risk to non-VM workloads, I dislike
>     doing an extra copy to user into buffer. So maybe we should add an ioctl
>     to teach tun to set num bufs to 1.
>     This way userspace has control.
> 
> 
> I'm not sure I will get here. TUN has no knowledge of the mergeable 
> buffers if I understand it correctly.

I rather want QEMU and other vhost_net users automatically fixed instead 
of opting-in the fix.

The extra copy overhead can be almost eliminated if we initialize the 
field in TUN/TAP; they already writes other part of the header so we can 
simply add two bytes there. But I wonder if it's worthwhile.

Regards,
Akihiko Odaki

