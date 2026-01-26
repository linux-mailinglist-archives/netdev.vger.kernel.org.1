Return-Path: <netdev+bounces-253488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G0iNn1yd2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:56:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A444892C0
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E48E305E317
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4C334C03;
	Mon, 26 Jan 2026 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z896Cdtp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A831F2380
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435458; cv=none; b=b2LO8EqqLy0npMDOTpgRGNdQnmWg0T9ZGYW5w5B925VI8gPo3g1lNJMlngGBTuvifp4m36UHEOoFZwjEvHRxavasuBM48oBcDeoI60dYxD8y5uwYwS9XUBUkVfFJolZcxwjGg0wv5bVHF0tg+CuNLqbgW+ygEOBtjY/rfWoKbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435458; c=relaxed/simple;
	bh=f53timH0np4bz+gztyV/dfAq6Ha3g4qBItMHfYuFoN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpIe70nm+RHwiS+VbJI0Noph+o1FBB9awygeBiS6/MWJLuqVojR8x8g2FDtW+6yzTSbr/fHBNPUTORbVgZjYqCddAT+wJG+AORsSE4z01nZJ1AAhzZY/Gm3HnFsxFIhalZVD7cJnTf9FWx1WTogQnLIkb0hHvX3MYNTFDdaFNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z896Cdtp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6aaf3cd62so580103385a.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769435456; x=1770040256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQxwi2pFUZR+UAlToTQBrAAHIAjqCBSvDHQE8e6QSYI=;
        b=Z896CdtpOPVagWYpaW3ZkjtlZsDBCg2opIPR+XJms3UMQNd3qOb7KXjj61LSp110Sx
         9V/rHLr+O61Ofv51xDoPDDd940XnAkc20xlJpVk8oTjGlYqZuEdSwA28pjkLBzN5YfAp
         zcGPPFGkanNVnBoSIbFVHcVXejUySsHfG4728ow6+dgE5VDB//LuFzDmGpfqbYDCT2Km
         Qnr/1XJyJXp9ePkujuiWX2kDEhejrhcCsBZgyTjlk78MpuXKrLw8SWH3sizps4oUQQpX
         YELNukHAWlMy9XvMIPdDtLHDJclQujtXGCkMladbAFli7aZBxfKXWYxYhBu67d24OpcP
         2l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769435456; x=1770040256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQxwi2pFUZR+UAlToTQBrAAHIAjqCBSvDHQE8e6QSYI=;
        b=wHHjmtYOg0yeoiRAQN58kDTwzcIvoqoTtGbmy3HsA0Kd/tUf0WSpQLo9auhSUNDnXg
         jagZzMcWFGcJ9HZOlqlJpDmNjO2J+6+XBOWVDjWJ6ccVYsgNcnwmPq5unKjrvQU+sM0G
         DlLYktKduhYP3K2bY3bU7rrna3zg64OjXaSQXrz4Mu9Z2V1ep0N+lxpKJFFogdj53vEp
         v79YxxmGvEZhOE5gzG8HoeJF2cor+Veo38/GwxSvljfkn5m8/qQvdQdsiBmPjR1A7QJc
         fEwz4E+3nJ+DQsBoZoLL2KWiWrGPnRBwQswaZpcgKG+4nqZ06TcT5pC0yjBhBpN6OIrK
         e13w==
X-Forwarded-Encrypted: i=1; AJvYcCUYeWwmoNJoSj/vLFO0SivGJF1lTaxLKPFh6Y0kw1c+VGsH9s2MepR7s7D7qnwaHxZvTirCWfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0kEYau6A3RzPht6WViNM9ELre0HEAVLTUQzamwptnirfWQ5+
	dhtFRR10gAZorPFbrXmvDbzCtHQQ1Oa/6CgRXcKMM01D5xtrqJOoJIdA
X-Gm-Gg: AZuq6aIGRt7BUu1hU1plvoWCRwcwmgXYG5BgZVlYn339avIuK+8U4tlM7Eobrzh1OUV
	joc2rHal1tKgwAQTmfoI5ZzBjYaZLN3IRo6I9VtQf5xdM5xpdaKVYcTQHtj12WDx9FhLcZPsi0M
	BUg8uqw+9ms9LjhJ8QToh7pO3jZ9kPIoZWcPMpY/GmCWjR6C3I40oMsQ+Eo9lMyq+VCTIzWfBuZ
	jRSn9COM8mHNu6ufFmFLCo99C6dG+zDmxaUqSSPLlKb1FdSh5obBKLTy+OP9fE0GlMxZx8T1C/Q
	7ZggjQywoWp0pSBnAYzz2fCq0nzbHUEfi7YXGpS6V8euWKTlBbdtvYzc+AxRXZAQ7fAmEJGuBfs
	aErhg3pF49t9DMe2qczlVKvwQA2pNswwyvNTUK58P2rgLhu5y8Gvw3cMJviyNRY6bgvpZsmWzkG
	86jvNzrNaN48yyGMUhDyQ=
X-Received: by 2002:a05:6a00:22d3:b0:81f:4c37:7647 with SMTP id d2e1a72fcca58-823412dbea7mr4104835b3a.68.1769427926560;
        Mon, 26 Jan 2026 03:45:26 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318648dd7sm9086663b3a.3.2026.01.26.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:45:26 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Soham Metha <sohammetha01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kernelxing@tencent.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2] net: skbuff: fix uninitialized memory use in pskb_expand_head()
Date: Mon, 26 Jan 2026 17:13:30 +0530
Message-Id: <20260126114332.23955-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
References: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,iogearbox.net,gmail.com,google.com,linux.dev,fomichev.me,davemloft.net,redhat.com,tencent.com,rbox.co,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-253488-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohammetha01@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 4A444892C0
X-Rspamd-Action: no action

pskb_expand_head() allocates a new skb data buffer using
kmalloc_reserve(), which does not initialize memory. skb helpers may
later copy or move padding bytes from the buffer.

Initialize the newly allocated skb buffer to avoid propagating
uninitialized memory.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---

v2:
- No code changes
- Resent to netdev list
- Added Closes tag
- Added Tested-by tag

 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a56133902c0d..b0f0d3a0310b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2282,6 +2282,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		goto nodata;
+
+	memset(data, 0, size);
+
 	size = SKB_WITH_OVERHEAD(size);
 
 	/* Copy only real data... and, alas, header. This should be
-- 
2.34.1


