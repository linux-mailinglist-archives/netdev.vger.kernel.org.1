Return-Path: <netdev+bounces-125622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BC96DFCF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424B0B217B8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F31A01B6;
	Thu,  5 Sep 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9RmLBap"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D077F10
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553940; cv=none; b=rfJ724byiOeLXAqqRbWd0eYZ56J5bMkSTBAjiLIhfxvn2cK1LudkhExZdU7uNAiBH90W4JArtypG704WHNkvPTnkTrEC/xACGlARB04D2wTLViPi4qT9JvSEpg35x0AuArCzhZdYElwqfbVeZ3FGlpKQ88sZsmVrLO68V3lgKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553940; c=relaxed/simple;
	bh=PhMfHsxsuV4e0GfUnbMSJQRxLiO8JgQ98/CnCKiEpV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD8xSYa7JA6Xa0fHY+g5wGTGBN9IOe8Q+G74HvuRtUrcczPVh7mQuf6433AiHHB5b2VJAZynPKkVmnq9Jqn69zvusg2NYuCXHW9UTNRUbg+xbiRPMp+IKdTyjcjmgpcSvvB9JcwYaubNJoYou1+zqhZa3eGn89oXu317z/kEXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r9RmLBap; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef1697a9-5f1b-459b-b3a1-32926fe2193f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725553935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bquw+gzeKG/uEvh1zvhW7asFOKanvNU5I6V4zRN6qGk=;
	b=r9RmLBap1kqM9iSxRGsgxjl8dbkNLAVmVMvJ7DLz0sd6fbuKC18y93+G/qDfnYc+Q4QrA4
	tJLpl30JteGssjePFxkxVaZmxrtVdt87Tz8H1PCCWsAP44csKoexg/PsjcQksObC6CLLIv
	Omw3jhM6BR1BVFv072GG6YINJ7rUAFA=
Date: Thu, 5 Sep 2024 12:32:04 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum
 checks
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CANn89i+3kwiF0NESY7ReK=ZrNbhc7-q7QU2sZhsR9gtwVje2jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/5/24 10:59, Eric Dumazet wrote:
> On Thu, Sep 5, 2024 at 4:24 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> On 9/4/24 12:30, Eric Dumazet wrote:
>> > On Tue, Sep 3, 2024 at 8:43 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>> >>
>> >> The partial rx checksum feature computes a checksum over the entire
>> >> packet, regardless of the L3 protocol. Remove the check for IPv4.
>> >> Additionally, packets under 64 bytes should have been dropped by the
>> >> MAC, so we can remove the length check as well.
>> >
>> > Some packets have a smaller len (than 64).
>> >
>> > For instance, TCP pure ACK and no options over IPv4 would be 54 bytes long.
>> >
>> > Presumably they are not dropped by the MAC ?
>>
>> Ethernet frames have a minimum size on the wire of 64 bytes. From 802.3
>> section 4.2.4.2.2:
>>
>> | The shortest valid transmission in full duplex mode must be at least
>> | minFrameSize in length. While collisions do not occur in full duplex
>> | mode MACs, a full duplex MAC nevertheless discards received frames
>> | containing less than minFrameSize bits. The discarding of such a frame
>> | by a MAC is not reported as an error.
>>
>> where minFrameSize is 512 bits (64 bytes).
>>
>> On the transmit side, undersize frames are padded. From 802.3 section
>> 4.2.3.3:
>>
>> | The CSMA/CD Media Access mechanism requires that a minimum frame
>> | length of minFrameSize bits be transmitted. If frameSize is less than
>> | minFrameSize, then the CSMA/CD MAC sublayer shall append extra bits in
>> | units of octets (Pad), after the end of the MAC Client Data field but
>> | prior to calculating and appending the FCS (if not provided by the MAC
>> | client).
>>
>> That said, I could not find any mention of a minimum frame size
>> limitation for partial checksums in the AXI Ethernet documentation.
>> RX_CSRAW is calculated over the whole packet, so it's possible that this
>> check is trying to avoid passing it to the net subsystem when the frame
>> has been padded. However, skb->len is the length of the Ethernet packet,
>> so we can't tell how long the original packet was at this point. That
>> can only be determined from the L3 header, which isn't parsed yet. I
>> assume this is handled by the net subsystem.
>>
> 
> The fact there was a check in the driver hints about something.
> 
> It is possible the csum is incorrect if a 'padding' is added at the
> receiver, if the padding has non zero bytes, and is not included in
> the csum.
> 
> Look at this relevant patch :
> 
> Author: Saeed Mahameed <saeedm@mellanox.com>
> Date:   Mon Feb 11 18:04:17 2019 +0200
> 
>     net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Well, I tested UDP and it appears to be working fine. First I ran

# nc -lu

on the DUT. On the other host I used scapy to send a packet with some
non-zero padding:

  >>> port = RandShort()
  >>> send(IP(dst="10.0.0.2")/UDP(sport=port, dport=4444)/Raw(b'data\r\n')/Padding(load=b'padding'))

I verified that the packet was received correctly, both in netcat and
with tcpdump:

    # tcpdump -i net4 -xXn 
    tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
    listening on net4, link-type EN10MB (Ethernet), snapshot length 262144 bytes
    16:07:45.083795 IP 10.0.0.1.27365 > 10.0.0.2.4444: UDP, length 6
            0x0000:  4500 0022 0001 0000 4011 66c8 0a00 0001  E.."....@.f.....
            0x0010:  0a00 0002 6ae5 115c 000e 0005 6461 7461  ....j..\....data
            0x0020:  0d0a 7061 6464 696e 6700 0000 0000       ..padding.....

and also checked for checksum errors:

  # netstat -s | grep InCsumErrors
      InCsumErrors: 0

to verify that checksums were being checked properly, I also sent a
packet with an invalid checksum:

  >>> send(IP(dst="10.0.0.2")/UDP(sport=port, dport=4444, chksum=5)/Raw(b'data\r\n')/Padding(load=b'padding'))

and confirmed that there was no output on netcat, and that I had gotten
a UDP checksum error:

  # netstat -s | grep InCsumErrors
      InCsumErrors: 1

I can try to test TCP as well, but it is a bit trickier due to the 3-way
handshake. From the documentation, partial checksums should be agnostic
to the L3 protocol, so I don't think there should be any difference.

--Sean

