Return-Path: <netdev+bounces-179196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B0AA7B1DB
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10904177B16
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E001A76D4;
	Thu,  3 Apr 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLEy5trh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0C2E62A2
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717955; cv=none; b=X4jfkz0vsyXTo58P6kx1c4kNuy/PeN/q5jt7kStzaWgo5ArGecRsJ6dVD+Zf58x3NhemhXTFjseMZocfx4gmg4bZgX0abAIk6KyQzk41xfPJ6EZgOzDi3RwwEth7K8ppnlYumMS8Z7jDzh33VcoSm2zuHNJpmlh76sebWQYCUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717955; c=relaxed/simple;
	bh=eKqzYyjIi2T79dBU8LcLsXkzWmFMmVDyNb6oq7/9R+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWrPWMEcgZcWGE6JA4ktuJ4nNrlFSmQI/kPG+2/+aGctWHnX+3J32g4Cy+/jt06oycHdfkO1TnWCwTEyHizQGeLA5uXg3zF8Qo0KgVdoIQ041Vh6JWaiFuH3gPWv5p/Ydv7Ogkvzm2lSkyuHNBhBuEd0Y1lTyaRVfDHvrjv+qdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLEy5trh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743717951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVFBnpk4VtqkCeBmziZc7aEtpDNjYwZQhVxgdIMsz4=;
	b=iLEy5trhOODlJjU5O36gvmgzH0Vg35ZiNPi5YaG+kTM91G5HYpokaa/RKxFsfJgAB+vHue
	PSuTi0oMhRFjflJPIcmi1Ji0zX2ooaPXcxVPtKgNyWoxBOvj3gyFwwg0Ku4PlhAYYP8g2J
	gE81JLYP6gjeOmKc96g1HH3XL/21buU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-EfLWLR0sNpmLTbvPGZtAGA-1; Thu, 03 Apr 2025 18:05:49 -0400
X-MC-Unique: EfLWLR0sNpmLTbvPGZtAGA-1
X-Mimecast-MFC-AGG-ID: EfLWLR0sNpmLTbvPGZtAGA_1743717948
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so8528515e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 15:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743717948; x=1744322748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAVFBnpk4VtqkCeBmziZc7aEtpDNjYwZQhVxgdIMsz4=;
        b=C4PaQafHENy6PuEewBQ6GmYjKGeJCBg8boi/95zb1uk/hRqqLvVYQlD3u6iLR0qDO7
         v1ZUdry29x9gnCdKW3z3mLRXMyAs+L62qn1TIZ3ITA3N8pRr9rho+bNlrJdOzN2EWGwa
         d2sY4F1TYugMJnPBfInGxhdHXtEAASMibgBl5pudale7gj0PJ7nYgd200XL3ApHVg95M
         fIQfBBYDWebHnlPK5+i9A0PzCwoXZ1wa/SLlTZeeaQ9miQ6+toT/7eeMJW4huzTLKAJW
         LlF81vRd2eKiJ+m+0Fbm4kb5KTCH/l0U/b6IGkcXTnpPq75WVtqIpD0x779bERJIC4yU
         qELg==
X-Forwarded-Encrypted: i=1; AJvYcCUpHvgrrWXUwnavMf0qgGEc2vRgKCH5XD8CZdksONvQShH3wzkMSUprZ74sdFSZtzCW/7SER5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzzOb0UFfSo6gXgcrSaCw+GBjiSM7pFxG8lvPwQ//xilS0X/Q
	yK5Qp/av2v546F2NVqugRkHfQESv9gTZZp8A+WOMDN1JuQpBy3bKJtrM8XVWWm8UsbacemU9pUH
	1956A8+dqLMS4e3Tx0YKn6mXWG5BvYVehEO+wWdJK4ty3lrFInzZXng==
