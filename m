Return-Path: <netdev+bounces-146249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7B9D26F7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B1E1F24327
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451271CDA25;
	Tue, 19 Nov 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="saMNt/g0"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E51CD200
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023142; cv=none; b=aZvrtuOZ7I+vsmITNM0sTE5kv0qJW/MAkL0IS1YrYmlKl8sU95VCWUBps4LyRxsr0oSNd0rUzIUWI12ClN1AGsZUdpkiTe3505SGmMONAEu4xw9gDc7wwuSnFYBtgkrnQHItK9uuOedvWFMh2HAnIc5RTkesx5QurWALfeUENcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023142; c=relaxed/simple;
	bh=R1N7tuV3toAcK96W6gsrUGEuM8/UuBdRJ2bRHdfTqeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f1q21jZ8/o4RcsaqMzU2TcYy6Jl+P9Ww0MB1p8tRV245pyrDWY3FLu1maYZg7OAzTagTsjvmUd7P69fmL66YSPyhyxIZUKnShVFvmglimuJVKaJQaVn519+L3YPohScjLDDGAdS9UI3AIm7lIKixyM87nSVdctZRBKnjJpi4R20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=saMNt/g0; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tDOKv-0024Kx-KJ; Tue, 19 Nov 2024 14:32:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=zFb0s9I2ZS6P3vudh9lt5OZE4zI28ib5bkNvsnSR5V4=
	; b=saMNt/g0vqhrUVcIU0xIw84mf5iSlYd3Wyx6FqVAQiqY4s6/iAH59oxBLFYwZOxBVo7JH2/fr
	qfba2alj+6T7CoOktEE+C9U9MC/TI/Ut7H5gw0BeDvOhfvVYJ6KyCJ4CuKa3y12g8CiFOKnluHkqd
	Qx3/t+mY+NCdATz+aiDJWwY9CbksFVldZxL7YPOD8M18tWcs++kJn7NkEDbonbZ7N8/nMhY8BH77Z
	PWyOyoM00A7ROR9faCWfiXrjZaC5Zt6BHS0xoJrIRLSdrLGPjfgWTrao8D3xf9bm59WA2G67BMkGA
	KR9L+nFukBg0y6lw3aVigjjO4gDYB1R4QCg8QQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tDOKv-0006N3-0w; Tue, 19 Nov 2024 14:32:09 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tDOKj-000XIx-0V; Tue, 19 Nov 2024 14:31:57 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v3 0/4] net: Fix some callers of copy_from_sockptr()
Date: Tue, 19 Nov 2024 14:31:39 +0100
Message-Id: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuTPGcC/4XNQQqDMBAF0KuUWXeKExWTrnqP0kUSxxoKRhIJi
 nj3hlDoptDln89/s0Pk4DjC9bRD4OSi81MO9fkEdtTTk9H1OYOoRENEDUZvX/MS0Pp5w8GtHLF
 WSrHWkrQmyMM5cCny7g4TL/DIx9HFxYetPEpUqo/Z/jITYYU9ydrKbrCmb2/B+PVifcGS+A+ID
 ChDom0sSdPpL3AcxxvpusTU+AAAAA==
X-Change-ID: 20241114-sockptr-copy-fixes-3999eaa81aa1
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>, David Wei <dw@davidwei.uk>
X-Mailer: b4 0.14.2

Some callers misinterpret copy_from_sockptr()'s return value. The function
follows copy_from_user(), i.e. returns 0 for success, or the number of
bytes not copied on error. Simply returning the result in a non-zero case
isn't usually what was intended.

Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.

Last patch probably belongs more to net-next, if any. Here as an RFC.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- rxrpc/llc: Drop the non-essential changes
- rxrpc/llc: Replace the deprecated copy_from_sockptr() with
  copy_safe_from_sockptr() [David Wei]
- Collect Reviewed-by [David Wei]
- Link to v2: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co

Changes in v2:
- Fix the fix of llc_ui_setsockopt()
- Switch "bluetooth:" to "Bluetooth:" [bluez.test.bot]
- Collect Reviewed-by [Luiz Augusto von Dentz]
- Link to v1: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co

---
Michal Luczaj (4):
      Bluetooth: Improve setsockopt() handling of malformed user input
      llc: Improve setsockopt() handling of malformed user input
      rxrpc: Improve setsockopt() handling of malformed user input
      net: Comment copy_from_sockptr() explaining its behaviour

 include/linux/sockptr.h           |  2 ++
 include/net/bluetooth/bluetooth.h |  9 ---------
 net/bluetooth/hci_sock.c          | 14 +++++++-------
 net/bluetooth/iso.c               | 10 +++++-----
 net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
 net/bluetooth/rfcomm/sock.c       |  9 ++++-----
 net/bluetooth/sco.c               | 11 ++++++-----
 net/llc/af_llc.c                  |  2 +-
 net/rxrpc/af_rxrpc.c              |  7 ++++---
 9 files changed, 40 insertions(+), 44 deletions(-)
---
base-commit: 66418447d27b7f4c027587582a133dd0bc0a663b
change-id: 20241114-sockptr-copy-fixes-3999eaa81aa1

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


