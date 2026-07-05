Return-Path: <netdev+bounces-304740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzzHGtalSWo65gAAu9opvQ
	(envelope-from <netdev+bounces-304740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 02:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6162708B58
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 02:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b="Ym/Z9T8X";
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304740-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C2A2301859E
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E31CAA78;
	Sun,  5 Jul 2026 00:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9216169AD2
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 00:31:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783211470; cv=none; b=Fj0u/zB9iVF2RRVgWXAjghmzD83yIWBC59O2VWP2+PQe8uDwqztmFwCewS2QpnidsSPCvlIa/YD65tc5UQNHBF+d88nxVfoiVt8E++/ND2Qy9SjcRGyoAlEnWnSLfjELXAswyT12OU/01rgYgmc+GSxuf6QN0dyMeybxxaMgVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783211470; c=relaxed/simple;
	bh=XRrOAqGo1SaWPhRhkBK20y6xrteJRGYUgMAh4pyUKQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMZKDBwH3M5HgqEVlqIvkeXO0SBZKmVhUYq5qxCSKFYkX66PC2AOHTMDGC+jHnLUbwvRECTn7DrkdRRTeDJa5Qn7PrMHmGVlzrEJFSXbNyRpZAsAFkDZiXcpiFMgvb77V6MtcH6Ww0p3QKZHy7xBQIylsPXMp7tZpwl17QN5u5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Ym/Z9T8X; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso18000915ad.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783211468; x=1783816268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzR86rL+Wq9WPxMLO6rL2wU+CKuwRy8NRTc65AlFuAc=;
        b=Ym/Z9T8XJpUzuUdgCivJOLT8tICgp/hA+Zvq2Br86qXrvX49dZrGmrSbGM3CONerZk
         R5mk/GDYFNYYAEv3XHINKQJXHm9QKrAOxhAhZ2hRcMLJEs4J3jmJwVA7jHms9KzukYOs
         bh3p1y9p31sNumFpIhCykx56uDKGMhkFjo8D2gS43vsx79BWYnB3jrdn8dKCgSKW0d2A
         67THDxQk2AM192CRpyWlM0TCqWbP6n0sH3RQWnL17b6eO7Oa3BFvXBG3QZ2bJLMXCZpB
         /XAJ2yW2RA6o5ESFXzPAGju7VGir2+aGmG94hUXiNV6teLpH4fDwC9tEPQ9YyhINCGwU
         0ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783211468; x=1783816268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzR86rL+Wq9WPxMLO6rL2wU+CKuwRy8NRTc65AlFuAc=;
        b=MRRmVW3OStSAsh8WvSKEzuZmizA9MsNsjIgle0U9T5AWVfeI9XNIihf9OGhXk5BaC1
         hiNUTazK0nVVqH/VxAxL6cifkEu4rwB42H8pJcIKs2CNXw0kMTjpqWJQdpM7xFg3TQo0
         8C6wzCRdUlTQmrLt2CjUfFo798faF15oxM/Rrjo5zwVZH2q4R8XdGc8uLld5jaoYNN8K
         TMjlASQ3dDd9Apm0r8R+CllXUHtTkSrCaPx+iCkFoghyQvXyw7PB5CtgBRjy1Hk610N1
         yixxrBsLwMhBlv4G7jNyEQZF0LMj6sn5YSF5H4J42l3cjZj3Rn4IRPdvlsrQEpy9gyGI
         zsWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZSHW4O0gQj57trUC1lqydwuxicxx+UiCCowEDT0baVQ65IsQopIEjkAT85XnPmFCtrfKFuuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYWXqCZx9044f6qSi4xgHN+tnYAEbJrGpR5z/gs25XfpISzQ3i
	Mf5edaac1naafHDNUvURJ9WRDTug7hG3mn8LJrU+Qxw0iUqMBHi6e7NojY/q1qilxA==
X-Gm-Gg: AfdE7clEb1u9xIorbmfuT+C+VjaPq4fDOfeywqu4t2qd1uPP/7lNfe0eIWbd8507GZu
	MGP7s1W1FmNitCE5B7i2vHebB43Q8IZ+mTvRHXd3BwoBXdUUgynIOkmHJ2gE1qS4nbhIZRxiTwF
	LuUj/BmOeHsp8jXq0kZdwmho3imzZT4CSoTNjJ7VKFPqoyuIeQ2rXEQdYcf42EPFagy/PM8L0Qj
	xe/GxokiYKdyR8sqo8I3aFZPrtwemsZMPlLV72ReWB3FK4566KDc5uwUpLVJGVkvkC1ErhVJE1e
	93zBIXi6qsQl6VUNkjMrZyD/PV2D0+3U/seZSDjjjCn+nt6UvOgh9sL5l96SbBohuGaICUSUkaP
	ahM4LNhjAZw6OMBVpZHNP8UIECty/ZZBneBGZy9NzRTFyCK7CDISPt1ikcUdcCkYxVsHlQtEzBQ
	==
X-Received: by 2002:a17:903:284:b0:2bf:13af:b077 with SMTP id d9443c01a7336-2cc09dd66a9mr35384805ad.14.1783211467991;
        Sat, 04 Jul 2026 17:31:07 -0700 (PDT)
Received: from p1.. ([2607:fb91:152f:d935:c8f0:3f07:a1a1:8c92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad712b12fsm27782795ad.25.2026.07.04.17.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 17:31:07 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] sctp: validate the body of a STALE_COOKIE error before reading it
Date: Sat,  4 Jul 2026 17:30:13 -0700
Message-ID: <20260705003013.1134430-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304740-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6162708B58

sctp_sf_do_5_2_6_stale() reads the 32-bit Measure of Staleness that
follows the error header:

	stale = ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));

without checking that the STALE_COOKIE cause actually carries that
4-byte body. sctp_walk_errors() in the caller only requires
err->length >= sizeof(struct sctp_errhdr), so a peer can send an 8-byte
ERROR chunk whose sole STALE_COOKIE cause has length == 4 and no body.
It passes sctp_chunk_length_valid() (>= 8) and the error walk, yet the
staleness read reaches past the validated cause.

When that is the only chunk in the packet the cause ends exactly at
skb_tail (sctp_inq_pop() discards only when chunk_end > skb_tail), so
the read stays in-bounds of the skb head slab object but past the packet
data. The value is folded into the COOKIE_PRESERVATIVE parameter of the
retransmitted INIT and reflected to the peer, leaking adjacent kernel
slab bytes.

Discard the chunk when the staleness field falls outside the validated
chunk data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/sctp/sm_statefuns.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index d23d935e128e..e4b4b63162cf 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2592,6 +2592,9 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 
 	err = (struct sctp_errhdr *)(chunk->skb->data);
 
+	if ((u8 *)err + sizeof(*err) + sizeof(__be32) > chunk->chunk_end)
+		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+
 	/* When calculating the time extension, an implementation
 	 * SHOULD use the RTT information measured based on the
 	 * previous COOKIE ECHO / ERROR exchange, and should add no
-- 
2.43.0


