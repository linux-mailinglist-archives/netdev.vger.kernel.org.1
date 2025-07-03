Return-Path: <netdev+bounces-203860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DBEAF7BDB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BFC5479C2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52C221D94;
	Thu,  3 Jul 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="0OrHD9pb"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F02EFDAF;
	Thu,  3 Jul 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556006; cv=none; b=TrcwF+EV/zkavAoLNmbHyOANMk+06KBi1QP7qv0fQZ7oy8W2LGEKz5+Bv5nmMLycqM0WAhcQhsiBfTzE+1GD3VFq1oP9048xIWILp05axkLF6ilAMieS67Xr1IeDaSIw6rc0ZCh87bppDyLxW8myjE/lZPT+gBnNLrSUPuxWUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556006; c=relaxed/simple;
	bh=WXDTGdP8LV2OdLBV2fawDgbjiGfDbWOsOGS4OT5h28k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W+NVclPDrAA9PNpK1lLw8KFZGjaAtr40pChlBYBObvB9ZM2qkC2LkiZDw/8chtQ3paeLJ4xCo6PB+8OhHjTEUPp/xq1o2RclhkKXtk527z8xyWwz0psPNHivkwsVhRh8HMNM8B+8S9FnWTGW/TDSpN2xIuLfYeZKudED1IPWvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=0OrHD9pb; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uXLj5-000pBt-R7; Thu, 03 Jul 2025 17:19:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=EJBbOdRMlb7fC04E5yAV9/cTzwhdRgdAxVTABcEKhoI=
	; b=0OrHD9pbLQMTK3Q1IdxasyAVmmsHYMxjvtibfxnAvmqXTk+NSVm3uKb7LcGQYYD3czSMXUh35
	0zU1Dt3feILpaShKmrdTHHAfzbH1gbiCkiEObEQPY3cbVGuy797LLTdIoj45n1SdjNEKLZouwcYGd
	ZcHzK5kfrr8AJgsRYD3GnZp+NbYb0vdUIQQ3oPvCegdv3cb2UMkePLbSjI5vps20ZVPQdGZ4uWLeK
	jeGtupEF5JJNvuNeJHOlxvo+V4R7EL+Mfk5hoc93UHcJeojYdMKpkpgMAEgw173T0b5CQ1yY9sQFO
	vcg66Ai9Pu4pfxBMvQwUI232QO8VGTAuAUvAxw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uXLiz-0006bx-MI; Thu, 03 Jul 2025 17:19:45 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uXLhj-001WIY-Gy; Thu, 03 Jul 2025 17:18:27 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v4 0/3] vsock: Fix transport_{h2g,g2h,dgram,local}
 TOCTOU issues
Date: Thu, 03 Jul 2025 17:18:17 +0200
Message-Id: <20250703-vsock-transports-toctou-v4-0-98f0eb530747@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmfZmgC/3XOTQ7CIBAF4KsY1mKm09IfV97DuCgwWmJSGkBS0
 /TuIpvqoss3k/fNLMyTM+TZ+bAwR9F4Y8cUquOBqaEfH8SNTpkhoACBJY/eqicPrh/9ZF3wPFg
 V7ItXshG6U9i3IFhqT47uZs7ylY0U2C0NB+ODde98LRZ5leG6aHfhWHDgWqNG0tSlHy5O2vmkb
 BYj/igI+womBZCkRpCFhvJfKTelAdxXyq/SN4RUd9i1zaas6/oBWIA8yk0BAAA=
X-Change-ID: 20250523-vsock-transports-toctou-4b75d9c2a805
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

transport_{h2g,g2h,dgram,local} may become NULL on vsock_core_unregister().
Make sure a poorly timed `rmmod transport` won't lead to a NULL/stale
pointer dereference.

Note that these oopses are pretty unlikely to happen in the wild. Splats
were collected after sprinkling kernel with mdelay()s.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v4:
- Fix a typo in a comment [Stefano]
- Link to v3: https://lore.kernel.org/r/20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co

Changes in v3:
- Static transport_* CID getter rename and comment [Stefano]
- Link to v2: https://lore.kernel.org/r/20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co

Changes in v2:
- Introduce a helper function to get local CIDs safely [Stefano]
- Rename goto label to indicate an error path, explain why releasing
  vsock_register_mutex after try_module_get() is safe [Stefano]
- Link to v1: https://lore.kernel.org/r/20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co

---
Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

 net/vmw_vsock/af_vsock.c | 57 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)
---
base-commit: 223e2288f4b8c262a864e2c03964ffac91744cd5
change-id: 20250523-vsock-transports-toctou-4b75d9c2a805

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


