Return-Path: <netdev+bounces-287748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CXlFZcLBWo1RwIAu9opvQ
	(envelope-from <netdev+bounces-287748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:39:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36D53C13B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4E3E300BEB7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756133CCFBD;
	Wed, 13 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTdYvx5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C5399354
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715536; cv=none; b=bAefj3O5BOSF4P/2/MSxRkTc//p3YK4UYYL2lqzRAkGymHY//cn4fz1Moh6G/ajV9dHl95OfsJh3AcpXLmzTZGZLtZWavWwNacl72vdSVe2yFMtrsCS7gq5NwQCyBfNYSfbxkmWN9wxdpbWztV9XEbyZbUNUopcnrZxxp846jMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715536; c=relaxed/simple;
	bh=oBAEVZATeASbH0nhe5drMl+9AytTIzOltLbIrseS608=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gps7bdPBVqKPCp/lSd9cJ+OZNij/MJbamx42YsJR1VhJLjldPFVh5xyysb4KmQDo9Jx3kEFa+gFfmrixsaab9bcD3/J7ZlUauOEc30ARy2pZJIKBcjMGLDYaiqyANaKbE++H15R3Egb7ln3MYhpzzAa91z4RpBr2H7J/eh3PkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTdYvx5M; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90caad2e944so308128585a.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715534; x=1779320334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tPQGmLtEe0WJuWlk4o1gxSupMduAnwXuzQSwzyxZi4M=;
        b=pTdYvx5MO4zbPeh/PcIK5Gh1pZTloEHd+8KGbwCGZJj5Vopexg0esPVevrd7hZ3ens
         FBRnqm/cFBM77WHWpAvTsbuxe8G73LNFOuE8cS5wlrkgpkp7UhpfiKeYu+G3+fLKRPvY
         M+9uwmmfhBqnZbTBAXqLMd6CI8BbkvwOay11E8vabUCnUga8GczhJSMWiL7ZAbsAxGWN
         t5syL1QGav+fokBHNbx825t8KNxMD4mZ3+J0S3BB4mMWbo9pYfUeiYrph+Er+OzPvBz6
         b9B/IfWlkEF80jgrvJgyDU76QmC2jhLgE5nrrMNbdke81ELQH9U+LNSlDsuezWxXI7cz
         +nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715534; x=1779320334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPQGmLtEe0WJuWlk4o1gxSupMduAnwXuzQSwzyxZi4M=;
        b=OYN/drJXLIsfD8xCwTiDd092nsJL99i86SmsaovJff5WxowbRVl6MalRT2otMH+0cL
         Ssb2n5lonL6IXz3RHUw0/fjC+VhXrEDMzBlKiLM075Wq66lanNucXYIxQODHJdLqsFhl
         p1b98DpmERVHMb2I6wvebTvd961HJq48qUOg7Sn/BLVXAYvXsS0Tb/yKKp3omvyHz7ZY
         hdktGY5SmIc06wB6emq8WOVfzNd0XJUdWrWKYrx04luGaknCKbct2gkBz/FSyZLUSPOc
         od1s6aMibT9KMqliqs3j4OHUdb9vXp50UsUUPFYfYMi7ASsJwCzOE4DABz8QQw8AcBAB
         mkag==
X-Forwarded-Encrypted: i=1; AFNElJ8QxE7OWPoywz1KRXILvUNd7gdykvMBi2e3n+lFyRJKQ+W4ZaJ4ONPhB1c6EF7aWorTJjE0uU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21fPEIbRi002Djtzf5y0UFa7prDZwJz4AE1Sa1R8f8bi7GLQG
	HS5dI9UQfoJneN4jvyOBzaS2mN+1UlD7rR484DED9WowverjnACgbART
X-Gm-Gg: Acq92OE/ybvOQ4rIjl5IluuVBKM7sxzlX2mrMS/es75Cz545Q4BDEJYtzF6a75aH2mi
	yfMLHxdYlI5sU876pwdQ1ECmtx7B8NMgFHqpqhVMkV/dd/+1R0jlTAC4acXtUkI34qTwV2KHO6K
	s6RoJT6P0FWcnYOZ8jna9zjq2BgwTXGyb2YKGopOJneVwQzvWp1WJBFZgL6Z1WDXp58hbI2fz/r
	2xaMShnPALjC99XI0vcR6YovkYJelE7ZBQSA+RU57sE5zqWuLTCIl+B0I7UkZ8mFvndJPxT1/g1
	7odAk6ruhPbKL8Opxm+1nh5zNTYCmdNwd9RaMJ0WQkjUJ+2PtTZ5D1BncJKrWyk/yTVk5uy4ibw
	CHxtEzH0sqIDwCbAwoqqKagtzn1d6pk/IOL9RaMqrPddUDV1CwrLdhCiKQ2hu5dfKj1dK868SW+
	XKBdSCHhTstBcoiVdHrVUuDXCzQbUoXG3EScdVFP7ptdUZKxsGNyFZ28u4LUBZRV6dUOVXah7Xg
	YxF+ndpiZs74+RO4Pyykg/LyAOxGsPn+PqYQc86qVg=
X-Received: by 2002:a05:620a:1a1a:b0:8e4:ebbb:b162 with SMTP id af79cd13be357-90fab222fedmr756739285a.9.1778715533884;
        Wed, 13 May 2026 16:38:53 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm94186085a.20.2026.05.13.16.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:38:53 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luka Gejak <luka.gejak@linux.dev>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/1] net: hsr: fix node-table UAF on device teardown
