Return-Path: <netdev+bounces-259717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBhEFFZjmGmJHgMAu9opvQ
	(envelope-from <netdev+bounces-259717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E0167DB0
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563603006B6A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C4344020;
	Fri, 20 Feb 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="27qFReLU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1115313281;
	Fri, 20 Feb 2026 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594580; cv=none; b=TadRiC+jNSNlbpq41BnlgJyRxewt7ERLdrhE1/ApLdfKVnRW7YWkLDA6+T+6kx3GkUMtVMCsOtsrIG4dL3lrkcbmHnI9TerPvQhpY2V7rBgZl/sxpoEiMA5T4t2cmSwOntgLINz1EkiFA8YF1HCE3B/YUX89pDlsuUDJqK3mTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594580; c=relaxed/simple;
	bh=UZqugDl9YAuEn3qPaV7KYY7wKE1Ep4P6qhkliHaP7Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ4K5T02LznLy1xqNw2e6uQpirNs/AtYCniZSzcwkLl3Ny2RPZn5D+iozYq5YsOLlyCW0X5rEfIbpXv+Aazb5AOWtSg+PTmT1HSZwrFx71LWnvoJ89nqNZbHAfN9iPp32GeRZqFYKRtu9HzmsSlCk8adKbcqeTjX8yduAhp+CsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=27qFReLU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xqKLoTg7Ju7x5pvSrVHpqnVQjdZWB/YWkrxf0VRywQE=; b=27qFReLU4ywzybhAqrHkRUEWtG
	zRKYmiqL6KlaPTvAe/qOAxxPUFOIClouJS5DHoZ5X2Poc/DH9+ClxYhIyXHux/Z8344fKkGvks9G7
	jtyiYLCPz1zWnCGQUAgrShqkwIWhWuvMDWpghD1VGwXli/ztD5KcJoU0NKSWp7g9PxWs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtQfx-0084ZL-7o; Fri, 20 Feb 2026 14:36:09 +0100
Date: Fri, 20 Feb 2026 14:36:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC
 driver support
Message-ID: <28b232f1-5814-4b3a-af28-1eab023743c0@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch>
 <SN7PR12MB81478FB396CDD9929618C2D69368A@SN7PR12MB8147.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81478FB396CDD9929618C2D69368A@SN7PR12MB8147.namprd12.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: E58E0167DB0
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 12:59:16PM +0000, Neeli, Srinivas wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

Sorry, i'm not part of AMD...

> > So how does the host send a frame out Port 2? Is there an extra header
> > on the frame sent by EndPoint, which the switch interprets?
> >
> 

> In this RFC, I configured all switch ports in forward mode. As a
> result, when a frame is sent from the internal endpoint, it is
> flooded to both external ports.  To forward packets to a specific
> port instead of flooding, either static switch CAM entries need to
> be configured or address learning should be enabled so the switch
> can learn CAM entries dynamically.

Despite not being part of AMD, this part is important.

I don't care about how the RFC works, i want to know how the hardware
works, to ensure you have the correct choice of DSA vs pure switchdev.

Take the example of running Spanning Tree Protocol. The bridge needs
to send the BPDU out a specific port. What mechanism is used to do
that? It also needs to know which port a BPDU ingressed.

	Andrew

