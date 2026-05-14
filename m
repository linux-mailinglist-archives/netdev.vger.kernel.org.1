Return-Path: <netdev+bounces-287894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNmMHQOcBWrAYwIAu9opvQ
	(envelope-from <netdev+bounces-287894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:55:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BA540068
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FF69301F783
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179933A9D9B;
	Thu, 14 May 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMR8oyvN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF13A7F69
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752512; cv=none; b=bBd1v2K5fECopV0Dv0g5NVqyY8SyhsAicy2pJ9ot7GCtIPcmvuUggXhspHKhBvKIZg5kO3k33jqoIlI0kPyHPbtfzQmrRsr+sgEop1kHB7/SV6c271g4OJ+TYxaYv5Fve1vbYQVw/zgY6wTLaEQTGVa25UYZ3sDl/pgNIhybd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752512; c=relaxed/simple;
	bh=aWOAyxznfu2DsxMrjlFn01jTigFda6DF+5/UCvSQ84I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mdv06YypfdTdyt95o85DEgoK6rjuXv7+5oqaM+5WzrY4IZCKC+tU9cYdMw15+db9HbOQgwCBhsYM3Lvd6ORlX5xMjQDSzqynJLTOvxjZeZs/G0YQ7bFnsdmp8hxloeCubrAGpUf8V+zHNeNUNqy4MOcXubomyLHQ6vxzvYI80JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMR8oyvN; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-65c7091141aso16089676d50.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752508; x=1779357308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=knQ+mZvmXbqo8/l9wWNtG3F1HWfhXkBlL3CWcmlym3U=;
        b=iMR8oyvNaEJ/1b3UCIc5QEaDxFLJZGDuMl7xWV9XTyYrzWlVbl7sVuiKQLA2RhAP3x
         XboxPVBe8wCbhbC+NkPfTaOS2D4SclLhLQFpKfhKKpOuBL7GB98FcPf9EbUAZ6CJUe2Q
         pxMDK4nCoK32a+/WB8oM0XBJzWrHRGA0M24RikS4oyp33Ioot22gYYGuz0TVMhaiETOQ
         tKPlYEbgueHJJbZz0CwjYVfG15vMjyzMKHs5/rEQ3+baivttg2E+HdM8DFPzvnvFTxNO
         KQteZzrPBQ860AaL3eW/B5pI4OejSL9xXetenpB+UCKPVAaF8loQuoeBMfTV2FpBn+z3
         RS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752508; x=1779357308;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knQ+mZvmXbqo8/l9wWNtG3F1HWfhXkBlL3CWcmlym3U=;
        b=ZgRwhhj3Ygkxj2F9DFvy+2AAhNNwY2DoIAC8ix1N3wx57NYoiIwRzzOwb2JGFgxF03
         EEdCc2xysC7EtaKhDrUEhxAl/1G+0doOniERX16ADCPJf929lkLr82+tFPDCmxM1xUUk
         vSoM2GI71QdLAvFnLMd1x33SXgCmf7iop7Di2mJH2aInEuS8ESWKeaiKPojUXluN66XE
         xToONHv/F7/VcPuKhuvHxJmKf7DeMy8FCTaK8BCcsd9BfgfpoqfVndVjpd9BLUl1/a7+
         8QQC9coFrLW2UZTlfesx1/NwA8GogeXliszuCf0iPhejnEZSF/UfstS/yBkkq1cmLSTM
         MEag==
X-Forwarded-Encrypted: i=1; AFNElJ8FKymBj1rliD5hSdp4FNbM73EepGg6/GUa5pZr78J4aEH19kU26P2C9tgmKoq7V4FC98qNCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3C2grJDv8F5vc79UFjTXULUhgklPNho+MraA3YJnhVZyMrmH
	Ilph1bxuVtq1/0sZlQ2LZNR1YwC3EgPfCA5IWLEq9KII56L+OBBXFvwbwOBnwzIqEonn/LYXoK2
	VSDuwvMh+2PBDPA==
X-Received: from ywkk9-n1.prod.google.com ([2002:a05:690c:a0a9:10b0:7bd:4802:f23f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:d94:b0:7ba:ee75:f115 with SMTP id 00721157ae682-7c6a965298cmr72477267b3.4.1778752508345;
 Thu, 14 May 2026 02:55:08 -0700 (PDT)
Date: Thu, 14 May 2026 09:55:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514095506.3919094-1-edumazet@google.com>
Subject: [PATCH net-next] net: always declare __sock_wfree() and tcp_wfree()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E50BA540068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287894-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Even if guarded by IS_ENABLED(CONFIG_INET) compilers need to know
what __sock_wfree() and tcp_wfree() are:

   include/net/sock.h:1861:63: note: each undeclared identifier is reported only once for each function it appears in
   include/net/sock.h:1862:63: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
    1862 |                (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);

Fixes: f0de88303d5e ("net: make is_skb_wmem() available to modules")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605141607.mDXnYFKY-lkp@intel.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 219917959b54582fdd3d78e8042e1bdfc43decd0..e0263bae8da9870d517e758265047faf96b940d0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1851,10 +1851,9 @@ static inline struct sock *sk_clone_lock(const struct sock *sk, const gfp_t prio
 struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int force,
 			     gfp_t priority);
 void sock_wfree(struct sk_buff *skb);
-#ifdef CONFIG_INET
 void __sock_wfree(struct sk_buff *skb);
 void tcp_wfree(struct sk_buff *skb);
-#endif
+
 static inline bool is_skb_wmem(const struct sk_buff *skb)
 {
 	return skb->destructor == sock_wfree ||
-- 
2.54.0.563.g4f69b47b94-goog


