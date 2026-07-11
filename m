Return-Path: <netdev+bounces-306874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XYPBLclfUmr3OwMAu9opvQ
	(envelope-from <netdev+bounces-306874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:22:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947C741F4E
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:22:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=eMVI1NjN;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=c8kmqXI9;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306874-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306874-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C543012D26
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF62E8DEA;
	Sat, 11 Jul 2026 15:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0E2E11C7;
	Sat, 11 Jul 2026 15:21:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783297; cv=none; b=I5Q9V4epUKqIUKIbykZ77dYgokd3VBTc1hzzYMY4bydkdm6dKMPJx6huBLkBkAsQh3og2+a/U+zfgQjQuaUmnajUGSBmk5yFREP9eZwqLi/tJuKM2vE2cy840a0wStg5/Bn8XUH+wACmj489y2wuYwgK5iZYTbzwmNieWTgT+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783297; c=relaxed/simple;
	bh=o9XAWD66ai+0Z3WcwldrjMlSlthY+1Kqo3Oox8uMmS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AJHdVP17ECKnJEoLbT3u1yrqD2LndnPFjm6RkOqwmhbEQ85XaoWwapu5TwohHyImy/WrzzaK8deK/mumPkjORqv2pprAeNr0W+CR6S1x1XzzZSEnubC3hHUeu0TCZtv5m7vo/O8ugdA3YLZ3eUa6Hk70QQSYLSUgIooNriFpJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eMVI1NjN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c8kmqXI9; arc=none smtp.client-ip=80.241.56.152
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gyC8j6jmRzKvvr;
	Sat, 11 Jul 2026 17:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783783285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kH44882xOwsD4SfCnl+qgk2oMqAUi2EehaDoPIzn3X4=;
	b=eMVI1NjNntkXUIL2KOm2VZts3RhfTzWVqESVgkEg1PEU0iNNOTLEy4oPU1sGltwuvADktu
	29XhMgFGgB99GHjLXkAn5ozkGwVXTnUWBBmNLahKBuKQI8RFu1nsjv2tvFKSfvmDAtyj1O
	lXeTa0MTvdh9lMX7wH0Z4HrZUVewtjTxlWk4QbVwtZ4evIKBzLeSF4SmncAmhlmzTH6lfO
	ksEtFi2KZ9Zd1uON+d5igIc2yOUDcSKi98kj00W2rAeb7w1IRkWpYlhnb4PTXyjwtXe5ay
	DtFsbogadRXZ3ZyFWqIHkaejjrBvgV4yEaPRdkLhep6OOvyMJ6Ju9mGHWYSjgw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783783283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kH44882xOwsD4SfCnl+qgk2oMqAUi2EehaDoPIzn3X4=;
	b=c8kmqXI9fAQXUpbVt8GLOdc11hNZaJUQQYsS5cxln0FyNygQRxXRLlPlY4A/0KF/KVlnyq
	89csec1W7y0LP0NuHF8OvgxGL8QwqVDg/yqjlR/tZT0U7N22e4zfIfz1jks9M3hooLWyED
	CDY1JGEot2RA0xGQ/m+LTSdmCoWb3snkaAPehAWthZ4c9C+ImtG2A76FPCgJ1/TbH/2vmO
	HwgjxsoeMhnxjxIUpu6BvcCkHiqsrmwmJoz/XnGg32ShT1AplRvrYoSH27jRz6L7EeMPnf
	xNMJZmtF3EhCBlrp2XnEluRXkziEHFi6I+wVebbtpQX2hdjgVnKSjqP8z4pXDQ==
Subject: [PATCH 0/2] PCI: Convert bitfield flags to atomic accessors
Date: Sat, 11 Jul 2026 17:21:05 +0200
Message-Id: <20260711-pci-dev-flags-v1-0-2fcf2811138c@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0auEWTuQ2KK0VykuTDKjIyWVjEpBc
 vem7fIt/j9BKQsp3M0JmQ5ReaUK1xgI85gmQonV0Nq2s71zuAbBSAfyc5wU2fvAV+abvTiozZq
 J5f37PYa/dfcLhe07gVI+47rh/HEAAAA=
X-Change-ID: 20260711-pci-dev-flags-fbbcf4ff9031
To: Edward Cree <ecree.xilinx@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Justin Tee <justin.tee@broadcom.com>, 
 Paul Ely <paul.ely@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
 netdev@vger.kernel.org, linux-net-drivers@amd.com, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-edac@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783783272; l=2313;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=o9XAWD66ai+0Z3WcwldrjMlSlthY+1Kqo3Oox8uMmS0=;
 b=4RJCYIsxz6UvLYOQ6xqvhVEQoQSh4rZQVVIc7mWtjntBUq4ccNJ2KYKolDjFHU49aAutOyaus
 A5Eqo668VqlDuoF/ENWHgCu8gHFoRAMIBVG+FaowFqe6tBmqjHocs5w
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 7fb4275b43160de9afd
X-MBO-RS-META: o4fyj9cuc9w1urffc3xfrywcrt7anabk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ecree.xilinx@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bhelgaas@google.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:bp@alien8.de,m:tony.luck@intel.com,m:dakr@kernel.org,m:rust-for-linux@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:xen-devel@lists.xenproject.org,m:linux-edac@vger.kernel.org,m:mhi@mailbox.org,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfd
 r.de];
	TAGGED_FROM(0.00)[bounces-306874-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,HansenPartnership.com,oracle.com,suse.com,epam.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,alien8.de,intel.com];
	FORGED_SENDER(0.00)[mhi@mailbox.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5947C741F4E

`struct pci_dev` keeps ~60 flags in one C bitfield. Bits sharing a
word must not be modified concurrently, but several writers take no
common lock: `pci_set_master()` writes `is_busmaster` and can run
without the device lock (e.g. runtime PM resume paths),
`pci_disable_device()` clears it, and `broken_parity_status_store()`
writes the same word from sysfs at any time without any lock.

Convert these two bits to a new public `flags` bitmap accessed with
atomic bitops, mirroring how the driver core replaced its
`offline`/`offline_disabled` bitfield in commit a7cc262a1135 ("driver
core: Replace dev->offline + ->offline_disabled with accessors").
More bits can follow the same pattern later.

An alternative would be to reuse `priv_flags`, but its bit definitions
and accessors are deliberately private to drivers/pci, while
`is_busmaster` is accessed by xen-pciback, lpfc and sfc. Happy to
respin that way if preferred.

This is also a prerequisite for the Rust device enabling API rework
[1]: the guard object planned there calls `pci_disable_device()` from
contexts that may run concurrently with `pci_set_master()`, which
requires `is_busmaster` to not be part of a shared bitfield word.

Link: https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org/ [1]
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Maurice Hieronymus (2):
      PCI: Replace pci_dev->is_busmaster with accessors
      PCI: Replace pci_dev->broken_parity_status with accessors

 drivers/edac/edac_pci_sysfs.c               |  4 +--
 drivers/net/ethernet/sfc/falcon/farch.c     |  2 +-
 drivers/net/ethernet/sfc/siena/farch.c      |  2 +-
 drivers/pci/pci-driver.c                    |  2 +-
 drivers/pci/pci-sysfs.c                     |  4 +--
 drivers/pci/pci.c                           |  6 ++---
 drivers/scsi/lpfc/lpfc_init.c               |  4 +--
 drivers/xen/xen-pciback/conf_space_header.c |  4 +--
 drivers/xen/xen-pciback/pciback_ops.c       |  4 +--
 include/linux/pci.h                         | 42 +++++++++++++++++++++++++++--
 10 files changed, 56 insertions(+), 18 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260711-pci-dev-flags-fbbcf4ff9031

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


