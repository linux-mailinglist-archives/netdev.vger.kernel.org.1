Return-Path: <netdev+bounces-289366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G9rACc0DGo5ZwUAu9opvQ
	(envelope-from <netdev+bounces-289366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:57:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FE57BBDE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E9BE3148E01
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D71477E24;
	Tue, 19 May 2026 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jzr1wbJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FF47886E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183982; cv=none; b=AR6iE+z+keLR2EQD2bZUMmTkLdCUHSEwRo784uepBjrlC2aVVxaVofJGaXlHxiAljQ4gcnOMTLF1qqa/jrMBGqRO49KLa5Pbd+8pLIYxj3XFec8BTYCF40dIjM7C6EDvWez1qCFFioXkw7cakQpMHr0PnDdIcygvyTv/Jkpibyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183982; c=relaxed/simple;
	bh=LWbN8zNdoO0XYiKgo/f0nDuS/3FSoGzKuXA9aNp4TSk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B6CYej4l4jJCJqsABNQNIEXltc2FGXzOAHzCGiwy1jaNS2c/F3qWtVMSPLxPYLwCSyrVCbXABzgSEW2f9pj/bW2vdB78DZLfYQc7ncpAIamfbzqcYVe7jMecPp5QbGTEL+IYyLSxMIiEmGl0BUbaI1Unncm+60Aloz+Vyl8yOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jzr1wbJQ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9112b2755abso903222285a.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779183980; x=1779788780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ck0nioZIpXfDeqaJmryEQdE/4o5C/f9MbjAkvgRDk8=;
        b=Jzr1wbJQHc9uk7xU8XVUnWUsmkG68VfFGfwb764Bl7VXnlYW2EqZrj/HvMWyChSq1J
         2GXU1CWoqMtUABTT1qAxhGOvySE/SxXvTkLfsURNEJFW8jqc53Q2Qlo5yaM0ZZsy5HTm
         1GX3yHlo5by8HCvhe8+hL1VSgvRiXDnGCByBQ6pIsr/VNydDBKk6Nmvc3LzmZi0+RnNt
         R75WQ6zG+r74MlM/5ynI68AfXiSkksfCT4e2w2waphiQlM38E8L41ZsDmuNk7t13Xy0v
         IH+4q84MCk/+B7w3OaOfd09bs78dhqQkcynOifgoVMBJsAFzonnxMls3zK6Dtg7B+jAX
         jdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183980; x=1779788780;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ck0nioZIpXfDeqaJmryEQdE/4o5C/f9MbjAkvgRDk8=;
        b=Gz6WTqLV2gFOjH6x0nBWTtr6EI+qnJGdm+WTiamOC8ufDR8NYSWFYChrPSZHN0WNQP
         DHmws42gD7FGN4ML/0kt/cYWcoskUhRcZWkG8ptXALUL4o/xAHdUGjuhYpWbHB04WyYe
         h5Frb4D5qmrbmiPmEXKV1csK9d8o45Bm40nncOvWlmVWnbvDLryVLX7jA3GhDFdcZ7vw
         v5NMr7PqnsvE9k47qdKFOOGCFfKDRbqg0dBioMtKXs+5wgFf1r+iD9dUmLrY1h09zffR
         HylS8L33wHM+sKicmbZZGJ9UBUynEqWjGgALk5vxUp3MoiesXIl3rhYyo1f0oFnqcalT
         ZrfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7jSPzHzXr+JSMBq31BVwqEY+Eix0coGoecDyej6qTUQSdu/Ncn0at7VIh0RUW6mg4nY0GL+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDNAqdL26UdLlgJLOITWFatwZ4y3EjQKlihs8KL5iNcPtDDVH
	aKPf7Hk+AxCUiIqHEYY/AXLxssjlZVJiUiL4f9VFm5CFeGU+IguR4LfiPHuxYKXkAhi555ARr97
	aNUOH6PuAoG5BOg==
X-Received: from qkaq25.prod.google.com ([2002:a05:620a:aa19:b0:913:351:9730])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a0c:b0:8f8:7765:27da with SMTP id af79cd13be357-911cec0ece3mr2497073385a.42.1779183979535;
 Tue, 19 May 2026 02:46:19 -0700 (PDT)
Date: Tue, 19 May 2026 09:46:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519094618.2632073-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net/sched: sch_drr: lockless cl->deficit and cl->quantum
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289366-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 719FE57BBDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

First patch adds missing annotations around cl->deficit.

Second patch makes cl->quantum lockless, to prepare
future lockless qdisc dumps.

Eric Dumazet (2):
  net/sched: sch_drr: annotate data-races around cl->deficit
  net/sched: sch_drr: make cl->quantum lockless

 net/sched/sch_drr.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


