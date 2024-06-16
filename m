Return-Path: <netdev+bounces-103871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A546F909E7A
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135ECB20D38
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74F175BF;
	Sun, 16 Jun 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ReT+8a6L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7CB12E47;
	Sun, 16 Jun 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554783; cv=none; b=kUzNCnddSzSGxXBKnerXWCJIWVBRrmWBZ2z+bfSBngS/tyD5cQpaeo87IZRxikhVl0H9YacbksIMiVkZQEgWLEs+a02PriSR12hgPy2l4+U9SRWhDmiyokBUmtpLq0nBdBh9c0Xk606LISnq/ljvDiEZIQVwDKs06RTHjYead+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554783; c=relaxed/simple;
	bh=qR+9FEx9x0bJ3F5nqrI0gOfNAfsFaGmwjugmSOv/3oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwkehIq1SNPqkPfsbx/tUza5RkYk6REaWll/MNzQ1C4Pm0ybOwv6eZwv+YU5p2w6Bl4T3FhMPt/HJoGBkQjzVylwBSlP+gXBuc4Di6KH8hA7EtKg9LgQDTcI725paY0qt2QWKwX+6lV0KOgp7v/I1FbOs26IN3l2DJyQ5RRCEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ReT+8a6L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GVCvajlkzGyB22Se2ZOzmrs2oP4nXY5Ynx4z1DMOBb0=; b=ReT+8a6LUzQeJGHrfBShmparlj
	ub5DAmAfIxHXxTxSWn8wbRVzRO8h4bzrhyR4k47VFslXAF/WhnpOXoxQdv4QauE98YPboWjfImQ0z
	GPADWAoFALpXtfrpwsFONrCWJhxbhGfwHoidwmdic3JNQ1z9ihGwylSP0a2T5qyoHe9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIsb8-000Bu1-So; Sun, 16 Jun 2024 18:19:18 +0200
Date: Sun, 16 Jun 2024 18:19:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <efff16aa-33d9-45eb-ac42-86f3411abfc9@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
 <f14a554c-555f-4830-8be5-13988ddbf0ba@lunn.ch>
 <b07cfdfe-dce4-484b-b8a8-9d0e49985c60@ti.com>
 <8b4dc94a-0d59-499f-8f28-d503e91f2b27@lunn.ch>
 <60bc57a7-732b-4dcb-ae72-158639a635c0@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bc57a7-732b-4dcb-ae72-158639a635c0@ti.com>

> The Linux Remoteproc driver which initializes remote processor cores carves out
> a section from DDR memory as reserved memory for each remote processor on the
> SOC. This memory region has been reserved in the Linux device tree file as
> reserved-memory. Out of this reserved memory for R5 core some memory is
> reserved for shared memory.

I don't know much about rpmsg, so i read the documentation:

https://docs.kernel.org/staging/rpmsg.html

There is no mention of carving out a region of DDR memory. It says
nothing about memory reserved in DT.

The API is pretty much: Please send these bytes to the peer. Call this
callback when bytes have been received from a peer.

> The shared memory is divided into two distinct regions:
> one for the A53 -> R5 data path (Tx buffer for Linux), and other for R5 -> A53
> data path (Rx buffer for Linux).

As i said in my previous message. Forget about the A54->R5. Think
about a generic architecture. You have an RPMSG facility using the API
described in the documentation. You have a block of shared
memory. That memory could be VRAM, it could be a dual port SRAM, a PCI
BAR region, or some DDR which both CPU have mapped into their address
space. Design a protocol around that. This might mean you need to
modify your firmware. It might mean you need to throw away your
firmware and start again. But for mainline, we want something generic
which any vendor can use with a wide range of hardware, with as few
assumptions as possible.

	Andrew

