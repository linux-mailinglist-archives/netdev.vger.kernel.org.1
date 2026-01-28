Return-Path: <netdev+bounces-254279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI5lMKkbemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:22:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE0A2AC9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF053012244
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA92A26E16C;
	Wed, 28 Jan 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="J3NwdyVc"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF4221DAE;
	Wed, 28 Jan 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609907; cv=none; b=cCvfuCFdpPpxL0EBgxBXGZpOE2P4BgoQiktCg/wCIlLq4f3X3KMMaZ9MmsSXFUSqrJgx3kXT3TDTPeIbwI2bO1jnmgsLucsD0F49IgS5MwcI09N8KAuyHEVi8PbdWXxg4Q7JRIUmq1uZyFv5DoiyyiB8cSr5JE/6QlBAN/4N+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609907; c=relaxed/simple;
	bh=pdsKKG+XFXl393qIdP5nH6CE06WIiPYeNtll4jcDpk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S4P6z8TW9YMlInIWAvZzngiboPzNDmribIBfNAXIYbXy2nFy2F0L3RdVOMFb8R6+H/K8mGVwGKUHKAkJReS+yQphXwzQO0CpyCHQL0EMXH91k39+a9Wf52H9C/YX/IbiKhZDvEIucKSxTLQhFEbeftD/7oERwn+ux3zmG/sWzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=J3NwdyVc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DWJ8EX/uLkvihShNEFcCS5upaZILDmFQdw86cdc5Uc8=; b=J3NwdyVcDmya4dGir1wp5uRhKM
	iuc7xug34lsrUPpWF+eQy9BRSuIU5OCBWKDjVfdMy0vrBtrd8DKunvAkBfLynSDkwjAF6Wdqrhg16
	3AgAOsJxzATwZ8ZG8kFrVTYMSqfWq3VOSwFBGC1bOUA8Kh+Mi6zse3VV4EhoJdcAbJRcB00UDB5Z8
	GWCGf/ZcWZt1mkd+07i3frJFsiuASuyoNV4qc4pNFQEoFfvNx1pFIHNNc82oebC8gRTojgTCWML8Y
	CAnNAMlAY+gDxqMTSCctfs2uC0cArAiwnzfQ61WwEU8aq4XmOmel9hTASXOD8RywbxVcHNbPN5psH
	Wd5Vp1qw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl6N3-000Dsv-4x; Wed, 28 Jan 2026 14:18:14 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v5 0/4] net: netconsole: convert to NBCON console
 infrastructure
Date: Wed, 28 Jan 2026 06:17:36 -0800
Message-Id: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEaemkC/2XNy2rDMBCF4VcRs/aU0ehme9X3CFnIspRoIxfZm
 JTgdy+IuqRkffj+84Q11hxXGMUTatzzmpcCozCdgHD35RYxzzAKYGIjpXRYprAUTKy1c8EPSUX
 oBHzVmPKjdS5Q4oYlPja4dgLued2W+t0Odtn21mLm39YukdCaSatAQ++o/5zjlH35WOqtJXY+m
 SXJdDJGwsnKNFgyvfPvTL2yvzeFhN4xJ040J2/emH5l6mQaCbX1JiRj3cD2HzuO4wcrlguTSgE
 AAA==
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
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=4035; i=leitao@debian.org;
 h=from:subject:message-id; bh=pdsKKG+XFXl393qIdP5nH6CE06WIiPYeNtll4jcDpk4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpehqe6BkJhmNPTkGLAkhAaEOol/7uWU8fCkw3p
 ZWs7Ol9aKuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXoangAKCRA1o5Of/Hh3
 bQBDD/92r+JoKgLDGMs9N23hSkeGaj6vON95cJeXLicu4UKDfbUW2O0OzxRM39Y9uYh5cPdi8dm
 1KxiT8Ot9V9wO8U5oXPuBlz2kr7pXmGciHAb0ucmxTyLfGHE7+SayZfaxYDxUnJaoCNxUUe2fH9
 8LBQamjy92ypapNXxf3GwC8+wJabnyemkent0upHjdwrvdjQoRMb4vuJMpiu44F75ICcDOyhgya
 qU23/xZoW35IX+kQNkjO3OMxhGbg917trnLNRxImEus3uNmFWh9RbbemDppu1oWeB4AZefY0D77
 aQhLiSEMrgV+05HPSxo8FI08baojZ7XKST+d2chN3JxbMFBoHj350m74t7m0bJHfuhjU7HbHrhP
 L0W+fv6Uj6EYx04uXnOd4q8pXUUbEkbs3UNWAVhV4y70e8K3tJvOtYkT+4OlLbzwgVsoo9bv+wv
 3nkExW0JRtAtoOlImmp5AtMFnEj6GXUrs1bco+kkpanZjtTq21FXVtHryRo39qelK6du3i/YG1M
 nu0YtvRGMiJbFrzffke59eQiKVQPqDEFrPJQpuUbQ4w8LqPvrA+ZhzMgtsLtZgAJOJhrt2lk124
 vqM9odjVIQZjbvZ+AnlivLopxBQ6HMfaFsB775Iz9/gb4R9Afn8i74x2y2kOG9FSA0cGzIj8Q2e
 ipX/nkRIRR7L8RQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254279-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2FAE0A2AC9
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
Changes in v5:
- Replace the memcpy size from TASK_COMM_LEN to sizeof(wctxt->comm)
  (John)
- Add some compilation time asserts (John)
- Change the implementation of printk_info_get_cpu()
- Link to v4: https://patch.msgid.link/20260123-nbcon-v4-0-46a5cf567926@debian.org

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
Breno Leitao (4):
      printk: Add execution context (task name/CPU) to printk_info
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: convert to NBCON console infrastructure
      netconsole: Use printk context for CPU and task information

 drivers/net/Kconfig               |   2 +
 drivers/net/netconsole.c          | 153 +++++++++++++++++++++++---------------
 include/linux/console.h           |   8 ++
 kernel/printk/internal.h          |   8 ++
 kernel/printk/nbcon.c             |  16 ++++
 kernel/printk/printk.c            |  54 +++++++++++++-
 kernel/printk/printk_ringbuffer.h |   5 ++
 lib/Kconfig.debug                 |  20 +++++
 8 files changed, 206 insertions(+), 60 deletions(-)
---
base-commit: bf2e36c9dab95e41516fbcf7b1cc804539b2d021
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


