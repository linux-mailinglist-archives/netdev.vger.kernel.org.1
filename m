Return-Path: <netdev+bounces-225588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AECB95B67
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE26F7B3B61
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695E322545;
	Tue, 23 Sep 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efdAqGt+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB675311945
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627738; cv=none; b=P5GnFcfAOTvHZphoTNrQQNTOHAhLjgDiSexe97hlgwWhgQx36GMMhQ35xg+m3F9AW34e9l+yacKyb+XCnDsu7VKLfNjV898XZJpYMXVEjXo3T87rvYg5zyl8SP5REZ7UPaVqVTefODgn3KvoDmdtTKtuaMppxrJZv0SQWIMzY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627738; c=relaxed/simple;
	bh=G8RMdmZL4fdCH9fRdyOpBtwiZHkjTotcoV1Ff2ChtfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IKGjV3OL2e10/FksZaSjUfXimmoFMakOlfOwFepOUbZA7vkWFS2OfBpz+icCrh5zm60ZhODZCry3AAp8AGMC7aC0yaYoy9SgxaZ+eKAigFc+FVkSeUHZI9tmAXTvj1DExldFJtAcjfjM5P1sVJZ692D1TU8qqi8ZXX26PaOe/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efdAqGt+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758627733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TUxr2PcYQo3Gqe2ITI3w1kddbm1Woi0UL2ab5WEwRM=;
	b=efdAqGt+WKJblAMFq5Xvll0BsZCB9RmQ312crZrMM3mKFf6S5ySAdfY8fhVthWvSJL0NKP
	CtM5ZUono2zJ2WgRuZeA5fWC/BCmCzaoWxyDScOJbG6d0iDFA571RLNSbdWHpCyIW3QsDv
	ooszxFBWZA9cPxFswY2oa6gdQlNxxoQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-OgakBrbQOW-xmu05GJwuDQ-1; Tue, 23 Sep 2025 07:42:12 -0400
X-MC-Unique: OgakBrbQOW-xmu05GJwuDQ-1
X-Mimecast-MFC-AGG-ID: OgakBrbQOW-xmu05GJwuDQ_1758627730
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6232f49fc79so5748294a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 04:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758627730; x=1759232530;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TUxr2PcYQo3Gqe2ITI3w1kddbm1Woi0UL2ab5WEwRM=;
        b=SB0PDIvilOlXoZVfn9VtzuQ/xLySGco5k0yKBxKLwYwt1eUypPZr+Gh5Fs7zurVmOf
         inhdnCcJ6GKIA1sXMz+pF4kzd8Z7y9mgqG9cRDepbNzS0aJj6b0v737D5Kl6UKA3M3qh
         239fFF2MQm747PNkT9gmOkJMV0Il0x1fxro+HGwgenplLlAGAyH5cnwA46ddELYunDo2
         Nd+ohYFnxrJMZY0g6u4h+mY1jOt8lm81j2w7P8l0Qd01Gou95Mm+i8OGF8nbv6z4f2+S
         SULgXBget/+K2pbVxddq3qRVYG2Y0Qcveq9KajtxFVqnu5SuR/3sNFYjxGfuzuN6/hae
         faDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV581JmDeYGUtuqxdrBWXKBaM/i+XINA8e+MSYtTl302D62iUv5H1MCawYPEH/LyNJiESYl4LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfwThWYXKVvmLBqXD4gUjJyL/VdMB6ZRS1nx4i+yDPRspbS5t
	8Te0PawCbriRqpe4mwEWmcrfWGINAX9N85Af6Iz8WMBJe8kE6QZrSK+SA0M+OdILzfcTwhChoSe
	1EbkLY2PPRGL6zUjjX+dlUFl8YKBhFadMDL/517nKkGaH2wZRz2Hnz16i5w==
X-Gm-Gg: ASbGncu3iH6TFnDBeY+23Nq2wD2LE9zOg9ZkFflFU+unw3udckHFU0ytHwqLlrpktCT
	7AlEGhWSvZvbwoi+Vtu3aLCWmD0QqMXLNifrSL0/v8onAbCATYQg3G4bGjef57sKBDKNhvRXj4Z
	qyCBCmRa0WG2AESk3N5rS7TAN7pAbxlBhvoGYGGg9MbhNbmAVtmRauA/iL3tdLsSeyAIQ7e1jRP
	4sqPkUPhkcX4sfyFjjEFV9m4Debd47JOXrLSm2gEgsPZYQOWc0XvDviM9NbPW5nimlrenzxHJkK
	AdKd0BLc9yGQDNv0uvPC/kmjNnS8ZiCm2KvFzrCBkWF4gApMtd7F9LcRTeu72+9RLYk=
