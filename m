Return-Path: <netdev+bounces-226622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDCEBA3081
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DBC624379
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548929B229;
	Fri, 26 Sep 2025 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGG2Y4LC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1429A300
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876966; cv=none; b=QN/vlODIBG9moRUBuPYLxys1tckk2ZUqk/khutW0syLETs1FtXgozWKGL1sx9YxQnP+Sh6EqvbOM8yFX/QcvNxRV336owuZKCqPur7+OMSRkVPzId9qy3O0CMIbuakjBUfSCyEW+sUiEKvz20wngl+f96F5xoDHhzyxmqXUq7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876966; c=relaxed/simple;
	bh=wiLl+QzGP4jkl9gd7uZj88hnx36VRjSUVnnmvbJs20I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ES7ZgqU7RWd4BaoR0r3fV5q3g5JPLW29cp1lTIxp61OBmi1YAw1qAM4eyvEqbQRyLoeRjp8fukKnl8ORX8cJd+qSNu7FDbDij+qQPCnYCDoDX5qmvKWb4Ob11/XASM7oR0Gpwl3+KdCQiXtyN3dE8Y5lMp8FpuajeolHJar8yaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGG2Y4LC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758876963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C67xH3Vlopkqdp7cUYZYysDv/9rtz6w4Y9k2ipC7sI4=;
	b=gGG2Y4LCvq3lxbPJOprZ/ayf/KyShMJc8Y8HTfna6HqceUU0l6MTMOZqs7LM6KBQfCPFfV
	GK+Ufc4hvs9k0Yc69NiOP5C/KAqu6Gl3dYMPk1ISKJbruXGdD3gx8UljUxYA41vGrJjgzw
	AB+H3R71pt3UPXdlqKGQMxNEN3VHnY8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-lPTU8e7RMrOcQ_EWDRbO-w-1; Fri, 26 Sep 2025 04:56:02 -0400
X-MC-Unique: lPTU8e7RMrOcQ_EWDRbO-w-1
X-Mimecast-MFC-AGG-ID: lPTU8e7RMrOcQ_EWDRbO-w_1758876961
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6339aa08acfso2705823a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876961; x=1759481761;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C67xH3Vlopkqdp7cUYZYysDv/9rtz6w4Y9k2ipC7sI4=;
        b=Kbv8SeRu2aEdJRvrHMs/Z4q3/qXbY4aB/7D7qB5GgXfYJ/hI4m7ifi5w2mSvhr15Wv
         UzoyqQzBhkoDXLyqSfbWuLEafIoCDiPFD9QR84JHmCRM5bw3JW4x4aaDeAq+Kk766+Y5
         Jeiieq8VfEQzxXL4DT4a0iWG45dzwaXKfYDLjbbc1TqhvmpJOXG/5c3F6kalG/TI7Wnn
         4hhB//ex5JiGGCO1q1eBPlPtLD/IIK1Klcxh3/LYP6d+x0juMZ6f+pM8Fi3xxwDdWWyf
         4dC6VP0Mzn1wDUpnPXQrHkM8CPMGjl9Hp9cLUAXsjY/l7B/vRnpI2umWBpXgtKHODREk
         Wvlg==
X-Forwarded-Encrypted: i=1; AJvYcCV2a1lq44E9Xg8V84Zwq/93FH9bOj35IWkDUPmi4y6kGLJyd0/T3CpQ4OEGzxNkZ1hzP7/TV0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYaNYemn5oJpe8mvkL/daa8mf05gs8lJMzs0elXKiIHUuL+fR
	1AiD32HOItqxT9k3/y2sepszNeWF8hUMQ2p/4vASrCVbliqNZz6HWslEEgxg2zpehjwHoczSvo2
	wYVBChJldTDimrceW22eoJPdHCUOwxWQ/f8drxjPU4qNQi8xCcscggLwHYneZrGwhqQ==
X-Gm-Gg: ASbGncu4vnu+NAFuO6oIqvHUlbrpTyxqBC2mZYKJwKFNRjgRvRw2AWm6RWBPFgvOVVe
	1OIxC77lE0TZQvISBoGx80MN3WexPbvCWkyxY+TSu2Sz0olAxCrYa20A2XQXB4k1uyhdnfNE0kn
	uhLD7fuRdZl5jDbyQdOKT+6QEpLaBC0Ogpz/WubE17o77xc/kCIoogPjUUXJavBmNs2Ubi9IPSG
	QZYGrgicfXWmViPYxTCtrBen/BBKV4fH/IAEZvIh88d/zadqKXdgqfADLxh+GeVtApeQF8LfFW8
	+tGK9o6ZqpnebkQuSL24KtNb/G5aYOqzuVIcWPnFkizOOf/ABXmrAUZDj/1y5ZsJ
X-Received: by 2002:a05:6402:23d6:b0:633:14bb:dcb1 with SMTP id 4fb4d7f45d1cf-634a332f3fcmr4932594a12.11.1758876960624;
        Fri, 26 Sep 2025 01:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHab/SkJB4tH1HftkLBDBn0zd3NxTVPVjI7bTzKn4ouyJoGVkSgFQIIFCEApQe8Ufb4NT3s5w==
