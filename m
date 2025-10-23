Return-Path: <netdev+bounces-232277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7BC03B81
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AA8B34AE3E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E2026E71B;
	Thu, 23 Oct 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Kutc4zgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E19184
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259952; cv=none; b=byzJpaN6tKYCAOeEZArfohMopAMjaD3Hg8wArXM/Kr7aqm5Lkrjrhg2H7CYZ+KUKNzpMEKoW230Ar/Z8XmUtCYBGOxUH7bX+Td7fs/Afyjx0VKcoGHxpE1oDGdISt1NqsTXFKlIhYMc2hDAClILCJqb23wSrzX96AIWEq+XoIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259952; c=relaxed/simple;
	bh=a/oVA+1W2W63nNBlqpwA4juoX4MUOMQKgdxV9IsDUtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgQ49CJAsKO6ay/HwG+S0R8eHMctx9ZsjRipaw19EZSOX8L7Xk/2CAKDm8UR8GN4TpHC/JY1k5Tsdpwre1tsM3lu44yHihxmDBW2nBScIAq5nxa/F+VQiF1zvTphBzLMoIT9CXolKpW8geMOBHF5rNTHdieKfjO8hkquE8F6QDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Kutc4zgt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811a02316bso1049884b3a.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761259950; x=1761864750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mprIX+RYkzlOHXK9v2bWr1TLOjlDU4ICDIXLml7GahI=;
        b=Kutc4zgtcGNNvg8pP1ZdItmAPJRBs68LIqeUwqihZzrQ7QZD8OE6jag59lNswxDHcN
         G/UKpYylrAwv23ZHxkwuc1DoAwTeu+nf8SVRv1LaxxKZRFePTsPFghKz09MwqZ945qfN
         s3kOIX0k8UQAlDQ/c8lQnoOPNIn0IqC6ssApROeGflOixqhPaf665BwtZM1OdZdm6Vfl
         tQuPs5okFJsv3ZvS9Q+GznsU+HLJ8rguO5xlUiCGhQ14k6swCjIxdYsb85HKWAwRXEx7
         BTYXqk1kfzcN2RSk0C6C+hWXQy01qTsFVHCntdaU7tsdP9k4LPzgoAfxKDqBSXdpcaxm
         PE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761259950; x=1761864750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mprIX+RYkzlOHXK9v2bWr1TLOjlDU4ICDIXLml7GahI=;
        b=sm70LwcX2kFf/deI4aVY98YtrkKfSTSmdc/ioMpPJcgOWQTvvz4WBBtXb9QRwuPnw4
         u0Or/X4yZRxWJkh+Ufn2tXOuKKXEEfyIfqsW3868nJwpKpF7fRKR4joWkrzB56RwkJlm
         okzo0uflDVXy634Tl2EZg79S0Wzl7FGhsh4o349+uFn4mu8Z/AoCJEM+7lUu3TAR5m47
         WhHQA+xvhOTv3Tn8+Vj5e6CHyLNZOX21+XRlFMBunI/xddBI3lMLNymLf95LidMGezjN
         0rYvTU7PAuGKUCe5Qq7bNuDlxbeoG5pdvmlSuKA46D+aPz4pL2MW0bKPBMTj7/JdKzag
         +XmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1GNh3lavVDGGnUiGlYBq03PjT5S6k7/3KGE9NF9BIIbhNf+xcd9uJrKngQ+h0GWLxaw2Mcus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfHILbnzNTbkWMFDfTjFYQom16D9J+Fp3HsGxBSTXk4LozCmD
	TpURQZWqC0Ev7vh3ZnPa04eo8pcY5Hbvv+uuA7GsM7Gqrc5nr7woETQVpb1UAyS8fQ==
X-Gm-Gg: ASbGncv5GH6kNmUKgXlJP7FNhGaabCviPlL/R5Hjw5UlET9zoUUTNSh73J5fFgt4Eyy
	UFq308hi4fHefL+3YETAZ8ABBt+2J9HeCEVBiRCIFjae2+xg5bvtj8Yie+F2uj6GLy5M0EtNG5q
	lE17GLYitUprqJAd5Uc7h+qVe6VSeyNy0ucvcjLyAteZJb8dLZN/1MdlSJTdD3KRtuuLHb0kaMm
	ZbEhIL0bAgy7vCogiiHfigwFfEkllYnI3F7dZYaqJg2MTQ/raKKVakZV2wkFQX2jkU5BRvgTrck
	ot/LbnLsTpBq8BvwoILBpkAwxoBml9s4aeDP+2YozT0thZg5XMuGT+IcZgI9GEsPXPfVHdxEaRT
	zeaQT0OHwnFzWIBuQuJYaHglFThW/znWEGiclAnvJ+4EUu11/6zhimQqMpflygL5cqOqxSJm7LR
	9jF4yk6H1IAinswQ+zVypxAGoI7MvvINHtkHQg1a7C
