Return-Path: <netdev+bounces-257744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZtEEFA/ahmnMRQQAu9opvQ
	(envelope-from <netdev+bounces-257744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 07:22:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0410513A
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 07:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121A2302171F
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5276129CB57;
	Sat,  7 Feb 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkNl2v13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E51C860A
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770445321; cv=none; b=XFDZN8GmFPIawUyeghEJcGXegoxdmg8ZF+AgTVJ1B1FgMR/T3PAqhBfVRNBHnRYh9PyYPA56Z9N71IrHYu+PGtnbGSNxyN1zZSuvPuVcuy+ewTJUsgDJjlvL7muj9vs0fETqaHpJolgu2iNhaw5izUFleOgN7zg4QUDmWVmhBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770445321; c=relaxed/simple;
	bh=khdehHZTZ3iPp0jMZpCIkxyJL29MISIPziLCk4adFEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ogXkd9TihWulKT+az1TH6d3RC4VD6BKO/mrJpOKrSwYnJ/gHL1M20qEbavj5NPCUXuHEJKl5XOCIKPNaByK/mNp8ok75b2fw4KManbXhVuztCv+a6hLkZ9d9MO+5kpaewjLsYan0evlmge/ZMgJ26TEIRS6PLd87gIelYmDRQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkNl2v13; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-894638da330so30295146d6.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 22:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770445320; x=1771050120; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jvauz+ENBVr5yYmGZ77a3RAIpmuhMLwQfOQH7uwGMY=;
        b=AkNl2v13GX3N7oIuzBnxLTUM+e0oV/kd5hBS4dfhSOUplKfEi1VovgzEOpO+GuvAWp
         9B6enSbaDkZ5KMtBE2lhBpbEz4Bs3UsqYC0zkiZ4GA3qUjhw4IIzAIhCZmMhdcF939dU
         gIsLyZU8qdSbyxk4DCqxsXNEFFVl7RfpoUh/G0PIHVHodxrlTkHk4AoKMd9icrgrEiOg
         Hk4OY2lIqVIwjFGj0uZI3nUbpvtbXoKH0qkWEzQWl3BGjhAr3Cp8j3LWiNrJAdWEi7Kc
         qfqaeXfgDILk1do9RDqgrgeVIQ/hDNSBfe1VzWfcsZjF53ur1pJgaF+Lm/8XPpa1jqtk
         WFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770445320; x=1771050120;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jvauz+ENBVr5yYmGZ77a3RAIpmuhMLwQfOQH7uwGMY=;
        b=V08FDhgZ/bj1/WNt/GJ7FaUVc3sKudepKg+2yCVVOv/tyqUevW8yYOsQf5DlDU3SLG
         +iSxdGceELRNnU9/B+p6UAGHM1y5rySMXlwSY924lap9vZTsYfQzxMnT7Cu+fGBrWaUE
         Tp2v0ufZSXskLEOq9Xjqm4HqfGnaKcAhN0NOjehADn18t8HO2azSkCAndijXBu5+3EAR
         szaSUizpFXvv/UZe2Q/cJjSYWLI0/RvxHJUxm676wxeJO878E4VJtBoGXBP+KYL7O4Hk
         GniOY3kqZSELlHsuUCUBop26Z2t1BpeO55HuyiKxAVSsQQTJ+umOM/J5pfj8szQBjgLq
         gtTA==
X-Gm-Message-State: AOJu0YzpB7das5d/gTq3iC4p1dmH0lKvKHzvgpN7IpRWkoggIHkgm0Ci
	p9Fm6CC65H/50QWDkuVODAi6oLAverpFsxN5NO4F1EHyAiTCAeilm+OU
X-Gm-Gg: AZuq6aIcRYdof/NKXJMsKIWHy0UbqMwUcKccvSLYdWK/kRQ6GnDUe2PhP+oKtNlQ16P
	Wo8vVr5YGdbj1JumILo/cCt6WEXorrTU9mDvLRkAakqb+SkXv04JdgTgFXtBadFtUrl6cEiNOVP
	Iw9OKDkX2+g8mLem0u3y8MG6Zqda7QPJNMMboJ0AIYvO5SE+KtxbhJWuzmU+t7OEjgQcp3nxmrW
	VRy9gFDDfeVjRIA3eqgaHP8/h7HQRKB9glicMyY+6ZTfCOYXnXIgoNs0craiqvSAVhcCMfbbden
	Noq+MmFt8ouKHl7hDlNC+2rYFQX/Mm0FrKCwMh/h22MU90CgkxdMkGaDSu97bedacFN5G7oOaL3
	lEtPT1qx6BMbdGvHi+PEZcXLIbs6gH4WPY/sf1NG7fUHiIl1l6a2EGsyXhLuSNGmzKrXsEbeKi6
	Vck5AM0NNx2tYo/ZaCS8SQ
X-Received: by 2002:a05:6214:27e2:b0:895:1855:f174 with SMTP id 6a1803df08f44-8953c8065a2mr72114296d6.24.1770445319801;
        Fri, 06 Feb 2026 22:21:59 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf58b06sm34858036d6.15.2026.02.06.22.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 22:21:59 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 07 Feb 2026 14:21:46 +0800
Subject: [PATCH net v3] net: ti: icssg-prueth: Add optional dependency on
 HSR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-icssg-dep-v3-1-8c47c1937f81@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPnZhmkC/22MOQ7CMBBFrxJNjVHGhiBTcQ9E4WWcjEQW2ZEFi
 nJ3LFcpKP/y3gaJIlOCe7NBpMyJ56kEdWrADWbqSbAvGWQru1a2SrBLqReeFmF1uAUnLSESlP8
 SKfCnup4w0QqvUg6c1jl+qz9jnf6oMgoU1jgTrlJdglWPfjT8Prt5rJYsj2R3JGUhtTeE2qKmz
 h/Jfd9/vjxfyuEAAAA=
X-Change-ID: 20260203-icssg-dep-b9f7fc2be11e
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Roger Quadros <rogerq@ti.com>, Mohan Reddy Putluru <pmohan@couthit.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,couthit.com,arndb.de,pengutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email,davemloft.net:email,couthit.com:email]
X-Rspamd-Queue-Id: 55F0410513A
X-Rspamd-Action: no action

Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
forward offload") introduced support for offloading HSR frame forwarding,
which relies on functions such as is_hsr_master() provided by the HSR
module. Although HSR provides stubs for configurations with HSR
disabled, this driver still requires an optional dependency on HSR.
Otherwise, build failures will occur when icssg-prueth is built-in
while HSR is configured as a module.
  ld.lld: error: undefined symbol: is_hsr_master
  >>> referenced by icssg_prueth.c:710 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:710)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:681 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:681)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:1812 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:1812)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(prueth_netdevice_event) in archive vmlinux.a

  ld.lld: error: undefined symbol: hsr_get_port_ndev
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/etherneteth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:683 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:683)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced 1 more times

Fixes: 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame forward offload")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Mohan Reddy Putluru <pmohan@couthit.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v3:
- The implementation of the 'HSR if HSR' syntax has not yet been merged, use
  'depends on HSR || !HSR' instead.

- Link to v2: https://lore.kernel.org/r/20260206-icssg-dep-v2-1-9dae19b19e6d@gmail.com

Changes in v2:
- Switch to the optional dependency as recommended by Jakub.

- Link to v1: https://lore.kernel.org/r/20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index fe5b2926d8ab060d83f5a58d91e749a45c6cea18..c60b04921c62cab52983efa5aaafecdb9b7d4da4 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on HSR || !HSR
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.

---
base-commit: 6d2f142b1e4b203387a92519d9d2e34752a79dbb
change-id: 20260203-icssg-dep-b9f7fc2be11e

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


