Return-Path: <netdev+bounces-307658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id il3AD6cSV2q3FAEAu9opvQ
	(envelope-from <netdev+bounces-307658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42975A92F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307658-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0FC53011392
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1143B4417;
	Wed, 15 Jul 2026 04:54:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63383B42D7;
	Wed, 15 Jul 2026 04:54:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784091292; cv=none; b=AWMebL7aCqbRs5yCgYkj9PTsvBtveynZqZvTO9xMHPGcRZW/jsXmcOf1DdM1E8kdT16XfPwnVxqiX14t40aTlzNQbIPeLgn7CiZlpLfSVB9ZZ1jDrF5BeMcYDsUw608yADzp53gUg7R8AZUFmmGeo6qVvdYpYpALo8HqN+DWdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784091292; c=relaxed/simple;
	bh=YG/BH0rGq979Z5uTrx4zYXUgFUmbKsGaN6XPzFKM8Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNKgf46hCIAH5wLQe7HkBPRIGlx6C8qlz4iSivawmxwg8xPfVXLseOD9b/iUrSqzwpcp0FTQphTYCi96NMZ/6RExHE5qSO7lRyIoK1M84ZxTUUlzkwOc5GEI+jCh6r6acxWLwdBT1dhQdxFofPp0Es6RUjIEwpv/pXYM+81i+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id B5F3510630;
	Wed, 15 Jul 2026 06:54:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 960BB603411E; Wed, 15 Jul 2026 06:54:38 +0200 (CEST)
Date: Wed, 15 Jul 2026 06:54:38 +0200
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
Subject: Re: [PATCH v2] PCI: Move pci_dev->is_busmaster into priv_flags
Message-ID: <alcSjoypegNolW48@wunner.de>
References: <20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307658-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:from_mime,wunner.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F42975A92F

On Tue, Jul 14, 2026 at 09:37:07PM +0200, Maurice Hieronymus wrote:
> +++ b/include/linux/pci.h
> @@ -1446,6 +1445,8 @@ void pci_disable_device(struct pci_dev *dev);
>  extern unsigned int pcibios_max_latency;
>  void pci_set_master(struct pci_dev *dev);
>  void pci_clear_master(struct pci_dev *dev);
> +bool pci_dev_is_busmaster(const struct pci_dev *pdev);
> +void pci_dev_assign_busmaster(struct pci_dev *pdev, bool busmaster);

pci_dev_assign_busmaster() should not have public visibility.
Drivers should really use pci_set_master() / pci_clear_master()
and nothing else.

It seems Xen is the only one in the tree which needs this:

> +++ b/drivers/xen/xen-pciback/pciback_ops.c
> @@ -125,14 +125,14 @@ void xen_pcibk_reset_device(struct pci_dev *dev)
>  		if (pci_is_enabled(dev))
>  			pci_disable_device(dev);
>  
> -		dev->is_busmaster = 0;
> +		pci_dev_assign_busmaster(dev, false);
>  	} else {
>  		pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  		if (cmd & (PCI_COMMAND_INVALIDATE)) {
>  			cmd &= ~(PCI_COMMAND_INVALIDATE);
>  			pci_write_config_word(dev, PCI_COMMAND, cmd);
>  
> -			dev->is_busmaster = 0;
> +			pci_dev_assign_busmaster(dev, false);
>  		}
>  	}
>  }

Please change these direct assignments to pci_clear_master(),
preferably in a separate patch to ease bisecting if anything
breaks.

Then you don't need pci_dev_assign_busmaster() and can just inline
setting/clearing the bit in __pci_set_master() and pci_disable_device().

Thanks,

Lukas