X-Google-Smtp-Source: AGHT+IEHe9SkuremXkwGFi2FaIb8CUv1fFBjSZogbj5L+apUmO6ApQDbI6nK3Rp0HrvwhEdBUvUfhQ==
X-Received: by 2002:a05:6300:8812:b0:334:a915:21bf with SMTP id adf61e73a8af0-334a9152202mr32544364637.1.1761259949757;
        Thu, 23 Oct 2025 15:52:29 -0700 (PDT)
Received: from [192.168.2.125] (69-172-167-162.cable.teksavvy.com. [69.172.167.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e318a2sm3140090a12.33.2025.10.23.15.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 15:52:29 -0700 (PDT)
Message-ID: <bcff860e-749b-4911-9eba-41b47c00c305@arista.com>
Date: Thu, 23 Oct 2025 15:52:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
 <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
Content-Language: en-US
From: Christoph Schwarz <cschwarz@arista.com>
In-Reply-To: <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 18:24, Neal Cardwell wrote:
[...]
> Thanks for the report!
> 
> A few thoughts:
> 
[...]
> 
> (2) After that, would it be possible to try this test with a newer
> kernel? You mentioned this is with kernel version 5.10.165, but that's
> more than 2.5 years old at this point, and it's possible the bug has
> been fixed since then.  Could you please try this test with the newest
> kernel that is available in your distribution? (If you are forced to
> use 5.10.x on your distribution, note that even with 5.10.x there is
> v5.10.245, which was released yesterday.)
> 
> (3) If this bug is still reproducible with a recent kernel, would it
> be possible to gather .pcap traces from both client and server,
> including SYN and SYN/ACK? Sometimes it can be helpful to see the
> perspective of both ends, especially if there are middleboxes
> manipulating the packets in some way.
> 
> Thanks!
> 
> Best regards,
> neal

Hi,

I want to give an update as we made some progress.

We tried with the 6.12.40 kernel, but it was much harder to reproduce 
and we were not able to do a successful packet capture and reproduction 
at the same time. So we went back to 5.10.165, added more tracing and 
eventually figured out how the TCP connection got into the bad state.

This is a backtrace from the TCP stack calling down to the device driver:
  => fdev_tx    // ndo_start_xmit hook of a proprietary device driver
  => dev_hard_start_xmit
  => sch_direct_xmit
  => __qdisc_run
  => __dev_queue_xmit
  => vlan_dev_hard_start_xmit
  => dev_hard_start_xmit
  => __dev_queue_xmit
  => ip_finish_output2
  => __ip_queue_xmit
  => __tcp_transmit_skb
  => tcp_write_xmit

tcp_write_xmit sends segments of 65160 bytes. Due to an MSS of 1448, 
they get broken down into 45 packets of 1448 bytes each. These 45 
packets eventually reach dev_hard_start_xmit, which is a simple loop 
forwarding packets one by one. When the problem occurs, we see that 
dev_hard_start_xmit transmits the initial N packets successfully, but 
the remaining 45-N ones fail with error code 1. The loop runs to 
completion and does not break.

The error code 1 from dev_hard_start_xmit gets returned through the call 
stack up to tcp_write_xmit, which treats this as error and breaks its 
own loop without advancing snd_nxt:

		if (unlikely(tcp_transmit_skb(sk, skb, 1, gfp)))
			break; // <<< breaks here

repair:
		/* Advance the send_head.  This one is sent out.
		 * This call will increment packets_out.
		 */
		tcp_event_new_data_sent(sk, skb);

 From packet captures we can prove that the 45 packets show up on the 
kernel device on the sender. In addition, the first N of those 45 
packets show up on the kernel device on the peer. The connection is now 
in the problem state where the peer is N packets ahead of the sender and 
the sender thinks that it never those packets, leading to the problem as 
described in my initial mail.

Furthermore, we noticed that the N-45 missing packets show up as drops 
on the sender's kernel device:

vlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 127.2.0.1  netmask 255.255.255.0  broadcast 0.0.0.0
         [...]
         TX errors 0  dropped 36 overruns 0  carrier 0  collisions 0

This device is a vlan device stacked on another device like this:

49: vlan0@parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc 
noqueue state UP mode DEFAULT group default qlen 1000
     link/ether 02:1c:a7:00:00:01 brd ff:ff:ff:ff:ff:ff
3: parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 10000 qdisc prio state 
UNKNOWN mode DEFAULT group default qlen 1000
     link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff

Eventually packets need to go through the device driver, which has only 
a limited number of TX buffers. The driver implements flow control: when 
it is about to exhaust its buffers, it stops TX by calling 
netif_stop_queue. Once more buffers become available again, it resumes 
TX by calling netif_wake_queue. From packet counters we can tell that 
this is happening frequently.

At this point we suspected "qdisc noqueue" to be a factor, and indeed, 
after adding a queue to vlan0 the problem no longer happened, although 
there are still TX drops on the vlan0 device.

Missing queue or not, we think there is a disconnect between the device 
driver API and the TCP stack. The device driver API only allows 
transmitting packets one by one (ndo_start_xmit). The TCP stack operates 
on larger segments that is breaks down into smaller pieces 
(tcp_write_xmit / __tcp_transmit_skb). This can lead to a classic "short 
write" condition which the network stack doesn't seem to handle well in 
all cases.

Appreciate you comments,
Chris


