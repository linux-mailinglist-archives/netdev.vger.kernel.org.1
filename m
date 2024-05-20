Return-Path: <netdev+bounces-97163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00B8C9A02
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE146B21E73
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF21CA85;
	Mon, 20 May 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEqy4Ccn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607511B974
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195338; cv=none; b=pM8UDNvKTZkqv/8Yn2G4K5KdMqv1Nfn2HSeN1QvMVItSsL/969LYYWrN4tHuHl90LyP3rqHKav5IoWlwgxjBAB0HkxqFDP1rnSqC75jHXC8KfZfX+wTwL/+xxhKEN2WsU5z7aNHtuG+y6QXsWoLCGidogC230KG0LIHhVGZa59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195338; c=relaxed/simple;
	bh=zOveTwTANzAYimu3FBsiFyK8fzKWl7a/ASIdBtEaTDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6BbWBEl32Mc7tPwtwT0ELgFLcx7nh/YhGjLMdPYXPNNZl+QVXSa/zo2FlYnvoh8Bu6bUtk9AywOQAtkAzXEVl0nSzM9w40Eu7Tn379tJla29p62injj8fD/dswkNtivAV8kvz7rxakEGqyFNHaqEuvCd1xUjhcK3QSsiaU6cWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEqy4Ccn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716195335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ude2J6/YxYo8bNsBtIomuhFYlpHiE03QinnQpgm+Mes=;
	b=MEqy4CcnyoMmxRblRshGdRE/6lV1imnM5I4tkIqm+MhqE8UarsMrBlN8x+n+AOl3BLN/u+
	qfEy7zR/Urn0v+dA4fVo9dYhEwY1QVCNqm2xBj7nd8uXRRAOu/33romrc4rxmMqWgi4+ua
	OCvTlDtzwicjaPPl6RsiEr/CNoCb0h4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-n7yM47NnNFyMDgLnnCokEw-1; Mon, 20 May 2024 04:55:33 -0400
X-MC-Unique: n7yM47NnNFyMDgLnnCokEw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a137f8fc62so143225476d6.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 01:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716195333; x=1716800133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ude2J6/YxYo8bNsBtIomuhFYlpHiE03QinnQpgm+Mes=;
        b=SMaYZWU0sgSDJA5A8m+rxQIlKB3Z3PF2jsvy8+Bc6UGqarWoPT3gg/WRCWI462GtLb
         OfmSYrPi3fGkA7cPo9FbWc3+XEV12vAec3cGCJECxdiSotneGrVfh5YxmI8rqN0SxuRo
         vSKVWE4A2UknUD8cyqmjB6jI0RaqKuOoy0a0Ct04ulrF3I5ZF1o60811J+8xTpQTcdZX
         dvUDwy2s4igUEA5A0HWEEtqGtmRY4lKLJ28tBB/50tVjBCiNA1k8sz4dtMjrC3CXxva9
         BvHf3W+5An/u/dv1PNDzyt95TZX6A6b5I6HO12PTN5DRjkfIdCyL5CgWTjaBGuyvQtcc
         vOBA==
X-Forwarded-Encrypted: i=1; AJvYcCXbwJHl+BfX8d2N/VWsL+AN0aGFW3O5Q+cCkmTUyR59mqwaDOBYz/Awhs0M7/rlJsszF9X0FDIPRGW5um7TdCAC4O7Kn9iK
X-Gm-Message-State: AOJu0YyipqacaTq6QppiP27PKX83Z//Nbgm/MNCjz9dVBBDXddOFZI5j
	YnU0pRusbdPjXY123dDWIzfegPkXBoD+r1hW2nnO/oR/VkZgjgZ1ilMVEs1Ug1euFEILM9mM9y8
	vqZHYKUBtjYeUhniqmJe4Bep3cj4ZqqUTBHeQB/+Kwrl0xQBPt5k1fjWpNRnxKA==
X-Received: by 2002:a05:6214:5d05:b0:69b:2523:fcd3 with SMTP id 6a1803df08f44-6a16825d79dmr338328316d6.60.1716195332672;
        Mon, 20 May 2024 01:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR8gdnVof1nmsWGREGF+KmJcs+xK22+zO3SVF1/gM6fpWReTV080ow/jA5YNvO2eD5VdzcYw==
