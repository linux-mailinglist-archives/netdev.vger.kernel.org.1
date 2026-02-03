Return-Path: <netdev+bounces-256372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGv7HPovgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:27:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C113DCC6F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EEE1301FE39
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247931D37B;
	Tue,  3 Feb 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OId2dtKR"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0441D5ABA;
	Tue,  3 Feb 2026 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139474; cv=none; b=GR0QKEBPoNb/O/H/e44UPPSzPMaKnCxYxREMlHKXgPWAUEJj1t5nj/Socx8S2tRD4NdlUKcy1iK8qt2liEfc6SgtXupi0wvILrjbqDqWBgjGL6hxMCaaHlxz4R3Kk3DlkhFDleLpEQFlo6XHy2KFrGj6iO72eff58U5gLI3Vcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139474; c=relaxed/simple;
	bh=EXVzYIkb1ujewKXqi19rPswvAVNTy/OSkqy9SEyu5zE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IQR9jnhXXqMTERC8pM1D2yA3l+c0WsLXV+YQ6VB+t4d+t7bkiW8TWuvQVP0moDo7AdlspakTZ3fh3ptrd7HlOjc508aPbcQSqYDQCnmC4d3H67ajpaNFM0dCp3L2dWP+68+MMh2us93xGMXUzWMUr0Ojx2kFVjwnIPbOWvAG3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OId2dtKR; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=pGo/bVwRRzzDTEL6tmGB8mNjA/zMc2P3BfZOOCY6Bmg=; b=OId2dtKRfjb1LZHrT4rjihi3pz
	OWiUBKNt/0AJK+Lps4gz9CMG0eBEkZgnHQPXno18jkkrtNitrq7W6MGtoemzCpTn0iaG4j43y57J2
	ChYP00ll2R7c/YhHwuSfEJic+8imE8DC3S9eKeuZxo6VrYsHDPay6D1+jdSJfvI7HPSdBlbo8e5cU
	DJD07LG3VsgNl1oCa0meVB6uBqhasCiwxRKZGiH8/jJrdUg9f2rW99zG4WbiWAWnv127nKop3FPqX
	78n9iQrAzTx2bVULmcT1hXrRhIJxqPZPL72Wn2Lp/JdfnMrVkRJjssmX7dSjAEQc8ZQa6RPLKUJTV
	J7/Hz/Yg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vnK8V-004z5H-KJ; Tue, 03 Feb 2026 17:24:24 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v6 0/4] net: netconsole: convert to NBCON console
 infrastructure
Date: Tue, 03 Feb 2026 09:23:51 -0800
Message-Id: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgvgmkC/2XNzWqEMBSG4VsJZ+0pJyd/6qr3McwiiclMNrGoy
 JTBey9ILRbXH8/7vWFOU0kz9OINU1rLXMYKvbCNgPj09ZGwDNALYGIjpXRYQxwrZtbauei7rBI
 0Ar6mlMtr79ygpgVrei1wbwQ8y7yM0/d+sMp931vM/NtaJRJaE7SK1LWO2s8hheLrxzg99sTKB
 7MkmQ7GSBiszJ0l0zp/ZerM/t4UEnrHnDnTkL25MH1m6mAaCbX1JmZjXcf2wsyZtQczSNipoIc
 hRNlK/49t2/YDkA7q8oEBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262; i=leitao@debian.org;
 h=from:subject:message-id; bh=EXVzYIkb1ujewKXqi19rPswvAVNTy/OSkqy9SEyu5zE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgi9C9LpjWG3jxQbV3bhP9GtfK5h0KqtIF705y
 ymf4BzJJOGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYIvQgAKCRA1o5Of/Hh3
 bfmfD/sGwL+svysHp7M0sRpIstH9O6d/EYpPufB8kXTn8ebTQ4URzfb/Nk4VRH9if5b1ekmSvMK
 kbdHGEh8+BxsQc9qc2h6MEc/mW7mwsBy3w1jdOQ6yQKEDm9Sf/p22bp25QQZamyzU6tR6sFkdGl
 vvfTrz3mZyaddbGlakc44xk679vstQRMmwGU33J7zHNLkAuHhAjCVysFHXxFqWbM2+C4vDd6lCQ
 5aUiZBh4qEP/Q5txQ0d9H0AsHbBpNc+igw06ILFbe+XGBSVNqZdb+kknP5nP9NyTWnJAR17Ts0P
 KIfvQBpQ7V3/d/XNsAeRw/a7od23vRf2Xg9/zyXiuw6AIbQbIkxKMLnSO4CF818iCh2110Hvb4k
 MdGsgso2mDfaJ9F5KDewwCKoiLrWbQAbG4Y/H0ilesbcnSFDCITOw37/riBkP6xFO8xSj6QVIPR
 Ch4VuaBnD2SoLchz40Ns7E8QD7eBv+8p4HcyjTG3Uq1KX2GY2poY3UyNBJgfvleERrIryDmU/Ox
 u5TbeXZqvTpdYwOt5HCSbTQ2Q6o475saskVCZUckAuINDP8mMJ/z3SEm9p4gci/Ni2cuoF1WjiP
 MQUoMy5gBiswYd7v5NYWrZ0EzV8X6Qpkt9nBgk6ihBP7sIYPgPNn7P61Ps5mz3IU0oT4lFfWINi
 36KLwKCZ8pssE6A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8C113DCC6F
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
 lib/Kconfig.debug                 |  20 +++++
 8 files changed, 205 insertions(+), 60 deletions(-)
---
base-commit: bf2e36c9dab95e41516fbcf7b1cc804539b2d021
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


