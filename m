Return-Path: <netdev+bounces-98675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82858D209F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169A21C2284F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D9171641;
	Tue, 28 May 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbfxuXSm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC188171083
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910917; cv=none; b=d+qzg5MWXNM6bkB27wXSdl2zrVycpOft3XLQOWySDD3PxYVuMOFgmmcinEDdmZIMfFb2aRhOF+IMKrtxyzEfbNwNwNhBK+nVDpoz4QBumev65GJhOM3EFmpKZue1QyBAVTZ+j0O8CiHELD+brVtb43KJlYOEPMdx+UkRSmFoX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910917; c=relaxed/simple;
	bh=UAyozGNsCmwUqD+XrpPFVs6dG7QVe6gbexROJiLABZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIz8UGmBIhMHgMSsyhdcJg24bn45Sa+5xBaB0jbP0VkSUGVJ+dytnW9fNwdVEewqtgzPo/mBpGMWgEFFzhdKS2pQHM2I6Fz0vuhBx3JJVDNrUiT58OdD7rWvRfmmDUIwQaXXHZxEMRCdKs3reP4Q1hTYAoSpjvl66AlbEuuYzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbfxuXSm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716910915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlQdyp3ut05LIO9kbFRssBfZgD5dhilSrQu4L3xBd0s=;
	b=dbfxuXSm+Fhv1yGIpNHe2VCSMWx+1sOWmQvpN/tVnJXiBkyWnRW26FCsMHF1MLB/pGkUmE
	QCYbNfhCla1nPK41OvFBeLmfJ6JzosHxCFKhR+JvcMumfMmS2EEoY09MBLWUxys6Z3Yjdo
	NFxi/CW5Kc3jfMnwzUe0k1Q8F6Ivg+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-K81UBSUcOvuEl8UPP9NOGQ-1; Tue, 28 May 2024 11:41:53 -0400
X-MC-Unique: K81UBSUcOvuEl8UPP9NOGQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35858762c31so927367f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716910912; x=1717515712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlQdyp3ut05LIO9kbFRssBfZgD5dhilSrQu4L3xBd0s=;
        b=QovKu5RR4FeqtnJoQixk6x7+n3Xr2UX2rNCdPkGw93xdjAzjbyytGhVEWqfmtrzBZy
         LbTvRnLxbP7WACCZZnyK/h5N8rUou8740qNSWef9Qw6HQ31afCsOnmoCbsNRG+bWFyyw
         r/vO0uyOlKA5pnql1VuLZhqizmADHXJwP0G83W9sXPfmBZM+V2poXL9YINsObff3I7F2
         6vU6xBRMd9OeSeG6DLyJk5qYCAhSq2xR+9SrDL19A1xPNcdfsB006o79kipApYs2j495
         cYFaC6pPVctlxqwbmOS/4hDJyZV3XZrhaz7hznSUJwpwHhBpLLLG/AGsPEQKp3XN/7ZM
         Ux0w==
X-Forwarded-Encrypted: i=1; AJvYcCUkzpsDCkAZ6KcAIKiHIgNarSOH2y0RAGZDdCi9YTHQjKAoipunfSQTNCNvBYGm+Wn+yV2dH2pGIOWVTHsR6fmvIQPRzHvR
X-Gm-Message-State: AOJu0Yxs2gNpocavZPXDpkykL6JIorKwOlkw70iF0Tdr7dAWAy7dIJfG
	ViAYc7WEQJXoe3FYfMq3y0ZXTD7J9oRt3rBXpLLp0hvFJlXKPrZbFz01YdAfZevqPRPUKxLkRBj
	l8nfLydhaWlp2KG6UI53rv+T6K4kVYxkWSJNxngsvG2XvizoyELcHJoj8gZqsqQ==
X-Received: by 2002:adf:eec3:0:b0:34d:9604:3500 with SMTP id ffacd0b85a97d-354f74ff878mr13231306f8f.4.1716910911999;
        Tue, 28 May 2024 08:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/eI4H9RLn/HEJbswzk9/w4qmy4mScgNCLnDTdPrjLIdOMmxpG1K8AZvK0jQycr4vEkSjcAw==
X-Received: by 2002:adf:eec3:0:b0:34d:9604:3500 with SMTP id ffacd0b85a97d-354f74ff878mr13231273f8f.4.1716910911434;
        Tue, 28 May 2024 08:41:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966682sm146735305e9.2.2024.05.28.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:41:50 -0700 (PDT)
