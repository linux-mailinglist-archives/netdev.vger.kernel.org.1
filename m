Return-Path: <netdev+bounces-179175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C4A7B093
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863251898BA7
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D30207673;
	Thu,  3 Apr 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKoUdlKs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB601F12F9
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714371; cv=none; b=SsxdBB+wLZwgYEB+ylaN8TM1ers8t/9zuc7y+4nPKONbjhgEchLUncf1InMjlYFVEFZ4OAIXHjK+GzcynLJY45umvaaryxnA2ulUbSqmGSxThk4Ce6hjlteMmIqgOf4xMUYFS4i1fEoKFNp9csmiB4UZqcynxbXvL/INzeMuw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714371; c=relaxed/simple;
	bh=gJ5wrIvReAv5QqxtqNCJ9FujkFKj0dFoDyjRW8MTRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmBULdFRZ+MRKfazMwaguGyDQSAMzjhT6nIBO7fTSWdQISR7Jt7J0o89qN3m0odcy3gz19ZZzoeepJFkT1ln75RBL2n2zXdQ5n1fyfP0rOeatuO1BUGT8/C2B3c8dotjB61elo62xFjTWBQfUuraqiRKrpVlBlklEYsQ/HazGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKoUdlKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743714368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQPSgYV8xh79P5dCNHj8YipiJGf0W9F/2BqM6SXAVZc=;
	b=GKoUdlKshdKsThZbK5zOqZbl78Sjg3Ump3tG/GZlZdXFRr3vXK/J5CxnyIbwzm74Plcipd
	YVayzEU+FPjYZ7IBTKW3CYFmFyau1i5KgYHzzNQ0kqLjrXQmj8g/ViB98boDrRS4oBJQZU
	sNQs5Lm8AyVXOKgkmTLRWUC5lGbB0wk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-1U7p6lAtOSWlN9eSDKMAfg-1; Thu, 03 Apr 2025 17:06:06 -0400
X-MC-Unique: 1U7p6lAtOSWlN9eSDKMAfg-1
X-Mimecast-MFC-AGG-ID: 1U7p6lAtOSWlN9eSDKMAfg_1743714366
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so7459925e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714366; x=1744319166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQPSgYV8xh79P5dCNHj8YipiJGf0W9F/2BqM6SXAVZc=;
        b=rTgTswW3X73G6NxYtccELEvZ6nljYJ2R/aPn3hsNrR9OGJaljnX9xt5iWcX6qtijeb
         aZmcU4jWO75ZWskbjVuYywWYKOVYUd++j88/jaUlyHo49el3Zgcx35r+q9gGwyGZwsSi
         BEDx2xxo+6n+T75dXDhoo7qqWZdt6tPkXzd74GvVnxUe9DjEU1C8Oon/oc/G5Q5J1RDD
         FY1LgohCt7WpZyphT2I1z+5xESJfkkZQTI1K/mTms1hcEu1hgJJ1i8WfDZmC9YopClYp
         RlZRW8tcCw+MIXFoFcG6tgM8oIxkeQW5ZfqCZruLeWKpyB4xy2hQ3w8duT5tXloqSXW/
         bopQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjiAnb1C7VCX2PkeXdSdLEWujrDN0qM2MzT+uUgtpHsrGfVhMvOW21tCZYRkqmTLcYHnKzp70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0M5/DP1r323qYs3YWHKXn9qdl/Uk2M9nm+G5z6fgVeZC3odFL
	6rVGa6SKtux5ehAVEKwpVUB4PCSo8Or4Xz64e+iKhk4Ab91r1hcTZs8Jnk+IcCLdYFq5gAGfm6s
	B5O692kSK14qIegA51Pl2nPLmPJo3t/efl1BlyUsuAIyMiFabroRXzQ==
X-Gm-Gg: ASbGnctVo/Y1cfStvfpl2qfDxmKr0S3ZLEd/LRXCdF5EPyWk9TpxfDf6cvH9TZcEEeP
	Fn0O8KSDIG1KpwSvr3SFWuG39Vk/hV+ESThlb8sWpucj8gzmFEWMNkkXGKd5MSgLROM8S2VGMFz
	osolg/pRd8jv6H78YdEF0TQ5fk9zucqrLHfVz6qSTODbskZm6K1IvEc1oHg1WqheG3I6lICMydr
	JpUT5wuOoFnvaXzjPGeJhGpNucvj80lTgULT7wtouXqlfhuD0pl1WvymB26SKSJHHnFXhBiM4Nj
	SD/cVJ9B/Q==
