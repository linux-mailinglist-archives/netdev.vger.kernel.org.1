Return-Path: <netdev+bounces-288351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jv6KpVCB2oCvAIAu9opvQ
	(envelope-from <netdev+bounces-288351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA15552862
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB11730CA5CC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F23E7BCF;
	Fri, 15 May 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqVo+vXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F513E00BC
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859947; cv=none; b=UxDesiwjfklu3GDMP6Y3Oi/PeWTG4dHZWvtkpFpM4oDOsHijO1ahOi02tU8xYKcH/188AJhwUgbvViVej3ZHCRqUC6xa0SmISKLGGTumnToVRR/nQyk96jzw8lo3BeVXNWuIq8ZGmXFkc4Hc6pFnNwwhOEu/mdnjLVkVLBfeqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859947; c=relaxed/simple;
	bh=iThSfm4s67Ja6SUjf+5sNa7Pxnv8T1K1Ykg9BGBvQ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0h6Ev3cp1UNLirreVGQ+XtjF2fRoVtf3mO7Fu1K3pQClKeO2yIZyM9iUGu3f63d1DogSd8plGACbP9BOaa1Knd1f5VR/U5ZRJibvx8K9DOl+nEQ2kjQORqvFRvcxXzYJqFVlwrrCKxUOfwlfd0xY4gQ6CUl2qRNCSrIxmI9Rb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqVo+vXW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8bb09239328so76644646d6.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859945; x=1779464745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CeihbjahaamDWkZJ8szFGyTV5a8HEDtn6uzHSf+RP9Q=;
        b=mqVo+vXWbavbHFjdeiKM0lAEC1XftkCw354ai4jusQ9IScKj5sxpber3ra4/FZv7wL
         RuDd50nBRG6uDQrZJZkwuQVy0xcsLREUtyWWIOFJ9mNfwMB4hRUz0Vk1dW0gwCDgHgLu
         C3Mj0o6Y/PvgHgwfdLMNFVk6EP5qb7JD565Hzcz5va8lMIqNy8I2QqGa7aUwOJPaEQ95
         ma3UWDMaVK+Fa0/A8cNG2uEh1YbswUfjF5DzmwWpx7d4XODx8KZ6S2DLmS/zzYFtMcnM
         GsmYpQn/szMmHdSFBIhmcccTuPS5QL59aGUJvLIjOAYRdS1ZOnzV+I1IOBfXgJX9npYT
         Pwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859945; x=1779464745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeihbjahaamDWkZJ8szFGyTV5a8HEDtn6uzHSf+RP9Q=;
        b=d/bEbcaRZb91HSRQdKEVw5Y1XcY7c5+BxftTfemBNdXttgfIa2MVbM5AK/ZV6EkPhi
         inEz5PE1IEcLblL3jUMeKFd8FSuDCCvjczxnbuS+8JTMFbfQhiL1pFN/cXIsW6PZJIKC
         JzvfrI+NYBmlZCbMvPr946g9/lv2HMfDthnKo3p/EeSZX3QHNEQz3I9w/JDUrE4ssiHp
         u5OvJ4qptPlWT5NVIEZlcIN75t/wbiW2W7ktos6Q3Jmms3xBYARiujp72sLmj8ppOKGi
         2SWUJsmvPus1Qyt2yMmiJtZmh7nn05uhAlqYegHyQdQawsyLRQHIBisx3jwhT27rnR3M
         DZKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CDHu8/3CjpcP6XHEFB+rs6+QQ1FeaptFZ2WMcDqng7GaOWhU+L5xX9XxGi5paCo9f0gFvBqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGV76UVty4EGMVbwYA1avuRI6Fmqy6DUwGq+plTSi0ekId+HW
	rc55ul/kv2QKI50WMEbLuhUikQRddm3qFrhxktZVeHn9p0KIemTJ/DZy
X-Gm-Gg: Acq92OEcNsHpHHJAYnuEkZZUZDI7YBKwCIQlplOusFD2/BccTCXxwbl8kk8PLMrS4wN
	Md1A+behQlR1GTgSg1gkyhkOOb4xhpNvSnryYuFbPzLQ8/QPNgCdxRSBOR9L1tQNUtIHqAI5y3u
	p/n516w+uiH/2ToXzQihzTYbaZh0FvHbDA0n3dvIVDwJurhtkZhGfTKl1fSOs6Qxaw95t+gneS0
	HnU2vIfPaMm8458bv+AnU0FIperB/1qdxaoknmlpE8P+ggfqAfsOYH1xakhoQ9JOWudnbW+k5f4
	hGE79tCOu1Ufa6lgLlz6pGuvHk3uQBiTHQZioKLNPE17i9Yv3XFk6K/VB6HhRQ0BeMrtqcjAjEr
	oiW3nvawA4VY3qi83LXjrMVE42NewT9pp9rWQuohywBaBbDj6QZiq+SqXrjIQMiJjD1oPqEYE5e
	D7rZ3wFM0rCK64EnlRO560H+Xquy283bKgkEVZMHDh7nysN5HxTYYzmjlKyV/li1H6CovD7ubqK
	hwJtKEwsYxImU3ZlfkS0naB3guEIMl+6oB3gWsHkGs=
X-Received: by 2002:a05:620a:2685:b0:8cf:ed8d:20a3 with SMTP id af79cd13be357-911cef0365amr728861885a.42.1778859944579;
        Fri, 15 May 2026 08:45:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc8408f1sm573577885a.24.2026.05.15.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:45:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] xfrm: ah: use skb_to_full_sk in async output callbacks