X-Received: by 2002:a05:6402:23d6:b0:633:14bb:dcb1 with SMTP id 4fb4d7f45d1cf-634a332f3fcmr4932567a12.11.1758876960175;
        Fri, 26 Sep 2025 01:56:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629cbdsm2546635a12.3.2025.09.26.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:55:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 641E7277197; Fri, 26 Sep 2025 10:55:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 19/20] netkit: Add xsk support for af_xdp
 applications
In-Reply-To: <5d139efa-c78e-4323-b79d-bbf566ac19b8@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-20-daniel@iogearbox.net> <87zfalpf8w.fsf@toke.dk>
 <5d139efa-c78e-4323-b79d-bbf566ac19b8@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 26 Sep 2025 10:55:57 +0200
Message-ID: <87plbdoan6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 9/23/25 1:42 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>=20
>>> Enable support for AF_XDP applications to operate on a netkit device.
>>> The goal is that AF_XDP applications can natively consume AF_XDP
>>> from network namespaces. The use-case from Cilium side is to support
>>> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
>>> virtual machine management add-on for Kubernetes which aims to provide
>>> a common ground for virtualization. KubeVirt spawns the VMs inside
>>> Kubernetes Pods which reside in their own network namespace just like
>>> regular Pods.
>>>
>>> Raw QEMU AF_XDP backend example with eth0 being a physical device with
>>> 16 queues where netkit is bound to the last queue (for multi-queue RSS
>>> context can be used if supported by the driver):
>>>
>>>    # ethtool -X eth0 start 0 equal 15
>>>    # ethtool -X eth0 start 15 equal 1 context new
>>>    # ethtool --config-ntuple eth0 flow-type ether \
>>>              src 00:00:00:00:00:00 \
>>>              src-mask ff:ff:ff:ff:ff:ff \
>>>              dst $mac dst-mask 00:00:00:00:00:00 \
>>>              proto 0 proto-mask 0xffff action 15
>>>    # ip netns add foo
>>>    # ip link add numrxqueues 2 nk type netkit single
>>>    # ynl-bind eth0 15 nk
>>>    # ip link set nk netns foo
>>>    # ip netns exec foo ip link set lo up
>>>    # ip netns exec foo ip link set nk up
>>>    # ip netns exec foo qemu-system-x86_64 \
>>>            -kernel $kernel \
>>>            -drive file=3D${image_name},index=3D0,media=3Ddisk,format=3D=
raw \
>>>            -append "root=3D/dev/sda rw console=3DttyS0" \
>>>            -cpu host \
>>>            -m $memory \
>>>            -enable-kvm \
>>>            -device virtio-net-pci,netdev=3Dnet0,mac=3D$mac \
>>>            -netdev af-xdp,ifname=3Dnk,id=3Dnet0,mode=3Dnative,queues=3D=
1,start-queue=3D1,inhibit=3Don,map-path=3D$dir/xsks_map \
>>>            -nographic
>>=20
>> So AFAICT, this example relies on the control plane installing an XDP
>> program on the physical NIC which will redirect into the right socket;
>> and since in this example, qemu will install the XSK socket at index 1
>> in the xsk map, that XDP program will also need to be aware of the queue
>> index mapping. I can see from your qemu commit[0] that there's support
>> on the qemu side for specifying an offset into the map to avoid having
>> to do this translation in the XDP program, but at the very least that
>> makes this example incomplete, no?
>>=20
>> However, even with a complete example, this breaks isolation in the
>> sense that the entire XSK map is visible inside the pod, so a
>> misbehaving qemu could interfere with traffic on other queues (by
>> clearing the map, say). Which seems less than ideal?
>
> For getting to a first starting point to connect all things with KubeVirt,
> bind mounting the xsk map from Cilium into the VM launcher Pod which acts
> as a regular K8s Pod while not perfect, its not a big issue given its out
> of reach from the application sitting inside the VM (and some of the
> control plane aspects are baked in the launcher Pod already), so the
> isolation barrier is still VM. Eventually my goal is to have a xdp/xsk
> redirect extension where we don't need to have the xsk map, and can just
> derive the target xsk through the rxq we received traffic on.

Right, okay, makes sense.

>> Taking a step back, for AF_XDP we already support decoupling the
>> application-side access to the redirected packets from the interface,
>> through the use of sockets. Meaning that your use case here could just
>> as well be served by the control plane setting up AF_XDP socket(s) on
>> the physical NIC and passing those into qemu, in which case we don't
>> need this whole queue proxying dance at all.
>
> Cilium should not act as a proxy handing out xsk sockets. Existing
> applications expect a netdev from kernel side and should not need to
> rewrite just to implement one CNI's protocol. Also, all the memory
> should not be accounted against Cilium but rather the application Pod
> itself which is consuming af_xdp. Further, on up/downgrades we expect
> the data plane to being completely decoupled from the control plane,
> if Cilium would own the sockets that would be disruptive which is
> nogo.

Hmm, okay, so the kernel-side RXQ buffering is to make it transparent to
the application inside the pod? I guess that makes sense; would be good
to mention in the commit message, though (+ the bit about the map
needing to be in sync) :)

>> So, erm, what am I missing that makes this worth it (for AF_XDP; I can
>> see how it is useful for other things)? :)
> Yeap there are other use cases we've seen from Cilium users as well,
> e.g. running dpdk applications on top of af_xdp in regular k8s Pods.

Yeah, being able to do stuff like that without having to rely on SR-IOV
would be cool, certainly!

-Toke