X-Received: by 2002:a05:600c:4695:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-43ed0db3646mr1629495e9.28.1743714365528;
        Thu, 03 Apr 2025 14:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIXS5hwbzfgThNhAktLRgRbRw/FEpi7tWXoj6bda4No5E7hvlK67fZzMkXDe5GScLwGcYoA==
X-Received: by 2002:a05:600c:4695:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-43ed0db3646mr1629325e9.28.1743714365119;
        Thu, 03 Apr 2025 14:06:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226da7sm2788385f8f.98.2025.04.03.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:06:04 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:06:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250403170543-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
 <20250403100206-mutt-send-email-mst@kernel.org>
 <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>

On Thu, Apr 03, 2025 at 10:07:12PM +0200, Markus Fohrer wrote:
> Am Donnerstag, dem 03.04.2025 um 10:03 -0400 schrieb Michael S.
> Tsirkin:
> > On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > Tsirkin:
> > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > > Hi,
> > > > > 
> > > > > I'm observing a significant performance regression in KVM guest
> > > > > VMs
> > > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > > > 
> > > > > When running on a host system equipped with a Broadcom
> > > > > NetXtreme-E
> > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > > > > guest drops to 100–200 KB/s. The same guest configuration
> > > > > performs
> > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > > > > moved to a host with Intel NICs.
> > > > > 
> > > > > Test environment:
> > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > - Guest: Linux with virtio-net interface
> > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > level)
> > > > > - CPU: AMD EPYC
> > > > > - Storage: virtio-scsi
> > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > bottlenecks)
> > > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > > 
> > > > > This issue is not present:
> > > > > - On 6.8.0 
> > > > > - On hosts with Intel NICs (same VM config)
> > > > > 
> > > > > I have bisected the issue to the following upstream commit:
> > > > > 
> > > > >   49d14b54a527 ("virtio-net: Suppress tx timeout warning for
> > > > > small
> > > > > tx")
> > > > >   https://git.kernel.org/linus/49d14b54a527
> > > > 
> > > > Thanks a lot for the info!
> > > > 
> > > > 
> > > > both the link and commit point at:
> > > > 
> > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:   Thu Sep 26 16:58:36 2024 +0000
> > > > 
> > > >     net: test for not too small csum_start in
> > > > virtio_net_hdr_to_skb()
> > > >     
> > > > 
> > > > is this what you mean?
> > > > 
> > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > warning
> > > > for small tx"
> > > > 
> > > > 
> > > > 
> > > > > Reverting this commit restores normal network performance in
> > > > > affected guest VMs.
> > > > > 
> > > > > I’m happy to provide more data or assist with testing a
> > > > > potential
> > > > > fix.
> > > > > 
> > > > > Thanks,
> > > > > Markus Fohrer
> > > > 
> > > > 
> > > > Thanks! First I think it's worth checking what is the setup, e.g.
> > > > which offloads are enabled.
> > > > Besides that, I'd start by seeing what's doing on. Assuming I'm
> > > > right
> > > > about
> > > > Eric's patch:
> > > > 
> > > > diff --git a/include/linux/virtio_net.h
> > > > b/include/linux/virtio_net.h
> > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -103,8 +103,10 @@ static inline int
> > > > virtio_net_hdr_to_skb(struct
> > > > sk_buff *skb,
> > > >  
> > > >  		if (!skb_partial_csum_set(skb, start, off))
> > > >  			return -EINVAL;
> > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > +			return -EINVAL;
> > > >  
> > > > -		nh_min_len = max_t(u32, nh_min_len,
> > > > skb_transport_offset(skb));
> > > > +		nh_min_len = skb_transport_offset(skb);
> > > >  		p_off = nh_min_len + thlen;
> > > >  		if (!pskb_may_pull(skb, p_off))
> > > >  			return -EINVAL;
> > > > 
> > > > 
> > > > sticking a printk before return -EINVAL to show the offset and
> > > > nh_min_len
> > > > would be a good 1st step. Thanks!
> > > > 
> > > 
> > > 
> > > Hi Eric,
> > > 
> > > thanks a lot for the quick response — and yes, you're absolutely
> > > right.
> > > 
> > > Apologies for the confusion: I mistakenly wrote the wrong commit
> > > description in my initial mail.
> > > 
> > > The correct commit is indeed:
> > > 
> > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Thu Sep 26 16:58:36 2024 +0000
> > > 
> > >     net: test for not too small csum_start in
> > > virtio_net_hdr_to_skb()
> > > 
> > > This is the one I bisected and which causes the performance
> > > regression
> > > in my environment.
> > > 
> > > Thanks again,
> > > Markus
> > 
> > 
> > I'm not Eric but good to know.
> > Alright, so I would start with the two items: device features and
> > printk.
> > 
> 
> as requested, here’s the device/feature information from the guest
> running kernel 6.14 (mainline):
> 
> Interface: ens18
> 
> ethtool -i ens18:
> driver: virtio_net
> version: 1.0.0
> firmware-version: 
> expansion-rom-version: 
> bus-info: 0000:00:12.0
> supports-statistics: yes
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> 
> 
> ethtool -k ens18:
> Features for ens18:
> rx-checksumming: on [fixed]
> tx-checksumming: on
> 	tx-checksum-ipv4: off [fixed]
> 	tx-checksum-ip-generic: on
> 	tx-checksum-ipv6: off [fixed]
> 	tx-checksum-fcoe-crc: off [fixed]
> 	tx-checksum-sctp: off [fixed]
> scatter-gather: on
> 	tx-scatter-gather: on
> 	tx-scatter-gather-fraglist: off [fixed]
> tcp-segmentation-offload: on
> 	tx-tcp-segmentation: on
> 	tx-tcp-ecn-segmentation: on
> 	tx-tcp-mangleid-segmentation: off
> 	tx-tcp6-segmentation: on
> generic-segmentation-offload: on
> generic-receive-offload: on
> large-receive-offload: off [fixed]
> rx-vlan-offload: off [fixed]
> tx-vlan-offload: off [fixed]
> ntuple-filters: off [fixed]
> receive-hashing: off [fixed]
> highdma: on [fixed]
> rx-vlan-filter: on [fixed]
> vlan-challenged: off [fixed]
> tx-gso-robust: on [fixed]
> tx-fcoe-segmentation: off [fixed]
> tx-gre-segmentation: off [fixed]
> tx-gre-csum-segmentation: off [fixed]
> tx-ipxip4-segmentation: off [fixed]
> tx-ipxip6-segmentation: off [fixed]
> tx-udp_tnl-segmentation: off [fixed]
> tx-udp_tnl-csum-segmentation: off [fixed]
> tx-gso-partial: off [fixed]
> tx-tunnel-remcsum-segmentation: off [fixed]
> tx-sctp-segmentation: off [fixed]
> tx-esp-segmentation: off [fixed]
> tx-udp-segmentation: off
> tx-gso-list: off [fixed]
> tx-nocache-copy: off
> loopback: off [fixed]
> rx-fcs: off [fixed]
> rx-all: off [fixed]
> tx-vlan-stag-hw-insert: off [fixed]
> rx-vlan-stag-hw-parse: off [fixed]
> rx-vlan-stag-filter: off [fixed]
> l2-fwd-offload: off [fixed]
> hw-tc-offload: off [fixed]
> esp-hw-offload: off [fixed]
> esp-tx-csum-hw-offload: off [fixed]
> rx-udp_tunnel-port-offload: off [fixed]
> tls-hw-tx-offload: off [fixed]
> tls-hw-rx-offload: off [fixed]
> rx-gro-hw: on
> tls-hw-record: off [fixed]
> rx-gro-list: off
> macsec-hw-offload: off [fixed]
> rx-udp-gro-forwarding: off
> hsr-tag-ins-offload: off [fixed]
> hsr-tag-rm-offload: off [fixed]
> hsr-fwd-offload: off [fixed]
> hsr-dup-offload: off [fixed]
> 
> ethtool ens18:
> Settings for ens18:
> 	Supported ports: [  ]
> 	Supported link modes:   Not reported
> 	Supported pause frame use: No
> 	Supports auto-negotiation: No
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  Not reported
> 	Advertised pause frame use: No
> 	Advertised auto-negotiation: No
> 	Advertised FEC modes: Not reported
> 	Speed: Unknown!
> 	Duplex: Unknown! (255)
> 	Auto-negotiation: off
> 	Port: Other
> 	PHYAD: 0
> 	Transceiver: internal
> netlink error: Operation not permitted
> 	Link detected: yes
> 
> 
> Kernel log (journalctl -k):
> Apr 03 19:50:37 kb-test.allod.com kernel: virtio_scsi virtio2: 4/0/0
> default/read/poll queues  
> Apr 03 19:50:37 kb-test.allod.com kernel: virtio_net virtio1 ens18:
> renamed from eth0
> 
> Let me know if you’d like comparison data from kernel 6.11 or any
> additional tests


I think let's redo bisect first then I will suggest which traces to add.


