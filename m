Return-Path: <netdev+bounces-251562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCyKH9nab2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C824AA86
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6271774CF7F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27734CFC0;
	Tue, 20 Jan 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ5P+UEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102734C9AF
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927752; cv=none; b=fFIQ1ZHIaE3Ei2A5obyLzj9w4FnEbj4CjXcs3z26QNfMh1y/SirjGsaJHKfCYh/9n2SgV2phoy4C9dgi/Qp48EVFxCtPONl+2Q943blD2uxj231VFTbHDfD26GgfhBri4CRBb0b2o5WClwV/cDuyWSrBk1f0Zu4iFG4aSRwfS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927752; c=relaxed/simple;
	bh=qEG8W+iXPCChN+rsqU7ShDmWYPWBLq9atvzzf+9ff/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GXqxSqVE+cxf5f92UJ1H/GOnb3q00yOX4foVw+i5IeWg0Tu06fwEWephf88wwYA2alPVuXaTuN5+vkP7BXxJJkabrWFtyVjkZ/0RmBJWDnVyB+fVRalK4rpJijPRWVJ9PNRXB6EG0yN3ZOzy0pIRyJKlY9zJUVuu8M+xA2IUYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ5P+UEM; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5014b22d678so74281511cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768927748; x=1769532548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsOFJn4EZiKQ337yr9Dz5asIEvy6XfYTAcnE7gOIqmc=;
        b=GJ5P+UEM9ALZ/SH8B5YF91HNxT8CPwWC+EA1z357JN34GpUgxKVcv6vWotphwo3UMU
         nvizmVEUQ3tYFLtZ2ZhbP+EWx4YwBEj1T9Y+0AqtlNdZhogQyDBlixufgV2PwtzTsDZh
         pIIjn/8zbrFaUep1FsryagDY6o53/aaX7hRgVugHyk4J0Nhy8SBN+K08/kDwQCJ+FDhr
         GaSMQ2ffKR5xR7FmDEsIvo5u2Y6zwo2c7EVxTKkmvS4xTi+gXIY519UrQ1Iwhs15mR2G
         0yuln9iroUXlK5vAZXN7Fj3X1WkWozcQKNhtOVgwdyxHNmRPZ0U+CLFSD8kumLoYj9VA
         3Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927748; x=1769532548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsOFJn4EZiKQ337yr9Dz5asIEvy6XfYTAcnE7gOIqmc=;
        b=m7VI654lxAocQDXNxWenzVaG/Ui4uOhBTNPSSmykaEIxhnacAU7ndi+LM2xtDHpaly
         8iv/Rq2UC+gwvEZIQbaBOBUhtd48TpzySmFvlOthmBNalmq8RAd4pCS9TwFO+MoWpHWc
         gYyj+S0395/P1q67mK0IUeqtXvE/069L468DuzAYbdw2bFMEWhhyIsX7KwZGfAL0dL9r
         mqw4p6Z4i6t9FforMa1DWL1W4IeQNn5BhndXEiCQjXJi91aEjpmpIRefG5yjBTfgukId
         QsgnabopxnKv7N986m2FCaaLJYJMDk4C94RP7zNovrcZ0DnolROcMieI3g5jwGVJltsi
         fFLw==
X-Forwarded-Encrypted: i=1; AJvYcCXrlGOWv6FR1MrYdSXhCEcoY2uqdMIH5E+aYREd9qHfEja0fxe+Ss7KppSu6uQBbuXHguWER/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryiUKrLX/jIozaqlVrJG9aPpdvfsmPEAF4ocIeAb7vB8QrScw
	6+v0MueVIYSnB5GosKS+diiOYD7hoiaAGYimXbMVTVad6DfS6imFD928UQsKrDXI3UwLJuUDCqz
	3Qa34urg5387MnA==
X-Received: from qvbre3.prod.google.com ([2002:a05:6214:5e03:b0:88a:2fb9:2b69])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7dcc:0:b0:501:4a86:f5f1 with SMTP id d75a77b69052e-502d85351b7mr28744701cf.71.1768927747661;
 Tue, 20 Jan 2026 08:49:07 -0800 (PST)
Date: Tue, 20 Jan 2026 16:49:01 +0000
In-Reply-To: <20260120164903.1912995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120164903.1912995-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120164903.1912995-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/3] net: always inline __skb_incr_checksum_unnecessary()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251562-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E8C824AA86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

clang does not inline this helper in GRO fast path.

We can save space and cpu cycles.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/2 grow/shrink: 2/0 up/down: 156/-218 (-62)
Function                                     old     new   delta
tcp6_gro_complete                            227     311     +84
tcp4_gro_complete                            325     397     +72
__pfx___skb_incr_checksum_unnecessary         32       -     -32
__skb_incr_checksum_unnecessary              186       -    -186
Total: Before=22592724, After=22592662, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4a8452e90fe78adcdcfdefb79169..e6bfe5d0c5252b2e7540e1fef9317aab83feced2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4763,7 +4763,7 @@ static inline void __skb_decr_checksum_unnecessary(struct sk_buff *skb)
 	}
 }
 
-static inline void __skb_incr_checksum_unnecessary(struct sk_buff *skb)
+static __always_inline void __skb_incr_checksum_unnecessary(struct sk_buff *skb)
 {
 	if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
 		if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-- 
2.52.0.457.g6b5491de43-goog


