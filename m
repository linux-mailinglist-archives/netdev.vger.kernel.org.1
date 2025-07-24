Return-Path: <netdev+bounces-209720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D7CB10934
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB5AAA7CE8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6472727FB;
	Thu, 24 Jul 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxEZIqCF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547132750F6
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356559; cv=none; b=TLHf11EnxTEW+vO2iSoo3SAtATru6nuV5bSn0p6tzFljRGYlx586B17d2utVrXEhflcDhbNUCEsOzF8BSbMhuINs4lb9sFzXOraobbrl4sOnLCl5fht9A6gclOKXwKhj/3fuBYURLlP6gmx7ufMkSdqhDZMj6bttwo7rfjmZiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356559; c=relaxed/simple;
	bh=QY0wlUrEs+xJ2iTSKItWw+fa8SF+sXILwbTVtqS4H64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgticiQQL2cyPlBfeBaqs99NLbaPcxcvZ+9bdjnhRMnj9MRK17Kerq3iwDBa/XPvorAkawwIac50us/FekZ2sv5ryIryi6EpmUKZTi7dnkqECs84B3bcU2sh6ZvrgK5FjEipGdEKOat5KtHp+BQvRrhPEw3lXAqRI8FCzNRa92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxEZIqCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753356551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq7Lq11sSeC7Cvxw/pznO7BsVopFEA44F2tSa+vLiTo=;
	b=PxEZIqCFg+cb5prhGK+mAP6zz1Ns4s1kwKrWyU5myR6tI2vuJYNKXIUwsaSUoX8fYxHyAb
	/cNeGG3rjLP+ytPqRrf4+69AEcbZX0KfGCoHwLS9FM0c1hQLQB+xWbtUEEUKVmJ4wxGwws
	UtUdxxEUgh9VPG4/rTPXIbuZ//0UM6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-hhbpGuFPPLWrg8dFNVGo4w-1; Thu, 24 Jul 2025 07:29:09 -0400
X-MC-Unique: hhbpGuFPPLWrg8dFNVGo4w-1
X-Mimecast-MFC-AGG-ID: hhbpGuFPPLWrg8dFNVGo4w_1753356546
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so561883f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 04:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753356546; x=1753961346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq7Lq11sSeC7Cvxw/pznO7BsVopFEA44F2tSa+vLiTo=;
        b=K9nPbIWGzospypfeaC09Vu76QFiqB0XGtoqm6dA9CaYFui8AHmXOn5j3AwIEmmMweI
         7pOk6WFkIv7ayRqhQRmhAuyFnlwCuCFngjNI2A76hB6jquJawD/q0zrwcVf9sTwwZQqm
         N9QYsbr8peD/Ngwc5H8kcUVAe+N7UFXwuyk0xUdMhayNnBgSORx0EZ9cQYJG2yT/Qh6j
         u6afKcteICQPG9g+4Wx26vsf3jCy5LiYG45L6YNiI+0phdYB0JFbbnMiznRiCR6AAw2O
         Je4JGV2l96ls/OqvemSKIaWRGm77aFT2U9n+8Jkr0+ZTmcJ0zqmNuai0m2dMWaN9utIC
         i5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVb33XLWVBVpT2bnTZb3oGGY7mFchbSWkaHN0m6Z9ZACtyQP8itRI6e0bbJvy1siF5f3tE7zdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3G/jK1DDVp2WD0oEHvs57RZRMj36ctKz/+G+uMl4VxMkiuQ7F
	AQwW+tFQc/8nvl6tJ/R/n57SpiCyD73WaWBWBfEwo0jRArnbUzJAy5pca+2sNWPD3nrO5HWSwHV
	/NMciD/Misbt9LtahqRoe1FR7GgHLEg9t4IExguaYWGCDM7fPNxjh4QrdTQ==
X-Gm-Gg: ASbGncvSi+a+xSwq03FkJ9b+HgkiYCQGw8pjaL9uzi4g9Yxe6J1wTOhzyNCVKTaw+l3
	sGcpVbvMn4OoC/fY+G+T4EBnHWy646C7VE4Q1NZyZeA3KGVRjookHvx3md1xsb4/xagP/90qQEx
	MbwB2tbmlFfwAFGhHlcSJh8UsztQHJWRwXPVUr1H+6ppZ+U1uRTGTZ0u7CbW8oZNQvm0xrBJhhS
	Nbq9W+/lf8jv8lD1pu7d9+gvq8nrsFOiEb3Tar9hQLsKovtPKQNpt5n0F3qVUMkYAc6hvY8dkAn
	Uqbxg4sTQImKECEZm1mHE+ANwR2q2oYKsj4AA2ryZqdC+NcS0S5pvUAC0rQuE33QeVBdecZDDvq
	F/zNiELWTClM=
X-Received: by 2002:a05:6000:2881:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b768c9c1afmr5715452f8f.11.1753356545555;
        Thu, 24 Jul 2025 04:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo6z1ZFZkYTQYv6CwccSDc9KdW97fsCA+nZmqQdSdRp5JW0Quv8SFSpGZcc+a5A91+j+t4DA==
X-Received: by 2002:a05:6000:2881:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b768c9c1afmr5715424f8f.11.1753356545042;
        Thu, 24 Jul 2025 04:29:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6d085sm1867039f8f.21.2025.07.24.04.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:29:04 -0700 (PDT)
