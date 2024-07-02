Return-Path: <netdev+bounces-108439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EAD923D33
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B555286E95
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982015D5A4;
	Tue,  2 Jul 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy66HbZ4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C401167D83
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921952; cv=none; b=lcMOsEV8NCzjSA76oMIsn+T+d9mQz4uAWhttCjjfFPIHUvVkfrNsXknww42TC4siV2cNBuC+TLx+JhTLUFLbDnDMnNZSApqr/APXoi8a1wJb4TfG66s0TvNcQOJ4O6sXcvTe8S++UJltDnG8aTr3L2kDuDKskoCBXB1C4ED5vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921952; c=relaxed/simple;
	bh=o3DxiSX0V7ibpPfayjNjBRA+XYTLR0rE1GPKw2O7IAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2L4aO3DVYI/vXm85K40kMFRzjVvQhhoC6Uplb5g47rtwKfnrpRLliQaWnWj8skNgus0Y1zYjPzIwcil/0+P26RYE5/KNBhUGSL8ptMrL0yihz44H2gUqretT2RLqKTZvW9yEFGU9dn1eHuS+83u7WcTPJz7yGPcOYTnXF84tiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dy66HbZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719921949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIY7ymFq65GMU+6BYZkdKE1/VVblQ2rpUte3RvkSuQM=;
	b=Dy66HbZ44gJKXp5cS7wwjzBvhtbdrspc0UoMyDqdI+RZ2gSjAMZ+XSfufMjq8VPiMas0oG
	bBVuhMESqzffnPcKXkJKj2c4W6SG1kYdG6Pmiwts8mFxzOUw2boYQE+mAlSiLE5hrMHH4Y
	xNc6zD4r53s1Bw6DwGlVQPwjHb0wtJI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-c_iV2LFZMzixIpJ9v9YGuw-1; Tue, 02 Jul 2024 08:05:45 -0400
X-MC-Unique: c_iV2LFZMzixIpJ9v9YGuw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6fe8b2bcc4so295839366b.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 05:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921944; x=1720526744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIY7ymFq65GMU+6BYZkdKE1/VVblQ2rpUte3RvkSuQM=;
        b=JUwZi/Z7vSkeAOo7GDhDqw8TgU8LtTWfBR//pOJsN+d1LPxnDrI+j6QCOZbjjgJLrA
         HLNdriZnb+FLHazXetPpX4RBb2EDMTP/yPhsVAJr1mO6IGHFB3l5O9dDpRL0SyeVmG1Y
         RNC5PighbPKeOHGfeSUv8RCC3ZwvuFsIubXG/26V/D74R4NjG8Sga0mySqKYQShAy46t
         6GRNGwmgdGv75rGJxJVi80lVz+hg+xrLYbPvErvlzifMvqZa5cDKk82Pamqfh2qtRtcy
         MqmUHkqMkrhZN3uX8qrLbX9uSWxBm5HDdaGO2Cna7y4EJMgUx4MpEvWhcB05KK9DHdXd
         r5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzCuRDQFOlR1J3ffuN4QdxnM+C4ue39CcrN5MNq81aUarQjiqY0sdb76GkqJnfz/939x+YUzfgk+Tu7HNb+t52s/i70w3v
X-Gm-Message-State: AOJu0YwP2bnvzoUmhjypi8IExPeASHldcEljSJrNiId/6Mm6gZ3kgJXu
	surQC/M8lwrAwwHdk9A+tGmG4Y1TK3N6E468Q9JrBHZXLebJaE/dPKGOfpsHk6WdhRMNCwBZ4iQ
	sUJC3I4FxG3jCrXofEbnZCMRn7C3gJLvxpndhtvF4GuzFCIgZL+VnMA==
X-Received: by 2002:a17:906:db05:b0:a72:5c3d:4d08 with SMTP id a640c23a62f3a-a7514495834mr593526766b.61.1719921944493;
        Tue, 02 Jul 2024 05:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyelizFnE93jO2j1CjN7UeHKnIO2pnAXClpq93UziagX36mOq9DAA4Ru4XryXWbOHa4P6BZQ==
X-Received: by 2002:a17:906:db05:b0:a72:5c3d:4d08 with SMTP id a640c23a62f3a-a7514495834mr593523166b.61.1719921943764;
        Tue, 02 Jul 2024 05:05:43 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.133.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503ad14sm5609712a12.88.2024.07.02.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:05:43 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:05:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <nojtsdora7chbhnblvygozoa4qui3ghivndvg5ixbsgebos4hg@e2jldxpf7sum>
