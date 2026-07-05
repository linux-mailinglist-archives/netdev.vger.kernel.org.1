Return-Path: <netdev+bounces-304823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xVbDFobqSmrCJgEAu9opvQ
	(envelope-from <netdev+bounces-304823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 01:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7470BBB1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 01:36:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b="IbOtp/yG";
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304823-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304823-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A82B3008767
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B036403A;
	Sun,  5 Jul 2026 23:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13C2E2DDD
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 23:36:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294595; cv=none; b=ECIHrCo0gz6ajMMFzcGtf2tkng1O1pHcdR9lyuxKJGA3sfEciuEozvMRI2iVTyoRjwgbl0TzDD8AK5VnDt9QwbP7sQJhKRgPko4tJuCO2AxpEiVeL7JMadyrNDNDoNgikEyLdrRS5xT+DLH49ODQVWGxQaqq8WKTwFHkUFFwwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294595; c=relaxed/simple;
	bh=oowJ0/pwMLpK+2FBTaTr7SQOcKOb4MiuA70vmsgUgiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwmdbQm2upqm5bBSQoSGBi03xmYW9W0KTIoLUqMSD1sm0DKIV0S6iOhvkKI4RcD2wGKxqXEswxJcZDHhryRB9M1JPUMQ0LHQnzyKiu/g4a/ywOieRAZg5VSrT0TtbYw7YzLgDlxP3vfLPe/qSpa9l1N5i3KM2rYwLg0Gjzq1u5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=IbOtp/yG; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caea3f742bso30250015ad.0
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783294594; x=1783899394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wagndnGVb7E87oGYXUV2CXr6Jt9C4YXqmzSMkRBdYcU=;
        b=IbOtp/yGL43TB71pl2LIxr7TJYxD6/IH7fr3+xoM2BcumWs2EunymlOXLZnhID5EXh
         LLoNpf1jaEnsawRfXTJJ+zNX8qqi6X2x32yhIjXJEpzSViPGdoG6SjRCkPT+qvKpGk+m
         7wcnT06sU67vKv5kptQW0woFGw9WrtQeu7YoupEJQBoViPPcJ9SRG/IrO4rs/TSYFV1A
         mwBCtYgyN00MJU5uQh1ysEoaQhqBj/t8BHlR1GQ1PjuU+bLKRgl2hfJMquDoKkxBVCen
         lrPT6AA4RJ59rmrO+tj2epvaPgN+xfLvUEhL5vBShLTUqA6qBTmC5Np7aDkZx5g7nODg
         nzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783294594; x=1783899394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wagndnGVb7E87oGYXUV2CXr6Jt9C4YXqmzSMkRBdYcU=;
        b=Ero/SG9mVLaJ/2OPcAfqeekvafEUOgIpZVQSrrhnN80rGYzrOENXmKoVHhS2bX+OXT
         h1QHHeV4leeRwDsGwiNqiI5K0yEN9Akgzy5tGQ0dn6OzcangIUF6YCY8DukM6DyEEuiB
         WlpV2KzfRW+OcaHtKy1AKxF7f78mEP3HQRYIUhxaUcqF+iVYDGfglYWLKC2bowa1ph4A
         yBdq0rUyFr9JHAef+nli6GIcwlNZJ6RWkFD7w8SA9yLynQLXvLR5EvD6+FmdfSVEFvSy
         dc0ycUpE0w0LhV628F/DNOvJdelAI016PWH4RwgFOxBRZUAAu/MsSyzEW0hT+8V7+3Ez
         Htjg==
X-Forwarded-Encrypted: i=1; AHgh+RpuHuEkj1lYLfE6dgnf+UYwpd5uQPsKedUjWoyWUHpTSh4H42FJuyi+YZ1aeO/2+xTGFYcX0C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXvzplE3vUjeMnjijqfpaiQj0ygm693pRBXnKc8WkziSOfjiV
	6kGf3VrBWpdSlCyjKgxSIsPHMHlVKqrlVtLLoL7SjgAAAWyewHT4Snw7vkCKt0e8NYG9u4DqWDI
	fZZ0rDQg1
X-Gm-Gg: AfdE7cnxHEDsbwHGEPyPwKSnPbJH8+Yf5JHokLA64sMjUPnFgPYSvZkXAgkt4XCs20d
	VqohZ+rLcwWZlBMTRrNy2GE5zDaFbP+QMwc45hnwUqT3VgGGULYaHIUbjuo5abykkUBI5+EaXx2
	N4PJs0YP5zXcKX5SOsxZkQ9gvjD5QaNbwHpc4FI6SwOmmD28BHmr6ue9oGUUIL0b6g14R0ldLLv
	GeI98S19irsITB6HEKKS2G0Aej1Bp9W1QMtzKKNvzF67TsZLK3bM3JDb6zxBd1vB/hdIRPwUYvN
	KfBDgsu4ee21wCy56r35KGjwXkpXL3b0OizPtwqf9l3+fK5PiOwOAXn6UlgABtbKSR+m1d7f3j5
	TkIqu+ijbXRzT0YhHJKkpXL5+CLMLwGhJXJIZQInK3M8OlD/2J+Tc0cunyX8F5rXn61lH7E3r2w
	==
X-Received: by 2002:a17:902:db05:b0:2c9:a247:171 with SMTP id d9443c01a7336-2cb97e47b64mr75072215ad.1.1783294593851;
        Sun, 05 Jul 2026 16:36:33 -0700 (PDT)
Received: from p1.. ([2607:fb91:1529:e46a:7f70:6a22:47e0:673d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7870f58sm38938695ad.59.2026.07.05.16.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 16:36:33 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag
Date: Sun,  5 Jul 2026 16:36:29 -0700
Message-ID: <20260705233629.2287813-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304823-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99C7470BBB1

nf_ct_frag6_reasm() slides the packet head forward to drop the IPv6
fragment header and then unconditionally advances skb->mac_header:

	skb->mac_header += sizeof(struct frag_hdr);

On the NF_INET_LOCAL_OUT defrag path the skb has no link-layer header
yet, so skb->mac_header is still the "not set" sentinel (u16)~0U. Adding
sizeof(struct frag_hdr) wraps it to a small value (0xffff + 8 == 7),
after which skb_mac_header_was_set() wrongly reports a MAC header is
present and skb_mac_header() points into the headroom.

The reassembler has done this unconditional add since it was introduced;
it was harmless while mac_header was a bare pointer, but wrong once
mac_header became a u16 offset whose unset state is the ~0U sentinel
tested by skb_mac_header_was_set(). The sibling net/ipv6/reassembly.c
does the same relocation and does guard the adjustment; mirror the
guard here.

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 64ab23ff559b..3637b20d3fa4 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -348,7 +348,8 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	skb_network_header(skb)[fq->nhoffset] = skb_transport_header(skb)[0];
 	memmove(skb->head + sizeof(struct frag_hdr), skb->head,
 		(skb->data - skb->head) - sizeof(struct frag_hdr));
-	skb->mac_header += sizeof(struct frag_hdr);
+	if (skb_mac_header_was_set(skb))
+		skb->mac_header += sizeof(struct frag_hdr);
 	skb->network_header += sizeof(struct frag_hdr);
 
 	skb_reset_transport_header(skb);
-- 
2.43.0


