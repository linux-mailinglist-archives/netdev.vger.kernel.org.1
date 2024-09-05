Return-Path: <netdev+bounces-125565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42196DBB4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9601C252C1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A2DDBE;
	Thu,  5 Sep 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PoBm7UFU"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174B1CA84
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546277; cv=none; b=TsynkrVd0PhHIwAt5veX0VBtWu/X5y5ndo5XlPEUB4dp32rZaL6GLpLO2QbiRfNq6BfJnwB/64gmdwuTA+jEyXMNSnKzwdDpeUscIzQrUSiku05VYtE1AF+des/qVEI1bokqnRRes6+p3CCgcwsWFk/mEON4BWxIFnZttpwbCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546277; c=relaxed/simple;
	bh=am6Cp+AEuJGNKpoxHu9bp8q9uOFc3n339MCD3TT9aEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ4Lj4ReGrsDsm/YwR2Od+yawNSP3zAoxt7R1EXR/KrJnrSphh0sa35n2jT+NTb8FTDWaVaj+B77vXHXpA2UcnGsahDCcjTDKTGbSIcYF/mCcvEKH9uHUY1LQtHmxqG/UU2P3yEsf5hJoSZG6dISaUHBPsPw6aZgodciONBNMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PoBm7UFU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <156719f8-7ee8-4c81-97ba-5f87afb44fcf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725546273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2nr4SZifsXmeSrfvwtYbuSX2mlUeDCnuX2HngHo/rQ=;
	b=PoBm7UFUezSuKcvoSJImlTK4KtjkIgE0rPXojd3opeK1B/rI5nI6ihsPE4eDNpfvZbiGLj
	fVt29ia3O8YETd5QKkyXRsLsSZLPrx0etbmEU7suUrc09aGzMQgRUhHuaKutaadBY/H0FG
	Svy9j5GEWAbBKJfZMkcOW4q36h+0vVQ=
Date: Thu, 5 Sep 2024 10:24:23 -0400
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CANn89iKJiU0DirRbpnMTPe0w_PZn9rf1_5=mAxhi3zbcoJR49A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 12:30, Eric Dumazet wrote:
> On Tue, Sep 3, 2024 at 8:43 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> The partial rx checksum feature computes a checksum over the entire
>> packet, regardless of the L3 protocol. Remove the check for IPv4.
>> Additionally, packets under 64 bytes should have been dropped by the
>> MAC, so we can remove the length check as well.
> 
> Some packets have a smaller len (than 64).
> 
> For instance, TCP pure ACK and no options over IPv4 would be 54 bytes long.
> 
> Presumably they are not dropped by the MAC ?

Ethernet frames have a minimum size on the wire of 64 bytes. From 802.3
section 4.2.4.2.2:

| The shortest valid transmission in full duplex mode must be at least
| minFrameSize in length. While collisions do not occur in full duplex
| mode MACs, a full duplex MAC nevertheless discards received frames
| containing less than minFrameSize bits. The discarding of such a frame
| by a MAC is not reported as an error.

where minFrameSize is 512 bits (64 bytes).

On the transmit side, undersize frames are padded. From 802.3 section
4.2.3.3:

| The CSMA/CD Media Access mechanism requires that a minimum frame
| length of minFrameSize bits be transmitted. If frameSize is less than
| minFrameSize, then the CSMA/CD MAC sublayer shall append extra bits in
| units of octets (Pad), after the end of the MAC Client Data field but
| prior to calculating and appending the FCS (if not provided by the MAC
| client).

That said, I could not find any mention of a minimum frame size
limitation for partial checksums in the AXI Ethernet documentation.
RX_CSRAW is calculated over the whole packet, so it's possible that this
check is trying to avoid passing it to the net subsystem when the frame
has been padded. However, skb->len is the length of the Ethernet packet,
so we can't tell how long the original packet was at this point. That
can only be determined from the L3 header, which isn't parsed yet. I
assume this is handled by the net subsystem.

--Sean

