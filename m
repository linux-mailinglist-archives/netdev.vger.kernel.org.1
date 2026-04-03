Return-Path: <netdev+bounces-275246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BLVMxc80GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:15:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6153398B2A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C378C3004D8D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7826E6E1;
	Fri,  3 Apr 2026 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6G/3uZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A217DFE7
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254545; cv=none; b=RIX5kwzliy8splu5bzfEOtz2HdaNvqnF5tMNJ7AXGLTgbzneJ9ZEWYF28baCAF/1mFiQfnW2qCDTu5mYgOvXE0IrJf6/mpa35mnoHQWhaFJ+x4+dXTjAK6TEBVWhaWHqggLXIGkaqV7gVC0u/TCF+ylqpBuT8XcJKbaOdC3Zu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254545; c=relaxed/simple;
	bh=0udAjhnFYU4afdYUsRv8vgycMgT15YXMglute6d9rFw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YdFbkZZZyIClAaxpLti4vchpIHAH0jVLPGqpSk7XfGa4LoeLGIfvcU9Z3OmzZGAkePj1o2H7p5Uxmlc21XNsx5rrpaMdSEdHHDgSCIHWS3vsKmDxA7wbwKzM8jvD1pDiHe2p6HCig3p3SARkTZB22TN9TyWrjHmOF5pIDZlCPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6G/3uZ+; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so53706231cf.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775254543; x=1775859343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qH1ekF0/VZm9yHWr2xkmhdl6ZGFesDysg+5EoJKMA4U=;
        b=F6G/3uZ+e3R9TVeYAmJ6wqmO49eMsBruGFGDk3VOx08HZlKO0SBP1Dq+hh3KztYuJv
         DErDHvc2CGnTKRuyP63KmMi4Bc2llaWZc4ZhNFl1i7Sjqr47ZrcaJeFpDCv/V11CYtn6
         rUYSPtv/QBVI7R0x9IfOpeGbcZ02YS/8rpi1UmoUBIxsVmVviV8GzUws5dgT8SQC3CLp
         pzDo/wtWmlhkQAiE74fG6Jf5dySd/iwWn1a4QG8YXtoOf7jAOQKJCitFQYq8tzGqj2MB
         rDe8gSMuMLJBtAaIM6K+RWIY61qeOFWI7T4hJwOqt4fl6pbo0yHUycCbz0Bf2LBTtZ3P
         Y12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775254543; x=1775859343;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qH1ekF0/VZm9yHWr2xkmhdl6ZGFesDysg+5EoJKMA4U=;
        b=QJehsAYQs+GCc2r2CHJX+GJYx5moaLjZ1DqCJjHr/rIt7/lX+zcV+KqwpE9ri3au7k
         gTpmqURWIXscwrqKM11Hot7b19+hEHratFQaGqJ0/nHKnFzhXWBeh2fX2Vl7p0jQBG8Z
         knh4S5SDf+Va45WCOoU5tS6Pfq2kiMsDnbGrii2PbRnW2wwTVrMowFAvSwBoCSMAtnJ4
         RC3nQM/Nt6fwyZnxYdPoZfYTt93zysJihUlwJRQDeJO2p3z4Glg38dC/0KL+RPa6C79A
         EDa1++zXMxF6fOUyu5vbQTSar+wKqRVz2VdqflzZ0rRjuvOMpnFAPAyBZS7zG65QLNs2
         1R9w==
X-Forwarded-Encrypted: i=1; AJvYcCV3FfWxPQH4zVZxx2tKI+mNy3kRJENKfVZ3bLs81WMTr7quCzKPbOwgizGsKkTmAAcpt9coyEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GjrX6hZyVupLHXaAgGtPX3zHjzGCm6IAhpnPHFom2YUnKCv2
	4jMVw8wmQzDvt2Okxhui0kQ3RQIJRkXbwUa1MrR8M7rRZJ+zB6bLahPjewfxLvEMTVXmwEf3xQ/
	AuylKKb98/qO6aQ==
X-Received: from qtnp22.prod.google.com ([2002:ac8:4616:0:b0:50b:8918:6af4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:574a:0:b0:50b:4d80:ccbf with SMTP id d75a77b69052e-50d62b4e641mr74088961cf.21.1775254542254;
 Fri, 03 Apr 2026 15:15:42 -0700 (PDT)
Date: Fri,  3 Apr 2026 22:15:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403221540.3297753-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: pull gso packet headers in core stack
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275246-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6153398B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most ndo_start_xmit() methods expects headers of gso packets
to be already in skb->head.

net/core/tso.c users are particularly at risk, because tso_build_hdr()
does a memcpy(hdr, skb->data, hdr_len);

qdisc_pkt_len_segs_init() already does a dissection of gso packets.

Use pskb_may_pull() instead of skb_header_pointer() to make
sure drivers do not have to reimplement this.

First patch is a small cleanup to ease second patch review.

Eric Dumazet (2):
  net: qdisc_pkt_len_segs_init() cleanup
  net: pull headers in qdisc_pkt_len_segs_init()

 include/net/dropreason-core.h |  3 ++
 net/core/dev.c                | 81 ++++++++++++++++++++---------------
 2 files changed, 49 insertions(+), 35 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


