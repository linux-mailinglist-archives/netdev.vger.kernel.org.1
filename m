Return-Path: <netdev+bounces-306956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MLPtHvOqU2rKdAMAu9opvQ
	(envelope-from <netdev+bounces-306956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97D7450A5
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306956-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306956-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E86873005AAA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C28281530;
	Sun, 12 Jul 2026 14:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136B2765E2;
	Sun, 12 Jul 2026 14:55:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868135; cv=none; b=icacOHf2BiISObACpuC2gNf+XOyeAXM5BEnUqGPjL5XX/c7dzRowpDdk5VbtYXy+5SfL5pqpLtvdAcoMjUQV+kW/wPntCVXLx4htwK+4zDtSmNW+l4dBHWdWrXWxId9ZNJiCHc7DBFEs7Stp1kERwtH60wTw9A3Y7JzceFoNg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868135; c=relaxed/simple;
	bh=L4a64Aplo3e+24CSASMZO4O607mX9iJGrnuUkdNt5Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLYK2zPWiPWGleC0ZICYUVy5Kn3Sxehg18uI3g5PWPsrjr1pw5cuuk4xK+WcaRKFqTBnVW9ygqoB+0tNQ1y8jYoeMxRxEqnit+MdiCDP7T5qv2kenq6QlxCyiqIc1H97eC1NvsW9IQfVhQDrIt3mPIm5ZA7ZNZBrD8jMj+98oH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 26AD310632;
	Sun, 12 Jul 2026 16:55:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 032786022F08; Sun, 12 Jul 2026 16:55:30 +0200 (CEST)
Date: Sun, 12 Jul 2026 16:55:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Replace pci_dev->broken_parity_status with
 accessors
Message-ID: <alOq4rsjATipBjY9@wunner.de>
References: <20260711-pci-dev-flags-v1-0-2fcf2811138c@mailbox.org>
 <20260711-pci-dev-flags-v1-2-2fcf2811138c@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711-pci-dev-flags-v1-2-2fcf2811138c@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306956-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:ecree.xilinx@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bhelgaas@google.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:bp@alien8.de,m:tony.luck@intel.com,m:dakr@kernel.org,m:rust-for-linux@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:xen-devel@lists.xenproject.org,m:linux-edac@vger.kernel.org,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfd
 r.de];
	FORGED_SENDER(0.00)[lukas@wunner.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,hansenpartnership.com,oracle.com,suse.com,epam.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,alien8.de,intel.com,vger.kernel.org,amd.com,lists.xenproject.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E97D7450A5

On Sat, Jul 11, 2026 at 05:21:07PM +0200, Maurice Hieronymus wrote:
> `broken_parity_status` shares a C bitfield word in `struct pci_dev`
> with many other bits. `broken_parity_status_store()` writes it from
> sysfs at any time without taking any lock, so userspace can make it
> race with every other writer of the same word, e.g. `pci_set_master()`
> from a runtime PM resume path, and updates of neighboring bits can be
> lost.

For static bits in struct pci_dev, i.e. ones that are mostly read
and almost never written, and in particular ones that are only
written on device enumeration, it's perfectly fine and more convenient
to keep them as bitfields.  broken_parity_status seems to fit that bill.

For other bits which are modified more frequently, move them to the existing
priv_flags member if you believe they can be updated concurrently.
I'm not sure is_busmaster fits that bill, it isn't updated that often.

Quite honestly I'm wondering if there is anything to fix here.
Yes I get it, userspace may interfere with adjacent bits.
But broken_parity_status is only used for certain broken devices
on EDAC-capable platforms.  That's a fringe use case.
Is it really worth refactoring this?

Perhaps a better approach is to enclose dev_attr_broken_parity_status.attr
in "#ifdef CONFIG_EDAC" so that the attribute isn't shown unless it's used.

We shouldn't have used a sysfs attribute for this in the first place
but rather a quirk.  Unfortunately 6b09ff9d7879 does not betray for which
device this was needed, so it's difficult to convert it to a quirk now.

Bjorn introduced a pci_disable_parity() API in 2021 which is used in a
quirk for certain Mellanox products:

https://lore.kernel.org/all/20210330174318.1289680-1-helgaas@kernel.org/

Perhaps we can deprecate the sysfs attribute in favor of using quirks
for broken devices?

Thanks,

Lukas

