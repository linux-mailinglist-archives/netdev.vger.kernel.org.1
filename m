Return-Path: <netdev+bounces-284688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBSYJse8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:00:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CB4D60AB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E891D3004434
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A62E8B6B;
	Wed,  6 May 2026 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaO5VaFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFB2D837C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039997; cv=none; b=i3k90pc2YlcZU8QKhUX+5vyDdy8fgFY2NbgKsScwfA5K7TrNiEjSjde+7rmmOBfQ+UtiFXbyuLKa7yBNoqrtWtFVXTkba5tJXzODJPT8iz9dhZABE77LoJlsgIlZD8x+snI70afHcVavhGk5ZIR2LGB0Xpri+gimhuY4MD186ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039997; c=relaxed/simple;
	bh=IpiWDaNs+J7u30XR4VdvnzCTVFdpUQ9OaGc8w2kffzk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rKjteRqcHyrtKsw1xd2QAPTgMs46ICjKv3NX0i7dPZK9mVioGK/sfZLBa5PYXZ5IRJqEAowMxFqvv5ZJr+v46Zi7VJsrjJV3hcRy3iTEYxl0B4j5Ze6F8WY75RCVfwtzdlihUkjVPJd6bf/q9bJQMGg7qZ7w46VGCQnbD/TsE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaO5VaFW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso5373236a91.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 20:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778039996; x=1778644796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qYslFs1h13jEE5KHxuzG6+JGzfMuPYoycKnsRCLyiE=;
        b=LaO5VaFW0tm3BHNRNkKMFRTqt9CdoOliK9D7hwBKzNItPLfSlfgOk1hfe+FD1yI458
         KeTZk9tg1vKz27be0MQi5Xklg3zdbXXLIZO7pmK05OK5xDyYV9WiMpQ3ylR/6qOE9DiS
         9awFrkJ2+tsgwccEmX0Cp1hDKoT0BfpBgEnmIxlu2WVsU4FCQVtsMKbJQGTdTeOxRoMn
         M1en+/T6Ya885UewFVxl2/LOCIy0ELqOa4FH4GXGVFhaLLudI/OfhkbZsu+EgUN942DZ
         FD7szThJpwGVSsLWsRhAfbtf0MjjN1/4LpfBiXSAXBgJMSfZHeGJVBo5HrQf/l4niNzX
         yZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778039996; x=1778644796;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qYslFs1h13jEE5KHxuzG6+JGzfMuPYoycKnsRCLyiE=;
        b=JpUPzbeuvWMh/fd7hBQMwawCC3pXsuG5uqfaq0k5tjGQ3Yd9xwHtEHk0vF9lOvADe0
         A2my5GUkEdYfkZwg5Dns/MVIWHOZyoitmg+0eXIrhV11Rc1VkVGXKo40qON8tsYZzd4S
         dtUHP0/31B3KqGxoMTKY9AKQcSwRHbmMF4J3/mIGxLE9LEk5Hrj51ZLoCd2cjkSO4V2J
         TeqVJCLKZwquZM6EgM8nsV6zICFl56iR0VAz50GE62c0DYby0wbWBDwQ2kn/J2tfEzBO
         Zrv7YUvb0k8Xj8ukeoK4PTHUEzYWTNzrRuVKYA9tV7fr2o/7Um/rOMQSdTCMmisgwnmV
         9NBw==
X-Forwarded-Encrypted: i=1; AFNElJ/hyBR0V/YP79TB/M7T062lptNFX8yTcg0//LzKrxKYyf8/PbTlugwzdIxOmeoQe77iJ2wwa4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo74H6FR6aGQ/HeeEHyxqqPNoYwNRIxDP99O5V16YI7LFlEtcZ
	T9Z3spXbPCp/B5wqGX2Jo4aNM/MHNeO4NCZurB+/uZWgtmSiUjmY95FDqP8l3XaMTL/6DAkAyXe
	C2niIQA==
X-Received: from pjbms5.prod.google.com ([2002:a17:90b:2345:b0:364:dca8:e4f6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134e:b0:354:a57c:65db
 with SMTP id 98e67ed59e1d1-365ac487ca5mr1524780a91.20.1778039995945; Tue, 05
 May 2026 20:59:55 -0700 (PDT)
Date: Wed,  6 May 2026 03:59:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506035954.1563147-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] tcp: Two fixes for socket migration in reqsk_timer_handler().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 989CB4D60AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284688-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The series fixes two bugs in the error path of socket migration
in reqsk_timer_handler().

Patch 1 fixes a potential UAF in reqsk_timer_handler().

Patch 2 fixes imbalanced icsk_accept_queue count.


Kuniyuki Iwashima (2):
  tcp: Fix potential UAF in reqsk_timer_handler().
  tcp: Fix imbalanced icsk_accept_queue count.

 net/ipv4/inet_connection_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


