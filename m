Return-Path: <netdev+bounces-306985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 59vwD5EQVGpzhgMAu9opvQ
	(envelope-from <netdev+bounces-306985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B67461B2
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:09:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=Eg3Dj51p;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306985-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306985-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 757D03012CCD
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319137A846;
	Sun, 12 Jul 2026 22:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C037205D
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 22:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894148; cv=none; b=AmjKC3BpRAZ2kyv3t6YQAk3GytYvm/CF+t9Nmb1mIKem2GOiHB7L0chJZkKtDO9lv/L8VEZcAu7Yf6wjMhL0f7nojnhQ0sV3eK5tQACnzGTA+m9Vk55tw+m91+N7QA65lcxZfRy6qMj8xA9SDe+DrCOqor7o8uuhFMFhggUYefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894148; c=relaxed/simple;
	bh=ya0YwKNn5tL15JftmzZoYB2lGcBnSqSdBe1mSe09vP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqy9QGZfRGiRLN3c93rCUbrRqZIodXudC4GS3Qj6pk9TlcGzrS7c3/RqZgMRTfLkrEqbmFWE+r9bwt9DPlLjv/iKfoWzol4FFYOcl3GeDzAxENVgDWDrBG4Bb5noOQUB2Me+re8qQvq/sZfG8Tr//KEVkTP6RP2I3M9dU635UqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Eg3Dj51p; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca24023edso29867345ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783894146; x=1784498946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZtdvHMChIDL+dYOQDIFLigXmiDjoDs/HmzFXJgyvP8=;
        b=Eg3Dj51phmOx/hBaypr7IONdmAEJdmjfu6dDJXnj9xiS88DDQyLCWS0SJ3lAhELcBe
         Yi+CZrApan5MmEBBmw2rof4/HhiPBplvsn7PbSi/gyZO2m7P02miVKuXOwM45ZwA1bvt
         d6nLhAKUSp+oxUeAaLkCfBt4hAtO9iR4tCks/vjvq1QnH6ZLzx6/Ja41+4da6io00F72
         1EsvzWLzTIsDxL5/kEf6oZZS1Oh2Rm0d00LMqG53H4ac/ctUdT+5SQxzXYTBqGTYmFYm
         tnwu8s+DB+lrir7AngMq9OIqRrlk4CghfDtf8YpVCSmPl477SL4ufQUxyE6a2I9wOxP3
         MM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894146; x=1784498946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZtdvHMChIDL+dYOQDIFLigXmiDjoDs/HmzFXJgyvP8=;
        b=cZUpn9Kj9fp+PLZsipfjeVl8itFFqyx3ZrTspiZ10VKd2+k7PsCBQxR9ThkduAbrwX
         POze+lqLxBe+e1w23bzlpLwkk/dqop/63h8QvaJCNiIFB+6vaqh25skxW9u/GURlkpIq
         fw6DqeMC2VWrHq7RC0t7kRickga9mFeTmm3Y/KWPg2EB/IiZteWWkwS/ZXrruJLwoXM2
         wcgYn0+W5hl1uIuGL0GxAfkskE4Q44gK/dxJ1jsZ6crDVXE4FbOFTWzq2JTNTCvGTwcW
         +3S1xPMqUbYoPW+RhPZEVDxe2+K5N2hqZPHgvQsDns1eOVxllIyy8ITGtDLZiPzXmDK5
         TfAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6v2tWgc4Q9Lswdyeq4s31QXk6OxKApqUUEH6UaFjP2mDe8LZKcUNN5yJnnn5yiiLUDo7tiWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybY+rPIFcfkewrDlM8R1FFnSa75jvnnXGinuPdp4vDBBjRU88+
	hLm/W0y5/k9cGKryHFJQATxsg7jMV7qWKZqQrfcO0BLGc6P7puQ7S2BWMJN+2ioYBw==
X-Gm-Gg: AfdE7cny9z4LdLplaH54tooDXWC2vZbn2MLL/d1/25Pqhx4ucpGysXppCmPscl6L8bp
	HMdiO0dmltnzekR5dkEFOfrFpOLQ5iJSRvyv97b0UBXOkPYLXVrNafk+IAqOMhHu59vgYJP6tz4
	paiKfzxJtsDS3ji/pHNL63DP+NCRNOnmujsKkeXB2msDAhiXm1bCd7Hs2kx7z2uWz2mYLGOII1B
	L7yTKI6RvwBIEinT+71/QaplzyEWwN819cFnWj1D9wGE+VhgVSXuhM54rodebzLOxtjVxrsqMTg
	lOMDnqbxKdxPASHFa60HLSF4z3I24k3AMm7OmKP9vwBG50nZ3r/yBnf1T1z94fQZHArfUabY1VG
	o6Wpr2sUTgt+nGtU7ppjZ5SNpbYzZZEObtRUfUPxHic6I5KoiJ8ruwlCQajCYaC4QeboYEpuh
X-Received: by 2002:a17:902:fd84:b0:2cc:5fae:cc5a with SMTP id d9443c01a7336-2ce9f188707mr65291085ad.46.1783894146108;
        Sun, 12 Jul 2026 15:09:06 -0700 (PDT)
Received: from p1.. ([2607:fb90:eca4:601:96a2:dc03:fbca:601e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdddsm88368665ad.77.2026.07.12.15.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:09:05 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n
Date: Sun, 12 Jul 2026 15:09:03 -0700
Message-ID: <20260712220903.3131568-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306985-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A94B67461B2

On CONFIG_INET=n, mpls_valid_fib_dump_req()'s local strict-check loop
enters the RTA_OIF arm on the index alone and calls nla_get_u32(tb[i]).
Since nlmsg_parse_deprecated_strict() leaves tb[i] NULL for any omitted
attribute, a dump without RTA_OIF dereferences NULL and oopses.

Skip unset attributes before dispatching on the index, mirroring
ip_valid_fib_dump_req().

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:mpls_valid_fib_dump_req (net/mpls/af_mpls.c:2189)
  Call Trace:
   mpls_dump_routes (net/mpls/af_mpls.c:2236)
   netlink_dump (net/netlink/af_netlink.c:2331)
   __netlink_dump_start (net/netlink/af_netlink.c:2446)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7041)
   netlink_rcv_skb (net/netlink/af_netlink.c:2556)
   netlink_unicast (net/netlink/af_netlink.c:1345)
   netlink_sendmsg (net/netlink/af_netlink.c:1900)
   __sock_sendmsg (net/socket.c:790)
   ____sys_sendmsg (net/socket.c:2684)
   ___sys_sendmsg (net/socket.c:2738)
   __sys_sendmsg (net/socket.c:2770)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception

Fixes: 196cfebf8972 ("net/mpls: Handle kernel side filtering of route dumps")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/mpls/af_mpls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ca504d9626cf..1ad07df89d5b 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2185,13 +2185,16 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	for (i = 0; i <= RTA_MAX; ++i) {
 		int ifindex;
 
+		if (!tb[i])
+			continue;
+
 		if (i == RTA_OIF) {
 			ifindex = nla_get_u32(tb[i]);
 			filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
 				return -ENODEV;
 			filter->filter_set = 1;
-		} else if (tb[i]) {
+		} else {
 			NL_SET_ERR_MSG_MOD(extack, "Unsupported attribute in dump request");
 			return -EINVAL;
 		}
-- 
2.43.0


