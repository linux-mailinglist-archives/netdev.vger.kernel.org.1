Return-Path: <netdev+bounces-213381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B752B24CD8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B12188B9C8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C602F067A;
	Wed, 13 Aug 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XGmuhegS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9271DE8AD
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097297; cv=none; b=bJlT9jDzwGcN6wFZR30RqnQgxkGGJZsSuZR/czmXd5v/ydg3lhMNrtDV8bTXuJ7e3HDNMoTrEAKZJ7kwhbFARWXsXrTrfbH2fGOBDqsu56QLSBdad2Mi++/23VeG5TUtAoZ2LDQi2RYAB3nnTMPUaPseRviNcyHVYm0IXsdy3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097297; c=relaxed/simple;
	bh=17p7MwBRCSHE64fa1D2KRWGLUNsrWBqS0NAwyjoJ49k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcdo4gV4McQhwBPY7BndFZV4PvkiWHHHvMtJC0wkNcBcHKG/q8jPoUzGOBUnzXUcyqD0syD37LwzJcPKhx/Dq6MPxbYPzl5+L13+zpoNzklR2aBCaIwbDy+FvWc6eNRkjhbja/YHJbX8ih5ghpS1KL50Tq6L1njsl9e3w8dkvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XGmuhegS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso43660125e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755097294; x=1755702094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je12YbuZgJ4qovK2aDqAlKj+xBOV5nZtHN1wMIqYxUE=;
        b=XGmuhegSWmR0z1eD5VfGaLK4lsnGhjzImb+ike8bZO4hDvXI4lxDj0MYcYeRbgDJ98
         cGvhu/pcDGZ1TrqSZwCOsSLXPyqv2DvpvpUqmIl3cfBYmVgZrNfNGfqKYxOqMGJgK/qv
         kveyeammzwRrx+FoAVBkeByWUssccEkqp0JUI2DboMCsLgJ3VaotKsvn2xa3bI/ic16Y
         lGZdo62M+ofV2pe+3UnRdhCSoV+BBNnd85VkrBRope7gXuuuQCivuD0Zy0znlgIEwhV7
         zDlalYb+XGWJMJkpxRy0NbuKBV3LwXMs/NyAASDE1V1NTkugEeOYI27uFigiSkfywa6X
         0CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097294; x=1755702094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je12YbuZgJ4qovK2aDqAlKj+xBOV5nZtHN1wMIqYxUE=;
        b=pZTllgcEWUDy76KSUl7Ga49e4bQs95aR2OnaDr+kD12DMDXa9GHTCaX3RpTUj4eXHl
         UXJ91eOO/zlCB2+1fbzVTB1vPzmnaGZQ36KHoNwuyrrq3IL80aZbTbDtu5D/lRQHXwFN
         z3oJnGgzObJKtFYalquAwKx3Aq0ZhdSKAJc0kub+UI/obocFLglujfBtU2bRfHmKbcKA
         sDKwxxtpzmyL/G0u6sj9TigEPeWp0zA4fIj1bK4l5F8VX/Iw4G5HIX+y+Mmwe1FdAx0s
         4doGINIOiUII620XydlmADN//9u4CZoVxLAMw+byqITurrZi6ugWmk0HZ8hGwtS+PpCu
         2p6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN6tO6+FNYcdYQECh7N6b2SrBP+Op5HgM+bn58eY2BxTLTOhUrdqWRSpgok3GOx7514sPOsCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx4q3xh/rmD1aEH6dpY5nVSimlU6FoR1J8kP7o+K6qSlFMDYD
	Vb0gFGvKVBEqHdnCFvwduK2p+qUVf+0TAAKlGJMeqOXzTHtFxYDgvl3CP5qW56M9crE=
X-Gm-Gg: ASbGnctvsuBccwlKcw8J1aBEiDufW62ztlP87ofXvGLRR1Mr3/6RcZCc2jENr6+6Arc
	UGmis1mWki+UfXbslu2r3ChNDKku3sZAtrr+39oH3qC+vd4wQXIdZB1KSu8j3nWUK95BVncRvxo
	aI94J0hOLf71gVs6EUPZQsAG2xCKOAN0KitWW88a9XhorgRmN5dAK3h+XgQXGY0FeKE916OpCO/
	cbp61h9tmMsx7Zs2O8iZO5LJz8XqXPh+VpEuwgUuFVXhsxCwAlpiXrQ/l8ZeMSF7X97OjI/JnyZ
	xwqd+XTIzT7hyD26Ee/XQ1IDN2HeomeodBwuMTx+voS9MAhYSF5c3u9DiKSiifzsW+Uf3+Jzcj2
	gvYZse1sBg2NwXlkzRHA8w/w1ccORAo4ChrOjEQ61BMNzj7zivR1QADEXW1190UoLNzpAHxzvzu
	l9WDQ1uu//+w==
