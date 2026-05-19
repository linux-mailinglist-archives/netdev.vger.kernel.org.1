Return-Path: <netdev+bounces-289377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePCjKr4zDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:56:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6D57BB2E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 552A33016CBF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C73EFD34;
	Tue, 19 May 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTV8G513"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49520C461
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184571; cv=none; b=MivgJgnGub7bSbEAErpLU8cepam8qbvtcgmmeTcczV6c2LSMWMS5hTW9ak38hObTqr+sQc52xZAsjeMDCF3hbqGJYNy3mWNsXw0gnCpPPAUu3S/x4YvrVsKkRSmPVK6DnvpRvcNq3dIc2eZp8jbvZEFLiZFev7R/4PZmsOuNxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184571; c=relaxed/simple;
	bh=/LQEHTIq6LTFMijbqMPUVwmgIpviSok94r1c4CxGapE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gjqc0XSICFiGSgaqjp1zryUg78fmoPr0cguvGGFMyRLma+s8Z3oDB6rW+eP3zIYbl73BOv6UjKVZQ75Q4CDmMIrDC2Mei3QAlXpW44W2gUKOQlYlEl9zdMctuXVY4DYez0E66wbSWK2L8NaGo/vyqht983ima+hG/DQrfUZnXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTV8G513; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48fde653997so3394005e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779184568; x=1779789368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUceqssW4JcolAy41kY7p6kxMzL22y72v8TwMZQc6vc=;
        b=QTV8G513eBS5UV6HXAA4TQW6YDi7DzjGSL1XRsxyVx60B3mofpt8Cr2z5GaSObA9Sj
         fYllfbvWBA7rxa0KFqS1NEHxxBvmA26kOJhHIpxLSSV36Foim+ki0H6fP1KKDGpTd1UU
         n3y+kPo1pMNb7Z/MlL3fBcxmg0/k/w6mn2kp0t6m22ivTd7p0vFMLw2Bd6z80n7kreVm
         4HaJRMG0lobXehSdc6g0d2598bcHlaMdyjj48OnQMnKW4OFe0TB+E7LL6+zNECfUkxIV
         0ugVbZhFYV5KsrkQe+AOQVuLmOK+QG+PtjAmhjym/j5S4U3ZyvcRB1TJuEQKZwwYTkx4
         r0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184568; x=1779789368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUceqssW4JcolAy41kY7p6kxMzL22y72v8TwMZQc6vc=;
        b=SoI1wvZ35MPpuIoYeOlyqOzt8VcMWDOgHStP2Hz6VxqZoJ7AL+bkDaX72xeg8IIFIC
         gzbj2u74i+Xxr+wpSCekOEd0bPLQLx4+dTLLjUKoHRIE9LComoV+gK+6CF9t7nbEF4mC
         SMtadZ8tlu8ACw9FHcRtXiaOFBLp7+p7YWXoF5MNis5DBffKXdRN3iTkXqPg1f6W0nzU
         d25RqkdlQl62HzETZ2I1gMIQ2bldnC12uANLZz0HiWoydFv/ySsU6tLpEbYtiFpG0wit
         rtSjCsNIOERKzBoB6ZnvpxfJcwemZ3bydIaUt5g3lhaP8+OyzATG617d1M8t5BlvGNfO
         GJmg==
X-Forwarded-Encrypted: i=1; AFNElJ9eb2eltcjMQVF/rQFBGPmSszJbLLd9za+ou4a+6o3Rgr5EYBvsoss+iNAIeQy01wrw7Pme+pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvaaqgd9GbMQPKeGoE26kM2UV/ZcpsMMCwbpK683ZncqlHtuI7
	zhvSSDrYK4d8eEJLRnpbcCG/97AmAWxWgDgyQH/U8TFbblQcCMQi933p
X-Gm-Gg: Acq92OGoMBKT/oqYczxspd2AKu9D+3C4IC3fGDo8qFbQa4V4JGxgmqnqUy+7m7iMOgA
	LRv5g23mcuJbVDd91w4j0F0h+veFyx8u5h69QjXO6g5GVoxtppvDoB6pBTVp66PcONRXtpATN/C
	kOlIV3E5rxrcBp12JQc2uqN66i9+W+ZfFRarwfIp2U3G02Hzm4sAfiZDcXG3pFSYhuUTACp4sBn
	QYqZnvrJ0c5KyM+qnz8aj+2jGUDQJpshZWL7oJrVflhKLERzFx37mCjvY513sPpq0+DAMHYF+D0
	05rCNPOXqeQfWJmwap0XENGN+H2C0VPq+vdY+fbOSNYjicThcZPS6kG/mH+hogmJOglKpyN5Uln
	hB7+LcQP8wmm8EG5lDBXT/PZb/HUSp0xHoydSlYfN0sGwC3oLYTLearEFDEkGOdRWhStxUXHxrw
	NQkW8Wzqvzn4YB9tazJmHue9I299YPm/4vH6GYSFZieE0oCMV4wl2CAVVv7NcXydeQnJ+ZqE7ds
	uAnc7Y=
X-Received: by 2002:a05:600c:1d02:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48fe5ea0842mr170501005e9.0.1779184567548;
        Tue, 19 May 2026 02:56:07 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f213esm142960545e9.1.2026.05.19.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:56:07 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC kmalloc failure in netif_rx_mode_run
Date: Tue, 19 May 2026 02:55:55 -0700
Message-ID: <20260519095557.3749407-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289377-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0EF6D57BB2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netif_rx_mode_run() fires netdev_WARN() when netif_addr_lists_snapshot()
returns non-zero. The only path to a non-zero return is -ENOMEM from
__hw_addr_create() failing its kmalloc(GFP_ATOMIC) -- syzkaller hits it
via failslab, and it can also be reached under real memory pressure.

This is the only allocator-failure site in this file that WARNs.
__hw_addr_create() itself, and every other caller of it in this file
(__hw_addr_add_ex(), dev_uc_add_excl(), dev_uc_add(), dev_mc_add(), ...)
just propagate the -ENOMEM silently. GFP_ATOMIC is a may-fail allocator;
callers are required to handle NULL, so a returned -ENOMEM here is an
expected runtime condition, not an invariant violation.

The miss is self-healing: any subsequent change to dev->uc / dev->mc
(every dev_{uc,mc}_{add,del}, IFF_PROMISC flip, etc.) calls
__dev_set_rx_mode() -> netif_rx_mode_queue(), which re-queues the device
and retries the sync. The only cost of a failed attempt is one stale
rx-mode window until the next update; nothing in the kernel relies on
this attempt succeeding.

Demote to net_err_ratelimited() so the condition stays observable in
dmesg without tripping panic_on_warn.

Reproducer (syzkaller .prog format with setup notes): 
https://pastebin.com/t7AQKx9v

Fixes: 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work")
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/core/dev_addr_lists.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d73fcb0c6..c6fdcac74 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1275,7 +1275,8 @@ static void netif_rx_mode_run(struct net_device *dev)
 		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
 						&uc_ref, &mc_ref);
 		if (err) {
-			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+			net_err_ratelimited("%s: failed to sync uc/mc addresses\n",
+					    netdev_name(dev));
 			netif_addr_unlock_bh(dev);
 			return;
 		}
-- 
2.43.0


