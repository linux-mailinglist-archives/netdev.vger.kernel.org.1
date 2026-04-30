Return-Path: <netdev+bounces-282666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNL7B7jz8mnNvwEAu9opvQ
	(envelope-from <netdev+bounces-282666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:16:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772549DF55
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 881A93009837
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A50D3750AD;
	Thu, 30 Apr 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5PU/zya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993632FA30
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529778; cv=none; b=aessC4WL5v/5TmeZxayi80FJNUEZFKj27A4YsGjv2Coa68Tj+QhAQr2cE3iyIzGeZ2Q4kAltPLLxuJ+dogty08stFWXhCZK2pHLgXWKskmWdSGowjlv8iPtcDQu+7KnI2yPrvP1K5kcWA85g2d5hc/p6HA+zuQLicYBqSHaHQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529778; c=relaxed/simple;
	bh=Xu8xfjitNvHnqvxUQgLTE0f1DJGNESJYdcu5LKgWrls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hD3QnrERAbOSLRA42Ei0hfBksfAWsjzwWfFeCShTlu3UaTa0wloUCgZ5OQ3i1hoWmTLN2Prm1xOM98CCwOHjvIeqR8/N2z98Vv0ugViyrVgatOysA7bbDV50kLuOcw8oR63/APaRqqt23g+aI3CnpbGqehM99pQl8ZNUES2KZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5PU/zya; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8d60fca52b9so99681385a.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777529776; x=1778134576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mdbPbD25SGaxgkBE9cwJGS/J7wrlSgs49NnHZvaKOt8=;
        b=G5PU/zya4ayRrzVySr3UjbpVjKcqL9m6UspSqop7HnlCBj+K1pV9nJ0T70ej61fiof
         QTUT3G0vuexfFVa7iLMFw1BJw4hmIfRWPUD39mmCEcSLr1veRvq5Z+jzVbPfQ+04nm8E
         Tirem5yjH4ley2Urv9WVXutoo/S3INMNMHFIP0PFXu84ZgdwcjnFlIpLzj53iYEGXh4+
         9TKLsPKRA7HonVyNNlXVg+sYXkgzDdDHndJX1ZGKBfnqiuWmfUskMvetGLvRGc73suZn
         rt3YCAYFLPUE1mrrWf706xnNbuVaOcGzo3G8aITvYgKkegTLDFJDaVC7hyXM3eU64l8W
         EDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529776; x=1778134576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdbPbD25SGaxgkBE9cwJGS/J7wrlSgs49NnHZvaKOt8=;
        b=OC7rZwRdLEbnWCiEIVA9t/bupaMbFwabYlXlLX6TOTdbkzPVJljiKGqSs937PIdWfa
         fNMCWVRMU0mfa8j2oei86/PurnsUin22eH3LpQsbTkFQRAo3dh+dYpitG6A5IK5G9oBa
         bBe13iT0YkfKIbjC6RSuPuVyrXc1m5CSPpLUD3JgjT/mc7C/eVbdXYZRenPS12FkKXxX
         YWv0+GNW4zcFn7eAHwOfAFPYHtoVrhuvr8yhfnyS0UKGzbG13zluShv+UdlrVm3xwH3I
         kep0lEE7WyriGs13GJ7875Ak/80wfINuiQfNarSSj5v6Yjo9RaEX1i32Y0QkHIISRHst
         ZyeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4+Q1JE5+E/gbh9WqDefb6u28IS+YCCyLk+0U+CoW2v6cNHG6lPUu/VVvewRb8+v/e9EYsgUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VIHqzlfneuCQERJf1g8q9mx6BCeHkWzBxIDGRy9K1aVhFSRG
	tvy+M+638izbN01FJu7C9I88LEtY3C4gKK99NOT/6E7xHUeiFIwFThfg487cLM+zLZ87eH1Fe6K
	xM2OgT0cy/3uUtg==
X-Received: from qkbc11.prod.google.com ([2002:a05:620a:31cb:b0:8eb:d5a2:d399])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:319f:b0:8f3:dc9b:1758 with SMTP id af79cd13be357-8faafd04da0mr167917485a.17.1777529775884;
 Wed, 29 Apr 2026 23:16:15 -0700 (PDT)
Date: Thu, 30 Apr 2026 06:16:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430061610.3503483-1-edumazet@google.com>
Subject: [PATCH net 0/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (series)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0772549DF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,toke.dk,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282666-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

cake_dump_class_stats() runs without qdisc spinlock being held.

In this series (of two), I add READ_ONCE()/WRITE_ONCE() annotations for:

- flow->head
- flow->dropped
- b->backlogs[]
- flow->deficit
- flow->cvars.dropping
- flow->cvars.count
- flow->cvars.p_drop
- flow->cvars.blue_timer
- flow->cvars.drop_next

Eric Dumazet (2):
  net/sched: sch_cake: annotate data-races in cake_dump_class_stats (I)
  net/sched: sch_cake: annotate data-races in cake_dump_class_stats (II)

 net/sched/sch_cake.c | 155 +++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 72 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


