Return-Path: <netdev+bounces-244034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC13CAE09A
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 20:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC83300FB3B
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 19:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E8188713;
	Mon,  8 Dec 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JqwsStIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A73B8D5E
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220494; cv=none; b=ofWM3qrDRTrMvgPIULdzJaEPVcTLIcukhKI3ojyO/D+0LAGqjHnjBXqxUJZLP9h2A6cD2QaxfubDHxnXWjjQ0+a8QPHnF16FtTakXBHP0GOcTalStn5K/8Azp1q2bCD6ax2wKs0Cxeef0XOBGQCiWxzyhQoisq0TgnI/BFc+gB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220494; c=relaxed/simple;
	bh=9dMmjKpAIe5tiYWnCChQqxacDy15SebclmPnWqCJ8yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBlst2j8XO5/Y7QDuVU82njF51PicS8gcJ35d3bijzaKqct6mdGNcG1PCF00SX6zAw5Epr3xi/sWRH5caeIcjYJ60oPeIyNOWvOATCP7O7UpdW01C3GmcEpnWKTvhi9TKZfQCcPFHPLCKpHxmYWjy7u+whTq2SzGOezoJ+Zt9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JqwsStIx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298250d7769so39711155ad.0
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 11:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765220492; x=1765825292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxrdnTWRTtifhCFpYMtimVf6Z+uRaSgL2fzffnSUQ4=;
        b=JqwsStIxdqkSLsJjOqC2rBtJoMXDlo+pBaN5HO/Vtnmlu8zvlDBdVHSoVzzEcvVkmo
         n3xxofvLZ1mmKyjiBVoetInCeRMcFzKboqWIJAsrKs5j82+6ZU5ZG+ynJZ9u9VMkrubN
         XQ4/A/yK+kgIY0vOhlMET2590bqEVIDLrSYh1L3PqUGA4ENE1qR1nb7/ajr/4xPY0cOv
         kdHMrRF67llPSBMVi32t5il1jRmUGpqJ0/H9v5SGJm5PrXUEMrxICgKh/Jhl2ozSnIWH
         /M7++EHVuNTIvY+zDsENBJ+Y24JXKrWMuiGPU+sunTGr1LU5jyydJLab5+GmzImf14k2
         Ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765220492; x=1765825292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJxrdnTWRTtifhCFpYMtimVf6Z+uRaSgL2fzffnSUQ4=;
        b=M2UVM1UtUJGmImAJTzBLATf5G6nYkLUFx89aq8uV8lVL+bUbPqoMfElGbJ7dQGfYIq
         +j82ZXS6UETRNlWtSaEe20j0JeUGYbtU7q8Zdyxn1uJKfNWPCcZzRbhmUIvGmlhxz/qB
         70EvM0NKSsJwFyNHIBIXxfMmuQKktdub++5VrE4LNm7WY2/zfS4eAX4Z7Ae4AemGSkga
         RLcdY6GsLISNxKT3XoL6gxoX7XyxfrxmLFYTK8vIMjGV7is8geoAC6jH/fr33kKRLwzx
         /Gdje/4x5/3XIN508gkKbiEKEuW8WTlMipbrTHtgCgSHuXdgEv/Yitel6KMdwpZ4Qr6M
         hKug==
X-Forwarded-Encrypted: i=1; AJvYcCUBN2Wg5eiyhWNyioLwAHZts2rC9zcxiMN68vu1ZIIfSCYdB7SSweIKcO8cTRNbtY/PESVrsbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywde7XjjsnXcDbVtj+9iiSryEOm6vKXLXGkLnEmg/CY5DAEW0wh
	XYmu6HyopHmvGBsicNYcCf83ToJ3x5ArNQaplb+1mwR3fV6p/265cDCY5SgRlN8w7A==
X-Gm-Gg: ASbGnctcsUQUl1X25bM/djtlr26BAcOfvECg7c4/gtppSozIZRhJAmO3HfYOsFghvkS
	2aLnCLLnqCMirQNKUKT9Lx0Qxg6b5SsBdrpNi8pOX9VJIrXkahOBPqAP1tBKrvZq0hnZ+h2DJt1
	JPixnjgKA6zR/DlxDELL2H9rHySwP1e9/p/PQO1t63KvVxtBlquEZ+YcLr30p+U+TjreBLUqb4X
	nebFEUczkcsq3jjpYMkrDrAe24KoBTYeIxR4veG6AKkpPXK2v8U9nqSMHLl38x+7JMS3XXGV/E0
	rBHE3VuLE90+k0PjG2QHASFqVjZNpKdv8OpHKlj3wg7yUoshvKMS/CSGskmXhiRdqXUu4pwVGjq
	xvcgYQrht/biQUgYSRzUG9Se6hd1cOh+RGJTZLoRirPq0J9Qz/cb408uHA+9WjnFaKeNZWZ0=
