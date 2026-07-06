Return-Path: <netdev+bounces-305244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWbaAGc7TGoXiAEAu9opvQ
	(envelope-from <netdev+bounces-305244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B1716531
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=gc6avgk8;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305244-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305244-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09BA33032CD4
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAB3B19D0;
	Mon,  6 Jul 2026 23:33:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FC3242D4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:33:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380836; cv=none; b=mpcCQnbEED4SvDeNtSZAjYw3Aff9gFrel+0gjM3Pw+dOGMlDPHPQTD+OuJojuTMqN4ueUveCu/n3+aAblI+cilh9zG11hR6d09ZNGnhWi4o6JbIUC5k3xMeSNEeDQ84ziZtAIiXVcqH9dFXP38Jh2CjZQEhk4IFC6nrAgL7dvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380836; c=relaxed/simple;
	bh=T2aOOIkGZjXaJ04CLlQJ3VXiA4Qr620lpnNV/chLF3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyD6ietRHGTTES3QoCwGTVLYzisKwslg8md8x4DlBptmTbQXBpbOnSZ4Px3RWzXXkMRkti63BoF5NrzTj6GU3edM3DJv8G7H/bf3kTYoK4czRy62de6GFVd+Mfj6naYvEcbVBtmh4vUHKpjqqi7Xb65B017L9Juo/l2Qti4/+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=gc6avgk8; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2788706a91.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783380834; x=1783985634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7SHEEPJPlufd/HInq99YVhBy4TEzIh4/di5h9/W1R0Y=;
        b=gc6avgk8CdqeTOyRUrW/DWgjmBk/X1v31M0B9E363JddD1jYJknGh2HLUbqpiGmfvC
         I372UxnLiSeKVKYLpKYSwfqNeD0vkGSh5XTWf0R1SkP1Fm2rEazOodqw08OQAC5cJ25K
         K5s85r+SmoIJe3/zzxItGes0vf4WlNIfFnoJxzrJT3xMAqmsR/0OtyQnYTxQUiANgP30
         TM8CmULd6PfgQaUxI/YwxtAw0YFl0LYectTIBh2551JqhcHe0qlIoelKyu1SaXEnhSUy
         W9TknM/6b81eoLvpYlUSHJGm+b5at4Cb1bT9OSFjawcxc1tG6VUS1iC7eu4rlF+jaOKg
         BMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783380834; x=1783985634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SHEEPJPlufd/HInq99YVhBy4TEzIh4/di5h9/W1R0Y=;
        b=jodDkoJubsokNTci8J6srKajTmrmzVfdQcuYC0/qfBMeyrB0jd1/QA18+I986bgfus
         aoc7dTD1XvVCyQa3cTD/TQgbrKxMpvpH0XVH7QmT5MLX+VnLDKKpmo+o7cynwQIuNzKU
         A7TiM+scv2siGNCd486ZU9/U2iNiiRpV5dqOJ6yGCb81AgBVK/W8XatM2kkboIoN29Uc
         qBY4FQKQY3ulheNhGNlnW8Q3Nfd+oJZgrAapHN0Va6mSBBB4949pdjFckTRHs77JisLZ
         MPzLkRiTDy3zYDDUhE4JJlAg70hxBEia0fsXaqeruS4JKXgOIBnha7WfJQvecZCrwgyR
         yE9w==
X-Gm-Message-State: AOJu0Yws35f150ZyWMXAMZeZlYonyh6vwN1Y19tgtmAuj7xfa5hGHVlT
	sI6MdlCpJcKyDy5p53X2mZqy6hwfI7iv2HpAP0unLEKX98ttbarqeE1tvwa+Tt3XBBp+NIJdB58
	jwRe7tA==
X-Gm-Gg: AfdE7cliwgxViZtut9RDRZa96fbDnN8vCjnL/gcjYc0glGlmZTQzh5KwAldAdoova+g
	UrfNMmvjNR4Pn9CmgZ9gn3JENvidimz5LLz90YtPZiY230JieD49VGjgapAHF/GGx/OtCAN+P7N
	w3FjhhPfKpbj+DvcVj/Fah2hkr1j9JMg6kHEkyNG07n8VnUHhyFmLSio8Gf6u+CLYiZ+1/i3De9
	ue8XyE7D3B0ATHm7wELifHgCjLFtusLxAzgGQdFjqs2g3PcxXuU/b+ea+QEBL8/cyPLyZLzZ920
	Y8vSJ62Cqgv9WXoB+Cx4qppCHYhhLwdsH9M5/WvVEEyWJ0ibp/xozT/XWVdEGCyvi8pM7VFyQxl
	XEl1Y1XPCcVrBDkRvUcNQ1sHz31OThKS0TBSQzVTabESfqfagojBc0kt9goxgqbXrtO9Vu3oO+u
	ldh8DOMHU08LJ4qoz1UitbJ9htGRBL
X-Received: by 2002:a17:90b:1fc5:b0:387:e0db:3fad with SMTP id 98e67ed59e1d1-387e0db4602mr233810a91.38.1783380834375;
        Mon, 06 Jul 2026 16:33:54 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a9e2f2sm1197873eec.25.2026.07.06.16.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 16:33:53 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Herbert <tom@herbertland.com>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] vxlan: add missing NULL check for vxlan_sock in GRO path
Date: Mon,  6 Jul 2026 23:33:44 +0000
Message-ID: <20260706233344.3334648-1-xmei5@asu.edu>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-305244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tom@herbertland.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B8B1716531

vxlan_gro_prepare_receive() reads vs->flags from the vxlan_sock returned
by rcu_dereference_sk_user_data(sk) without a NULL check, unlike the rest
of the driver (e.g. vxlan_rcv() does "if (!vs) goto drop;").

udp_tunnel_sock_release() clears sk_user_data to NULL and waits an RCU
grace period before the socket leaves the hash, so any callback running on
the tunnel socket during teardown must tolerate a NULL sk_user_data. If a
VXLAN device is torn down while GRO runs on its UDP tunnel socket,
sk_user_data can be NULL when a packet carrying VXLAN_HF_RCO arrives,
faulting in NAPI/softirq context.

The GRO path was the only sk_user_data reader on the socket missing this
guard (vxlan_rcv and vxlan_err_lookup already have it; the gro_complete
callbacks do not touch sk_user_data). Add the same NULL check so GRO
flushes instead of dereferencing a NULL socket pointer.

  Oops: general protection fault ... SMP KASAN NOPTI
  KASAN: probably user-memory-access in range [0x2018-0x201f]
  RIP: 0010:vxlan_gro_prepare_receive (drivers/net/vxlan/vxlan_core.c:678)
   vxlan_gro_receive (drivers/net/vxlan/vxlan_core.c:713)
   udp_gro_receive (net/ipv4/udp_offload.c:841)
   ...
   dev_gro_receive (net/core/gro.c:522)
   gro_receive_skb (net/core/gro.c:640)
   tun_napi_poll (drivers/net/tun.c:259)
   ...
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 5602c48cf875 ("vxlan: change vxlan to use UDP socket GRO")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b5b1253ac08b..f2235bae9bfe 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -663,6 +663,9 @@ static struct vxlanhdr *vxlan_gro_prepare_receive(struct sock *sk,
 	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
 	__be32 flags;
 
+	if (!vs)
+		return NULL;
+
 	skb_gro_remcsum_init(grc);
 
 	off_vx = skb_gro_offset(skb);
-- 
2.43.0


