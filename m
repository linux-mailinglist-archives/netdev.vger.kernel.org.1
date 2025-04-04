Return-Path: <netdev+bounces-179250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A721BA7B8E7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4150917A27D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2461A00ED;
	Fri,  4 Apr 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwQaBeys"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22119D886
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755379; cv=none; b=morfsl55n8n+yIL7cIuPANo2EMbNKTBn0ugfwQA0MXYoUT6rns+pvxNnwQhQxyULA8prptLlKkVwo5ySRlyZZTJT7mXwWp39/gxqBhHGvvg+SB3aznwKqjITqBZXzuVj6hFHM6Xq5nyJC3mqGQ+ffAxLvpH0AUVRNrUC0/ZmVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755379; c=relaxed/simple;
	bh=e1FSULY5KvnOwyIVIx9HUIgr9X/BcL5fROFXUFNAlac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajWhDmM54qxw9FYbVv9sGycbEHMZiS1d9Cd+KJUKTukWYKyhkAFTgAq6JcmtjCNOD5YM265wWjxKDXLdBCRXK8fSYMs46araTBKNARvIe77fjOQGrQz6YvDjm5JR0wN6++z+Nziy29DpMurnsoMoQyDkb/R7mhAVxuN7cxmzwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwQaBeys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YWsT0d4jRBoSmkqfsRAr3G4OSF/rm5hMiqgTWy5/Z4=;
	b=bwQaBeys7WpUtlokSo50ZiFwU4chVJjne3CJS94n8lLubU6zt+o9LnfskPYCL1NMZ37xzN
	46RF5UP0pRAZJIDV7XQh+KUG6rPfXthUG2PBr8LQjEg8RSHR6KGc9m1eoY7IJmEdtHrKvF
	IaMhdxBuK38fkuiR5m2kLvMzLQvMIfk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-fplr5J0POuiSLWZtrnDAMw-1; Fri, 04 Apr 2025 04:29:35 -0400
X-MC-Unique: fplr5J0POuiSLWZtrnDAMw-1
X-Mimecast-MFC-AGG-ID: fplr5J0POuiSLWZtrnDAMw_1743755375
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d08915f61so9473285e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 01:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755374; x=1744360174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YWsT0d4jRBoSmkqfsRAr3G4OSF/rm5hMiqgTWy5/Z4=;
        b=iW0WZtImwwyM5GVJ6Np1I6PKbk9Bkb4nFI+4QFi8WdowaRJJ/buWIYMssYge+IFhVo
         01nhilCTLDLCqZlk8WQIzBIrIF3PXL3m779v04YTgZ2T6KUFKXZQYHFN27yX3687C1a7
         X87G3VtQ1CDwFnGef92p7KUgylfkByAZGahq8zauu1LMdGrRKJ0FsR1go7gJ9o+pvq8L
         r/59Q45M0sf1bLASd0n41lqTYyiPf6zjw/VPk6edz8T7jF4t+PzHgc10+rno0MAJaaFd
         nXwMRUKN8BYatIJItQaH2li/yqugdLlWL+JhfyulZbP59AbNTfiFyyKfrMWb3PAt0O0m
         m0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVTBMm1f1LyFfHLEUoT3MGbtHJ4xhP7V41w7A3dbSf+IuEXpGM8qe5ptm3gnEcaV17JUrn2/sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOuInJ2VnxZkw6cPvyDUtU/pJ5mPrCHeuRn/SPakpMalCHOOpe
	HUXJuC2yz71xfU4TfWfuz6xuG78x6tbehfetM8pIoixkxP+f5bjYlpBWLVRUwMwB1+LVwEoTuk9
	B3X0jBd8F4d3P8ITwMXhfnxuAPj9BRhxC+KqbrLS6B5sy+6LnWmWk+g==
X-Gm-Gg: ASbGncvm7IrQpwICEVeRHEglCU8MxdBTbL/UIhAyWfbNajOIJJ6KIwBZf1mUN50VYni
	bzkfZoOfa68UcRHGJbEMRQNz+J44A8/o1KZFNlJJOYk+U4gK6fjAzlVjPfidfKtD1q95klkELxH
	U/5QHOSt3S1fsdF3lmktnUPIo4N3FaRo2uciw7hbz2hMe2ekqsewcE4hT5nxu28rwjlviYq0z3D
	23Tn/XWhuxoxmxuIy6wjSCzqikTb5l9WtNP6aQtQ7PUNs8U468XPIbNzRtg4c2X0Dgq4RhcdS1x
	gCLf+RIyWw==
