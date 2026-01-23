Return-Path: <netdev+bounces-252833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGN6E9dnc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:21:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3675B00
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0FC304B9D1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736C284690;
	Fri, 23 Jan 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gpgMuBR7"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF4271A7C;
	Fri, 23 Jan 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170697; cv=none; b=tjE2zVrdyavIH/POFy4Mtg7bKWXhNE0qYpjmhCghmNam0vQSBrlR0UvmQWBbKkmcesLr6/yx/HvFfGIN+n1v9C7iOb55QkK0jcaeMd16RCHRMTCdcRJAHBdr9OqlJsRtexz9lfqbEc/ae2ahMifVBQlMVEWdtKGMcXNQnihh/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170697; c=relaxed/simple;
	bh=NwG4XWWbn+0SmXP2RTHOokEcmBGXa0v4k/BxSO4w0k0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rwbhu9VjCsB7eTmo20zXAETd7CM++3ktWAZqBKdjqZIWII08znUDHy88d4M38la3fRLVUbdaWB37yps5x3/o5ONhuQUrrPNfHbjHAvTl6wDrdiklQfvhcdPiR0KKdB0jCZ3P5j5Q55YYzMjADbx0i2ui/3SU1+G7VFMyRvV1hO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gpgMuBR7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JbRpQgVc93hQybzo7oJZntq+XjrHJupBpkHu/kwPsrc=; b=gpgMuBR7IhVdU3LpdNn+bkwRys
	6Yh93H9e12y8OPiyMz3iz1Ritd7171+NmOjxjyI0HMbmS7Q8BLIRkHuBEI+3bGFIYAUsM0pbWa4ZQ
	+lZH9Yk9PPIC0uOl6Q2/BSRQTH51YmmgrGbYzrBqTnjW3uChkiMi7UPdHoAIhLSBtib4GYkrkircc
	TccT0HEMYhjVuO9mJfP/kDXKm3Wp/RBK+zfyC4K9IF5lX3US0QB8HV9htIyapzJkemiPEzERlTKwj
	Z6Lg0/g8hqL231Ov94cjYEH475rhebLB8mhhS7OdvjdA52DVto7CgGdv7vK7migmplQhk4M8VxntT
	FqAvB3GQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vjG6p-00DpeC-OJ; Fri, 23 Jan 2026 12:17:52 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/5] net: netconsole: convert to NBCON console
 infrastructure
Date: Fri, 23 Jan 2026 04:17:23 -0800
Message-Id: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRmc2kC/2XNyw6CMBCF4VdpZs2Y6XApsPI9jIsCU+2mmEIIh
 vDuJo0YjeuT7z8bTBK9TNCqDaIsfvJjgFYVmYL+bsNN0A/QKmDiUmttMHT9GNBxURjT28blApm
 CRxTn19S5QJAZg6wzXDMFdz/NY3ymg0WnPbWY+d1aNBJWZVfkPTW1ofo8SOdtOI3xlhILH6wiz
 XQwRsKu0q6pqKyN/Wf5N/u85UhoDbNjR4Oz5Q/b9/0FwIAtXBMBAAA=
X-Change-ID: 20251117-nbcon-f24477ca9f3e
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819; i=leitao@debian.org;
 h=from:subject:message-id; bh=NwG4XWWbn+0SmXP2RTHOokEcmBGXa0v4k/BxSO4w0k0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpc2bph5TJtyEcKzmdVYS6X81b422u1VxEgIJWR
 Bmq0/KAuNGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXNm6QAKCRA1o5Of/Hh3
 bYxZEACKSH22TOMqaOSX74W0sQ2Q4NHix+6B68btLHx6Lvtxf3ia3+7SR9rbgjyJd7SbpUgseBR
 r1q0qTaw0+X77MwuxO76cj8o/QnF2ljTj7w3oUgLOtskAfOYIhL03rR+Rvpxx5F0UwF7BAgRcc7
 k090JWSrXQojFjCBswL1YBfKTu6i0/saGPb7LGqgIc2B7DJixqTJKOj4QPwg3KC/eQ3iUVOEZVx
 u1NKL2BlANo2tUXFdVgm/RqNk0ZXip+STmMW3XlTXedot+3nw6twScscJMTEUJ90uh6EVXMgXZB
 Q9HedxCoZxPztPRjxKyJj38vgCZmgrR4Ri4Wl1FIzZwupL7TXis33SlSXOG+MbDqxJX0gAyWETz
 rIQIYP07X3XTgQEQDyxr8P9BaVvoFFC8r6gApk11oqOjHxX027GRQu8lhM54se67SRCrT6HJgL7
 kYxiKW+Lx+UhHKJoxUPK/tfCHyG4mg6sS0oywSAT5C8w9A0jPfwhu/sdqqMPkX5skOIoIMV38v3
 Q3uKsExMMCBwCLz+aWBrvUErHTdOvxKBorf4p9SYW5L9600I0YURgzCyEdTeeOcrTHXCcSgYFqq
 UgKuSuJ6sJWWCv+Xd4trqdARnLyWyj/PUH/eGejhOzayg6EauCgTdGpwrol8n9LC7aWLiJY8DoO
 bbi7ouPJfzb3C3Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252833-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9A3675B00
