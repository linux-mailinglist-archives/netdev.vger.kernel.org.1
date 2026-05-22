Return-Path: <netdev+bounces-290710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJwJKgQKEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:47:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79E5B02B5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACA253024291
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170363911B5;
	Fri, 22 May 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSJMX2Ie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A438E13F
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435985; cv=none; b=MupGQwczg886haI4Oo+aThGo+rrwFF9ziy8vAdXA/cr9v2WflohcX+do+7C7VFruXjbKfttJKuHjxpjMHOyLE7xy9XjrknfrAiFYZVnGhzLHqraQnSuj7fS1G1ZH6OnWSMfz+q8/sUwHANROQOoF9DH1LfIfB4zxXop1hbrXpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435985; c=relaxed/simple;
	bh=ITNyLUTiNArq3+p1wCkL+2oFFFQASXvWz83jxEAII34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htzizU4eFzy4rhusoQasN+R9HIgvlBUfk9Mlg6Cmy0Ugvny2uG46WfBz3uVMRpf5oSQ2AzXo6aLLA4pFZ7q/PryqdNgkN7JX8K2hwQf4391xiwby13youWTYM1yvIF82OVg/Zl1X1U9k6OMJ7I+iF6CwQdUV1yYIr+CAkYCFv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSJMX2Ie; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so3823577b3a.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435972; x=1780040772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJfhavb7c0g8BRp/awps30Nd4Ebc+ZK855mSv70HAsk=;
        b=qSJMX2IeeGVERhY1TEdY4tA6MZ0ARnpj5urHUpQYjzjVRWC2dehn/e6cQQDV4hmwe5
         KutDM2NdDS66o48TiywBNipLlza6PiGVnOPV5/DNoGXbQPZl96QxvhgWVznXuSAPsCsM
         vBQQT2jfFk8HO6AQ1JYhaeGQLtpasE5o6P7g+NbzH//qkN4VAXstKhi4gfBcY/TMEWgI
         AKGBnpC/3yINbQ2xJpPhIpL1dZch8B17l0+A+yNrfuPg2AbbFMstCRgzkobATBMypEvw
         LCD5x+P+wSJj46NzoyHK+b0NTOvrVEpjMQAjwj01KDTwa/cSJAu6VBNhegQnfgtyWRGQ
         dX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435972; x=1780040772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJfhavb7c0g8BRp/awps30Nd4Ebc+ZK855mSv70HAsk=;
        b=Z6bFY7Lraad/wnqZMVO3iHgiA2hyuavtz70GDwc/3isq+xy/V0YTeQLK7sdxOr+w7I
         jtOVdbcfJ5V6Y1V8r7K1w4R2/qzqk657dmLEXfeKBO/20KINSLBGHlTOiU+jdKJy4AvL
         5G8ykWhND++nb/Kn1UThNyyWvdltI1Hp0ozpeD0E5Xy1YkKGS2LqENAc+d5QImsGk8S/
         i8NaUYzwrmPJKSI7w0t4obsJV/NYiZGDZdTmrFZoyhRtJk+peoATLJ8M4DWTRvPX8f+i
         sm4ujFG4NwvBA3Ko+N3u9Aw834EW+zMPW3Bv3/GtV0pWJ6nS3ONoyk1vXPC46jd7uIOg
         fHog==
X-Forwarded-Encrypted: i=1; AFNElJ8xkOzfgCX5Evht8PyYBtrU/MczjczVd7Did6Ri3DDRvk/ZTp56s3pNb2UvroVzURgkauiE5bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYAcy0J3NQ5AQR4preQt56ozoUK5YBMDCQh4vS3oMYE911UYf
	00IeJvr05JNTOiNxIH3wd/Hr1kj6R2dOLncghF6jsPrYZ0eaHEeAJniz/pEiGnGEIx4iC4sQDD7
	hYQHh5Q==
X-Received: from pfbfq9.prod.google.com ([2002:a05:6a00:60c9:b0:82f:7833:9aa9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acb:b0:82f:6e7:1527
 with SMTP id d2e1a72fcca58-8415f32f286mr2675412b3a.23.1779435972280; Fri, 22
 May 2026 00:46:12 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:59 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-9-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if
 receive queue is not empty.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290710-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.866];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C79E5B02B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unlike SOCKMAP, BPF_SOCK_OPS_RCVQ_CB does not iterate existing
skbs in the receive queue when it is enabled for the first time.

In practical production use cases, this behavior is usually not
a problem.

We can safely assume that the upper-layer protocol is designed
with specific synchronisation points where the connection is
temporarily quiet.

At these points, the application can completely drain the receive
queue and safely enable BPF_SOCK_OPS_RCVQ_CB while no skbs are
pending.

A prime example is an application transitioning from HTTP to an
RPC protocol:

     Client                                Server
       |                                     |
       | --- HTTP Upgrade request ---------> |
       |                                     | [Drain all skbs]
       |                                     | [Enable BPF_SOCK_OPS_RCVQ_CB]
       | <-- HTTP 200/Switching protocol --- |
       |                                     |
       | --- RPC Frame 1 ------------------> |

However, to strictly prevent any potential race conditions arising
from unconventional upper-layer protocol designs, let's explicitly
signal a failure if BPF_SOCK_OPS_RCVQ_CB is enabled while the receive
queue is not empty.

-EUCLEAN is chosen to indicate that the caller needs to clean up
the receive queue before enabling the feature.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5913b3be9f1d..883e4aaed49e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5395,6 +5395,9 @@ static int bpf_sock_ops_check_rcvq_cb(struct sock *sk, int val)
 
 		if (unlikely(sk_is_mptcp(sk)))
 			return -EOPNOTSUPP;
+
+		if (!skb_queue_empty(&sk->sk_receive_queue))
+			return -EUCLEAN;
 	}
 
 	return 0;
-- 
2.54.0.746.g67dd491aae-goog


