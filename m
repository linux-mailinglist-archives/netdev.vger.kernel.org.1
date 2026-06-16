Return-Path: <netdev+bounces-299941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jILsMaCfMWotogUAu9opvQ
	(envelope-from <netdev+bounces-299941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA36A694D3F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bE3JPLzf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299941-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299941-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20BD4301E1B3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1C3DD513;
	Tue, 16 Jun 2026 19:00:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CE3DE428
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:00:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636456; cv=none; b=gN8Hj1OsaSPkns5QimMmLtcLsoftKEce4vRMDuCKExWTG7YNf//mOVs/j03TIKMI77101+kDW2FARzNpAQn5iucvvYSlAaIdZA4zOL9rXpdIAp/XdQw8Mia+b3YZlz9W2y0m+xr3eo3YsYrmVoRKVECgQRzZta/nU+F6tBYZXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636456; c=relaxed/simple;
	bh=9Tyx3IZ683JCdQMRbGJeTjnP9qW7Us8tqu9ScIW2eJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZulkPsnN3oHnEy1DdoEnSbMqdixKyd2QcNabVg6KkQ3LYMfzSC4/fx5EPHE18T66Ko2S09VwyBoyIUI9vF7HFT5sxav+5k4NltqFCm6ZawLy5FCl7Uxcr9WR5Z9VjgC3UwZEGlnrl6OCcYnka1gnhYI2oruTAelBRd2Fq0pqabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE3JPLzf; arc=none smtp.client-ip=209.85.167.46
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa63628d26so4856146e87.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781636453; x=1782241253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAylVLBoI1FWIRaqnARn0iCZWEh0HddelhXPEdFepIU=;
        b=bE3JPLzf2Ayr90aodKGCy3QXSoUKQacdo32bqaaB1GxC8d2+KrbeH4ujPMw3Bl+Ln+
         gwa8VvdpxKapffdh+G67FlMyVuI+I4LJO5A3Ccp8Egzw4O2fPhGc/BBWkC7ZhYQEDeTk
         sEzsTIJG7g/PLmIPt3tCUemUUa3VLAP3/7e9XztNdxOLb/V04V/OAVWbt6Cydr8jKasl
         A+3XsPRDsMxCfIRZQs5KueO/ftN/k6TvI6RamGeZ5cMrJHP20TIbEAS/oxVRHUi7sdMF
         lcdnCQ/+gPvXMBIOXVo3B3uGTWZaoapq+rFjBPnS+a4WThbrFNL7v0O2cnvObe91sd9N
         trsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781636453; x=1782241253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAylVLBoI1FWIRaqnARn0iCZWEh0HddelhXPEdFepIU=;
        b=sML1tihdLznpbnYY2hUJ1RNKJ+A+JH7slGc0aVOc/SzyjqZKvdXvBVDBK7vRn7C0/L
         VEDfYCBax4Dy6mG0yOJQ6i6yisYXiL7NzyDlUY7XlyiBftq+qbNwA/0cjzBLfqrzyjRw
         TL3xtrwRKc5KNeqma6y7g4rW/EZkTOpRbKuglHMHGQP3OdYTszw4Jh6P5q+YipA3R2cC
         TdjeVHu9Q+v3JT6vP3YQQg1moETWqZx/1FI09UF4oE+AbI1PT7b1Shv79tLRzEcm7XZX
         M2U055Qw78nlr3j0KdrnXOB2AT70HsvelRLTrgTCM2AoUlGCY0dwiJ5Rt9vKnamjh6MJ
         n+4A==
X-Forwarded-Encrypted: i=1; AFNElJ9f8r9z2pP+kJXFQWaRO2Olnoc5B7TBvnGWcz+8etx6zcSnDDZrfJfg+k20Cuo7BSTjs/kT/VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkUzMdIaKKMM2lUJDrrmlfzAMvi9K4CYfzO2vKMsMo0C9j1Lb
	/x6CVagSj1nRQMw/K6D36MXMHrl0MXSbS20Y8mTQKqgIZB+j354ig/UX
X-Gm-Gg: Acq92OEIT82QIuA0wOrfloBdnfUZZxu66Hily6IwL94OcpvhxehwH+XVOOnbREdn8HR
	RdRRJdUobKV69oZXLoM8QfOWFU3OHo3t3ubhIWV7WjZfiFCtjvoBFGzQ5M/nFt99lREySGwekaV
	46z3xD653h09aoIjTz4ZZBhEC40pcsPAIKRvqXr5VeaSw9u2B5dSdlhs/1OHILJ1xlICmpUQZvW
	X74FBwBShW+N5lU/zjV5hi2A2I7fddX4q47+9jtexOflWyPiRuADqSn4kh0UqPtpxeiC/E1XkEA
	oyD7H1/4fw6elASHWofI8YQwyQA4ye3hqXfAoWR7uonsk7rwbtxuK3kMMsb1hdIllCkcX6EB9LB
	pttWPqQDVIXY+09dNYUi+8/y2nIr0PNnRh3nd5zXb79ND6k9+ml4hGNrNmBVkC8HLAC8RGL0MSV
	operYDoMXijYhqkPCG+a6wAUopFNU7j16IEUnIsrE=
X-Received: by 2002:a05:6512:baa:b0:5aa:74f8:72f4 with SMTP id 2adb3069b0e04-5ad46fe041bmr185686e87.32.1781636452394;
        Tue, 16 Jun 2026 12:00:52 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e124462sm3738075e87.0.2026.06.16.12.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:00:51 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH 6.1] net: gro: don't merge zcopy skbs
Date: Tue, 16 Jun 2026 22:00:36 +0000
Message-ID: <20260616220038.87364-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	DATE_IN_FUTURE(4.00)[2];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,m:sd@queasysnail.net,m:imv4bel@gmail.com,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:huzaifas@redhat.com,m:willemb@google.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,queasysnail.net,vger.kernel.org,linuxtesting.org];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,queasysnail.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA36A694D3F

From: Sabrina Dubroca <sd@queasysnail.net>

commit 4db79a322db8c97f7b73b8a347395ef4d685eb40 upstream.

skb_gro_receive() can currently copy frags between the source and GRO
skb, without checking the zerocopy status, and in particular the
SKBFL_MANAGED_FRAG_REFS flag.

When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
on the pages in shinfo->frags. Appending those frags to another skb's
frags without fixing up the page refcount can lead to UAF.

When either the last skb in the GRO chain (the one we would append
frags to) or the source skb is zerocopy, don't merge the skbs.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-46323
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index ea6571c01faa..c5a9733d929a 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -171,6 +171,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
+	if (skb_zcopy(p) || skb_zcopy(skb))
+		return -ETOOMANYREFS;
+
 	/* pairs with WRITE_ONCE() in netif_set_gro_max_size() */
 	gro_max_size = READ_ONCE(p->dev->gro_max_size);
 
-- 
2.30.2


