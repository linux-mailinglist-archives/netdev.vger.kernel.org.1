Return-Path: <netdev+bounces-280696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB68Am316WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DA2450C31
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3143A3092D8C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C914377EB0;
	Thu, 23 Apr 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHVb4WzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC737BE96
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939809; cv=none; b=kOraHbYLzRdZ4wZ1BIqD16Ydmgircl1eQvvIPd5+RldlUTNTWdG2SM9nPxP4mGRTOff+StOw0EXvNJLPWIWn+653SpMtIYX7kxGAWgNqWzXcG7aIQTO1xqdBlOjTwWEzU8Vfr08DHi91CAwnac5h9Jz58V19Dr2eR8uZSaDHceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939809; c=relaxed/simple;
	bh=29rcjNac10PUyYtkCiBmUhksWSjWoWNlvdOKwOWo6Tc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QrmSRVF5IVaIGu3m2uOS++FwLnR6x6BUp8DwEMBkoM6dRFodHBP5UYMSvCpcves3R9+94eLq0E8eqdKMq0Hq1rZlu8tstBI8u9AUnyq4WTjnxclYfA8xF2AM2pUC1IeFCIqmZWFrIuOy1vE+NPUUqq/UHVNBssrh3N+PcVjBd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHVb4WzV; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8eb04352924so827072785a.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776939806; x=1777544606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cHcptBePs9DOyVUVRjip5Ys00nk35NmlpdujziJhkIY=;
        b=BHVb4WzV5SrtsXm3z2WeKS0E971fkXIhV1vM6xGFf4PvUinnAn5jsGJ+SNnnteKBW+
         HvqhQYgU1VrYY/5Du+3lEkimks1WaTMA3ckLTv/h0DJ4jobPxTIIKDu+TlHYQWbMUruF
         V4g2scEK+3z2T9fgF7Gh0SQcdfv8JnQQKfMWAqJ4+bnsuX26F2jnnXYiYTwXVKjZIoSb
         kirhjm8FNdRbj18+ByW4MSarboA9WvMIDZjOEOdeRHMo6wzWTTV9/YlmFJ1uibVL7Kkx
         FkepGFU1k1LhohN1+SxIK5c7abiv3PwM4pIWjhE0TEiYNHkiCnwLfNLp8QeqzyBsdlcv
         bGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939806; x=1777544606;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHcptBePs9DOyVUVRjip5Ys00nk35NmlpdujziJhkIY=;
        b=DWYLJsYJvspVmUCMPhdB9vryS0RGfB2i/GHkQMyJ1mh1f5q7tUZE1P99/UPDvhXUqi
         /qgLZz9yGASjoM2Qizp+q5NYVcDNTl2prwvKQBJ8j6g2zE2XLWr8VZXNZvUheR+DOWWM
         Do9fmph30gCIB2/PJyF808E4ynktGicH2Bz7QC7XkyA9YfcSF+bPDehn1yShDpCj3QK+
         kMrg2XYJJJINqX+WfTQN8WUxC0xlGTL+45H2NpISQqQmtnO5EXsgZxLefQFv3UOWKXPv
         yz/uxB/U0OyVeYsQdGnmS7ISKkgVfKt9gYGEANH6WN6aX4tZ2J7W+3KjosbqbbptGDNg
         zv6A==
X-Forwarded-Encrypted: i=1; AFNElJ/Uyph2P6NsD8bsfbJkitXuLO61Q3rvZ4KNNalqurMUPkVx6FYmU/8BmTby6dArer2s63YByu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOjQ4F5+13zPaSklgU+m7PWbK5uq+YIPfz61KyuEMV9cQzaQW
	qs4D3tPqMc5gS3Uj8FGqws1FNr9Txn84fStRfTE5xOF9WKdD6Liv27CWtMeFSEu4hkPJlBwY/Co
	rD5O3iMb+4dcMRg==
X-Received: from qknva10.prod.google.com ([2002:a05:620a:3f8a:b0:8cd:a797:cd5f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a21:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8e78fd21ba0mr3494475385a.21.1776939806229;
 Thu, 23 Apr 2026 03:23:26 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:23:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423102324.3172448-1-edumazet@google.com>
Subject: [PATCH net 0/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (series)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280696-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59DA2450C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cake_dump_stats() runs without qdisc spinlock being held.

This mini series adds missing READ_ONCE()/WRITE_ONCE() annotations.

Original patch was too big, splitting it eases code review.

Eric Dumazet (5):
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (I)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (II)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (IV)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)

 net/sched/sch_cake.c | 217 ++++++++++++++++++++++---------------------
 1 file changed, 113 insertions(+), 104 deletions(-)

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


