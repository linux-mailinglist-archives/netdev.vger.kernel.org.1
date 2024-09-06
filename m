Return-Path: <netdev+bounces-126071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06E96FD7F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7DB1C21F05
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56E159598;
	Fri,  6 Sep 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RuQYGU4U"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873315957E
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658670; cv=none; b=oIqwOLHwAAbIlYhv4dGyChDDqJw6lgfjtHEjL8HlONx0IzmkfG7nYIqHbiYT81GiKV0Fe+rUjNqcORo9wML8iQsa/gbR6bRiQasBMT+xuFwqUiHW6Q53bxMP9Fu4Ltkykb51lZX0j0+eODUpiUSx4OlhCSNZed6NkabRGdh7tVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658670; c=relaxed/simple;
	bh=JGQi6FvCpuiT2ijL8cbu5FxHucyNfc4Ntf9zRg4wzH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKFzWh4+Qkt2cecfN08hFSRF329adlKB3k8qDNGTA6TQQqcfqudAKvNzXFFpTroIF6+xlPBiPtPxPL9UUFQGwFBfgIpvxdN5WJ5jcYmHhtaNBWpcUpjn1v6NfgVTHlqRwPcfehpwKKSyf+B4gfcNCtM5cWcKP/XQTrdhuwEvxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RuQYGU4U; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36eebfb3-9b0f-4c5b-a78d-d77268e5d427@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725658665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsG/xaoOVpMq9tfHFIFZMN5tyvsB1gE3xhnwPSAJPhc=;
	b=RuQYGU4U2P3wC1XC/pWl68wWoIWwFuP3hPTGlmOy0Ib5GUkLI/jk4zZYNtOuhbybvxeUA0
	Yl3lgFhXO3ehdVB/wqM/1SBEhALL94+ZyBnnVlohRAp/WK7seWx2Jni6b+KvaCj6zWsBfu
	jwGZhGNsrBphe79GAx/tpu2mkyni9i0=
Date: Fri, 6 Sep 2024 17:37:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum
 checks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-4-sean.anderson@linux.dev>
 <CANn89iKJiU0DirRbpnMTPe0w_PZn9rf1_5=mAxhi3zbcoJR49A@mail.gmail.com>
 <156719f8-7ee8-4c81-97ba-5f87afb44fcf@linux.dev>
 <CANn89i+3kwiF0NESY7ReK=ZrNbhc7-q7QU2sZhsR9gtwVje2jA@mail.gmail.com>
 <ef1697a9-5f1b-459b-b3a1-32926fe2193f@linux.dev>
Content-Language: en-US
In-Reply-To: <ef1697a9-5f1b-459b-b3a1-32926fe2193f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Eric,

