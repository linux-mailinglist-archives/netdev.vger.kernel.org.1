Return-Path: <netdev+bounces-277694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOqEBh842mnYzAgAu9opvQ
	(envelope-from <netdev+bounces-277694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:01:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1203DFA6C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3B3303F2B5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09534A3C9;
	Sat, 11 Apr 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+3YHCIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE387347BDC
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775908807; cv=none; b=sTzFSE2zl61Kq/cuA3LTMmqMnyYdYEGfZBQxM1+DWTQ3WFWV3fgzFQNJdK0fXNv94RZ+KPXAhbTMzAP6WzYMq4tbJkVx/VfBvrxXns4mnrzW3I2dsXpUwpVc4QDxJ1pzZIEJWOuYB4AGDn+TyGZIGObU8kJ63vQORWYzakvJnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775908807; c=relaxed/simple;
	bh=GMQQ846bik74lm+a9kxAhWISSjbQN89Wh2uXyZKV+B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDXMGMffy9/CfLjTCESo7QFjtjhXnW4+d2HLojGkJKGZABerlkLH81eOXDFO1kAXYdbncruDa5OKY+qQCGvj76FpBrbAbAjwTYeLMMHbCn/QCvlepmHxxVxKz7m8SzvY22jkex4Jk8uKH8kxRsFPZ7XCjMzNCEwVhiraV5Mr8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+3YHCIu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d95017a68so1926903a91.3
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775908805; x=1776513605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BqptnOZV+wSO7mgK/jnSvUYe0PNtQ9QVGGsakN9kDs=;
        b=X+3YHCIuD6LyyHYCbKoeoz6mlXSVY9kCMEkQjRSrvcD2hmo4LFvjUl6em7ty7ShB2p
         PlgltWjmxVA1u0qaGej64kQMnhFeXZ+haJStdjyZl2S1Tq2OO3rPiN9IEogsGc9S5Rz7
         qUaa/r0c9MBKfFZ9RQ11f9Z4iTcn2HEfCBSm93Ky90e2tG1ZODctyXu30N1xXgKKg2AA
         /xkWxCMjPTHjwnNgfOgt5zNRlib/dbbRA/sM7Gc14w3RHyCUXSPXOPCOGM/cN/oe/Ssm
         f1DBa0n8Sg9NKyysmeqBcuazou/Nhg6MrDc8/HWLOqHMJ79yWqziVo6wLFR/67PoyUMh
         FvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775908805; x=1776513605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BqptnOZV+wSO7mgK/jnSvUYe0PNtQ9QVGGsakN9kDs=;
        b=inuqkbsGNK1aL926sdHfo+pgIb5ygG+OF90hjog/5csPSzQ2EHhvhR+Bg42ySOlBLW
         NueQqp+n76bmeBuP8tsDw+zvZ3ipcDT0YdYlVB/zsX2IfCp4Mxrz7mKmlaHlQICfyYl1
         Wf1Gt0iG5sSr/WOFrPwb13Jym84LVWEXE/O68gOixFZ+LKR8jptTDk6STuapzEDky6xY
         VOP/EEQfE5W4qg0VAcHz40qQGe04pYIi/St06s5ZSNEz8/IQBC/lqvncPLTpHTDdhWwJ
         UEiJ54nE2Jaet/okvhTgoPUD9emC5+raSavYxaFCqHKoi+5hWcFTKFRlsPOugZ9v79sH
         t7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVTZBbpSglk62xxMXcppUTCLlu5i87KBFnyEX2W4JEGBtONOfFbojJmUO3b7lzklvAigTZDu+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7I1Zy2hs9rpC5tKG6SkPGvucFH9S4XPBRljknEGMveJ9SSMg
	SnO7i5n8WDdn1CCmtk58+C3ByiT7FiqWWWSSOjjikORMUDuwutNUXydG
X-Gm-Gg: AeBDieuoIWvMDqyC/4mwJCjF41EX1K6r4Em0veBqUeWlc4kX/v1LDe13cO1zI4E/TT8
	JTgx9roPAH2E0P+gK5L6DthAiehUMntrVvgw08AkSIJ1csMryN0DSBobuIIXDk8NT+fkOKG6Go2
	X10IO3nkJGAirBpTMOxFthgybsTzLZIdRi3OZpyolJ01EbZyrRmca5Hd15LsqVO1MQZFCrNndcM
	63DRBj+k3fq4lWUcHNUSMLtSYz9WhpR4DEteAKAOfgYddZRxVLV0DMEHFfScKCX6nt/zk84A046
	t6PDk0oRaVm1CJF+sM+GICdQqlnMEipue0dLmjZ2Ey/M3wMM6dIAS7MiCDqqw8OTpgmiFUXZA8Y
	DhxlUdbCiAO9Db6lTPwegsua7N8DUJxlptYUilx8iDqAsfJmK7ZSc9/LWelRppmAOKI9WvqN83T
	3OZhY00R8tM5WGAAJAWU44QPpGhjVAYzLkiTZClRreSKeFzLY+NfDJTp1gRtAgpa6wCmphJhEje
	QuFP3ItzytY+10=
X-Received: by 2002:a17:90b:3952:b0:359:8eaa:7f42 with SMTP id 98e67ed59e1d1-35e4282294cmr6901564a91.18.1775908805039;
        Sat, 11 Apr 2026 05:00:05 -0700 (PDT)
Received: from localhost.localdomain ([103.10.31.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f996sm9826696a91.12.2026.04.11.05.00.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 05:00:04 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com,
	shuvampandey1@gmail.com
Subject: [PATCH net v2] atm: mpoa: keep mpc->dev referenced across mpoad restart
Date: Sat, 11 Apr 2026 17:44:58 +0545
Message-ID: <20260411115958.64827-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277694-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5ec223ccb83b24ef982f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC1203DFA6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

atm: mpoa: keep mpc->dev referenced across mpoad restart

syzbot reported a netdevice refcount warning:

refcount_t: decrement hit 0; leaking memory.
WARNING: lib/refcount.c:31 at refcount_warn_saturate+0x70/0x110
...
dev_put include/linux/netdevice.h:4466 [inline]
mpoad_close+0x1fc/0x3e0 net/atm/mpc.c:889

mpoad_close() drops the reference held in mpc->dev, but the mpoa_client
itself stays alive and keeps the same device pointer.

When mpoad is attached again, atm_mpoa_mpoad_attach() reuses the existing
mpoa_client and its mpc->dev without reacquiring that reference, so the
next close can hit the netdevice refcount warning.

This reference is owned by the mpoa_client/LEC association rather than a
single mpoad open/close cycle. It is acquired when the client gets its
LEC device and is released later from mpoa_event_listener() on
NETDEV_UNREGISTER. Fix the imbalance by removing the dev_put() from
mpoad_close().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
Link: https://groups.google.com/g/syzkaller-bugs/c/qhZ5MJfLBOE/m/UnotmgRdAQAJ
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
Changes in v2:
- drop the atm_mpoa_cleanup() dev_put()/NULL hunk
- add the syzbot warning excerpt
- add a Fixes tag
- clarify that the final dev_put() comes from the notifier path

 net/atm/mpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index ce8e9780373b9..90ab8f2889734 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -886,7 +886,6 @@ static void mpoad_close(struct atm_vcc *vcc)
 		struct lec_priv *priv = netdev_priv(mpc->dev);
 		priv->lane2_ops->associate_indicator = NULL;
 		stop_mpc(mpc);
-		dev_put(mpc->dev);
 	}
 
 	mpc->in_ops->destroy_cache(mpc);