X-Gm-Gg: ASbGnct+9O+ea7qhyacKzrmVRESnH+dHP81Aa6VptBakhpK9qeGOAM3MemkGqGM2wva
	14UjFen5c2rFQ8QcuCCXof10yCKTPZY+B36d3I0cciydmY46vn5jYH2gBMivbQwBQLI9wLNDBBh
	0Y3GNHPcdOQu8rj7MxA5/mnzR+MrLQOaQeFXZPAwhcS/XRah0Aq+zUe/Evi42sfbFU8Eu7NzDZE
	CqGEKCCE7YQi//DKMomU3Hnz1hMZCWrPnX8hthJwULaIawfyfV1fX+leZ387yeDkGUdFcUuGOeH
	+xKkHPkpeA==
X-Received: by 2002:a05:6000:220b:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39cb35981fdmr851929f8f.21.1743717948376;
        Thu, 03 Apr 2025 15:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW79kGoZJtIy40Yyv2kYOF7XH99mDIi3DHMq1I1roAepV4AIJGqkODQhQwHwIeDrJwacw5tw==
X-Received: by 2002:a05:6000:220b:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39cb35981fdmr851912f8f.21.1743717947920;
        Thu, 03 Apr 2025 15:05:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6a60sm2740151f8f.29.2025.04.03.15.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:05:47 -0700 (PDT)
Date: Thu, 3 Apr 2025 18:05:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250403180403-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
 <20250403100206-mutt-send-email-mst@kernel.org>
 <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>
 <20250403170543-mutt-send-email-mst@kernel.org>
 <fa9aec4d5d5148cff37a17d076b90ab835b8c7ef.camel@webked.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa9aec4d5d5148cff37a17d076b90ab835b8c7ef.camel@webked.de>

