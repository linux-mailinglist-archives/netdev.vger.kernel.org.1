Return-Path: <netdev+bounces-193025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B289AAC23BF
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00507B21A5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A1291863;
	Fri, 23 May 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bL4/7YsZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7513D539;
	Fri, 23 May 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006653; cv=none; b=r2kIgzdRh2ktMZKR9MpVM1fUqh/yg+veArbIdF6PpQwi9GTbT5bsvZZ4hp5m6pjgvD7rVsWcakBV8pvVfIgGOcAyVOKMTFI3m+n/AxwM8ZxcwBpGJi7zJkkMOOMCCe5lLPyxQ2zvSoe3tNqaCys3R1Ta8shV7PhhNAX3urwzx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006653; c=relaxed/simple;
	bh=QWwG59g5MU2yUcdEwHwb3pj0woEQNNX3BJXpMdxaGdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdH8Dl55vPDljzfolteAUjPCGP4OtBC6hzY6MMGW7lmPen4J8aFCGmhDx+uGLBpQYddKWh+lKckr/SDY3gzUd99VE615BkTzBCt12J54S94mNdf6HY0nZkKiC9C7GgMepkqVSHuF4MFrOFUVIS/koyRfbMHymA+NPlZDlxftloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bL4/7YsZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9PPnvysXCe7nzpl2dlq+yYzcvu67I28jfeZX7VT12P0=; b=bL
	4/7YsZC73DTlJZDPOpH6yqzgpyOF3021NjeoxBga9DgVV4B2V1TxU1qUt9ndN6uFuuHpWrZgsBB2z
	2VPUAUl8WMAh7r+MPq1yg+YSoIdNA+cc668P5Ocohltm5UO7JE5uuPTwLb3LPLeJs60/7BckmpOPO
	w2jlB6cyGEKXUwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uISNX-00Dc47-JO; Fri, 23 May 2025 15:24:03 +0200
Date: Fri, 23 May 2025 15:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on
 bcm63xx
Message-ID: <a1197a9b-48c3-4dce-866e-287f5cd30865@lunn.ch>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com>
 <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
 <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
 <2e5e16a1-e59e-470d-a1d9-618a1b9efdd4@lunn.ch>
 <CAOiHx=mQ8z1CO1V-8b=7pjK-Hm9_4-tcvucKXpM1i+eOOB4axg@mail.gmail.com>
 <e0d25a68-057b-4839-a8cd-affe458bfea3@lunn.ch>
 <CAOiHx==NzwF3mXfkf+mS0AZzb-FTR0SHwG9n0Hw9nRiR4k-z6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==NzwF3mXfkf+mS0AZzb-FTR0SHwG9n0Hw9nRiR4k-z6w@mail.gmail.com>

On Fri, May 23, 2025 at 11:08:55AM +0200, Jonas Gorski wrote:
> On Tue, May 20, 2025 at 2:15 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Without this change no mode/port works, since there is always either a
> > > 0 ns delay or a 4 ns delay in the rx/tx paths (I assume, I have no
> > > equipment to measure).
> > >
> > > With this change all modes/ports work.
> >
> > Which is wrong.
> >
> > > With "rgmii-id" the mac doesn't
> > > configure any delays (and the phy does instead), with "rgmii" it's
> > > vice versa, so there is always the expected 2 ns delay. Same for rxid
> > > and txid.
> >
> > If you read the description of what these four modes mean, you should
> > understand why only one should work. And given the most likely PCB
> > design, the only mode that should work is rgmii-id. You would have to
> > change the PCB design, to make the other modes work.
> 
> Since I also have BCM6368 with a BCM53115 connected to one of the
> RGMII ports lying around, I played around with it, and it was
> surprisingly hard to make it *not* work. Only if I enabled delay on
> *both* sides it stopped working, no delay or delay only on one side
> continued working (and I used iperf to try if larger amounts of
> traffic break it).

Interesting. You see the Rockchip people insisting their devices need
fine tuning, 2ns is not good enough, it needs to be 1.9ns. And then
they end up in a mess with interpreting what phy-mode actually means.

In some ways, this just as bad. You can get away with using 'rgmii'
which is wrong, when it should be 'rgmii-id'. It would be better if
only just one mode worked, then DT developers would get it correct.

	Andrew

