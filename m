Return-Path: <netdev+bounces-263334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGpBBPcTp2kMdgAAu9opvQ
	(envelope-from <netdev+bounces-263334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:01:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CEB1F4582
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AF143026DB5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8D3D34BE;
	Tue,  3 Mar 2026 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8uCb1tZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FC3358C2
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557272; cv=none; b=Gtt7uiCC4rdIK5sAlt3c5tMuJLUGSep4ybfL23Tg+Sk60ngDEJzoHCebOs1+9dmltrRrnUdInbcvSqXAbhmCBtCBYyxl77OQVUspOzfew/FYWyMAr+uLWv01nfx8LnWbLAtmAtDZN4elubthd5FPxprWwdMxjDGkP9Olnp95Law=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557272; c=relaxed/simple;
	bh=+xr/8cP1YmUhYlqNJcGc2rtUKBHvlfAXWLvjH6aqTzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kIZNjJDKG6OzoycSgCUEDaTFmrDr9jkpinRORN/tmjBizoPR9lRYobMsiA3fWpp10X5grRGLBw0i2mjeHTq+9/yiKgu6OtDXmfyy9F3k4EUVJjvbj5ChMWhjj375sTZHxvM4926J5eKL59CMt1C0IiWYkIjij3PdJ5b6yK2E8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8uCb1tZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so3777083a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772557271; x=1773162071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjQGo/Bm/mzaEwWNBUTkUEEoY/bSeVQ1lxMEw0MvYk4=;
        b=W8uCb1tZd9dREQeElLfg9eOBISvtDGVh21QhjyOMruc0SM4SDjCTb0pOEnWMZ1yk5X
         GoXnvaP3GejhlEZo35qQydSy2EJmALJZlOq4OZ6smE6b5sS89J8y76JhEubygAa93Cmk
         jhK+IvbX5sv/Ik/r/Z8ZqiFTgcGicrIoKQCS9RM+BYaucyfSkAfMo/W/GO1Vc68m0x1/
         hTf9+zuWCvXOU3lnwit8AK6ksSA8X8Ma0rIreMip/tHnFradFUu/mpQdJPShYCzIUrg7
         gUHZDy9D4C8axhxIRnTKMPM/JAl4XMm93lY9mMM846pcT9Tj1mjKf9uR3i1/jGOP36/w
         EVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557271; x=1773162071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjQGo/Bm/mzaEwWNBUTkUEEoY/bSeVQ1lxMEw0MvYk4=;
        b=WHm1G7zdQtlr+DM+E97dhgMagDdrUbfCb99hTh3Hlmr/Polir69utVTlxGhnEqSZBd
         CLruxmuDkEtG2IdYw+w5/ujXaGtWQVzjFbGJnMu7WZXm06jkkcVFkmBtuiLAkDgHXql7
         bSdcGvnotnPqfwt8SaCh27d5LGLPrOK3SJYNqboMHxBTUPtrv8/RzwGJdhO+NEdw2dtC
         5rvyHY8LgQIuoMj3WhUakU8TL+W4kH6WdGrpFc5zBLZeUu5oXkDqvhHkHz+m0JAOEQNY
         zanZc2VL2suVRc2BZ6BPLRrCBBixAG/rgowDQo+aG7f40tCb0lyC2JyGBASIGzivcFSB
         Zicg==
X-Gm-Message-State: AOJu0YyRaBb4fvd0H+YkvD/EMLYnjBJ1e5LQBSJ2AJsGnHDA+J4WR8+n
	/gUaePatwNcYm0oRx4sh4Efqm3p8TD/Ryg8eODDNMA9oNNudKupICy6GBlKPG3uebsFrNStbwWA
	SeyVQTDUavyatVCBufMcA8JAK4TB2AggcYXcbn0NeI71fzhPTOP4OCQjlWVVo1TVvl3TFLwW+bY
	W5J8RrP8yKphcIi2m4PlLQNr3ZOU/iIR8=
X-Received: from pgkc18.prod.google.com ([2002:a63:ef52:0:b0:c6e:22cb:d319])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f0a:b0:38e:676a:f3e
 with SMTP id adf61e73a8af0-395c3a5f7cbmr15863153637.29.1772557270810; Tue, 03
 Mar 2026 09:01:10 -0800 (PST)
Date: Tue,  3 Mar 2026 17:01:02 +0000
In-Reply-To: <20260303170106.129698-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303170106.129698-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303170106.129698-2-jrife@google.com>
Subject: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 54CEB1F4582
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-263334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[isovalent.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RSPAMD_EMAILBL_FAIL(0.00)[jrife.google.com:query timed out,yusuke.suzuki.isovalent.com:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,isovalent.com:email]
X-Rspamd-Action: no action

Currently, udp_abort() invokes __udp_disconnect() which clears out
socket fields like inet_daddr and inet_dport. This makes fields like
dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
hooks following an abort on a connected UDP socket, since they'll always
equal zero. This differs from the behavior for TCP sockets where a
cgroup/sock_release hook will see the address and port that the socket
was connected to at the time it was aborted. This causes issues in
Cilium where a sock_release hook is used to perform map maintenance when
sockets are released, since Cilium actively destroys connected UDP
sockets in some cases.

Make the behavior consistent between TCP and UDP sockets by not clearing
out these fields in udp_abort(). Instead, just unhash the socket, mark
its state as TCP_CLOSE, and preserve the state of the other fields.

Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2..01a0a0fbcd56 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	__udp_disconnect(sk, 0);
+	sk->sk_state = TCP_CLOSE;
+	sk->sk_prot->unhash(sk);
+	sk_dst_reset(sk);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.473.g4a7958ca14-goog


