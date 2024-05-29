Return-Path: <netdev+bounces-98985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADF8D34F9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3814284D0F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236B17B513;
	Wed, 29 May 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcArVvro"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6517B4FD
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980170; cv=none; b=k3fsL2fhap7HMJdcyoXhg7lW16QvVCnLEbhkGkW68fXAPULM/wADSJ/3ks72NGLCHHqNheupncOabvGksS4FO7oVHWGOXZq5Ue+wtRl9Ph5k/I11Sa6pMFmEd25WAjMZNAo8TzHFRMckfuYL5M4Gv2UiHsA4iFsxgpYhZCyGKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980170; c=relaxed/simple;
	bh=2eq9RHpWGnbH5bMsvZ9gjK91MtzdKTlb2oxg+DVHL3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozkFOjAfAluC/8XHh93decDjiChwlMnCIM8Vp+3/1rp1x+lyo91ju27bnh0yI9GV6L98bJnNdZuOaYQKGqSSxsFZ3qyjUB5uW76eZTXtfdtLy9YpMF4R2tDOCeELbxtCX2qBjaxyZkvkWZ4A5duMhu+m+LXlkwmzUoHKYVxoJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcArVvro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716980168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/IW4Faf1WCV8kgopnLSo94ttZs/Y2hkDErm/OSdzVk=;
	b=EcArVvroa6p8EV6aJ2SAiIAN3aVsQlqHPmjCj6HFY8qpGdOlgvMnvorGURGpMBs4zGxKqz
	+WTUiFjwqXJGyDBEbSqMQWXxnX23N7PnKbRIvFvBTcKk806GsOAkWGWGLZ779TOl3x9+u7
	cuAnEpxZUtqN25Uv/659iQqiSCAUIXQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-tyEuEHzLNy6WfCxonqv6oQ-1; Wed, 29 May 2024 06:56:06 -0400
X-MC-Unique: tyEuEHzLNy6WfCxonqv6oQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43fb0949d28so13091181cf.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 03:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716980166; x=1717584966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/IW4Faf1WCV8kgopnLSo94ttZs/Y2hkDErm/OSdzVk=;
        b=gfXlxmMLTWV51yzeDuh+lHED25YGDpaRtIwIxFh6xxyDJRT1OjmMyqukCxyQ52BBaC
         9r1n6IauPj/tikFwQcn8/pUmHU9YCSUdpOD+t72SOSASniatAUeE2h6+AjHpxdObmsD5
         dMeqBVeAwT7eSpZdNNdwXwzwagdfXVncd17CyVoV77kMhTYO7J+zIrZS+NhDLCtkghoC
         yEmeSzBDLoEhBIGT3+sLj11rAnvIcxobYWoEj7saCNiIn8klBw0qS8eW57dxpS/7Q81c
         ChSxK1TY0rvRfBllLSYLQWWQRxTubWcm97qzU3a57FGrnwgdbwK4auhRDJSA7ZFWtadU
         G6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmQgC4joJPeOeT2YfN4J7kqiMUBNjY1VUE38V+0UIMTxnTniNsb9lYP0jtHN/p79kh6SCW2KighzutJ1qVcCu4WIP3+fyU
X-Gm-Message-State: AOJu0YyebTlGpXtllhsebpaPgIMVb62osSlmf5A8seH4MnikHZuFcUz/
	JXsCNx3bHA0Jmy1bSmIbqDbj9CjX2xNHe3lcdqQZiovsfr93iPctM4fZtvaElF0JFJuFS4XwJkw
	mjg5IZErdyimB6wnQRNIY9+r7On6xE2N5F0eU4JDN6uC55WbZVdjkkw==
X-Received: by 2002:ac8:5ad4:0:b0:43a:c0c7:a218 with SMTP id d75a77b69052e-43fe12871b8mr24606881cf.33.1716980166359;
        Wed, 29 May 2024 03:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYZXr2GVdAp/Ri4KfEP1VHGQ64i7iFk7NFAo87pQluTH/X3DAr8lzSE1WqVCix95BVrkz/+A==
X-Received: by 2002:ac8:5ad4:0:b0:43a:c0c7:a218 with SMTP id d75a77b69052e-43fe12871b8mr24606671cf.33.1716980165996;
        Wed, 29 May 2024 03:56:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb1832368sm52838811cf.57.2024.05.29.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:56:05 -0700 (PDT)