X-Google-Smtp-Source: AGHT+IEDrY7TCfncVywJhT6BywEwqUuZuMzloXBDKlhKCQy0/Lh+zpuUKezZlkdcb5VkzJqgqHCqgQ==
X-Received: by 2002:a17:902:f693:b0:248:ff5a:b768 with SMTP id d9443c01a7336-29df5571f2dmr76812165ad.10.1765220492025;
        Mon, 08 Dec 2025 11:01:32 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf52fsm133666565ad.39.2025.12.08.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:01:31 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com
Cc: horms@kernel.org,
	dcaratti@redhat.com,
	petrm@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH net 1/2] net/sched: ets: Remove drr class from the active list if it changes to strict
Date: Mon,  8 Dec 2025 16:01:24 -0300
Message-ID: <20251208190125.1868423-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a user issues an ets qdisc change command, transforming a
drr class into a strict one, the ets code isn't checking whether that
class was in the active list and removing it. This means that, if a
user changes a strict class (which was in the active list) back to a drr
one, that class will be added twice to the active list [1].

Doing so with the following commands:

tc qdisc add dev lo root handle 1: ets bands 2 strict 1
tc qdisc add dev lo parent 1:2 handle 20: \
    tbf rate 8bit burst 100b latency 1s
tc filter add dev lo parent 1: basic classid 1:2
ping -c1 -W0.01 -s 56 127.0.0.1
tc qdisc change dev lo root handle 1: ets bands 2 strict 2
tc qdisc change dev lo root handle 1: ets bands 2 strict 1
ping -c1 -W0.01 -s 56 127.0.0.1

Will trigger the following splat with list debug turned on:

[   59.279014][  T365] ------------[ cut here ]------------
[   59.279452][  T365] list_add double add: new=ffff88801d60e350, prev=ffff88801d60e350, next=ffff88801d60e2c0.
[   59.280153][  T365] WARNING: CPU: 3 PID: 365 at lib/list_debug.c:35 __list_add_valid_or_report+0x17f/0x220
[   59.280860][  T365] Modules linked in:
[   59.281165][  T365] CPU: 3 UID: 0 PID: 365 Comm: tc Not tainted 6.18.0-rc7-00105-g7e9f13163c13-dirty #239 PREEMPT(voluntary)
[   59.281977][  T365] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   59.282391][  T365] RIP: 0010:__list_add_valid_or_report+0x17f/0x220
[   59.282842][  T365] Code: 89 c6 e8 d4 b7 0d ff 90 0f 0b 90 90 31 c0 e9 31 ff ff ff 90 48 c7 c7 e0 a0 22 9f 48 89 f2 48 89 c1 4c 89 c6 e8 b2 b7 0d ff 90 <0f> 0b 90 90 31 c0 e9 0f ff ff ff 48 89 f7 48 89 44 24 10 4c 89 44
...
[   59.288812][  T365] Call Trace:
[   59.289056][  T365]  <TASK>
[   59.289224][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
[   59.289546][  T365]  ets_qdisc_change+0xd2b/0x1e80
[   59.289891][  T365]  ? __lock_acquire+0x7e7/0x1be0
[   59.290223][  T365]  ? __pfx_ets_qdisc_change+0x10/0x10
[   59.290546][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
[   59.290898][  T365]  ? __mutex_trylock_common+0xda/0x240
[   59.291228][  T365]  ? __pfx___mutex_trylock_common+0x10/0x10
[   59.291655][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
[   59.291993][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
[   59.292313][  T365]  ? trace_contention_end+0xc8/0x110
[   59.292656][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
[   59.293022][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
[   59.293351][  T365]  tc_modify_qdisc+0x63a/0x1cf0

Fix this by always checking and removing an ets class from the active list
when changing it to strict.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/sched/sch_ets.c?id=ce052b9402e461a9aded599f5b47e76bc727f7de#n663

Fixes: cd9b50adc6bb9 ("net/sched: ets: fix crash when flipping from 'strict' to 'quantum'")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_ets.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index ae46643e596d..306e046276d4 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -664,6 +664,10 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			q->classes[i].deficit = quanta[i];
 		}
 	}
+	for (i = q->nstrict; i < nstrict; i++) {
+		if (cl_is_active(&q->classes[i]))
+			list_del_init(&q->classes[i].alist);
+	}
 	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
 
-- 
2.51.0


