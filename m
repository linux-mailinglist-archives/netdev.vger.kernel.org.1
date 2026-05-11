Return-Path: <netdev+bounces-286480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EiAFuSDAWo6cAEAu9opvQ
	(envelope-from <netdev+bounces-286480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:23:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4A50910C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B712300145D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7937A487;
	Mon, 11 May 2026 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4LQ6tg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421CF379EFE
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484194; cv=none; b=P8/BgDEVgSaiQDrIN9OEjbCj7RBAE/mnKmaqGz+s0IuJuIQ4DIXQg+CC7BNW8nv9ZFSAPKXcvRrVRmtR6Fvz3wVIPbJmehPRc2W+mZSgbv/RAf+V8gQdw1kHWANeUqfJbJMV5SKkg/Ku84fnMRPzMEWyZph+n2ZeE93ePwJTFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484194; c=relaxed/simple;
	bh=xUHUA2brW+5Nwqxv9KImUvBUimvFJK4dmUvkhLv2zlA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l9XLgzB6SauNfdnLiinioiNX7GmY029YU20q4OMgEne6S3M7OF850Okld0t4Bq+NYecy2rH7/a99lNMiNfQf1a12RC/7hBjLIAAkdAHfLXHYsvBaBE0J/ykUrakKPg8jH9bzH2503OscTD6sGlbRMElp5PjUD3yuW4ZJHU2iVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4LQ6tg6; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-514a182b90dso17685041cf.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778484192; x=1779088992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlyNPSemsWqYOzbnlrjFxW0A6vhDwmFk32vMhanLoHc=;
        b=e4LQ6tg6T7hQ1putCXOR5MXz2E25qHmFPjwVh1rUHuSCvKrIrA0Cu8/AuVfaRS3Imb
         /L1ICePSu5lqGVUzFR6co5AKeVykOXT577d2N1RwnUrMD4wPQQ+uKXm5fE8I5CvdS6av
         EXud7krEFy1zuAqp6OitkPoKZ2DQwgnlz8c5CYRQ4OHnXW/TMgZDqzfR2PZq94l4+5ik
         W6MyIpiq2Qbr1Fnig+eu/fcuXHxqF0QJzAz289xbyTDCgR5xRcA2eBJpywxQgcthwNbJ
         6oCK00Z/61hbihD2KrGtr1A4mbs/AM37nw2oIj6Jqf1dwIulY9cFafG9rNC4Kov9/93u
         grIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484192; x=1779088992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlyNPSemsWqYOzbnlrjFxW0A6vhDwmFk32vMhanLoHc=;
        b=afw40idNqu8+C5SAuW+S5pWfebtw5wL0VLV22EhJCqKqNsR5qQnrAwTYf2UiSjghNt
         xpGlWsbWdxic5U/nOYQwrsYaw7PQ7DLEgeM2s7nHxYgSf9NMLcWMewfWt7Qe9eg7IWe7
         EMkJE5AMRYbzxlmAx0Kytjo1kcSTSwKn+/wKvdSOzFMoyUMtJreJZ3Pap7VGeYBwlVdJ
         icQNlooK9KCffKSX9CkXCMNQzYMb1bvS70QRLg87S/5l47hrSc6G8Qu5tSZSbZKB67qs
         jm9qtmzTmFfnTr6y0mg4zTAYGMhqYU9sO2hNESrzYzQhElpTmXc4cfe4/d1Ydd0uK5FV
         CGhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tpFRmGPcKYQ3QhrpbNhL3lHKekPnd3MHP6h55sjwaZuQJ6oR4+og8IKDrHrGvExw+ijzYElM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9D+6OnlkFP8Z/5elz07zM0r0dMVQpXHE6sBi8Faf+OLPdRKRn
	a/lkBqVuJbzFOxaeHEJaJ2GLGNpB3yV8Zv1B7gq0VxQ/Y8ve9zoPQKDtEV/dFHHkT22ec4M4eFb
	6DCxkTuZqhrUutQ==
X-Received: from qvad17.prod.google.com ([2002:a0c:f111:0:b0:8c0:95b3:ebef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2613:b0:50d:a8aa:8087 with SMTP id d75a77b69052e-51461f9fc6bmr325864001cf.38.1778484191917;
 Mon, 11 May 2026 00:23:11 -0700 (PDT)
Date: Mon, 11 May 2026 07:23:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511072310.1094859-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] net: use IP_OUTNOROUTES drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1DC4A50910C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286480-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

First patch changes sk_skb_reason_drop() sock to be const.

Second and last patch add SKB_DROP_REASON_IP_OUTNOROUTES
to both tcp_v6_send_response() and inet6_csk_xmit().

Eric Dumazet (3):
  net: constify sk_skb_reason_drop() sock parameter
  tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
  ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()

 include/linux/skbuff.h           | 3 ++-
 include/trace/events/skb.h       | 4 ++--
 net/core/drop_monitor.c          | 6 +++---
 net/core/skbuff.c                | 5 +++--
 net/ipv6/inet6_connection_sock.c | 3 ++-
 net/ipv6/tcp_ipv6.c              | 2 +-
 6 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


