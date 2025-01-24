Return-Path: <netdev+bounces-160691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3BA1AE25
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF3318861BB
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C36FB9;
	Fri, 24 Jan 2025 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7oaADD9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062D3C00
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737681694; cv=none; b=fKRRkIG8E7Z3PeEyhU2YVuQ/uAqSA5pGAFqu18SefR1DW4/9WdwFXNY6bNmMOd96qLhT7jaPuneNaGCAprxzZL4kt1jc63u90Md8K1QqO0VrtgzoFZQoXxpaaJmUR2Ipvg3Z3C8xZ1XRKa0j/7I2v/rWVaa/WPqxLZ5avvXdweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737681694; c=relaxed/simple;
	bh=xGJIwJ5lmVh1PLO5BwoN/+8BaPI03GiV1/Zu7hb078o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/5fTafeJSe3Yh72UcyIiyHZ2rgIf+ASbytbctLKvWQ4Q4JcHsMFpv3YM+o3NTXHnZn+AA7lDAx8BGjxUk5G1JoOqOu5Dy5RUjnH1LaRo/owHtrfVWv5yVPwlCYOvjvMyyVhbSuowYEVEzcDr3Yj9WwOD4hsIyOTTP1qibhjmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7oaADD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C06C4CED3;
	Fri, 24 Jan 2025 01:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737681693;
	bh=xGJIwJ5lmVh1PLO5BwoN/+8BaPI03GiV1/Zu7hb078o=;
	h=From:To:Cc:Subject:Date:From;
	b=R7oaADD9apwWUxyNsGIN+MmPlDjod5cw1NX3letJootCDnP0oFH4oyjqYk6Od8RCA
	 odHoPAozC7SFjtvnn4eZgSZ5MYzlGYUwNQRVn7Xo/BuuiKW0ULu3d/rmbAuMUsQ6m9
	 S+JsO7P5zuZDCtDhmLHZyeK94bNGIKUlPWES8EwbIRqnO1hnynq2vIbJvECXe4ZUNp
	 B01YfBw0JSZpn8AWWXu170eLW+h8K2RYtubGA/ZS238ngcPTs2tHQvghLvzQM7/jQn
	 7jNTkWMWCREyBCp2PtjGe1qfV2urypse6r9jo6yQ7g+NZgInbri/HOtjWDyB7RwTZY
	 GQ/wQDX1Mnnpg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	nicolas.dichtel@6wind.com,
	willemb@google.com
Subject: [PATCH net] tools: ynl: c: correct reverse decode of empty attrs
Date: Thu, 23 Jan 2025 17:21:30 -0800
Message-ID: <20250124012130.1121227-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlink reports which attribute was incorrect by sending back
an attribute offset. Offset points to the address of struct nlattr,
but to interpret the type we also need the nesting path.
Attribute IDs have different meaning in different nests
of the same message.

Correct the condition for "is the offset within current attribute".
ynl_attr_data_len() does not include the attribute header,
so the end offset was off by 4 bytes.

This means that we'd always skip over flags and empty nests.

The devmem tests, for example, issues an invalid request with
empty queue nests, resulting in the following error:

  YNL failed: Kernel error: missing attribute: .queues.ifindex

The message is incorrect, "queues" nest does not have an "ifindex"
attribute defined. With this fix we decend correctly into the nest:

  YNL failed: Kernel error: missing attribute: .queues.id

Fixes: 86878f14d71a ("tools: ynl: user space helpers")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: nicolas.dichtel@6wind.com
CC: willemb@google.com
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index e16cef160bc2..ce32cb35007d 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -95,7 +95,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 
 	ynl_attr_for_each_payload(start, data_len, attr) {
 		astart_off = (char *)attr - (char *)start;
-		aend_off = astart_off + ynl_attr_data_len(attr);
+		aend_off = (char *)ynl_attr_data_end(attr) - (char *)start;
 		if (aend_off <= off)
 			continue;
 
-- 
2.48.1


