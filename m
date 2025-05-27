Return-Path: <netdev+bounces-193686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F0AC5185
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21C417F6BA
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E662E2798F0;
	Tue, 27 May 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wEktqAyU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061C27979A
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358182; cv=none; b=KfrevMzAeav+YHhWgo79UABysPHAeL527vlq2z3EQHKpc2+D6iicedYNXnteEbhH3etyqaqkhlPDK/IXyywf+/VD5JF3m3l+y6qtzKbenxHWZmiZ55PsybTXb+Sn6Yh3rlcrmZYwiHHKbbaF7CpMMQWJuJg12GdvUPSzVQLJ4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358182; c=relaxed/simple;
	bh=ebWtN4bB5Ewb/8TjxpXfXz1i1Mf2JMJOPDj61AHMBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9DlDbIkrTihmzRqz+NCmkXslBvrQDsEabtMo1tjqpAXL/e9BBeBDg2xqrG2EpOdS4AXPcYdSBk2v5Lz3l/oANt0I/+Yi1RLX17B7TkQdcMdXygChKeuMtUE+wnw1yvGCBdfs1zkfAB2OgeyyHJaD5jhJesWVsuPmw70HmMZAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wEktqAyU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yr6Oas7ZQRAgKZXGxIoD3a1Zy3jLO0HdkX5/LMyqldw=; b=wEktqAyUyaU8C0rgfexnHN9rQ3
	Zw/5glxb3I0TS+EMUP1VjodOcHjvGCY6xNOXuRD6yBCP6oQA9Lmlc/POqgUvm/yVAddYRkZkvz5UM
	sx46vA07bhInVlDEP8K82rWqWfdJeNYe5er9jk0asyYBYSe/4O/sw5xvVvYSlmcEFimU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJvpL-00E5SA-RO; Tue, 27 May 2025 17:02:51 +0200
Date: Tue, 27 May 2025 17:02:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
References: <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>

On Tue, May 27, 2025 at 04:25:16PM +0200, Ricard Bejarano wrote:
> Ok, I was going mad trying to find CRC stats for blue's tb0.
> 
> 'ethtool -S' returns "no stats available".
> 'netstat' and 'ss' aren't much better than 'ip -s link show dev'.
> CRC verification is done by the driver so 'tcpdump' won't see those (I do see loss, however).
> 
> But, I do see the thunderbolt-net driver exposes rx_crc_errors.
> And then I found 'ip -s -s' (double -s):
> 
> root@blue:~# ip -s -s link show dev tb0
> 5: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP mode DEFAULT group default qlen 1000
>     link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast           
>     9477191497 6360635  16763       0       0       0 
>     RX errors:  length    crc   frame    fifo overrun
>                      0  16763       0       0       0 
>     TX:  bytes packets errors dropped carrier collsns           
>           8861     100      0       0       0       0 
>     TX errors: aborted   fifo  window heartbt transns
>                      0      0       0       0       2 
> root@blue:~# 
> 
> Bingo! CRC errors.
> 
> How can we proceed?

static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
                              const struct thunderbolt_ip_frame_header *hdr)
{
        u32 frame_id, frame_count, frame_size, frame_index;
        unsigned int size;

        if (tf->frame.flags & RING_DESC_CRC_ERROR) {
                net->stats.rx_crc_errors++;
                return false;

So it looks like CRC is offloaded to the hardware. I've never look at
thunderbolt, so i have no idea what its frame structure looks like.

Maybe hack out this test, and allow the corrupt frame to be
received. Then look at it with Wireshark and see if you can figure out
what is wrong with it. Knowing what is wrong with it might allow you
to backtrack to where it gets mangled.

Looking further into that function, it seems like one Ethernet frame
can be split over multiple TB frames. When it is, the skbuf has
multiple fragments. Wild guess: Copying such fragments to user space
works, that is a core networking thing, heavily used, well tested. But
when the skbuf is bridged and sent out another interface, that code
does not correctly handle the fragments? You might want to stare at
tbnet_start_xmit() and see if you can see something wrong with the
code around 'frag'.

	Andrew

