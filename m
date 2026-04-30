Return-Path: <netdev+bounces-282905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKOMNMB182nJ4AEAu9opvQ
	(envelope-from <netdev+bounces-282905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D24A4D0D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 582543030758
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743030F533;
	Thu, 30 Apr 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="Gz3tE79F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3831327D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563038; cv=none; b=tLrBe1F8MSqflEjFElyGHb6vjGEc4Hl2ijy//oSfZ5cyr9npmbn6Fu2tPXhHHCO0avYBbNHzk6nmKmz8N8y/6mr1NhA6qcWw+jB+pGLwUK77oAAMDiC8gUZNBVPm3AZrTYNeHou/k70neH2A+pzjqwVermrL7SNGre34DT42qM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563038; c=relaxed/simple;
	bh=xXnQsjtqGxKOM8NZxDlpP6YJlvkaUbX9991pUA+OdbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxT6IyhB/tt+A/yjAMX7O6Jl8pTvQphqmzuQYAhdAFZO8vfqW8d85RcFzPcAPWhBDWliXw4rLBLJ9lM73ool3kIjTT9BgQnh9nNJm/iY9g7OHe5edHWpFIXhvOFSZBepN9dHRvQu5NZrBKbYeo7PgU1P5pqRhXoA1z0U+wBxtuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=Gz3tE79F; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d933da14f0so110109085a.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777563035; x=1778167835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXTJvAOfvRa7NNwLaGmrCktIbRSgY5DJNwPRo6G8z14=;
        b=Gz3tE79FZAnMGac2Ijn/V12fIBvovLbaPmbZ0ot70v7Zm+fGD3yejkOZNFJdi8cL6/
         orRzXjJKh9EY8gsWaw0lVARDk/FXXS6NnWypL6Ca7P6rEuvrdKuAcS+cdr3yEKM43vG+
         ZZmiGeTfc6xW0lphCLXztvnG7kzWk3ZWOZFC7r9VKh9hxAEiAbw684Xmz4NG63CLccCv
         8wHRNixg4zozW96b6lgc9CDdRsCtRLN8wEbdIVRNXrOoKDXuAYmH8n4xZ8hIWV2tU+X7
         YqCo+3dQofkgxmeOILA26BSaYuM19XghoTU2bc81BfcrZQSGxVtqnozlTXUpnoW4UEtB
         QywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563035; x=1778167835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXTJvAOfvRa7NNwLaGmrCktIbRSgY5DJNwPRo6G8z14=;
        b=QW7SmshYbNul0CbqUG8Z+nfHz52ogi3QbhSEaFeP93kQYoQwhZWxwiKfPUfpKPNyhp
         KaFUKwwzZaRnGjsHela251wf5rFrtWYn/aMgJ8XEXCZ3F0ss4U8aFVQ6WMTWlIwGGUrg
         +9VCIagZq4zpxcWl8j9bRrV2VWdIelJxgXZGwIOTJL1fgeVhoagkoYCdbp96oqOEmlp+
         cNfoQagp4H65Tan21QA+43m5qjNvdkjMcK2mRE1fSAnQzA7mNxpp9g7Mkhd7oV5cTNL1
         bzHopPyDLhml9DhrxnvFAOYfd/veIJvigVQXclXIZGfb+WcEmtvWTUMXjrIaiDdiGB36
         qomg==
X-Gm-Message-State: AOJu0YyQ9pV3wyP/lpru7w8QbuDH4ONXoVqenkj26l5ek63pt0b7Y0IC
	58hGu5EeTAYEMNlkS33fbJzKHGW17YIuIL4wQOhlWa4TglkuDDN+BlWeRuJdh0YrqyI5S14Erpt
	VYNc=
X-Gm-Gg: AeBDievxFe57n9Yn1a8jOp4QTdhwhge7PQ1pYkrm1uoNxU59hSqORyw/QlbGHMbPDM3
	F8VeOLS02mwaWxAMJ5sBngeq4i7584KwJxZl4lyGunkchIcWUfjV0tueEVpOOAVcPnIKxJeGtfM
	VSJNFOZzlJsc6YOMafevg3JH9q2/darsaZVGjycM96qvj+EtqTd0PuAZjVyJrBrMpVSb6zYboHd
	z/vnsMAhP1U43u17wy4+OGw3tMQr2JP6J24ZUbgcMovJzrV9gUR+lanakKRfEpN5QOwD7SFkz8S
	w3kj2cVNkt+MQu9wgngN1DmkK1d1g6AJv5Buph1aYWRr7zUuqk52Z90EzV3rMn52nhjIqSkc538
	X6L2zC0d8w5CsGj+fGWFWDQ/Gm7gdOTXQFAwt/B9Bm4fe0TyWsUXIQNozb9DpTva8KVbk8UGsye
	FGP7RpEZxb16Vr1076jfPLsCrf2FZySmGapL4mqQ==
X-Received: by 2002:ac8:7f42:0:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-5102aaebfb4mr48264681cf.7.1777563029617;
        Thu, 30 Apr 2026 08:30:29 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b398312sm876591cf.10.2026.04.30.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:30:28 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	ghandatmanas@gmail.com,
	rakshitawasthi17@gmail.com,
	security@kernel.org
Subject: [PATCH net 0/3] Replace direct dequeue call with qdisc_dequeue_peeked
Date: Thu, 30 Apr 2026 11:29:54 -0400
Message-Id: <20260430152957.194015-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 552D24A4D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282905-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:mid]


When sfb and red qdiscs have children (eg qfq qdisc) whose peek() callback is
qdisc_peek_dequeued(), we could get a kernel panic. When the parent of such
qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
its child (red/sfb in this case), it will do the following:
 1a. do a peek() - and when sensing there's an skb the child can offer, then
     - the child in this case(red/sfb) calls its child's (qfq) peek.
        qfq does the right thing and will return the gso_skb queue packet.
        Note: if there wasnt a gso_skb entry then qfq will store it there.
 1b. invoke a dequeue() on the child (red/sfb). And herein lies the problem.
     - red/sfb will call the child's dequeue() which will essentially just
       try to grab something of qfq's queue.

The right thing to do in #1b is to grab the skb off gso_skb queue.
This patchset fixes that issue by changing #1b to use qdisc_dequeue_peeked()
method instead.

Patch 1 fixes the issue for red qdisc. Patch 2 fixes it for sfb.
Patch 3 adds testcases for the two setups.

Jamal Hadi Salim (2):
  net/sched: sch_red: Replace direct dequeue call with peek and
    qdisc_dequeue_peeked
  net/sched: sch_sfb: Replace direct dequeue call with peek and
    qdisc_dequeue_peeked

Victor Nogueira (1):
  selftests/tc-testing: Add tests that force red and sfb to dequeue from
    child's gso_skb

 net/sched/sch_red.c                           |   2 +-
 net/sched/sch_sfb.c                           |   2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 148 ++++++++++++++++++
 3 files changed, 150 insertions(+), 2 deletions(-)

-- 
2.34.1