X-Rspamd-Action: no action

This series adds support for the nbcon (new buffer console) infrastructure
to netconsole, enabling lock-free, priority-based console operations that
are safer in crash scenarios.

The implementation is introduced in three steps:

0) Extend printk to expose CPU and taskname (task->comm) where the
   printk originated from. (Thanks John and Petr for the support in
   getting this done)
1) Refactor the message fragmentation logic into a reusable helper function
2) Extend nbcon support to non-extended (basic) consoles using the same
   infrastructure.

The initial discussion about it appeared a while ago in [1], in order to
solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
cause is that some hosts were calling IRQ unsafe locks from inside console
lock.

At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
nbcon: Allow unsafe write_atomic() for panic"), and now we can
implement netconsole on top of nbcon.

Important to note that netconsole continues to call netpoll and the
network TX helpers with interrupt disable, given the TX are called with
target_list_lock.

Netdev maintainers, Petr suggested that this patchset goes through netdev[2]

Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
Link: https://lore.kernel.org/all/aW9D5M0o9_8hdVvt@pathway.suse.cz/ [2]

Signed-off-by: Breno Leitao <leitao@debian.org>

---
Changes in v4:
- Added __acquires/__releases compiler annotations (Simon)
- Rebased on top of net-next, which included changes from Andre
- Netconsole Dynamic now selects PRINTK_EXECUTION_CTX and
  CONSOLE_HAS_EXECUTION_CTX
- Link to v3: https://patch.msgid.link/20260122-nbcon-v3-0-a722f2f0dfa5@debian.org

Changes in v3:
- Fixed netconsole selection (s/CONSOLE_HAS_EXECUTION_CTX/PRINTK_EXECUTION_CTX)
- Removed unnecessary "inline" in C file.
- Tried to shrink the get the lines to fit 80-columns
- Link to v2: https://patch.msgid.link/20260120-nbcon-v2-0-b61f960587a8@debian.org

Changes in v2:
- Return if not able to nbcon_enter_unsafe() instead of retrying on
  a different target (Marcos)
- Add printk that supports context information, which will be used later
  by netconsole sysdata. (John, Petr)
- An extra patch to bring symmetry to send_msg_udp()
- Link to v1: https://patch.msgid.link/20251222-nbcon-v1-0-65b43c098708@debian.org

Changes in V1 from RFC:
  * Removed the extra CONFIG for NBCON, given we don't want to support
    both console. Move to nbcon as the only console framework supported
  * Incorporated the changes from Petr.
  * Some renames to make the code more consistent.
  * RFC Link: https://lore.kernel.org/all/20251121-nbcon-v1-0-503d17b2b4af@debian.org/

---
Breno Leitao (5):
      printk: Add execution context (task name/CPU) to printk_info
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: convert to NBCON console infrastructure
      netconsole: Use printk context for CPU and task information
      netconsole: pass wctxt to send_msg_udp() for consistency

 drivers/net/Kconfig               |   2 +
 drivers/net/netconsole.c          | 153 +++++++++++++++++++++++---------------
 include/linux/console.h           |   8 ++
 kernel/printk/internal.h          |   8 ++
 kernel/printk/nbcon.c             |  15 ++++
 kernel/printk/printk.c            |  50 ++++++++++++-
 kernel/printk/printk_ringbuffer.h |   5 ++
 lib/Kconfig.debug                 |  20 +++++
 8 files changed, 201 insertions(+), 60 deletions(-)
---
base-commit: 9abf22075da98c615be2f608ec1167329a71eafd
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


