Return-Path: <netdev+bounces-259899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNYXCQRem2nyygMAu9opvQ
	(envelope-from <netdev+bounces-259899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:50:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DE17037A
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B05FF3008D07
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D234FF47;
	Sun, 22 Feb 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYTM06BN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC81D7995
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771789820; cv=none; b=IU54NlTHlFlS+Q4qhrpFWthCUodeX94TSdLHUT6+/PQquTVuiu0d9vwTZd3TW0HELK3fdQvMJOxQ63rkKV9ncUnIiP9Ap2IAJxA0Yf+s2edx1E8Z0RUtCYnERpM2WOeYvxxeDSOFzApdisEVmxfnzz+uAJq2jul0+6jFl2SyfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771789820; c=relaxed/simple;
	bh=vZPP+usAxUazkVJzf3sQ09C954MywnBEdDeMvIqyMZQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tXkywZ87/zkLqt9E58MCdGGarE9nMk9J3Cu7r6XHQ9HPar7Lcb3vC4jfMEt44O7PkYuxW/2XhEXO++Jh1IHq6SmrRN4Ll5S1x4l+PmCyAsqAvFty32UW+CI1rgQE9Hyein1JMzBh5B1yArqmWsMrg4lUi7M6jaU8g/Vj15wm9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYTM06BN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad5fec176so37427635ad.2
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771789819; x=1772394619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3HY9jhYz1kJpttQ+I5SbT1PG8uffXRBId8CK5jGo45o=;
        b=aYTM06BNh0a4BBNLPe0BCZ92/GDkAXrieMycm/cpOr3E7pMLIaqcmLKCIFpop86u6b
         qZMk8DRfzlDRxHSZQdGYdhh5PAVHSKAXGCEaHOxGO86fKZAzRljWttx/YhNfAM7KBV4g
         uQjMiAC5GqHrQbVHlcu2nlFstOTI5/WAZGvvM9+VPfAfej++oZ1rumBP7tIaf7ocKMU4
         indRzEPW2aOCMmXcBN1POQhlzNd4rmp3JpBN1Ytn9cG1eXGO0tutSMp4mW/lAxqK+jeT
         LAezRXoGlXbLs1/wASfG+0WIKUXUJVR4faA3J4HZAjCazWMTCsY+q+wtR/fkPiFSaFKk
         /ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771789819; x=1772394619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HY9jhYz1kJpttQ+I5SbT1PG8uffXRBId8CK5jGo45o=;
        b=VPhY6TqndskjksBtlHdkozHbjTSxZQkuF8friGxQxq5iIoLIDaVcBr0+PifIluogNR
         +U8t7vzlbywprS4efzeWB2X+FyAenT4RU4ULyKEQtm9UpEO5hpjrce6HEwzblmPl+BoU
         W9sdIk5/jeJ/k0u9lkdJTmanG6x6GI+2lbptxoWBKlOr+AGUwOR13mYjNOZgtZCuVL2E
         TeCOZmLdNKwizz08/UmICO4irxll2JScME31lK5d3bFS0CA1bUu69erV0snBRxMDNmhx
         uobRrgifEjeXQDFv3tF3lZDlDjl2zJYDyspCIm1tiVHxIN1rkaAJiUaCkDy9Qp2sOGak
         Q1pw==
X-Forwarded-Encrypted: i=1; AJvYcCUwspCXDBgFGlfRiiRmWHHJjGoq4yzwMZgYslIRDtFCjHYJ6gEomCJCtFxsHpZ+7Z4SICjbcBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7Vy8xAaXpXHgsz4a9A9TcQotJMCHo+X1jgiCnjtLr6IfWEUP
	C/P4ug6bOJ28iws0QXlyPV5YMM5thl5hbOKhkPgx0CMf/BNRtJXnkfAbZ5pEgfIVw0PwLpS+u55
	Df2S/Zw==
X-Received: from pjxx5.prod.google.com ([2002:a17:90b:58c5:b0:354:c506:5ac1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b30:b0:2aa:de6a:8b29
 with SMTP id d9443c01a7336-2ad74418ba5mr52582035ad.4.1771789819099; Sun, 22
 Feb 2026 11:50:19 -0800 (PST)
Date: Sun, 22 Feb 2026 19:50:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260222195016.705157-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] ipmr/ip6mr: Fix mr_mfc.unres.unresolved corruption.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259899-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 321DE17037A
X-Rspamd-Action: no action

ipmr_cache_resolve() / ip6mr_cache_resolve() dequeues
skb from mr_mfc.unres.unresolved with no protection.

Patch 1 / 2 replace __skb_dequeue() with skb_dequeue()
in ipmr_cache_resolve() / ip6mr_cache_resolve().


Kuniyuki Iwashima (2):
  ipmr: Fix mr_mfc.unres.unresolved corruption in ipmr_cache_resolve().
  ip6mr: Fix mr_mfc.unres.unresolved corruption in 
    ip6mr_cache_resolve().

 net/ipv4/ipmr.c  | 2 +-
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0.371.g1d285c8824-goog


