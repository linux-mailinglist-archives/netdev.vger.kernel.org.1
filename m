Return-Path: <netdev+bounces-249020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F84D12C96
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31765303435C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52306358D3C;
	Mon, 12 Jan 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qpn3gOt5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D52222C4;
	Mon, 12 Jan 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224324; cv=none; b=orVoxeyo+0tF+7WCphaHTgcZvJjlXtbF3MdiY1/QeRfvZyGpOvtk8C36aj3mScQO764DjHG3p8nngkINt7/CR0rvtzJ8q7SY0cVrJJnbfCMjrs6IOSXazNZbzTqDGd3gZWwa//PoedevJ+3ze1RhwsyDO+wgBh4bTg+Z2dD9kRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224324; c=relaxed/simple;
	bh=ZtIEImTdbFc51Ru7QpmEbr/ImRDQRUOshNIVRQzsSoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcV0yOF9u1Ix1K/NBbsSKPDLuVA+gEu01hUJoV61H7FJl5J9ehygopsNUwAAKQ3H5Nq1YsupEODOFTdYSgihN9foYuHoslrlf9mjD80S/O+qKU4hzvBvKPKrMEjhMKM+Ig4fgOrMPuwCstCtcnEC0vL1pGigh3zE2Mk5T8Re7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qpn3gOt5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iHbP176mpgAGq9kCi92VZjk+dqr0heKyjL7PyZirZAU=; b=Qpn3gOt5j18vViglQafGzGgs7Z
	aGqRBHTEbpMRnopGmke0ysw231OEgJmD+vg9xfpc0ycQ0Lt1ybVN33dI5rPguR8HkSCbSPgSDqr2u
	nAW7TKLGpuTHekdPm53Fjs4hafIeYNNY2r8qRd5reJvitrHsAdMHLJHa5W6PS5RjbyJg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfHui-002Tf4-4v; Mon, 12 Jan 2026 14:24:56 +0100
Date: Mon, 12 Jan 2026 14:24:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sven Schnelle <svens@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
Message-ID: <7be41f07-50ab-4363-8a53-dcdda63b9147@lunn.ch>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yt9decnv6qpc.fsf@linux.ibm.com>
 <6a32849d-6c7b-4745-b7f0-762f1b541f3d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a32849d-6c7b-4745-b7f0-762f1b541f3d@linux.dev>

> > drivers/ptp/core    - API as written above
> > drivers/ptp/virtual - all PtP drivers somehow emulating a PtP clock
> >                        (like the ptp_s390 driver)
> > drivers/ptp/net     - all NIC related drivers.
> > 
> 
> 
> Well, drivers/ptp/virtual is not really good, because some drivers are
> for physical devices exporting PTP interface, but without NIC.

If the lack of a NIC is the differentiating property:

> > drivers/ptp/net     - all NIC related drivers.
> > drivers/ptp/netless - all related drivers which are not associated to a NIC.

Or

> > drivers/ptp/emulating - all drivers emulating a PtP clock

	Andrew

