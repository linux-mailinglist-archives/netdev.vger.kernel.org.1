Return-Path: <netdev+bounces-288854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAYvNNaeCmpY4QQAu9opvQ
	(envelope-from <netdev+bounces-288854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F5565DE1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54B09300A4CC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947638A292;
	Mon, 18 May 2026 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLGS5wqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAD38911E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080854; cv=none; b=gvwiUqmzX7B5MJEm48nUtxeA2R6fBzNpaRPaf0/uN7rek7kLLtNCoXBNODruaF5ysuPUIKG7VFuBNA1xLwcjyaKAfc1OyKwBq65lxqfcIE02/oJMN1WJh0TJIL66sJgZW7j7kgNvL7S7FiU8jLj8xFNrYI0VB8hWsOuVPS9/OA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080854; c=relaxed/simple;
	bh=DOZKBKh5jmk+R7VB7I5R4NmYk10fyYGUKS/vQ53aNk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8G/67Pj+Xdui7ubkKVbdHZgZhW4eF61t5carWt/FhRyjAZXPtFBdeW6KKxIBKyNBhH+wbEo4PuZBXC6FMu22OmKxFcKGw7wx5ZYGIglZ2vRoSJrzugUrPqMuSWaY4AL6iuROfPFlHv6caiZY4CysUtjKTa8oJygVlqKn0gcDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLGS5wqz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so996736a12.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080852; x=1779685652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCC0Ma145abVNt33CjH4ulz/FW2YSQ0ujV+oGrhgjeo=;
        b=OLGS5wqz2u+msfNpHTTJn44EoLARrRKNZipzGiu+w3hK8mRqm2ky0+Oee11vvhF57E
         zwhFgVubReld3KWNKrIUYa+j5EQnKUwaQbx0TLAKZdBPw5kZlfeYS+l/VaEDQL77//+e
         9ut0SklO1x7ia5F0JVEagTlFjQ2lH41XyCyiZFezM2vNG2zg4ooEmmyHhfl/naREPcCe
         oYewO6NCdTx0uMu3ivu6WQ5E8y6u4oLjmzv11VYAhvCaGNViWBFcKLzc4SIQ5ilGnQu3
         D4GMJBsX++Nypo4Vl/vaP0TrwC1EnOa9CnthbAF1aXQdoJUQpA9/hY/3jme6nQbl+j2S
         wz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080852; x=1779685652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCC0Ma145abVNt33CjH4ulz/FW2YSQ0ujV+oGrhgjeo=;
        b=XTFA+mXp7gaGjDHP/MBLrPBsPNaajGDc1xiVZJifqs3/6Td+YwtuhpDr6xxQSLdxnJ
         oQMlmWvaezn6bthbDtHkEdzx83/xJX8GbclwjrzYzdipZwLUZh9F9oEitV2lbPT7z2IP
         C/UUouUhEyLwzUbN/LvfFuyW/5T7s9bdXr5e0HeMW+L2JuVjD475FQYdp4jHtZ+z6Pgt
         JoHDTbJQcM3V+l521Et9Th9BH9FsHFNUcF6M0p4Wk8n0kINGT0OniahWolRhaOJ/at4C
         qs2uDR6LTdRhiYuefP7vYgIsSRohK3XrbsCpo/XCjzZzQOXzBqwwXrG7a9koblVEbUJC
         oetA==
X-Forwarded-Encrypted: i=1; AFNElJ8UIYe8pk1TP3w93sSzeX7jIKB3FzHsgkKc8pbfZD1QSxfCC4k4o3yklazuZCBPL2vgk3yJlqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZrG3VQ+PqQEefOV+qquo8SVE/t39WEIunjqzoJ95+3czrJaC
	F2f7+HlUfnZvQ/xfqaGsj7JMHzGQcfyWvN64hAfKqG1Bj5y2WyCSHTsaUUhz/YZ3yHPxyvgh1Bl
	NKGYxxg==
X-Received: from pffk1.prod.google.com ([2002:aa7:88c1:0:b0:82f:473b:a2d5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a214:b0:835:3949:3c1f
 with SMTP id d2e1a72fcca58-83f33cf029cmr13906407b3a.24.1779080852182; Sun, 17
 May 2026 22:07:32 -0700 (PDT)
Date: Mon, 18 May 2026 05:07:12 +0000
In-Reply-To: <20260518050726.318824-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050726.318824-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/5] bareudp: Use rtnl_dereference() in bareudp_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 247F5565DE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288854-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

kernel test robot reported sparse warning in bareudp_sock_release():

  drivers/net/bareudp.c:288:12: warning: incorrect type in assignment (different address spaces)
  drivers/net/bareudp.c:288:12:    expected struct sock *sk
  drivers/net/bareudp.c:288:12:    got struct sock [noderef] __rcu *sk

The warning is not new and exists since the initial bareudp commit
571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling
different protocols like MPLS, IP, NSH etc.").

Let's use rtnl_dereference().

Note that bareudp_sock_release() is called from bareudp_stop()
under RTNL, so there is no real issue even without the helper.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605062359.e3gOfZCr-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
I didn't add Fixes tag so we don't bother resolving conflicts
for harmless warning.
---
 drivers/net/bareudp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index bfcecdcffe67..5ef841c85526 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -285,7 +285,7 @@ static void bareudp_sock_release(struct bareudp_dev *bareudp)
 {
 	struct sock *sk;
 
-	sk = bareudp->sk;
+	sk = rtnl_dereference(bareudp->sk);
 	rcu_assign_pointer(bareudp->sk, NULL);
 	udp_tunnel_sock_release(sk);
 }
-- 
2.54.0.563.g4f69b47b94-goog