X-Google-Smtp-Source: AGHT+IFXqt5LPuOlEXVdf/zo4i2yFRbcmo4lW7SxAHZ3nqQPMO3z7dPVL58xg/gcGFrW+KBzQ2iajg==
X-Received: by 2002:a05:600c:4f48:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-45a165e41c0mr29476455e9.19.1755097293990;
        Wed, 13 Aug 2025 08:01:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1ab24d1dsm343015e9.0.2025.08.13.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:01:33 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:01:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Gebauer
 <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
Message-ID: <20250813080128.5c024489@hermes.local>
In-Reply-To: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 00:03:48 +0200
Simon Schippers <simon.schippers@tu-dortmund.de> wrote:

> This patch is the result of our paper with the title "The NODROP Patch:
> Hardening Secure Networking for Real-time Teleoperation by Preventing
> Packet Drops in the Linux TUN Driver" [1].
> It deals with the tun_net_xmit function which drops SKB's with the reason
> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> resulting in reduced TCP performance and packet loss for bursty video
> streams when used over VPN's.
> 
> The abstract reads as follows:
> "Throughput-critical teleoperation requires robust and low-latency
> communication to ensure safety and performance. Often, these kinds of
> applications are implemented in Linux-based operating systems and transmit
> over virtual private networks, which ensure encryption and ease of use by
> providing a dedicated tunneling interface (TUN) to user space
> applications. In this work, we identified a specific behavior in the Linux
> TUN driver, which results in significant performance degradation due to
> the sender stack silently dropping packets. This design issue drastically
> impacts real-time video streaming, inducing up to 29 % packet loss with
> noticeable video artifacts when the internal queue of the TUN driver is
> reduced to 25 packets to minimize latency. Furthermore, a small queue
> length also drastically reduces the throughput of TCP traffic due to many
> retransmissions. Instead, with our open-source NODROP Patch, we propose
> generating backpressure in case of burst traffic or network congestion.
> The patch effectively addresses the packet-dropping behavior, hardening
> real-time video streaming and improving TCP throughput by 36 % in high
> latency scenarios."
> 
> In addition to the mentioned performance and latency improvements for VPN
> applications, this patch also allows the proper usage of qdisc's. For
> example a fq_codel can not control the queuing delay when packets are
> already dropped in the TUN driver. This issue is also described in [2].
> 
> The performance evaluation of the paper (see Fig. 4) showed a 4%
> performance hit for a single queue TUN with the default TUN queue size of
> 500 packets. However it is important to notice that with the proposed
> patch no packet drop ever occurred even with a TUN queue size of 1 packet.
> The utilized validation pipeline is available under [3].
> 
> As the reduction of the TUN queue to a size of down to 5 packets showed no
> further performance hit in the paper, a reduction of the default TUN queue
> size might be desirable accompanying this patch. A reduction would
> obviously reduce buffer bloat and memory requirements.
> 
> Implementation details:
> - The netdev queue start/stop flow control is utilized.
> - Compatible with multi-queue by only stopping/waking the specific
> netdevice subqueue.
> - No additional locking is used.
> 
> In the tun_net_xmit function:
> - Stopping the subqueue is done when the tx_ring gets full after inserting
> the SKB into the tx_ring.
> - In the unlikely case when the insertion with ptr_ring_produce fails, the
> old dropping behavior is used for this SKB.
> 
> In the tun_ring_recv function:
> - Waking the subqueue is done after consuming a SKB from the tx_ring when
> the tx_ring is empty. Waking the subqueue when the tx_ring has any
> available space, so when it is not full, showed crashes in our testing. We
> are open to suggestions.
> - When the tx_ring is configured to be small (for example to hold 1 SKB),
> queuing might be stopped in the tun_net_xmit function while at the same
> time, ptr_ring_consume is not able to grab a SKB. This prevents
> tun_net_xmit from being called again and causes tun_ring_recv to wait
> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
> queue is woken in the wait queue if it has stopped.
> - Because the tun_struct is required to get the tx_queue into the new txq
> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
> faster then trying to get it via the tun_file tfile because it utilizes a
> rcu lock.
> 
> We are open to suggestions regarding the implementation :)
> Thank you for your work!
> 
> [1] Link:
> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> [2] Link:
> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [3] Link: https://github.com/tudo-cni/nodrop
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>

I wonder if it would be possible to implement BQL in TUN/TAP?

https://lwn.net/Articles/454390/

BQL provides a feedback mechanism to application when queue fills.

