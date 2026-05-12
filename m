Return-Path: <netdev+bounces-287331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAz5IsahA2qe8QEAu9opvQ
	(envelope-from <netdev+bounces-287331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:55:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012852AA7A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C48B300B288
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D12394E93;
	Tue, 12 May 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1ww8I9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A0393DE2
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622910; cv=none; b=ogFFLzyCoobrjmXmQ/aoRQW4s9czXL6GEG+QkGZpo3uD39gfxmovLarWbh9zkskyG3mNafeRBurA+Rt0OFZu68NeNDGbN/QKaVoXfaOngtGVa/I0ua2daG+7lv0enkGlyty1xtgDa0dkcTk7gwM9a29fzbbN7fb0LkOkrgK/0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622910; c=relaxed/simple;
	bh=reuPeR5st+dNjQ+dUnUpP6RytIN2DJ+Tp7VAQwercNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLai8kiGu4WyenKItjNJ+ibeudtMhNUjDLGRZflyFkbsBs4y9kdqLBvBkgOZXHeHKkCv9v4gl8I+wES1Ge36VHnI8GjhjD9G+QT+5Kxa7zs3w/2TtA2j0W4SpI1Z/VFmg5HmzPPbYIbGModAsq6uy2RC4yKT2Q3ekdktbB2Pfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1ww8I9i; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so3507975a91.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622908; x=1779227708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nTYItNBEtJamr9+Qzv1BppMHRb0qZCJCrUuytaYaF0=;
        b=N1ww8I9ilxYYwzVoA1zQfsqh9AE/Fnfno45zOPpuBlhwAsZjVLY04NHry8axtMI2NA
         z+EQCom2rmmbaX9ZcgJ5HEQK4CL9iPVOmurfhrMb/DtFgYpu0Q+r5PUxjpq1ZSrUTTFq
         8CPAYmh7i0uGAbkIvpAtV2q57EHwABKz2wgXx3jx0BCam6FvH1+YS2mJf9LadON4MOSg
         Y1nD0HNdHJpnCyD+VWVjW4AfbtvYEQFUfOi15MXq0x1OfHQtwJzjT98Mi5qljsWkNX8a
         3CyHmvFtg/fAX1O/TlxVPYGzjyPD+UvTV4ZDfPaB0JbZEFtJzZ3NWZk263pkbuhYMXHH
         mFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622908; x=1779227708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nTYItNBEtJamr9+Qzv1BppMHRb0qZCJCrUuytaYaF0=;
        b=b10wMMvn1F4l1nX4OGI6FPATuJaZL9dVqXiwF8xPtcGohO9KRzN+Zgh4RnaWXw2BHX
         mSbJGYY4v6Y5oHBDdTT3uhTlyXJx21WhtA2uzjcz7+BBDSuGYto2wktFdsQ0HzuBF9zK
         3ZkDHBbOkE8ldJSwzUzS1N+jAXfvnoxHviL8U44OefpJWWUGhsKlI6x71fja3UvaQlNO
         KB1/p3p7nz4dyi12A7vBCQuvxkhTfNDOXyU3EWZaJoM05uV9CHYBW9RA0vbEGsALk82K
         Acn/O/h3UTwDZcPBfQ2q+iLV6hXj25Y2MsoX7RQI5bjv1FuWtLEDu2K/gW2MLrWpmOTt
         gGvw==
X-Forwarded-Encrypted: i=1; AFNElJ+smuc+I8tYge60z1LB2PfGxr7ZFVkHHxc7nN2xDVqaHbKDqqTYXrdWrhLdyxIQp+7ZZDgcLNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAeHkBTWwzGungukhATtI2UkD77CBGtBNHD994x1mVYWdZFaW
	cmDHMufLQb6UavoQGht/SDF7p2ZxMs4s7+Mq1l6agolmlFPBaB/0y0MM
X-Gm-Gg: Acq92OHdHDUiAtag5d8pJYCWQvz57x/r2HHsJdyaZg5Yl5xQsnl2LAkct/qvWl+f7Ra
	mm0EoNTNOFi3e+FRrAMu+glBgm06DFbaX4zddzIubhV2f3uvo3zjU2t7bYhPrazOhyhJX85p34q
	yhD5bNKrRNsWIMhfiMnczDsYtWiLb5GOMWGNsJf4PlMz4JPikHozGOs49paMME8KxSb/5bpIGJi
	8mR7SINv6Q6UqoYasMHssxxhy56Z12rCNu4Hgrz7qioYs920CKxbfSZZF0o21VVeCXCrMP+RDIV
	Tcbew0PDWrzlLuO66xvwkLfYJ8y4mH+ET8FFv09Xhyzqegp+QBCFFC7TWYozM9CQYPnkj6kMMR2
	FW+PSSYrXvFSZbot/6UPNh2e5mu1wMX4gOBaqUGPi+xAYyYGSX6C9f4Bn+TeECHSnY04pJ6zFMj
	9Pf1j6tJBgc6uQmLXGUuVwGhDNvqj6SnUoidBLUrpdDaY2q9NS3eT5jy5n7ESS5MshuUijJ1lg
X-Received: by 2002:a17:90b:37c3:b0:368:3d3e:efa6 with SMTP id 98e67ed59e1d1-368f3f87c51mr696927a91.20.1778622908222;
        Tue, 12 May 2026 14:55:08 -0700 (PDT)
Received: from r912.lan.4v1.in ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52f27sm180335295ad.36.2026.05.12.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:55:07 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] netfilter: nf_conntrack_proto_tcp: fix typos in comments
Date: Wed, 13 May 2026 03:25:01 +0530
Message-ID: <20260512215501.1988242-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9012852AA7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-287331-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix three typos in comments:

