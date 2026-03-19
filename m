Return-Path: <netdev+bounces-269636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O8uNA1xXvGkUxQIAu9opvQ
	(envelope-from <netdev+bounces-269636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:06:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C6A2D1ECC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9160302796B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73734C80D;
	Thu, 19 Mar 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqb8K16L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C23451CF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950808; cv=none; b=GYW9ytwQ8NBScQcmbE7xHXRyGHHZwFFbLyTrH3DeD9s1OPkaeI2wXxTnHJ5iiJDWq+13py2ALbZQ70u+aoBXxtl1220bavgJ6LJ+R7P8JXqihk03ce99M5FBBFG1rqMtXkGr6gG1mtYIpJOXxplhFYr7UheM/YsBocfyejBYbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950808; c=relaxed/simple;
	bh=9pS6SdbQQ7xG2PIQpbU5PdKA1gc9OGD8+fliTqhm/zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfN745DvDhDsjME+oFC07XzTNddNVe5wO0tJkvev5PG8xjTNl6J6aunGCAGNvbM7tdPpsd8bFKW/h8R6v3kUzHKq/82mYi8ioXVPq6U6uy+7cKiavFc4r51rXErCRInmjT+T6uBCwKHOv3tkG0JEJZGfs79QfuhC3dxHU0lakXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqb8K16L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b94a19fdso1118473f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773950805; x=1774555605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMImQC3uQ10mtNdYTKjYLhttFlGwTDpP0kPY5vIqCTE=;
        b=Jqb8K16L0X4FKvUUgCsfG1ZNKvheMb1LERFGR6u5cNSoZgOexEcsIxqTit67pTG8C/
         SNOTeR1qI98AZwF++ENJ0FbLMGT5C8x5PcDWaEHZq+eNIjVHSEtwmZEZO5+tsCGSqWj0
         WQRfkIT5eosSTgmdODBIDu20TGtINQFTu880Nc9v1+XUoaBp30zch7TZGt6u+tgSO4pJ
         hyjxZfLVJm6/xrXwvexDQz6cVHk4UiiSb1eDc5bSy2rJ+i+uS+rD3t/vRidWR2FiqKa/
         6qBGVHRMOma4QK6SU0H+4wygiPJcSmj/ZyJbauBoZJOCOdSsJIKLinZbRv4vYFDOgr4f
         kuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773950805; x=1774555605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMImQC3uQ10mtNdYTKjYLhttFlGwTDpP0kPY5vIqCTE=;
        b=ZYZCBk8G7CbjszUEU5ZzcEw9Y4To+vl7r24LC5/u7wLNiNsxA4KrxrOCrurasdorqn
         v9w4QAAYQ/Ly0gF1N/PhJx74zocULY8RhY2trei3kIE9qaxpQx1iSReMkrhbNTvKt786
         T1xeG+wIcKVQQEAkk/REv0n8ig1tcbzsMD471QhNypcoahvQLSU2Pie0lV29ENSBC6dz
         qF58lUByMJYYsVIU2DvSCdEmFMlHDXx5Eab4bJA3L6xDO+xgePZZhiCT5/FOlmv+C4ug
         cSuJD9mFurlCm8hUfST+v/ARZ/qx8BJWqJnmeM8d+X3Qy5aOnv50TriQYi8hlOy4JkAb
         Zkew==
X-Forwarded-Encrypted: i=1; AJvYcCV1mt8cTxJhn3vFMy/mSWZZdOZSWEX00a1RPfnRGxglk16YX4qSabbqSBI07zCpVUqxYcl+t9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bP0wOryDGsgi7h92LcTgLxJeYqu9iXCZKUHhADrF6jB+E4nN
	fmuv0RKhWtPzBgDj9Jrk3gNhU4/FN5LuSyhwzqiw+3Pct6O6mzWPnJk9
X-Gm-Gg: ATEYQzyW7UgS52C8123e7n4agZQ+KU6pe1kwVmX3ncXPxIfgBPm233GcT2JPKy6KeeG
	6LPEzDpLSaeIKPP6JxDGSpLjAiIxNQF+ecME8jyVPb1Q8XbJhhlaGcYylycc/Gm8lqiuCoiGvKN
	k30u/rXod0m3lIDbGHNz6cGBXJ+mmxywAh1HsrLrrrfG7vpwVlZw0X0VLBSJT2ZHmUS4gCStJGq
	cUVwEFxzYuDOYJyKY+ABQMKWh47z+WGrzNjj3bjlkUXXMaQtxCE4K0FRuOzOhmna5d2K/ghjURL
	/PSKvyRlkVyeBD94dcMievXpmcnUKFy3ziVjuwDqqwp6pd+l3bUbJGQ8j+DBdBRA5bbZoI9IGwS
	KyFmal8PSScwbeah5nkTYaGwuVy4HqvmuiTWfFkh90oi19qSaS3/ZBrYkugcv+Sr2QLxvQBJwEu
	SJGHk8NXbs9XmOVjI4Khg5PQ==
X-Received: by 2002:a05:6000:2dc2:b0:43b:5094:a9bf with SMTP id ffacd0b85a97d-43b64263f98mr1065496f8f.29.1773950805303;
        Thu, 19 Mar 2026 13:06:45 -0700 (PDT)
Received: from yepc2 ([87.68.133.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470380asm922521f8f.24.2026.03.19.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:06:44 -0700 (PDT)
From: Yochai Eisenrich <echelonh@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: Yochai Eisenrich <echelonh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH] net: fix fanout UAF in packet_release() via NETDEV_UP race
Date: Thu, 19 Mar 2026 22:06:10 +0200
Message-ID: <20260319200610.25101-1-echelonh@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269636-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[echelonh@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.646];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[calif.io:url]
X-Rspamd-Queue-Id: 47C6A2D1ECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`packet_release()` has a race window where `NETDEV_UP` can re-register a
socket into a fanout group's `arr[]` array. The re-registration is not
cleaned up by `fanout_release()`, leaving a dangling pointer in the fanout
array. 
`packet_release()` does NOT zero `po->num` in its `bind_lock` section.
After releasing `bind_lock`, `po->num` is still non-zero and `po->ifindex`
still matches the bound device. A concurrent `packet_notifier(NETDEV_UP)`
that already found the socket in `sklist` can re-register the hook.
For fanout sockets, this re-registration calls `__fanout_link(sk, po)`
which adds the socket back into `f->arr[]` and increments `f->num_members`,
but does NOT increment `f->sk_ref`.

The fix sets `po->num` to zero in `packet_release` while `bind_lock` is
held to prevent NETDEV_UP from linking, preventing the race window.

This bug was found following an additional audit with Claude Code based on
CVE-2025-38617.
Link: https://blog.calif.io/p/a-race-within-a-race-exploiting-cve

Fixes: ce06b03e60fc ("packet: Add helpers to register/unregister ->prot_hook")

Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
---
 net/packet/af_packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 72d0935139f0..bb2d88205e5a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3135,6 +3135,7 @@ static int packet_release(struct socket *sock)

 	spin_lock(&po->bind_lock);
 	unregister_prot_hook(sk, false);
+	WRITE_ONCE(po->num, 0);
 	packet_cached_dev_reset(po);

 	if (po->prot_hook.dev) {
--
2.53.0


