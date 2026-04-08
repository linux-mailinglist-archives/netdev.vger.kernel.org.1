Return-Path: <netdev+bounces-276266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK2SHbfP1WkC+QcAu9opvQ
	(envelope-from <netdev+bounces-276266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A12273B69E5
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E194E300E035
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11296274FEB;
	Wed,  8 Apr 2026 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlImg9ZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC22222AC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775620020; cv=none; b=ivCfTRAbgDe8PyXXa/kRrLEruh4UQUzVMm7nv9aJGBnD/xuU08Otmu0u5+DNIVOm8jSBPpFk+PtBkQXwLgjjhIUtdyk9ED8fxABFSmQt1Bk7KCPUCjsN83SyJJ3r7WA+BRsTInCIGj//fzwI49NwAMjq8i7jFkQJG2qHX/9hYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775620020; c=relaxed/simple;
	bh=XLWK3U7t3wtnUiVeSeL403GD/3ggJvFV0dCHkY3YMwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXU8IN12auTLZ2v4OOzWn6GoULgfpXHciKUR84Ng8x8hHDrDs8utO0ESQdQvpBNWljnl2jnYTuEPTz3I9pKVtCONBxs+Sz1cI5TVKuegc4YyJRD4qbr3fdugdIUSTZk0MUnDXJGY0GvKl6P6hBE1LIZSW6ya/El+WPqLfG9nfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlImg9ZM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a60975dc5so57463427b3.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775620018; x=1776224818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEYNDhDMiU1B6pQ6eoniUd0oA2vBhdScWVGs5ZrFJmE=;
        b=IlImg9ZMzcIHtEWX/wo0mYRM8uDU2XMJZ8EDGrXzzqUqv3WoAN8SidnFqMpOEkCFPO
         kbCPOpGTHN1EvpKxB6WtgcS15Uikw4alIYqtGwAMU0IqJom2qEfRL29aoYCKvtCKsx+c
         blBvxHyB0DWnyEVmFtdBu7dmIAtp3zi6q7uLwoD29B1DJ/WCN94o8n6jV4qWCCRhmnf6
         2+7SotRmxzvVwbfPlAbj6jHO7zTRKD3KWjLYNp8IecZaOOMFORgJxZwPgFgzqyKt6XL2
         uFGm4HlLruAIxX1hQfdfOKjpG2AUwI6r6iA7a3UDlQauUU+ZS+2YSrc23uO9ZKpo10nz
         1n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775620018; x=1776224818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEYNDhDMiU1B6pQ6eoniUd0oA2vBhdScWVGs5ZrFJmE=;
        b=sNhES3ty0R0jwBCPve5H+8HLIaBRsgO/pej9w5uf3GpiPB5m4iRsfaBfXmMKO4Hozw
         epyt6/1jM8Q4ITD9Fs+zmLtE///DmM9eVj8ycGDORHl/uw67rAawkqoUN40B7V5TqWjD
         fMKA1Oju9K+RIVuAmT14Iv2Kr+VhfZoFTRDlh2kENtvwo1Gia+yoktr3k8mBGwqPycMg
         jrZ5AyMmi6tSuOkgovhgnidAXBUbg1BnRQ16LqHEoIqnKtoVIHii3Stbo1usRyzUV9GM
         P4girDBM9upIdmdb6AE3/Pwa1mFipcvuMwvS26DGilp10utCBFZNviqEUcDjNP6fIsD/
         8Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCU6WqSphWj26aGEhmbuijEROsii3vpbgS4eRLIz5XTUGCwinJUxSNH5bVYkAcYEYjWysV2SI5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxihym/4qj1gvjWRbRhwjljzxD34Gg0tIdyN4Itpkmd2yvU32
	vGiXNCm1a+Vsbmtw532MHcN2UDWfeczV1xtCdOe5s9oadleYyCdUAwT1
X-Gm-Gg: AeBDievL9TW3cJ9Gejh02J0qMV46j586ITFUwN8nycwmVoIQ//KUPI24GWdIzoImgee
	4wUwvEu2491xn0OszR8CrodCNbZqObnz0F/qTbNWCyOc9Q7rp92Ibhs8qACuaf/JnkcivuZG52j
	UoNWjcyfZaj3IxBNQk+zaX08fPGiQrWBNxy95UFrNvJ86htjfUk7nTmI87JGzpickYXKCsvkK5K
	rdrZSfoHzfsnjecNse5kQHQg2jRLzdGb94ZZUxk/GYUifV8pcSGymilUma9gtYNEU+5fb+PcdM6
	2lUpI5x9nE6q6cQbiqTOO0e22UjVbRHy4ieeWcREVQQFMt5oPziv5rNmwrj3mQgOl0nKfrE3AXu
	sMV2dG8HaVs00ctr9URQoZI0dnnrxAyuVShcjGxuOfLE77Gplgto7ng8ifZ6sja0GybAelQA6RJ
	lgpGE96rIE3wEErGLovnQV9s8Q9NPOW9OX8+qy+AX1/jqYNBSaNvy4280GH0enWEL1BNDSQQ6vO
	sa2WMTO+fDqTEPz+8AVBqQC0YEXbqXMbJ0Rt+zd+Il8h8Uq2aJPknHCFXBMdh6Bnw4=
X-Received: by 2002:a05:690c:3482:b0:7ac:ff2:4603 with SMTP id 00721157ae682-7ac0ff272d5mr6996747b3.20.1775620017727;
        Tue, 07 Apr 2026 20:46:57 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df155csm79129167b3.36.2026.04.07.20.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:46:57 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
Date: Wed,  8 Apr 2026 11:46:22 +0800
Message-ID: <20260408034623.180320-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
References: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,syzkaller.appspotmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276266-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A12273B69E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_prog_test_run_skb() calls eth_type_trans() first and then uses
skb->protocol to initialize sk family and address fields for the test
run.

For IPv4 and IPv6 packets, it may access ip_hdr(skb) or ipv6_hdr(skb)
even when the provided test input only contains an Ethernet header.

Reject the input earlier if the Ethernet frame carries IPv4/IPv6
EtherType but the L3 header is too short.

Fold the IPv4/IPv6 header length checks into the existing protocol
switch and return -EINVAL before accessing the network headers.

Fixes: fa5cb548ced6 ("bpf: Setup socket family and addresses in bpf_prog_test_run_skb")
Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..300e2bfc5a62 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		sk->sk_family = AF_INET;
-		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
-			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
-			sk->sk_daddr = ip_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET;
+		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
+		sk->sk_daddr = ip_hdr(skb)->daddr;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
-		sk->sk_family = AF_INET6;
-		if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
-			sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
-			sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET6;
+		sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
+		sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
 		break;
 #endif
 	default:
-- 
2.43.0


