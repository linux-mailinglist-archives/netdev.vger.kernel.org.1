Return-Path: <netdev+bounces-303680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jKHVJVQjRWqr7goAu9opvQ
	(envelope-from <netdev+bounces-303680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350E6EEB2C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:25:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TlVDab3t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303680-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC6C4306F7D5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE92737F8;
	Wed,  1 Jul 2026 13:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D22BE02A;
	Wed,  1 Jul 2026 13:57:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914245; cv=none; b=HImCWvDR/UI6E7WwyaAQhc28ena6h8DiIZIWUsCQceB6v+w0a8tw+XCoVYKR6joBL8j7K7+ACyw3NGEs24weTKy8EnP5XMn6bs+A4dUgVkCVJYsCPZa0poqntbX9m9tYEYuVs4+SpWA/DaoVx5+r55XgCEOx0dzWhorudAEwvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914245; c=relaxed/simple;
	bh=jyouimgOHe00t9Rj8kGA3cHbwAbO2s+J+L9yOVT9ZI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DjfuSbSTfbs6D1CF17xEZFkHmAh2nudsjmbnWnYNo2Luyn2xLVjrRb+xcte/5/pneI6gvenHHBZsIzhw9iDIGueyTfapv7+qQTJM0tn94XZgDedR6tI2aoFYaEZtW9szNnHwf45AYJ+Ww1PLEzvML0pzKSYPts7pccB7u31Hufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlVDab3t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF371F00A3D;
	Wed,  1 Jul 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914244;
	bh=zag35WAocY+5o+OvST/25DSXMEyjKxN2j2GDhfTpF5s=;
	h=From:Subject:Date:To:Cc;
	b=TlVDab3taKef0cAHAYzvZWbe8q1YtiZZL2iPNyoLbK/g1DgwhDk/Gg9XGmwG9yKBF
	 PnWzy//tKPnrrbIuL4frm/k3LfXeFGF2iCiZ2yEZWg2OFMYpIXXwpiqEGDdeYqHh12
	 FxuPhn3YvDMqXdAYksh7EzEe29c/SLkcjH6s6U2CkKGL02I4pNZDh36BF+vzSNse+L
	 4L4BLyrOyvTeZB/fzHFqta9oFP7ZoXHXgsn7JsvszUlmHn9T2thGwzYpuKnFPY6iZ4
	 /hQnQLexd22jTT31Sc43CUIAg/Usjb6WzwhcixRdNrLp6OWItHPtroKWH161IHgwTI
	 elkTYlpzGTUfw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/4] drivers/net/ethernet: replace __get_free_pages() with
 kmalloc()
Date: Wed, 01 Jul 2026 16:57:17 +0300
Message-Id: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0cRWoC/yXMwQ6CMBAE0F8he3aTgkLQXzEeumW09VDNLhATw
 r/b6vFNZmYjgyYYXZqNFGuy9MoF7aGhEH1+gNNUTJ3rBjccHcuJJ00r1BhzhGbMLD3c2Mt59NJ
 SWb4V9/T5vV5vf9siT4S5XtWGeAOL+hxijSpp37/MWFb8jgAAAA==
X-Change-ID: 20260630-b4-drivers-ethernet-b5e085b98ab1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Mike Rapoport <rppt@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-net-drivers@amd.com, netdev@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:manishc@marvell.com,m:pabeni@redhat.com,m:ecree.xilinx@gmail.com,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:rppt@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rppt@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,marvell.com,kernel.org,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9350E6EEB2C

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/drivers-net-ethernet

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
v2 changes:
- split out ethernet drivers from a larger set 

v1: https://patch.msgid.link/20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org

---
Mike Rapoport (Microsoft) (4):
      bnx2x: use kzalloc() to allocate mac filtering list
      ice: use kzalloc() to allocate staging buffer for reading from GNSS
      sfc/siena: use kmalloc() to allocate logging buffer
      sfc: use kmalloc() to allocate logging buffer

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_gnss.c      | 5 +++--
 drivers/net/ethernet/sfc/mcdi.c                | 7 ++++---
 drivers/net/ethernet/sfc/siena/mcdi.c          | 7 ++++---
 4 files changed, 14 insertions(+), 11 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260630-b4-drivers-ethernet-b5e085b98ab1

Best regards,
--  
Sincerely yours,
Mike.