On Thu, Apr 03, 2025 at 11:24:43PM +0200, Markus Fohrer wrote:
> Am Donnerstag, dem 03.04.2025 um 17:06 -0400 schrieb Michael S.
> Tsirkin:
> > On Thu, Apr 03, 2025 at 10:07:12PM +0200, Markus Fohrer wrote:
> > > Am Donnerstag, dem 03.04.2025 um 10:03 -0400 schrieb Michael S.
> > > Tsirkin:
> > > > On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > > > Tsirkin:
> > > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer
> > > > > > wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I'm observing a significant performance regression in KVM
> > > > > > > guest
> > > > > > > VMs
> > > > > > > using virtio-net with recent Linux kernels (6.8.1+ and
> > > > > > > 6.14).
> > > > > > > 
> > > > > > > When running on a host system equipped with a Broadcom
> > > > > > > NetXtreme-E
> > > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > > > the
> > > > > > > guest drops to 100–200 KB/s. The same guest configuration
> > > > > > > performs
> > > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM
> > > > > > > is
> > > > > > > moved to a host with Intel NICs.
> > > > > > > 
> > > > > > > Test environment:
> > > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > > - Guest: Linux with virtio-net interface
> > > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > > > level)
> > > > > > > - CPU: AMD EPYC
> > > > > > > - Storage: virtio-scsi
> > > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > > bottlenecks)
> > > > > > > - Traffic test: iperf3, scp, wget consistently slow in
> > > > > > > guest
> > > > > > > 
> > > > > > > This issue is not present:
> > > > > > > - On 6.8.0 
> > > > > > > - On hosts with Intel NICs (same VM config)
> > > > > > > 
> > > > > > > I have bisected the issue to the following upstream commit:
> > > > > > > 
> > > > > > >   49d14b54a527 ("virtio-net: Suppress tx timeout warning
> > > > > > > for
> > > > > > > small
> > > > > > > tx")
> > > > > > >   https://git.kernel.org/linus/49d14b54a527
> > > > > > 
> > > > > > Thanks a lot for the info!
> > > > > > 
> > > > > > 
> > > > > > both the link and commit point at:
> > > > > > 
> > > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > > Date:   Thu Sep 26 16:58:36 2024 +0000
> > > > > > 
> > > > > >     net: test for not too small csum_start in
> > > > > > virtio_net_hdr_to_skb()
> > > > > >     
> > > > > > 
> > > > > > is this what you mean?
> > > > > > 
> > > > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > > > warning
> > > > > > for small tx"
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > Reverting this commit restores normal network performance
> > > > > > > in
> > > > > > > affected guest VMs.
> > > > > > > 
> > > > > > > I’m happy to provide more data or assist with testing a
> > > > > > > potential
> > > > > > > fix.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Markus Fohrer
> > > > > > 
> > > > > > 
> > > > > > Thanks! First I think it's worth checking what is the setup,
> > > > > > e.g.
> > > > > > which offloads are enabled.
> > > > > > Besides that, I'd start by seeing what's doing on. Assuming
> > > > > > I'm
> > > > > > right
> > > > > > about
> > > > > > Eric's patch:
> > > > > > 
> > > > > > diff --git a/include/linux/virtio_net.h
> > > > > > b/include/linux/virtio_net.h
> > > > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > > > --- a/include/linux/virtio_net.h
> > > > > > +++ b/include/linux/virtio_net.h
> > > > > > @@ -103,8 +103,10 @@ static inline int
> > > > > > virtio_net_hdr_to_skb(struct
> > > > > > sk_buff *skb,
> > > > > >  
> > > > > >  		if (!skb_partial_csum_set(skb, start, off))
> > > > > >  			return -EINVAL;
> > > > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > > > +			return -EINVAL;
> > > > > >  
> > > > > > -		nh_min_len = max_t(u32, nh_min_len,
> > > > > > skb_transport_offset(skb));
> > > > > > +		nh_min_len = skb_transport_offset(skb);
> > > > > >  		p_off = nh_min_len + thlen;
> > > > > >  		if (!pskb_may_pull(skb, p_off))
> > > > > >  			return -EINVAL;
> > > > > > 
> > > > > > 
> > > > > > sticking a printk before return -EINVAL to show the offset
> > > > > > and
> > > > > > nh_min_len
> > > > > > would be a good 1st step. Thanks!
> > > > > > 
> > > > > 
> > > > > 
> > > > > Hi Eric,
> > > > > 
> > > > > thanks a lot for the quick response — and yes, you're
> > > > > absolutely
> > > > > right.
> > > > > 
> > > > > Apologies for the confusion: I mistakenly wrote the wrong
> > > > > commit
> > > > > description in my initial mail.
> > > > > 
> > > > > The correct commit is indeed:
> > > > > 
> > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > Date:   Thu Sep 26 16:58:36 2024 +0000
> > > > > 
> > > > >     net: test for not too small csum_start in
> > > > > virtio_net_hdr_to_skb()
> > > > > 
> > > > > This is the one I bisected and which causes the performance
> > > > > regression
> > > > > in my environment.
> > > > > 
> > > > > Thanks again,
> > > > > Markus
> > > > 
> > > > 
> > > > I'm not Eric but good to know.
> > > > Alright, so I would start with the two items: device features and
> > > > printk.
> > > > 
> > > 
> > > as requested, here’s the device/feature information from the guest
> > > running kernel 6.14 (mainline):
> > > 
> > > Interface: ens18
> > > 
> > > ethtool -i ens18:
> > > driver: virtio_net
> > > version: 1.0.0
> > > firmware-version: 
> > > expansion-rom-version: 
> > > bus-info: 0000:00:12.0
> > > supports-statistics: yes
> > > supports-test: no
> > > supports-eeprom-access: no
> > > supports-register-dump: no
> > > supports-priv-flags: no
> > > 
> > > 
> > > ethtool -k ens18:
> > > Features for ens18:
> > > rx-checksumming: on [fixed]
> > > tx-checksumming: on
> > > 	tx-checksum-ipv4: off [fixed]
> > > 	tx-checksum-ip-generic: on
> > > 	tx-checksum-ipv6: off [fixed]
> > > 	tx-checksum-fcoe-crc: off [fixed]
> > > 	tx-checksum-sctp: off [fixed]
> > > scatter-gather: on
> > > 	tx-scatter-gather: on
> > > 	tx-scatter-gather-fraglist: off [fixed]
> > > tcp-segmentation-offload: on
> > > 	tx-tcp-segmentation: on
> > > 	tx-tcp-ecn-segmentation: on
> > > 	tx-tcp-mangleid-segmentation: off
> > > 	tx-tcp6-segmentation: on
> > > generic-segmentation-offload: on
> > > generic-receive-offload: on
> > > large-receive-offload: off [fixed]
> > > rx-vlan-offload: off [fixed]
> > > tx-vlan-offload: off [fixed]
> > > ntuple-filters: off [fixed]
> > > receive-hashing: off [fixed]
> > > highdma: on [fixed]
> > > rx-vlan-filter: on [fixed]
> > > vlan-challenged: off [fixed]
> > > tx-gso-robust: on [fixed]
> > > tx-fcoe-segmentation: off [fixed]
> > > tx-gre-segmentation: off [fixed]
> > > tx-gre-csum-segmentation: off [fixed]
> > > tx-ipxip4-segmentation: off [fixed]
> > > tx-ipxip6-segmentation: off [fixed]
> > > tx-udp_tnl-segmentation: off [fixed]
> > > tx-udp_tnl-csum-segmentation: off [fixed]
> > > tx-gso-partial: off [fixed]
> > > tx-tunnel-remcsum-segmentation: off [fixed]
> > > tx-sctp-segmentation: off [fixed]
> > > tx-esp-segmentation: off [fixed]
> > > tx-udp-segmentation: off
> > > tx-gso-list: off [fixed]
> > > tx-nocache-copy: off
> > > loopback: off [fixed]
> > > rx-fcs: off [fixed]
> > > rx-all: off [fixed]
> > > tx-vlan-stag-hw-insert: off [fixed]
> > > rx-vlan-stag-hw-parse: off [fixed]
> > > rx-vlan-stag-filter: off [fixed]
> > > l2-fwd-offload: off [fixed]
> > > hw-tc-offload: off [fixed]
> > > esp-hw-offload: off [fixed]
> > > esp-tx-csum-hw-offload: off [fixed]
> > > rx-udp_tunnel-port-offload: off [fixed]
> > > tls-hw-tx-offload: off [fixed]
> > > tls-hw-rx-offload: off [fixed]
> > > rx-gro-hw: on
> > > tls-hw-record: off [fixed]
> > > rx-gro-list: off
> > > macsec-hw-offload: off [fixed]
> > > rx-udp-gro-forwarding: off
> > > hsr-tag-ins-offload: off [fixed]
> > > hsr-tag-rm-offload: off [fixed]
> > > hsr-fwd-offload: off [fixed]
> > > hsr-dup-offload: off [fixed]
> > > 
> > > ethtool ens18:
> > > Settings for ens18:
> > > 	Supported ports: [  ]
> > > 	Supported link modes:   Not reported
> > > 	Supported pause frame use: No
> > > 	Supports auto-negotiation: No
> > > 	Supported FEC modes: Not reported
> > > 	Advertised link modes:  Not reported
> > > 	Advertised pause frame use: No
> > > 	Advertised auto-negotiation: No
> > > 	Advertised FEC modes: Not reported
> > > 	Speed: Unknown!
> > > 	Duplex: Unknown! (255)
> > > 	Auto-negotiation: off
> > > 	Port: Other
> > > 	PHYAD: 0
> > > 	Transceiver: internal
> > > netlink error: Operation not permitted
> > > 	Link detected: yes
> > > 
> > > 
> > > Kernel log (journalctl -k):
> > > Apr 03 19:50:37 kb-test.allod.com kernel: virtio_scsi virtio2:
> > > 4/0/0
> > > default/read/poll queues  
> > > Apr 03 19:50:37 kb-test.allod.com kernel: virtio_net virtio1 ens18:
> > > renamed from eth0
> > > 
> > > Let me know if you’d like comparison data from kernel 6.11 or any
> > > additional tests
> > 
> > 
> > I think let's redo bisect first then I will suggest which traces to
> > add.
> > 
> 
> The build with the added printk is currently running. I’ll test it
> shortly and report the results.
> 
> Should the bisect be done between v6.11 and v6.12, or v6.11 and v6.14?

The commit you showed is between 6.11 and 6.12. Having said that,
you can manually checkout 49d14b54a527289d09a9480f214b8c586322310a
and 49d14b54a527289d09a9480f214b8c586322310a~1 and record
the results with git bisect bad/good and if it works
then git bisect will stop immediately for you.