X-Received: by 2002:a05:6000:144f:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-39d0de3b210mr1674677f8f.33.1743755374541;
        Fri, 04 Apr 2025 01:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnYsRndkAe+SDCxu/OU7SkDG2ml903xm0A48L5uKmulL1m95vbIvM9r/KA5itpPLalSiFVUQ==
X-Received: by 2002:a05:6000:144f:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-39d0de3b210mr1674658f8f.33.1743755374142;
        Fri, 04 Apr 2025 01:29:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bbc64sm39017415e9.21.2025.04.04.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:29:33 -0700 (PDT)
Date: Fri, 4 Apr 2025 04:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250404042711-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>

On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
> Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> Tsirkin:
> > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > Hi,
> > > 
> > > I'm observing a significant performance regression in KVM guest VMs
> > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > 
> > > When running on a host system equipped with a Broadcom NetXtreme-E
> > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > > guest drops to 100–200 KB/s. The same guest configuration performs
> > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > > moved to a host with Intel NICs.
> > > 
> > > Test environment:
> > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > - Guest: Linux with virtio-net interface
> > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level)
> > > - CPU: AMD EPYC
> > > - Storage: virtio-scsi
> > > - VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
> > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > 
> > > This issue is not present:
> > > - On 6.8.0 
> > > - On hosts with Intel NICs (same VM config)
> > > 
> > > I have bisected the issue to the following upstream commit:
> > > 
> > >   49d14b54a527 ("virtio-net: Suppress tx timeout warning for small
> > > tx")
> > >   https://git.kernel.org/linus/49d14b54a527
> > 
> > Thanks a lot for the info!
> > 
> > 
> > both the link and commit point at:
> > 
> > commit 49d14b54a527289d09a9480f214b8c586322310a
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Sep 26 16:58:36 2024 +0000
> > 
> >     net: test for not too small csum_start in virtio_net_hdr_to_skb()
> >     
> > 
> > is this what you mean?
> > 
> > I don't know which commit is "virtio-net: Suppress tx timeout warning
> > for small tx"
> > 
> > 
> > 
> > > Reverting this commit restores normal network performance in
> > > affected guest VMs.
> > > 
> > > I’m happy to provide more data or assist with testing a potential
> > > fix.
> > > 
> > > Thanks,
> > > Markus Fohrer
> > 
> > 
> > Thanks! First I think it's worth checking what is the setup, e.g.
> > which offloads are enabled.
> > Besides that, I'd start by seeing what's doing on. Assuming I'm right
> > about
> > Eric's patch:
> > 
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 276ca543ef44d8..02a9f4dc594d02 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct
> > sk_buff *skb,
> >  
> >  		if (!skb_partial_csum_set(skb, start, off))
> >  			return -EINVAL;
> > +		if (skb_transport_offset(skb) < nh_min_len)
> > +			return -EINVAL;
> >  
> > -		nh_min_len = max_t(u32, nh_min_len,
> > skb_transport_offset(skb));
> > +		nh_min_len = skb_transport_offset(skb);
> >  		p_off = nh_min_len + thlen;
> >  		if (!pskb_may_pull(skb, p_off))
> >  			return -EINVAL;
> > 
> > 
> > sticking a printk before return -EINVAL to show the offset and
> > nh_min_len
> > would be a good 1st step. Thanks!
> > 
> 
> I added the following printk inside virtio_net_hdr_to_skb():
> 
>     if (skb_transport_offset(skb) < nh_min_len){
>         printk(KERN_INFO "virtio_net: 3 drop, transport_offset=%u,
> nh_min_len=%u\n",
>                skb_transport_offset(skb), nh_min_len);
>         return -EINVAL;
>     }
> 
> Built and installed the kernel, then triggered a large download via:
> 
>     wget http://speedtest.belwue.net/10G
> 
> Relevant output from `dmesg -w`:
> 
> [   57.327943] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.428942] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.428962] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.553068] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.553088] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.576678] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.618438] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.618453] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.703077] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.823072] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.891982] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.946190] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   58.218686] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  

Hmm indeed. And what about these values?
                u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
                u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
                u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
print them too?



> I would now do the test with commit
> 49d14b54a527289d09a9480f214b8c586322310a and commit
> 49d14b54a527289d09a9480f214b8c586322310a~1
> 

Worth checking though it seems likely now the hypervisor is doing weird
things. what kind of backend is it? qemu? tun? vhost-user? vhost-net?

-- 
MST