References: <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
 <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
 <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>
 <l5oxnxkg7owmwuadknttnnl2an37wt3u5kgfjb5563f7llbgwj@bvwfv5d7wrq4>
 <3b6a1f23-bf0e-416d-8880-4556b87b5137@amazon.com>
 <hyrgztjkjmftnpra2o2skonfs6bwf2sqrncwtec3e4ckupe5ea@76whtcp3zapf>
 <CAFfO_h5_uAwdNJB=fjrxb_pPiwRDQxaZn=OvR3yrYd+c18tUdQ@mail.gmail.com>
 <xw2rhgn2s677t6cufp2ndpvvgpdlovej44o6ieo7nz2p6msvnw@zza7jzylpw76>
 <CAFfO_h4WnSkinX1faduAD68h=nQCWhPgpYKTPV+xfSqyfMmxEA@mail.gmail.com>
 <CAFfO_h55DdTPWEjeR-ARnWZ0tMWNdJZnUauXsxm5eL+TzhAFLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h55DdTPWEjeR-ARnWZ0tMWNdJZnUauXsxm5eL+TzhAFLA@mail.gmail.com>

On Sun, Jun 30, 2024 at 04:54:18PM GMT, Dorjoy Chowdhury wrote:
>Hey Stefano,
>Apart from my questions in my previous email, I have some others as well.
>
>If the vhost-device-vsock modification to forward packets to
>VMADDR_CID_LOCAL is implemented, does the VMADDR_FLAG_TO_HOST need to
>be set by any application in the guest? I understand that the flag is
>set automatically in the listen path by the driver (ref:
>https://patchwork.ozlabs.org/project/netdev/patch/20201204170235.84387-4-andraprs@amazon.com/#2594117
>), but from the comments in the referenced patch, I am guessing the
>applications in the guest that will "connect" (as opposed to listen)
>will need to set the flag in the application code? So does the
>VMADDR_FLAG_TO_HOST flag need to be set by the applications in the
>guest that will "connect" or should it work without it? I am asking
>because the nitro-enclave VMs have an "init" which tries to connect to
>CID 3 to send a "hello" on boot to let the parent VM know that it
>booted expecting a "hello" reply but the init doesn't seem to set the
>flag https://github.com/aws/aws-nitro-enclaves-sdk-bootstrap/blob/main/init/init.c#L356C1-L361C7

Looking at af_vsock.c code, it looks like that if we don't have any
H2G transports (e.g. vhost-vsock) loaded in the VM (this is loaded for 
nested VMs, so I guess for nitro-enclave VM this should not be the 
case), the packets are forwarded to the host in any case.

See 
https://elixir.bootlin.com/linux/latest/source/net/vmw_vsock/af_vsock.c#L469

>.
>
>I was following
>https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication
>to test if sibling communication works and it seems like I didn't need
>to modify the "socat" to set the "VMADDR_FLAG_TO_HOST". I am wondering
>why it works without any modification. Here is what I do:
>
>shell1: ./vhost-device-vsock --vm
>guest-cid=3,uds-path=/tmp/vm3.vsock,socket=/tmp/vhost3.socket --vm
>guest-cid=4,uds-path=/tmp/vm4.vsock,socket=/tmp/vhost4.socket
>
>shell2: ./qemu-system-x86_64 -machine q35,memory-backend=mem0
>-enable-kvm -m 8G -nic user,model=virtio -drive
>file=/home/dorjoy/Forks/test_vm/fedora2.qcow2,media=disk,if=virtio
>--display sdl -object memory-backend-memfd,id=mem0,size=8G -chardev
>socket,id=char0,reconnect=0,path=/tmp/vhost3.socket -device
>vhost-user-vsock-pci,chardev=char0
>    inside this guest I run: socat - VSOCK-LISTEN:9000
>
>shell3: ./qemu-system-x86_64 -machine q35,memory-backend=mem0
>-enable-kvm -m 8G -nic user,model=virtio -drive
>file=/home/dorjoy/Forks/test_vm/fedora40.qcow2,media=disk,if=virtio
>--display sdl -object memory-backend-memfd,id=mem0,size=8G -chardev
>socket,id=char0,reconnect=0,path=/tmp/vhost4.socket -device
>vhost-user-vsock-pci,chardev=char0
>    inside this guest I run: socat - VSOCK-CONNECT:3:9000
>
>Then when I type something in the socat terminal of one VM and hit
>'enter', they pop up in the socat terminal of the other VM. From the
>documentation of the vhost-device-vsock, I thought I would need to
>patch socat to set the "VMADDR_FLAG_TO_HOST" but I did not do anything
>with socat. I simply did "sudo dnf install socat" in both VMs. I also
>looked into the socat source code and I didn't see any reference to
>"VMADDR_FLAG_TO_HOST". I am running "Fedora 40" on both VMs. Do you
>know why it works without the flag?

