Return-Path: <netdev+bounces-294871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bIMcGFtuIGpl3QAAu9opvQ
	(envelope-from <netdev+bounces-294871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1BB63A6C0
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:11:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=KaDlUFvi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294871-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294871-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33AB3090DAC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D5380FDD;
	Wed,  3 Jun 2026 18:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E20379C27
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:04:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509853; cv=none; b=mC54uqLPIX3+50NncCfPRn2SL4R8eso3MdPk5TNIocpLmntZ3JaX7fqb4rrtDOh1RKd0iAlNX/W5L03QxmO8IveOYEu/y+zU78K/7oIW7gf+Kv7tqbw5GAergxbABoqTlYujneuSHrbFKOlMWa8VR1QHF0PBxFiIIHG88Z3fhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509853; c=relaxed/simple;
	bh=ZgR8OWPikv52PCAGJisqbNIfYHWZl0dOg8fibX517og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ujj4wXQtPVg0W09PgKJjVRbWnhUFO+XeSFAYcSJEUA3GzK06snpvUITHYVL3OpARmWazdErD7Y3+S842ys99QOHV9W03PepgWEQcahz0e51dx7nln2ON7FLoHs11ZYiwtNq+IrEbJJZTpuxR2Jo1zA9WTKmi9cj+dCe0X6R9pXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=KaDlUFvi; arc=none smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccf7b7d188so48848996d6.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780509851; x=1781114651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OJLSpJcAwItE4blXgTc7q6TgMgouOivQcInXyYVhZs=;
        b=KaDlUFviiRbL8CU38a/Zaaqv9y9h8p5H5KkKjX/ywsZNJG/Z6PFurg/flU7U8m3aSO
         ciwWy2/S5jFA1ajyg30wr1RhFJsO8w0Zal2/vY0BhK4Dxl3D6nFxABPhIoC7hBFu53bh
         quHWYFVFLgO9spGzspGbVZnY32BxcZF2hMXnKhvvzmn9PvC/CEiyG+ozb7/FzRY8VF7u
         TRmaR8OV3g9oZYGW0yfVakDsc0mpletpASvvmfQJpzXA7IY8rqNPeiZF9Qy0CTTnvROV
         rc6C1qEk233A3VvaYaQ0h+voIAwuqIt+aTlmyFwFh8/62F4X4Bqwo3EdC0ryKTWRgubx
         5KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509851; x=1781114651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OJLSpJcAwItE4blXgTc7q6TgMgouOivQcInXyYVhZs=;
        b=Qo3/Oe6DB2W3vKNVn0xdwRj+VZZLnre+hbCivkMtsMeAtfUTjp8O5wzrEllNQkF+Bv
         MQhIySL36HuBrYmeKRlfm1thJBM3ZzEsmD8P7XLPvm7jVAAZa35qTlqE7hfa7o7ULPKQ
         9o+oZdPjsNVmEUURPhk41PZEdGaKpfHs1VZ7viImcvu5Y7M8O7BGcVPwZzWVQAhPPlxG
         5hm7JrTKIhsbWI2YUJBaA+jZdbcRI8SzkJBLm/1LaFcuem4Hli66H+8LyANPDuqund6o
         50I6q13dOxbcvWFaXlCoezaBFbGByfxnoTFGDfvMPrtXaq6nV+OxVIcjLpr9TIitmZSV
         QXgg==
X-Forwarded-Encrypted: i=1; AFNElJ9WGOSWcK4bK9XV4Uq9pXPowRkMXwDw2A6WjdLvTyX/mM4zXY5dLnUDzi18fKNDtxDgU1wKqys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yZxHp/3A3NbqTv9OZ2NKIi+54aFfNmZYUIdJuYzP2qsSX2On
	T9/frd/133ZbGyju9j+S179fL8WVXq4/AnJLYLvqvo4m/XfUVXTtH6fO1H96JkTZB/XkRFcchYJ
	is2Q1fwk=
X-Gm-Gg: Acq92OHOiDXyrAj6Iopwzee2ebFgTCqTRz6Wb8n/7Q+UMWMQgJC5mEu7XDSLDtdQZMV
	OYmr5TOitquz8bAOz+AdP9KeN4UdgSsZxFMoi8wo7RY7E/BfIj6FNF3e0Vk9wMeur5TasgPbCV6
	Da3Ir6WTfxgzWAzy5FHV0ZYKWznRYX+Y6wZd+kDQkusiNpkf8Ju8iAipRRZPNHlpDzRHMz2L9rA
	F8nO79IdmrkC5tJdyKyrRTGKmXMStjkOJ0rRkySJ1Am6Pip7BFZeTD1hwQQBsrDv8R8hmIhU0OQ
	lq3pU2g9+EwhHKZwaT1iJ4iPUHZDqU08ksOyhSYGvrBHLZr9yBe6fE2Ong7Np4BUIuFxQDZ7pqD
	x1qYjdfXI9w+UbcuqyOl+PLpLgQrCBA1mqyzZg+1QDXBBvsfeFg5BAQJjBpD9cdyWnsQbLQDuCk
	x7h4GXoYknmJ/dQ6tU4m0GZZlrqyfkOLsgHHtNTQ==
X-Received: by 2002:a05:6214:5904:b0:8cc:f135:52ab with SMTP id 6a1803df08f44-8cece0455efmr65083756d6.39.1780509851067;
        Wed, 03 Jun 2026 11:04:11 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd053032sm27930346d6.24.2026.06.03.11.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 11:04:10 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: act_nat: only rewrite IPv4 packets
Date: Wed,  3 Jun 2026 18:04:06 +0000
Message-ID: <20260603180407.26100-1-sam.moelius@trailofbits.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:mid,trailofbits.com:dkim,trailofbits.com:from_mime,trailofbits.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC1BB63A6C0

act_nat can process packets whose protocol is not IPv4 and then
interpret the payload as an IPv4 header.  Non-IPv4 packets may be
modified based on unrelated bytes at the network header offset.

The action is documented as IPv4 NAT and should leave other protocols
alone.

Check the packet protocol before parsing and rewriting the IPv4 header.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/act_nat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..34d6ba2d4143 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
 
 	noff = skb_network_offset(skb);
+	if (skb_protocol(skb, true) != htons(ETH_P_IP))
+		goto out;
+
 	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
 		goto drop;
 
-- 
2.43.0


