Return-Path: <netdev+bounces-290707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P5MABELEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D065B0385
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07643307FB38
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC2339280C;
	Fri, 22 May 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rehJ8qjm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394D399039
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435975; cv=none; b=nxJ7CpANft/oe/iDxCarDu1gqgp9Dy3/398iFMTb4RLBJrJmGgSd7i2NxDspM9X+RS/InHwgzoLa0N04JirUmFYayqV1OOUYOZs2SL1TQq25ZEMw8DG8qaWjCyYwURD+hU8dYqHPkuRw9GItflcZgQ7A2W6RblcERqBImtoRXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435975; c=relaxed/simple;
	bh=grAO0EilKOi6iyT1ZeTbGIzISWBZn3LwNPHiK1w6ePU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+Qvz4vgf32qi8+Ez8o3lbC2GTwJJZhxAkagLyu95UQNBF5v7ObBQUopJ+UEwGctHmIvBiWJ2/tZutMkSBfijWNFhJi6R393Y9HLH6e12S8P+zgf8/g1NOn/XtBqq/PpD0pNvkYfoOa+DFc5o7iFkRl5sq3usJ9HGX59OL+r2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rehJ8qjm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36629e48023so6686428a91.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435972; x=1780040772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDwte1/PKSE4DPAbIkeOnlnE4IdttbSjV5cNN6/hCak=;
        b=rehJ8qjmfGPTZiXqX9GJEI+5SZrH4L6s5vFjFdGNQkaVAT7lpiLzOJM3QlrMT/RzX0
         bbx35otVhja8trHGFUd2I2J3db95cG2MDmp7KrU0IXQddvByCjDDmaqXOQxZgPxGqYD1
         B7u5wXA64MFwEjQw4wG3C5d8p3QmzoreH3N7UUsevaZSFIvZMHwRlAJdICb25Xzr5dZE
         NeF8jturEh1MpsjAzMH2u3nRHqk+2XbCuG+8yTsLWhM1lcaGxuHPHFA8DuTnlv8HUR+l
         wh32DsPdS0Iuar/osMNep/+FwW5mwJYwqPCw2R8Obv2AD6h46yGiBhcvZ01kubiqhooD
         8/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435972; x=1780040772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDwte1/PKSE4DPAbIkeOnlnE4IdttbSjV5cNN6/hCak=;
        b=GRfgG7zKf2VctpNWXOczzvDeJPQTgER3HqdrJ5vq8BuZi+TZRypJhUkFtYDLyYWsGy
         zQsei0vQaAJ6U0hUH+50IvUO6g9tI4b1rUakHQ3VEV/UItMki2fTyG5x+kQLKhhQkVjS
         rOT2S4A9AfDz7E1SG4+p/L9rI9eTaJDBSt5L9zvu+uReWLxDe/tYB/yqMPPIQqVkyJpA
         B8sOkINOx9+VWSf5Ye86Mkss6FvmdnP1pDbcTa1tmGvAfIiddMfqFS/1Sj6WrzRMdzmH
         NzOytlP1knraPHtgQqH6uVNCjtpxHk0sQjwGZ3ouOt5bE3bAYldn0TtJ+x2IT5rzOOCa
         Ltsg==
X-Forwarded-Encrypted: i=1; AFNElJ9hPtoRGEXxBgsbLNorjx1MkUMeOE6D939CaSCLqfiYaVFsoIcv/apX9TQAnnWFAq8cUT0V8bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMg0zld3jko+uqeXaOHEtGPXPxy4VJc8cTxjrUJssp1F38Y7Jv
	kgnaBbCKDU3pJPMPHwrDSCJ6ywI2y9/zDJS2/ob9j7dBB0RJMVnYWrTtG/W8TARc8woAewo3MJG
	Xb2busw==
X-Received: from pgjd23.prod.google.com ([2002:a63:d657:0:b0:c80:2656:4e70])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a97:b0:3a2:7ef4:81df
 with SMTP id adf61e73a8af0-3b328e256ddmr2491394637.26.1779435971483; Fri, 22
 May 2026 00:46:11 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:58 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-8-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 07/11] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290707-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.880];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 64D065B0385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat().

We should not allow calling __tcp_set_rcvlowat() for MPTCP subflows.

Let's disable BPF_SOCK_OPS_RCVQ_CB for MPTCP for now.

If needed in the future, bpf_sock_ops_tcp_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ff7fd415486a..5913b3be9f1d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5392,6 +5392,9 @@ static int bpf_sock_ops_check_rcvq_cb(struct sock *sk, int val)
 #endif
 		if (not_tcp_prot)
 			return -EBUSY;
+
+		if (unlikely(sk_is_mptcp(sk)))
+			return -EOPNOTSUPP;
 	}
 
 	return 0;
-- 
2.54.0.746.g67dd491aae-goog


