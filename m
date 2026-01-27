Return-Path: <netdev+bounces-253911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KR+NDTSeGmNtQEAu9opvQ
	(envelope-from <netdev+bounces-253911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:56:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292F961DE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDCFA30572F9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8E35C1BE;
	Tue, 27 Jan 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1IsLMA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595135CB88
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525079; cv=none; b=hcnru8K26bPfASDTas23XnRQBp3WfsbgTgZ8sELaY37vAgLEo7TCslXbtKba8qK2eoSPoeEh3Tmm+THSCgYAA1r25OVsGfmyHtXzsRDZYOZEaAihWrZKqYt/thDDqA0bq+y4QBf/4CfiE7d96Ciu8WmLX/DOl0G0XVVX0ykjtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525079; c=relaxed/simple;
	bh=QrayitH6kTp21s+oOsXvj4remUCsGhZRn2GTlbIaE1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyxPx2KyxjdEsopfm4GmKO6+5B+I0s3h/90Hhizy8QYNfwfl32suhsh75zcjDXeiFqQCIRSAmCdd/lOZksE8ZLBoIr9FvFpBsKocO54A7iRKChnuCVGaRW7DPY8R2WFoPcC/njtBeO+K5eSlt+EvLsMsnF1bCF1+dal7Uqa7MiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1IsLMA3; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-6493c3adfe4so6694005d50.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769525077; x=1770129877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxe5GooN7uNDFkvTmR8R6ZqonfXanzb286hd3BM11No=;
        b=h1IsLMA3dKUGdNrHBskr3vTPh8SVI9ujGaOTv9q6l98FDD7UTIlnJueKwtaxATDzQH
         xJLX7gkTTf3URsednNoNM73WpZXRis04tWZsyJu6D7QKoj9hhpjPk30p6ACTIGZNyIXN
         kYDt80HSFk0o8OU6WcN7iXK2o5jhuGF7BkthKO8Pi+Kb7FRWKRXRlMlcoZ2JVN5yvvzW
         Phub68ovh2q5jvuwiyILVs07OETbgWi3JsXwoDTgHE3OOrlLRNDemtwHtMZptIwe501b
         z0j2Al+FPYp7CpiKxrryByl/VEnPsAbP/AAwoGzbep9JHlx3wnWzRhvkWfZSxgJefU1T
         dy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525077; x=1770129877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxe5GooN7uNDFkvTmR8R6ZqonfXanzb286hd3BM11No=;
        b=SyIfn/j1Jh1rElPri6WAjCwD1o4aPoYvZTA8J03VouwcD4yAlDuooa6QDN/aO9Zf72
         bX9z3SowoyGpJ6ZGddOyWj8e5B8HNK0Aep5R67ZKPXS5tVrujXBGRapiy50KDmRhkGg5
         A5rEehS5/sl17ogRU3zvscD0u1Tpkp7yjQIll711ajkOocvXr/oPqbls7COX2KpkKPqJ
         ALH/Rv3Uzvgce5MuXF/k7ljm1P72GJXna/PAiAeNHpMvhd5FHT/QMmxRVc113Wg15Dqu
         HcaCQkJeiFJpT+VjqWsV+vZQqqOA9Qbp1OiOn40L1od8j42U+Rd0ObnA4cZ1fCwJ1tZ3
         nojQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYL5/AMsUak2UTNS4TqyK9S1U6paYbmrsVw54wReDTSNWTt/+fQp3e5hjWpclqBlQ9YqoX5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZfay6aSjOcF6C++A5O8D0lBI4Vbk2LB9aYghdGmKoEjbNwKs
	GUPV7mK4u7ipNgdBC3KBaabnEIh0FGN9iI3Juwin7eH2mg+va2E1wIeUfz6J8NsmvRUuzmn8jK9
	0mzFiFSoaEkCHLw==
X-Received: from ywtt2.prod.google.com ([2002:a05:690c:a582:b0:794:5d4e:753f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1896:b0:649:6053:15e9 with SMTP id 956f58d0204a3-6498fc485camr1312704d50.44.1769525076845;
 Tue, 27 Jan 2026 06:44:36 -0800 (PST)
Date: Tue, 27 Jan 2026 14:44:32 +0000
In-Reply-To: <20260127144433.196836-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127144433.196836-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127144433.196836-2-edumazet@google.com>
Subject: [PATCH net 1/2] net: add skb_header_pointer_careful() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	GangMin Kim <km.kim1503@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,gmail.com,resnulli.us,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253911-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7292F961DE
X-Rspamd-Action: no action

This variant of skb_header_pointer() should be used in contexts
where @offset argument is user-controlled and could be negative.

Negative offsets are supported, as long as the zone starts
between skb->head and skb->data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4a8452e90fe78adcdcfdefb79169..72679aa7af587cad524feba82432154cfb8afbd3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4301,6 +4301,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 				    skb_headlen(skb), buffer);
 }
 
+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+			   int len, void *buffer)
+{
+	if (unlikely(offset < 0 && -offset > skb_headlen(skb)))
+		return NULL;
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {
-- 
2.53.0.rc1.217.geba53bf80e-goog


