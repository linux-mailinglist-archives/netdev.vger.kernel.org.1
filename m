Return-Path: <netdev+bounces-287470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IWZCAAyBGqNFQIAu9opvQ
	(envelope-from <netdev+bounces-287470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F252F5BD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9255530C3EE2
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840A37267B;
	Wed, 13 May 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4TREOrm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE39379C3D
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659737; cv=none; b=ksTbXg79Qekzih6SANIFhAwIjsIlseq4Rgb9hA4ssrpE5mEgeRdi6kx0QB+3ReWEk7kdcaYdnUqv7VE2R3Ssld3LCTMZeg7075U83N03iAP7AptK+mC0II1a2KFSt3mIfbf9p5yDneg6530bAV/Ogn3kygrrp1sRaDirGjGeWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659737; c=relaxed/simple;
	bh=JeUALF1HDkHbxXrbHi14Hwve2cnPOQi1TZn94xYHXOQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EtDts8bHLCTxu0CdvmLN//xL7IrTMmhUwBoM4uLMz72rIe4p6cuHIwBz2usXFEM/FoYaoYFw177myPKKZAWoX+9vcVB5L0gFRrJYK3Bcn9ucDYwoY/C9m/2WcXd/CdH3MVvQI0dAeROugFQFhpZl8C8FW8ZhnKYJ6I3Wz8rbfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4TREOrm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7bd8cb261c3so128675227b3.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778659735; x=1779264535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUhuferwgCUQM+E2sqqF+Tsw2i8EUmhQl7CppcOQzcM=;
        b=u4TREOrm45e5wAaQ+uJTd0P0+rqmeipDwKbsedT8qF0KQwwtkKGjePqu7QdR9TemaN
         sFiZsnOpcrPHXn8wjo3FhUbqcNAkkVZCuX163x2imHn9f/Igl0dc7rL34STU709lGa5s
         kX3+Ew88RjjkYyOa2IuOMnlzTKi8Hw/aRfhBYoqtCcxzY0IjT9IOCGL2bF9pAlSXqFzl
         QOGx52m8j7dj4pbdd+aLp6PsT5pRJORv5jL72XySrgCTdAmcMujEX3BpIBqvpISYxJwC
         xaLVo7EHWsBFXZsI/iBnvqRHtJBKUAiC6QPhNl716t5RBsiaLw5Y0MsJWWKbYoUO7o3r
         GA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659735; x=1779264535;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUhuferwgCUQM+E2sqqF+Tsw2i8EUmhQl7CppcOQzcM=;
        b=Ui6FpoypX4zxAidg2tpkPzUtjCKnLLQN3UZmPmaZPRjXAqCVu8Qv28wO2avdEssJLM
         pC2s1AiW9Efpbp9dQZpL+Jx3TjsZ8wxuAe8GXb6rWgNDxvGvv4BCg3MpBc2IN5FSF4vS
         ZWF0xBa/ftZfr47hV2337M5l/s/Gk3Ia/sNvuvl1eOFyvxRMHbfdP1ljhRde3Isbzj5C
         cn2ibWIEol+7GPMuqgwjsMeOlqE3iffhgSEnS9AMflImx6RLwngJD3OEEnBQw/3bSgpd
         4AteFD3hMRKNLeeE1YeebOBoiAWjmk97SPYrJncMUtcARDtC3hfMG94CczVZEVmz41wI
         FQ0A==
X-Forwarded-Encrypted: i=1; AFNElJ86BR5eXf3xiUTeY2JKdn8Ru50FZklpPFQLks+IfDskjYWALj/J29LfV3ezKMIPeVISVkKu3i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweM5PKRSkAiSKv6TakkKJ6rbsUha0vvwuslsIVBqYP0giZVpDa
	aFRRvrhBJBf/EJg1+3vCvqT5dnbjGbYGClMqZK7gVKBWKITOxJdhag6zdzO9LZ7ip0hmbY/jcfx
	RmUc9ArUTxRmP2Q==
X-Received: from yxuk1.prod.google.com ([2002:a53:cdc1:0:b0:651:be12:1fda])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:d054:0:10b0:654:1261:8b4a with SMTP id 956f58d0204a3-65df80e3456mr1269416d50.3.1778659735256;
 Wed, 13 May 2026 01:08:55 -0700 (PDT)
Date: Wed, 13 May 2026 08:08:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513080853.1383975-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net/sched: changes around qdisc_qstats_qlen_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2A1F252F5BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287470-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,nvidia.com,toke.dk,vger.kernel.org,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

First patch makes clear qdisc_qstats_qlen_backlog() runs locklessly.

Second patch changes ioam6 to not acquire qdisc spinlock anymore.

Third pach adds missing READ_ONCE()/WRITE_ONCE() annotations in hfsc.

htb still needs fixes, I will take care of them separately.

Eric Dumazet (3):
  net/sched: qdisc_qstats_qlen_backlog() runs locklessly
  net: ioam6: no longer acquire qdisc spinlock while calling
    qdisc_qstats_qlen_backlog()
  net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()

 include/net/sch_generic.h |  6 +++---
 net/ipv6/ioam6.c          |  4 +---
 net/sched/sch_hfsc.c      | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 17 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