Yep, so the driver will forward them if the H2G transport is not loaded, 
like in your case. So if you set VMADDR_FLAG_TO_HOST you are sure that 
it is always forwarded to the host, if you don't set it, it is forwarded 
only if you don't have a nested VM using vhost-vsock. In that case we 
don't know how to differentiate the case of communication with a nested 
guest or a sibling guest, for this reason we added the flag.

If the host uses vhost-vsock, that packets are discarded, but for 
vhost-device-vsock, we are handling them.

Hope this clarify.

Stefano

>
>On Wed, Jun 26, 2024 at 11:43 PM Dorjoy Chowdhury
><dorjoychy111@gmail.com> wrote:
>>
>> Hey Stefano,
>> Thanks a lot for all the details. I will look into them and reach out
>> if I need further input. Thanks! I have tried to summarize my
>> understanding below. Let me know if that sounds correct.
>>
>> On Wed, Jun 26, 2024 at 2:37 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > Hi Dorjoy,
>> >
>> > On Tue, Jun 25, 2024 at 11:44:30PM GMT, Dorjoy Chowdhury wrote:
>> > >Hey Stefano,
>> >
>> > [...]
>> >
>> > >> >
>> > >> >So the immediate plan would be to:
>> > >> >
>> > >> >  1) Build a new vhost-vsock-forward object model that connects to
>> > >> >vhost as CID 3 and then forwards every packet from CID 1 to the
>> > >> >Enclave-CID and every packet that arrives on to CID 3 to CID 2.
>> > >>
>> > >> This though requires writing completely from scratch the virtio-vsock
>> > >> emulation in QEMU. If you have time that would be great, otherwise if
>> > >> you want to do a PoC, my advice is to start with vhost-user-vsock which
>> > >> is already there.
>> > >>
>> > >
>> > >Can you give me some more details about how I can implement the
>> > >daemon?
>> >
>> > We already have a demon written in Rust, so I don't recommend you
>> > rewrite one from scratch, just start with that. You can find the daemon
>> > and instructions on how to use it with QEMU here [1].
>> >
>> > >I would appreciate some pointers to code too.
>> >
>> > I sent the pointer to it in my first reply [2].
>> >
>> > >
>> > >Right now, the "nitro-enclave" machine type (wip) in QEMU
>> > >automatically spawns a VHOST_VSOCK device with the CID equal to the
>> > >"guest-cid" machine option. I think this is equivalent to using the
>> > >"-device vhost-vsock-device,guest-cid=N" option explicitly. Does that
>> > >need any change? I guess instead of "vhost-vsock-device", the
>> > >vhost-vsock device needs to be equivalent to "-device
>> > >vhost-user-vsock-device,guest-cid=N"?
>> >
>> > Nope, the vhost-user-vsock device requires just a `chardev` option.
>> > The chardev points to the Unix socket used by QEMU to talk with the
>> > daemon. The daemon has a parameter to set the CID. See [1] for the
>> > examples.
>> >
>> > >
>> > >The applications inside the nitro-enclave VM will still connect and
>> > >talk to CID 3. So on the daemon side, do we need to spawn a device
>> > >that has CID 3 and then forward everything this device receives to CID
>> > >1 (VMADDR_CID_LOCAL) same port and everything it receives from CID 1
>> > >to the "guest-cid"?
>> >
>> > Yep, I think this is right.
>> > Note: to use VMADDR_CID_LOCAL, the host needs to load `vsock_loopback`
>> > kernel module.
>> >
>> > Before modifying the code, if you want to do some testing, perhaps you
>> > can use socat (which supports both UNIX-* and VSOCK-*). The daemon for
>> > now exposes two unix sockets, one is used to communicate with QEMU via
>> > the vhost-user protocol, and the other is to be used by the application
>> > to communicate with vsock sockets in the guest using the hybrid protocol
>> > defined by firecracker. So you could initiate a socat between the latter
>> > and VMADDR_CID_LOCAL, the only problem I see is that you have to send
>> > the first string provided by the hybrid protocol (CONNECT 1234), but for
>> > a PoC it should be ok.
>> >
>> > I just tried the following and it works without touching any code:
>> >
>> > shell1$ ./target/debug/vhost-device-vsock \
>> >      --vm guest-cid=3,socket=/tmp/vhost3.socket,uds-path=/tmp/vm3.vsock
>> >
>> > shell2$ sudo modprobe vsock_loopback
>> > shell2$ socat VSOCK-LISTEN:1234 UNIX-CONNECT:/tmp/vm3.vsock
>> >
>> > shell3$ qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
>> >      -drive file=fedora40.qcow2,format=qcow2,if=virtio\
>> >      -chardev socket,id=char0,path=/tmp/vhost3.socket \
>> >      -device vhost-user-vsock-pci,chardev=char0 \
>> >      -object memory-backend-memfd,id=mem,size=512M \
>> >      -nographic
>> >
>> >      guest$ nc --vsock -l 1234
>> >
>> > shell4$ nc --vsock 1 1234
>> > CONNECT 1234
>> >
>> >      Note: the `CONNECT 1234` is required by the hybrid vsock protocol
>> >      defined by firecracker, so if we extend the vhost-device-vsock
>> >      daemon to forward packet to VMADDR_CID_LOCAL, that would not be
>> >      needed (including running socat).
>> >
>>
>> Understood. Just trying to think out loud what the final UX will be
>> from the user perspective to successfully run a nitro VM before I try
>> to modify vhost-device-vsock to support forwarding to
>> VMADDR_CID_LOCAL.
>> I guess because the "vhost-user-vsock" device needs to be spawned
>> implicitly (without any explicit option) inside nitro-enclave in QEMU,
>> we now need to provide the "chardev" as a machine option, so the
>> nitro-enclave command would look something like below:
>> "./qemu-system-x86_64 -M nitro-enclave,chardev=char0 -kernel
>> /path/to/eif -chardev socket,id=char0,path=/tmp/vhost5.socket -m 4G
>> --enable-kvm -cpu host"
>> and then set the chardev id to the vhost-user-vsock device in the code
>> from the machine option.
>>
>> The modified "vhost-device-vsock" would need to be run with the new
>> option that will forward everything to VMADDR_CID_LOCAL (below by the
>> "-z" I mean the new option)
>> "./target/debug/vhost-device-vsock -z --vm
>> guest-cid=5,socket=/tmp/vhost5.socket,uds-path=/tmp/vm5.vsock"
>> this means the guest-cid of the nitro VM is CID 5, right?
>>
>> And the applications in the host would need to use VMADDR_CID_LOCAL
>> for communication instead of "guest-cid" (5) (assuming vsock_loopback
>> is modprobed). Let's say there are 2 applications inside the nitro VM
>> that connect to CID 3 on port 9000 and 9001. And the applications on
>> the host listen on 9000 and 9001 using VMADDR_CID_LOCAL. So, after the
>> commands above (qemu VM and vhost-device-vsock) are run, the
>> communication between the applications in the host and the
>> applications in the nitro VM on port 9000 and 9001 should just work,
>> right, without needing to run any extra socat commands or such? or
>> will the user still need to run some socat commands for all the
>> relevant ports (e.g.,9000 and 9001)?
>>
>> I am just wondering what kind of changes are needed in
>> vhost-device-vsock for forwarding packets to VMADDR_CID_LOCAL? Will
>> that be something like this: the codepath that handles
>> "/tmp/vm5.vsock", upon receiving a "connect" (from inside the nitro
>> VM) for any port to "/tmp/vm5.vsock", vhost-device-vsock will just
>> connect to the same port using AF_VSOCK using the socket system calls
>> and messages received on that port in "/tmp/vm5.vsock" will be "send"
>> to the AF_VSOCK socket? or am I not thinking right and the
>> implementation would be something different entirely (change the CID
>> from 3 to 2 (or 1?) on the packets before they are handled then socat
>> will be needed probably)? Will this work if the applications in the
>> host want to connect to applications inside the nitro VM (as opposed
>> to applications inside the nitro VM connecting to CID 3)?
>>
>> Thanks and Regards,
>> Dorjoy
>


