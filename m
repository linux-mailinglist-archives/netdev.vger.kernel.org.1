Return-Path: <netdev+bounces-301911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BfU8BcnzPGqsuwgAu9opvQ
	(envelope-from <netdev+bounces-301911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E286C4307
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:24:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rPyjGQXp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301911-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301911-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7871630120CD
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30637F731;
	Thu, 25 Jun 2026 09:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DED364059
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:24:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379461; cv=none; b=h65WR0Ye1iiCUWLC/q0eOT5BHbD5xXDOQyYRyth0aWU9/a5U0tUlAAWXlit8Pk9AKoOH9clJ3d4sIOaBy02NkVTkc1kuvp3DZfAmhbM7CjEuJCfVX5H77ZjreHFeA8H2vCZZCVU/rZ4xls5ZOen2+qEiHRaV5xTbvI6Ts6k0vwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379461; c=relaxed/simple;
	bh=baFe4p8QWVuHjJbVSxdh3lQWVI1+Ps9ESitgQ/rn6dM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QUSy7XG1sxzXPYtIb/tjuaxrBAwWxPWmqRvuVvYjtvACHnpZIxJDkSwfBea5p6YtpmGAX6XLJ+D6gosrdxklsMr2tg9M1HVj4vlRRphSoURwCht2DUuO5Hfa3m0pOZt9nxhkJyWozDse9mDmicaxSTsxZxk0bEXkCkwZ/bSm1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPyjGQXp; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-808a9e51918so26709177b3.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782379459; x=1782984259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/3dIVLARhiNzIbIouaNHJYwFz6ietaxhQlPXg0w2/w=;
        b=rPyjGQXpGkOwK4Y9xX8iLInDiZdHnWguIZS0hJc/B4/W1FWumUwTYPOu7Fi+WPFVve
         xOutHE1+mNb324DU7oF53eCs89azge9kD4Gyb5yu3IQ2J3oXQBhjAy3vcUhkzngx9LpU
         qTjtvK67XtMeEAT99IgGtm1qCSVRK7fxno6B6Fep0nE21z/++l06B54dOoMd3EmdSWl2
         YXNuQ1ozmf/oqcGnOkvqXa/L3WrqfII8msBN0TqLzB276/dFGXEw1qn2KIWRWt6ix4oB
         fpRC3DUYFTtB6LQKDfoxw8UdeB6upJd95ba2Jfp4Fn6rkoR9na73Ie8ogp5Xlb3rhKH0
         KWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379459; x=1782984259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/3dIVLARhiNzIbIouaNHJYwFz6ietaxhQlPXg0w2/w=;
        b=Z1xrd++jJ8rRpjXZfbMNAZDdeojqMhcDTPszJd0mmtvilGhA/kxaMP2DwR8FKyBKqn
         xr5FvC/yn/qwqotmp3n0vWd7rVojXrOO9sx/92MW3dRwBst6xIKdo/zwIgJu+dSCQLNH
         ZXJnRrg6cGf+2q1H+Rw3p1R16JO5+B/Inyi62KHVN4x7kAPVqTv/DxeqZbe6STNczsfY
         nfnJbGxj5g2rGC2Ek3qgZtAHNYAVo2LpjcJqoi+7E1ZX/hEPoK1Q2wQCYDtbBB2Gh7aM
         n95UnVqH3aaKfDOOqL9Drvt9ctCUI9KeRjDq0bQfJ/6fjvOKweCWYJpzAd00HMD90QrM
         KX1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrej2jjsSuoBOOsk7sKIwRSP/wOh2MRCCcEAmysIfAQ4QzJmzTlM5DSrgw7TBED8ieyF+eJA/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVUYIp43dDwwLA5/nDMeHN/pMY2E74zo+b1/+tdC9sZDTpUza
	MnVIT/0Qjez48pk7HKNN416jA9CfntD81bzKFSJbAM9swFfZCsCvg7Gt56tLiwPi2+xVetH9u91
	83qDK9apUu22ELw==
X-Received: from yxbr10-n2.prod.google.com ([2002:a05:690e:440a:20b0:664:79e8:1ade])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:ac95:0:b0:663:1faf:1dc with SMTP id 956f58d0204a3-664883ae351mr1150711d50.45.1782379458909;
 Thu, 25 Jun 2026 02:24:18 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:24:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625092417.890245-1-edumazet@google.com>
Subject: [PATCH net] xfrm: fix stack-out-of-bounds in xfrm_tmpl_resolve_one
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301911-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,secunet.com,gondor.apana.org.au];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,0ac4d84afe1066a1f3e9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,spinics.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71E286C4307

syzbot reported a stack-out-of-bounds read in xfrm_state_find()
which flows from xfrm_tmpl_resolve_one().

The issue occurs when a policy has a mix of family-changing templates
(e.g. BEET or IPTFS) and transport templates. If an optional
family-changing template is skipped because no state is found, the
current family of the flow (`family`) is not updated. The subsequent
transport template is then evaluated using the unchanged family (e.g.
AF_INET), but it uses the template's `encap_family` (e.g. AF_INET6)
to perform the state lookup.

This causes `xfrm_state_find()` to interpret the IPv4 flow addresses
(allocated on the stack as `struct flowi4` in `raw_sendmsg` or
`udp_sendmsg`) as IPv6 addresses (`xfrm_address_t`), leading to a
16-byte read from the 4-byte stack variables, triggering KASAN.

Fix this by tracking the active family of the flow (`cur_family`)
during template resolution:
1. Initialize `cur_family` to the flow's original family.
2. For transport templates, verify that `tmpl->encap_family` matches
   `cur_family`. If they mismatch, abort with -EINVAL.
3. When a template that can change the family (tunnel, beet, iptfs) is
   successfully resolved, update `cur_family` to `tmpl->encap_family`.
4. If a template is skipped (optional), `cur_family` remains unchanged.

This prevents mismatched transport lookups and makes the resolution
robust against any family-transition gaps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com
Closes: https://www.spinics.net/lists/netdev/msg1200923.html
Assisted-by: Jetski:gemini-3.1-pro-preview
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7ef861a0e8231b63ece816b5237b03fa1367ccf9..95e30670303d34598ba164dff59a65c14489d5f3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2485,6 +2485,7 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 	int i, error;
 	xfrm_address_t *daddr = xfrm_flowi_daddr(fl, family);
 	xfrm_address_t *saddr = xfrm_flowi_saddr(fl, family);
+	unsigned short cur_family = family;
 	xfrm_address_t tmp;
 
 	for (nx = 0, i = 0; i < policy->xfrm_nr; i++) {
@@ -2511,6 +2512,11 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 					goto fail;
 				local = &tmp;
 			}
+		} else {
+			if (tmpl->encap_family != cur_family) {
+				error = -EINVAL;
+				goto fail;
+			}
 		}
 
 		x = xfrm_state_find(remote, local, fl, tmpl, policy, &error,
@@ -2526,6 +2532,11 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 			xfrm[nx++] = x;
 			daddr = remote;
 			saddr = local;
+			if (tmpl->mode == XFRM_MODE_TUNNEL ||
+			    tmpl->mode == XFRM_MODE_IPTFS ||
+			    tmpl->mode == XFRM_MODE_BEET) {
+				cur_family = tmpl->encap_family;
+			}
 			continue;
 		}
 		if (x) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


