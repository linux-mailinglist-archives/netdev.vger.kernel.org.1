Return-Path: <netdev+bounces-70277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9784E386
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7E4281EC4
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3B79DBD;
	Thu,  8 Feb 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bylYhYu9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A56BB36
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404195; cv=none; b=Nw2Hl8gnlZ8z9hUCFH9NPlu1U+yuyZKl60gxaRXxWIsYoF3nr6eaz/PiiCBFws76TPL2jXm1I22fcoVRRJujWZdnoqxIf62sh8Mhb+SX5Y4wIc/gsfLndlfuE1YKg6ypD7IeeEy69jldkevlbGJdKnOaeAf0hcjspLEWlk7siHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404195; c=relaxed/simple;
	bh=4ZjKlLJwKiQBV03QIrQ5rKpFagHd0yPASmokBnbNfec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxTa0x1zcV4bM2/TDeXYYu6jcLF3V+FlBWhyCOZU+OdyBVzWmPibzHb9uJda9WMi7rokK8d6wqty+JoxmrTS1OJutUTvmPD9KXigjO+d/lzAEL5h7m9UOd9aoydm9wdCURVmv7pJHFaqMMzPtF1jmUgBQ9I1VGB5J2D3K+Qa0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bylYhYu9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4XecEseGpYjYkzOJBtEqqKpX8jMT2WIiF2JXTeOMVbw=; b=by
	lYhYu9sKmpJB74CgC03K7qElapNbN7jPfkO5CHA3wrBAxRjHRPDAN0/KaI24QY/jqZ71dxGcOjd0P
	8SBFKWL5D+TQhALxKPw9ke390KXJ8FGIhi4tCX7WfGFJMwjwGZIHByeYX1n2I0vBt5BGMB7nA/Bef
	IaVmOQhTAdyS0F0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rY5pD-007Jkx-KX; Thu, 08 Feb 2024 15:56:27 +0100
Date: Thu, 8 Feb 2024 15:56:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, Taras Chornyi <taras.chornyi@plvision.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: Prestera driver fail to probe twice
Message-ID: <f8c3d41c-a7ba-4ad3-af5a-6b12e4aa30e9@lunn.ch>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
 <c70a4c93-909e-4a94-8e46-d3d62aa7b487@lunn.ch>
 <20240208101005.29e8c7f3@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208101005.29e8c7f3@kmaincent-XPS-13-7390>

On Thu, Feb 08, 2024 at 10:10:05AM +0100, Köry Maincent wrote:
> Hello Andrew,
> 
> On Thu, 8 Feb 2024 00:32:43 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Tue, Feb 06, 2024 at 04:54:06PM +0100, Köry Maincent wrote:
> > > Hello,
> > > 
> > > It seems the prestera driver has never been tested as a module or in a
> > > probe defer case:  
> > 
> > Hi Köry
> > 
> > Could you hack a -EPROBE_DEFER failure? If you can show that does not
> > work, the driver is clearly broken because phylink could return that.
> 
> That is how I have noticed the issue. I was trying to test my PSE pd692x0
> driver as a module that prestera depends on (I will drop the PoE v3 soon).
> The PSE core is returning -EPROBE_DEFER in case we can not find the PSE
> provider.
> 
> Here is a boot dmesg for example:
> 
> [    1.898897] Prestera DX 0000:01:00.0: Loading mrvl/prestera/mvsw_prestera_fw-v4.1.img ...
> [    1.907155] Prestera DX 0000:01:00.0: FW version '4.1.0'
> [    5.535427] Prestera DX 0000:01:00.0: Prestera FW is ready
> [   13.458823] Prestera DX 0000:01:00.0: using random base mac address
> [   13.596594] prestera_port_sfp_bind : 403 -EPROBE_DEFER (The hack to get the PSE is in this function)
> [   13.632517] ahci f2540000.sata: supply ahci not found, using dummy regulator
> [   13.639759] ahci f2540000.sata: supply phy not found, using dummy regulator
> [   13.646846] platform f2540000.sata:sata-port@0: supply target not found, using dummy regulator
> [   13.655866] platform f2540000.sata:sata-port@1: supply target not found, using dummy regulator
> [   13.666105] ahci f2540000.sata: masking port_map 0x3 -> 0x3
> [   13.671960] ahci f2540000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform mode
> [   13.680598] ahci f2540000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
> [   13.690393] scsi host1: ahci
> [   13.693744] scsi host2: ahci
> [   13.696789] ata1: SATA max UDMA/133 mmio [mem 0xf2540000-0xf256ffff] port 0x100 irq 40 lpm-pol 0
> [   13.705640] ata2: SATA max UDMA/133 mmio [mem 0xf2540000-0xf256ffff] port 0x180 irq 40 lpm-pol 0
> [   13.787389] mvpp2 f2000000.ethernet: using 8 per-cpu buffers
> [   13.813450] mvpp2 f2000000.ethernet eth0: Using random mac address a2:00:a8:8c:7f:ca
> [   13.862023] i2c i2c-2: Added multiplexed i2c bus 3
> [   13.867101] i2c i2c-2: Added multiplexed i2c bus 4
> [   13.872104] i2c i2c-2: Added multiplexed i2c bus 5
> [   13.877181] i2c i2c-2: Added multiplexed i2c bus 6
> [   13.882034] i2c-mux-gpio i2c-mux: 4 port mux on mv64xxx_i2c adapter adapter
> [   14.030349] ata2: SATA link down (SStatus 0 SControl 300)
> [   14.195606] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   14.201982] ata1.00: ATA-9: M.2 (S42) 3TE7, S20730A, max UDMA/133
> [   14.208142] ata1.00: 53742528 sectors, multi 16: LBA48 NCQ (depth 32)
> [   14.214832] ata1.00: configured for UDMA/133
> [   14.219477] scsi 1:0:0:0: Direct-Access     ATA      M.2 (S42) 3TE7   30A  PQ: 0 ANSI: 5
> [   14.228723] sd 1:0:0:0: [sdb] 53742528 512-byte logical blocks: (27.5 GB/25.6 GiB)
> [   14.236465] sd 1:0:0:0: [sdb] Write Protect is off
> [   14.241341] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   14.250491] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
> [   14.259197]  sdb: sdb1 sdb2 sdb3 sdb4
> [   14.263962] sd 1:0:0:0: [sdb] Attached SCSI removable disk
> [   18.896377] Prestera DX 0000:01:00.0: waiting for FW loader is timed out
> [   18.903242] Prestera DX: probe of 0000:01:00.0 failed with error -110

Thanks. That clearly shows that the Prestera driver is broken.

Either there needs to be a way to determine if the firmware has been
downloaded, or the firmware download needs to be moved to the end of
the probe function once all resources are available and its no longer
possible to have an -EPROBE_DEFER.

   Andrew