Date: Wed, 13 May 2026 19:38:37 -0400
Message-ID: <20260513233838.3064715-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D36D53C13B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,linutronix.de,linux.dev,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287748-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

HSR generic-netlink node-list/status readers walk hsr->node_db under
rcu_read_lock(), but RTM_DELLINK teardown frees the same node table
immediately via plain list_del() + kfree(). A reader that has already
obtained a struct hsr_node can race hsr_dellink() and dereference
freed node memory.

The patch below uses list_del_rcu() and the existing
hsr_free_node_rcu() callback in hsr_del_nodes(). The HSR prune paths
already use this lifetime rule for the same node_db.

Reproduction.

  The natural reader window between hsr_get_next_node() acquiring
  a node and ether_addr_copy() consuming it is short, so I widened
  it with a temporary udelay() in hsr_get_next_node() and
  hsr_get_node_data() (debug-only, not in this submission). Under
  x86_64 KVM with KASAN, an in-netns RTM_NEWLINK / parallel-readers
  / RTM_DELLINK loop then produces:

    BUG: KASAN: slab-use-after-free in hsr_get_next_node+0x1db/0x350
    Read of size 6 at addr ffff888009e6f290 by task hsr_genl_spam/...
    Freed by task ip:
      hsr_del_nodes+0x144/0x250
      hsr_dellink+0x6c/0x90
      rtnl_dellink+...

  The reader walks node_db under rcu_read_lock() while hsr_dellink()
  -> hsr_del_nodes() removes and immediately frees the entries.

  Without the artificial widening the race is still real but the
  observable window is ns-to-us scale, which is presumably why
  syzbot has not flagged it in the open. The fix is the same
  either way: honour the RCU lifetime that the prune paths
  already use.

Testing.

  - net/hsr/hsr_framereg.o builds clean on an x86_64 KASAN config.
  - With the widening patch applied on top of this fix, 50 rounds
    of the RTM_NEWLINK / parallel-readers / RTM_DELLINK harness
    run KASAN-silent. The same harness fires the splat above on
    the unpatched tree in the first round.
  - Without the widening, 100 rounds of the same harness in
    list-readers mode run clean on the patched kernel.
  - tools/testing/selftests/net/hsr/{hsr_ping,prp_ping,hsr_redbox}.sh
    -4 all pass on both stock and patched kernels, diff-clean.
  - scripts/checkpatch.pl --strict is clean.

A separate status-path NULL deref in hsr_get_node_data() shows up
when the same harness runs with status readers and the widening
patch. That predates this fix and is not addressed here; I will
send it as its own patch once the primitive is characterised.

This targets net and carries a stable tag back to the dellink
cleanup commit b9a1e627405d.

Michael Bommarito (1):
  net: hsr: defer node table free until after RCU readers

 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 8d90b09e6741f5103ccc81a53bf2391ea09419a7
--
2.53.0


