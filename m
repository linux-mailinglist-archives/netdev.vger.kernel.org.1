Return-Path: <netdev+bounces-213790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B9B26AA4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2DD5859A4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825F21C18C;
	Thu, 14 Aug 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RirJ8I+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE321B8F2;
	Thu, 14 Aug 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184135; cv=none; b=Vgq5bk3v5UAquYQJOquV2mDgpexLM2EUgfj4ir21SjW0Cp8eRDErGpDZbVd2zD9ne5gqFVpeJ2cIoBVP1aSypj9jWpQgT+PinhkARoNSNtq/sB9oOYmiB/XEemwI5bjNpE2/mRB9C8YDR4QNAPvuw9mvHrmDWr873MZOBDeEPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184135; c=relaxed/simple;
	bh=OLRxpy6qWg4z+se20ssCoGoEQD71Nl21MMatXMblnpE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k2DOmyvBVk1NoyCIaS9oPVZDOnCYvtLV69sQwQbKd9OFHB1VJwckKgquuE/mNuUSKVE8ewo7rkSVbCOWCaIOL0iz8w2UBs2fK+Fevs2B0mSFNTP07f0fHiVk1CEFGXKQlDnV8eQf0WbqW64EKJTVnBvwEwWNdRJ9XQu7Vhh5oFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RirJ8I+x; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109914034so10285561cf.0;
        Thu, 14 Aug 2025 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755184132; x=1755788932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLDF7sfjPqLLWDRFGrMALuelOz/Kn4A6EdAoxb5ZrY0=;
        b=RirJ8I+xtOfvqSvapYY4hCNWfUObQxoWzCckc6nYDW7mRtoshtOLviG+GAILF1H8PF
         kpOUBVC9I+M04xLoMAVd1npGidW/RETFUmwvy+7hx8i0/DwYO3lJm3ub0Sym2PUwHtEK
         tYew5Huy9TKzPXEWWmsWHHlvKWMRry7up2/ZFOHONpLWV+vUyWa9gQI5Ajc7r0sToVhp
         XP3GGOGqCx4dfx9UU39mamESoCryEB2aPa7wL/GJGCI9b573loeaM/iIvb9KpmCqyE7Z
         a3BD98wORuo9XgidQ+TtO9/vSKuPVgfgGdXbfM6hJ4VUXShHGIkf7KB5pzlguJ5iECfv
         a55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184132; x=1755788932;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZLDF7sfjPqLLWDRFGrMALuelOz/Kn4A6EdAoxb5ZrY0=;
        b=kSl7NwmVvun2K9dKqPEWiSCLS7Xc/w8qUNTvrTVKfX08gceff8Zvrbv8cXchDS7oUb
         Yo8jqOYImnITo/3/Kojj8HwUr7arDyZd1VizcN7X+AbAZ/aeXqus2W902+9s/QtvHLBJ
         /Y8hj1ubeqbSwH/p4UCTNikfXdoZwUgqW2OA4bBjUhM3MQMyQyhWBJtKvYyKd0CBcy1G
         yOugaezvjvw5KcFrnZ92pyV2mCxaN47uGHEqIOhExgC8hyCw0/B5Y/yfzKVajyBm6Yko
         uQW6R+hlXfPJRpl0kKCmwy/X/mcZIZQz65FB+mtNcgRtENk+B/RZ/mOvzUBJIXaxs6XZ
         P9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSHwDranQZdx10E019644gtPYqdfeaeYYV4mr4n/HmlQhAdTukO9BGb+bSBruUxJtRThiswI56XsZQFc=@vger.kernel.org, AJvYcCXGDrHNKuAVcxtZipkt4IoB0aptAAC7l18nPvgliVOLgnbQBt3SxhCwlFyhuIXcHvfPcsBHJaJY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3yL6LXl39xBoupTHeMZL2MJnFbrbW9l1iZ+0u6B1cQSlph3w
	OJh8r1cudM2Z9fc1fG1JsnfMGjr6Uw99xjPi23niCHU+Z2ESEbF+nUWL
X-Gm-Gg: ASbGncs3GoAruLbzrwad9jXUahMdByWHyZjbqDceLookdcPf48IijVPXTAQ6YkCYcT/
	i3vxMNcIS2g37gRiTeu7FsCKDRQgphSdTlC+lqkDEf/dbQi0eyQyZuip43m3MImdXyMmpvEHEAe
	kvXGhVHmI4N+A8OOoubIOb+zdZp7vIspr8f1juRkha1owzr0z8xHIVsCwEcFWkRRTSW/4eUgphB
	b8sP470uTOmRrQmNMTHNBiB9FWWOXkeHOf3yYrxQpY9OtDiroF+/ybvm77ppgrMaX/kplI14m5W
	glZRS3BM2mXgStTPKR1HgXXpGZIvHp6bGG49EWRi8yoVUZXyTtGldruDzxHBMVL2uLJhDIjk/Ky
	mq5SpFnBn0dJpqCxR1TZzB7gxVITkBHEF35aMmcODhZvpWFIT2Vg2OkXjOwUSxunlOIQT/AAxji
	PHnFTE
X-Google-Smtp-Source: AGHT+IHgScGGciLoAAGZWbpaNRtf5J7sRgORxdvTVJmR/HHyk7N0OmASK0g6XJgOhQ2AxkZYIM6PTQ==
X-Received: by 2002:ac8:59d3:0:b0:4b0:8b84:3db3 with SMTP id d75a77b69052e-4b10aab9513mr41257721cf.46.1755184131803;
        Thu, 14 Aug 2025 08:08:51 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b0785d13a2sm148110901cf.39.2025.08.14.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:08:51 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:08:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tim Gebauer <tim.gebauer@tu-dortmund.de>
