Return-Path: <netdev+bounces-274768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FkuIrT7zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F340038F38E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D76306C84F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09CC37F75A;
	Thu,  2 Apr 2026 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="ArlR5UpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447A371894;
	Thu,  2 Apr 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172405; cv=none; b=g8y0cE7dh3snImXda9EcKKgNTLt9GFS4MsESi9Lm0k3z/4+C4h3fMePXCVyLElPN+pZ3Sdeu9g+bu8RrYIZNd24SdTTiQJvss4e+PyAA8WC5U/tgNevh3gdM2Qmc7ZkRDW3/p/zkmI9xNXLQqDPPhuBYpBksnBKmAALpkIbFIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172405; c=relaxed/simple;
	bh=OyFXrtaIREt5Mvg5IohzDWe1YdeCFr+GRBZBVtcHM3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=smn4FKMtrtn970vmYsphTJCq4hd8EfpHu8Hpx+E484TgF3Ia73bDETLJOW2AdEpB49lfn0HktvINSCA7su3cQyP8+29T+ZEhH4pTBFdZtS+cNrm+Rz/gUn5IOaQ53s7CtvIjmXdwdxvIL7IV+Mvr8rq9362GnmSTTSDiSJepAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=ArlR5UpR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a558e;
	Fri, 3 Apr 2026 00:36:50 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 0/6] rust: net: introduce minimal rtnl/netdevice abstractions and nlmon reference driver
Date: Thu,  2 Apr 2026 12:36:34 -0400
Message-Id: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4f0dfe2803a2kunm6754def456bf0d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGk1CVkxCHUMdH05OTU1JT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ArlR5UpRSpw/UaSNxCKSdQVuQLlvpDNJr+LXgkmWpRdgX3oYdrC9NjHbVluj5Oiv7CryXyr5EoXvAxWYps5RlJ0xbrFwchRORL8qh1dMgOjGoxxlLvA09sN11o1+DnOZNeclhK8W3Mk+wZoydsXAurpljLZjhz//oWbNgnyP964=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=YKAAwYb4mtekaS6vgI940JW2tJJCQEqwWtepoxJLGfI=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274768-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ruc.edu.cn:dkim,ruc.edu.cn:mid]
X-Rspamd-Queue-Id: F340038F38E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This RFC proposes a minimal set of Rust networking abstractions for
link-type drivers, together with a Rust implementation of nlmon as a
reference driver.

The scope is intentionally narrow. The series only tries to cover the
pieces needed to model:

- rtnl link registration and validation
- net_device private state allocation
- sk_buff transmit ownership
- netlink tap lifetime management
- per-device stats updates

nlmon is a useful target for this because it is small, self-contained,
and exercises rtnl registration, netdevice setup, tap lifecycle, and
stats handling without introducing hardware-specific probe or teardown
paths.

The series is structured as follows:

- patches 1-2 expose the required bindings and helper glue
- patches 3-4 add the minimal Rust net abstractions
- patch 5 adds the Rust nlmon reference driver
- patch 6 adds scoped MAINTAINERS entries

The driver itself is built with #![forbid(unsafe_code)] and does not
call raw bindings directly. Unsafe is confined to small abstraction
implementations under rust/kernel/net/.

Validation so far:

- drivers/net/nlmon_rust.o builds successfully
- x86_64 bzImage builds successfully
- QEMU smoke passes:
  ip link add nlmon0 type nlmon
  ip link set nlmon0 up
  ip link show nlmon0
  ip link set nlmon0 down
  ip link del nlmon0

The Rust implementation is kept behind CONFIG_NLMON_RUST so the new
abstractions and the reference driver can be reviewed without displacing
the existing C implementation.

Feedback on the abstraction shape, the lifetime model, and whether
nlmon is a suitable reference driver would be especially appreciated.

I would also be grateful for guidance on any aspect of this series that
does not match Rust-for-Linux or netdev expectations. If the direction
is useful but the submission, factoring, or abstraction boundary needs
to change, I am happy to revise the series accordingly and resubmit.

Thanks,
Wenzhao Liao

Wenzhao Liao (6):
  rust: bindings: expose networking headers needed by nlmon
  rust: helpers: add net_device and sk_buff helper wrappers
  rust: net: add minimal skbuff, netdevice, and stats abstractions
  rust: net: add minimal rtnl registration and netlink tap support
  net: add Rust reference driver for nlmon
  MAINTAINERS: add Rust net and nlmon entries

 MAINTAINERS                     |  19 ++
 drivers/net/Kconfig             |   9 +
 drivers/net/Makefile            |   6 +-
 drivers/net/nlmon_rust.rs       |  93 ++++++++++
 rust/bindings/bindings_helper.h |   4 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/net.c              |  19 ++
 rust/kernel/net.rs              |   5 +
 rust/kernel/net/netdevice.rs    | 319 ++++++++++++++++++++++++++++++++
 rust/kernel/net/netlink_tap.rs  |  89 +++++++++
 rust/kernel/net/rtnl.rs         | 221 ++++++++++++++++++++++
 rust/kernel/net/skbuff.rs       |  67 +++++++
 rust/kernel/net/stats.rs        |  17 ++
 13 files changed, 868 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/nlmon_rust.rs
 create mode 100644 rust/helpers/net.c
 create mode 100644 rust/kernel/net/netdevice.rs
 create mode 100644 rust/kernel/net/netlink_tap.rs
 create mode 100644 rust/kernel/net/rtnl.rs
 create mode 100644 rust/kernel/net/skbuff.rs
 create mode 100644 rust/kernel/net/stats.rs

-- 
2.34.1

