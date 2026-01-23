Return-Path: <netdev+bounces-252628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPw5INrqcmnQrAAAu9opvQ
	(envelope-from <netdev+bounces-252628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:28:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B1701BD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC080301E3EC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12138A294;
	Fri, 23 Jan 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mEEvkfU3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B928488F;
	Fri, 23 Jan 2026 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138893; cv=none; b=txJuKtLYBTNjJSSyzRBsHl+D194DzbycScsP88DQ0N9HQPD/9bx3brZKU1Cl5fWrcsnZiIYqutXLRvM2+f0UgdVqyOS56MKMeL+mNQ3ZZEtlGwroplnBzV0eUFvy6PIC+IpcOrL9yCy483An6PZZ0AAKn2ltqehfuS+/AOiMj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138893; c=relaxed/simple;
	bh=TF9xwVDzdSE4dVujx0IYpy0EXeCsIdFwgvfICNgQ8TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSyQbgTcG7ZYEQ6Gua1122lTyfBADYp23YwS3DqoUZpFXPNdkiSrZiyK3oAm8UW5Uani3gEs1pPucGbNAwUOT0HL6NGc4ILH20GvzJSiy6+RJIvOWV7euurgrE8Ffam2+ZypS8pV2nAOgi0JMuelJdYbZujfkiuERSOAtQiDRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mEEvkfU3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=edhtLOg1x6VOOaFWLxD4NbGr1OUxUi82yheN+qEaVtc=; b=mEEvkfU3LpfqvGui+Y41Fk+psP
	8yg5siRLrVTc++1GaGRAfSklGR2e3OasaHCzdZs2xRmBB/GGgFfj1fjOfJHWRFnyHAD/zePxPiksY
	Iy4eDnXWk7OCnwjOu+XtILlJ3O3yEx//8D5Jdt/x/lP/y+aiFDYwt7UgeR/SWDqo0rkc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vj7pi-00440V-V1; Fri, 23 Jan 2026 04:27:38 +0100
Date: Fri, 23 Jan 2026 04:27:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>, y@lunn.ch
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, hawk@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, sdf@fomichev.me, daniel@iogearbox.net,
	john.fastabend@gmail.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 01/15] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252628-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 246B1701BD
X-Rspamd-Action: no action

> +config NBL_CORE
> +    tristate "Nebula-matrix Ethernet Controller m18100 Family support"
> +    depends on 64BIT && PCI
> +    default m
> +    select PAGE_POOL
> +    help
> +      This driver supports Nebula-matrix Ethernet Controller m18100 Family of
> +      devices.  For more information about this product, go to the product
> +      description with smart NIC:

_CORE is a bit unusual for a driver. CORE is generally a library which
is shared by a number of drivers. It does not have a tristate string,
it is just selected by the drivers which need it.

> +static int nbl_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id __always_unused *id)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	dev_dbg(dev, "nbl probe ok!\n");

Please don't have pointless debug messages. If your driver does not
even probe, you should not be submitting it.

> +	return 0;
> +}
> +
> +static void nbl_remove(struct pci_dev *pdev)
> +{
> +	dev_dbg(&pdev->dev, "nbl remove OK!\n");
> +}
> +
> +#define NBL_VENDOR_ID			(0x1F0F)

    Andrew

---
pw-bot: cr