Date: Tue, 28 May 2024 17:41:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
References: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
 <4i525r6irzjgibqqtrs3qzofqfifws2k3fmzotg37pyurs5wkd@js54ugamyyin>
 <CAFfO_h7iNYc3jrDvnAxTyaGWMxM9YK29DAGYux9s1ve32tuEBw@mail.gmail.com>
 <3a62a9d1-5864-4f00-bcf0-2c64552ee90c@csgraf.de>
 <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com>
 <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com>

On Tue, May 28, 2024 at 05:19:34PM GMT, Paolo Bonzini wrote:
>On 5/27/24 09:54, Alexander Graf wrote:
>>
>>On 27.05.24 09:08, Alexander Graf wrote:
>>>Hey Stefano,
>>>
>>>On 23.05.24 10:45, Stefano Garzarella wrote:
>>>>On Tue, May 21, 2024 at 08:50:22AM GMT, Alexander Graf wrote:
>>>>>Howdy,
>>>>>
>>>>>On 20.05.24 14:44, Dorjoy Chowdhury wrote:
>>>>>>Hey Stefano,
>>>>>>
>>>>>>Thanks for the reply.
>>>>>>
>>>>>>
>>>>>>On Mon, May 20, 2024, 2:55 PM Stefano Garzarella 
>>>>>><sgarzare@redhat.com> wrote:
>>>>>>>Hi Dorjoy,
>>>>>>>
>>>>>>>On Sat, May 18, 2024 at 04:17:38PM GMT, Dorjoy Chowdhury wrote:
>>>>>>>>Hi,
>>>>>>>>
>>>>>>>>Hope you are doing well. I am working on adding AWS Nitro Enclave[1]
>>>>>>>>emulation support in QEMU. Alexander Graf is mentoring 
>>>>>>>>me on this work. A v1
>>>>>>>>patch series has already been posted to the qemu-devel 
>>>>>>>>mailing list[2].
>>>>>>>>
>>>>>>>>AWS nitro enclaves is an Amazon EC2[3] feature that 
>>>>>>>>allows creating isolated
>>>>>>>>execution environments, called enclaves, from Amazon EC2 
>>>>>>>>instances, which are
>>>>>>>>used for processing highly sensitive data. Enclaves have 
>>>>>>>>no persistent storage
>>>>>>>>and no external networking. The enclave VMs are based on 
>>>>>>>>Firecracker microvm
>>>>>>>>and have a vhost-vsock device for communication with the 
>>>>>>>>parent EC2 instance
>>>>>>>>that spawned it and a Nitro Secure Module (NSM) device 
>>>>>>>>for cryptographic
>>>>>>>>attestation. The parent instance VM always has CID 3 
>>>>>>>>while the enclave VM gets
>>>>>>>>a dynamic CID. The enclave VMs can communicate with the 
>>>>>>>>parent instance over
>>>>>>>>various ports to CID 3, for example, the init process 
>>>>>>>>inside an enclave sends a
>>>>>>>>heartbeat to port 9000 upon boot, expecting a heartbeat 
>>>>>>>>reply, letting the
>>>>>>>>parent instance know that the enclave VM has successfully booted.
>>>>>>>>
>>>>>>>>The plan is to eventually make the nitro enclave 
>>>>>>>>emulation in QEMU standalone
>>>>>>>>i.e., without needing to run another VM with CID 3 with proper vsock
>>>>>>>If you don't have to launch another VM, maybe we can avoid 
>>>>>>>vhost-vsock
>>>>>>>and emulate virtio-vsock in user-space, having complete 
>>>>>>>control over the
>>>>>>>behavior.
>>>>>>>
>>>>>>>So we could use this opportunity to implement virtio-vsock 
>>>>>>>in QEMU [4]
>>>>>>>or use vhost-user-vsock [5] and customize it somehow.
>>>>>>>(Note: vhost-user-vsock already supports sibling 
>>>>>>>communication, so maybe
>>>>>>>with a few modifications it fits your case perfectly)
>>>>>>>
>>>>>>>[4] https://gitlab.com/qemu-project/qemu/-/issues/2095
>>>>>>>[5] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
>>>>>>
>>>>>>
>>>>>>Thanks for letting me know. Right now I don't have a complete picture
>>>>>>but I will look into them. Thank you.
>>>>>>>
>>>>>>>
>>>>>>>>communication support. For this to work, one approach 
>>>>>>>>could be to teach the
>>>>>>>>vhost driver in kernel to forward CID 3 messages to another CID N
>>>>>>>So in this case both CID 3 and N would be assigned to the same QEMU
>>>>>>>process?
>>>>>>
>>>>>>
>>>>>>CID N is assigned to the enclave VM. CID 3 was supposed to be the
>>>>>>parent VM that spawns the enclave VM (this is how it is in AWS, where
>>>>>>an EC2 instance VM spawns the enclave VM from inside it and that
>>>>>>parent EC2 instance always has CID 3). But in the QEMU case as we
>>>>>>don't want a parent VM (we want to run enclave VMs standalone) we
>>>>>>would need to forward the CID 3 messages to host CID. I don't know if
>>>>>>it means CID 3 and CID N is assigned to the same QEMU process. Sorry.
>>>>>
>>>>>
>>>>>There are 2 use cases here:
>>>>>
>>>>>1) Enclave wants to treat host as parent (default). In this scenario,
>>>>>the "parent instance" that shows up as CID 3 in the Enclave doesn't
>>>>>really exist. Instead, when the Enclave attempts to talk to CID 3, it
>>>>>should really land on CID 0 (hypervisor). When the hypervisor tries to
>>>>>connect to the Enclave on port X, it should look as if it originates
>>>>>from CID 3, not CID 0.
>>>>>
>>>>>2) Multiple parent VMs. Think of an actual cloud hosting scenario.
>>>>>Here, we have multiple "parent instances". Each of them thinks it's
>>>>>CID 3. Each can spawn an Enclave that talks to CID 3 and reach the
>>>>>parent. For this case, I think implementing all of virtio-vsock in
>>>>>user space is the best path forward. But in theory, you could also
>>>>>swizzle CIDs to make random "real" CIDs appear as CID 3.
>>>>>
>>>>
>>>>Thank you for clarifying the use cases!
>>>>
>>>>Also for case 1, vhost-vsock doesn't support CID 0, so in my opinion
>>>>it's easier to go into user-space with vhost-user-vsock or the built-in
>>>>device.
>>>
>>>
>>>Sorry, I believe I meant CID 2. Effectively for case 1, when a 
>>>process on the hypervisor listens on port 1234, it should be 
>>>visible as 3:1234 from the VM and when the hypervisor process 
>>>connects to <VM CID>:1234, it should look as if that connection 
>>>came from CID 3.
>>
>>
>>Now that I'm thinking about my message again: What if we just 
>>introduce a sysfs/sysctl file for vsock that indicates the "host 
>>CID" (default: 2)? Users that want vhost-vsock to behave as if the 
>>host is CID 3 can just write 3 to it.
>>
>>It means we'd need to change all references to VMADDR_CID_HOST to 
>>instead refer to a global variable that indicates the new "host 
>>CID". It'd need some more careful massaging to not break number 
>>namespace assumptions (<= CID_HOST no longer works), but the idea 
>>should fly.
>
>Forwarding one or more ports of a given CID to CID 2 (the host) should 
>be doable with a dummy vhost client that listens to CID 3, connects to 
>CID 2 and send data back and forth.

Good idea, a kind of socat but that can handle /dev/vhost-vsock. With 
rust-vmm crates it should be doable, but I think we always need to 
extend vhost-vsock to support VMADDR_FLAG_TO_HOST, because for now it 
does not allow guests to send packets to the host with destinatation 
other than 2.

>Not hard enough to justify changing all references to VMADDR_CID_HOST

I agree.

>(and also I am not sure if vsock supports network namespaces?

nope, I had been working on it, but I could never finish it :-(
Tracking the work here: https://gitlab.com/vsock/vsock/-/issues/2

>then the sysctl/sysfs way is not feasible because you cannot set it 
>per-netns, can you?).  It also has the disadvantages that different 
>QEMU instances are not insulated.
>
>I think it's either that or implementing virtio-vsock in userspace (https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com/, 
>search for "To connect host<->guest").

For in this case AF_VSOCK can't be used in the host, right?
So it's similar to vhost-user-vsock.

Thanks,
Stefano


