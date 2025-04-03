Return-Path: <netdev+bounces-179060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4BA7A489
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE27A5DCE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E214324EAB9;
	Thu,  3 Apr 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a20IpYlO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71473433D1
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688996; cv=none; b=BKQwtWJ+LYQL0ObYmd+DB16o/M+X12AmpIKLHR0jMLmOZs/ZQy4sN7mm+KyjOtIb5xNZx2dHZPIsDRWnUQ/8c3foxK0BaNrnNHdW4Ho6EDvAOgMu10m/ZVKEj8olt38AP18HT4/FsdS+ot3HaJWsJUMWL1YE9IJx1msn6ZLoalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688996; c=relaxed/simple;
	bh=PLIry9I5MN5+p97bRNx+HoFhgLJY0z5+1qZUMALAcao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbBcaL+z4FJNrtn/WOPH1Ys+r8doM4M1efWk3h8hT0E9AC60+rxeoFqUaetzjczUXNMSSpyWNrVc0Gl0f23wxb1ICw7zmwZqFmYQREs8i/eL36Kh1sNwu7CZNjiNBsBmsagsc4XxxuRNp97F6vLJuToN2Yzq1OChsah80V/KGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a20IpYlO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WBThcQneZqddzRwqfMjSBi+IuLp0YfEk4vsedSbljI=;
	b=a20IpYlOYoAi1Bm0ivLJPA0bn6fi3hUVpfwjekn3s/Z5YiEKc0EF8xZWHcM32g+6di5FDB
	60JQBZi6L4wkZTer0wOHkd5kPQVO58g7GsMHhpVOKXLiTKmsTqI1kqVIVWC+1QUFjocQHx
	6eEVGxq05QoMlosKDSxKowGq4eUJqMY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-9rmqNNd1PlObhdYDK1xiaA-1; Thu, 03 Apr 2025 10:03:11 -0400
X-MC-Unique: 9rmqNNd1PlObhdYDK1xiaA-1
X-Mimecast-MFC-AGG-ID: 9rmqNNd1PlObhdYDK1xiaA_1743688990
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fe32a30so478970f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 07:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688990; x=1744293790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WBThcQneZqddzRwqfMjSBi+IuLp0YfEk4vsedSbljI=;
        b=ST2IH0xP1WuKRsXPUf7lIBA/H4jgK6Ra0F6WtCajWgCUQCwFuoQXu2vXc/cO5T+5nB
         VITnK5ituQkQD4bfHbwZ5M9NRDekZr6WmGPApqfSxte0UshkD8sNbU7WMWZwP0sdYiHj
         21vygT+yFdKeJ5lbB3QV+dBswI6VKZPSzFoMZZzIeR9WOg74TnLZhGJgE56qivEzwi3W
         QjgcuQIWIY4vUH18h+g2Kc56FNCGhFJ14PCI0ssvFJd+hsp7oK2Kg4d+u8/y3UwZlZYo
         fo5dQ6eLiRkcZYT1QCuxfQkgWik6FT2p54ps4iFLLpZ7zcdiqm+22bLSggttg9hGc8kF
         5INw==
X-Forwarded-Encrypted: i=1; AJvYcCVRwLeQrdtt3l6HsQx36BwRu8bgkQt81Uy0L4paFN9W/Pfu36YZxFtnPVE66zhbGs+tVVXJowQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGOJgCdP6ma4B+HC1qGLthjTQ8KpCLLx7JdscHPftleCJM6De
	WxIEeCxJGl83E5699wEj0cV+WAYYOyaKAn0cJ47pSJD8kaHZu0E7/nZ8M6iDU5LLj3m0IsZs5uo
	Q5heweYpugOKjwAiMuIzpAw0heOI8elWOgTSHxT9wPhwcp6FiUjkvgg==
X-Gm-Gg: ASbGncvJeUD1FK9f4C4O65h4MRf2w/lIflCauZu1sEVdWhDykvwSjhY8XoVvi6TfZR7
	pSPBrC2Ldt28LMzXMyP3mrXN6a4FShAr/GDv992/4QEv4RAwnn7hFLexjvtIIWckljSxav8xWHL
	C7xLj3o5wse4/Iny2ZilFUKyvLq6/AvZK/UtxZoCGwXSJmCBwC9+XlchdWPt/ElhR+lPD3L5Pch
	rYnGkyxQfSPjha5OnrlL0vavkPmU8mWDzi9RW3Pw++G3YNqGgC/DlSKxm86USji/wZ7OFkRNTNb
	2vAtYDFekQ==
X-Received: by 2002:a05:6000:250e:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39c30338008mr2275600f8f.25.1743688990040;
        Thu, 03 Apr 2025 07:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC2+/8ybqHkABA5XplMD4M48h+miairALBzMuE16io0YC/ba6y7OVR2eUT30wn6NDVL3wRjQ==
X-Received: by 2002:a05:6000:250e:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39c30338008mr2275550f8f.25.1743688989617;
        Thu, 03 Apr 2025 07:03:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea9a88b70sm44441485e9.3.2025.04.03.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:03:09 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:03:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250403100206-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>

On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
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
> 
> Hi Eric,
> 
> thanks a lot for the quick response — and yes, you're absolutely right.
> 
> Apologies for the confusion: I mistakenly wrote the wrong commit
> description in my initial mail.
> 
> The correct commit is indeed:
> 
> commit 49d14b54a527289d09a9480f214b8c586322310a
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Sep 26 16:58:36 2024 +0000
> 
>     net: test for not too small csum_start in virtio_net_hdr_to_skb()
> 
> This is the one I bisected and which causes the performance regression
> in my environment.
> 
> Thanks again,
> Markus


I'm not Eric but good to know.
Alright, so I would start with the two items: device features and
printk.

-- 
MST