X-Received: by 2002:a05:6402:27d3:b0:634:5705:5705 with SMTP id 4fb4d7f45d1cf-63467777e5dmr2034128a12.12.1758627730037;
        Tue, 23 Sep 2025 04:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVsCDpc5IWoUNh9WXpVz7PEvJx30W355c6iit1K0jZJgJ5OlHyps2N1qPVh8fX81j05Kd6qg==
X-Received: by 2002:a05:6402:27d3:b0:634:5705:5705 with SMTP id 4fb4d7f45d1cf-63467777e5dmr2034107a12.12.1758627729508;
        Tue, 23 Sep 2025 04:42:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d06a15sm11013207a12.1.2025.09.23.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:42:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BEABB276C0D; Tue, 23 Sep 2025 13:42:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 19/20] netkit: Add xsk support for af_xdp
 applications
In-Reply-To: <20250919213153.103606-20-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-20-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Sep 2025 13:42:07 +0200
Message-ID: <87zfalpf8w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> Enable support for AF_XDP applications to operate on a netkit device.
> The goal is that AF_XDP applications can natively consume AF_XDP
> from network namespaces. The use-case from Cilium side is to support
> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
> virtual machine management add-on for Kubernetes which aims to provide
> a common ground for virtualization. KubeVirt spawns the VMs inside
> Kubernetes Pods which reside in their own network namespace just like
> regular Pods.
>
> Raw QEMU AF_XDP backend example with eth0 being a physical device with
> 16 queues where netkit is bound to the last queue (for multi-queue RSS
> context can be used if supported by the driver):
>
>   # ethtool -X eth0 start 0 equal 15
>   # ethtool -X eth0 start 15 equal 1 context new
>   # ethtool --config-ntuple eth0 flow-type ether \
>             src 00:00:00:00:00:00 \
>             src-mask ff:ff:ff:ff:ff:ff \
>             dst $mac dst-mask 00:00:00:00:00:00 \
>             proto 0 proto-mask 0xffff action 15
>   # ip netns add foo
>   # ip link add numrxqueues 2 nk type netkit single
>   # ynl-bind eth0 15 nk
>   # ip link set nk netns foo
>   # ip netns exec foo ip link set lo up
>   # ip netns exec foo ip link set nk up
>   # ip netns exec foo qemu-system-x86_64 \
>           -kernel $kernel \
>           -drive file=${image_name},index=0,media=disk,format=raw \
>           -append "root=/dev/sda rw console=ttyS0" \
>           -cpu host \
>           -m $memory \
>           -enable-kvm \
>           -device virtio-net-pci,netdev=net0,mac=$mac \
>           -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>           -nographic

So AFAICT, this example relies on the control plane installing an XDP
program on the physical NIC which will redirect into the right socket;
and since in this example, qemu will install the XSK socket at index 1
in the xsk map, that XDP program will also need to be aware of the queue
index mapping. I can see from your qemu commit[0] that there's support
on the qemu side for specifying an offset into the map to avoid having
to do this translation in the XDP program, but at the very least that
makes this example incomplete, no?

However, even with a complete example, this breaks isolation in the
sense that the entire XSK map is visible inside the pod, so a
misbehaving qemu could interfere with traffic on other queues (by
clearing the map, say). Which seems less than ideal?

Taking a step back, for AF_XDP we already support decoupling the
application-side access to the redirected packets from the interface,
through the use of sockets. Meaning that your use case here could just
as well be served by the control plane setting up AF_XDP socket(s) on
the physical NIC and passing those into qemu, in which case we don't
need this whole queue proxying dance at all.

So, erm, what am I missing that makes this worth it (for AF_XDP; I can
see how it is useful for other things)? :)

-Toke

[0] https://gitlab.com/qemu-project/qemu/-/commit/e53d9ec7ccc2dbb9378353fe2a89ebdca5cd7015


