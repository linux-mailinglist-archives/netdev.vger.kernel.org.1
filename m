Return-Path: <netdev+bounces-297793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GWeMLWymKWqbbQMAu9opvQ
	(envelope-from <netdev+bounces-297793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03166C1E3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:01:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eOrXu8e5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297793-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EC4230E9BC9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314F3546C4;
	Wed, 10 Jun 2026 17:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6D352037
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:59:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114376; cv=none; b=b6gzWZZ9hEAs3z47jN0wgbBgaBDV2iJc9j9oBY0+JexVYmpwUuBbjnk9o4uAFCIE0qtZvyhxjj1Ex7PFWC/nF2MteQKQR69j5E7mCLoetUMwjvZFRBLdByVCP8oM2rndq2uLdnSOaQlcLLG0pmbWEyLeWt/XSqC0G6dU0TiMu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114376; c=relaxed/simple;
	bh=MOH8uvDl49+FgVeTGAfgbY1LaUOs8A8UBGtliJWpA48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTdv3yCzEdGH5vLW9wc4MTwIVz0G4Nk84NY+nGpHSutPEF7GCcZuhzRv97B9qQcBL8xyc7iQaQcjWRUSv96vz3EKm2X99ELVfxLbTdCLcMO9y0MsV2uCj2ovYcIfDSCrEFlPDl84rApPpcZ2zVh84Gmz7oNJK3pKkpACBV3EoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOrXu8e5; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842848fd613so6019405b3a.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114374; x=1781719174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wE+IA+8Dk7eFT8d7+2Q1/q+SA8sUoegIzrCmxHEg14k=;
        b=eOrXu8e5c6ft/upmrbjYIHBEepU/1etQL7kKI1pChoglqY/hecddzLh8UpHRdizZ0t
         a9pqrkSk66dA66z4GrmF2QUoJemnZ8lTXPgJ+Ku1BG6TXTEOWVXxGJmCDeKwU0H6BGgO
         LGDd8Dd9NcJKUf+fUG9cIt3Ud86n7ke4Y5BMrsNInWekb7jNVaj2YXj2uHUrRHn85m/T
         EjWv5K+yLTlXf9J2mi+ADNh8wbIJueUD/R2znelggZm+MVqGhIzpxgVXXaiOIkk9/psx
         Dz1Ur1g5PljuhTCZmxsWtVEqcyHwzn1oButyELiJxLhEb8i7g7J0z4SoNwPF+JGrY2hc
         ZimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114374; x=1781719174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE+IA+8Dk7eFT8d7+2Q1/q+SA8sUoegIzrCmxHEg14k=;
        b=pAWkkfqnBL8UPGLdlyZFS3NhrnZDp8vL5BEhAsx9q8VSqx2s7QJQRx5TjMHRs2SdiY
         9w5XI0meMdbL3JEEB4XHQZjiCopbAlthxD79OTb+Rg7agwJwQbaIZLi87mCzv5OERU2Z
         3S/hwLVVtjgeayk1wZi0sg8qw2WHAOjb0TEySRx+ghE2Grotv+F6Z15EEtSpmZiO/vUZ
         C3zbMcNj5XXhBd4DaYPz+iwg9ztz3owNuEHpPp3OfNdl0bcotUb+P99/qzjpeNCEwBbX
         lcU4LsoKbzMurt7SdrOF4FIoaOhh/785ot3jLbyTqqulUkX2m0WAozbm0Mlcvao3hfsI
         TEfA==
X-Forwarded-Encrypted: i=1; AFNElJ8YtHrJZVQt10eadwzESXHULAvAufogiLoRSawQ+wk+qUI5EYd4zDNKsSNgJaEo4Dhbr18/+BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3S/hDpTcWuo8Fw6DS0sCVsulMvtBUhJ8vFeHQ5D3mlo9kE/O6
	yvKPuNN2I3PIl2V9e+ne60OKuBp7JdsTMlSdTpBods34cmByR6V3MUzl
X-Gm-Gg: Acq92OG3RTogbYP4+IyWsh1KqiC/6CDfdEG4DYLzd1x/sAE4kLhNy4YBPJXq3ouF7df
	SH7nyz5B6tjpJIrtr8t99OFZVQD3lnp/Ey6iWGO2AU5ijkZPk5ii7aoQy7XSozica7odrMUGJHl
	/fwfzUl+eGIzq88icgl6J3HzRXUrN6zaiKb04nDHN1T3F69DfVLQNB+mWtZaFJevCmkhdn8LCkz
	L0ncaXPhYGRpYOgf6Ui9wglrfneW9GO24+99V6WOz9nHF0g+O+XGJr7KTfjhA8XPMEejSjFGcQt
	xv715zE4UrWTc1M8Ql8OmE6TeUTALRhMXzxu1ehGQsqeDMQHzyTAaRDpEYNbTvI5bhdecrSeS0Y
	XhKJJNMIyNqlD8RE3kD9UBhKccnUXb+2JVLE9dWrHRmPUVYeWmXue91/CubqaIRKxxXyIjlFf6k
	UCpX6OD6Kfw0SQ+9aBJt3YdhJOhaWopN/cFni6LX4p31/J0jj0NBg3ywVpsX13pXIeUqRhudyJ6
	4k4bI+zUpY=
X-Received: by 2002:a05:6a00:10c2:b0:842:3be7:4d51 with SMTP id d2e1a72fcca58-8430a66ee10mr9635935b3a.15.1781114374097;
        Wed, 10 Jun 2026 10:59:34 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm25235306b3a.34.2026.06.10.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:59:33 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: take the socket lock in udp_bpf_recvmsg()
Date: Wed, 10 Jun 2026 17:59:17 +0000
Message-ID: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297793-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cong.wang@bytedance.com,m:ast@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E03166C1E3

udp_bpf_recvmsg() drains the psock ingress_msg queue through
sk_msg_recvmsg() without holding the socket lock. __sk_msg_recvmsg()
walks the head sk_msg's scatterlist and updates each entry in place
(sge->length -= copy, sge->offset += copy), drops the page once an entry
is consumed, and frees the sk_msg when it is drained. ingress_lock only
serializes the queue list operations, not this per-entry consume;
copy_page_to_iter() can fault, so the loop cannot hold a spinlock.

Two threads calling recvmsg() on the same UDP socket then consume the
same sk_msg at once:

  CPU0                                CPU1

  sk_msg_recvmsg                      sk_msg_recvmsg
    copy = sge->length                 copy = sge->length
    copy_page_to_iter(copy)            copy_page_to_iter(copy)
    sge->length -= copy
      /* sge->length == 0 */
                                       sge->length -= copy
                                         /* underflows to ~0U */

The next pass loads the underflowed length into a signed int, the value
is negative so the copied + copy > len clamp is skipped, and
copy_page_to_iter() is handed ~2^64 as its size_t bytes, which trips
page_copy_sane(). The same race can put_page() one page twice and free
the sk_msg while the other reader still walks it.

  WARNING: CPU: 0 PID: 5484 at lib/iov_iter.c:356 copy_page_to_iter
  WARNING: CPU: 1 PID: 5485 at lib/iov_iter.c:356 copy_page_to_iter
  CPU: 1 UID: 0 PID: 5485 Comm: syz.6.1204 Not tainted 7.1.0-rc7 #1
  RIP: 0010:copy_page_to_iter+0xa9/0x270
  Call Trace:
   <TASK>
   __sk_msg_recvmsg+0x384/0x9a0
   udp_bpf_recvmsg+0x1a0/0x6f0
   sock_recvmsg+0x124/0x150
   __sys_recvfrom+0x1c2/0x2b0
   __x64_sys_recvfrom+0x7b/0x90
   do_syscall_64+0x115/0x6d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

tcp_bpf_recvmsg_parser() already serializes this with lock_sock() around
__sk_msg_recvmsg(); udp_bpf_recvmsg() does not. Take the socket lock
around the sk_msg_recvmsg() consume so a given ingress sk_msg is drained
by one reader at a time. The wait path is left unlocked, as
udp_msg_wait_data() sleeps without dropping the socket lock.

Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/udp_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 9f33b07b1481..8dd73e9ee1ea 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -80,7 +80,9 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	}
 
 msg_bytes_ready:
+	lock_sock(sk);
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	release_sock(sk);
 	if (!copied) {
 		long timeo;
 		int data;
-- 
2.43.0