- "migth"/"Migth" -> "might" (two adjacent occurrences in the
  tcp_conntracks[] state-transition table comment block).
- "agaist" -> "against" (tcp_error() header comment).
- "intrepretated" -> "interpreted" (RFC 5961 challenge-ACK
  marker comment in nf_conntrack_tcp_packet()).

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index b67426c2189b..47dc6edb4431 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -169,14 +169,14 @@ static const u8 tcp_conntracks[2][6][TCP_CONNTRACK_MAX] = {
 /*fin*/    { sIV, sIV, sFW, sFW, sLA, sLA, sLA, sTW, sCL, sIV },
 /*
  *	sNO -> sIV	Too late and no reason to do anything...
- *	sSS -> sIV	Client migth not send FIN in this state:
+ *	sSS -> sIV	Client might not send FIN in this state:
  *			we enforce waiting for a SYN/ACK reply first.
  *	sS2 -> sIV
  *	sSR -> sFW	Close started.
  *	sES -> sFW
  *	sFW -> sLA	FIN seen in both directions, waiting for
  *			the last ACK.
- *			Migth be a retransmitted FIN as well...
+ *			Might be a retransmitted FIN as well...
  *	sCW -> sLA
  *	sLA -> sLA	Retransmitted FIN. Remain in the same state.
  *	sTW -> sTW
@@ -798,7 +798,7 @@ static void tcp_error_log(const struct sk_buff *skb,
 	nf_l4proto_log_invalid(skb, state, IPPROTO_TCP, "%s", msg);
 }
 
-/* Protect conntrack agaist broken packets. Code taken from ipt_unclean.c.  */
+/* Protect conntrack against broken packets. Code taken from ipt_unclean.c.  */
 static bool tcp_error(const struct tcphdr *th,
 		      struct sk_buff *skb,
 		      unsigned int dataoff,
@@ -1098,7 +1098,7 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			}
 			/* Mark the potential for RFC5961 challenge ACK,
 			 * this pose a special problem for LAST_ACK state
-			 * as ACK is intrepretated as ACKing last FIN.
+			 * as ACK is interpreted as ACKing last FIN.
 			 */
 			if (old_state == TCP_CONNTRACK_LAST_ACK)
 				ct->proto.tcp.last_flags |=

base-commit: 73d587ae684d176fac9db94173f77d78a794ea4f
-- 
2.54.0


