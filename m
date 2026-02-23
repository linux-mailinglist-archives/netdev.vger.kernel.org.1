Return-Path: <netdev+bounces-260256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LgNHxjenGl/LwQAu9opvQ
	(envelope-from <netdev+bounces-260256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:09:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3417EE2E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E27E300BC69
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66737D11D;
	Mon, 23 Feb 2026 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrGVV2wx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412842222A9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888073; cv=none; b=cjkHV1YFoVEWttT9mSIogwveRL7+aBQfrb+6nqopb4RE2nAcIgA4bSaQILdPuIOeOvRfN19BmwxkzpgrvOpgycJ7lMfrJQDVIcMZ08503ytLk4+0AjVqj1UI9ZMMwUexT9TtQZO6LzAlUOAGGfG3XbAOANdpw8qwzFFbw5OCOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888073; c=relaxed/simple;
	bh=xkJLVqf3jksD/kEmlPTWa7iJ1pG5J1cOinlyPkDEokU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nVLyY1Uu84+MpEwuG0+aq7De/AtMixJV4UnJAhhe6rgzphpJtZoW4ef4OM+xD7L/a17GSrtuR6i3xf0TmW53UCPqLWUSHry9bYs2FAWrb1Au+Loljh82GKePSyGRyXfYjFV5a1cd5miqsv1YxKMAszRgFNqw8I1oMAdMMfeF1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrGVV2wx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ab0b2e804cso57215825ad.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771888071; x=1772492871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYzxjy17nM4pxM+pr7WqqPu2oje/LqwK9DS+bOv8WyU=;
        b=wrGVV2wxI6/uLAFba0qGuc1IORZ2dBE1jgWFLLdr5/TSx0huSjNcS+o0sCMaQVRANn
         2moZ7r/l15E28OE7sLHEwwOdLAkQCSvMp9IvefziQuaDVjlfwzEfbLL65dQFXyS7a/Qm
         RP0iSVoPD+dS/gfjrS7wJ2W60ygXd34LkeTkmV8LcMAMi892UBNxfAzf+hmZgFmc+UTr
         Ek2poIx9QFEIXBMJjM9Zc36VCbx6EspaVIJkowAPOO/0tldHPRjLbHtgw0pwX/YxifS/
         GdvcbbRk1B/LRExYXnqLX2MdaYb5wColoK3Y1W4UPq8bbODtMKgk5eIKEhhza9bjJnyd
         KLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771888071; x=1772492871;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYzxjy17nM4pxM+pr7WqqPu2oje/LqwK9DS+bOv8WyU=;
        b=LdBE+z9F2OaNaD+H+2qPFc7Dy2dBBo74y4ZWCZWW8CBgqScSr8q6nQIgfpOwb+zpyy
         438p6o3yqH58KPrNE7OaouBqJomvikSi6JnNTvEAm5Q/u6Y3dKBQ6B3yREZkqOVQgrIr
         bXQr6L+TaUGS1d6GWe+rDH0mrnD7Q0JyGNvn7ptQ/JXbUcEUN83HEToj8SvXYd2+izYv
         hT9duy0Quhvktrn4JLjObt64ojpZmVV9mSe6ew6NqZo4iOWcLARCDPaOGa31W9tHsD9L
         AljmkYS7bO3eJeWLEwL9L8S05Wr+4oviGda14iJJe09OFOswqN8MB4mpIXjVIP9LD9X7
         TNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpRWsYGZh2C9+nwkpPoymR/VinaNpuS/abQgdTwF7L0Povdwj7llptZvrvF7AL7DxdrvFQTPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGXw8c6ZM+5NT0eK3oe9a3kdwxnrNB00KuY3aO2c3EH0R0AuG
	tcthVQgz+Sv8+1839oIVJJziCD223aJUa5BQAUuFApYnHlzsXufWBSgmMh8xJtHCaRWEostHGEp
	a/tBFzQ==
X-Received: from plld16.prod.google.com ([2002:a17:902:7290:b0:2a1:10fa:4a4a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d0:b0:2ad:99d8:8612
 with SMTP id d9443c01a7336-2ad99d8881bmr4611865ad.20.1771888071371; Mon, 23
 Feb 2026 15:07:51 -0800 (PST)
Date: Mon, 23 Feb 2026 23:07:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260223230749.2376145-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] bonding: Optimise is_netpoll_tx_blocked().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260256-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4C3417EE2E
X-Rspamd-Action: no action

bond_start_xmit() spends some cycles in is_netpoll_tx_blocked():

  if (unlikely(is_netpoll_tx_blocked(dev)))
      return NETDEV_TX_BUSY;

because of the "pushf;pop reg" sequence (aka irqs_disabled()).

Let's swap the conditions in is_netpoll_tx_blocked() and
convert netpoll_block_tx to a static key.

Before:

   1.23 =E2=94=82       mov    %gs:0x28,%rax
   1.24 =E2=94=82       mov    %rax,0x18(%rsp)
  29.45 =E2=94=82       pushfq
   0.50 =E2=94=82       pop    %rax
   0.47 =E2=94=82       test   $0x200,%eax
        =E2=94=82     =E2=86=93 je     1b4
   0.49 =E2=94=82 32:   lea    0x980(%rsi),%rbx

After:

   0.72 =E2=94=82       mov    %gs:0x28,%rax
   0.81 =E2=94=82       mov    %rax,0x18(%rsp)
   0.82 =E2=94=82       nop
   2.77 =E2=94=82 2a:   lea    0x980(%rsi),%rbx

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bonding/bond_main.c |  4 ++--
 include/net/bonding.h           | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 55a960da42b5..2f2dddcf9d30 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -206,7 +206,7 @@ MODULE_PARM_DESC(lp_interval, "The number of seconds be=
tween instances where "
 /*----------------------------- Global variables -------------------------=
---*/
=20
 #ifdef CONFIG_NET_POLL_CONTROLLER
-atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
+DEFINE_STATIC_KEY_FALSE(netpoll_block_tx);
 #endif
=20
 unsigned int bond_net_id __read_mostly;
@@ -6589,7 +6589,7 @@ static void __exit bonding_exit(void)
=20
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	/* Make sure we don't have an imbalance on our netpoll blocking */
-	WARN_ON(atomic_read(&netpoll_block_tx));
+	WARN_ON(static_branch_unlikely(&netpoll_block_tx));
 #endif
 }
=20
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 4ad5521e7731..7f8fda2fdfcb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -91,22 +91,22 @@
 			    NETIF_F_GSO_ESP)
=20
 #ifdef CONFIG_NET_POLL_CONTROLLER
-extern atomic_t netpoll_block_tx;
+DECLARE_STATIC_KEY_FALSE(netpoll_block_tx);
=20
 static inline void block_netpoll_tx(void)
 {
-	atomic_inc(&netpoll_block_tx);
+	static_branch_inc(&netpoll_block_tx);
 }
=20
 static inline void unblock_netpoll_tx(void)
 {
-	atomic_dec(&netpoll_block_tx);
+	static_branch_dec(&netpoll_block_tx);
 }
=20
 static inline int is_netpoll_tx_blocked(struct net_device *dev)
 {
-	if (unlikely(netpoll_tx_running(dev)))
-		return atomic_read(&netpoll_block_tx);
+	if (static_branch_unlikely(&netpoll_block_tx))
+		return netpoll_tx_running(dev);
 	return 0;
 }
 #else
--=20
2.53.0.414.gf7e9f6c205-goog


