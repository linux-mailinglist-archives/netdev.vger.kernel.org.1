Return-Path: <netdev+bounces-307293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CGovNJ9jVWoqnwAAu9opvQ
	(envelope-from <netdev+bounces-307293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2592F74F759
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:15:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=rFnHVpNR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307293-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307293-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C3C302C14B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EE383305;
	Mon, 13 Jul 2026 22:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677823C4FA
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 22:15:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980955; cv=none; b=eXRRZ1EuKSdMLRK/UdbY7rdbQvwMcSE7VeTXiX/jCXLPNz7RpLJpt3dJsMBzAmletktbRIrxSexTDMrkf99+GySUy5i2eI/mLMOZUzoAFe148BZnd15l+7oc52yfwueF3g84BZ+Zo889wZ0/HqbuPTbbDqHwuEoNPsaKOk87Ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980955; c=relaxed/simple;
	bh=W50T5GS5RhtgQrX1rqdT/yM+AtlTrx/Uz9g0NTLB27s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVPd+nOvZkwO2tZHDpolKjLrNKakzxiX+yba2JbNtBf0KiDg4hmpAJkUvHyziGjD1hhwCrHKb7fv+rmaNWPAFp/Suh+oqAEjTb6ZPEWvcuCHvAlD+wL7bbPuhOnXtQ5GVEJJ8XQhmD4LPP903HIqI6yjWZNH7EKJnDOMbF/c+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=rFnHVpNR; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381ed661712so4195800a91.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783980953; x=1784585753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbraxpj7kQUhZfQBAZU6pBiadDbmkj02vD6BfbHFaKo=;
        b=rFnHVpNRqadlUud7f9mk1Khk2chPvKHczX4WbJj5pVBA54fJhmCQng9yBOFc7KzeEn
         Oq6Bp+5gh8rSsIL07EcHSm1hRyZhv4GvNlp34x+HD2Q30DcVGbhNGE5HK36+dpqVrQTQ
         EbCtiqOeL1C/qIQTMpTJ5XKqUYYmGSP39tUI29EnJRhG+RqN1DZVuCyjWRUZ+wMj3FQ2
         MXy1xxrodxHaNKo716/S/c0VY3PJ9XtY/KbNjrlhP4Kq9kW9PgKOorcUkbm3yuLxHH4c
         Ht2AezJMwOiRi5rRMhDmX/ePC2t2IjCT5XXQXsN1ZvPShk1cNtEKDSYDyuOq8hFWcUIW
         gK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980953; x=1784585753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbraxpj7kQUhZfQBAZU6pBiadDbmkj02vD6BfbHFaKo=;
        b=Frc9ALRttmrCZIl6qIsBYCr5zFJoTk/qBAA0Nh06+AeLb7tIY868YYRhUBlGbA84d6
         o6tWDypaGTMrMdUqjxp9o8ufdHx3yO28Qc3W68+s3owSBWhun5m0jMEiCRVDzlAI5rhi
         C7PlbBSk+PBByMJxZCiYkckytsi9zWuT5+IUMrN2fBIgApqQWZggWpaXSc5r6vWRxajd
         P0PLFhLAnmVbm4BBI/oQhT1aW3fY15NgzHBSZ2hLeKuHwlUet/KxNllCOejiSq220gN5
         k6OIDiILJIYvGSXROtNfA/GwrQ388GGoRdI7GlMrazp2KEsNAXm696WJMZGlrICg8S0v
         HpbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzH1WOkq0xn77Qg7153unHKNG7tQx572mTBOjRjUcwlVH25HvpdzseCJK8vCnAEsQZtkylbKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYtq25OYDf0uHEWCuHJ4xQOPdRZ2eAjn18178n93X3DRYfwAR
	+NWd+j3jYbNlgbe99m8ie/OswktTqQ7Dh69E0QuHk6do71V6bBO8QVH15Q5woKx49w==
X-Gm-Gg: AfdE7clJa+POIJrgN1D1phzP3APqWqWN+TssdF8IXlThms3BMWGwKPNNWDjxS2eIi+1
	yPGANLpkXo7h9T/Qx+RXe0raW68h9L2vO6Qm2fKKD++/gBz7+UZCjAmti5xM8M79aT9fD9xsxQw
	0AshVWrx7jQ1xWBUopIP4z5gbT9UldyOGzDwnh80gzBiFQtf7rUGQpHegGwyaddRlRTHrdZHz0H
	x773xuN+efdigmYK6o1gT6TGwBthmkF8mOq3cMjt872bHcDGnuDdsNDMJORuBYmSKbro8osrKzN
	EgD23FUEU8RnuSPVwwnNIy6uZqQ+8+WgiykGmHEDus7DDJ+wJUYwafFv7lQVlfXUR+ER1YH+rl7
	tXxsUnrxDc6fmkgPsb4R1+oHqYh8/Szc0cqppb/BE+4Edyji5kSoN7ogqHNX1jRZTESumNTLMF4
	2NPcAz4TLAErTLbDVSzQ==
X-Received: by 2002:a17:90b:3c10:b0:381:cef1:11bb with SMTP id 98e67ed59e1d1-38dc774d03fmr10598405a91.22.1783980953360;
        Mon, 13 Jul 2026 15:15:53 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm75300590eec.11.2026.07.13.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:15:53 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] nexthop: initialize extack in nh_res_bucket_migrate()
Date: Mon, 13 Jul 2026 22:15:51 +0000
Message-ID: <20260713221551.3344650-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:petrm@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2592F74F759

nh_res_bucket_migrate() passes an uninitialized netlink_ext_ack to
call_nexthop_res_bucket_notifiers(). When
nh_notifier_res_bucket_info_init() fails (e.g. the kzalloc returns
-ENOMEM), the error is propagated back before any notifier sets
extack._msg, and the error path formats the stale pointer with
pr_err_ratelimited("%s\n", extack._msg). With CONFIG_INIT_STACK_NONE
this dereferences uninitialized stack memory:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: maybe wild-memory-access in range [...]
  RIP: 0010:string (lib/vsprintf.c:730)
   vsnprintf (lib/vsprintf.c:2945)
   _printk (kernel/printk/printk.c:2504)
   nh_res_bucket_migrate (net/ipv4/nexthop.c:1816)
   nh_res_table_upkeep (net/ipv4/nexthop.c:1866)
   rtm_new_nexthop (net/ipv4/nexthop.c:3323)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
   netlink_sendmsg (net/netlink/af_netlink.c:1900)
  Kernel panic - not syncing: Fatal exception

Zero-initialize extack so _msg is NULL on error paths that never set it.

Fixes: 7c37c7e00411 ("nexthop: Implement notifiers for resilient nexthop groups")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv4/nexthop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6205bd57aa85..44fe75004cac 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1788,8 +1788,8 @@ static bool nh_res_bucket_migrate(struct nh_res_table *res_table,
 				  bool notify_nl, bool force)
 {
 	struct nh_res_bucket *bucket = &res_table->nh_buckets[bucket_index];
+	struct netlink_ext_ack extack = {};
 	struct nh_grp_entry *new_nhge;
-	struct netlink_ext_ack extack;
 	int err;
 
 	new_nhge = list_first_entry_or_null(&res_table->uw_nh_entries,
-- 
2.43.0


