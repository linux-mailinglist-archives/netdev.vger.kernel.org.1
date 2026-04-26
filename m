Return-Path: <netdev+bounces-281193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G5XYJjty7mn6twAAu9opvQ
	(envelope-from <netdev+bounces-281193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 22:14:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F646B072
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 22:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0B2300C90D
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D6389106;
	Sun, 26 Apr 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buQE4MMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533B2E0B71
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234488; cv=none; b=QBsrLfYigMpUPQ9A6trxSj6pDb0RzFM7FcraIpJmt+OEPveo2cDZpw6VXTNaPbQ1PAAWHIwnFIqdIM3ZHKrEyusFlGEnBwdmz4lTBEIjW5Ot+VHbyBWuRwhnBheZjQXLjkk8o5suKnGB0MDq4evDm2a1WGXQC2iW9j8/kXxFXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234488; c=relaxed/simple;
	bh=wQh4zXm97o5oeHm5yxBn3vGN2YMh8YxuJpccD1EQfJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0uh937XdRRAp1ZkW+tllR2UFnqw7GLB1zmOox5hcMTxuMbFRPWIoIlj8GvIguAgbMnsPclo3TLMVNIXXDCQkkrROtF0bCbMEqbAY+mE/aGZPpDBZwAiBaB0zw5/54rUj/449TWo4XJY6d7En+AFuldLvtKtcnVQ4CegZhli+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buQE4MMi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4411e1eba51so6193411f8f.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777234485; x=1777839285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8urkDnAMQ7s+DYXue+F/vPxH0oIhN0IJHHe1OnaQFl4=;
        b=buQE4MMiKJyWXsQrw0Acqi6pu4Hfp1ekqeYQKMXJRBPPedZ/0axrfR0Uk2abQ++n08
         IZC8pKEF+2Zu1fWvMbCjI7/Lxp0Ejcg93wjecfrOuzBhpL5MDGS+XBNiB0u/Ib9aT5SF
         kCuVvTHe1ZGS1hDZbZNynk8BeeerBF1+K8NmCpAljI2e26Cud4Wu36ZlknR+DDcE6lLY
         qCci/kCOT/9LZxs2lPYOpAMCF925lC7WVyd3K4jjpAGRmBAk5awAKokA1VvygwQO/8Mv
         IlIBazwNa/j+Uc2TM/DmdCW+MOI5o8C0xxhWfygSqzrZLI6HKtDL2vI6k7XzSXc45G7p
         W6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777234485; x=1777839285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8urkDnAMQ7s+DYXue+F/vPxH0oIhN0IJHHe1OnaQFl4=;
        b=aSnyjL2AyGG2b7aASPNE5jG1lOwUKncV/1djWOgnsPZuuADA7XrHDB7YAU5MFNeagT
         cIdNiamZqH0RYoxmZN9kCZXqE1D86OFW8coWH5/iail1dkuYG61v2PBfBB6cEZ2Pd8kn
         ND+yHks2kAtLALkb8c8Wbg5478S5fqFS9FgWtbwQnEQq0B84gL6viYuPIvNHMXcWfPsZ
         AtnZlwc7JKIktZzSA2VsWtTP8z4xv6CebaJeW2I4EJZQtERGi8croQMZjd2H3elT/Dv4
         s/4fUdynoBjGyJsCCof6qJIWgEnv+o+yTElpw2kqBlB0npdw3+ZRJyVnqqWNzai0Ta2R
         mztA==
X-Gm-Message-State: AOJu0Yz3iisHg283daiwu/U7YbHGa8NRF3YjLqmZFSOq2uv/Py/fwaAv
	dHzRHSJFWKwWGAlcc5IGkiUXwoxZUiie7jNI6CSnGzPr4iCAffyR90OwFrRy+g==
X-Gm-Gg: AeBDiesq+c3674Ohc2iqPYu3S2Jdr+LfCIQwX7hGwYDFdaGHsvkw37qExOtMA0w9qri
	2gstXtb0n003UF6BZh12XeYOJWygaui2U5foT+5d70qoTs3FlTU4Pugc2BRcuLMMmGGtwxOT+/w
	fie9lxY/hOMeNbidjbWJlX6sn3kIwmW6OBX0nAw1zrZNa8paQFnr5h9opzyRNgOpn/Rzg3GDhM8
	/TCG3QZTQbAsva9ziT19f619PnhphWToAJOpaplQYySqEj10iPEEStyik5gwPEGNh+44xSN7IDj
	yfBeZI03/u5aF+3e+JKLB2QGYl2F/x4NrWHEc3yP52eBuftoDHULRec/qXYM0W0NKLC/h7EZ0H1
	c2AFJT+IdEwg618kL8i1XZvucHwdH6KHjQMVw8EDhOtoxX08O9S9NHUcjjUVfQoAZ2l+xig5+Jx
	+w7pCxTTR7AmT7LJxUmO/kxAF5RXIi/w==
X-Received: by 2002:a5d:5d0b:0:b0:43d:20e9:b0e1 with SMTP id ffacd0b85a97d-43fe3db9b22mr59214532f8f.7.1777234485262;
        Sun, 26 Apr 2026 13:14:45 -0700 (PDT)
Received: from fedora-dev ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm70356206f8f.22.2026.04.26.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 13:14:44 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH net v2] netdevsim: zero initialize struct iphdr in dummy sk_buff
Date: Sun, 26 Apr 2026 23:14:34 +0300
Message-ID: <20260426201434.742030-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF4F646B072
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281193-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlatistiv@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]

Syzbot reports a KMSAN uninit-value originating from
nsim_dev_trap_skb_build, with the allocation also
being performed in the same function.

Fix this by calling skb_put_zero instead of skb_put to
guarantee zero initialization of the whole IP header.

Closes: https://syzkaller.appspot.com/bug?extid=23d7fcd204e3837866ff
Fixes: da58f90f11f5 ("netdevsim: Add devlink-trap support")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
Changes since v1:
  - avoid unnecessary shuffling of struct member initialization.
  https://lore.kernel.org/netdev/20260421082005.74a3efb4@kernel.org/

 drivers/net/netdevsim/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 1e06e781c835..f00fc2f9ebde 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -829,7 +829,7 @@ static struct sk_buff *nsim_dev_trap_skb_build(void)
 	skb->protocol = htons(ETH_P_IP);
 
 	skb_set_network_header(skb, skb->len);
-	iph = skb_put(skb, sizeof(struct iphdr));
+	iph = skb_put_zero(skb, sizeof(struct iphdr));
 	iph->protocol = IPPROTO_UDP;
 	iph->saddr = in_aton("192.0.2.1");
 	iph->daddr = in_aton("198.51.100.1");
-- 
2.53.0