Date: Fri, 15 May 2026 11:45:31 -0400
Message-ID: <20260515154531.1386683-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4FA15552862
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-288351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When AH output is offloaded to an asynchronous crypto provider
(hardware accelerators such as AMD CCP, or a forced-async software
shim used for testing), the digest completion fires
ah_output_done() / ah6_output_done() on a workqueue.  The egress
skb at that point may have been originated by a TCP listener
sending a SYN-ACK, which sets skb->sk to a request_sock via
skb_set_owner_edemux(); it may also have been originated by an
inet_timewait_sock retransmit.  Neither is a full struct sock, and
passing the raw skb->sk to xfrm_output_resume() then forwards a
non-full socket through the rest of the xfrm output chain.

xfrm_output_resume() and its downstream consumers expect a full
sk where they dereference at all.  The natural egress path
through ah_output_done() does not crash today because the
consumers that read past sock_common are either gated by
sk_fullsock() or short-circuit on flags that are clear on a fresh
request_sock; an exhaustive walk of the 50 most plausible
consumers under sch_fq, dev_queue_xmit, netfilter, tc-egress and
cgroup-egress BPF found no current unguarded deref.  The bug is
still a real type confusion that future consumer changes could
turn into a memory-corruption primitive.

This is the same bug class fixed for ESP in commit 1620c88887b1
("xfrm: Fix the usage of skb->sk").  Apply the analogous fix to
AH: convert skb->sk to a full socket pointer (or NULL) via
skb_to_full_sk() before handing it to xfrm_output_resume().

The same async AH callbacks were touched recently for an
independent ESN-related ICV layout bug in commit ec54093e6a8f
("xfrm: ah: account for ESN high bits in async callbacks"); the
sk type-confusion addressed here is orthogonal.  This patch is
part of an ongoing audit of the AH callback paths; an ah_output
ihl-validation hardening series is also currently under review on
netdev.

Reproduced under UML + KASAN + lockdep with a forced-async
hmac(sha1) shim that registers at priority 9999 and wraps the
sync in-tree hmac-sha1-lib.  With the shim loaded, ah_output_done
runs on every SYN-ACK egress through a transport-mode AH SA and
skb->sk arrives as a request_sock (TCP_NEW_SYN_RECV); after this
patch, xfrm_output_resume() receives the listener (the result of
sk_to_full_sk()) and consumer derefs land on full-sock fields as
intended.

Fixes: 9ab1265d5231 ("xfrm: Use actual socket sk instead of skb socket for xfrm_output_resume")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv4/ah4.c | 2 +-
 net/ipv6/ah6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 5fb812443a08f..ab8fa851ab4d9 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -138,7 +138,7 @@ static void ah_output_done(void *data, int err)
 	}
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index cb26beea43982..62794355d4d79 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -332,7 +332,7 @@ static void ah6_output_done(void *data, int err)
 	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
-- 
2.53.0