Message-ID: <3b92595e-c426-4b90-8905-8ba75e7f722a@redhat.com>
Date: Thu, 24 Jul 2025 13:29:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio_close() stuck on napi_disable_locked()
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zigit Zo <zuozhijie@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
 <20250722145524.7ae61342@kernel.org>
 <CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
 <83470afc-31f1-4696-91f3-2587317cb3a1@redhat.com>
 <CACGkMEtg00ih8tv4LTgxNkUEREF5vzYP=dKrth_eFPbEDZg11w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtg00ih8tv4LTgxNkUEREF5vzYP=dKrth_eFPbEDZg11w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/24/25 12:53 PM, Jason Wang wrote:
> On Thu, Jul 24, 2025 at 4:43 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/23/25 7:14 AM, Jason Wang wrote:
>>> On Wed, Jul 23, 2025 at 5:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>> On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
>>>>> The NIPA CI is reporting some hung-up in the stats.py test caused by the
>>>>> virtio_net driver stuck at close time.
>>>>>
>>>>> A sample splat is available here:
>>>>>
>>>>> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stats-py/stderr
>>>>>
>>>>> AFAICS the issue happens only on debug builds.
>>>>>
>>>>> I'm wild guessing to something similar to the the issue addressed by
>>>>> commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
>>>>> but I could not spot anything obvious.
>>>>>
>>>>> Could you please have a look?
>>>>
>>>> It only hits in around 1 in 5 runs.
>>>
>>> I tried to reproduce this locally but failed. Where can I see the qemu
>>> command line for the VM?
>>>
>>>> Likely some pre-existing race, but
>>>> it started popping up for us when be5dcaed694e ("virtio-net: fix
>>>> recursived rtnl_lock() during probe()") was merged.
>>>
>>> Probably but I didn't see a direct connection with that commit. It
>>> looks like the root cause is the deadloop of napi_disable() for some
>>> reason as Paolo said.
>>>
>>>> It never hit before.
>>>> If we can't find a quick fix I think we should revert be5dcaed694e for
>>>> now, so that it doesn't end up regressing 6.16 final.
>>
>> I tried hard to reproduce the issue locally - to validate an eventual
>> revert before pushing it. But so far I failed quite miserably.
>>
> 
> I've also tried to follow the instructions of nipai for setup 2 virtio
> and make the relevant taps to connect with a bridge on the host. But I
> failed to reproduce it locally for several hours.
> 
> Is there a log of the execution of nipa test that we can know more
> information like:
> 
> 1) full qemu command line

I guess it could depend on vng version; here I'm getting:

qemu-system-x86_64 -name virtme-ng -m 1G -chardev
socket,id=charvirtfs5,path=/tmp/virtmebyfqshp5 -device
vhost-user-fs-device,chardev=charvirtfs5,tag=ROOTFS -object
memory-backend-memfd,id=mem,size=1G,share=on -numa node,memdev=mem
-machine accel=kvm:tcg -M microvm,accel=kvm,pcie=on,rtc=on -cpu host
-parallel none -net none -echr 1 -chardev
file,path=/proc/self/fd/2,id=dmesg -device virtio-serial-device -device
virtconsole,chardev=dmesg -chardev stdio,id=console,signal=off,mux=on
-serial chardev:console -mon chardev=console -vga none -display none
-smp 4 -kernel ./arch/x86/boot/bzImage -append virtme_hostname=virtme-ng
nr_open=1073741816
virtme_link_mods=/data/net-next/.virtme_mods/lib/modules/0.0.0
virtme_rw_overlay0=/etc virtme_rw_overlay1=/lib virtme_rw_overlay2=/home
virtme_rw_overlay3=/opt virtme_rw_overlay4=/srv virtme_rw_overlay5=/usr
virtme_rw_overlay6=/var virtme_rw_overlay7=/tmp console=hvc0
earlyprintk=serial,ttyS0,115200 virtme_console=ttyS0 psmouse.proto=exps
"virtme_stty_con=rows 32 cols 136 iutf8" TERM=xterm-256color
virtme_chdir=data/net-next virtme_root_user=1 rootfstype=virtiofs
root=ROOTFS raid=noautodetect ro debug
init=/usr/lib/python3.13/site-packages/virtme/guest/bin/virtme-ng-init
-device
virtio-net-pci,netdev=n0,iommu_platform=on,disable-legacy=on,mq=on,vectors=18
-netdev tap,id=n0,ifname=tap0,vhost=on,script=no,downscript=no,queues=8
-device
virtio-net-pci,netdev=n1,iommu_platform=on,disable-legacy=on,mq=on,vectors=18
-netdev tap,id=n1,ifname=tap1,vhost=on,script=no,downscript=no,queues=8

I guess the significant part is: ' -smp 4 -m 1G'. The networking bits
are the verbatim configuration from the wiki.

> 2) host kernel version

I can give a reasonably sure answer only for this point; the kernel is
'current' net-next with 'current' net merged in and all the patches
pending on patchwork merged in, too.

For a given tests iteration nipa provides a snapshot of the patches
merged in, i.e. for tests run on 2025/07/24 at 00:00 see:

https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-hw-2025-07-24--00-00.html

> 3) Qemu version

Should be a stock, recent ubuntu build.

/P


