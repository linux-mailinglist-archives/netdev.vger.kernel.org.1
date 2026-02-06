Return-Path: <netdev+bounces-257539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bfvGMZXjhWnCHwQAu9opvQ
	(envelope-from <netdev+bounces-257539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:50:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DEEFDB46
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 174E43010495
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89853AE6E6;
	Fri,  6 Feb 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O3bN/17x"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0036F40E;
	Fri,  6 Feb 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382225; cv=none; b=rlHrePA8BnPKpjffXfgl/vrA9U59BKKS4kTN5LtsG5Kh9NX0wW2jukwmlhsVx4/u4rQGoIpvTI5Hsjj2bF7Hb/V1/gepkiFXUcB3ZPef0Dv8qFKxO4pX3MqeEsdbqhIv04vp7csJ7swfZaeyMCaEdDBNGWr0FxoD/wy1xDhVnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382225; c=relaxed/simple;
	bh=SaZYs/ihGtEdH4rdaKpXb4/m2M+s4M0pLJcxU5lWx2U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OpvfYem+6VHMrgA8bNBeNCWabb16Bz4uYFe7xoVqB/nVyD3B6mIb/rz6XsTjtcxGVmtwCAdp49lC5VK8+v/GVbnMBE9Rwx+k1uT7BJ3T3y/cSvDi6H/UdGTmTb9JBzmrHfy07voAHqHpi9Mq4SYSn/BxY1Pmwe0mmCnwUfG98nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O3bN/17x; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LTaZyDZ9j3Gi5vmjthyt4iu0Hy1XoazU4zauTqgjkf0=; b=O3bN/17xmt76AnPsMg4sZQX2id
	tm14vLxSc2N1Bv9pT5X7PIjne/2pXcOSRJqkrgC56P+7HyFIb0g9AZt5NajOqQq+kqPPiyvwR20fp
	uqKTQvqk48KFhB87vOD6/ojvxUVJWfMKbtqkY64La/F2dVmA8on51KfXdsK/r61mlMN7O72bDZ0fo
	PLJeMQgGfUqxvrnN0SO8iT6CpG97GGMtT8vHY4V1+lgdIjS48qnfCax8hukBxx3ghS5iF1Pk//4rs
	YH3Hs3jzEbsL/zQCOfrw0QvLFH5cRHgPssgCGo6afvtehYEKSjwGJiAn7j5dvoPmxC0gawoGoaaU1
	dzX7Q+5g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voLHm-007Abv-Ea; Fri, 06 Feb 2026 12:50:11 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v7 0/4] net: netconsole: convert to NBCON console
 infrastructure
Date: Fri, 06 Feb 2026 04:45:28 -0800
Message-Id: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnihWkC/2XNy2rDMBCF4VcRWmfKaHS1V3mP0oWuiTZysY1JC
 X73UlOnLl4fvv88+ZTHmifesycf81KnOjTeM3thPN59u2WoifeME5IWQlhoIQ4NCillbfRdkZl
 fGP8cc6mPrfPOW56h5cfMPy6M3+s0D+PXdrCIbd9aRPTbWgQgGB2UjNg5i+6acqi+vQ3jbUsst
 DODgnBnBAjBiNIZ1M76M5NH9nqTgOAtUaGCqXh9YurI5M4UICjjdSza2I7MiekjczvTgNDJoFI
 KUTjhT8z8McLXm/lhThcZUpBk7D+2rus3Guup4LgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4429; i=leitao@debian.org;
 h=from:subject:message-id; bh=SaZYs/ihGtEdH4rdaKpXb4/m2M+s4M0pLJcxU5lWx2U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpheN8MUdiUGcfuIeNzA56jQAU51PJ4Xn8+FTZJ
 c2QrjfMyCyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYXjfAAKCRA1o5Of/Hh3
 bXjdEACoVQDdi2VUy/eCzdDwtoZ3t/S2xvwD3x/oRwSr3bYHlHqGabXyEiOXzNj9rETgel78g89
 BAZUq9fCW6HKhsccJKLgMZK88UusTRsFnM7e1IxV/T+lxUfxly3+ZIMVSXYNBic4idUCZ4MU4Fa
 FiBjfSE18mFGhzbjYIaMrTBoTyUI+tj0L+72BvVMQO5msOZghmaV373rOgH2U/uwLJeyoj40ub6
 jBtL37LlFEOaF0HwGBbGVaevUOmJYa4by7QdbXT9nQi6HEpjVFrvH//j/wXwM8wG+Ihis8sOxs3
 dWh4joCoyYjEjJUv11Qro8qsoV6RG3aytk8dK/ry7lad3vzB8huwFMqqzeYWbjcX9e+gcwYhUAH
 JE9vy9P3zzfeuPOo1C/15ToZaACeEzzJJS/c5UHJJfqnBJgd5/QdGJygNgy85SiStT2oOiR1Hmu
 C4u4XPK1v00mR81UxAyM9G10cdXpDgsMNAzWwrkQCtkQkhJCgLAQ4Uwb26AFeKuIxQafVfpjdIZ
 TG1eJxFk/upnUW5Y4L6sTjJlm7HieZBeyBH5JYDPz6zJRn/JMtHsYyvbR6VHwwol6LiGwp9/rY5
 f6RIRsbnhOwM/B50zW007ivZN/jiD+se4GqW1C8u40MdTIXeujvPN8rrC5GgXpsTU2x4zk5PYvV
 wCi0cG44hmvvKbA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257539-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37DEEFDB46
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
Changes in v7:
- Remove the intermediate CONSOLE_HAS_EXECUTION_CTX config option
- Link to v6: https://patch.msgid.link/20260203-nbcon-v6-0-985f3bdb3267@debian.org

Changes in v6:
- Do not select PRINTK_EXECUTION_CTX in NETCONSOLE_DYNAMIC (Jakub)
- Do not make PRINTK_EXECUTION_CTX user visible (Jakub)
- Link to v5: https://patch.msgid.link/20260128-nbcon-v5-0-93b4ddbc181a@debian.org

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

 drivers/net/Kconfig               |   1 +
 drivers/net/netconsole.c          | 153 +++++++++++++++++++++++---------------
 include/linux/console.h           |   8 ++
 kernel/printk/internal.h          |   8 ++
 kernel/printk/nbcon.c             |  16 ++++
 kernel/printk/printk.c            |  54 +++++++++++++-
 kernel/printk/printk_ringbuffer.h |   5 ++
 lib/Kconfig.debug                 |  12 +++
 8 files changed, 197 insertions(+), 60 deletions(-)
---
base-commit: bf2e36c9dab95e41516fbcf7b1cc804539b2d021
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


