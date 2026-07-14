Return-Path: <netdev+bounces-307578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q1OSGJmUVmpF+AAAu9opvQ
	(envelope-from <netdev+bounces-307578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF369758813
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:57:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=e7S0Tu+D;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xvjOuN1v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FFD13585E48
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA844C666;
	Tue, 14 Jul 2026 19:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC344C648;
	Tue, 14 Jul 2026 19:36:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057823; cv=none; b=QmsuJ+Q+KCVCm6kOpF+9EiCLFY8jVTZA8F9ci8BUy+FEpcsutb8T74QPjq4zbrKg0s8gXpxkJdnPa6uBjwnPswIjjoLwe94K0N1OEdlz9+JnIGpM7r6VeoU4+WUxRFCebYyFKGW+NktUu0HxDuVR4NApMp33OS0Jr5lQMLIEzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057823; c=relaxed/simple;
	bh=qHaXUl200pL6nJZtzXnzHu1oFgry5MeFbAsDAc/Iang=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sSMbVLDJcYhG36oXePVjkrkXwYC7SP1r7/8jch4R5alVWJkc2zKGHYYDZFVXTc5ilz4m5SWbP/EmT7E9Z8vO+M0hkUP/7zcQ6UGuxgka2uSgQ3O4GfiSO3Td0oCC847KJ0ovPgdEJGsRo4cJ2Pp9du1S6TYCk2llyVxcZP5iIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=e7S0Tu+D; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xvjOuN1v; arc=none smtp.client-ip=80.241.56.151
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h08h95yhsz8v36;
	Tue, 14 Jul 2026 21:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784057817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Wi1q4BS9lRkpK3qWatwz/kytotQz+59Wf8+u9AiPE=;
	b=e7S0Tu+DVytj4usCrWgwVM68Xix/RP4xbXYX03+zsC3FQigbyTnQzw8qzY94nhifaX4Iuf
	eTJxwzcBYzWiReEMzVWOzbbejPqqfWUlEKH9UyDi6UlY7AOIXmjOR//HCXwNYLsB/WeZ5E
	LUY1FqhjRM4b7sEp/HgY+G3t7oe3B+z9iCdnGIkZc8SupiJuRc+xpK0dDWDpZIQ5uHAu/f
	Bi4wqQ/fsdCx1jNzzWW9rwO3KVhLi9zK6DQ81SVGDdwYoy7k6EjZxcxvBzZBV02cE+5Jdq
	ZXyTkriURJnhccpDFLAkNoNOEGTZWstGYAJ+XK3jO256RSCzojN0YdoAQmCuIQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784057815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Wi1q4BS9lRkpK3qWatwz/kytotQz+59Wf8+u9AiPE=;
	b=xvjOuN1vzLKjZ26Tmn+S2qLO3u+8OwUIfuWAayCB2SKrbAhd1wB9h6niBpWpt0p5qmeWiR
	vBkk+2rOsDleEmE2O4vyR7KZv28n97ejyHwOTDqthsf5NfADAm4cc3VoauGrf/FEhJbrQb
	iJuRoAo+jBdNFmU1JdZewC6s9eA49cae+qlTW/trKz4oJsnlNtegNHVhaL+uUVYnbCXucI
	crFz4AoN/ZQwF7uTrzBMpeVHtwJMmi5Pb7AFvhw3OK7kongiigRedeFwapJvVXHXYgol9x
	VzFwDGyI4QIl2yFfPINCRjhtQFvOYJLMaVFRGRMU4Z2lWq9fFLWF5m4T4vYhfQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:36:44 +0200
Message-Id: <DJYJPKVVNEYV.1VCK4XOL7XLXE@mailbox.org>
Cc: "Edward Cree" <ecree.xilinx@gmail.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Justin
 Tee" <justin.tee@broadcom.com>, "Paul Ely" <paul.ely@broadcom.com>, "James
 E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, "Juergen Gross" <jgross@suse.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Borislav Petkov"
 <bp@alien8.de>, "Tony Luck" <tony.luck@intel.com>, "Danilo Krummrich"
 <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-scsi@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-edac@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Replace pci_dev->broken_parity_status with
 accessors
From: "Maurice Hieronymus" <mhi@mailbox.org>
To: "Lukas Wunner" <lukas@wunner.de>, "Maurice Hieronymus" <mhi@mailbox.org>
References: <20260711-pci-dev-flags-v1-0-2fcf2811138c@mailbox.org>
 <20260711-pci-dev-flags-v1-2-2fcf2811138c@mailbox.org>
 <alOq4rsjATipBjY9@wunner.de>
In-Reply-To: <alOq4rsjATipBjY9@wunner.de>
X-MBO-RS-ID: 05fc47b8a807a8d7f87
X-MBO-RS-META: jwkwhigke4zsupccfdb75c4p5d75mnzy
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307578-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mhi@mailbox.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ecree.xilinx@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bhelgaas@google.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:bp@alien8.de,m:tony.luck@intel.com,m:dakr@kernel.org,m:rust-for-linux@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:xen-devel@lists.xenproject.org,m:linux-edac@vger.kernel.org,m:lukas@wunner.de,m:mhi@mailbox.org,m:ecreexilinx@gmail.com,m:andrew@l
 unn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,hansenpartnership.com,oracle.com,suse.com,epam.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,alien8.de,intel.com,vger.kernel.org,amd.com,lists.xenproject.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF369758813

On Sun Jul 12, 2026 at 4:55 PM CEST, Lukas Wunner wrote:
>
> For static bits in struct pci_dev, i.e. ones that are mostly read
> and almost never written, and in particular ones that are only
> written on device enumeration, it's perfectly fine and more convenient
> to keep them as bitfields.  broken_parity_status seems to fit that bill.
>
Its only writer is broken_parity_status_store(), so it is written from
sysfs at arbitrary times rather than on enumeration. But I agree the
exposure is small; apart from the sysfs attribute itself, EDAC is the
only reader.

> For other bits which are modified more frequently, move them to the exist=
ing
> priv_flags member if you believe they can be updated concurrently.
> I'm not sure is_busmaster fits that bill, it isn't updated that often.
>
The motivation is not update frequency. The planned Rust device
enabling rework [1] wants a guard object whose drop calls
pci_disable_device(), which may then run concurrently with
pci_set_master(). Moving is_busmaster out of the bitfield stops those
paths from writing to the word shared with the other bits.

> Quite honestly I'm wondering if there is anything to fix here.
> Yes I get it, userspace may interfere with adjacent bits.
> But broken_parity_status is only used for certain broken devices
> on EDAC-capable platforms.  That's a fringe use case.
> Is it really worth refactoring this?
>
I dropped this patch in v2 and moved only is_busmaster, into
priv_flags as you suggested.

> Perhaps we can deprecate the sysfs attribute in favor of using quirks
> for broken devices?
>
That sounds like the better long term fix to me, but I would leave it
to a separate discussion.

[1] https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@kerne=
l.org/

Best,

Maurice

