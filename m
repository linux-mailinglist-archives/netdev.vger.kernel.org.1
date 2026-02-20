Return-Path: <netdev+bounces-259698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNmhBTlBmGneDwMAu9opvQ
	(envelope-from <netdev+bounces-259698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:10:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F31672B1
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849803015471
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA3341654;
	Fri, 20 Feb 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="nwlE0XfE"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60515340A41
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585825; cv=none; b=Hurso0ANps8YNsM7G5VTEKDMd1OXrjtAFHS+tVo9ABKm0+JMqDZ2aZjnbk7YghGtebJloWOqo+HDDw24O/yE247ofo4ksFk672jUbnPloJl2zHVXL6y6Bi5odQGpkYVwS4p5mSJZZt+oNTUTf/2VX2Mz16raRK37KRfcwoHDF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585825; c=relaxed/simple;
	bh=9Vd/vU2OOT5YdMAIsfa4uj1uXtxEkk9tOj+MqX6QAzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cE/XYc1UUUJGx1U55blxMVCSv0ULlEYIg0GNZV16A2okOAjKg0OZrJ5e8OWCj3BKYNQz0uVQ3eUGmOBALRqljCcv4QTvLm4Xo8HpV0ObEL2JuSXOxksa8mX9Rr5ud3JnPIsFdU6Ox5fpZfrwtn/Ah+7rg1CmocLyLvt541WOiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=nwlE0XfE; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (54.52.30.125.dy.iij4u.or.jp [125.30.52.54])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61KB9NnI040209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Feb 2026 20:09:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=wTepkiaRF/hdxZuhpHfCAhj6kmf4sZflDY7X5BlhPCE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771585766; v=1;
        b=nwlE0XfEmpGymRX1tpzxeqddRsbvAqyLC+cIR4WrUGW4MNbAJPs1ixw/1u3ziYEu
         UvHsjQBMr+LMKg+XJcFLRg5hsdGM06H4dTGqxC/YipLP8ytQBaeydQQMw1FTEqRg
         SFs5ntTbkhk1zprf8VPpkk9yMAb6PF5dvz0fYlqaviruHjoKqP1qB1qSIbXIUqxV
         9nX7rKSHhWilw33mRwm+E0ohvYMV2+wxhjAUlxyyzS24h/h4kRJu/5K2wHWVg47s
         zBYCTcp1lS0KkmaJ8BexgWtSrqTAtjEmCeklT6tu5AtSFv0zcAkR7vNIsIMo+l2+
         hPfrZjZ4wCFz7/NJXDFVDQ==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 bpf-next] net: core: allow netdev_upper_get_next_dev_rcu from bh context
Date: Fri, 20 Feb 2026 11:09:17 +0000
Message-ID: <20260220110922.94781-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-259698-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: 6E3F31672B1
X-Rspamd-Action: no action

Since XDP programs are called from a NAPI poll context, the RCU
reference liveness is ensured by local_bh_disable().

Commit aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master
device") started to call netdev_upper_get_next_dev_rcu() from this
context, but missed adding rcu_read_lock_bh_held() as a condition to the
RCU checks.
While both bh_disabled and rcu_read_lock() provide RCU protection,
lockdep complains since the check condition is insufficient [1].

Add rcu_read_lock_bh_held() as condition to help lockdep to understand
the dereference is safe, in the same way as commit 694cea395fde ("bpf:
Allow RCU-protected lookups to happen from bh context").

[1]
 WARNING: net/core/dev.c:8099 at netdev_upper_get_next_dev_rcu+0x96/0xd0, CPU#0: swapper/0/0
 ...
 RIP: 0010:netdev_upper_get_next_dev_rcu+0x96/0xd0
 ...
  <IRQ>
  dev_map_enqueue_multi+0x411/0x970
  xdp_do_redirect+0xdf2/0x1030
  __igc_xdp_run_prog+0x6a0/0xc80
  igc_poll+0x34b0/0x70b0
  __napi_poll.constprop.0+0x98/0x490
  net_rx_action+0x8f2/0xfa0
  handle_softirqs+0x1c7/0x710
  __irq_exit_rcu+0xb1/0xf0
  irq_exit_rcu+0x9/0x20
  common_interrupt+0x7f/0x90
  </IRQ>

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..b99d46b682c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8103,7 +8103,8 @@ struct net_device *netdev_upper_get_next_dev_rcu(struct net_device *dev,
 {
 	struct netdev_adjacent *upper;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_rtnl_is_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held() &&
+		     !lockdep_rtnl_is_held());
 
 	upper = list_entry_rcu((*iter)->next, struct netdev_adjacent, list);
 
-- 
2.51.0


