Return-Path: <netdev+bounces-174572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BFA5F4FB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C3A1669A0
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4D2673A1;
	Thu, 13 Mar 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gK+NIxjH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8C264FBC;
	Thu, 13 Mar 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870508; cv=none; b=LtTkTUQcQGGTg7TIUJo2m4Afk2WKAyMou+4BtsW9oWKytN6lrTReSXElChBRyh6/Q9uPCh9S/fOkX3hmITnJfH6XpAe5/TMEZExwmYmscxiuqNctloLwsX6v7M8PFjMpzwlIbdxtmhH4u2DmaGfO0+5jI39y+o9NLAHliZGwHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870508; c=relaxed/simple;
	bh=CCEtVfnsZrC2J46tRuWCShcdrEwGwGkKg9nBPiglXjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0siEfsSF5WvSBiW1NFK5I7zbesiy+F96rZlABrZNxUmOpnghgmyUZ39GcaW8CmdfejRhl1yiURYOp5tNOUJEC1WAS+4yZ2U/rJWEbNm235hOz48wJofE7lpK4jFAVQZyKz3LFGchop/FTN1pmgj9fMxW5ppvOhi132tNoUk9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gK+NIxjH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JAmSBShQ4Oo+DzVgXCfJRH9EvtD5cdq+eGj0LwrBrMM=; b=gK+NIxjHhbJg9QA80guaisWjV1
	fhUZPcPh+lhz0p7UJTieeyzosK7n9tQkzGdJk2ay7IGt3CC+SZZpGCTEa4UmM9ulRFkHDQxhmeAVD
	eIA3rR10nj78pdnZ89dyF5tZi00KtN/v81EUUJvn2GYYnPDCbHzVk7m2zpP1XD7SGWJo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsi5R-004zY7-Lz; Thu, 13 Mar 2025 13:54:57 +0100
Date: Thu, 13 Mar 2025 13:54:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Message-ID: <468deb47-1837-4709-84e5-b14bf0e8c2a5@lunn.ch>
References: <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <Z9HjOAnpNkmZcoeo@shell.armlinux.org.uk>
 <186bf47a-04af-4bfb-a6d3-118b844c9ba8@lunn.ch>
 <BL3PR12MB6571E707DC09A31A553CB1BCC9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571E707DC09A31A553CB1BCC9D32@BL3PR12MB6571.namprd12.prod.outlook.com>

> Synthesis options I mentioned in comment might sound confusing, let me clear it up.
> Actual synthesis options (as seen from configuration UI) IP provides are (1) and (2). When a user selects (2), IP comes with default 2.5G but also contains 1G capabilities which can be enabled and work with by adding switching FPGA logic (that makes it (3)).
> 
> So, in short  if a user selects (1): It's <=1G only.
> If it selects (2): It's 2.5G only but can be made (3) by FPGA logic changes. So whatever existing systems for (3) would be working at default (2).
> 
> This is the reason we didn't described (3) in V1 series as that is not provided by IP but can be synthesized after FPGA changes.

This whole discussion would of been much easier and wasted a lot less
time if you had given us accurate information right from the start....

So 3) does not exist at the moment, because if it did, the customer
doing it would need to make proprietary changes, both to the licensed
IP and the driver. We have not seen such driver patch submissions...

    Andrew

---
pw-bot: cr

