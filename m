Return-Path: <netdev+bounces-254276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIIUGxYaemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE55A299D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2962B300B1A8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE5221DAE;
	Wed, 28 Jan 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbvk2P4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BF1E572F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609743; cv=none; b=rWJypUBy9LsBJBraQWN9t+JvGPVkXS8VRNGl+Gwpw6Ywx94Ib9Zi3gEV5aJajyCqiLG5cJQrSalXyMTITrCT3mFkLPKxyWKCBcFU2BNMmQ236UCsOmkx7gDXt5es4z5FwWRfdU6u9G4FqD2oTRwhZ0Lp+AgGRZznkvMxQWdne7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609743; c=relaxed/simple;
	bh=gKcgG3XT4Lf6N/zBcFjLBA8r/eqPwC9sRVuaU5TeCac=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nNiSqXgsOrEzcxvOIakfd60Y+FWLvbIQTXI2VWpVfupyotSf9xFsr00wNKvYSI6A5XO4j34yG7O25aZW7AgJPj3NymZP8WC9vJce4BcrDcegSrymi6AuxkLCBi4WFLjh1/QfkEhpxVds7Fp3eoT0dNtlI8GXHg7aWoQJu3InC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbvk2P4s; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c5296c7e57so1091745685a.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769609741; x=1770214541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OTvBn8cPeuEiu3n22B1RbD01hVDEbLOUn9gW9IHy0nA=;
        b=sbvk2P4s2sYAuN1UQNesFTkCR75rWcp9I133qc/WNrOPY1Wy0kSCO7jSJZTOu/Bxu0
         kffUYClWAM7Ztlt7YOc7ChkiHxShCv0O1O+wlQyfW0homNL+NhEf+Jw7WAJps5sOmBf4
         97MfRQmZbuL3xYS0Px0gL+77vw5GYwNaE/RNvVCeQkwXDc40URaYpvkDnpC6dQZu6pFe
         vnppXl5LA9JC+SCStZfHse3mtGVlOALOhO6AAAouzEg67691xLP/udCCPd2BqrvkOTY/
         eaC16OlCKDyvNQFIpGjZSHOqmcxiyL1K+cj5wMvoTpdlRH/FWN39qwVEjKbTILHLjVJU
         u3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769609741; x=1770214541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTvBn8cPeuEiu3n22B1RbD01hVDEbLOUn9gW9IHy0nA=;
        b=SLKLsi6rrXb2axjV5TJsZ7turwMqQmneyTAwtaGMEJ7bu7SkWWcWrpgTSeI11Zwp1h
         Z8Zimm/Wu9JXn3QUQszkplbPECnqG/+CxdtMypRA4m6h7h8mDQqm7JTSh8BuGHKTFxw6
         51Rn5B02OEjLkOX+8cPn9zr422KANZcvaRqrqHugVXyJ/wEJumV/NYulj3o1EGvi0OE0
         fcQ4ewP81tAtSQQuOeyAPPMl/gPZelloCNNYwQ54RoucUVvl1d7d8TwrmroDey2p5fk7
         ZJABWzAFZXlBa+ZP1Tn3334qFqQxI5EobqblfrBH1Ej9qkiUGEZC/csQ03I0pVVhF0gQ
         Q+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4XecaCi9Mw9rkPSWjnLaSM5y7AN3MkX5MLDcDNJKAKqoAz337Cc5SGpCTv2N/FA3dPKw0WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGfs+MHohOAbV4PuIfvGrwh+hoc3FxtZIK/dyHjQ+vXQqKRAf
	Hk2x+Gs/5V6wqVMbc95weyhaRzc9TjBcrauRj7DvCmp6CBrIpVknVQQaB8/uHP1UiDypWC0qaAn
	MwKoOlHR10pDKMA==
X-Received: from qkap8.prod.google.com ([2002:a05:620a:a908:b0:8b2:eb2c:2ed2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f10:b0:8c5:2b63:2d1d with SMTP id af79cd13be357-8c70b91480cmr634460985a.73.1769609741111;
 Wed, 28 Jan 2026 06:15:41 -0800 (PST)
Date: Wed, 28 Jan 2026 14:15:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260128141539.3404400-1-edumazet@google.com>
Subject: [PATCH v2 net 0/2] net: fix potential crash in net/sched/cls_u32.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, GangMin Kim <km.kim1503@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EE55A299D
X-Rspamd-Action: no action

GangMin Kim provided a report and a repro fooling u32_classify().

Add skb_header_pointer_careful() variant of skb_header_pointer()
and use it in net/sched/cls_u32.c.

Later we can also use it in net/sched/act_pedit.c

Eric Dumazet (2):
  net: add skb_header_pointer_careful() helper
  net/sched: cls_u32: use skb_header_pointer_careful()

 include/linux/skbuff.h | 12 ++++++++++++
 net/sched/cls_u32.c    | 13 ++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