Date: Wed, 29 May 2024 12:55:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <hyrgztjkjmftnpra2o2skonfs6bwf2sqrncwtec3e4ckupe5ea@76whtcp3zapf>
References: <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com>
 <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com>
 <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
 <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
 <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
 <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>
 <l5oxnxkg7owmwuadknttnnl2an37wt3u5kgfjb5563f7llbgwj@bvwfv5d7wrq4>
 <3b6a1f23-bf0e-416d-8880-4556b87b5137@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b6a1f23-bf0e-416d-8880-4556b87b5137@amazon.com>

On Wed, May 29, 2024 at 12:43:57PM GMT, Alexander Graf wrote:
>
>On 29.05.24 10:04, Stefano Garzarella wrote:
>>
>>On Tue, May 28, 2024 at 06:38:24PM GMT, Paolo Bonzini wrote:
>>>On Tue, May 28, 2024 at 5:53 PM Stefano Garzarella 
>>><sgarzare@redhat.com> wrote:
>>>>
>>>>On Tue, May 28, 2024 at 05:49:32PM GMT, Paolo Bonzini wrote:
>>>>>On Tue, May 28, 2024 at 5:41 PM Stefano Garzarella 
>>>><sgarzare@redhat.com> wrote:
>>>>>> >I think it's either that or implementing virtio-vsock in userspace
>>>>>> >(https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com/,
>>>>>> >search for "To connect host<->guest").
>>>>>>
>>>>>> For in this case AF_VSOCK can't be used in the host, right?
>>>>>> So it's similar to vhost-user-vsock.
>>>>>
>>>>>Not sure if I understand but in this case QEMU knows which CIDs are
>>>>>forwarded to the host (either listen on vsock and connect to the host,
>>>>>or vice versa), so there is no kernel and no VMADDR_FLAG_TO_HOST
>>>>>involved.
>>>>
>>>>I meant that the application in the host that wants to connect to the
>>>>guest cannot use AF_VSOCK in the host, but must use the one where QEMU
>>>>is listening (e.g. AF_INET, AF_UNIX), right?
>>>>
>>>>I think one of Alex's requirements was that the application in the host
>>>>continue to use AF_VSOCK as in their environment.
>>>
>>>Can the host use VMADDR_CID_LOCAL for host-to-host communication?
>>
>>Yep!
>>
>>>If
>>>so, the proposed "-object vsock-forward" syntax can connect to it and
>>>it should work as long as the application on the host does not assume
>>>that it is on CID 3.
>>
>>Right, good point!
>>We can also support something similar in vhost-user-vsock, where instead
>>of using AF_UNIX and firecracker's hybrid vsock, we can redirect
>>everything to VMADDR_CID_LOCAL.
>>
>>Alex what do you think? That would simplify things a lot to do.
>>The only difference is that the application in the host has to talk to
>>VMADDR_CID_LOCAL (1).
>
>
>The application in the host would see an incoming connection from CID 
>1 (which is probably fine) and would still be able to establish 
>outgoing connections to the actual VM's CID as long as the Enclave 
>doesn't check for the peer CID (I haven't seen anyone check yet). So 
>yes, indeed, this should work.
>
>The only case where I can see it breaking is when you run multiple 
>Enclave VMs in parallel. In that case, each would try to listen to CID 
>3 and the second that does would fail. But it's a well solvable 
>problem: We could (in addition to the simple in-QEMU case) build an 
>external daemon that does the proxying and hence owns CID3.

Well, we can modify vhost-user-vsock for that. It's already a daemon, 
already supports different VMs per single daemon but as of now they have 
to have different CIDs.

>
>So the immediate plan would be to:
>
>  1) Build a new vhost-vsock-forward object model that connects to 
>vhost as CID 3 and then forwards every packet from CID 1 to the 
>Enclave-CID and every packet that arrives on to CID 3 to CID 2.

This though requires writing completely from scratch the virtio-vsock 
emulation in QEMU. If you have time that would be great, otherwise if 
you want to do a PoC, my advice is to start with vhost-user-vsock which 
is already there.

Thanks,
Stefano

>  2) Create a machine option for -M nitro-enclave that automatically 
>spawns the vhost-vsock-forward object. (default: off)
>
>
>The above may need some fiddling with object creation times to ensure 
>that the forward object gets CID 3, not the Enclave as auto-assigned 
>CID.
>
>
>Thanks,
>
>Alex
>
>
>
>
>Amazon Web Services Development Center Germany GmbH
>Krausenstr. 38
>10117 Berlin
>Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>Sitz: Berlin
>Ust-ID: DE 365 538 597


