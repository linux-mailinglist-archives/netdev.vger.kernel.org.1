Return-Path: <netdev+bounces-103885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558C909F75
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 21:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED542831CA
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0D481DB;
	Sun, 16 Jun 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xFD/sfvV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D3405F8;
	Sun, 16 Jun 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718564654; cv=none; b=YqQtbR98t9bO2lwp33Bv4mD7y6PK0kfCCNSOrF/GiuRk5oGk+x9Qgba+OHVe6RFt29bUFQthiQ0EiIb2ImjSsSU+Vy5aY33C/MvsUCTVeFspsxA4nmuIogTgILic4Yi9J3VXNwrHNE0KnORKz6jqXgpzJPRA6f5JjrvtRNEaOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718564654; c=relaxed/simple;
	bh=ExtjE4s06fx8QImyhfSC+fvw4uzLe/3aFBnAyqALAvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gowA+XzNcE4MOlU8vo9VUP/Vxa/+bvC/Ym0VkpMwwJxRWFMK8cfwWj+K8MI5Diwkhzvkz8UNHHYGt8zpMK8/Ncc3/pde89ma5L7sZNvnrL1FBqAhO47e2zPa1ZGaptXSz/MYYqOI5ViLB06pC87s93VXH7OgiqeYabLBq7KMrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xFD/sfvV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xfz0trPehPu0lxxZ+A55z1auT/PTnlsf3zMBmOrD6tw=; b=xFD/sfvVPw3FDAuzyU/sTQcdCi
	9DPN24fzn6eofQI81fPN+aeE6uU6afZPzuwe8dpA2Ot/fY1gKvvHgN6LvongJ5f1Ef29qnUh/kf2C
	3ApX3SJ59+5uqmqQc1rftPYFvLl2PFIyZj5OAx7zoYt6M2oBIvEOqxCAuoJ6BkyPY/34=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIvAC-000CGh-V2; Sun, 16 Jun 2024 21:03:40 +0200
Date: Sun, 16 Jun 2024 21:03:40 +0200
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
Message-ID: <8781578d-7323-43c2-ad75-35bed142916f@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
 <f14a554c-555f-4830-8be5-13988ddbf0ba@lunn.ch>
 <b07cfdfe-dce4-484b-b8a8-9d0e49985c60@ti.com>
 <8b4dc94a-0d59-499f-8f28-d503e91f2b27@lunn.ch>
 <60bc57a7-732b-4dcb-ae72-158639a635c0@ti.com>
 <efff16aa-33d9-45eb-ac42-86f3411abfc9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efff16aa-33d9-45eb-ac42-86f3411abfc9@lunn.ch>

> As i said in my previous message. Forget about the A54->R5. Think
> about a generic architecture. You have an RPMSG facility using the API
> described in the documentation. You have a block of shared
> memory. That memory could be VRAM, it could be a dual port SRAM, a PCI
> BAR region, or some DDR which both CPU have mapped into their address
> space. Design a protocol around that. This might mean you need to
> modify your firmware. It might mean you need to throw away your
> firmware and start again. But for mainline, we want something generic
> which any vendor can use with a wide range of hardware, with as few
> assumptions as possible.

Just adding to my own email. You might want to split the overall
problem into two. It could be, you have 95% of the code in a generic
driver framework. You instantiate it by calling something like:

void *cookie rpmsg_ethernet_shared_mem_create(struct rpmsg_endpoint *ept,
					      void __iomem *shared_memory,
					      size_t size);

The cookie is then used with

int rpmsg_ethernet_cb(cookie, void *data, int len);

which gets called from the rpmsg .callback function.

You then have a vendor specific part which is responsible for creating
the rpmsg endpoint, finding the shared memory, and mapping it into the
address space ready for use.

All data structures inside the shared memory need to be position
independent, since there is no guaranteed the CPUs have it mapped to
the same address, or even have the same size addresses. The easy way
to do that is specify everything as offsets to the base of the memory,
making it easy to validate the offset is actually within the shared
memory.

As i said, i've not used rpmsg, so this might in practice need to be
different. But the basic idea should be O.K, a vendor specific chunk
of code to do the basic setup, and then hand over the memory and RPMSG
endpoint to generic code which does all the real work.

	 Andrew