On 9/5/24 12:32, Sean Anderson wrote:
> On 9/5/24 10:59, Eric Dumazet wrote:
>> On Thu, Sep 5, 2024 at 4:24 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>>
>>> On 9/4/24 12:30, Eric Dumazet wrote:
>>> > On Tue, Sep 3, 2024 at 8:43 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>> >>
>>> >> The partial rx checksum feature computes a checksum over the entire
>>> >> packet, regardless of the L3 protocol. Remove the check for IPv4.
>>> >> Additionally, packets under 64 bytes should have been dropped by the
>>> >> MAC, so we can remove the length check as well.
>>> >
>>> > Some packets have a smaller len (than 64).
>>> >
>>> > For instance, TCP pure ACK and no options over IPv4 would be 54 bytes long.
>>> >
>>> > Presumably they are not dropped by the MAC ?
>>>
>>> Ethernet frames have a minimum size on the wire of 64 bytes. From 802.3
>>> section 4.2.4.2.2:
>>>
>>> | The shortest valid transmission in full duplex mode must be at least
>>> | minFrameSize in length. While collisions do not occur in full duplex
>>> | mode MACs, a full duplex MAC nevertheless discards received frames
>>> | containing less than minFrameSize bits. The discarding of such a frame
>>> | by a MAC is not reported as an error.
>>>
>>> where minFrameSize is 512 bits (64 bytes).
>>>
>>> On the transmit side, undersize frames are padded. From 802.3 section
>>> 4.2.3.3:
>>>
>>> | The CSMA/CD Media Access mechanism requires that a minimum frame
>>> | length of minFrameSize bits be transmitted. If frameSize is less than
>>> | minFrameSize, then the CSMA/CD MAC sublayer shall append extra bits in
>>> | units of octets (Pad), after the end of the MAC Client Data field but
>>> | prior to calculating and appending the FCS (if not provided by the MAC
>>> | client).
>>>
>>> That said, I could not find any mention of a minimum frame size
>>> limitation for partial checksums in the AXI Ethernet documentation.
>>> RX_CSRAW is calculated over the whole packet, so it's possible that this
>>> check is trying to avoid passing it to the net subsystem when the frame
>>> has been padded. However, skb->len is the length of the Ethernet packet,
>>> so we can't tell how long the original packet was at this point. That
>>> can only be determined from the L3 header, which isn't parsed yet. I
>>> assume this is handled by the net subsystem.
>>>
>> 
>> The fact there was a check in the driver hints about something.
>> 
>> It is possible the csum is incorrect if a 'padding' is added at the
>> receiver, if the padding has non zero bytes, and is not included in
>> the csum.
>> 
>> Look at this relevant patch :
>> 
>> Author: Saeed Mahameed <saeedm@mellanox.com>
>> Date:   Mon Feb 11 18:04:17 2019 +0200
>> 
>>     net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
> 
> Well, I tested UDP and it appears to be working fine. First I ran
> 
> # nc -lu
> 
> on the DUT. On the other host I used scapy to send a packet with some
> non-zero padding:
> 
>   >>> port = RandShort()
>   >>> send(IP(dst="10.0.0.2")/UDP(sport=port, dport=4444)/Raw(b'data\r\n')/Padding(load=b'padding'))
> 
> I verified that the packet was received correctly, both in netcat and
> with tcpdump:
> 
>     # tcpdump -i net4 -xXn 
>     tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
>     listening on net4, link-type EN10MB (Ethernet), snapshot length 262144 bytes
>     16:07:45.083795 IP 10.0.0.1.27365 > 10.0.0.2.4444: UDP, length 6
>             0x0000:  4500 0022 0001 0000 4011 66c8 0a00 0001  E.."....@.f.....
>             0x0010:  0a00 0002 6ae5 115c 000e 0005 6461 7461  ....j..\....data
>             0x0020:  0d0a 7061 6464 696e 6700 0000 0000       ..padding.....
> 
> and also checked for checksum errors:
> 
>   # netstat -s | grep InCsumErrors
>       InCsumErrors: 0
> 
> to verify that checksums were being checked properly, I also sent a
> packet with an invalid checksum:
> 
>   >>> send(IP(dst="10.0.0.2")/UDP(sport=port, dport=4444, chksum=5)/Raw(b'data\r\n')/Padding(load=b'padding'))
> 
> and confirmed that there was no output on netcat, and that I had gotten
> a UDP checksum error:
> 
>   # netstat -s | grep InCsumErrors
>       InCsumErrors: 1
> 
> I can try to test TCP as well, but it is a bit trickier due to the 3-way
> handshake. From the documentation, partial checksums should be agnostic
> to the L3 protocol, so I don't think there should be any difference.
> 
> --Sean

I saw that there was a checksum selftest today, so I went back and ran
that as well. I managed to get it to pass:

# NETIF=net LOCAL_V4=10.0.0.1 LOCAL_V6=fc00::1 REMOTE_V4=10.0.0.2 REMOTE_V6=fc00::2 REMOTE_TYPE=netns REMOTE_ARGS=ns2 ip netns exec ns1 kselftest_install/drivers/net/hw/csum.py
KTAP version 1
1..12
ok 1 csum.ipv4_rx_tcp
ok 2 csum.ipv4_rx_tcp_invalid
ok 3 csum.ipv4_rx_udp
ok 4 csum.ipv4_rx_udp_invalid
ok 5 csum.ipv4_tx_udp_csum_offload
ok 6 csum.ipv4_tx_udp_zero_checksum
ok 7 csum.ipv6_rx_tcp
ok 8 csum.ipv6_rx_tcp_invalid
ok 9 csum.ipv6_rx_udp
ok 10 csum.ipv6_rx_udp_invalid
ok 11 csum.ipv6_tx_udp_csum_offload
ok 12 csum.ipv6_tx_udp_zero_checksum
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

But ended up having to modify the test [1] to handle exactly this
situation (but in the test's reference checksum). I also had to add
another patch to set NETIF_F_RXCSUM for this driver. I think this shows
that there should be no hardware issue with removing the length check.
I'll send a v2 on Monday with the RXCSUM patch unless you have any
objections.

--Sean

[1] https://lore.kernel.org/netdev/20240906210743.627413-1-sean.anderson@linux.dev

