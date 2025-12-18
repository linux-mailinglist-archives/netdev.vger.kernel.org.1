Return-Path: <netdev+bounces-245307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4623ECCB2D8
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B74163029B66
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B72DC33F;
	Thu, 18 Dec 2025 09:31:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6E2EBBBC
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050288; cv=none; b=G9056LqtDfPQJZY+u7WCUoVyEYwpVHzSwFO8k66fo7EPqr0YbX7vrfdF3HF9cwxeWkMK+JL8Oc8+MQT8AY5zpkHhr6cTOmyryiAfDy9Pv6mkgwKalwh5N2k1racaEL25mrfwDgJ8Ek8DXzegU5f76Y+gXaXQdcYqBxGIkNR/0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050288; c=relaxed/simple;
	bh=JhbLteRyRtTT3gBDAvBvtJCQzZ0+fa8JnzcYDcM6b+0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kArQ2P/7ls3UHgAKYqTRhj45YI0mUskpEhYdVbYN4SGCiZYurL0uqSHX0xf/2g1Xl/bRRfw9eCgSxFZe6Kc1ytNSKZfxbrQc3L0Q0P1DoX9pN+YnBUtUcXIuePG/UEYU917x3tNpLbiRgrQxMxSLwAy9KFiHQzs6EO12Yyi5Z84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CB5D2473BA;
	Thu, 18 Dec 2025 10:31:17 +0100 (CET)
Message-ID: <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
Date: Thu, 18 Dec 2025 10:31:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
From: Christian Ebner <c.ebner@proxmox.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, lkolbe@sodiuswillert.com
References: <20250711114006.480026-1-edumazet@google.com>
 <20250711114006.480026-8-edumazet@google.com>
 <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com>
Content-Language: en-US, de-DE
In-Reply-To: <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1766050265384

Hi,
to add some more information gained.

pcaps obtained via tcpdump of the traffic while in a stale state show 
the following recurring pattern:

41	0.705618	10.xx.xx.aa	10.xx.xx.bb	TCP	66	[TCP ZeroWindow] 8007 → 55554 
[ACK] Seq=1 Ack=28673 Win=0 Len=0 TSval=2656874280 TSecr=1348075902
42	0.705662	10.xx.xx.aa	10.xx.xx.bb	TCP	66	[TCP Window Update] 8007 → 
55554 [ACK] Seq=1 Ack=28673 Win=7 Len=0 TSval=2656874280 TSecr=1348075902
90	0.914606	10.xx.xx.bb	10.xx.xx.aa	TCP	7234	55554 → 8007 [PSH, ACK] 
Seq=28673 Ack=1 Win=139 Len=7168 TSval=1348076111 TSecr=2656874280

Output of `ss -tim` show the sockets being severely limited in buffer size:

ESTAB                          0                               0 
  
[::ffff:10.xx.xx.aa]:8007 
       [::ffff:10.xx.xx.bb]:55554
          skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic 
wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000 
rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478 
bytes_received:1295747055 segs_out:301010 segs_in:162410 
data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308 
lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps 
delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242 
rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wnd:7168

This would indicate that the buffer size not growing while in this 
state, therefore limiting the rcv_wnd?

Best regards,
Christian Ebner