X-Received: by 2002:a05:6214:5d05:b0:69b:2523:fcd3 with SMTP id 6a1803df08f44-6a16825d79dmr338328186d6.60.1716195332350;
        Mon, 20 May 2024 01:55:32 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it. [87.12.25.77])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194da1sm109949106d6.67.2024.05.20.01.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:55:31 -0700 (PDT)
Date: Mon, 20 May 2024 10:55:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, Alexander Graf <graf@amazon.com>, agraf@csgraf.de, 
	stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <4i525r6irzjgibqqtrs3qzofqfifws2k3fmzotg37pyurs5wkd@js54ugamyyin>
References: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>

Hi Dorjoy,

On Sat, May 18, 2024 at 04:17:38PM GMT, Dorjoy Chowdhury wrote:
>Hi,
>
>Hope you are doing well. I am working on adding AWS Nitro Enclave[1]
>emulation support in QEMU. Alexander Graf is mentoring me on this work. A v1
>patch series has already been posted to the qemu-devel mailing list[2].
>
>AWS nitro enclaves is an Amazon EC2[3] feature that allows creating isolated
>execution environments, called enclaves, from Amazon EC2 instances, which are
>used for processing highly sensitive data. Enclaves have no persistent storage
>and no external networking. The enclave VMs are based on Firecracker microvm
>and have a vhost-vsock device for communication with the parent EC2 instance
>that spawned it and a Nitro Secure Module (NSM) device for cryptographic
>attestation. The parent instance VM always has CID 3 while the enclave VM gets
>a dynamic CID. The enclave VMs can communicate with the parent instance over
>various ports to CID 3, for example, the init process inside an enclave sends a
>heartbeat to port 9000 upon boot, expecting a heartbeat reply, letting the
>parent instance know that the enclave VM has successfully booted.
>
>The plan is to eventually make the nitro enclave emulation in QEMU standalone
>i.e., without needing to run another VM with CID 3 with proper vsock

If you don't have to launch another VM, maybe we can avoid vhost-vsock 
and emulate virtio-vsock in user-space, having complete control over the 
behavior.

So we could use this opportunity to implement virtio-vsock in QEMU [4] 
or use vhost-user-vsock [5] and customize it somehow.
(Note: vhost-user-vsock already supports sibling communication, so maybe 
with a few modifications it fits your case perfectly)

[4] https://gitlab.com/qemu-project/qemu/-/issues/2095
[5] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock

>communication support. For this to work, one approach could be to teach the
>vhost driver in kernel to forward CID 3 messages to another CID N

So in this case both CID 3 and N would be assigned to the same QEMU
process?

Do you have to allocate 2 separate virtio-vsock devices, one for the 
parent and one for the enclave?

>(set to CID 2 for host) i.e., it patches CID from 3 to N on incoming messages
>and from N to 3 on responses. This will enable users of the

Will these messages have the VMADDR_FLAG_TO_HOST flag set?

We don't support this in vhost-vsock yet, if supporting it helps, we 
might, but we need to better understand how to avoid security issues, so 
maybe each device needs to explicitly enable the feature and specify 
from which CIDs it accepts packets.

>nitro-enclave machine
>type in QEMU to run the necessary vsock server/clients in the host machine
>(some defaults can be implemented in QEMU as well, for example, sending a reply
>to the heartbeat) which will rid them of the cumbersome way of running another
>whole VM with CID 3. This way, users of nitro-enclave machine in QEMU, could
>potentially also run multiple enclaves with their messages for CID 3 forwarded
>to different CIDs which, in QEMU side, could then be specified using a new
>machine type option (parent-cid) if implemented. I guess in the QEMU side, this
>will be an ioctl call (or some other way) to indicate to the host kernel that
>the CID 3 messages need to be forwarded. Does this approach of

What if there is already a VM with CID = 3 in the system?

>forwarding CID 3 messages to another CID sound good?

It seems too specific a case, if we can generalize it maybe we could 
make this change, but we would like to avoid complicating vhost-vsock 
and keep it as simple as possible to avoid then having to implement 
firewalls, etc.

So first I would see if vhost-user-vsock or the QEMU built-in device is 
right for this use-case.

Thanks,
Stefano

>
>If this approach sounds good, I need some guidance on where the code
>should be written in order to achieve this. I would greatly appreciate
>any suggestions.
>
>Thanks.
>
>Regards,
>Dorjoy
>
>[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
>[2] https://mail.gnu.org/archive/html/qemu-devel/2024-05/msg03524.html
>[3] https://aws.amazon.com/ec2/
>