Message-ID: <689dfc02cf665_18aa6c29427@willemb.c.googlers.com.notmuch>
In-Reply-To: <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
 <20250813080128.5c024489@hermes.local>
 <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Schippers wrote:
> Stephen Hemminger wrote:
> > On Tue, 12 Aug 2025 00:03:48 +0200
> > Simon Schippers <simon.schippers@tu-dortmund.de> wrote:
> >
> >> This patch is the result of our paper with the title "The NODROP Patch:
> >> Hardening Secure Networking for Real-time Teleoperation by Preventing
> >> Packet Drops in the Linux TUN Driver" [1].
> >> It deals with the tun_net_xmit function which drops SKB's with the reason
> >> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> >> resulting in reduced TCP performance and packet loss for bursty video
> >> streams when used over VPN's.
> >>
> >> The abstract reads as follows:
> >> "Throughput-critical teleoperation requires robust and low-latency
> >> communication to ensure safety and performance. Often, these kinds of
> >> applications are implemented in Linux-based operating systems and transmit
> >> over virtual private networks, which ensure encryption and ease of use by
> >> providing a dedicated tunneling interface (TUN) to user space
> >> applications. In this work, we identified a specific behavior in the Linux
> >> TUN driver, which results in significant performance degradation due to
> >> the sender stack silently dropping packets. This design issue drastically
> >> impacts real-time video streaming, inducing up to 29 % packet loss with
> >> noticeable video artifacts when the internal queue of the TUN driver is
> >> reduced to 25 packets to minimize latency. Furthermore, a small queue
> >> length also drastically reduces the throughput of TCP traffic due to many
> >> retransmissions. Instead, with our open-source NODROP Patch, we propose
> >> generating backpressure in case of burst traffic or network congestion.
> >> The patch effectively addresses the packet-dropping behavior, hardening
> >> real-time video streaming and improving TCP throughput by 36 % in high
> >> latency scenarios."
> >>
> >> In addition to the mentioned performance and latency improvements for VPN
> >> applications, this patch also allows the proper usage of qdisc's. For
> >> example a fq_codel can not control the queuing delay when packets are
> >> already dropped in the TUN driver. This issue is also described in [2].
> >>
> >> The performance evaluation of the paper (see Fig. 4) showed a 4%
> >> performance hit for a single queue TUN with the default TUN queue size of
> >> 500 packets. However it is important to notice that with the proposed
> >> patch no packet drop ever occurred even with a TUN queue size of 1 packet.
> >> The utilized validation pipeline is available under [3].
> >>
> >> As the reduction of the TUN queue to a size of down to 5 packets showed no
> >> further performance hit in the paper, a reduction of the default TUN queue
> >> size might be desirable accompanying this patch. A reduction would
> >> obviously reduce buffer bloat and memory requirements.
> >>
> >> Implementation details:
> >> - The netdev queue start/stop flow control is utilized.
> >> - Compatible with multi-queue by only stopping/waking the specific
> >> netdevice subqueue.
> >> - No additional locking is used.
> >>
> >> In the tun_net_xmit function:
> >> - Stopping the subqueue is done when the tx_ring gets full after inserting
> >> the SKB into the tx_ring.
> >> - In the unlikely case when the insertion with ptr_ring_produce fails, the
> >> old dropping behavior is used for this SKB.
> >>
> >> In the tun_ring_recv function:
> >> - Waking the subqueue is done after consuming a SKB from the tx_ring when
> >> the tx_ring is empty. Waking the subqueue when the tx_ring has any
> >> available space, so when it is not full, showed crashes in our testing. We
> >> are open to suggestions.
> >> - When the tx_ring is configured to be small (for example to hold 1 SKB),
> >> queuing might be stopped in the tun_net_xmit function while at the same
> >> time, ptr_ring_consume is not able to grab a SKB. This prevents
> >> tun_net_xmit from being called again and causes tun_ring_recv to wait
> >> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
> >> queue is woken in the wait queue if it has stopped.
> >> - Because the tun_struct is required to get the tx_queue into the new txq
> >> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
> >> faster then trying to get it via the tun_file tfile because it utilizes a
> >> rcu lock.
> >>
> >> We are open to suggestions regarding the implementation :)
> >> Thank you for your work!
> >>
> >> [1] Link:
> >> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> >> [2] Link:
> >> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> >> [3] Link: https://github.com/tudo-cni/nodrop
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >
> > I wonder if it would be possible to implement BQL in TUN/TAP?
> >
> > https://lwn.net/Articles/454390/
> >
> > BQL provides a feedback mechanism to application when queue fills.
> 
> Thank you very much for your reply,
> I also thought about BQL before and like the idea!

I would start with this patch series to convert TUN to a driver that
pauses the stack rather than drops.

Please reword the commit to describe the functional change concisely.
In general the effect of drops on TCP are well understood. You can
link to your paper for specific details.

I still suggest stopping the ring before a packet has to be dropped.
Note also that there is a mechanism to requeue an skb rather than
drop, see dev_requeue_skb and NETDEV_TX_BUSY. But simply pausing
before empty likely suffices.

Relevant to BQL: did your workload include particularly large packets,
e.g., TSO? Only then does byte limits vs packet limits matter.


